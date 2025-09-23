Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6035ECAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay2-0006Iq-A8; Tue, 23 Sep 2025 17:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay0-0006Ha-De
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:32 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Axx-0003i8-WB
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:31 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-267fac63459so57534235ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664468; x=1759269268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZamIB9qOqLDXfHWztLFTsDY1Wf4aDJfUVKiJDrru8TA=;
 b=NP3LyLsc82v/I5+Hjom25xl/WszN0Z4g84X+yiQW/Wbx5SkbA3BcYgiY3hNBUciyrA
 Xt+fITrASCb7FdkJJZSszdV8FQ+zuvOMxc8WD6c6GcN1ocJG6IkQrfkW0xYA8AQGs6II
 fZI2NpQebQ6knUleT2ZA/wBRHjo0gxp2IcR7AY4VKrEI5wqicoGHcSrdZogKDEvVvnki
 c1McIFvgoeM4SWkIrVg9MJePqCDNxnC8eRpK/R6jMa6GwO5snTRfzmLqRhGeCr5UdWjE
 0MbEJqV9hsNNwsYl7iLVQoP3MSK2+YpMHFRp5vL9DMnvhEvKbfb4KoTE3bTfs1MNJFbE
 9Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664468; x=1759269268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZamIB9qOqLDXfHWztLFTsDY1Wf4aDJfUVKiJDrru8TA=;
 b=CDil/fAm6DDoxzGRKvGXToxPasMfC02mbVNSVypf24jfp7Huyu266tCbCvmxAH98Jq
 4BRnbGtWOtK+xoSMpJUvkkUeOksHbpniHYNe0UQqFpaifscZQ939tQE2SEZxZ1HyJj62
 xCAE7P4+jOFW6V/SlM3Kmt7H5IubuIg9b7U9DzbOEvVz7pMziOUEIGaeC/xu8tGg3Fmb
 9Jt2q6RmiZiRZBmpSqb5Kctw5rlodhWWznOtDwpmBwk6u9mZVcntErlRbEJuC8PHozDg
 QEoZrWcmzDgQjW5cq6fZVT9g475m0xYLJRBg0VoEjIrCKofQ/yFOMo9nrXSt26DmlKc6
 hXjQ==
X-Gm-Message-State: AOJu0YwF6uNqO9RunRyP/oWIY+bwXPb3kmY+9dE3RHmV0wLE1dxkahAI
 g1YIiDnUJWIjnIeYgm2BpPZCXpCuuhZJIZd5lLWpSoSHK+r1xnLXzfc53yqao24jWFKFn7uu3IU
 B1PCr
X-Gm-Gg: ASbGnct/EaM9hgtlRXxM42gM5ZFWwI2GVSJMhJ959QLZQtqZckhrZ6MTDK6UIpnB3+F
 0cRRt/c8Ll9rIwYcpGMI8Ca4yeV32C+2uJAOYUdqg8L/7zgvk+IL1tCpDk0Pd/DJnT40jT2rWwG
 VKdUTWdHUcAKXzh3Ce32cJxyJ8LBv+yH+cPWfDSdqChTrSQw8V65DlO9UK4NnRry7SxoDyTXied
 JQ+8lXbBrFclddCfnL8m+bztix2dClMvEX3hzXmBl9fXOgFiRzwMN0Ehi4zhLr8k2rQjP1py51X
 yPyTF4M1q6KFq+/PG1jHQDjJINStHWO+nnit9yzvujUguKOlc6UFCf6o1XZJi+cuIHOh9RYXYT/
 5/YhNZ05zGBimxWul6wWFOcx+G92v
X-Google-Smtp-Source: AGHT+IH+c5Yk+YV6LrcH+gh1k70ihRRGyDu721kqleWbyAhx5u+mjm0kl0vz6F5eZByJEj6mfD1GRQ==
X-Received: by 2002:a17:903:1107:b0:267:b0e4:314e with SMTP id
 d9443c01a7336-27cc2c9a0c3mr51670835ad.23.1758664468282; 
 Tue, 23 Sep 2025 14:54:28 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/10] target/alpha: Simplify call_pal implementation
Date: Tue, 23 Sep 2025 14:54:16 -0700
Message-ID: <20250923215425.3685950-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Since 288a5fe980f, we don't link translation blocks
directly to palcode entry points.  If we load palbr
from env instead of encoding the constant, we avoid
all need for tb_flush().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.h       |  1 -
 linux-user/alpha/cpu_loop.c |  5 -----
 target/alpha/sys_helper.c   |  6 ------
 target/alpha/translate.c    | 21 ++++++---------------
 4 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index d60f208703..788d2fbf28 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -90,7 +90,6 @@ DEF_HELPER_FLAGS_2(ieee_input_s, TCG_CALL_NO_WG, void, env, i64)
 #if !defined (CONFIG_USER_ONLY)
 DEF_HELPER_FLAGS_1(tbia, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, i64)
-DEF_HELPER_FLAGS_1(tb_flush, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_1(halt, void, i64)
 
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index bb8346b509..f93597c400 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -94,11 +94,6 @@ void cpu_loop(CPUAlphaState *env)
                 break;
             case 0x86:
                 /* IMB */
-                /* ??? We can probably elide the code using page_unprotect
-                   that is checking for self-modifying code.  Instead we
-                   could simply call tb_flush here.  Until we work out the
-                   changes required to turn off the extra write protection,
-                   this can be a no-op.  */
                 break;
             case 0x9E:
                 /* RDUNIQUE */
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 51e3254428..87e37605c1 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/tb-flush.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -38,11 +37,6 @@ void helper_tbis(CPUAlphaState *env, uint64_t p)
     tlb_flush_page(env_cpu(env), p);
 }
 
-void helper_tb_flush(CPUAlphaState *env)
-{
-    tb_flush(env_cpu(env));
-}
-
 void helper_halt(uint64_t restart)
 {
     if (restart) {
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index cebab0318c..f11b382438 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -48,8 +48,6 @@ struct DisasContext {
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
-#else
-    uint64_t palbr;
 #endif
     uint32_t tbflags;
     int mem_idx;
@@ -1155,7 +1153,6 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 #else
     {
         TCGv tmp = tcg_temp_new();
-        uint64_t entry;
 
         gen_pc_disp(ctx, tmp, 0);
         if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
@@ -1165,12 +1162,11 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
         }
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUAlphaState, exc_addr));
 
-        entry = ctx->palbr;
-        entry += (palcode & 0x80
-                  ? 0x2000 + (palcode - 0x80) * 64
-                  : 0x1000 + palcode * 64);
-
-        tcg_gen_movi_i64(cpu_pc, entry);
+        tcg_gen_ld_i64(cpu_pc, tcg_env, offsetof(CPUAlphaState, palbr));
+        tcg_gen_addi_i64(cpu_pc, cpu_pc,
+                         palcode & 0x80
+                         ? 0x2000 + (palcode - 0x80) * 64
+                         : 0x1000 + palcode * 64);
         return DISAS_PC_UPDATED;
     }
 #endif
@@ -1292,11 +1288,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
     case 7:
         /* PALBR */
         tcg_gen_st_i64(vb, tcg_env, offsetof(CPUAlphaState, palbr));
-        /* Changing the PAL base register implies un-chaining all of the TBs
-           that ended with a CALL_PAL.  Since the base register usually only
-           changes during boot, flushing everything works well.  */
-        gen_helper_tb_flush(tcg_env);
-        return DISAS_PC_STALE;
+        break;
 
     case 32 ... 39:
         /* Accessing the "non-shadow" general registers.  */
@@ -2874,7 +2866,6 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     ctx->ir = cpu_std_ir;
     ctx->unalign = (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
-    ctx->palbr = env->palbr;
     ctx->ir = (ctx->tbflags & ENV_FLAG_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
 #endif
 
-- 
2.43.0


