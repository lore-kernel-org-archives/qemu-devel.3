Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDB6D1713D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3DFA-0005LI-Uy; Tue, 22 Oct 2024 07:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3DEw-0005Km-Sj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:39:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3DEu-00014R-2O
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:39:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HEA1018378;
 Tue, 22 Oct 2024 11:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=DrJYM7OmrEChNecpP4cBzc7hafsi
 kJHo6jqqXcsVJhA=; b=aqv1rTPis+i5uroI5DeTdM24prPWnYDI3ZDTNAz9gmDq
 GYmK1HjZqlcnDUizIrxAA0BIqH45kyx78r3Y1J7uXv+YkRlBo1IJ2O8clxtXJxlR
 4CrAZrktTagRUm7rYLWxkvKNwasoUrTcKH4G/b32Cih3AQROxHI10rm2Lh5IV/u6
 Wr+iLnnWd+vqYBNP5i71yIlyM03HkbTEoLrENqzqtgW2LN+Zt3zmhx9QIyiUTdAS
 8IXvth7Yjm0KpaTtpztmWrr8mF1+nULl97ruZWWL0I6nKqZK8Sje22SdVct4pw6F
 Rl7MaGEajeRIy96SThb0Hm3QK+Y2J/AffrhAFhQEEQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5gcpack-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 11:39:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M82Fd4026471;
 Tue, 22 Oct 2024 11:39:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3sb6m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 11:39:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49MBdeqn50987510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 11:39:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94BE520043;
 Tue, 22 Oct 2024 11:39:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BECA20040;
 Tue, 22 Oct 2024 11:39:40 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.26.72])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Oct 2024 11:39:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] tests/tcg: Stop using exit() in the gdbstub testcases
Date: Tue, 22 Oct 2024 13:37:11 +0200
Message-ID: <20241022113939.19989-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6WViykz38n35A2yWy4hBzN1FxVOjnb5R
X-Proofpoint-ORIG-GUID: 6WViykz38n35A2yWy4hBzN1FxVOjnb5R
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

GDB 15 does not like exit() anymore:

    (gdb) python exit(0)
    Python Exception <class 'SystemExit'>: 0
    Error occurred in Python: 0

Use the GDB's own exit command, like it's already done in a couple
places, everywhere. This is the same fix as commit 93a3048dcf45
("tests: Gently exit from GDB when tests complete"), but applied to
more places.

Acked-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
v1: https://lore.kernel.org/qemu-devel/20241021150153.487057-1-iii@linux.ibm.com/
v1 -> v2: Mention 93a3048dcf45 (Peter, Gustavo, Philippe).
          Collect A-b and R-b.

 tests/guest-debug/test_gdbstub.py                 | 14 ++++++++++----
 tests/tcg/multiarch/gdbstub/interrupt.py          |  4 ++--
 tests/tcg/multiarch/gdbstub/prot-none.py          |  4 ++--
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py |  4 ++--
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
index a715c0e3f5e..4f08089e6a9 100644
--- a/tests/guest-debug/test_gdbstub.py
+++ b/tests/guest-debug/test_gdbstub.py
@@ -10,10 +10,16 @@
 
 fail_count = 0
 
+
+def gdb_exit(status):
+    gdb.execute(f"exit {status}")
+
+
 class arg_parser(argparse.ArgumentParser):
     def exit(self, status=None, message=""):
         print("Wrong GDB script test argument! " + message)
-        gdb.execute("exit 1")
+        gdb_exit(1)
+
 
 def report(cond, msg):
     """Report success/fail of a test"""
@@ -38,11 +44,11 @@ def main(test, expected_arch=None):
                    "connected to {}".format(expected_arch))
     except (gdb.error, AttributeError):
         print("SKIP: not connected")
-        exit(0)
+        gdb_exit(0)
 
     if gdb.parse_and_eval("$pc") == 0:
         print("SKIP: PC not set")
-        exit(0)
+        gdb_exit(0)
 
     try:
         test()
@@ -62,4 +68,4 @@ def main(test, expected_arch=None):
         pass
 
     print("All tests complete: {} failures".format(fail_count))
-    gdb.execute(f"exit {fail_count}")
+    gdb_exit(fail_count)
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
index 90a45b5140a..2d5654d1540 100644
--- a/tests/tcg/multiarch/gdbstub/interrupt.py
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -8,7 +8,7 @@
 #
 
 import gdb
-from test_gdbstub import main, report
+from test_gdbstub import gdb_exit, main, report
 
 
 def check_interrupt(thread):
@@ -49,7 +49,7 @@ def run_test():
     """
     if len(gdb.selected_inferior().threads()) == 1:
         print("SKIP: set to run on a single thread")
-        exit(0)
+        gdb_exit(0)
 
     gdb.execute("set scheduler-locking on")
     for thread in gdb.selected_inferior().threads():
diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index 7e264589cb8..51082a30e40 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,7 +5,7 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
-from test_gdbstub import main, report
+from test_gdbstub import gdb_exit, main, report
 
 
 def probe_proc_self_mem():
@@ -22,7 +22,7 @@ def run_test():
     """Run through the tests one by one"""
     if not probe_proc_self_mem():
         print("SKIP: /proc/self/mem is not usable")
-        exit(0)
+        gdb_exit(0)
     gdb.Breakpoint("break_here")
     gdb.execute("continue")
     val = gdb.parse_and_eval("*(char[2] *)q").string()
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 0f687f3284a..6eb6ebf7b17 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -3,7 +3,7 @@
 This runs as a sourced script (via -x, via run-test.py)."""
 from __future__ import print_function
 import gdb
-from test_gdbstub import main, report
+from test_gdbstub import gdb_exit, main, report
 
 
 def run_test():
@@ -12,7 +12,7 @@ def run_test():
         # m68k GDB supports only GDB_OSABI_SVR4, but GDB_OSABI_LINUX is
         # required for the info proc support (see set_gdbarch_info_proc()).
         print("SKIP: m68k GDB does not support GDB_OSABI_LINUX")
-        exit(0)
+        gdb_exit(0)
     mappings = gdb.execute("info proc mappings", False, True)
     report(isinstance(mappings, str), "Fetched the mappings from the inferior")
     # Broken with host page size > guest page size
-- 
2.47.0


