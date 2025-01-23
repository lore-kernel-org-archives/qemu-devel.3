Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DA0C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5C2-00050r-KR; Thu, 23 Jan 2025 16:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bz-00050R-S0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bx-0002nV-3a
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso16944995e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669407; x=1738274207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvU1L8TmR0niaHN7D1u6sbhbe7T6PjXXRojbsrJxUGY=;
 b=KkrJfLjsxVHZL9c9A6c9GdtH6AWbOoHC2eSiIYS2MDMbtmT+DNqO3AdK5kZhaKNwnm
 +kbwK9q4M+0+tTlZRi1vbPiu5zm9qhRAlrMWFN4uWKkvE13YAMvKCmfNh36IXYlCe3Jq
 Ri/cDLjm+RI64fxSTPCI7PujAf9jHI5MbrdM8bLuJWsNbmXwf6ysvAjSYhn5XGXVH824
 0GKQEOBGq44NTBocZ3L+sSRUhwecq+c8+ldm7fJz6kVe0iLrQWZaayULTyb0ICpu13+i
 zn3FzO829wjmGJSoESjGpSeI3lAh1f8xS5DD02EsYZa47mpCdCm0wBnEQAZUwqjkTlVR
 +ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669407; x=1738274207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvU1L8TmR0niaHN7D1u6sbhbe7T6PjXXRojbsrJxUGY=;
 b=lQRTFt+YXBJqUz7YKS8zJwW3r13cq4EgBuAEUMSeE7n9vgIohJT37ZCB+5Uj24KbgI
 Tu6nzTJ6NKn3ay5tzcSVGJ7iQO2OpIlOPLrIxvx0Vt3Yu2RMMNDuM1Lcll3Z/guDuHJe
 sVNqermIPcL5bjEY2nIlIkRZVAe4Slmxf/8U1GZIy3bDI9CpAu0/Vgf7iWTa9GIjAe3Z
 akQAsYK4PsZD8TkHt7Yvg5nrulc3TO7p167zkc9qM0Ens+Quq736s4S9XaaANsLkueDI
 oVtG8vj9LPdIdo83XV7LZSVnCsfXSFeBPIDRIzHCJLmEudZJosStdfHKrH7Mi6iNHOyx
 gK6w==
X-Gm-Message-State: AOJu0YwHP2dzxnxmY2bqpirXgMXZ+hLkmHSOCXBQOyP6hkjaTRFzyQ0K
 THatcz9slzN6bIhJmiiKu9FWcKFrjeEss83/+rzeGSwjuKmeVSfHmcoeWgWJMSj60C7YLoDKPOl
 DL2Y=
X-Gm-Gg: ASbGncuvBV8NYhULjz1kCMXRe1aeEI8hIks3oI5wasuiZ0QEg5G2zz82z9Te0kSoYxl
 dkYCciplofVRWE4+u3iK8DzbGroO3ZIGGsuLLIH8GmcJTtzn+psXmpM6DIAA23Wq6+VQN+eYHG9
 6s9ZLj+xcEJ/34V/2YBA6f4DFcMBRzFjvgH1XdSetGJXx7w064QPMBZSiQmdR6HEFaRK/9qms+k
 AG7D5lY5mLTTCHwJskDeaOmKJLiYMPFDZI6OoDQJP9OUUqlfWpWFqBGbOWjwSj0hLdMBZargPHs
 Xv5GHarLccO8ZxVf036FjxtSdACVp+D+WkXARsTLgK3/aCk5Q0MRU7Q=
X-Google-Smtp-Source: AGHT+IGbzPxJjvXP/fCRle4WjnAxFBAfgBADckTSTYV23PC+KGaIgqHmd5WqM1x5xWkAtwp1tSZjpQ==
X-Received: by 2002:adf:e50d:0:b0:38a:8d32:272d with SMTP id
 ffacd0b85a97d-38c2227d072mr4559041f8f.28.1737669407245; 
 Thu, 23 Jan 2025 13:56:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764desm805629f8f.9.2025.01.23.13.56.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/15] target/ppc: Restrict powerpc_checkstop() to TCG
Date: Thu, 23 Jan 2025 22:56:01 +0100
Message-ID: <20250123215609.30432-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Expose powerpc_checkstop() prototype, and move it to
tcg-excp_helper.c, only built when TCG is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h        |  2 ++
 target/ppc/excp_helper.c     | 26 --------------------------
 target/ppc/tcg-excp_helper.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 46db6adfcf6..42e33be496f 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -289,6 +289,8 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 void ppc_cpu_debug_excp_handler(CPUState *cs);
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
+
+G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
 #endif
 
 FIELD(GER_MSK, XMSK, 0, 4)
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b08cd53688c..236e5078f56 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -400,32 +400,6 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 }
 
 #ifdef CONFIG_TCG
-/*
- * This stops the machine and logs CPU state without killing QEMU (like
- * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
- * so the machine can still be debugged.
- */
-static G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
-{
-    CPUState *cs = env_cpu(env);
-    FILE *f;
-
-    f = qemu_log_trylock();
-    if (f) {
-        fprintf(f, "Entering checkstop state: %s\n", reason);
-        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
-        qemu_log_unlock(f);
-    }
-
-    /*
-     * This stops the machine and logs CPU state without killing QEMU
-     * (like cpu_abort()) so the machine can still be debugged (because
-     * it is often a guest error).
-     */
-    qemu_system_guest_panicked(NULL);
-    cpu_loop_exit_noexc(cs);
-}
-
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 void helper_attn(CPUPPCState *env)
 {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 6950b78774d..93c2d6b5a03 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -17,7 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "exec/cpu_ldst.h"
+#include "system/runstate.h"
 
 #include "hw/ppc/ppc.h"
 #include "internal.h"
@@ -199,6 +201,32 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
+/*
+ * This stops the machine and logs CPU state without killing QEMU (like
+ * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
+ * so the machine can still be debugged.
+ */
+G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
+{
+    CPUState *cs = env_cpu(env);
+    FILE *f;
+
+    f = qemu_log_trylock();
+    if (f) {
+        fprintf(f, "Entering checkstop state: %s\n", reason);
+        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_unlock(f);
+    }
+
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+    qemu_system_guest_panicked(NULL);
+    cpu_loop_exit_noexc(cs);
+}
+
 /* Return true iff byteswap is needed to load instruction */
 static inline bool insn_need_byteswap(CPUArchState *env)
 {
-- 
2.47.1


