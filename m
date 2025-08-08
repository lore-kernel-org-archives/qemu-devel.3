Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE648C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLlp-000676-UM; Fri, 08 Aug 2025 08:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLlc-0005N7-IK; Fri, 08 Aug 2025 08:00:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLla-0006v3-EL; Fri, 08 Aug 2025 08:00:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5783E5FA021001;
 Fri, 8 Aug 2025 12:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iNilJX
 BtPs9z9TTFk9Euq89alqfJVpxUoKhMYaJOiC4=; b=DOzbsJEa1AoJPW0Npc2boB
 ryY6oDa0bwv2H269q7Idtx2C1QTOsavyz4s1hoaDV9Eoyks3+N1Wb5mgPyoWbnyb
 37IMFrnQ1aYH3DY2ZWDfZD+Jghu0FfWXpj3Oj9It/7nLrAw7jRbfvco4LrtmgwJ2
 QCguWtzARdwjgBO7MOCM8n4qos7cHeVx4YgUcgHD0/xUWr/pG/iRYPb+fqauKpq4
 1AARuel4GsulUVagVRZ2C+Drfb88VFwi7L2aV2B8/nlUwV5Xp3p+y3ut5+44d7BO
 aOt+CNVtjqpJ8Ja0nsltZ+gp7aP+L3LV4BzzLfwlOwweQWdJYzG3x27IEJ5IdRNw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fuer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 12:00:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578Bva3G020330;
 Fri, 8 Aug 2025 12:00:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fuek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 12:00:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578A4Z4D022628;
 Fri, 8 Aug 2025 12:00:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqngwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 12:00:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578C02bD52560160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 12:00:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20E1A20043;
 Fri,  8 Aug 2025 12:00:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0531620040;
 Fri,  8 Aug 2025 11:59:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.151])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 11:59:57 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v9 6/7] tests/powernv: Switch to buildroot images instead of
 op-build
Date: Fri,  8 Aug 2025 17:29:28 +0530
Message-ID: <20250808115929.1073910-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808115929.1073910-1-adityag@linux.ibm.com>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6895e6c7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=vTr9H3xdAAAA:8
 a=aow-egSQAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=y3lVoIMbX-Uf3sPy4QIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: 2jxQUIEDT4W7zqvrk2OOmVMiUJEN2c15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA5NiBTYWx0ZWRfX+IB1lZSYEg3o
 EBc7rxWzGguygoNlFRLI2AG0SjKVMX8qSxifTyvZbpkMAERvzcfNy7NhB7OXpaWMED6KfvMolfH
 YO1IJXR98Pt8u3L/Y50CvGzdybSCqoxSTWiP/Lcp6/7H0pjpFgFc91um0n/jdMVLrXVNxA/0ad9
 qJHYW+Dap5pEdFwz1uCLoGmElrlv6NF1CN17g/uQp880TUEBlyS8HGz3B7EG+d3/Awdo8KpSjgb
 pJefP0ckb3NDhibjiEBY1DKBzrf4yoFAM5QabDyiDaSI9J6ZV4ITBzvXGiC9Dr8hFnzzG0U9Xbq
 7yTPUWzAWjIWThCkLY/cxVZVSH9+8DsFGw3oqnTx/0ULPy+xk8ZNchak7ki9xRE62hMASS6e0iU
 bsAcN2DOYanLmGNHlF+x4U8+osf+hOgIPvtrlhUm3Ivr7uBDquXVcovK+ucNelWivmyNaGgO
X-Proofpoint-ORIG-GUID: bgObswBaze_i_FEB1iJASZ_HpXBes9bI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As op-build images haven't been updated from long time (and may not get
updated in future), use buildroot images provided by cedric [1].

Use existing nvme device being used in the test to mount the initrd.

Also replace the check for "zImage loaded message" to skiboot's message
when it starts the kernel: "Starting kernel at", since we are no longer
using zImage from op-build

This is required for newer processor tests such as Power11, as the
op-build kernel image is old and doesn't support Power11.

Power11 test has been added in a later patch.

[1]: https://github.com/legoater/qemu-ppc-boot/tree/main/buildroot/qemu_ppc64le_powernv8-2025.02

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/test_ppc64_powernv.py | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
index 685e2178ed78..2b4db1cf99b4 100755
--- a/tests/functional/test_ppc64_powernv.py
+++ b/tests/functional/test_ppc64_powernv.py
@@ -18,9 +18,14 @@ class powernvMachine(LinuxKernelTest):
     good_message = 'VFS: Cannot open root device'
 
     ASSET_KERNEL = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
-         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
-        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_powernv8-2025.02/vmlinux'),
+        '6fd29aff9ad4362511ea5d0acbb510667c7031928e97d64ec15bbc5daf4b8151')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
+         'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
+        'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
 
     def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
@@ -78,27 +83,24 @@ def test_linux_big_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
-
-    ASSET_EPAPR_KERNEL = Asset(
-        ('https://github.com/open-power/op-build/releases/download/v2.7/'
-         'zImage.epapr'),
-        '0ab237df661727e5392cee97460e8674057a883c5f74381a128fa772588d45cd')
-
     def do_test_ppc64_powernv(self, proc):
         self.require_accelerator("tcg")
-        kernel_path = self.ASSET_EPAPR_KERNEL.fetch()
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path,
-                         '-append', 'console=tty0 console=hvc0',
+                         '-drive',
+                         f'file={initrd_path},format=raw,if=none,id=drive0,readonly=on',
+                         '-append', 'root=/dev/nvme0n1 console=tty0 console=hvc0',
                          '-device', 'pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0',
-                         '-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234',
+                         '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234',
                          '-device', 'e1000e,bus=bridge1,addr=0x3',
                          '-device', 'nec-usb-xhci,bus=bridge1,addr=0x2')
         self.vm.launch()
 
         self.wait_for_console_pattern("CPU: " + proc + " generation processor")
-        self.wait_for_console_pattern("zImage starting: loaded")
-        self.wait_for_console_pattern("Run /init as init process")
+        self.wait_for_console_pattern("INIT: Starting kernel at ")
+        self.wait_for_console_pattern("Run /sbin/init as init process")
         # Device detection output driven by udev probing is sometimes cut off
         # from console output, suspect S14silence-console init script.
 
-- 
2.50.1


