Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B064CE77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL33L-0002tO-Aj; Tue, 10 Dec 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32T-0007ut-3i
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:48 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32Q-0007ZQ-70
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:44 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso2540809e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847880; x=1734452680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjNCXqWLXBfOyQBfYtoOK+ENmcPrhXIDdj2qnDqUAHQ=;
 b=rfwv6EP7u02Undpu5ZIIsq8Nflri1YUslmRBk/fYeXp3G6vBV+R5xIhgZUwXT0OFhE
 XaYNSOUZYNGk3JpoPYHWXitGEB1285WqpFtPkp3keORnJViU5AcQx7PhxpOK27Rc4wy6
 T5XUV43kzVW8NGra8hM4ZQc28mf+swhqXTdAzormYn2LRnWswizaP7NsyHu0qaelDZby
 HPYGGpt8VB8wuNLIkiVN4q7LPStPwLXO67W56PgCuSAwgE0wiRtW5zj4QH8pnKzy6UTW
 DEAJPMPdFvvyOyLBNU03FhL/g2rOynNIoXOyJHZLLaoBnNneQMJ8xuuAGd3wpT2hIoTU
 ihTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847880; x=1734452680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjNCXqWLXBfOyQBfYtoOK+ENmcPrhXIDdj2qnDqUAHQ=;
 b=XKm/aYFxc/Z+mYM5PEXd+2NFd8nRNgo3DhebZXJP2NzZOaOWhGtcHXdEu9UEsuqjUO
 1n94gR1G++J2m0BNofhRl54ACCzaJfFyBLV5bubfwjEMWdYJDo7uP4iv+2dAuKEzsyKU
 I8vSEPTFCsm36Glzy+JPdqD4N1FWuOM5/IcapE29JkXmpme+r5Fv5Y3AlSlLeuZ7Dihz
 p0ytIWW26PsMfXyaLXzZ7Vd9XiFHPupQ+hlDBvYDiC3Ucj88T/4OyJWpDF/rih160Ecp
 hw4BbndLZSmZTi1w+cdyydU6qW6NBAChIjlyN/2iRjuiGTCR22wb6PwzhNoyuubUmLNd
 8fcA==
X-Gm-Message-State: AOJu0YwZTl1rLxd/JsefySl9LVaf36FvKOJ+GeT/uwa1FCFyDQyKgI33
 KhIJ9TINdBd9fsj3SILZCTl0fVF/VmNZcdHojijprHqgzYuYdF5VVkg7gVUo0z/NHX4pylfznE2
 6tkjhA1cz
X-Gm-Gg: ASbGncv3aTYdQ412WWAyIfA1DymKh2S8esQePPn1Df9EpHWZyBkXnzOFzRzc5Ju42AV
 sDC4tWsTnxVZEvvKgu6wgFvnl7v+cAjnodoX0XBkq/G0dZ1GHq9SX0ZfCl0AgPZUIa52kdXJAQf
 ESoWTNeYEKQGLTPlEWQ+ukCkxCpBJ6kudpB2EtxOaTUGE7s3b4q2ePj3adJLxn8JZyhtmPZBXip
 92HzZpPBFjZS7ufzizfokjEtkDJXJl0pfOkLU+JWoNOAFmun/hv9IemzSw=
X-Google-Smtp-Source: AGHT+IEI94Bb1AazIxMnKcq8Ed0CJHI5WrpFje7yfSL1sGMDvGAmEfy1lDNgfvv1qlWu1Jpr1QkzGg==
X-Received: by 2002:a05:6512:3d11:b0:53e:3a01:cf4d with SMTP id
 2adb3069b0e04-540240d1138mr1928041e87.31.1733847880500; 
 Tue, 10 Dec 2024 08:24:40 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 59/69] target/arm: Convert [US]CVTF (vector,
 integer) scalar to decodetree
Date: Tue, 10 Dec 2024 10:17:23 -0600
Message-ID: <20241210161733.1830573-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++----------
 target/arm/tcg/a64.decode      |  6 ++++++
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 894befef4d..6e9d040ebf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8599,6 +8599,29 @@ static bool do_cvtf_g(DisasContext *s, arg_fcvt *a, bool is_signed)
 TRANS(SCVTF_g, do_cvtf_g, a, true)
 TRANS(UCVTF_g, do_cvtf_g, a, false)
 
+/*
+ * [US]CVTF (vector), scalar version.
+ * Which sounds weird, but really just means input from fp register
+ * instead of input from general register.  Input and output element
+ * size are always equal.
+ */
+static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = tcg_temp_new_i64();
+    read_vec_element(s, tcg_int, a->rn, 0, a->esz | (is_signed ? MO_SIGN : 0));
+    return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
+}
+
+TRANS(SCVTF_f, do_cvtf_f, a, true)
+TRANS(UCVTF_f, do_cvtf_f, a, false)
+
 static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
                            TCGv_i64 tcg_out, int shift, int rn,
                            ARMFPRounding rmode)
@@ -9838,16 +9861,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x6d: /* FCMLE (zero) */
             handle_2misc_fcmp_zero(s, opcode, true, u, true, size, rn, rd);
             return;
-        case 0x1d: /* SCVTF */
-        case 0x5d: /* UCVTF */
-        {
-            bool is_signed = (opcode == 0x1d);
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_simd_intfp_conv(s, rd, rn, 1, is_signed, 0, size);
-            return;
-        }
         case 0x3d: /* FRECPE */
         case 0x3f: /* FRECPX */
         case 0x7d: /* FRSQRTE */
@@ -9867,6 +9880,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x1c: /* FCVTAS */
         case 0x5c: /* FCVTAU */
         case 0x56: /* FCVTXN, FCVTXN2 */
+        case 0x1d: /* SCVTF */
+        case 0x5d: /* UCVTF */
         default:
             unallocated_encoding(s);
             return;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f66f62da4f..146500d9c4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1657,6 +1657,12 @@ FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
 @icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
                 &fcvt sf=0 esz=%esz_sd shift=0
 
+SCVTF_f         0101 1110 011 11001 11011 0 ..... .....     @icvt_h
+SCVTF_f         0101 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
+UCVTF_f         0111 1110 011 11001 11011 0 ..... .....     @icvt_h
+UCVTF_f         0111 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
 FCVTNS_f        0101 1110 011 11001 10101 0 ..... .....     @icvt_h
 FCVTNS_f        0101 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
 FCVTNU_f        0111 1110 011 11001 10101 0 ..... .....     @icvt_h
-- 
2.43.0


