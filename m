Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E86CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoTu2-0007So-2B; Tue, 19 Aug 2025 17:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoTu0-0007Rw-MH; Tue, 19 Aug 2025 17:29:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoTtz-0006qO-0j; Tue, 19 Aug 2025 17:29:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JJ8YEM018279;
 Tue, 19 Aug 2025 21:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aN023FXOP01KI1YVM
 08x3W37aBtLvsDDKGGQ9kNvh8U=; b=tCdYZDFlX/PGlMS1j2/YxfEW3pt0JXpMI
 qosUrTePOpsJLABVMkfyRTKtkKsHkkbHuVAInc4yUSEpW8Ee+Jh4CmRrw13Ln6rN
 tF5uiOEZem4WHJM/3jJ68xfbo0ypJymsi6rL3sUjxshA5jy8UQktYGWF1gxWG4qN
 g8GBaZ7c5L82fWGc2nSPFmxPfHRhfiw9mjjfFMTchKEDeBCnS4Kj3mC64w8c8eR4
 x9b8mFmfmmFe99cA5QQybP6Ar1Ie0TJ5juO3S8XgG2nf7kvDMOXD61iwkvlERct0
 tEdloHYZmM5+jzFCIFVA25nZwZuzawCx8Fp1lFpAws8XPm70oZ0Mw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge40xa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57JLERge016511;
 Tue, 19 Aug 2025 21:29:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge40x9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JJ9BJJ032003;
 Tue, 19 Aug 2025 21:29:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y0e42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57JLTo5028770868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 21:29:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C718B58056;
 Tue, 19 Aug 2025 21:29:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF7815803F;
 Tue, 19 Aug 2025 21:29:49 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Aug 2025 21:29:49 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH 4/4] tests/functional: Add test for IBM PPE42 instructions
Date: Tue, 19 Aug 2025 16:28:48 -0500
Message-ID: <20250819212856.219932-5-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819212856.219932-1-milesg@linux.ibm.com>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FcM3xI+6 c=1 sm=1 tr=0 ts=68a4ecd1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8
 a=NUakdCcs51WeiAtREWwA:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-GUID: vvoITcok_tKw1jzhKzOvj9Gn5j52p819
X-Proofpoint-ORIG-GUID: xSFqLeiDi5BrLO478kP8wZXBGlCWVVI6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMSBTYWx0ZWRfXz5Rid6RAHqOc
 gW2+no/ttzb6r0OtdZE/gFnqQKQS6vY2Vw9gVi/oMbhS4V1c7kIKnFJvjo+Vyu4jfXf+uo5MNpD
 rTMuYDFDLHlPkMZ1morQiv4NJ6LddoKjZETq7UUnvxmHWmpKAscsUduCQsFf0JYkN98fqLFKEBJ
 WrnLyKqWQ2CsVdwn6vMKMqiB6uwwIjsrTLjOBQvjKdZ1glddotuFsRJRlU2eVGjbsD+/9J2ulLt
 MpCXCvRjNkdAd3EiqwhWIMT1/KUjUJebbJjh97Qi7nNfpirAYuEqg6pRD/N7EiCGIQcnihcQ3Ls
 9TbGpB2a3UpGhS9IZ5sIcyYpr1RKFBBYJY03dLo2h3UPZKlWISUPU0Be3CMxNh5/rQOXx1FLZ1r
 7nffJp/2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160011
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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

Adds a functional test for the IBM PPE42 instructions which
downloads a test image from a public github repo and then
loads and executes the image.
(see https://github.com/milesg-github/ppe42-tests for details)

Test status is checked by periodically issuing 'info register'
commands and checking the NIP value.  If the NIP is 0xFFF80200
then the test successfully executed to completion.  If the
machine stops before the test completes or if a 90 second
timeout is reached, then the test is marked as having failed.

This test does not test any PowerPC instructions as it is
expected that these instructions are well covered in other
tests.  Only instructions that are unique to the IBM PPE42
processor are tested.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 tests/functional/meson.build       |  1 +
 tests/functional/test_ppc_ppe42.py | 79 ++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tests/functional/test_ppc_ppe42.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 311c6f1806..ddfef55bd2 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -233,6 +233,7 @@ tests_ppc_system_quick = [
 ]
 
 tests_ppc_system_thorough = [
+  'ppc_ppe42',
   'ppc_40p',
   'ppc_amiga',
   'ppc_bamboo',
diff --git a/tests/functional/test_ppc_ppe42.py b/tests/functional/test_ppc_ppe42.py
new file mode 100644
index 0000000000..26bbe11b2d
--- /dev/null
+++ b/tests/functional/test_ppc_ppe42.py
@@ -0,0 +1,79 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the IBM PPE42 processor
+#
+# Copyright (c) 2025, IBM Corporation
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+import asyncio
+
+class Ppe42Machine(QemuSystemTest):
+
+    timeout = 90
+    poll_period = 1.0
+
+    ASSET_PPE42_TEST_IMAGE = Asset(
+        ('https://github.com/milesg-github/ppe42-tests/raw/refs/heads/main/'
+         'images/ppe42-test.out'),
+        '03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8')
+
+    def _test_completed(self):
+        self.log.info("Checking for test completion...")
+        try:
+            output = self.vm.cmd('human-monitor-command',
+                                 command_line='info registers')
+        except Exception as err:
+            self.log.debug(f"'info registers' cmd failed due to {err=},"
+                            " {type(err)=}")
+            raise
+
+        self.log.info(output)
+        if "NIP fff80200" in output:
+            self.log.info("<test completed>")
+            return True
+        else:
+            self.log.info("<test not completed>")
+            return False
+
+    def _wait_pass_fail(self, timeout):
+        while not self._test_completed():
+            if timeout >= self.poll_period:
+                timeout = timeout - self.poll_period
+                self.log.info(f"Waiting {self.poll_period} seconds for test"
+                               " to complete...")
+                e = None
+                try:
+                    e = self.vm.event_wait('STOP', self.poll_period)
+
+                except asyncio.TimeoutError:
+                    self.log.info("Poll period ended.")
+                    pass
+
+                except Exception as err:
+                    self.log.debug(f"event_wait() failed due to {err=},"
+                                    " {type(err)=}")
+                    raise
+
+                if e != None:
+                    self.log.debug(f"Execution stopped: {e}")
+                    self.log.debug("Exiting due to test failure")
+                    self.fail("Failure detected!")
+                    break
+            else:
+                self.fail("Timed out waiting for test completion.")
+
+    def test_ppe42_instructions(self):
+        self.set_machine('ppe42_machine')
+        self.require_accelerator("tcg")
+        image_path = self.ASSET_PPE42_TEST_IMAGE.fetch()
+        self.vm.add_args('-nographic')
+        self.vm.add_args('-device', f'loader,file={image_path}')
+        self.vm.add_args('-device', 'loader,addr=0xfff80040,cpu-num=0')
+        self.vm.add_args('-action', 'panic=pause')
+        self.vm.launch()
+        self._wait_pass_fail(self.timeout)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


