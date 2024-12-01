Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47613D49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlX7-0001Zz-67; Sun, 01 Dec 2024 10:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlX5-0001Yz-EN
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:47 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlX2-0004Kb-KA
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:46 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2689e7a941fso1781765fac.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065603; x=1733670403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdLf9DaDKP64c7c7Mfn+J4T6rAGLn69MsNTBGSh+qsY=;
 b=OxoRltIqvpQsZp1gGtQZc8FUdlKbNCrjsrhcxWIiTPg3BWqcrsRFGYYmRWgFbqrANV
 5TGzjTl5eOyCiIrlRMiejWlEaGy8KPOxqVxq+iuCU1F7PqETLCNm976/xQ3Pkqs2Z++e
 r6gO8cPRyXsK1wcyzgnF+AIzMq524M325PXRy4nJbMAKQ39QkVqw880yIRgKqSUXIg3H
 fymkqvfSBAlJ/bZBYJDNY0AMihogOAvz7r+1aVgDI6Mgbkhzr3K+eUZZGEkYgCJH35Qv
 6paOwmVVsxhe0/8tP4fjJgpxiZk8dlZjkdMkERKz+YE/DdFZwB6sHWjvHNcggKnHGOQd
 vUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065603; x=1733670403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KdLf9DaDKP64c7c7Mfn+J4T6rAGLn69MsNTBGSh+qsY=;
 b=NhOaX1a1kLAaisJFgvDEG1jPo0hTMbwgtEyUYUlFqKV/y3ZK/DDXZMjKJ7v3KVO378
 xazFuHCAPN3UQ17djJyMbEjuGtQ3G9N6RnPFlZFlfa5RELjUh2OzOFgkKgfAutDpIZAv
 n04YnEL3GjqnW2whmEe21XIHaJcFu/Vu6utjgMo92ysAH7m4pDbpZEaR0jOYqoGHybqa
 0AFpGHXuQpCGNOpexJQeMpNK1y4mlZjebkcU1CadeamcR0rdbT/zeIhsGGhWmitCO4Dd
 FHm9ytLFyIqt4Ve0YeZeWzi29MEp2v9q9WOTlIA1tp5BfJoPwWGSpUCSgkPx8SDazz3R
 0WvA==
X-Gm-Message-State: AOJu0YzOS3wQyUugvWG0csnND7lSVKHxWsxzoAvn5HAbmtFuutQFvcDU
 OM8yagim4XZT+KAHAULRi4R44tkFh9M5SAMZoogcSrL7TJmhpjwkoe9//O1m9YI9wcqA1Ouhus4
 mCRs=
X-Gm-Gg: ASbGncs+I53abFeSrX4y9Esa8GOq1Atghcf3e2l+vwXPh83mvtradmM9P6AfAFgxKf+
 pCmhkywiVDf6sjZYWIM09YAfkox46pHdabLUCfv/XCuJcEwK+JNpdYgiiLGkBks5Ca3q/748upD
 Q568CrFpqQi/pxNWakFSwnWd0xoF1CKrvx2B8PlU/88FWL77XH1DQ8L7xcDQjRohTeIYFw7FFcT
 fQUsZUZ+OB/yBAMZRO0nluQUa3jUcoHHnPMjxv5UeAtertp0kUPTlXmHC3Zi03dh5tUMWQA7/EL
 EYeVUDO1C3S0PDCqIOwBg1KXdWy8KnUh9W/N
X-Google-Smtp-Source: AGHT+IFelH0ToPtR0v3LLurzRE5AEIStTImBuNR53lrlv3VbKD72e8J+9E7Aki1Hd8TJAbusMukkhw==
X-Received: by 2002:a05:6871:b415:b0:29d:c6ef:cf1d with SMTP id
 586e51a60fabf-29dc6f037bdmr10654678fac.7.1733065603337; 
 Sun, 01 Dec 2024 07:06:43 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 30/67] target/arm: Convert FCVT (scalar) to decodetree
Date: Sun,  1 Dec 2024 09:05:29 -0600
Message-ID: <20241201150607.12812-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Remove handle_fp_fcvt and disas_fp_1src as these were
the last insns decoded by those functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 159 ++++++++++++++-------------------
 target/arm/tcg/a64.decode      |   7 ++
 2 files changed, 74 insertions(+), 92 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 679bdd826c..dacc3269b9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8447,110 +8447,85 @@ TRANS_FEAT(FRINT64Z_s, aa64_frint, do_fp1_scalar, a,
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
@@ -8973,7 +8948,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
                 break;
             case 2: /* [15:12] == x100 */
                 /* Floating point data-processing (1 source) */
-                disas_fp_1src(s, insn);
+                unallocated_encoding(s); /* in decodetree */
                 break;
             case 3: /* [15:12] == 1000 */
                 unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e828834c16..769aac51e9 100644
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


