Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75BAE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPeE-0001CB-9h; Wed, 11 Dec 2024 11:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdO-0005aW-5s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:22 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdM-0001QQ-9x
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:21 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-467918c360aso5222291cf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934739; x=1734539539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFmX4MjvTdCOOGQhoYxzX/rl0jVQPPh/e9AQv9Zr6rY=;
 b=Fontk107ceL0iVJY/TgvLqR+136IiqQchuCHg1aSr4YT/y9vAFokptZDF2QheR17BD
 DEI4GKF0+dDXEx703+oY/4l8qnEhRHmcYRY6AOd8xKckYMRISDTmqRrv/PZKR4eLt4ER
 giL9f9oRowG9i/ot3uwEMoP7OMkI94qHzNkr/1D6fBdXdFN7fwjQYWiu3KDWjmaPxP3t
 RN/qejuq1QaYqK5LdWdzzbIDOit/M94zqW+jrVidZn+8ZxpV8asMYqO8dA/c4bceg8qm
 imBs24sM4RmFhGTt7+GclMIrjBw9Q6LhKMyMlBvfyTwNSuxnwg89w9ACKw9JLSW4pR2Y
 Hk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934739; x=1734539539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFmX4MjvTdCOOGQhoYxzX/rl0jVQPPh/e9AQv9Zr6rY=;
 b=mN5AbZv29L/MR2G5dZ/CwJRUYTjQudkZl5027X62epy7qOqJ3T+eP1hzbnxo+W+98d
 6QsQftxhNU9tO3JbiLXl0tZ0VYZJ/ZUjW06RCSOmLCs1KDtC+tMrJqqZWk6S+AVIhJyk
 QJoIGeOif5JAOjJ8J6ZNcpBjfVgAxsexeiVKiHyvkeicNPQwKZLgm9taKdoMumj/yN4n
 j3mjqQbZweZ92bkUa+F6Af8XcMNW1ZqQCp0wDmZi+kZ7ng0Gp5cEVq7fOoRff4+ZYqey
 oYHcVVR9DxlGToHrirZ/FEKKOvil0RGp+G8bN2LDsUOIGn8Keo21MAyY+XKPLfk3ZQJe
 zu4A==
X-Gm-Message-State: AOJu0YzcZTqiIgzJqZv5z9pP23BJvEZmaJ72xcciU6phaa8QiRXmti0J
 3rnIgUTlAXA9UVR/BARBhHG16aPUqICMJOxcBAhuzB74ts5QB0IZsQBthh6nDbcTLpgY/jo5+MG
 fSaByi07P
X-Gm-Gg: ASbGncsq7bu/0Q0juF7/BstSbZd1WCIADke9YwRHFImrBP75el7SDNtKSiHZ1T/D93W
 hA677yLhxRmIBXmxpJ+qdFbEtFTiov7Kslx7cdy/lRFqTsA6xYIytdA0vxnINPvzqiZU5GpIbiT
 75X+bzKRor9y6qoYFC0tIWC0XJ9TT4NtF4Q8/n5W8KPQi7kCmDnaodDF5eV+giiwOJZBczgY96U
 VT4jfCoOcGS8KlXMoPpPRKKyOXO81hxp2L8R+VLPpQMI0D5BpPzYSrK2O/6Zw==
X-Google-Smtp-Source: AGHT+IG5yLdZCv0NBEQ5t0D6skeXCtfggRYAmYdlnTRBqhtU4383Ewl+om5by26V17io1JTU5XCJGA==
X-Received: by 2002:a05:622a:1194:b0:466:b1a2:c03a with SMTP id
 d75a77b69052e-46795422301mr6930701cf.37.1733934738967; 
 Wed, 11 Dec 2024 08:32:18 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 31/69] target/arm: Convert FCVT (scalar) to decodetree
Date: Wed, 11 Dec 2024 10:29:58 -0600
Message-ID: <20241211163036.2297116-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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
index e48dd308fc..b31a6d4dff 100644
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


