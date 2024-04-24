Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A237DC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmIO-0000zK-1s; Wed, 24 Apr 2024 19:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIL-0000xu-Pm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIJ-00028k-KW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1eab699fcddso765565ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714002293; x=1714607093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R088D4z5RrGC3ENBq7NdeJMAQG6+Qk8mMWqAtHkj3hU=;
 b=NGmBAZjW2nAX4QNreICv7m5oY0gQdJzr6eS6ToqBk+4lRnF4wgat2JZLzrpxI+doV4
 UdxNSK1/cPhCI6i7xXD/r/zsixI5nBfOAOfb7Rt5XIfH4/ulFsPaOBgxa4zm8brb/0jA
 k2RIdwD1C8QR9hXUeanOtHC+GNgFM2YS9qofiRngMbRlaGXGQMQYJSt97bkcvscqhELg
 kb5jCqg5yNri/Yv/kW3fZgMJWvlJcHAQp5w5n/mNOr7lyWFRdGZj3hplC3bsBCSsjh2Y
 LUrSHiTm7JFVjDzs5MnPetL0DZPcZ7nbue+tQt2IfyILOssDxWfnojEdyz1G/gSW88f2
 HfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714002293; x=1714607093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R088D4z5RrGC3ENBq7NdeJMAQG6+Qk8mMWqAtHkj3hU=;
 b=bMlOC2vlG482IjmEEVJSKJgF69Rm1UUCo4RwxL0IceGD17FM2LjSEMKAFocZeq/hCS
 5inyUCcwoRG7ZRSXFUnk0ns6dL1as4+gAk5EsugrWbzqf/9/LhQlKQQEalpsC2VKbxuR
 XDS+/QxA63Ys/PH915sCGHN8sW+pizdn5eLWH+Zw4+pF1n8e6W1cl5sSq/b4QCtxeKSC
 +w+9wNxprBDHx4rdXrkeg5sv9vVG27FbN6hWtC4N2DUqQ1AqoQ4e9IntEvFVPBvvaQgK
 q1bmCT2dZcgg0nemhqqIk7PeBxc/+dCr850hQp8grLcLtU8s5HsUIPRdV9l+RqZCT7Dn
 XMzw==
X-Gm-Message-State: AOJu0YyheD+Zv0KPWD32McAAa5GxCuu46U1YmJKq1WmTTAogs+z16YxN
 XeQql/usI/Sx84KY3R3XzmUz1MwvdB9xUuY950bKF0+n/+RDN/JhzIhjGcYNyxPSgDWpWum00Wh
 Y
X-Google-Smtp-Source: AGHT+IE5fLefTAfStSB0uh2BPVXjTi+X4ott54bWjNztPhXBQ+T2WHGnmhz0qaGRRIcyaJCRGEILiw==
X-Received: by 2002:a17:902:e848:b0:1e2:7fb2:b08 with SMTP id
 t8-20020a170902e84800b001e27fb20b08mr4856036plg.43.1714002293636; 
 Wed, 24 Apr 2024 16:44:53 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f55100b001e49428f327sm12531642plf.176.2024.04.24.16.44.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:44:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/alpha: Split out gen_goto_tb
Date: Wed, 24 Apr 2024 16:44:34 -0700
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424234436.995410-1-richard.henderson@linaro.org>
References: <20240424234436.995410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 61 ++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 52c2e6248b..c1a55e5153 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -425,60 +425,45 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
     return DISAS_NEXT;
 }
 
-static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
+static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
-    return translator_use_goto_tb(&ctx->base, dest);
+    uint64_t dest = ctx->base.pc_next + disp;
+
+    if (translator_use_goto_tb(&ctx->base, dest)) {
+        tcg_gen_goto_tb(idx);
+        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_exit_tb(ctx->base.tb, idx);
+    } else {
+        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_lookup_and_goto_ptr();
+    }
 }
 
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
-
     if (ra != 31) {
         tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
     }
 
     /* Notice branch-to-next; used to initialize RA with the PC.  */
     if (disp == 0) {
-        return 0;
-    } else if (use_goto_tb(ctx, dest)) {
-        tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb(ctx->base.tb, 0);
-        return DISAS_NORETURN;
-    } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
-        return DISAS_PC_UPDATED;
+        return DISAS_NEXT;
     }
+    gen_goto_tb(ctx, 0, disp);
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
                                         TCGv cmp, uint64_t imm, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
-    if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
+    tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
+    gen_goto_tb(ctx, 0, 0);
+    gen_set_label(lab_true);
+    gen_goto_tb(ctx, 1, disp);
 
-        tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-        tcg_gen_exit_tb(ctx->base.tb, 0);
-
-        gen_set_label(lab_true);
-        tcg_gen_goto_tb(1);
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb(ctx->base.tb, 1);
-
-        return DISAS_NORETURN;
-    } else {
-        TCGv_i64 i = tcg_constant_i64(imm);
-        TCGv_i64 d = tcg_constant_i64(dest);
-        TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
-
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
-        return DISAS_PC_UPDATED;
-    }
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
@@ -2920,12 +2905,8 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-        if (use_goto_tb(ctx, ctx->base.pc_next)) {
-            tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-            tcg_gen_exit_tb(ctx->base.tb, 0);
-        }
-        /* FALLTHRU */
+        gen_goto_tb(ctx, 0, 0);
+        break;
     case DISAS_PC_STALE:
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         /* FALLTHRU */
-- 
2.34.1


