Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CEFC5B552
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 18:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOKly-0003DL-Ng; Sun, 08 Jun 2025 14:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uOKlr-00038g-NP; Sun, 08 Jun 2025 14:29:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uOKlq-0001HO-09; Sun, 08 Jun 2025 14:29:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5581v3hx004964;
 Sun, 8 Jun 2025 18:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qJudSy
 +BHrAwJF8cvL9HKfkAX5s0H0E9qkeTId8gPdk=; b=ZoeftgK2VBJ7vbBMYaTH6Q
 Sm6cgu+kp2lOwaJIm8w1hUo5Bl98tLLAu/WhxWscM+GjoTBhub0zMy9+kqJ5bBJJ
 IPeQ6+f4SPUqFLEZVCtAqB/FxUjGZchvHWxYYqA5dQfd/w9K2lndJNIY+lQbLw8g
 ZkGHb/sRFgDNgMraBWheuKqaeiiGraphkOGtM1XdPAiaiMOEXz1xNAAH3Z6xnLIr
 Nb+Jo49vxKsTuQ4n/1IK9sJkwZHyom0Y5Kt8jnKj2uPr5qswVqraY2GJqTaybJqu
 XR21gpF2SBh6+HOEG7IQUy4OFFbwM0OsdTXFoJB7EZUbJz9sRAD0R1attEIhaixQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4ktkph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:29:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 558ITGmV025207;
 Sun, 8 Jun 2025 18:29:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4ktkpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:29:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 558HW2rk022352;
 Sun, 8 Jun 2025 18:29:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yjtbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:29:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 558ITBqr41026046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 8 Jun 2025 18:29:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4B3D20049;
 Sun,  8 Jun 2025 18:29:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 665BF20040;
 Sun,  8 Jun 2025 18:29:09 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.39.24.199]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  8 Jun 2025 18:29:09 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v8 6/8] tests/powernv: Switch to buildroot images instead of
 op-build
Date: Sun,  8 Jun 2025 23:58:40 +0530
Message-ID: <20250608182842.2717225-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608182842.2717225-1-adityag@linux.ibm.com>
References: <20250608182842.2717225-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=6845d67d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=vTr9H3xdAAAA:8
 a=aow-egSQAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=y3lVoIMbX-Uf3sPy4QIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: 321Na5JrCptiFN4NX83Q84wp_iYYtjrH
X-Proofpoint-ORIG-GUID: waYypp11mfxNk8GT8W7SXfzakE-E3BpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDE0NyBTYWx0ZWRfX8Iu9t4tS8Cav
 6joeKI0g/g1yqaNg3Si86sPm+5mygtqcb/ubol/y0LyEFxUwcfxSxr2ztQqc6OI2vE3lSMg/hiW
 mL9URPp/mmNDKR1jdMGZZ1qJEycqMSQ0h4i2C8C1e44uK86Sz0fSDRjjEjl4EIh4dCO1VmsYs+B
 l0gDakqOBxIPHg1R2As6Fb6NDorxOK8IsIZ5x7vkg4cByAvyxa40UMTDrDzStMREE4xF98a7MQc
 IZa0Ud78STXJPFTGfTQlaPU8BoMeT8adSiL3z3n6a3d+3V2cnEjOwVzFOXuBeTYzbJqp3ZxqHB0
 4hqrnJ3RQWhl2v48P4mwmBGIaWBpkZZ2DfAgaUrFGIxbjImEdov1LApq6UK/58pgi6AYxlIlRBY
 03tzLQtBqVoSC4xmSfxb/jIi/sbi8FKOvSN+tMXO7TCMFsvZs/cs1q62rELHlBfCCWPWWu6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506080147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
2.49.0


