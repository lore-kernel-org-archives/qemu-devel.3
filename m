Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EA0D15DA5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tvC-0000Q2-DG; Mon, 21 Oct 2024 11:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t2tv9-0000PP-Mn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:02:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t2tv6-0002n2-Ko
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:02:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2LijZ018547;
 Mon, 21 Oct 2024 15:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ETZ6ua41uh8lb1BiuTDnx/2pcfbXa7SPTShZ9gNSB
 rk=; b=hMo002l9ZnaZBFKjs5RL+sPFHfrC3e0I/oh8tb3UdnfUt9RiJo19+HckA
 dM9FaEJvZ/EDln3DZ1A/W5bO/BOnoEx+OYZ8xkKfi68pb9cJMUiPQRLVQl2kS0wJ
 PQ4775kxO5md9SIlg7WDEW0kEyeXkbcQ1dgeadM1D4huZzfdNY4Pcr+YzJwRUeY0
 hBAhrDqN5y6as0sXkvR2zNcK1jvnm2h1tgrLEs2KHeHOu8rLtYEBlu2d5wmEkCBZ
 R139wLAQMeS4GyO1w0nY8ROXam5p66aqPSwTRlbqcH1SThL9WxHABta24DBLgkSC
 zPc/5bua2jAXo1vvJvyF99WH/aFcw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h31xsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 15:02:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49LD0plM023864;
 Mon, 21 Oct 2024 15:01:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cst0xk5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 15:01:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49LF1t0617629460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 15:01:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F9352004D;
 Mon, 21 Oct 2024 15:01:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 068E420040;
 Mon, 21 Oct 2024 15:01:55 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.27.206])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2024 15:01:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tests/tcg: Stop using exit() in the gdbstub testcases
Date: Mon, 21 Oct 2024 17:01:26 +0200
Message-ID: <20241021150153.487057-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N-K6Od7cLBUz9Mr0XsrbWSyu0ukQTWa5
X-Proofpoint-ORIG-GUID: N-K6Od7cLBUz9Mr0XsrbWSyu0ukQTWa5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

GDB 15 does not like exit() anymore:

    (gdb) python exit(0)
    Python Exception <class 'SystemExit'>: 0
    Error occurred in Python: 0

Use the GDB's own exit command, like it's already done in a couple
places, everywhere.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
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


