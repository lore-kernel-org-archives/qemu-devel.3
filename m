Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14C3EF36F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUuv-0006SI-Gj; Mon, 09 Mar 2026 03:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUut-0006Qm-8y; Mon, 09 Mar 2026 03:20:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUur-0006Eg-IA; Mon, 09 Mar 2026 03:20:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628Ns7cD1721997; Mon, 9 Mar 2026 07:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gCouDQl/xUhsUxOzZ
 /1sjor9Q++aGzChfSsdF05Mb5E=; b=hJeEaP1TxRISSWf6Wyu7UxfQTBN4GGZ84
 aCwoYfEnwPa/bQNZXb5QeAHmeQyTRT7zS4lQYYjKqnzkySPR993HAQ8x5NpHJ4w5
 Pv6VpPZwfXKAOko/GQcOK0EHcLLtvjUOe8gHrBtErgrhcrRDlKmmqULV7KjnV+aM
 Y2iiVywFGIZP+azSK/IUkNYkS2Mvov1g6nQb/1W40kP6hTwBWpIdbDq9Mde+ipIu
 sLA8A5eJQRMmqb4zF/hS/SEB5K7Umt2k6TeHEXH7CknznJqr4j6O4PDAjacfFVec
 wTXRDADSP+tlsbIXWawEMGo1PGZMBxSbUfAbGuYEAFKnMzyp/rNVg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr5abj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6293pLTi009505;
 Mon, 9 Mar 2026 07:20:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy4310-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297KV0s40894950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01DF22004F;
 Mon,  9 Mar 2026 07:20:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3988020040;
 Mon,  9 Mar 2026 07:20:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:29 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 09/10] tests/functional: Add test for MPIPL in PowerNV
Date: Mon,  9 Mar 2026 12:49:58 +0530
Message-ID: <20260309072001.3136261-10-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfXyokVp0TrqnkZ
 WZjtsd2zMSAtgey3wN0DN6jdrAo2eEHtEAJzyULYWp12VYU/lH+FMeD+lxXi6sTAgtskfjWXE/M
 RRvqtucwaOxVCLrcTOHFKw9MqP/BDMNtbyzYbsiDtGF0sk/lzg6D9Pkcx6ccAzBXSOUjvR3LZ3u
 8d1JO3ntkz8NzTmBWyCbU4ad/5DrrBf6nE9Er4BU4xv3LMSuO9JA26JvdwRbyYk0D5sWoOnUm1N
 avpRevHtgs7Tfchu1x4tz9sZuuUu6fbpWVcX8KiXQ+KelYAkvgY1+STqM87uadG0ipA69jM1nG9
 qFLxUzva6QBwuMmv3noogm+JF+Mvt+RaOJ5zRd7HHKJG0p8TRTtf+NXRmyF5w0rIWCDQt354UYf
 y3rhScS+K03d8WBWScY1uEF5UWv6hv2zaC+0gfi41egOfOrgjRw96OGbpX+c04OQZSPQg4PYDvF
 eSoZHlft6KSE2dQIwYw==
X-Proofpoint-GUID: ezwazmuq7zGXu9g0bB3XUYp58lt_U_aP
X-Proofpoint-ORIG-GUID: g8NeY5TJs6sCLLdXMLLp1a_ugjkDkSQz
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69ae74c4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=xeNidhmBAAAA:20 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8
 a=yF-uCvtE38AvPGpA37UA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


