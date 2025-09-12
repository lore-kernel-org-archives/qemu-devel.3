Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB34CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6xd-00024a-5g; Fri, 12 Sep 2025 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6xQ-0001nJ-IO; Fri, 12 Sep 2025 12:49:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6xO-0008Kw-Ax; Fri, 12 Sep 2025 12:49:08 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CFg2ND017852;
 Fri, 12 Sep 2025 16:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Yp1rnR
 m1mtU0vDWAQJsbETwPEQ8gne7OPoZdYcgKjfU=; b=D4U++dRbifylIyvBeIG9fA
 VIcRnAmiGptuLUFWVoGenSst+L1Z6N73KIpiYGYU4uCVwifT8X5+JMvjy9M1nY/G
 Rhj5757vOQDw2BM/MEUXwsR0my6QTEwGLYY/Xkaj6Lam71vYeV/NRf3kwDdioA18
 pupI9SmfRQsg9Ksyd18lhw/yWQvGUi8Wp0UhVblESXH7S6RuAWKisnqqGPGCvGcm
 FYgn9ReIZY/TUh6pzpa0ycFcJ6dgUsQEUUXZ3jopJtFW3M0wlu4+tTdt4/0VHRDk
 KW2K+D0d7ujgrTYm08lrcMnIO7Ev3YlL2dx385WRCZUpmh3mDDapE1e6xpYzn0sQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bctbbve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:49:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58CGlWaP015883;
 Fri, 12 Sep 2025 16:49:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bctbbvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:49:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CE5kkG007982;
 Fri, 12 Sep 2025 16:49:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109q3wtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:49:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58CGn1WM54002060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 16:49:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25B835805E;
 Fri, 12 Sep 2025 16:49:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B08315805A;
 Fri, 12 Sep 2025 16:49:00 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Sep 2025 16:49:00 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v4 9/9] tests/functional: Add test for IBM PPE42 instructions
Date: Fri, 12 Sep 2025 11:47:37 -0500
Message-ID: <20250912164808.371944-10-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912164808.371944-1-milesg@linux.ibm.com>
References: <20250912164808.371944-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX3NxSkJs3xwAt
 +YqvjkA7UuEoK3bnZZGo/AxRCOSIU3BJ0IuL5HTGeeowPQlbJRMIzC4rskjyU5rSqxdIu9lvqby
 aC7rrL9MzlBZ88ofmoGx+q2DRj1S/awBmbeEVNeE3cRg+tRYaWZOllmooHd5i6YR7QElSKY/wcb
 5dd3SDKN4MM16rtnO5n8B4mlSUhq94kjNmTiLxQnq/gU0ZqeVYujAIdD3iuHhU4YvcxoAT0wSjQ
 2g+myKAPzxAXa+qXjO6nl3y/Iju6gpDtcXBnvRTSz6TYlqJwX0RnaxK2Py2wiu8gfvP/s/vuXnJ
 Uf8ogRXzSRxDzUDm98BFSlcTDNfHx/gb1NA8t1wNKMz56ryZtXgFGKM6dWmXtdiqhzamttG8Y9H
 7SQXScaE
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c44f00 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=up-X0YpDAAAA:8 a=WP5zsaevAAAA:8
 a=NUakdCcs51WeiAtREWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=86FmjZgct7XXK6GGpxvI:22 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-GUID: 0pAwxREzxDXG9aGAOFmeG5R9FIC9L0pB
X-Proofpoint-ORIG-GUID: d6-NYIPA_Gx_1a2GoQCsRowGeG0NyP6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
Changes from v3:
  - Rebase required moving test into tests/functional/ppc

 MAINTAINERS                        |  1 +
 tests/functional/ppc/meson.build   |  1 +
 tests/functional/ppc/test_ppe42.py | 79 ++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 tests/functional/ppc/test_ppe42.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 33ff9f14be..e20bab9b2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1535,6 +1535,7 @@ M: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppe42_machine.c
+F: tests/functional/ppc/test_ppe42.py
 
 PReP
 M: Hervé Poussineau <hpoussin@reactos.org>
diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meson.build
index 3d562010d8..ae061fe5a6 100644
--- a/tests/functional/ppc/meson.build
+++ b/tests/functional/ppc/meson.build
@@ -15,6 +15,7 @@ tests_ppc_system_thorough = [
   'bamboo',
   'mac',
   'mpc8544ds',
+  'ppe42',
   'replay',
   'sam460ex',
   'tuxrun',
diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
new file mode 100644
index 0000000000..26bbe11b2d
--- /dev/null
+++ b/tests/functional/ppc/test_ppe42.py
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


