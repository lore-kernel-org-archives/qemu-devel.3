Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB51D73E85
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyR-0004nF-Nh; Thu, 29 Jan 2026 12:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyN-0004XI-RG
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:27 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyL-0000eg-G3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:27 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8230c2d3128so723709b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708304; x=1770313104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsztMEzgZHZfrQRWYcQj4QjAMuO/MHTF7LJ1DZnGjY4=;
 b=lOtQiemX53Kg1b/00ZpCtTdBPBp1rcvT2fw0WweXqK45Bi1BxmkLMvJk2ZVQo3r0VT
 ByuhY+PMwjGX1YlXracPemnxYa0OszmJPqJaLklyrripJ4qmRzQGCHwQnHc/BJzGFVcq
 Joi6WazX5+nf128N5q9k2G1FvwV9lYZMfZo0emEaqUghd31IRmgNTxtMWxZPWnj24Qqn
 ajk+S2RK0bJdUKteaVvNb2yQYFX5LGBvaG8cVkjvKqtkPYoVMM0JFWf2FDfqQXYJ8uDr
 G8IPtN9rIIDsiJpZedAffg5g2Yn35VpaA77hhCTkjQav7qi9cU2Jxmp1ndF9x1rUe0cJ
 DuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708304; x=1770313104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jsztMEzgZHZfrQRWYcQj4QjAMuO/MHTF7LJ1DZnGjY4=;
 b=NjtrAxCj22jehvkJFLZQ5azNt/v0iMP+50Buzx+efSIj7jsKG8PJIBZWjoZNUgCkHX
 aa02s/eHmtcntNT1OGeBB0CxQxTGTAYhfINJ/X2T58eG57rcmQ8S7OB0ymbgNLB6izdn
 sFbZh2KReJrIAAI0YFSr8CV/lhwVkioqt3q6Jj9p4/j8IPYMA/RosmZUmsdGZ8XTOFJ/
 Z1ixfE1VG7mb7SM+u4+aUhZ5/P6WHNOhPRCSEilt9+bnHYHuG+ORzB4Z/Q51DmLZBYkt
 7zy5Z+TyukiuBKDrzsizhNvgmVP9fDSswbAcZoV60G+tt/f2SopSR0u4bPKUKw2eQ4Ze
 z8og==
X-Gm-Message-State: AOJu0YzpvwKgIJ5PWm6oGIgpOnK91FyU3onsA4hOViwQTqJW3V7Cgfs3
 O1jDq8ru0Njb63zbb4E1tRItdiic6Azclvdqguz6lYA8y4gKjXi0ElyH47fWIaNtXX1Torr/nOB
 VApi0
X-Gm-Gg: AZuq6aINpq6NiwxrCcBrvQ7vAgNgAgo+PIoQSWQUVcOu8+EQrqxSlQIe3DUp2ScGSM9
 mKlgsx8Nen2TIo8rN+lIS7A2SBR9D5KVgKEhIHrieroRt9m7geOWMCX7zLy+9TPok3+LyXkoyhA
 aOQnGGEeZsvISfDzylEyATfQfkuWpBaiQuNjIvSA+l8VtJiSXMoG9YPa7J69aiSU48R7jTvA3rw
 yWptriHG96wUuDvfSPvWgfXePmY4cYY5nhoZiQTaYTDsH67aof8GrLHLymY+FKAFRVdd+4cG510
 ezNTLezajWW3jgsFXxceyd/A4HUtVPeL25uje2bKzF1X/Ow6grcU7Iphbl2SP0Hyefamz+zykfY
 A73rW4btinV/wdOCprhckXhSczskkjuD+Rggu97sMtpsKZ37lv+okjQ17uyjk/6NfGrYhmUbNVq
 dO39bSyZmeRiecDl3KleC+452rhtA6zSCKKNPJP2jaDE4oTF8YR/qSspgSWmdOu+3P
X-Received: by 2002:a05:6a20:a106:b0:38e:9b5d:dc2c with SMTP id
 adf61e73a8af0-38ec62dddf8mr9506633637.17.1769708303918; 
 Thu, 29 Jan 2026 09:38:23 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:23 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/21] tcg tests: add a test to verify the syscall filter
 plugin API
Date: Thu, 29 Jan 2026 09:37:54 -0800
Message-ID: <20260129173811.138036-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

Register a syscall filter callback in tests/tcg/plugins/sycall.c,
returns a specific value for a magic system call number, and check
it in tests/tcg/multiarch/test-plugin-syscall-filter.c.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
[Pierrick - Changed syscall number to 4096 to make it work with mips32]
[Pierrick - Skip test when compiling without plugins enabled]
Link: https://lore.kernel.org/qemu-devel/20251214144620.179282-3-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 .../multiarch/test-plugin-syscall-filter.c    | 39 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   | 19 +++++++++
 tests/tcg/multiarch/Makefile.target           |  7 +++-
 3 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c

diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
new file mode 100644
index 00000000000..951e338a7c9
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
@@ -0,0 +1,39 @@
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
+#ifdef SKIP
+    return EXIT_SUCCESS;
+#endif
+    /*
+     * We cannot use a very large magic syscall number, because on some ISAs,
+     * QEMU will treat it as an illegal instruction and trigger a critical
+     * exception. For instance, on arm32, the syscall number cannot exceed
+     * ARM_NR_BASE (0xf0000), as can be seen in
+     * "linux-user/arm/cpu_loop.c:cpu_loop".
+     * As well, some arch expect a minimum, like 4000 for mips 32 bits.
+     *
+     * Therefore, we pick 4096 because, as of now, no ISA in Linux uses this
+     * number. This is just a test case; replace this number as needed in the
+     * future.
+     *
+     * The corresponding syscall filter is implemented in
+     * "tests/tcg/plugins/syscall.c".
+     */
+    long ret = syscall(4096, 0x66CCFF);
+    if (ret != 0xFFCC66) {
+        fprintf(stderr, "Error: unexpected syscall return value %ld\n", ret);
+        return EXIT_FAILURE;
+    }
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 42801f5c863..5658f830879 100644
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
+    if (num == 4096 && a1 == 0x66CCFF) {
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
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f5b4d2b8138..07d0b27bdd3 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,13 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
 	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
 	$(QEMU) $<
+run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
+			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
+else
+# test-plugin-syscall-filter needs syscall plugin to succeed
+test-plugin-syscall-filter: CFLAGS+=-DSKIP
 endif
 
 # Update TESTS
-- 
2.47.3


