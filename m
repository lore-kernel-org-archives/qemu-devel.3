Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14446CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swN-0004EL-Su; Mon, 22 Sep 2025 22:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swM-0004E8-AY
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swE-0003gr-JJ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77f2e621ef8so2107641b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595166; x=1759199966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I7FMx8ch25mi1HM2iSzOFbjlu0abcZfgeYT8ylr/T9c=;
 b=DgiaA+16cdKkQCxBaEevtLabbaUykaiwHvoBuA2mIE5kSHv5m1eraeWj3cLUZy++86
 T8UBfqJXauzQ9gCZjtdlxkn3SlC6RVb6JeSd4l3Z+ikca95502ZyCZR7Ppm6K6Tu3ud8
 L+zo+l+Z2diVxxHn4yt2X+E5cu4YUh458v/LxSk1AVqeqsB7UrLQ2sSB29MaU9bmZ1bt
 CnPJgPaZ44BPJBbJuw1uv2OSoePEzzF7Pdxxsh4PmxyN9xj2krkx9WqQkEMOtVDtFTs/
 lzTgb9lYfCbyNodmwCT7QNPFJfOxjZ4RjIb+LGvmT5kktkSovCPj9mJfXuxoGoIJyMNH
 Ysbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595166; x=1759199966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7FMx8ch25mi1HM2iSzOFbjlu0abcZfgeYT8ylr/T9c=;
 b=NuUYDnX9/3VvFD3fFUPHRoHO7CHpVq1nDSHpA1EW2W2WGM8yxlZL4RZtip1ZUPBT9C
 iMrYdzgi1K6J399GzeMIJLDFfS3gVyHYY2lyWpeyceN9GwFbCcZwdOlXTHNuc8v+77nA
 32mtyITo48eKfTG/WDPJXi2bYaurY/31UfJKKnyRbNRYLfpaU9xTUTHRH1YkTXaZsulh
 EMQvF3VI8r3KYjyUyqN4sDax3cxDeyDrTMqRk2fSivfce2wDnZDmA9xClRzzy5wOQ3Hh
 WWVWQYvojzPNJdHZMNziOC4cuA0iPR4J2FbeZvFc4eD2cWN5fWviRzHB8pF02vMnKZzF
 YnSQ==
X-Gm-Message-State: AOJu0Yy0mN23x9jFMamOLdIggSspfGzYxQu9t5FupA0MHIDza6zEshQn
 d+2dTJRG5NPxChQzwVEkiPK0fr4imbMioCI/1GciRu165vL6qUpmKMonELV+93NIedmUNlYe5Cd
 AKznp
X-Gm-Gg: ASbGncv0rQeCMdPAEvgh3biFUaULg1IYEs0q8ehbBL34PJLcJV4e2kRI/OVS9WynPM8
 EHHef4B6y0UG3oL1b4TdZ2Fea1KDdNcVku6aLPkNvvQjtYt3dyQajIZJQ6GW1RRYIYY27fAg1xX
 bezDnEzaxDMwiVSNHuQYspyzL/3iL5Gvetmy/b2+UzitsBet1zRV6C0vtFvkkSSZHthRWsCydyK
 rHswvk00n6ayFvJGDYLqrFs0e25GhzY3q9CyxWHnDw64zpCA9TeRfdy0rkVSTaB97nFpcoB1qxh
 REXdMtikH2ZJ0Um0MArlSfDFaiw2++vm5DRReX4IqP5R4fikQ51k3hJy41epRecvFf/elzRjTzV
 ElhEMQ8oTmKdqViZFkhVXHgMZ/gOv
X-Google-Smtp-Source: AGHT+IEicq4MIqnZXV1Dwrod3IW6O3/D0dOoMSoc/ubULa18kIa+bAPZkTRLO/siljOYHjyUmJ/WgQ==
X-Received: by 2002:a05:6a00:1825:b0:772:4b05:78b0 with SMTP id
 d2e1a72fcca58-77f53887f3emr1124770b3a.7.1758595166094; 
 Mon, 22 Sep 2025 19:39:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/12] target/alpha: Simplify call_pal implementation
Date: Mon, 22 Sep 2025 19:39:07 -0700
Message-ID: <20250923023922.3102471-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.h     |  1 -
 target/alpha/sys_helper.c |  6 ------
 target/alpha/translate.c  | 21 ++++++---------------
 3 files changed, 6 insertions(+), 22 deletions(-)

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


