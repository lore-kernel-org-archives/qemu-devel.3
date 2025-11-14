Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C29CEACE5
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 23:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK2nE-0007PQ-5W; Fri, 14 Nov 2025 18:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mD-0007GX-Px
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:26 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mB-0004af-8a
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:21 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-43320651e53so17416195ab.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763161217; x=1763766017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3YaVmM/0XrzFextwX0itGBRky+8Uqo16F2QBmoGm3k=;
 b=XBx09r/nTsghGbeg9Io8/MbhK/p/cREHlSgkbX4Vy7X/JL7oCWIJuI+yQwOF1+sC9z
 U89kI9sCqdU9wx0xKGpaGBGrnDpQMYs9Xak2LY8ikn0A/jgZ7B9Vl7L/+z4tA33AfLKR
 notEzEwBDFAFergWsG0y3lIRS8arCNmcPvxUtyBSINVZlDVuAIymwVu1MIKXr1zW+NOk
 gpbW01Fqvbg70hvNABKiTz4Gsb3sZoatzD6qWXmgoHebW7DsTWf5dGVYOiV+crQEM0dm
 0GiBLUKzkOLl79wJuS54OdhRpLxDH6uqfVTZYqkGQRI/36wBc86fI+z0XZAMLkE7wdNq
 cxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763161217; x=1763766017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F3YaVmM/0XrzFextwX0itGBRky+8Uqo16F2QBmoGm3k=;
 b=ZkSTpm3V4BnBafYr2fBS+Zi7d8ySIPztMG6WeVTP7R/cTf375Pr9Tnptw0ptqDmB35
 qIW8n9dg5V3bdBkTjrwxU1UPztwYHsQEI/NXnCk82vI4SXT1RGQ7ZLGmGahrtGioYJob
 KFK33kGtXmaG2lEsryD56HT9bhT+P7nXuwdCB3g8qWF55ZdsaUYgRTS27+1FZe3jYdjo
 MwmmxK8DEWnNqrgKRPYimmRi+VsFBF5QCF3PK+7j+wrAExD1dObGLciiQOAZbyj0DFaM
 NVRue3ae4BZC/qQ+WRVqLkFrnM95vaWrpqajh0STAzgjfYcSnUvi/IeQ6SkjfHA7LETP
 dBAA==
X-Gm-Message-State: AOJu0YwokToU4q75Bc010jZsFpSZB4Tv4zWPhWBsnZTPjrC3zipmUXz2
 1VjhayrkWow/8V1z5/SfSlOMfh2JJ6obYnXz4fCrVZZOtRktiqQjLHQa9YrcV0cL
X-Gm-Gg: ASbGncuOSZlw8ejKNGf0TE+UTByjzXzQ/LX+jzhfxkFidGMlQzm/zxGiIWKTHP73Cjm
 FlkPoA9FrPY5iHgVVdo8sQgc17weB3pULftBgqWNB8fswfCg1MonJ2lpDKlPo4m2Im1F+nPibWU
 KaF1jvU846RThMjiBVjK9uD+Mt4jVPI7uU7biMFdDVngiXAPxCbGsVd09MRrnrgupsguAOHDs6l
 AfmOgmv9HV02AhofIEcnjZoanlMDgDeaACj4V2emGKPkpRsEgw/1TYVsuBH/197JCoqxJDT+mzf
 kwno40wo/OrsRk3UXNnGrbHB1WoIHm3MDg3ZaPmwtT5oJ+eJYP+Nan9zBHWZaMol8LHqb6owCDg
 2cdMB46y841v7hqtGNGEgIhyuqM6kWDkEkjCVru2T0EwHR+C0G+SOVd5dUCsPClfLe+c0peb8aS
 N9uyaNZhzwD+MVX7BKd0INJaRCGrgptxjfRFP1t90buyg0wBQi/rDCbaKGsCtrQjoE5w==
X-Google-Smtp-Source: AGHT+IGapdMh4P9Wqm98DeUPgeyQbv+P9xyAfkSiOL25/IqLsEqT9PlM59jeYdtncsbbUlABK89VVA==
X-Received: by 2002:a05:6e02:33a0:b0:433:3487:ea1d with SMTP id
 e9e14a558f8ab-4348c86dbfbmr77011445ab.7.1763161217127; 
 Fri, 14 Nov 2025 15:00:17 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434838c24a1sm35673075ab.15.2025.11.14.15.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 15:00:16 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 1/4] Hexagon (target/hexagon) Remove gen_log_reg_write
Date: Fri, 14 Nov 2025 16:00:10 -0700
Message-ID: <20251114230013.158098-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The gen_log_reg_write function is a memnant of the original Hexagon
target design.  With the addition of gen_analyze_funcs.py and the
ability to short-circuit a packet commit, this function can be
removed.

Note that the implementation of gen_log_reg_write contains a check
of the register mutability mask.  This is only needed for control
registers, so we move it to gen_write_ctrl_reg.

We do need the gen_log_reg_write_pair function, but the name is
now misleading, so we change the name go gen_write_reg_pair.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_tcg.h                    |  7 +--
 target/hexagon/genptr.h                     |  1 -
 target/hexagon/genptr.c                     | 64 ++++++++-------------
 target/hexagon/idef-parser/parser-helpers.c |  2 +-
 target/hexagon/README                       | 10 ++--
 target/hexagon/gen_tcg_funcs.py             |  1 -
 target/hexagon/hex_common.py                | 14 ++---
 7 files changed, 40 insertions(+), 59 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 8a3b801287..10123336b1 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -509,10 +509,9 @@
 /* sub-instruction version (no RxV, so handle it manually) */
 #define fGEN_TCG_SS2_allocframe(SHORTCODE) \
     do { \
-        TCGv r29 = tcg_temp_new(); \
+        TCGv r29 = get_result_gpr(ctx, HEX_REG_SP); \
         tcg_gen_mov_tl(r29, hex_gpr[HEX_REG_SP]); \
         gen_allocframe(ctx, r29, uiV); \
-        gen_log_reg_write(ctx, HEX_REG_SP, r29); \
     } while (0)
 
 /*
@@ -528,7 +527,7 @@
     do { \
         TCGv_i64 r31_30 = tcg_temp_new_i64(); \
         gen_deallocframe(ctx, r31_30, hex_gpr[HEX_REG_FP]); \
-        gen_log_reg_write_pair(ctx, HEX_REG_FP, r31_30); \
+        gen_write_reg_pair(ctx, HEX_REG_FP, r31_30); \
     } while (0)
 
 /*
@@ -546,7 +545,7 @@
     do { \
         TCGv_i64 RddV = get_result_gpr_pair(ctx, HEX_REG_FP); \
         gen_return(ctx, RddV, hex_gpr[HEX_REG_FP]); \
-        gen_log_reg_write_pair(ctx, HEX_REG_FP, RddV); \
+        gen_write_reg_pair(ctx, HEX_REG_FP, RddV); \
     } while (0)
 
 /*
diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
index a4b43c2910..d932255042 100644
--- a/target/hexagon/genptr.h
+++ b/target/hexagon/genptr.h
@@ -37,7 +37,6 @@ TCGv gen_read_reg(TCGv result, int num);
 TCGv gen_read_preg(TCGv pred, uint8_t num);
 TCGv get_result_gpr(DisasContext *ctx, int rnum);
 TCGv get_result_pred(DisasContext *ctx, int pnum);
-void gen_log_reg_write(DisasContext *ctx, int rnum, TCGv val);
 void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val);
 void gen_set_usr_field(DisasContext *ctx, int field, TCGv val);
 void gen_set_usr_fieldi(DisasContext *ctx, int field, int x);
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index cecaece4ae..e58021ed6c 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -94,25 +94,17 @@ static TCGv_i64 get_result_gpr_pair(DisasContext *ctx, int rnum)
     return result;
 }
 
-void gen_log_reg_write(DisasContext *ctx, int rnum, TCGv val)
-{
-    const target_ulong reg_mask = reg_immut_masks[rnum];
-
-    gen_masked_reg_write(val, hex_gpr[rnum], reg_mask);
-    tcg_gen_mov_tl(get_result_gpr(ctx, rnum), val);
-}
-
-static void gen_log_reg_write_pair(DisasContext *ctx, int rnum, TCGv_i64 val)
+static void gen_write_reg_pair(DisasContext *ctx, int rnum, TCGv_i64 val)
 {
     TCGv val32 = tcg_temp_new();
 
     /* Low word */
     tcg_gen_extrl_i64_i32(val32, val);
-    gen_log_reg_write(ctx, rnum, val32);
+    tcg_gen_mov_tl(get_result_gpr(ctx, rnum), val32);
 
     /* High word */
     tcg_gen_extrh_i64_i32(val32, val);
-    gen_log_reg_write(ctx, rnum + 1, val32);
+    tcg_gen_mov_tl(get_result_gpr(ctx, rnum + 1), val32);
 }
 
 TCGv get_result_pred(DisasContext *ctx, int pnum)
@@ -240,7 +232,9 @@ static inline void gen_write_ctrl_reg(DisasContext *ctx, int reg_num,
     if (reg_num == HEX_REG_P3_0_ALIASED) {
         gen_write_p3_0(ctx, val);
     } else {
-        gen_log_reg_write(ctx, reg_num, val);
+        const target_ulong reg_mask = reg_immut_masks[reg_num];
+        gen_masked_reg_write(val, hex_gpr[reg_num], reg_mask);
+        tcg_gen_mov_tl(get_result_gpr(ctx, reg_num), val);
         if (reg_num == HEX_REG_QEMU_PKT_CNT) {
             ctx->num_packets = 0;
         }
@@ -256,23 +250,15 @@ static inline void gen_write_ctrl_reg(DisasContext *ctx, int reg_num,
 static inline void gen_write_ctrl_reg_pair(DisasContext *ctx, int reg_num,
                                            TCGv_i64 val)
 {
-    if (reg_num == HEX_REG_P3_0_ALIASED) {
-        TCGv result = get_result_gpr(ctx, reg_num + 1);
-        TCGv val32 = tcg_temp_new();
-        tcg_gen_extrl_i64_i32(val32, val);
-        gen_write_p3_0(ctx, val32);
-        tcg_gen_extrh_i64_i32(val32, val);
-        tcg_gen_mov_tl(result, val32);
-    } else {
-        gen_log_reg_write_pair(ctx, reg_num, val);
-        if (reg_num == HEX_REG_QEMU_PKT_CNT) {
-            ctx->num_packets = 0;
-            ctx->num_insns = 0;
-        }
-        if (reg_num == HEX_REG_QEMU_HVX_CNT) {
-            ctx->num_hvx_insns = 0;
-        }
-    }
+    TCGv val32 = tcg_temp_new();
+
+    /* Low word */
+    tcg_gen_extrl_i64_i32(val32, val);
+    gen_write_ctrl_reg(ctx, reg_num, val32);
+
+    /* High word */
+    tcg_gen_extrh_i64_i32(val32, val);
+    gen_write_ctrl_reg(ctx, reg_num + 1, val32);
 }
 
 TCGv gen_get_byte(TCGv result, int N, TCGv src, bool sign)
@@ -541,8 +527,8 @@ static inline void gen_loop0r(DisasContext *ctx, TCGv RsV, int riV)
 {
     fIMMEXT(riV);
     fPCALIGN(riV);
-    gen_log_reg_write(ctx, HEX_REG_LC0, RsV);
-    gen_log_reg_write(ctx, HEX_REG_SA0, tcg_constant_tl(ctx->pkt->pc + riV));
+    tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
+    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV);
     gen_set_usr_fieldi(ctx, USR_LPCFG, 0);
 }
 
@@ -555,8 +541,8 @@ static inline void gen_loop1r(DisasContext *ctx, TCGv RsV, int riV)
 {
     fIMMEXT(riV);
     fPCALIGN(riV);
-    gen_log_reg_write(ctx, HEX_REG_LC1, RsV);
-    gen_log_reg_write(ctx, HEX_REG_SA1, tcg_constant_tl(ctx->pkt->pc + riV));
+    tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC1), RsV);
+    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt->pc + riV);
 }
 
 static void gen_loop1i(DisasContext *ctx, int count, int riV)
@@ -568,8 +554,8 @@ static void gen_ploopNsr(DisasContext *ctx, int N, TCGv RsV, int riV)
 {
     fIMMEXT(riV);
     fPCALIGN(riV);
-    gen_log_reg_write(ctx, HEX_REG_LC0, RsV);
-    gen_log_reg_write(ctx, HEX_REG_SA0, tcg_constant_tl(ctx->pkt->pc + riV));
+    tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
+    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV);
     gen_set_usr_fieldi(ctx, USR_LPCFG, N);
     gen_log_pred_write(ctx, 3, tcg_constant_tl(0));
 }
@@ -773,25 +759,23 @@ static void gen_framecheck(TCGv EA, int framesize)
 
 static void gen_allocframe(DisasContext *ctx, TCGv r29, int framesize)
 {
-    TCGv r30 = tcg_temp_new();
+    TCGv r30 = get_result_gpr(ctx, HEX_REG_FP);
     TCGv_i64 frame;
     tcg_gen_addi_tl(r30, r29, -8);
     frame = gen_frame_scramble();
     gen_store8(tcg_env, r30, frame, ctx->insn->slot);
-    gen_log_reg_write(ctx, HEX_REG_FP, r30);
     gen_framecheck(r30, framesize);
     tcg_gen_subi_tl(r29, r30, framesize);
 }
 
 static void gen_deallocframe(DisasContext *ctx, TCGv_i64 r31_30, TCGv r30)
 {
-    TCGv r29 = tcg_temp_new();
+    TCGv r29 = get_result_gpr(ctx, HEX_REG_SP);
     TCGv_i64 frame = tcg_temp_new_i64();
     gen_load_frame(ctx, frame, r30);
     gen_frame_unscramble(frame);
     tcg_gen_mov_i64(r31_30, frame);
     tcg_gen_addi_tl(r29, r30, 8);
-    gen_log_reg_write(ctx, HEX_REG_SP, r29);
 }
 #endif
 
@@ -833,7 +817,7 @@ static void gen_cond_return_subinsn(DisasContext *ctx, TCGCond cond, TCGv pred)
 {
     TCGv_i64 RddV = get_result_gpr_pair(ctx, HEX_REG_FP);
     gen_cond_return(ctx, RddV, hex_gpr[HEX_REG_FP], pred, cond);
-    gen_log_reg_write_pair(ctx, HEX_REG_FP, RddV);
+    gen_write_reg_pair(ctx, HEX_REG_FP, RddV);
 }
 
 static void gen_endloop0(DisasContext *ctx)
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 1dc52b4e02..f5802ceadb 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1315,7 +1315,7 @@ void gen_write_reg(Context *c, YYLTYPE *locp, HexValue *reg, HexValue *value)
     value_m = rvalue_materialize(c, locp, &value_m);
     OUT(c,
         locp,
-        "gen_log_reg_write(ctx, ", &reg->reg.id, ", ",
+        "tcg_gen_mov_tl(get_result_gpr(ctx, ", &reg->reg.id, "), ",
         &value_m, ");\n");
 }
 
diff --git a/target/hexagon/README b/target/hexagon/README
index ca617e3364..1938c91af8 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -80,12 +80,14 @@ tcg_funcs_generated.c.inc
                     Insn *insn,
                     Packet *pkt)
     {
-        TCGv RdV = tcg_temp_new();
+        Insn *insn G_GNUC_UNUSED = ctx->insn;
         const int RdN = insn->regno[0];
-        TCGv RsV = hex_gpr[insn->regno[1]];
-        TCGv RtV = hex_gpr[insn->regno[2]];
+        TCGv RdV = get_result_gpr(ctx, RdN);
+        const int RsN = insn->regno[1];
+        TCGv RsV = hex_gpr[RsN];
+        const int RtN = insn->regno[2];
+        TCGv RtV = hex_gpr[RtN];
         gen_helper_A2_add(RdV, tcg_env, RsV, RtV);
-        gen_log_reg_write(ctx, RdN, RdV);
     }
 
 helper_funcs_generated.c.inc
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index c2ba91ddc0..bd241afde1 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -35,7 +35,6 @@
 ##        TCGv RsV = hex_gpr[insn->regno[1]];
 ##        TCGv RtV = hex_gpr[insn->regno[2]];
 ##        <GEN>
-##        gen_log_reg_write(ctx, RdN, RdV);
 ##    }
 ##
 ##       where <GEN> depends on hex_common.skip_qemu_helper(tag)
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 6803908718..093def9386 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -452,9 +452,8 @@ def decl_tcg(self, f, tag, regno):
             TCGv {self.reg_tcg()} = get_result_gpr(ctx, {self.reg_num});
         """))
     def log_write(self, f, tag):
-        f.write(code_fmt(f"""\
-            gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
-        """))
+        ## No write needed
+        return
     def analyze_write(self, f, tag, regno):
         predicated = "true" if is_predicated(tag) else "false"
         f.write(code_fmt(f"""\
@@ -496,9 +495,8 @@ def decl_tcg(self, f, tag, regno):
                 tcg_gen_mov_tl({self.reg_tcg()}, hex_gpr[{self.reg_num}]);
             """))
     def log_write(self, f, tag):
-        f.write(code_fmt(f"""\
-            gen_log_reg_write(ctx, {self.reg_num}, {self.reg_tcg()});
-        """))
+        ## No write needed
+        return
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
             ctx_log_reg_read(ctx, {self.reg_num});
@@ -630,7 +628,7 @@ def decl_tcg(self, f, tag, regno):
         """))
     def log_write(self, f, tag):
         f.write(code_fmt(f"""\
-            gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+            gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_write(self, f, tag, regno):
         predicated = "true" if is_predicated(tag) else "false"
@@ -664,7 +662,7 @@ def decl_tcg(self, f, tag, regno):
         """))
     def log_write(self, f, tag):
         f.write(code_fmt(f"""\
-            gen_log_reg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+            gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
     def analyze_read(self, f, regno):
         f.write(code_fmt(f"""\
-- 
2.43.0


