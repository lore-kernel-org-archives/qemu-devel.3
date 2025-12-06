Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB519D3ABF8
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 06:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRlJr-0004KC-4b; Sat, 06 Dec 2025 00:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJj-0004GS-Db; Sat, 06 Dec 2025 00:58:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJh-0005an-7V; Sat, 06 Dec 2025 00:58:50 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B60OMEk026159;
 Sat, 6 Dec 2025 05:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=T3tIPKeQAADyXWCDV
 xeggjX5Rh0Bq6dOHRDPPzZ65po=; b=m9DxgiNAOA8qUc5vIGV7EFfa6Vte0IOjH
 6mMuwRA1LJ0W79OrbNtvrR0CwgVRcLClshKKQ7g4OxkjUiYIvXOvokRxsOKX8yga
 kRbRFMWuwdfOhweqHc5dB0+HheBlcQnCo1Qgf/Gin3p6LSryluWGE/PsfXRkIaes
 IyfuSfH2O8i3OP+qY0+HV+5TwCpNaPMnxTEYdMkT7aO9IpDYRS7xpyi/ppKqS8hA
 0TF4v7/gzzdyePZIpnmzMhja05FrsssKCBBYkwN8MC1qTfQ4vnWveFxv5Tn24NvX
 E4bkDYgkhZVAVrLiGiZPhHAkux9gF9/Orqxzy7wbjI2Mkw9yWY8fQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wv8r2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B62x14b010227;
 Sat, 6 Dec 2025 05:58:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnkryhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B65wfxV10289602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Dec 2025 05:58:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F14D420043;
 Sat,  6 Dec 2025 05:58:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4A0020040;
 Sat,  6 Dec 2025 05:58:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.93]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Dec 2025 05:58:38 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 9/9] tests/functional: Add test for MPIPL in PowerNV
Date: Sat,  6 Dec 2025 11:26:48 +0530
Message-ID: <20251206055648.1908734-10-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V17ta6Ow0TczQEqFVXg-ehMzJcOmfkNO
X-Proofpoint-ORIG-GUID: V17ta6Ow0TczQEqFVXg-ehMzJcOmfkNO
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6933c615 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=vTr9H3xdAAAA:8
 a=VnNF1IyMAAAA:8 a=m4y8BZz7buB5IStCL_MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX3V69rFRcasBG
 g50czh97aG8pLV3AePeIZmWF6j3r5nwrPNxZTAMRTgEdckqP3rfSKvSTBEbXGY+dEJe3UnbpihR
 hqFk3zdX7uU+aVEqHECbtvvYYjWhgndtv9DYawCHhVmAAmFjZXdVSfit2SNa5xloA9m/WADAedB
 kDfa/T67f6q1DU6I243lnXN0qQuxtSNCu6qOSSltZLPSJdSwoUSw60X0zN+JB5gd3G8CcDTnqSb
 A0OfiUjZW7W0sWYHJhSmAHS64j5MP8zgsMJy13qceJTLKvTb9O9GoN8aUZIhVi05oLU5cv0LqSa
 RH0DLHe1fD6VdeRVakEjTtPcVjpJlT593xKkREydqvraolnAU2SlRHm5MdUt0m1aP7rUV0febJT
 x8Pk8r4zwY05f5wk7H/H/jGU6sj6NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
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
index 2d6b8017e8f0..e3238ceadfe6 100755
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
@@ -64,16 +60,14 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
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
 
@@ -104,16 +98,14 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
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
@@ -137,7 +129,7 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
         # that qemu didn't pass the 'ibm,kernel-dump' device tree node
         wait_for_console_pattern(
             test=self,
-            success_message="rtas fadump: Firmware-assisted dump is active",
+            success_message="fadump: Firmware-assisted dump is active",
             failure_message="fadump: Reserved "
         )
 
@@ -150,7 +142,7 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
         self.wait_for_console_pattern("preserving crash data")
 
         # Wait for prompt
-        self.wait_for_console_pattern("sh-5.2#")
+        self.wait_for_console_pattern("Run /bin/sh as init process")
 
         # Mount /proc since not available in the initrd used
         exec_command_and_wait_for_pattern(self,
@@ -168,9 +160,8 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
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


