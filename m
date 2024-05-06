Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34237C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnS-0001Kr-Av; Sun, 05 May 2024 21:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmu-0008OV-9C
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:12 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmQ-0002Xp-1X
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:04 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so1028474a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957472; x=1715562272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emTfhIv6+TB39OZ2RHO0q5KrFHWhcyAbSfnfnFT0w78=;
 b=s+qGwUPOFXV6RZYWFLR/nYYtv59wCMWPg2J4BixljseAOz0edxvhBbMNUpjTxwTxdB
 56jWsLqZjUDztWptpMWEar4Df/TEGzDF+D9PS7mxTZzLaSE8vLyGwaA2D1XopZCOF/Er
 R299IMW7JH3qOuwSEaYxTfw3b5SSHbVvpabckSFenUw/3SOC4Yq9aZGfw5nVJCIX5R2K
 jqhD6Tb9REVMW7K5xtUzx60QLGu1+sej+jTw1vmssMJawnukjbdBcfePvZhzfcCTUYF+
 04lt1oahziFAt77gNGoLghwQh4NaEFXp85z3ltRCm8WYaZI3l+MwXqtTsJ/GJg6SQ8EO
 afsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957472; x=1715562272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emTfhIv6+TB39OZ2RHO0q5KrFHWhcyAbSfnfnFT0w78=;
 b=ZVj+S5DFBbR1mUOrP9n9dle3O6P9SUl59XqbTIe9Gvr1+dtMsxkB0yDK9kXK1daHqd
 ffVJEmBflOoRH9TyKLyL+uaUWvVkQW7S4eKfe/1ouDVxys3ZVfYt/Vceo0lVU7TVwLT+
 rTkU658B0W75GuBV53oTBrE15RtRhFLLtCIos9z0uvEP8AWYRREgMPc8Cap9tkpGzsCU
 wreXlhhvhjcFqO7kTgefwQk4oDsx3d5n+PeGFn0OatcRh+u/X5dFLFJICUwmHhdv10c/
 A2cmZdCg8s56GFuPDF+tzQ80Zf3w4qwHCKcFPiL3eG0u5DEY86im0Y3U3SyVTJGKYJM/
 k0YA==
X-Gm-Message-State: AOJu0YyhkEswkEsZnMWzi94iqzkcXseLlwszYWCfbDRKMa+bBPZcV14+
 nSrbv+3Au8LtiZKv5y0nzCVX2RcjOV/X4leLR8LsnA2krr67qQ83h0py2NshcFkioFMHLgIBvET
 y
X-Google-Smtp-Source: AGHT+IG02PpEhcdk5mIEQqyJrCpVkveWYPvdiu0uG3DSymhlJe15O1CLYQBPflOPPykeK5JZbCiZ+A==
X-Received: by 2002:a05:6a21:1786:b0:1af:ac67:1307 with SMTP id
 nx6-20020a056a21178600b001afac671307mr2100772pzb.21.1714957472194; 
 Sun, 05 May 2024 18:04:32 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 33/57] target/arm: Inline scalar SQADD, UQADD, SQSUB, UQSUB
Date: Sun,  5 May 2024 18:03:39 -0700
Message-Id: <20240506010403.6204-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

This eliminates the last uses of these neon helpers.
Incorporate the MO_64 expanders as an option to the vector expander.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  17 ----
 target/arm/tcg/translate.h     |  15 +++
 target/arm/tcg/gengvec.c       | 116 +++++++++++++++++++++++
 target/arm/tcg/neon_helper.c   | 162 ---------------------------------
 target/arm/tcg/translate-a64.c |  67 ++++++++------
 5 files changed, 169 insertions(+), 208 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index c76158d6d3..a14c040451 100644
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
index 3abdbedfe5..87439dcc61 100644
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
index bfe6885a01..66a514ba86 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1217,6 +1217,28 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
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
@@ -1250,6 +1272,7 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fniv = gen_uqadd_vec,
+          .fni8 = gen_uqadd_d,
           .fno = gen_helper_gvec_uqadd_d,
           .write_aofs = true,
           .opt_opc = vecop_list,
@@ -1259,6 +1282,41 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
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
@@ -1292,6 +1350,7 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_sqadd_vec,
+          .fni8 = gen_sqadd_d,
           .fno = gen_helper_gvec_sqadd_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
@@ -1301,6 +1360,26 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
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
@@ -1334,6 +1413,7 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_uqsub_vec,
+          .fni8 = gen_uqsub_d,
           .fno = gen_helper_gvec_uqsub_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
@@ -1343,6 +1423,41 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
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
@@ -1376,6 +1491,7 @@ void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_sqsub_vec,
+          .fni8 = gen_sqsub_d,
           .fno = gen_helper_gvec_sqsub_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 9505a5fd18..0af15e9f6e 100644
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
index a8fd22f3e9..12235e06d8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9285,21 +9285,28 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
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
@@ -9419,35 +9426,16 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
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
@@ -9482,8 +9470,29 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
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


