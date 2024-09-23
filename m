Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284D8CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslq2-00080U-2d; Mon, 23 Sep 2024 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpZ-0006XU-O1
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpW-0000cX-05
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NCxHbN027664;
 Mon, 23 Sep 2024 16:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:mime-version; s=pp1; bh=IKh+tMgnefobp
 QcHLCDkFG0LTLlCEpBsVAWl2X8EoSg=; b=IiJlU0tz2lq2XVs9hfI3mcyD4Pus4
 Of7U+8FGzsG1aFh4duyYQO6E4BQ17NyXiqtvwjn3D6hnqMpcH/0kKN9WLRnlb+mC
 92Ing9c+Gjcly1yKefU7sdqNJBO8A/8m1FT4HRhLH2tsE+df3pVPVFyCFA7x/8CE
 58wzF0lqy6SYdpr0n9O8nyvOC1U0ssaNQ9opuLycfuXOyChSb/qWfxoCJ/LymdQA
 D0ol8d5UBRrY0rmDA6ns4Uilov5mXlZfbP2N18Vws+cZZgstfPXVozZmZPvqSJvf
 JYvflvPKX4KV4XP25XyxLKp7lIScfxgIxixyEb0AmpIthH8STCFefY4tw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14pcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGKwNU023341;
 Mon, 23 Sep 2024 16:22:27 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14pcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDl7H0000643;
 Mon, 23 Sep 2024 16:22:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fufp6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMOEh52232606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B97720043;
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2736C20040;
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 18/18] tests/tcg: Stress test thread breakpoints
Date: Mon, 23 Sep 2024 18:13:13 +0200
Message-ID: <20240923162208.90745-19-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _EpI72GVGbHpEqupnWVrFmUWPYP51zGV
X-Proofpoint-GUID: 8MFafCs5dLQVfFA7GPdLHqL5gZPVboWv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add a test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target           | 13 ++-
 .../gdbstub/test-thread-breakpoint-stress.py  | 28 ++++++
 .../tcg/multiarch/thread-breakpoint-stress.c  | 92 +++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-thread-breakpoint-stress.py
 create mode 100644 tests/tcg/multiarch/thread-breakpoint-stress.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 5e3391ec9d2..0a9cd037094 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -42,6 +42,9 @@ munmap-pthread: LDFLAGS+=-pthread
 vma-pthread: CFLAGS+=-pthread
 vma-pthread: LDFLAGS+=-pthread
 
+thread-breakpoint-stress: CFLAGS+=-pthread
+thread-breakpoint-stress: LDFLAGS+=-pthread
+
 # The vma-pthread seems very sensitive on gitlab and we currently
 # don't know if its exposing a real bug or the test is flaky.
 ifneq ($(GITLAB_CI),)
@@ -127,6 +130,13 @@ run-gdbstub-follow-fork-mode-parent: follow-fork-mode
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
 	following parents on fork)
 
+run-gdbstub-thread-breakpoint-stress: thread-breakpoint-stress
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint-stress.py, \
+	hitting many breakpoints on different threads)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
@@ -136,7 +146,8 @@ EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
-	      run-gdbstub-qxfer-siginfo-read
+	      run-gdbstub-qxfer-siginfo-read \
+	      run-gdbstub-thread-breakpoint-stress
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint-stress.py b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint-stress.py
new file mode 100644
index 00000000000..489d238f02d
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint-stress.py
@@ -0,0 +1,28 @@
+"""Test multiple threads hitting breakpoints.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+N_BREAK_THREADS = 2
+N_BREAKS = 100
+
+
+def run_test():
+    """Run through the tests one by one"""
+    if gdb.selected_inferior().architecture().name() == "MicroBlaze":
+        print("SKIP: Atomics are broken on MicroBlaze")
+        exit(0)
+    gdb.execute("break break_here")
+    gdb.execute("continue")
+    for _ in range(N_BREAK_THREADS * N_BREAKS):
+        counter1 = int(gdb.parse_and_eval("s->counter"))
+        counter2 = int(gdb.parse_and_eval("s->counter"))
+        report(counter1 == counter2, "{} == {}".format(counter1, counter2))
+        gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
diff --git a/tests/tcg/multiarch/thread-breakpoint-stress.c b/tests/tcg/multiarch/thread-breakpoint-stress.c
new file mode 100644
index 00000000000..1feed8577aa
--- /dev/null
+++ b/tests/tcg/multiarch/thread-breakpoint-stress.c
@@ -0,0 +1,92 @@
+/*
+ * Test multiple threads hitting breakpoints.
+ *
+ * The main thread performs a lengthy syscall. The test verifies that this
+ * does not interfere with the ability to stop threads.
+ *
+ * The counter thread constantly increments a value by 1. The test verifies
+ * that it is stopped when another thread hits a breakpoint.
+ *
+ * The break threads constantly and simultaneously hit the same breakpoint.
+ * The test verifies that GDB and gdbstub do not lose any hits and do not
+ * deadlock.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <pthread.h>
+#include <stdlib.h>
+
+struct state {
+    int counter;
+    int done;
+    pthread_barrier_t barrier;
+    int break_counter;
+};
+
+static void *counter_loop(void *arg)
+{
+    struct state *s = arg;
+
+    while (!__atomic_load_n(&s->done, __ATOMIC_SEQ_CST)) {
+        __atomic_add_fetch(&s->counter, 1, __ATOMIC_SEQ_CST);
+    }
+
+    return NULL;
+}
+
+#define N_BREAK_THREADS 2
+#define N_BREAKS 100
+
+/* Non-static to avoid inlining. */
+void break_here(struct state *s)
+{
+    __atomic_add_fetch(&s->break_counter, 1, __ATOMIC_SEQ_CST);
+}
+
+static void *break_loop(void *arg)
+{
+    struct state *s = arg;
+    int i;
+
+    pthread_barrier_wait(&s->barrier);
+    for (i = 0; i < N_BREAKS; i++) {
+        break_here(s);
+    }
+
+    return NULL;
+}
+
+int main(void)
+{
+    pthread_t break_threads[N_BREAK_THREADS], counter_thread;
+    struct state s = {};
+    int i, ret;
+
+#ifdef __MICROBLAZE__
+    /*
+     * Microblaze has broken atomics.
+     * See https://github.com/Xilinx/meta-xilinx/blob/xlnx-rel-v2024.1/meta-microblaze/recipes-devtools/gcc/gcc-12/0009-Patch-microblaze-Fix-atomic-boolean-return-value.patch
+     */
+    return EXIT_SUCCESS;
+#endif
+
+    ret = pthread_barrier_init(&s.barrier, NULL, N_BREAK_THREADS);
+    assert(ret == 0);
+    ret = pthread_create(&counter_thread, NULL, counter_loop, &s);
+    assert(ret == 0);
+    for (i = 0; i < N_BREAK_THREADS; i++) {
+        ret = pthread_create(&break_threads[i], NULL, break_loop, &s);
+        assert(ret == 0);
+    }
+    for (i = 0; i < N_BREAK_THREADS; i++) {
+        ret = pthread_join(break_threads[i], NULL);
+        assert(ret == 0);
+    }
+    __atomic_store_n(&s.done, 1, __ATOMIC_SEQ_CST);
+    ret = pthread_join(counter_thread, NULL);
+    assert(ret == 0);
+    assert(s.break_counter == N_BREAK_THREADS * N_BREAKS);
+
+    return EXIT_SUCCESS;
+}
-- 
2.46.0


