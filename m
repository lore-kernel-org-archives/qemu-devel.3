Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82257EB106D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzynh-0007EF-Mp; Tue, 10 Mar 2026 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynY-0006u6-8X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynW-0000HJ-BD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AF9Oi9641632
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wWQnkhfx9OiwjFjSD
 V5k/HgZxQnLtjck3Fdhnq45O1g=; b=YccFQAh860v8YRS+7RWgQNyM1vgEqQG/K
 fQKKhe74tYeL4MRmQVDtQ3st9mtc++NYEple8TyLmX5ni4aa26cdYA2fr7d8P8L3
 09NgzoVnuuVRse9grPW9HwWWaZT/GItxCVdFQMksBVoeKaEZsWSMgO1F5zdvw196
 tZINVycxVhuT5MV7B0Tf15REiaKJRbYioGQit7xaRlZjefdfgHN+111xFROds4xs
 gszyyoqCujNcxvJzlTizn0TFq5/N8kfoNUUHmRNbOtrEidzYcm0D+FF6AnJMiatD
 rqKrlE2ZsBWyZ68istiv+UiNfZWP7l9YLy+2NxOLh7E4gCITlF7QQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmbhe7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:15:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AF3VmH029359
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6up8aw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFEtMT56230264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:14:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1A9D2004D;
 Tue, 10 Mar 2026 15:14:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C48F2004B;
 Tue, 10 Mar 2026 15:14:54 +0000 (GMT)
Received: from Mac.com (unknown [9.39.23.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:14:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PULL 09/10] tests/functional: Add test for MPIPL in PowerNV
Date: Tue, 10 Mar 2026 20:44:29 +0530
Message-ID: <20260310151432.92531-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310151432.92531-1-harshpb@linux.ibm.com>
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I4tQCB-jK8pi7DmJ03kftFCVoqLG4O-k
X-Proofpoint-ORIG-GUID: I4tQCB-jK8pi7DmJ03kftFCVoqLG4O-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX6bRy6iXTjOYL
 lr45Y9eCVXDd/U4+z/YUf78gYOFSbgylyi0YXf3uGrGI3fg5ogHmV3QgWi4xI+PWQpKXqHOtr2H
 VmnDvH63VwVpixopxRJYH0/+lnALOEWNVai8l8LUfZ5gychVQMgV0+HtyFMNZ2DSKihCbm1cEDG
 dhb9JMAzYU+7O1nyh/t9KiMAvFS6pGpEyn8zUMeBX5du94nYoxqjHSlpC12TNy91cS5joQyaLa+
 kelQGDVKuQTAZuBpk2J/j7chfzr0IM/7kMbFkReZVHkgsMluo2lx/6t2d+oVjgftKIsuqNANhKk
 REeN0WsSHyug/iLqmuqmH9JjoS7EMKGvDotKH+2Dj4ZswOwnruenvHk5xGZ3sGctG7bDzaV/WRE
 m6SH0BctWLcETTp25t2J+UFJYDwsCaYcFAhAN6m5ZkSVepwCe4XQq+0xXykxVC2T0VR5GktsmJT
 eSmZBvglVLxhjQdi1PA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b03574 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xeNidhmBAAAA:20 a=vTr9H3xdAAAA:8 a=yF-uCvtE38AvPGpA37UA:9
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aditya Gupta <adityag@linux.ibm.com>

With MPIPL support implemented, enable fadump's functional test for PowerNV

Also, current functional test for powernv uses op-build's Linux 5.10 image,
which doesn't support adding "fadump=on" in argument due to this:

    Kernel is locked down from Kernel configuration; see man kernel_lockdown.7

Hence, instead of op-build's image, use the newer fedora vmlinuz as used
in FADump PSeries functional test

Also due to "bash#" string not showing up, rely on sh: no job control to
check if testcase has reached till shell

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260310124619.3909045-10-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/test_fadump.py | 35 ++++++++++-----------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/tests/functional/ppc64/test_fadump.py b/tests/functional/ppc64/test_fadump.py
index bd9692f64c..7ea65974e0 100755
--- a/tests/functional/ppc64/test_fadump.py
+++ b/tests/functional/ppc64/test_fadump.py
@@ -14,6 +14,7 @@ class QEMUFadump(LinuxKernelTest):
 
     1. test_fadump_pseries:       PSeries
     2. test_fadump_pseries_kvm:   PSeries + KVM
+    3. test_fadump_powernv:       PowerNV
     """
 
     timeout = 90
@@ -24,11 +25,6 @@ class QEMUFadump(LinuxKernelTest):
     msg_registered_failed = ''
     msg_dump_active = ''
 
-    ASSET_EPAPR_KERNEL = Asset(
-        ('https://github.com/open-power/op-build/releases/download/v2.7/'
-         'zImage.epapr'),
-        '0ab237df661727e5392cee97460e8674057a883c5f74381a128fa772588d45cd')
-
     ASSET_VMLINUZ_KERNEL = Asset(
         ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
          'releases/39/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
@@ -62,16 +58,14 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
             # SLOF takes upto >20s in startup time, use VOF
             self.set_machine("pseries")
             self.vm.add_args("-machine", "x-vof=on")
-            self.vm.add_args("-m", "6G")
+
+        self.vm.add_args("-m", "6G")
 
         self.vm.set_console()
 
         kernel_path = None
 
-        if is_powernv:
-            kernel_path = self.ASSET_EPAPR_KERNEL.fetch()
-        else:
-            kernel_path = self.ASSET_VMLINUZ_KERNEL.fetch()
+        kernel_path = self.ASSET_VMLINUZ_KERNEL.fetch()
 
         initrd_path = self.ASSET_FEDORA_INITRD.fetch()
 
@@ -102,16 +96,14 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
             timeout=20
         )
 
-        # Ensure fadump is registered successfully, if registration
-        # succeeds, we get a log from rtas fadump:
-        #
-        #     rtas fadump: Registration is successful!
-        self.wait_for_console_pattern(
-            "rtas fadump: Registration is successful!"
-        )
+        # Ensure fadump is registered successfully
+        if not is_powernv:
+            self.wait_for_console_pattern(
+                "rtas fadump: Registration is successful!"
+            )
 
         # Wait for the shell
-        self.wait_for_console_pattern("#")
+        self.wait_for_console_pattern("sh: no job control")
 
         # Mount /proc since not available in the initrd used
         exec_command(self, command="mount -t proc proc /proc")
@@ -135,7 +127,7 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
         # that qemu didn't pass the 'ibm,kernel-dump' device tree node
         wait_for_console_pattern(
             test=self,
-            success_message="rtas fadump: Firmware-assisted dump is active",
+            success_message="fadump: Firmware-assisted dump is active",
             failure_message="fadump: Reserved "
         )
 
@@ -148,7 +140,7 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
         self.wait_for_console_pattern("preserving crash data")
 
         # Wait for prompt
-        self.wait_for_console_pattern("sh-5.2#")
+        self.wait_for_console_pattern("Run /bin/sh as init process")
 
         # Mount /proc since not available in the initrd used
         exec_command_and_wait_for_pattern(self,
@@ -166,9 +158,8 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
     def test_fadump_pseries(self):
         return self.do_test_fadump(is_kvm=False, is_powernv=False)
 
-    @skip("PowerNV Fadump not supported yet")
     def test_fadump_powernv(self):
-        return
+        return self.do_test_fadump(is_kvm=False, is_powernv=True)
 
     def test_fadump_pseries_kvm(self):
         """
-- 
2.52.0


