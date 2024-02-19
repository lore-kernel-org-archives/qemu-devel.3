Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEA7C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Sg-0007jf-BL; Mon, 19 Feb 2024 09:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SU-0007ce-VY
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SS-0000bG-RL
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:26 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDNAoN016544; Mon, 19 Feb 2024 14:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oMfA3x9SvcDcnZaM7jMdOCs+kp+lWpjXVTF9brY0EZc=;
 b=l8IeWpWX3SOl9VNA50gIlKNP0iAEXN1xf2NMD+sV6IunMSZa26esNeLMIYh4Nu40ReuD
 9SaeMwEkG7GCm75XmosIXv2eZ5U+mD06tYnKBmc70KsPY+vVtPy1ID9mRm6m4BOu1NC7
 5lWyqpwamU29AgLOPXTkMbKoKpmHNXTRLaOFTcpe/sAgpAtWWoM73Ct9htJ1AIqSgpY8
 cTpkW5cUX/NZPqIMEJfOEuMASKF2MJ5/fAkyLmO6CLP0zt9JhPJUJpbxdpB31KCjTj8a
 AbmcQ1jfHvWzA5F6iEWiBe+n6+bXLaWuT3CZp6COlIgmZIa5NMbVb9TNPBxvJlaB34Rr bA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7tt1tah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JECMqP003987;
 Mon, 19 Feb 2024 14:17:05 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7tt1t9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDGDZD014406; Mon, 19 Feb 2024 14:17:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u29430-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEH0xj45417124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:17:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 832362004D;
 Mon, 19 Feb 2024 14:17:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48BB02006A;
 Mon, 19 Feb 2024 14:17:00 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:17:00 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 12/12] tests/tcg: Add two follow-fork-mode tests
Date: Mon, 19 Feb 2024 15:16:00 +0100
Message-ID: <20240219141628.246823-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com>
References: <20240219141628.246823-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0-YVqNladi6WzIVFEsrWarlyXXP5waua
X-Proofpoint-ORIG-GUID: th3vVCwN0noaYFtknlaCOvaIHD4FDqaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add follow-fork-mode child and and follow-fork-mode parent tests.
Check for the obvious pitfalls, such as lingering breakpoints,
catchpoints, and single-step mode.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target           | 17 +++++-
 tests/tcg/multiarch/follow-fork-mode.c        | 56 +++++++++++++++++++
 .../gdbstub/follow-fork-mode-child.py         | 40 +++++++++++++
 .../gdbstub/follow-fork-mode-parent.py        | 16 ++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index e10951a8016..b8b70c81860 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -115,6 +115,20 @@ run-gdbstub-catch-syscalls: catch-syscalls
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/catch-syscalls.py, \
 	hitting a syscall catchpoint)
 
+run-gdbstub-follow-fork-mode-child: follow-fork-mode
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-child.py, \
+	following children on fork)
+
+run-gdbstub-follow-fork-mode-parent: follow-fork-mode
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
+	following parents on fork)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
@@ -122,7 +136,8 @@ endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
-	      run-gdbstub-catch-syscalls
+	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
+	      run-gdbstub-follow-fork-mode-parent
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/follow-fork-mode.c b/tests/tcg/multiarch/follow-fork-mode.c
new file mode 100644
index 00000000000..cb6b032b388
--- /dev/null
+++ b/tests/tcg/multiarch/follow-fork-mode.c
@@ -0,0 +1,56 @@
+/*
+ * Test GDB's follow-fork-mode.
+ *
+ * fork() a chain of processes.
+ * Parents sends one byte to their children, and children return their
+ * position in the chain, in order to prove that they survived GDB's fork()
+ * handling.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+void break_after_fork(void)
+{
+}
+
+int main(void)
+{
+    int depth = 42, err, i, fd[2], status;
+    pid_t child, pid;
+    ssize_t n;
+    char b;
+
+    for (i = 0; i < depth; i++) {
+        err = pipe(fd);
+        assert(err == 0);
+        child = fork();
+        break_after_fork();
+        assert(child != -1);
+        if (child == 0) {
+            close(fd[1]);
+
+            n = read(fd[0], &b, 1);
+            close(fd[0]);
+            assert(n == 1);
+            assert(b == (char)i);
+        } else {
+            close(fd[0]);
+
+            b = (char)i;
+            n = write(fd[1], &b, 1);
+            close(fd[1]);
+            assert(n == 1);
+
+            pid = waitpid(child, &status, 0);
+            assert(pid == child);
+            assert(WIFEXITED(status));
+            return WEXITSTATUS(status) - 1;
+        }
+    }
+
+    return depth;
+}
diff --git a/tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py b/tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
new file mode 100644
index 00000000000..72a6e440c08
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
@@ -0,0 +1,40 @@
+"""Test GDB's follow-fork-mode child.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.execute("set follow-fork-mode child")
+    # Check that the parent breakpoints are unset.
+    gdb.execute("break break_after_fork")
+    # Check that the parent syscall catchpoints are unset.
+    # Skip this check on the architectures that don't have them.
+    have_fork_syscall = False
+    for fork_syscall in ("fork", "clone", "clone2", "clone3"):
+        try:
+            gdb.execute("catch syscall {}".format(fork_syscall))
+        except gdb.error:
+            pass
+        else:
+            have_fork_syscall = True
+    gdb.execute("continue")
+    for i in range(42):
+        if have_fork_syscall:
+            # syscall entry.
+            if i % 2 == 0:
+                # Check that the parent single-stepping is turned off.
+                gdb.execute("si")
+            else:
+                gdb.execute("continue")
+            # syscall exit.
+            gdb.execute("continue")
+        # break_after_fork()
+        gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 42, "{} == 42".format(exitcode))
+
+
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py b/tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py
new file mode 100644
index 00000000000..5c2fe722088
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py
@@ -0,0 +1,16 @@
+"""Test GDB's follow-fork-mode parent.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.execute("set follow-fork-mode parent")
+    gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
-- 
2.43.2


