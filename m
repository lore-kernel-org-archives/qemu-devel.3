Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A711C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSk-00070t-4m; Wed, 24 Apr 2024 18:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSi-0006yM-E4
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSg-0006h3-K5
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ee0642f718so1140591b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999093; x=1714603893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N1Fb/iLBacLjG+JYW3VIwBtHrdP9tAIF5ogLnK/WoGA=;
 b=gXL7aYadEgiP2R7/QB5RSLbcPfaEMqT0uSwshd+3qtx3EVwMGft3oW0Qc6GSZpRtor
 4XAH8PS/1o69MvDZH2xVP8Zil1lcoAE26fxhNQi384GW1mOU7U8W6wm6G8REQy9FX+E/
 5IcbwEtjKgY3Z0qrloB7FczCj2CTB02Y5EGsDt3IosB+OWRhkZfWtAt7HebEiuBaD+XI
 0VY0jwhjt4i2/qWgbDusqm9RcySHfw322k/CMqJQLLKauEHZ4ww6cyzDvKWENtfhxxG1
 kOCTK32P9iQlf/GV15MS1otRwvQFGSS1sIUytVoJw4HfXMG/3OC1TqvYS6LQF/6LUiLG
 ckYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999093; x=1714603893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1Fb/iLBacLjG+JYW3VIwBtHrdP9tAIF5ogLnK/WoGA=;
 b=nYqZ0vqakZmv8m5PePkiaB3RanK0U7VcN6pkXVBJkGcW0V+4ltWOEKTAg+c8k7ldsC
 2Md2eZ1jNaKqME8QAk6f7WQ1PbIEMNV85yhrorj39PyeUG1etQotWeJGRwwEmveU0rtv
 A2eLIzoZEAvl6W7OfrtV2vcsoyaKcYkRjylUM7R7kGTmEtBi1WXZ5f4v9ughi7O4+PHh
 hjIwUokk385Bs4Uc+FYodvXBUF4IMGM7b8Z4cfblEYZAJHw7hKUJOmFKWTetVF9LSsLV
 nR9jL2f6ymY8I+DTKxo67V00fzBRzGj0Ql87aSphoHKWoiMvdPYfr2diNYy4QNw8V6VN
 318w==
X-Gm-Message-State: AOJu0YxvPI6ZnguqeMGCy3YWMEfOaa6BQRfZBOTJQQIMuVcby1yzYHxb
 5SvJBwZybC9QTjATyyWKRx//+eQc+Mw3tbP+A9Q+z9inDymT0feecCixv+Bo7EWUDSvr6ln+7Nf
 1
X-Google-Smtp-Source: AGHT+IFfbmk//iNHRmpl0Jb3mZsOIbCi2khvtXpct3hGDCdjI6bkGhfNcPuGIKEcEyY7h/GqlEF1zQ==
X-Received: by 2002:a05:6a20:9190:b0:1a9:9839:f142 with SMTP id
 v16-20020a056a20919000b001a99839f142mr1675127pzd.10.1713999093218; 
 Wed, 24 Apr 2024 15:51:33 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] target/m68k: Perform the semihosting test during translate
Date: Wed, 24 Apr 2024 15:51:22 -0700
Message-Id: <20240424225123.929152-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
index 8a194f2f21..647bd9d9be 100644
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
+    test = translator_lduw(s->env, &s->base, s->pc - 4);
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


