Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C29C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjW-0002QA-Cb; Sat, 02 Mar 2024 00:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjT-0002PI-JV
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:23 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjQ-0007V1-Bf
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:23 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so1813755a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356579; x=1709961379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNxa07cC8INqvWd4XruP0LHDrSHd5AgnEtvzh0cx2mQ=;
 b=PPUbHTC1kyh1gXKgQILGXMHo8G9ySJqXDFcOhAx8iamWV12hQEQCNXz99HwvMSSXou
 VapdhdijTZ8BcJKaNe+9f7EffbU9IoZT/zODSRpW/pA8+qWwEUITzDm+7Y8XZ0HSnUZv
 S9EVqRC9io52t8ORhMy5iv1ja9KAr3JzEguSRJlBS0Et/0P4JanjiJ8iSIeXKpgVJKqT
 j+XqyobJT4NeNMke1ffi+mZ7aPeA6lpGNN0HCTV1G324/Ql/WxDA1D3I2QlMjNnvphY2
 rstGFFKP6BsJ+1uJha7431w+zEpNVczp2zj4g1GSKRIWXasBC+JnfzOCRYoABFy6/lU7
 iLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356579; x=1709961379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNxa07cC8INqvWd4XruP0LHDrSHd5AgnEtvzh0cx2mQ=;
 b=kX3RQDnkiRoZHJnd0wrR9dANexvpPu6PJ4E910w1WunbkOQ1l8z72AbOpxmlkS2eTI
 SBvt1xzjoQK7sLp7IZdKmxcufIVkt9XnpPJMho8UUt499gJt1cU4tAwKJ33KMyggzgaG
 Ev5iQp07YHCYx/ykZH2zo9u67rbHuXFQjatLeOMnmOChTM1Znl1H7JGJ/TPsP+TkBSR2
 D0z0+FzWUwol9zr4tZkWjmP52Jj9YPLE9zCt3w7IW8lm/PvsUiRfROUmMiurDNsQPPkz
 79UV3bZ4xz1UWT6LnBEyPsw8PipuRGcSdQuX4k/jE7DgfWLrCi6hTXAvRsxyJCkWxv9p
 XfjQ==
X-Gm-Message-State: AOJu0YwvFqAF2ZBlMu4onot3EFOxompmG1OK/AOwb+ztiiRPpdZkLqrw
 e0l2GyHHulJ9AOojfw4j1OSKWLrAtwchtDQTINmFD+JmvCTAZ6HP7z790p3QJmrWWWRL+4srzZl
 +
X-Google-Smtp-Source: AGHT+IHMXNyedWOxPeokVy51BMdLnE63tyceavW0mJUt8tYBQ2YVPlUf2xUjLUrinRzm/Mhw+w0UNg==
X-Received: by 2002:a17:90a:2e02:b0:29a:ac9d:a69d with SMTP id
 q2-20020a17090a2e0200b0029aac9da69dmr4218184pjd.34.1709356578912; 
 Fri, 01 Mar 2024 21:16:18 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 08/41] target/sparc: Perform DFPREG/QFPREG in decodetree
Date: Fri,  1 Mar 2024 19:15:28 -1000
Message-Id: <20240302051601.53649-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Form the proper register decoding from the start.

Because we're removing the translation from the inner-most
gen_load_fpr_* and gen_store_fpr_* routines, this must be
done for all insns at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  |  18 ++--
 target/sparc/insns.decode | 220 +++++++++++++++++++++++---------------
 2 files changed, 138 insertions(+), 100 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6a6c259b06..97a5c636d2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -241,34 +241,30 @@ static void gen_store_fpr_F(DisasContext *dc, unsigned int dst, TCGv_i32 v)
 
 static TCGv_i64 gen_load_fpr_D(DisasContext *dc, unsigned int src)
 {
-    src = DFPREG(src);
     return cpu_fpr[src / 2];
 }
 
 static void gen_store_fpr_D(DisasContext *dc, unsigned int dst, TCGv_i64 v)
 {
-    dst = DFPREG(dst);
     tcg_gen_mov_i64(cpu_fpr[dst / 2], v);
     gen_update_fprs_dirty(dc, dst);
 }
 
 static TCGv_i64 gen_dest_fpr_D(DisasContext *dc, unsigned int dst)
 {
-    return cpu_fpr[DFPREG(dst) / 2];
+    return cpu_fpr[dst / 2];
 }
 
 static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
 {
     TCGv_i128 ret = tcg_temp_new_i128();
 
-    src = QFPREG(src);
     tcg_gen_concat_i64_i128(ret, cpu_fpr[src / 2 + 1], cpu_fpr[src / 2]);
     return ret;
 }
 
 static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
 {
-    dst = DFPREG(dst);
     tcg_gen_extr_i128_i64(cpu_fpr[dst / 2 + 1], cpu_fpr[dst / 2], v);
     gen_update_fprs_dirty(dc, dst);
 }
@@ -2002,16 +1998,14 @@ static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
-    int qd = QFPREG(rd);
-    int qs = QFPREG(rs);
     TCGv c2 = tcg_constant_tl(cmp->c2);
 
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2], cmp->c1, c2,
-                        cpu_fpr[qs / 2], cpu_fpr[qd / 2]);
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2 + 1], cmp->c1, c2,
-                        cpu_fpr[qs / 2 + 1], cpu_fpr[qd / 2 + 1]);
+    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[rd / 2], cmp->c1, c2,
+                        cpu_fpr[rs / 2], cpu_fpr[rd / 2]);
+    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[rd / 2 + 1], cmp->c1, c2,
+                        cpu_fpr[rs / 2 + 1], cpu_fpr[rd / 2 + 1]);
 
-    gen_update_fprs_dirty(dc, qd);
+    gen_update_fprs_dirty(dc, rd);
 #else
     qemu_build_not_reached();
 #endif
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e2d8a07dc4..2c23868fc3 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -26,6 +26,14 @@ CALL    01 i:s30
 ## Major Opcode 10 -- integer, floating-point, vis, and system insns.
 ##
 
+%dfp_rd     25:5 !function=extract_dfpreg
+%dfp_rs1    14:5 !function=extract_dfpreg
+%dfp_rs2     0:5 !function=extract_dfpreg
+
+%qfp_rd     25:5 !function=extract_qfpreg
+%qfp_rs1    14:5 !function=extract_qfpreg
+%qfp_rs2     0:5 !function=extract_qfpreg
+
 &r_r_ri     rd rs1 rs2_or_imm imm:bool
 @n_r_ri     .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri rd=0
 @r_r_ri     .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri
@@ -37,11 +45,40 @@ CALL    01 i:s30
 
 &r_r_r      rd rs1 rs2
 @r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
+@d_r_r      .. ..... ...... rs1:5 . ........ rs2:5         \
+            &r_r_r rd=%dfp_rd
+@r_d_d      .. rd:5  ...... ..... . ........ .....         \
+            &r_r_r rs1=%dfp_rs1 rs2=%dfp_rs2
+@d_r_d      .. ..... ...... rs1:5 . ........ .....         \
+            &r_r_r rd=%dfp_rd rs2=%dfp_rs2
+@d_d_d      .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%dfp_rd rs1=%dfp_rs1 rs2=%dfp_rs2
+@q_q_q      .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%qfp_rd rs1=%qfp_rs1 rs2=%qfp_rs2
+@q_d_d      .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%qfp_rd rs1=%dfp_rs1 rs2=%dfp_rs2
+
 @r_r_r_swap .. rd:5  ...... rs2:5 . ........ rs1:5         &r_r_r
+@d_d_d_swap .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%dfp_rd rs1=%dfp_rs2 rs2=%dfp_rs1
 
 &r_r        rd rs
 @r_r1       .. rd:5  ...... rs:5  . ........ .....         &r_r
 @r_r2       .. rd:5  ...... ..... . ........ rs:5          &r_r
+@r_d2       .. rd:5  ...... ..... . ........ .....         &r_r rs=%dfp_rs2
+@r_q2       .. rd:5  ...... ..... . ........ .....         &r_r rs=%qfp_rs2
+@d_r2       .. ..... ...... ..... . ........ rs:5          &r_r rd=%dfp_rd
+@q_r2       .. ..... ...... ..... . ........ rs:5          &r_r rd=%qfp_rd
+@d_d1       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%dfp_rd rs=%dfp_rs1
+@d_d2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%dfp_rd rs=%dfp_rs2
+@d_q2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%dfp_rd rs=%qfp_rs2
+@q_q2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%qfp_rd rs=%qfp_rs2
+@q_d2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%qfp_rd rs=%dfp_rs2
 
 {
   [
@@ -241,68 +278,78 @@ DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
 FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
-FMOVd       10 ..... 110100 00000 0 0000 0010 .....        @r_r2
-FMOVq       10 ..... 110100 00000 0 0000 0011 .....        @r_r2
+FMOVd       10 ..... 110100 00000 0 0000 0010 .....        @d_d2
+FMOVq       10 ..... 110100 00000 0 0000 0011 .....        @q_q2
 FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
-FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
-FNEGq       10 ..... 110100 00000 0 0000 0111 .....        @r_r2
+FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @d_d2
+FNEGq       10 ..... 110100 00000 0 0000 0111 .....        @q_q2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
-FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
-FABSq       10 ..... 110100 00000 0 0000 1011 .....        @r_r2
+FABSd       10 ..... 110100 00000 0 0000 1010 .....        @d_d2
+FABSq       10 ..... 110100 00000 0 0000 1011 .....        @q_q2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
-FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
-FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
+FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @d_d2
+FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @q_q2
 FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
-FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @r_r_r
-FADDq       10 ..... 110100 ..... 0 0100 0011 .....        @r_r_r
+FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @d_d_d
+FADDq       10 ..... 110100 ..... 0 0100 0011 .....        @q_q_q
 FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
-FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @r_r_r
-FSUBq       10 ..... 110100 ..... 0 0100 0111 .....        @r_r_r
+FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @d_d_d
+FSUBq       10 ..... 110100 ..... 0 0100 0111 .....        @q_q_q
 FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
-FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @r_r_r
-FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
+FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @d_d_d
+FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @q_q_q
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
-FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
-FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
-FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
-FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
+FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @d_d_d
+FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @q_q_q
+FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @d_r_r
+FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
-FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
-FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
-FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
-FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @r_r2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
-FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
-FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
-FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
-FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
-FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
-FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
-FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
-FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @r_r2
+FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_d2
+FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_q2
+FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @d_r2
+FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @d_r2
+FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @d_q2
+FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @q_r2
+FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @q_r2
+FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @q_d2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
-FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
-FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
+FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_d2
+FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_q2
 
 FMOVscc     10 rd:5  110101 0 cond:4 1 cc:1 0 000001 rs2:5
-FMOVdcc     10 rd:5  110101 0 cond:4 1 cc:1 0 000010 rs2:5
-FMOVqcc     10 rd:5  110101 0 cond:4 1 cc:1 0 000011 rs2:5
+FMOVdcc     10 ..... 110101 0 cond:4 1 cc:1 0 000010 ..... \
+            rd=%dfp_rd rs2=%dfp_rs2
+FMOVqcc     10 ..... 110101 0 cond:4 1 cc:1 0 000011 ..... \
+            rd=%qfp_rd rs2=%qfp_rs2
 
 FMOVsfcc    10 rd:5  110101 0 cond:4 0 cc:2   000001 rs2:5
-FMOVdfcc    10 rd:5  110101 0 cond:4 0 cc:2   000010 rs2:5
-FMOVqfcc    10 rd:5  110101 0 cond:4 0 cc:2   000011 rs2:5
+FMOVdfcc    10 ..... 110101 0 cond:4 0 cc:2   000010 ..... \
+            rd=%dfp_rd rs2=%dfp_rs2
+FMOVqfcc    10 ..... 110101 0 cond:4 0 cc:2   000011 ..... \
+            rd=%qfp_rd rs2=%qfp_rs2
 
 FMOVRs      10 rd:5  110101 rs1:5    0 cond:3  00101 rs2:5
-FMOVRd      10 rd:5  110101 rs1:5    0 cond:3  00110 rs2:5
-FMOVRq      10 rd:5  110101 rs1:5    0 cond:3  00111 rs2:5
+FMOVRd      10 ..... 110101 rs1:5    0 cond:3  00110 ..... \
+            rd=%dfp_rd rs2=%dfp_rs2
+FMOVRq      10 ..... 110101 rs1:5    0 cond:3  00111 ..... \
+            rd=%qfp_rd rs2=%qfp_rs2
 
 FCMPs       10 000 cc:2 110101 rs1:5  0 0101 0001 rs2:5
-FCMPd       10 000 cc:2 110101 rs1:5  0 0101 0010 rs2:5
-FCMPq       10 000 cc:2 110101 rs1:5  0 0101 0011 rs2:5
+FCMPd       10 000 cc:2 110101 .....  0 0101 0010 .....    \
+            rs1=%dfp_rs1 rs2=%dfp_rs2
+FCMPq       10 000 cc:2 110101 .....  0 0101 0011 .....    \
+            rs1=%qfp_rs1 rs2=%qfp_rs2
 FCMPEs      10 000 cc:2 110101 rs1:5  0 0101 0101 rs2:5
-FCMPEd      10 000 cc:2 110101 rs1:5  0 0101 0110 rs2:5
-FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
+FCMPEd      10 000 cc:2 110101 .....  0 0101 0110 .....    \
+            rs1=%dfp_rs1 rs2=%dfp_rs2
+FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
+            rs1=%qfp_rs1 rs2=%qfp_rs2
 
 {
   [
@@ -328,74 +375,74 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
-    FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_r_r
-    FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_r_r
-    FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_r_r
-    FPCMPEQ16   10 ..... 110110 ..... 0 0010 1010 .....    @r_r_r
-    FPCMPLE32   10 ..... 110110 ..... 0 0010 0100 .....    @r_r_r
-    FPCMPNE32   10 ..... 110110 ..... 0 0010 0110 .....    @r_r_r
-    FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_r_r
-    FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_r_r
+    FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_d_d
+    FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_d_d
+    FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_d_d
+    FPCMPEQ16   10 ..... 110110 ..... 0 0010 1010 .....    @r_d_d
+    FPCMPLE32   10 ..... 110110 ..... 0 0010 0100 .....    @r_d_d
+    FPCMPNE32   10 ..... 110110 ..... 0 0010 0110 .....    @r_d_d
+    FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_d_d
+    FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_d_d
 
-    FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @r_r_r
-    FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @r_r_r
-    FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @r_r_r
-    FMUL8SUx16  10 ..... 110110 ..... 0 0011 0110 .....    @r_r_r
-    FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
-    FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
-    FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
-    FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @r_r_r
-    FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @r_r2
-    FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_r2
-    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
+    FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @d_r_d
+    FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @d_r_r
+    FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @d_r_r
+    FMUL8SUx16  10 ..... 110110 ..... 0 0011 0110 .....    @d_d_d
+    FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @d_d_d
+    FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @d_r_r
+    FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @d_r_r
+    FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @d_d_d
+    FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @d_d2
+    FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @d_d2
+    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @d_d_d
 
-    FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
-    FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
-    BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @r_r_r
-    FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @r_r2
+    FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
+    FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
+    BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @d_d_d
+    FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @r_d2
 
-    FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
+    FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @d_d1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
-    FSRCd       10 ..... 110110 00000 0 0111 1000 .....    @r_r2  # FSRC2d
+    FSRCd       10 ..... 110110 00000 0 0111 1000 .....    @d_d2  # FSRC2d
     FSRCs       10 ..... 110110 00000 0 0111 1001 .....    @r_r2  # FSRC2s
-    FNOTd       10 ..... 110110 ..... 0 0110 1010 00000    @r_r1  # FNOT1d
+    FNOTd       10 ..... 110110 ..... 0 0110 1010 00000    @d_d1  # FNOT1d
     FNOTs       10 ..... 110110 ..... 0 0110 1011 00000    @r_r1  # FNOT1s
-    FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @r_r2  # FNOT2d
+    FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @d_d2  # FNOT2d
     FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
 
-    FPADD16     10 ..... 110110 ..... 0 0101 0000 .....    @r_r_r
+    FPADD16     10 ..... 110110 ..... 0 0101 0000 .....    @d_d_d
     FPADD16s    10 ..... 110110 ..... 0 0101 0001 .....    @r_r_r
-    FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @r_r_r
+    FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @d_d_d
     FPADD32s    10 ..... 110110 ..... 0 0101 0011 .....    @r_r_r
-    FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @r_r_r
+    FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @d_d_d
     FPSUB16s    10 ..... 110110 ..... 0 0101 0101 .....    @r_r_r
-    FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @r_r_r
+    FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @d_d_d
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
 
-    FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @r_r_r
+    FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @d_d_d
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
-    FANDNOTd    10 ..... 110110 ..... 0 0110 0100 .....    @r_r_r   # FANDNOT2d
+    FANDNOTd    10 ..... 110110 ..... 0 0110 0100 .....    @d_d_d   # FANDNOT2d
     FANDNOTs    10 ..... 110110 ..... 0 0110 0101 .....    @r_r_r   # FANDNOT2s
-    FANDNOTd    10 ..... 110110 ..... 0 0110 1000 .....    @r_r_r_swap # ... 1d
+    FANDNOTd    10 ..... 110110 ..... 0 0110 1000 .....    @d_d_d_swap # ... 1d
     FANDNOTs    10 ..... 110110 ..... 0 0110 1001 .....    @r_r_r_swap # ... 1s
-    FXORd       10 ..... 110110 ..... 0 0110 1100 .....    @r_r_r
+    FXORd       10 ..... 110110 ..... 0 0110 1100 .....    @d_d_d
     FXORs       10 ..... 110110 ..... 0 0110 1101 .....    @r_r_r
-    FNANDd      10 ..... 110110 ..... 0 0110 1110 .....    @r_r_r
+    FNANDd      10 ..... 110110 ..... 0 0110 1110 .....    @d_d_d
     FNANDs      10 ..... 110110 ..... 0 0110 1111 .....    @r_r_r
-    FANDd       10 ..... 110110 ..... 0 0111 0000 .....    @r_r_r
+    FANDd       10 ..... 110110 ..... 0 0111 0000 .....    @d_d_d
     FANDs       10 ..... 110110 ..... 0 0111 0001 .....    @r_r_r
-    FXNORd      10 ..... 110110 ..... 0 0111 0010 .....    @r_r_r
+    FXNORd      10 ..... 110110 ..... 0 0111 0010 .....    @d_d_d
     FXNORs      10 ..... 110110 ..... 0 0111 0011 .....    @r_r_r
-    FORNOTd     10 ..... 110110 ..... 0 0111 0110 .....    @r_r_r    # FORNOT2d
+    FORNOTd     10 ..... 110110 ..... 0 0111 0110 .....    @d_d_d    # FORNOT2d
     FORNOTs     10 ..... 110110 ..... 0 0111 0111 .....    @r_r_r    # FORNOT2s
-    FORNOTd     10 ..... 110110 ..... 0 0111 1010 .....    @r_r_r_swap # ... 1d
+    FORNOTd     10 ..... 110110 ..... 0 0111 1010 .....    @d_d_d_swap # ... 1d
     FORNOTs     10 ..... 110110 ..... 0 0111 1011 .....    @r_r_r_swap # ... 1s
-    FORd        10 ..... 110110 ..... 0 0111 1100 .....    @r_r_r
+    FORd        10 ..... 110110 ..... 0 0111 1100 .....    @d_d_d
     FORs        10 ..... 110110 ..... 0 0111 1101 .....    @r_r_r
 
-    FZEROd      10 rd:5  110110 00000 0 0110 0000 00000
+    FZEROd      10 ..... 110110 00000 0 0110 0000 00000    rd=%dfp_rd
     FZEROs      10 rd:5  110110 00000 0 0110 0001 00000
-    FONEd       10 rd:5  110110 00000 0 0111 1110 00000
+    FONEd       10 ..... 110110 00000 0 0111 1110 00000    rd=%dfp_rd
     FONEs       10 rd:5  110110 00000 0 0111 1111 00000
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
@@ -407,9 +454,6 @@ NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 ## Major Opcode 11 -- load and store instructions
 ##
 
-%dfp_rd     25:5 !function=extract_dfpreg
-%qfp_rd     25:5 !function=extract_qfpreg
-
 &r_r_ri_asi rd rs1 rs2_or_imm asi imm:bool
 @r_r_ri_na  .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri_asi asi=-1
 @d_r_ri_na  .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     \
-- 
2.34.1


