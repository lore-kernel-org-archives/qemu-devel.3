Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C0C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zn-0004Qr-CU; Fri, 31 May 2024 08:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zi-0004Of-73
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:28 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zW-0003Pr-K6
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:25 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e72b8931caso20754251fa.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157052; x=1717761852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RxWUOGj99kPJp0phlJ640vUVgHEa32xMmNTfZFZibG8=;
 b=F8rqENl+/M/i24SEyxP5dmWevTkiYC084ovhlgi+FG8E0v+RgLjPBYHF5/doGbuudU
 SCPC9/t82L9ttphMIoT3mgK9qa/61OH4OtBKDXyJ3o9+wdeHMgajoanGvZmT0pJaX5Dk
 zq8tdZ4lKlGHr8M7lmUNcsJVGEerDpd/JBQGU81Zp05+2NE9HhncKVP+3sOEu0Too4I6
 LKi/tv0hsC/RfOIpTwyN2MyFOso1sqf6r3g7i34JdZVFpLFRVLq/InpyoefTmtMMMpjK
 TAsLtNNScnUrT2x+eE13oTnsg1BAp4Z+UNQXKQvjYoDjU+9U3bq+MQPUovsJPnECH7le
 r02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157052; x=1717761852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RxWUOGj99kPJp0phlJ640vUVgHEa32xMmNTfZFZibG8=;
 b=kIbAD40GuQ2DYd9YD+fx0uykqFUmqqpxZ86jdun6LBBM/ophiW7ZlF9UdmxhjfW2kT
 6r5mrzrx7PktaEWnU3UEdeKJYAyVoXvfb0dJ9Ea9rl0TIlEU/qQdwn9gpcPrCXEl7psD
 5ob8DjMqaGbQikt3/wzZ0PHbDniPz1OUFlRhgZ5M700Mg9D93JXGkXdxHEwQyjGQvmhE
 oq8c9qqZd7StrgC0XeE+BBvGgG2lj8N2ez5Kfq1VZjR/AXT4w6VQr9S5avxDtXcup9io
 hnWYwNjbDADPBDmD3+uAfEgdeTtHrX9g9wTTTNgfhaZ6uiIJqMTiTMO2ekkQoF1HmuO+
 idmQ==
X-Gm-Message-State: AOJu0YxbM4d7qMn0i2WnGTn8vJphm7t9e+U65zAKMteHiNUIMdckDhRt
 g+x21mq0CI4322cZ3MEjIQouDi3lQVGrm/DboHhCfLl4CI3kmO5ZYaHtbh0ntIayOR7eAby2rW1
 B
X-Google-Smtp-Source: AGHT+IG5qWYnREFDlUS43jsr15RTXRgedqHpTjUQOcpase7zdtivKHUMbXs6ENq0UEcaYmyKj8kzPw==
X-Received: by 2002:a2e:bea5:0:b0:2e2:72a7:843c with SMTP id
 38308e7fff4ca-2ea951aaa16mr13702501fa.36.1717157051665; 
 Fri, 31 May 2024 05:04:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/43] target/arm: Inline scalar SQADD, UQADD, SQSUB, UQSUB
Date: Fri, 31 May 2024 13:03:29 +0100
Message-Id: <20240531120401.394550-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This eliminates the last uses of these neon helpers.
Incorporate the MO_64 expanders as an option to the vector expander.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  17 ----
 target/arm/tcg/translate.h     |  15 +++
 target/arm/tcg/gengvec.c       | 116 +++++++++++++++++++++++
 target/arm/tcg/neon_helper.c   | 162 ---------------------------------
 target/arm/tcg/translate-a64.c |  67 ++++++++------
 5 files changed, 169 insertions(+), 208 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index c76158d6d3f..a14c040451e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -268,23 +268,6 @@ DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
 DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
 
 /* neon_helper.c */
-DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_u16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_s16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_u32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_s32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_u8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_u16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_u32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qadd_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qadd_s64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qsub_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qsub_s64, i64, env, i64, i64)
-
 DEF_HELPER_2(neon_hadd_s8, i32, i32, i32)
 DEF_HELPER_2(neon_hadd_u8, i32, i32, i32)
 DEF_HELPER_2(neon_hadd_s16, i32, i32, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3abdbedfe5c..87439dcc612 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -466,12 +466,27 @@ void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
 void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
+void gen_uqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
+                   TCGv_i64 a, TCGv_i64 b, MemOp esz);
+void gen_uqadd_d(TCGv_i64 d, TCGv_i64 q, TCGv_i64 a, TCGv_i64 b);
 void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
+void gen_sqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
+                   TCGv_i64 a, TCGv_i64 b, MemOp esz);
+void gen_sqadd_d(TCGv_i64 d, TCGv_i64 q, TCGv_i64 a, TCGv_i64 b);
 void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
+void gen_uqsub_bhs(TCGv_i64 res, TCGv_i64 qc,
+                   TCGv_i64 a, TCGv_i64 b, MemOp esz);
+void gen_uqsub_d(TCGv_i64 d, TCGv_i64 q, TCGv_i64 a, TCGv_i64 b);
 void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
+void gen_sqsub_bhs(TCGv_i64 res, TCGv_i64 qc,
+                   TCGv_i64 a, TCGv_i64 b, MemOp esz);
+void gen_sqsub_d(TCGv_i64 d, TCGv_i64 q, TCGv_i64 a, TCGv_i64 b);
 void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 3e2d3c21a13..740f3f864e5 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1218,6 +1218,28 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+void gen_uqadd_bhs(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b, MemOp esz)
+{
+    uint64_t max = MAKE_64BIT_MASK(0, 8 << esz);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_add_i64(tmp, a, b);
+    tcg_gen_umin_i64(res, tmp, tcg_constant_i64(max));
+    tcg_gen_xor_i64(tmp, tmp, res);
+    tcg_gen_or_i64(qc, qc, tmp);
+}
+
+void gen_uqadd_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_add_i64(t, a, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, res, t, a,
+                        tcg_constant_i64(UINT64_MAX), t);
+    tcg_gen_xor_i64(t, t, res);
+    tcg_gen_or_i64(qc, qc, t);
+}
+
 static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
@@ -1251,6 +1273,7 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fniv = gen_uqadd_vec,
+          .fni8 = gen_uqadd_d,
           .fno = gen_helper_gvec_uqadd_d,
           .write_aofs = true,
           .opt_opc = vecop_list,
@@ -1262,6 +1285,41 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+void gen_sqadd_bhs(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b, MemOp esz)
+{
+    int64_t max = MAKE_64BIT_MASK(0, (8 << esz) - 1);
+    int64_t min = -1ll - max;
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_add_i64(tmp, a, b);
+    tcg_gen_smin_i64(res, tmp, tcg_constant_i64(max));
+    tcg_gen_smax_i64(res, res, tcg_constant_i64(min));
+    tcg_gen_xor_i64(tmp, tmp, res);
+    tcg_gen_or_i64(qc, qc, tmp);
+}
+
+void gen_sqadd_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_add_i64(t0, a, b);
+
+    /* Compute signed overflow indication into T1 */
+    tcg_gen_xor_i64(t1, a, b);
+    tcg_gen_xor_i64(t2, t0, a);
+    tcg_gen_andc_i64(t1, t2, t1);
+
+    /* Compute saturated value into T2 */
+    tcg_gen_sari_i64(t2, a, 63);
+    tcg_gen_xori_i64(t2, t2, INT64_MAX);
+
+    tcg_gen_movcond_i64(TCG_COND_LT, res, t1, tcg_constant_i64(0), t2, t0);
+    tcg_gen_xor_i64(t0, t0, res);
+    tcg_gen_or_i64(qc, qc, t0);
+}
+
 static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
@@ -1295,6 +1353,7 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_sqadd_vec,
+          .fni8 = gen_sqadd_d,
           .fno = gen_helper_gvec_sqadd_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
@@ -1306,6 +1365,26 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+void gen_uqsub_bhs(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b, MemOp esz)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(tmp, a, b);
+    tcg_gen_smax_i64(res, tmp, tcg_constant_i64(0));
+    tcg_gen_xor_i64(tmp, tmp, res);
+    tcg_gen_or_i64(qc, qc, tmp);
+}
+
+void gen_uqsub_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, res, a, b, tcg_constant_i64(0), t);
+    tcg_gen_xor_i64(t, t, res);
+    tcg_gen_or_i64(qc, qc, t);
+}
+
 static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
@@ -1339,6 +1418,7 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_uqsub_vec,
+          .fni8 = gen_uqsub_d,
           .fno = gen_helper_gvec_uqsub_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
@@ -1350,6 +1430,41 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+void gen_sqsub_bhs(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b, MemOp esz)
+{
+    int64_t max = MAKE_64BIT_MASK(0, (8 << esz) - 1);
+    int64_t min = -1ll - max;
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(tmp, a, b);
+    tcg_gen_smin_i64(res, tmp, tcg_constant_i64(max));
+    tcg_gen_smax_i64(res, res, tcg_constant_i64(min));
+    tcg_gen_xor_i64(tmp, tmp, res);
+    tcg_gen_or_i64(qc, qc, tmp);
+}
+
+void gen_sqsub_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t0, a, b);
+
+    /* Compute signed overflow indication into T1 */
+    tcg_gen_xor_i64(t1, a, b);
+    tcg_gen_xor_i64(t2, t0, a);
+    tcg_gen_and_i64(t1, t1, t2);
+
+    /* Compute saturated value into T2 */
+    tcg_gen_sari_i64(t2, a, 63);
+    tcg_gen_xori_i64(t2, t2, INT64_MAX);
+
+    tcg_gen_movcond_i64(TCG_COND_LT, res, t1, tcg_constant_i64(0), t2, t0);
+    tcg_gen_xor_i64(t0, t0, res);
+    tcg_gen_or_i64(qc, qc, t0);
+}
+
 static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
@@ -1383,6 +1498,7 @@ void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_sqsub_vec,
+          .fni8 = gen_sqsub_d,
           .fno = gen_helper_gvec_sqsub_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 9505a5fd18e..0af15e9f6ef 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -155,168 +155,6 @@ uint32_t HELPER(glue(neon_,name))(uint32_t arg) \
     return arg; \
 }
 
-
-#define NEON_USAT(dest, src1, src2, type) do { \
-    uint32_t tmp = (uint32_t)src1 + (uint32_t)src2; \
-    if (tmp != (type)tmp) { \
-        SET_QC(); \
-        dest = ~0; \
-    } else { \
-        dest = tmp; \
-    }} while(0)
-#define NEON_FN(dest, src1, src2) NEON_USAT(dest, src1, src2, uint8_t)
-NEON_VOP_ENV(qadd_u8, neon_u8, 4)
-#undef NEON_FN
-#define NEON_FN(dest, src1, src2) NEON_USAT(dest, src1, src2, uint16_t)
-NEON_VOP_ENV(qadd_u16, neon_u16, 2)
-#undef NEON_FN
-#undef NEON_USAT
-
-uint32_t HELPER(neon_qadd_u32)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    uint32_t res = a + b;
-    if (res < a) {
-        SET_QC();
-        res = ~0;
-    }
-    return res;
-}
-
-uint64_t HELPER(neon_qadd_u64)(CPUARMState *env, uint64_t src1, uint64_t src2)
-{
-    uint64_t res;
-
-    res = src1 + src2;
-    if (res < src1) {
-        SET_QC();
-        res = ~(uint64_t)0;
-    }
-    return res;
-}
-
-#define NEON_SSAT(dest, src1, src2, type) do { \
-    int32_t tmp = (uint32_t)src1 + (uint32_t)src2; \
-    if (tmp != (type)tmp) { \
-        SET_QC(); \
-        if (src2 > 0) { \
-            tmp = (1 << (sizeof(type) * 8 - 1)) - 1; \
-        } else { \
-            tmp = 1 << (sizeof(type) * 8 - 1); \
-        } \
-    } \
-    dest = tmp; \
-    } while(0)
-#define NEON_FN(dest, src1, src2) NEON_SSAT(dest, src1, src2, int8_t)
-NEON_VOP_ENV(qadd_s8, neon_s8, 4)
-#undef NEON_FN
-#define NEON_FN(dest, src1, src2) NEON_SSAT(dest, src1, src2, int16_t)
-NEON_VOP_ENV(qadd_s16, neon_s16, 2)
-#undef NEON_FN
-#undef NEON_SSAT
-
-uint32_t HELPER(neon_qadd_s32)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    uint32_t res = a + b;
-    if (((res ^ a) & SIGNBIT) && !((a ^ b) & SIGNBIT)) {
-        SET_QC();
-        res = ~(((int32_t)a >> 31) ^ SIGNBIT);
-    }
-    return res;
-}
-
-uint64_t HELPER(neon_qadd_s64)(CPUARMState *env, uint64_t src1, uint64_t src2)
-{
-    uint64_t res;
-
-    res = src1 + src2;
-    if (((res ^ src1) & SIGNBIT64) && !((src1 ^ src2) & SIGNBIT64)) {
-        SET_QC();
-        res = ((int64_t)src1 >> 63) ^ ~SIGNBIT64;
-    }
-    return res;
-}
-
-#define NEON_USAT(dest, src1, src2, type) do { \
-    uint32_t tmp = (uint32_t)src1 - (uint32_t)src2; \
-    if (tmp != (type)tmp) { \
-        SET_QC(); \
-        dest = 0; \
-    } else { \
-        dest = tmp; \
-    }} while(0)
-#define NEON_FN(dest, src1, src2) NEON_USAT(dest, src1, src2, uint8_t)
-NEON_VOP_ENV(qsub_u8, neon_u8, 4)
-#undef NEON_FN
-#define NEON_FN(dest, src1, src2) NEON_USAT(dest, src1, src2, uint16_t)
-NEON_VOP_ENV(qsub_u16, neon_u16, 2)
-#undef NEON_FN
-#undef NEON_USAT
-
-uint32_t HELPER(neon_qsub_u32)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    uint32_t res = a - b;
-    if (res > a) {
-        SET_QC();
-        res = 0;
-    }
-    return res;
-}
-
-uint64_t HELPER(neon_qsub_u64)(CPUARMState *env, uint64_t src1, uint64_t src2)
-{
-    uint64_t res;
-
-    if (src1 < src2) {
-        SET_QC();
-        res = 0;
-    } else {
-        res = src1 - src2;
-    }
-    return res;
-}
-
-#define NEON_SSAT(dest, src1, src2, type) do { \
-    int32_t tmp = (uint32_t)src1 - (uint32_t)src2; \
-    if (tmp != (type)tmp) { \
-        SET_QC(); \
-        if (src2 < 0) { \
-            tmp = (1 << (sizeof(type) * 8 - 1)) - 1; \
-        } else { \
-            tmp = 1 << (sizeof(type) * 8 - 1); \
-        } \
-    } \
-    dest = tmp; \
-    } while(0)
-#define NEON_FN(dest, src1, src2) NEON_SSAT(dest, src1, src2, int8_t)
-NEON_VOP_ENV(qsub_s8, neon_s8, 4)
-#undef NEON_FN
-#define NEON_FN(dest, src1, src2) NEON_SSAT(dest, src1, src2, int16_t)
-NEON_VOP_ENV(qsub_s16, neon_s16, 2)
-#undef NEON_FN
-#undef NEON_SSAT
-
-uint32_t HELPER(neon_qsub_s32)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    uint32_t res = a - b;
-    if (((res ^ a) & SIGNBIT) && ((a ^ b) & SIGNBIT)) {
-        SET_QC();
-        res = ~(((int32_t)a >> 31) ^ SIGNBIT);
-    }
-    return res;
-}
-
-uint64_t HELPER(neon_qsub_s64)(CPUARMState *env, uint64_t src1, uint64_t src2)
-{
-    uint64_t res;
-
-    res = src1 - src2;
-    if (((res ^ src1) & SIGNBIT64) && ((src1 ^ src2) & SIGNBIT64)) {
-        SET_QC();
-        res = ((int64_t)src1 >> 63) ^ ~SIGNBIT64;
-    }
-    return res;
-}
-
 #define NEON_FN(dest, src1, src2) dest = (src1 + src2) >> 1
 NEON_VOP(hadd_s8, neon_s8, 4)
 NEON_VOP(hadd_u8, neon_u8, 4)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 781b2249720..ca7ba6b1e8c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9291,21 +9291,28 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
      * or scalar-three-reg-same groups.
      */
     TCGCond cond;
+    TCGv_i64 qc;
 
     switch (opcode) {
     case 0x1: /* SQADD */
+        qc = tcg_temp_new_i64();
+        tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
         if (u) {
-            gen_helper_neon_qadd_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
+            gen_uqadd_d(tcg_rd, qc, tcg_rn, tcg_rm);
         } else {
-            gen_helper_neon_qadd_s64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
+            gen_sqadd_d(tcg_rd, qc, tcg_rn, tcg_rm);
         }
+        tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
         break;
     case 0x5: /* SQSUB */
+        qc = tcg_temp_new_i64();
+        tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
         if (u) {
-            gen_helper_neon_qsub_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
+            gen_uqsub_d(tcg_rd, qc, tcg_rn, tcg_rm);
         } else {
-            gen_helper_neon_qsub_s64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
+            gen_sqsub_d(tcg_rd, qc, tcg_rn, tcg_rm);
         }
+        tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
         break;
     case 0x6: /* CMGT, CMHI */
         cond = u ? TCG_COND_GTU : TCG_COND_GT;
@@ -9425,35 +9432,16 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
          * OPTME: special-purpose helpers would avoid doing some
          * unnecessary work in the helper for the 8 and 16 bit cases.
          */
-        NeonGenTwoOpEnvFn *genenvfn;
-        TCGv_i32 tcg_rn = tcg_temp_new_i32();
-        TCGv_i32 tcg_rm = tcg_temp_new_i32();
-        TCGv_i32 tcg_rd32 = tcg_temp_new_i32();
-
-        read_vec_element_i32(s, tcg_rn, rn, 0, size);
-        read_vec_element_i32(s, tcg_rm, rm, 0, size);
+        NeonGenTwoOpEnvFn *genenvfn = NULL;
+        void (*genfn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp) = NULL;
 
         switch (opcode) {
         case 0x1: /* SQADD, UQADD */
-        {
-            static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_qadd_s8, gen_helper_neon_qadd_u8 },
-                { gen_helper_neon_qadd_s16, gen_helper_neon_qadd_u16 },
-                { gen_helper_neon_qadd_s32, gen_helper_neon_qadd_u32 },
-            };
-            genenvfn = fns[size][u];
+            genfn = u ? gen_uqadd_bhs : gen_sqadd_bhs;
             break;
-        }
         case 0x5: /* SQSUB, UQSUB */
-        {
-            static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_qsub_s8, gen_helper_neon_qsub_u8 },
-                { gen_helper_neon_qsub_s16, gen_helper_neon_qsub_u16 },
-                { gen_helper_neon_qsub_s32, gen_helper_neon_qsub_u32 },
-            };
-            genenvfn = fns[size][u];
+            genfn = u ? gen_uqsub_bhs : gen_sqsub_bhs;
             break;
-        }
         case 0x9: /* SQSHL, UQSHL */
         {
             static NeonGenTwoOpEnvFn * const fns[3][2] = {
@@ -9488,8 +9476,29 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
             g_assert_not_reached();
         }
 
-        genenvfn(tcg_rd32, tcg_env, tcg_rn, tcg_rm);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_rd32);
+        if (genenvfn) {
+            TCGv_i32 tcg_rn = tcg_temp_new_i32();
+            TCGv_i32 tcg_rm = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, tcg_rn, rn, 0, size);
+            read_vec_element_i32(s, tcg_rm, rm, 0, size);
+            genenvfn(tcg_rn, tcg_env, tcg_rn, tcg_rm);
+            tcg_gen_extu_i32_i64(tcg_rd, tcg_rn);
+        } else {
+            TCGv_i64 tcg_rn = tcg_temp_new_i64();
+            TCGv_i64 tcg_rm = tcg_temp_new_i64();
+            TCGv_i64 qc = tcg_temp_new_i64();
+
+            read_vec_element(s, tcg_rn, rn, 0, size | (u ? 0 : MO_SIGN));
+            read_vec_element(s, tcg_rm, rm, 0, size | (u ? 0 : MO_SIGN));
+            tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
+            genfn(tcg_rd, qc, tcg_rn, tcg_rm, size);
+            tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
+            if (!u) {
+                /* Truncate signed 64-bit result for writeback. */
+                tcg_gen_ext_i64(tcg_rd, tcg_rd, size);
+            }
+        }
     }
 
     write_fp_dreg(s, rd, tcg_rd);
-- 
2.34.1


