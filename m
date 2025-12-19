Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58751D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfrO-0001hp-2u; Fri, 19 Dec 2025 14:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqX-0000cg-Mz
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:03 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqU-0006po-K5
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:01 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so13771145e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171337; x=1766776137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBlglM9JFPWM18boH0BMxZfCeA1juo9itb3ve4H0EqE=;
 b=Getzhc+vfwMNOdf7+cOOBa2HK6PyGN5FNOsLdHP6pgE75RDSf8BaAcMCtOlFrSoHK6
 XoBdq32Yt/hFSEgqmKNCHu5FZJB1VrUxWCjUABcH4YuKpNRQXi+TUpGCEi92osko9f38
 Eit3uaK2n/WpZhxbDjQ4fobVez3PbzjtG/NEY2RfbuXvYYSHA7IPWpXvH78BNIH9bOmv
 gcDGXtyU0b4UULM0AsDMwjSmVZffyVW0NzbnAlskg7m469/3KwMuaPL7E5AgDUTc8bDM
 hBc29ZuZ/Xxm00I6stgNkJfxmbtmWGjuBJC31zSGfCRdHWSpEVkEVnG8Qtwhf8dS/IvM
 uVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171337; x=1766776137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LBlglM9JFPWM18boH0BMxZfCeA1juo9itb3ve4H0EqE=;
 b=N7t9EpI9S7jiuRQVzabtzaXIsyy8UMK1RyarEJCIAoWOvwK3RuLwhmF+UuSO7G+HOC
 6d1eqW3t0iHOOL6ZDOiHI3ljRmHrI7BC3zMw8YmLJ+ijYi7L3+P0jwFSyKDxfUc9PIPT
 3DWGJ2m0zE5o1TPBraWXgSP8yBgerfhJYSxxdHegjNK4hQYpxUudq/tb+e45RuICpY/p
 7t+zWcE4OGh1eAwUKzj5IcFbWxyKkPplPN+JMSImzSzA2KOPXk4hJXnJSn747CPgBXoc
 DZOzBQUctqKuz8GiCvDBr3nqO8EXUlnpFiyHYsOeMJ3goIa15ZKSGR/qAKaot3v/U56r
 zQAg==
X-Gm-Message-State: AOJu0Yxy+TjZnrg1zh2j+nW7sqmG+0kFSR0IXIGZeJ826jU21VBfvc6a
 +oL6W6CpxfOOXczOBlOGpsSGcdYkWaFtoma3fs28wtOcn6g8XDv6PiRgPcsCTvtsf2U=
X-Gm-Gg: AY/fxX5wnM4f8SWw0tg2IZbJVYP1JqIfD54nV7ZJefG3YB0BFYpNJsAJa79nqC3hPP5
 ODYITDGn/KV8jaMHrgfFdZukRFHauvu9zMxSBTXfhtszJcWj3n/5uY9yxVUR2F06p1PMwfsh56r
 mihctf+v1oJv20tcch78lSIWHz9W1OvnHa929VU9grPihflw46ozcTurqneAND142mU0zkb/Dv6
 VPEF8CgY+wYk514YTZI6HNXzjZXKcqWHJbkkZyD4yk1xtVupfOUfCX+H0SXumiLkDZ3+esnkmvM
 KyqEEuT7uFM5fyv2TyW+PGxfSWWPq3NG6RU5+qOjebXbLQWmb9GJ08yRw/wt94ID4rPrswYsl+u
 SGTkKkZNVNvmaSObmonzuRsVRi/QaQqEsPM2XysaBosZ69xVjB3yokWUok3vcMiLpcXRkRRbs71
 H7MOk2FaMaYj0=
X-Google-Smtp-Source: AGHT+IHGZUtcKQEtS4/zvWBFpofDj83AL78J2684Q/jk7+NYYE7bRgd9WFFHNkJyGywnxsCEdbN5ig==
X-Received: by 2002:a05:600c:c167:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-47d194c1e99mr39312485e9.0.1766171336924; 
 Fri, 19 Dec 2025 11:08:56 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm55343155e9.2.2025.12.19.11.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0619600FE;
 Fri, 19 Dec 2025 19:08:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>
Subject: [RFC PATCH 08/12] tcg tests: add a test to verify the syscall filter
 plugin API
Date: Fri, 19 Dec 2025 19:08:45 +0000
Message-ID: <20251219190849.238323-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

Register a syscall filter callback in tests/tcg/plugins/sycall.c,
returns a specific value for a magic system call number, and check
it in tests/tcg/multiarch/test-plugin-syscall-filter.c.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251214144620.179282-3-functioner@sjtu.edu.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../multiarch/test-plugin-syscall-filter.c    | 35 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   | 19 ++++++++++
 tests/tcg/multiarch/Makefile.target           |  4 ++-
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c

diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
new file mode 100644
index 00000000000..caa2063a461
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
index 42801f5c863..e7d4e9b5895 100644
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
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f5b4d2b8138..4005e3a8a9a 100644
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
-- 
2.47.3


