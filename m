Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA328CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt86-00023X-02; Mon, 08 Apr 2024 13:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt84-00022m-D1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:00 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt82-0003gS-Mb
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:00 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so153428a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598597; x=1713203397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZCdplx5RAU+rQd70pAqgPB6t58CmgDisH5Rp3Z9tsr4=;
 b=fDxPkqcGoW7EYI+62FkYQmO2yNCK1du+fqg/2x2iqqrsQYhLMa7XltW6ZCrV+O9wJZ
 Rhb2j1rc9QQym2NTo9cB3styhCJIaXHaZuQBoAHC8+tLiNBgQICf/O6bljD/R/Pdocmo
 XZzYKNv4k4evoKeSkShHIEDv4ZHs0kEoZY/SLb0Ryk5cu1BXJU6MzDzAh9QrXx1Jfz8b
 rVSNRRq9t9YW+C5tWNW8mxGXv9uJP2tV/9ttQG/t5UMJa7+FxXa1oNMZIJ1XgEyInimD
 dICxGl4gYekrHWAenqCVEgLh+fkr32QQv7kwasqPY2ZvvTc7fivFu2F8Mzxdk3maE4oV
 xE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598597; x=1713203397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCdplx5RAU+rQd70pAqgPB6t58CmgDisH5Rp3Z9tsr4=;
 b=Nfj3wPuRKn06LNqlcZkORyGbiot+trPTkhxFNbngJE5JVWB5DAHEce5OLWZ/KoGV++
 xYXWxuKzRMyQ+wC0AJYzKzY+tVfneycdy5DxJ8nY3RgwJtOj2OiOQN2EotpWKVgHDaYX
 Ihyqzjxj6dFQ8J4MNjHh8uaNcCOstZmkpxL9AzJOMUe3+r7KWv//Gy1y5gQ8ZP/1TUXn
 QIaprGVpOxFj1RPFnaFUfcX/YsWWJQ3EhZ11PlH9epeeYTLeasQq+EaSaeZEfb9o5jjz
 gSYoYKDxhjou1dIBYz+/ZfdRTqCSGL0A7o6ed/DeglficgyERAy2OH12OvOZRIIwFdGK
 tfwQ==
X-Gm-Message-State: AOJu0Yyn9P67CCUdjrVd61DCuen1Otdyc/0xRFblMO3CiaC9CBJsN5pa
 5iISJq+LZ4AUIdr4v0zLNeAz6QbFePujQLm5N1vKyq9zkImkIshLql+ZYjlGdbs8mvjYqUzdhK7
 s
X-Google-Smtp-Source: AGHT+IHmrmbVHb3i4cw5ajrp6zEP61C0Ho0d1Lcut2YTJDrEZQC0ck0zNwcTIwFqPujJZYUt6V4aaQ==
X-Received: by 2002:a17:90b:400b:b0:2a2:d8d6:fc3a with SMTP id
 ie11-20020a17090b400b00b002a2d8d6fc3amr7393024pjb.37.1712598596971; 
 Mon, 08 Apr 2024 10:49:56 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/35] target/m68k: Perform the semihosting test during
 translate
Date: Mon,  8 Apr 2024 07:49:11 -1000
Message-Id: <20240408174929.862917-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Replace EXCP_HALT_INSN by EXCP_SEMIHOSTING.  Perform the pre-
and post-insn tests during translate, leaving only the actual
semihosting operation for the exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h       |  2 +-
 target/m68k/op_helper.c | 14 ++-----------
 target/m68k/translate.c | 45 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index e184239a81..b5bbeedb7a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -66,7 +66,7 @@
 #define EXCP_MMU_ACCESS     58  /* MMU Access Level Violation Error */
 
 #define EXCP_RTE            0x100
-#define EXCP_HALT_INSN      0x101
+#define EXCP_SEMIHOSTING    0x101
 
 #define M68K_DTTR0   0
 #define M68K_DTTR1   1
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 125f6c1b08..15bad5dd46 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -202,18 +202,8 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
             /* Return from an exception.  */
             cf_rte(env);
             return;
-        case EXCP_HALT_INSN:
-            if (semihosting_enabled((env->sr & SR_S) == 0)
-                    && (env->pc & 3) == 0
-                    && cpu_lduw_code(env, env->pc - 4) == 0x4e71
-                    && cpu_ldl_code(env, env->pc) == 0x4e7bf000) {
-                env->pc += 4;
-                do_m68k_semihosting(env, env->dregs[0]);
-                return;
-            }
-            cs->halted = 1;
-            cs->exception_index = EXCP_HLT;
-            cpu_loop_exit(cs);
+        case EXCP_SEMIHOSTING:
+            do_m68k_semihosting(env, env->dregs[0]);
             return;
         }
     }
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 8a194f2f21..8f61ff1238 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -26,12 +26,11 @@
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
 #include "exec/translator.h"
-
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
 #include "exec/log.h"
 #include "fpu/softfloat.h"
+#include "semihosting/semihost.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -1401,6 +1400,40 @@ static void gen_jmp_tb(DisasContext *s, int n, target_ulong dest,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool semihosting_test(DisasContext *s)
+{
+    uint32_t test;
+
+    if (!semihosting_enabled(IS_USER(s))) {
+        return false;
+    }
+
+    /*
+     * "The semihosting instruction is immediately preceded by a
+     * nop aligned to a 4-byte boundary..."
+     * The preceding 2-byte (aligned) nop plus the 2-byte halt/bkpt
+     * means that we have advanced 4 bytes from the required nop.
+     */
+    if (s->pc % 4 != 0) {
+        return false;
+    }
+    test = cpu_lduw_code(s->env, s->pc - 4);
+    if (test != 0x4e71) {
+        return false;
+    }
+    /* "... and followed by an invalid sentinel instruction movec %sp,0." */
+    test = translator_ldl(s->env, &s->base, s->pc);
+    if (test != 0x4e7bf000) {
+        return false;
+    }
+
+    /* Consume the sentinel. */
+    s->pc += 4;
+    return true;
+}
+#endif /* !CONFIG_USER_ONLY */
+
 DISAS_INSN(scc)
 {
     DisasCompare c;
@@ -4465,8 +4498,12 @@ DISAS_INSN(halt)
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
-
-    gen_exception(s, s->pc, EXCP_HALT_INSN);
+    if (semihosting_test(s)) {
+        gen_exception(s, s->pc, EXCP_SEMIHOSTING);
+        return;
+    }
+    tcg_gen_movi_i32(cpu_halted, 1);
+    gen_exception(s, s->pc, EXCP_HLT);
 }
 
 DISAS_INSN(stop)
-- 
2.34.1


