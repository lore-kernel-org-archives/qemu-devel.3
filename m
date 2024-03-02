Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE9C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjk-0002Uk-Lo; Sat, 02 Mar 2024 00:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjh-0002Tk-Ro
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:37 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjg-0007YE-76
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:37 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so2091985a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356595; x=1709961395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3lhfoCFirnepvvopi9QZLqqlY2uYLR9Y0owrTZTqqw=;
 b=jI7caolP6WyFVgO6P1owrw8Mcg0jYzK3zU6cbUubREpcvFBLDoa1l0f9UusPmct1d2
 xwpCah/vJG2KzZlfko7h0ZE3usvJaRCOo5MlmLOo9SEQCvyN4XOySdmY6RkOFtWPB+ns
 BEPNMD8zIbH2AXG6goizUxnRc9gEnnhN8yxE9DS20attdS4IJ93YvSApG/EQSvKnUgpV
 asMpNlkupisgN/vv1w7Yd1B77Y51YaB0gUhy1GIfevLaYzSwehTQ2KA/9kDtF2uWRgNB
 vYNdRVaCLQ0vI9ahc32Vo3Mc7zIYXHw6Dwox737JtB7Ry3prq753C7OYAfUfjJ6HwWLt
 AMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356595; x=1709961395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3lhfoCFirnepvvopi9QZLqqlY2uYLR9Y0owrTZTqqw=;
 b=fTCX75madc5aTHim6KxU8S8tznaQtJ+zUKdQq6WrbRJQD4XgGtQSKwK/bIFvcbdDiw
 K5uU/EbiDkSvkue2peMUrq8YwelJ5vNpMMscww4Sf0eWrbhXaedxSXh/cpOVP3jTVJ4F
 a5T/N9mRQjAeeEO7zqv5W/9u18yYT/HfoCBwgwStzhHMXMZps0808+imgYWgviMIbKw7
 53nfp7pZwPurmtcaFRxVVbYZ5ntm5AYLlnx/i4pK8SQf9raahISMzspneh1lMpoaTw5g
 g5NXfLktXFtC0DgDF3JQbqWaOPeVAlLPF+bW7p10GjNUHBUlU5jtzEsvXuLfYdXP/Dwu
 Id4g==
X-Gm-Message-State: AOJu0Yzaqduwa9f8+djfeF1+nBV3rjQPLwWoa5xwHNsnY1e5vsOeK9N2
 bUQiKVqG/W2MfmxydAaBGNSuDr04X08AJHHlHBQ6L01xABpPsVGZJKuxVoPtt40WYZDkByCVWb9
 1
X-Google-Smtp-Source: AGHT+IEfcnAhaF4E88Hz322mRdtahDgmuj5SxW94VtXVPD93w8TQjNWG9owMQUVTy4IP3d6owlYCpA==
X-Received: by 2002:a05:6a20:1607:b0:1a1:3b27:4f40 with SMTP id
 l7-20020a056a20160700b001a13b274f40mr3434898pzj.10.1709356595014; 
 Fri, 01 Mar 2024 21:16:35 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 17/41] target/sparc: Implement FHADD, FHSUB, FNHADD, FNADD
Date: Fri,  1 Mar 2024 19:15:37 -1000
Message-Id: <20240302051601.53649-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 70 +++++++++++++++++++++++++++++++++++++++
 target/sparc/insns.decode |  8 +++++
 2 files changed, 78 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d6adbf9236..877847b884 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1243,6 +1243,66 @@ static void gen_op_fnmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
     gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
 }
 
+/* Use muladd to compute (1 * src1) + src2 / 2 with one rounding. */
+static void gen_op_fhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    TCGv_i32 one = tcg_constant_i32(float32_one);
+    int op = float_muladd_halve_result;
+    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+static void gen_op_fhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
+{
+    TCGv_i64 one = tcg_constant_i64(float64_one);
+    int op = float_muladd_halve_result;
+    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+/* Use muladd to compute (1 * src1) - src2 / 2 with one rounding. */
+static void gen_op_fhsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    TCGv_i32 one = tcg_constant_i32(float32_one);
+    int op = float_muladd_negate_c | float_muladd_halve_result;
+    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+static void gen_op_fhsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
+{
+    TCGv_i64 one = tcg_constant_i64(float64_one);
+    int op = float_muladd_negate_c | float_muladd_halve_result;
+    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+/* Use muladd to compute -((1 * src1) + src2 / 2) with one rounding. */
+static void gen_op_fnhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    TCGv_i32 one = tcg_constant_i32(float32_one);
+    int op = float_muladd_negate_result | float_muladd_halve_result;
+    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+static void gen_op_fnhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
+{
+    TCGv_i64 one = tcg_constant_i64(float64_one);
+    int op = float_muladd_negate_result | float_muladd_halve_result;
+    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+/* Use muladd to compute -((1 * src1) + src2). */
+static void gen_op_fnadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    TCGv_i32 one = tcg_constant_i32(float32_one);
+    int op = float_muladd_negate_result;
+    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+static void gen_op_fnaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
+{
+    TCGv_i64 one = tcg_constant_i64(float64_one);
+    int op = float_muladd_negate_result;
+    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
 static void gen_op_fpexception_im(DisasContext *dc, int ftt)
 {
     /*
@@ -4691,6 +4751,11 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
 TRANS(FORNOTs, VIS1, do_fff, a, tcg_gen_orc_i32)
 TRANS(FORs, VIS1, do_fff, a, tcg_gen_or_i32)
 
+TRANS(FHADDs, VIS3, do_fff, a, gen_op_fhadds)
+TRANS(FHSUBs, VIS3, do_fff, a, gen_op_fhsubs)
+TRANS(FNHADDs, VIS3, do_fff, a, gen_op_fnhadds)
+TRANS(FNADDs, VIS3, do_fff, a, gen_op_fnadds)
+
 static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
@@ -4804,6 +4869,11 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+TRANS(FHADDd, VIS3, do_ddd, a, gen_op_fhaddd)
+TRANS(FHSUBd, VIS3, do_ddd, a, gen_op_fhsubd)
+TRANS(FNHADDd, VIS3, do_ddd, a, gen_op_fnhaddd)
+TRANS(FNADDd, VIS3, do_ddd, a, gen_op_fnaddd)
+
 static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv_i64, TCGv_i64))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 120713a28f..dc524f5b8f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -307,8 +307,16 @@ FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @q_q_q
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @d_d_d
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @q_q_q
+FNADDs      10 ..... 110100 ..... 0 0101 0001 .....        @r_r_r
+FNADDd      10 ..... 110100 ..... 0 0101 0010 .....        @d_d_d
+FHADDs      10 ..... 110100 ..... 0 0110 0001 .....        @r_r_r
+FHADDd      10 ..... 110100 ..... 0 0110 0010 .....        @d_d_d
+FHSUBs      10 ..... 110100 ..... 0 0110 0101 .....        @r_r_r
+FHSUBd      10 ..... 110100 ..... 0 0110 0110 .....        @d_d_d
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @d_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
+FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
+FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
-- 
2.34.1


