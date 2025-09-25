Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B3DCAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ppx-0002d0-Aa; Thu, 25 Sep 2025 13:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1ppH-000267-Bi; Thu, 25 Sep 2025 13:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pp5-0006G8-QG; Thu, 25 Sep 2025 13:32:13 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PD3FCj008363;
 Thu, 25 Sep 2025 17:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Vun/1y
 WnGmNfbClsh0GJtGGRKxs9vXLAXrTDwd9VDSk=; b=eF5FIbmajvgTMyyOAncL4R
 6tEhPoLP8qwdCWqr/I98BP53SsQLFHi0UOZnGU+6OvfajTkwEYXz6xi7fH9QjVp9
 ISJ9j9gZ0Eueelgdf8TdEvvhauVUzIAt7dH7TUPCmUa/+R/NxEqB/NZB3kRP7oHH
 ziL0+sLTha/Ecp3k5BcGivJOmi9VnRxnEPW+wW8VoUkp4OQ+ADRHb+iddr5rQpjx
 bphjwVPbuUVUPjRL4PDadNmfBAVJYAEf6zt4C/XHmN4Wv8Ot2C+0x1+yJJJ7iV8y
 olb+KoKtN+Wzs1/AqKm6luv7eUJAqk5FbNkvCoc2DAc9r+mLqs93WPN0/0rye/0g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkpma8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PHVr8S025706;
 Thu, 25 Sep 2025 17:31:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkpma0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHMT8G030340;
 Thu, 25 Sep 2025 17:31:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1ey61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHVnqS61341952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:31:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CC6A2004B;
 Thu, 25 Sep 2025 17:31:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5252A20040;
 Thu, 25 Sep 2025 17:31:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.220.124])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:31:45 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v10 7/8] tests/powernv: Switch to buildroot images instead of
 op-build
Date: Thu, 25 Sep 2025 23:00:48 +0530
Message-ID: <20250925173049.891406-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d57c8a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=vTr9H3xdAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=d7QG3KQTCe1-xXpN3u8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX55nAaIvAIEGf
 BED+jGcaelhM/3GcZXp8yQxltMNyXCJTlu7LHFtuzKvkf82VR77Vuaq3FC7ezQzcYWWrWG0t4hD
 Pl7q7eSNtR0k/DuV8aJtwhQz9sToJjXxu/ix3urTI0ktnpb1C4qxi0xIAR6JGJ0Foq3oU6rEm+o
 xHLt/MtKtCkK5P+5Jqe8TV1O4ldgAZoK7FF8QlWHIFnfqWYdGhoGnXUYsf0hSFuaBb+1+6GoCtr
 tjYZ+KmVnseftMZTxO6Trj+CRlrQhUHmqSC6w0J5Q2ZvLw9oZ4qY9HWnv0GYo+yBTd7nqk+a1kS
 ukQMLIfJbPvN7NIEERtrXKjnMTVRXkjM36UO28rXjq6QDHLqowvvzR3lF5nQ+sNgyDjHeFrdLfs
 4qMs0bXX
X-Proofpoint-ORIG-GUID: rwBiNUHYRmKH8wB-nw2bwfO5B4CB4Ywp
X-Proofpoint-GUID: TYpk707BbKDpCk4Z9dd70kocVcsm4d2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 685e2178ed78..2b4db1cf99b4 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
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


