Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC9FFD3758
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEIR-0007OT-9L; Wed, 25 Feb 2026 07:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEIP-0007Nf-Oa; Wed, 25 Feb 2026 07:47:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEIN-0002IU-GT; Wed, 25 Feb 2026 07:47:17 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OKGpJr2346129; Wed, 25 Feb 2026 12:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GMdjZsABBxn0XKEYw
 kOI33cjbYG2f5rNoYGqUCK5CF0=; b=IZcx5axOyBRRtIj3u7TDjBYAql0ox2aal
 FkhlQn9ErAl+p6fK9suv8OKJOc/r+xSSEPCSJuHjTm8M4SbutPKzaNgPDDoTg0yP
 OYwyxyg5PH9/VLmtL6yY3H3L3KYWY6uG/zpG0AavhUnFX/sXJjJwJS+p2Wqf8uCQ
 0MbH2Q2B1iHlr/KlTIEbQ2Bvchmt2Hfv5M4hkJSdq/TfU3HAYl90Z2jNxyehxjHM
 VO/EFcaQvxHARacwb1XaqckndowqTeY/aubYvCluWL/RAOkwr7NQEkDFZ/toSK6P
 WBBNj32JZd06xlNpEQHX1QyqJqC75Z/kM6Ib/1AG2iWIsFMjE7Qgg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858nmpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:47:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P9BWQo003821;
 Wed, 25 Feb 2026 12:47:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jw42b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:47:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PCl8Tk57540950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 12:47:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C95F12004B;
 Wed, 25 Feb 2026 12:47:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13D0620040;
 Wed, 25 Feb 2026 12:47:06 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.235])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 12:47:05 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v3 09/10] tests/functional: Add test for MPIPL in PowerNV
Date: Wed, 25 Feb 2026 18:16:31 +0530
Message-ID: <20260225124633.1841222-10-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225124633.1841222-1-adityag@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX8wb4Ico+DHu8
 7eAJe3wQCmv9UD5wI8E1O1OiY3W5akB+JkukEBmwa/v3CpWB5oepF1+5A+B2C1jztdWY0/EB3p5
 pj38hPqAoJAWjfzUGC0ZY04v0GbMKdr1cZVa05mNXK3fSa7jhygbVSc5zICJ+ut4eBItXYRe5Fq
 du9lY3JjSErNipdtu11sIIENe5wcKkLNW42NLN+6/luAZoSIs7dwLQPgq8r+4thltYKnjayH9vv
 yRPwo8xTD8/vaKkZ+FUyN5ossrOyICUpZ7sV035IeHOr6UST5sqIRHFrJpVH9XR+xxBrDDKM4QC
 3uXcWwzDQJK07bHQDmgayTIuaoIhIiW8rBd3Ye63JvL9fysVBfTNIh2Ng11mNxarm6KZK991u/A
 M+8y9FM/Z/EUlVt9JodTwr7IrLScNgMDXa+FMDxiaNVGzLd3+7cQtOOhRQ0ILZ64zh1xLGfnCgm
 +byS7HfOseNZZpOnXmA==
X-Proofpoint-GUID: BIxtlIJRE7mFQqAq4qjvJvDV0vWF2jg2
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699eef51 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=xeNidhmBAAAA:20 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8
 a=yF-uCvtE38AvPGpA37UA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: yHR47q2C_0oXxCilH8Mev6hMOdrkFq5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250123
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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


