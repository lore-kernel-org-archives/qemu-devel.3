Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1FDD59D99
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Dec 2025 14:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUnNR-00082d-1f; Sun, 14 Dec 2025 09:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vUnNO-00082V-IN
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 09:47:10 -0500
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vUnNK-0002C3-1t
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 09:47:10 -0500
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 8A2E5100A5566;
 Sun, 14 Dec 2025 22:46:23 +0800 (CST)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6A72837C964;
 Sun, 14 Dec 2025 22:46:23 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH v4 2/2] tcg tests: add a test to verify the syscall filter
 plugin API
Date: Sun, 14 Dec 2025 22:46:20 +0800
Message-Id: <20251214144620.179282-3-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251214144620.179282-1-functioner@sjtu.edu.cn>
References: <20251214144620.179282-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp232.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Register a syscall filter callback in tests/tcg/plugins/sycall.c,
returns a specific value for a magic system call number, and check
it in tests/tcg/multiarch/test-plugin-syscall-filter.c.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
---
 tests/tcg/multiarch/Makefile.target           |  4 ++-
 .../multiarch/test-plugin-syscall-filter.c    | 35 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   | 19 ++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f5b4d2b813..4005e3a8a9 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,10 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
 	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
 	$(QEMU) $<
+run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
+			   			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
 endif
 
 # Update TESTS
diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
new file mode 100644
index 0000000000..caa2063a46
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
@@ -0,0 +1,35 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test attempts to execute a magic syscall. The syscall test plugin
+ * should intercept this and return an expected value.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+    /*
+     * We cannot use a very large magic syscall number, because on some ISAs,
+     * QEMU will treat it as an illegal instruction and trigger a critical
+     * exception. For instance, on arm32, the syscall number cannot exceed
+     * ARM_NR_BASE (0xf0000), as can be seen in
+     * "linux-user/arm/cpu_loop.c:cpu_loop".
+     *
+     * Therefore, we pick 2048 because, as of now, no ISA in Linux uses this
+     * number. This is just a test case; replace this number as needed in the
+     * future.
+     *
+     * The corresponding syscall filter is implemented in
+     * "tests/tcg/plugins/syscall.c".
+     */
+    long ret = syscall(2048, 0x66CCFF);
+    if (ret != 0xFFCC66) {
+        fprintf(stderr, "Error: unexpected syscall return value %ld\n", ret);
+        return EXIT_FAILURE;
+    }
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 42801f5c86..e7d4e9b589 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -170,6 +170,24 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
     }
 }
 
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    /* Special syscall to test the filter functionality. */
+    if (num == 2048 && a1 == 0x66CCFF) {
+        *sysret = 0xFFCC66;
+
+        if (!statistics) {
+            qemu_plugin_outs("magic syscall filtered, set magic return\n");
+        }
+        return true;
+    }
+    return false;
+}
+
 static void print_entry(gpointer val, gpointer user_data)
 {
     SyscallStats *entry = (SyscallStats *) val;
@@ -255,6 +273,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
-- 
2.34.1


