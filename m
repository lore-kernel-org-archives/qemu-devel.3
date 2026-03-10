Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BB8FD2D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwVR-0006CD-MI; Tue, 10 Mar 2026 08:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzwUF-00054E-Gu; Tue, 10 Mar 2026 08:46:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzwUD-0003AQ-4O; Tue, 10 Mar 2026 08:46:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A9JfsE1455623; Tue, 10 Mar 2026 12:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gCouDQl/xUhsUxOzZ
 /1sjor9Q++aGzChfSsdF05Mb5E=; b=KIOGuUhFqrMtzkMUxpvqLBEfMsD9VrkQ9
 g0wPpGvtJHTxNZfr67uedpkdzwSEqVeDF+RRvja07jB5KeiALyF9Q7tPq3u2B3cC
 Tan+fwsPmdddngxEBV6kxEJtewv+25Bqmu5mTxTBN0NlraDs6z/4SddteuZBo0Ny
 H05ucyBXwINNbLWTWKi1q7JI5PCzrhN13t/f6ZsWoqF4VIQZhDddO9GHGyi/s6WW
 oJobNr80v5XG1g3Qf5RyxEDxZR4rJAk7i962sTTfgarDi4LURKcr5TlZa7BCFQE2
 1Lzbh9/1sMBMV7IoOygrXjVAMcCfk7AQEUn3gqmx0CKQhJS8U6hPw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyaucn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 12:46:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABHdOv023022;
 Tue, 10 Mar 2026 12:46:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng21e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 12:46:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62ACkoYl28836182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 12:46:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02AB82004D;
 Tue, 10 Mar 2026 12:46:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86D1820040;
 Tue, 10 Mar 2026 12:46:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 12:46:47 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v5 09/10] tests/functional: Add test for MPIPL in PowerNV
Date: Tue, 10 Mar 2026 18:16:16 +0530
Message-ID: <20260310124619.3909045-10-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310124619.3909045-1-adityag@linux.ibm.com>
References: <20260310124619.3909045-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b012bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=xeNidhmBAAAA:20 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8
 a=yF-uCvtE38AvPGpA37UA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwOSBTYWx0ZWRfX9I7d3eDs6rWC
 UvvQYVPTPVsOIxvMVsx+ZUHdBn7tLtR5Y9UylmP+Mt+5igM9IEQc1eUjljWFk6OWil8Jw9s7fcu
 LEBBqLmxh8y3qLAi3rrFsokQxULkDIhyV8TyrsVSnEfQwBz+/SP0y0AdJWM2yX9B97PdOviX6u4
 DvLe7jB/3UDMHpbZxor6Ur0k76HGUYvJatxvNRfqvqc/MQY/agLiYyBEKxNF5TzpZRq8M4B4Vzb
 ngFrJszBa4vEsJOdTLORs0+OMoSaG/nIPhV8Wp9H3w0Zdmoi1ph68ydfUz1FBb8o/H+edZuzQTI
 RdNB+AZBWMvGnu5cU+bNUUIIcdIpDSp1q9mBVBByJT2yfQpPWdMvuk0rWY7UNrNZrbTEIqvMirq
 kZizLopo+vNDc5vbFhh/lHQ8M6RnZZvvngFRWQ4VSQm7EMNrxhExWQSoouonxxbCZR/gfoPmDfK
 eoMMd6qNjM/syqv9hQQ==
X-Proofpoint-GUID: t_0YIVC6OkDM0-_y4FJZHmNThDQ4HX1M
X-Proofpoint-ORIG-GUID: _Og19lAHMSICL2POpcY0WbyfyiajYJu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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
---
 tests/functional/ppc64/test_fadump.py | 35 ++++++++++-----------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/tests/functional/ppc64/test_fadump.py b/tests/functional/ppc64/test_fadump.py
index bd9692f64c05..7ea65974e0ea 100755
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
2.53.0


