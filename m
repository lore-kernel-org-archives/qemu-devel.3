Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90C8E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xp-0005fD-Rd; Tue, 10 Dec 2024 11:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xk-00051F-DC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:52 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xh-0006Yu-9e
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:51 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53e3778bffdso4237963e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847588; x=1734452388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKDQdzssu+1amspVknrH1gTBhzIp0+Rx6mwL9CLKm6E=;
 b=aFwPz9H7xPvOyACh5QfjX8WkVA3KbXImBO8F0fyLWK+DbtvTZuv5Hr6Ww1bj2AQyAT
 Hm/8tfFHmTY11TEMIPwuSKBDHqJu1RO8Q2ZoNCRtXBjL2V/xp/ax18JKYjg+CFa6CEnC
 +obe49pnQHLF2K2WtfnLzTT4na7Uq/TC9gGQzafvPDVyPubP2P6JjvuI+JZqlwGuB/Fs
 3po59i+fFxaaY3ZB7zQwv460ol2O0G6ZTG6rIPV4jy1crmpo4stnPGX5zXqwPTZb8MMx
 1nMOtuiHMCPE8bN1HzrKEgdgvAgZ6JnlGgiB+rcDPARNoiQtqaMusWM4zQ4UoLCK3anU
 2Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847588; x=1734452388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKDQdzssu+1amspVknrH1gTBhzIp0+Rx6mwL9CLKm6E=;
 b=qbyfNYRUdfXFGS6jxd8KBW5Wzj8felSgiItVfGPp5p5GAoowubo7vzGSgYk6br+7Pz
 7OL87SsNp+87qH7yZbhyH7cB3p551JTRb1x4K7tbQr1+IjJwbVkSvM0fCDF5PV3aJsJf
 q56fzKE7eKQReA55Uo0iMze1ukGZbK2NMEinBPpBcE0hGrOWb4HNBByukQRpjU5ybieB
 qGqa1LEsls8GI35GoupimXoOciMPJZjwrRk6EBmXT6IykVBuXtZh6jGnzfHUWN1KrugX
 sUI5Y4nudNiizCR4UCeBXrGHeWusWY1yAXsAW3qgC9zbjPdRGiqvUNVkSMAPphGojA63
 DAVA==
X-Gm-Message-State: AOJu0Ywna/bP87CXNm9/c2EiRmIV0u3PQa4MOtxhu3zRZTTOgeDDSnPU
 ejPCTI7zcLJC6sV+Gt0XdO93GK1iURoAPsLb3yvpoQ9zY6/5a7P+Ql2M5229C1z0sBMuRWAzwSy
 xM7XgiI+Y
X-Gm-Gg: ASbGncuORq3w0DEGI1pHz8th46eKiwS2UcKQbm3siUKfmtNKnBFf3m8ZtvGze3gJhmu
 UAuussh9K6PvE4xKfsLjvwfouHcAbo4FNYP3LUoa+RANsFmP+KE4ldrUUbhpjRAK+fnHqimpRp/
 T7LpfUcj9pmMzgjQZPziGpfYQWfJhXSXbw/i8ExEn4CEnh8swnYHDEXr4jI1Ry4RAW//djUjAh3
 vw8tEusk9LisC6Bg/YRVLZORcc5rqkXJCw0hX4beBOanEc82TQcTEpMjGA=
X-Google-Smtp-Source: AGHT+IEm3o8kM8Ac6PYvtUrSSWg6sbG8JTZ/gpD2iqky67ub3IqCxayzcX98DhpUMSmXvKFCl0Cm0Q==
X-Received: by 2002:a05:6512:3b8c:b0:540:22e0:1f63 with SMTP id
 2adb3069b0e04-540240c9391mr2048093e87.19.1733847587611; 
 Tue, 10 Dec 2024 08:19:47 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 31/69] target/arm: Convert FCVT (scalar) to decodetree
Date: Tue, 10 Dec 2024 10:16:55 -0600
Message-ID: <20241210161733.1830573-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

Remove handle_fp_fcvt and disas_fp_1src as these were
the last insns decoded by those functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 172 +++++++++++++--------------------
 target/arm/tcg/a64.decode      |   7 ++
 2 files changed, 74 insertions(+), 105 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5a48a2ef2d..7d9353f95e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8443,123 +8443,85 @@ TRANS_FEAT(FRINT64Z_s, aa64_frint, do_fp1_scalar, a,
            &f_scalar_frint64, FPROUNDING_ZERO)
 TRANS_FEAT(FRINT64X_s, aa64_frint, do_fp1_scalar, a, &f_scalar_frint64, -1)
 
-static void handle_fp_fcvt(DisasContext *s, int opcode,
-                           int rd, int rn, int dtype, int ntype)
+static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
 {
-    switch (ntype) {
-    case 0x0:
-    {
-        TCGv_i32 tcg_rn = read_fp_sreg(s, rn);
-        if (dtype == 1) {
-            /* Single to double */
-            TCGv_i64 tcg_rd = tcg_temp_new_i64();
-            gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, tcg_env);
-            write_fp_dreg(s, rd, tcg_rd);
-        } else {
-            /* Single to half */
-            TCGv_i32 tcg_rd = tcg_temp_new_i32();
-            TCGv_i32 ahp = get_ahp_flag();
-            TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    if (fp_access_check(s)) {
+        TCGv_i32 tcg_rn = read_fp_sreg(s, a->rn);
+        TCGv_i64 tcg_rd = tcg_temp_new_i64();
 
-            gen_helper_vfp_fcvt_f32_to_f16(tcg_rd, tcg_rn, fpst, ahp);
-            /* write_fp_sreg is OK here because top half of tcg_rd is zero */
-            write_fp_sreg(s, rd, tcg_rd);
-        }
-        break;
-    }
-    case 0x1:
-    {
-        TCGv_i64 tcg_rn = read_fp_dreg(s, rn);
-        TCGv_i32 tcg_rd = tcg_temp_new_i32();
-        if (dtype == 0) {
-            /* Double to single */
-            gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, tcg_env);
-        } else {
-            TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-            TCGv_i32 ahp = get_ahp_flag();
-            /* Double to half */
-            gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
-            /* write_fp_sreg is OK here because top half of tcg_rd is zero */
-        }
-        write_fp_sreg(s, rd, tcg_rd);
-        break;
-    }
-    case 0x3:
-    {
-        TCGv_i32 tcg_rn = read_fp_sreg(s, rn);
-        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR);
-        TCGv_i32 tcg_ahp = get_ahp_flag();
-        tcg_gen_ext16u_i32(tcg_rn, tcg_rn);
-        if (dtype == 0) {
-            /* Half to single */
-            TCGv_i32 tcg_rd = tcg_temp_new_i32();
-            gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-            write_fp_sreg(s, rd, tcg_rd);
-        } else {
-            /* Half to double */
-            TCGv_i64 tcg_rd = tcg_temp_new_i64();
-            gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-            write_fp_dreg(s, rd, tcg_rd);
-        }
-        break;
-    }
-    default:
-        g_assert_not_reached();
+        gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, tcg_env);
+        write_fp_dreg(s, a->rd, tcg_rd);
     }
+    return true;
 }
 
-/* Floating point data-processing (1 source)
- *   31  30  29 28       24 23  22  21 20    15 14       10 9    5 4    0
- * +---+---+---+-----------+------+---+--------+-----------+------+------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 | opcode | 1 0 0 0 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+--------+-----------+------+------+
- */
-static void disas_fp_1src(DisasContext *s, uint32_t insn)
+static bool trans_FCVT_s_hs(DisasContext *s, arg_rr *a)
 {
-    int mos = extract32(insn, 29, 3);
-    int type = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 15, 6);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
+    if (fp_access_check(s)) {
+        TCGv_i32 tmp = read_fp_sreg(s, a->rn);
+        TCGv_i32 ahp = get_ahp_flag();
+        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
-    if (mos) {
-        goto do_unallocated;
+        gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+        /* write_fp_sreg is OK here because top half of result is zero */
+        write_fp_sreg(s, a->rd, tmp);
     }
+    return true;
+}
 
-    switch (opcode) {
-    case 0x4: case 0x5: case 0x7:
-    {
-        /* FCVT between half, single and double precision */
-        int dtype = extract32(opcode, 0, 2);
-        if (type == 2 || dtype == type) {
-            goto do_unallocated;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
+static bool trans_FCVT_s_sd(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rn = read_fp_dreg(s, a->rn);
+        TCGv_i32 tcg_rd = tcg_temp_new_i32();
 
-        handle_fp_fcvt(s, opcode, rd, rn, dtype, type);
-        break;
+        gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, tcg_env);
+        write_fp_sreg(s, a->rd, tcg_rd);
     }
+    return true;
+}
 
-    default:
-    do_unallocated:
-    case 0x0: /* FMOV */
-    case 0x1: /* FABS */
-    case 0x2: /* FNEG */
-    case 0x3: /* FSQRT */
-    case 0x6: /* BFCVT */
-    case 0x8: /* FRINTN */
-    case 0x9: /* FRINTP */
-    case 0xa: /* FRINTM */
-    case 0xb: /* FRINTZ */
-    case 0xc: /* FRINTA */
-    case 0xe: /* FRINTX */
-    case 0xf: /* FRINTI */
-    case 0x10 ... 0x13: /* FRINT{32,64}{X,Z} */
-        unallocated_encoding(s);
-        break;
+static bool trans_FCVT_s_hd(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 tcg_rn = read_fp_dreg(s, a->rn);
+        TCGv_i32 tcg_rd = tcg_temp_new_i32();
+        TCGv_i32 ahp = get_ahp_flag();
+        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+
+        gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
+        /* write_fp_sreg is OK here because top half of tcg_rd is zero */
+        write_fp_sreg(s, a->rd, tcg_rd);
     }
+    return true;
+}
+
+static bool trans_FCVT_s_sh(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
+        TCGv_i32 tcg_rd = tcg_temp_new_i32();
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_i32 tcg_ahp = get_ahp_flag();
+
+        gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
+        write_fp_sreg(s, a->rd, tcg_rd);
+    }
+    return true;
+}
+
+static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
+        TCGv_i64 tcg_rd = tcg_temp_new_i64();
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_i32 tcg_ahp = get_ahp_flag();
+
+        gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
+        write_fp_dreg(s, a->rd, tcg_rd);
+    }
+    return true;
 }
 
 /* Handle floating point <=> fixed point conversions. Note that we can
@@ -8982,7 +8944,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
                 break;
             case 2: /* [15:12] == x100 */
                 /* Floating point data-processing (1 source) */
-                disas_fp_1src(s, insn);
+                unallocated_encoding(s); /* in decodetree */
                 break;
             case 3: /* [15:12] == 1000 */
                 unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4f7b3ee3d9..211346c4d9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1345,6 +1345,13 @@ FRINT32X_s      00011110 0. 1 010001 10000 ..... .....      @rr_sd
 FRINT64Z_s      00011110 0. 1 010010 10000 ..... .....      @rr_sd
 FRINT64X_s      00011110 0. 1 010011 10000 ..... .....      @rr_sd
 
+FCVT_s_ds       00011110 00 1 000101 10000 ..... .....      @rr
+FCVT_s_hs       00011110 00 1 000111 10000 ..... .....      @rr
+FCVT_s_sd       00011110 01 1 000100 10000 ..... .....      @rr
+FCVT_s_hd       00011110 01 1 000111 10000 ..... .....      @rr
+FCVT_s_sh       00011110 11 1 000100 10000 ..... .....      @rr
+FCVT_s_dh       00011110 11 1 000101 10000 ..... .....      @rr
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


