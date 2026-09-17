Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D747C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Ua-00042v-DA; Thu, 17 Sep 2026 05:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UX-00041g-5B
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:17 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UT-00017R-Tl
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:16 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6bda350b708so239126eaf.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637593; x=1790242393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0LxMjJkIml7LpUanI0923AE8AvAW5yzYjaL8c8o3zxM=;
 b=DgbKYRJ8K9xKXrJpQpRsSYORebsyBP305sZjduAlkNPro2NC3iPtX+xDDnUCJvfygC
 cXy5bImgMGf468vlMHdcsPBECPcdKaDYUi+XHVmrVXvhdXG+Bz6iSHm7l3SuD1X4t4+m
 tcLoiMglkooxc5OOJga1mryDggL5wV7wVmwMO4J4j1zoNtjjwqPk6Dt2PAGUu7ei9l0t
 b7vFBR2pJwUZ9vBhYgkrcgZzSrDW7Id/GKezzXtlaQkCh/XhotRpuoBLlBVwEb23Y7bX
 X2CRRGpg60kOlZJ+t/wSRXIRkKKW4kZnCkbzGMrdw47ve4vjztFgmdFntAY5M5awMVBK
 5NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637593; x=1790242393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0LxMjJkIml7LpUanI0923AE8AvAW5yzYjaL8c8o3zxM=;
 b=mYoYRgcGkHh9ywiwmYap5ewLCe2RlaGO4nOSORNCA3wA1OCsBNvnmRfxR8JrmufBA+
 Thv5EutQRv4BOUkTdq8jq/fbI+XZTWVQ4VlA0LjiqbBDtt5/yGMiveOFCr8sEoWK3kiT
 hBkMMu/Yp+oR3Zqc6Ik/pHRFVYEtJ1Js7RMCZz4rYR0uLRYmaKr+GUHD+Ial6W8YgRwL
 yytvzWvxU2F7iqyOIOJJJmUPkCpJvlZ5RAiW1gSWBWc5/RaFkHbg9s5cxcKYwZuYeaee
 EVVWZq9roL8kBy4Qo60iat3qFtnXPtFhpuQ1UbsPwvirlN8PfMvocTyHnQAZ3e7uaNBO
 AY3A==
X-Gm-Message-State: AFuF++nYJHyBBUlawXY6vHfNpFQYn6HPFX8aEDg7g7UppOdDckDIazZW
 Zmo+Q8aZMQpsrOQuTrkHoU1dA9Jtj3PFdPpRTm3/O+DhAYCueqDsG5vzWgoka+/H3P0pAJkgCDO
 Z267CE2w=
X-Gm-Gg: AYBFou2H6jdCIqOVvWSwLKx7KwjM07DVFRgQQ5+jnR3j+Ip+qgDL88oYNnDM3EjV8df
 3v7IQqB3cs2Y8bMygOaB/GDL+l/b9q6S1lQYpu0++miM5o49UYoiM+MGHuKJSD3cqla9ijZ+mTf
 MR5IFU4f9G62/tReR21JfSnKau9sfvA3kV/NuQk0LQW7f6C/nPqZPpiHhrdxCcpPBMtWPkac5Hj
 VGy6Dpdvi6uRArL5ibuUtfvTbcbnasikD2aqROFbN1KFOT5fgdkiMhooq9CibczsgHoE8KVB6UB
 +ZfKS4oKTIjVo6FyGQnwdCWga9bqEI/KDGL2Tm6FI5tbcblCQdmEhJ1gSI7MaTlRsKKoOGZvKnQ
 xl4ZipLoHZVQp7fIB3bEqBudH9/Enpg4GOH0BIpEaH4A4HxSovweH2IH2zQc9Rka+wtqBbei9sX
 p7v4xy718T3zvLjDmmL0MbMYDs0/EgRHT6nhkVBhv0sQyE9+SS50mRn/SiOLx63FWnNKCfo4o4k
 KDZewI=
X-Received: by 2002:a05:6820:1ca8:b0:6be:7d9:b14 with SMTP id
 006d021491bc7-6c7d11d8cd7mr5752027eaf.4.1789637592509; 
 Thu, 17 Sep 2026 02:33:12 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 02/13] target/alpha: Use tcg_gen_goto_jc{3}_i64
Date: Wed, 16 Sep 2026 23:32:56 -1000
Message-ID: <20260917093307.1092084-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0e.google.com
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

We can use tcg_gen_goto_jc_i64 for direct or indirect branches, where
flags are known to not change.  We can use tcg_gen_goto_jc3_i64 in
gen_call_pal where flags are known to change in a very specific way.

Introduce DISAS_PC_STALE_NOJC as a case where flags are changing
in an unpredictable way and must therefore use the runtime lookup.

Introduce DISAS_PC_STALE_NOCHAIN as a case where we must return
to the main loop.

Remove DISAS_PC_STALE and use DISAS_TOO_MANY instead, as they
wind up having the same semantics.

End the translation block when setting PS or FEN, as they represent
changes in tbflags.  This avoids a subsequent insn incorrectly chaining
via the jump cache and failing the assert.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 60 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 6f18b8d1af6..ecb4ac4b023 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -80,9 +80,10 @@ struct DisasContext {
 /* Target-specific return values from translate_one, indicating the
    state of the TB.  Note that DISAS_NEXT indicates that we are not
    exiting the TB.  */
-#define DISAS_PC_UPDATED_NOCHAIN  DISAS_TARGET_0
-#define DISAS_PC_UPDATED          DISAS_TARGET_1
-#define DISAS_PC_STALE            DISAS_TARGET_2
+#define DISAS_PC_UPDATED          DISAS_TARGET_0
+#define DISAS_PC_STALE_NOJC       DISAS_TARGET_1
+#define DISAS_PC_STALE_NOCHAIN    DISAS_TARGET_2
+#define DISAS_PC_UPDATED_NOCHAIN  DISAS_TARGET_3
 
 /* global register indexes */
 static TCGv_i64 cpu_std_ir[31];
@@ -449,7 +450,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_i64(cpu_pc);
     }
 }
 
@@ -1096,8 +1097,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             }
 
             /* Allow interrupts to be recognized right away.  */
-            gen_pc_disp(ctx, cpu_pc, 0);
-            return DISAS_PC_UPDATED_NOCHAIN;
+            return DISAS_PC_STALE_NOCHAIN;
 
         case 0x36:
             /* RDPS */
@@ -1148,6 +1148,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             tcg_gen_ori_i64(tmp, tmp, 1);
         } else {
             st_flag_byte(tcg_constant_i64(1), ENV_FLAG_PAL_SHIFT);
+            ctx->tbflags = deposit32(ctx->tbflags, ENV_FLAG_PAL_SHIFT, 8, 1);
         }
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUAlphaState, exc_addr));
 
@@ -1156,7 +1157,9 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
                          palcode & 0x80
                          ? 0x2000 + (palcode - 0x80) * 64
                          : 0x1000 + palcode * 64);
-        return DISAS_PC_UPDATED;
+
+        tcg_gen_goto_jc3_i64(cpu_pc, load_zero(ctx), ctx->tbflags);
+        return DISAS_NORETURN;
     }
 #endif
 }
@@ -1191,8 +1194,7 @@ static int cpu_pr_data(int pr)
 
 static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv_i64 va, int regno)
 {
-    void (*helper)(TCGv_i64);
-    int data;
+    int data, ret = DISAS_NEXT;
 
     switch (regno) {
     case 32 ... 39:
@@ -1202,17 +1204,16 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv_i64 va, int regno)
         break;
 
     case 250: /* WALLTIME */
-        helper = gen_helper_get_walltime;
-        goto do_helper;
-    case 249: /* VMTIME */
-        helper = gen_helper_get_vmtime;
-    do_helper:
         if (translator_io_start(&ctx->base)) {
-            helper(va);
-            return DISAS_PC_STALE;
-        } else {
-            helper(va);
+            ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
         }
+        gen_helper_get_walltime(va);
+        break;
+    case 249: /* VMTIME */
+        if (translator_io_start(&ctx->base)) {
+            ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
+        }
+        gen_helper_get_vmtime(va);
         break;
 
     case 0: /* PS */
@@ -1236,7 +1237,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv_i64 va, int regno)
         break;
     }
 
-    return DISAS_NEXT;
+    return ret;
 }
 
 static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
@@ -1264,12 +1265,12 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
     case 252:
         /* HALT */
         gen_helper_halt(vb);
-        return DISAS_PC_STALE;
+        return DISAS_PC_STALE_NOCHAIN;
 
     case 251:
         /* ALARM */
         if (translator_io_start(&ctx->base)) {
-            ret = DISAS_PC_STALE;
+            ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
         }
         gen_helper_set_alarm(tcg_env, vb);
         break;
@@ -1287,10 +1288,11 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
 
     case 0: /* PS */
         st_flag_byte(vb, ENV_FLAG_PS_SHIFT);
-        break;
+        return DISAS_PC_STALE_NOJC; /* flags updated */
+
     case 1: /* FEN */
         st_flag_byte(vb, ENV_FLAG_FEN_SHIFT);
-        break;
+        return DISAS_PC_STALE_NOJC; /* flags updated */
 
     default:
         /* The basic registers are data only, and unknown registers
@@ -2289,7 +2291,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             /* RPCC */
             va = dest_gpr(ctx, ra);
             if (translator_io_start(&ctx->base)) {
-                ret = DISAS_PC_STALE;
+                ret = DISAS_TOO_MANY; /* i/o insns must be last in tb */
             }
             gen_helper_load_pcc(va, tcg_env);
             break;
@@ -2905,12 +2907,16 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, 0);
         break;
-    case DISAS_PC_STALE:
-        gen_pc_disp(ctx, cpu_pc, 0);
-        /* FALLTHRU */
     case DISAS_PC_UPDATED:
+        tcg_gen_goto_jc_i64(cpu_pc);
+        break;
+    case DISAS_PC_STALE_NOJC:
+        gen_pc_disp(ctx, cpu_pc, 0);
         tcg_gen_lookup_and_goto_ptr();
         break;
+    case DISAS_PC_STALE_NOCHAIN:
+        gen_pc_disp(ctx, cpu_pc, 0);
+        /* fallthru */
     case DISAS_PC_UPDATED_NOCHAIN:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.53.0


