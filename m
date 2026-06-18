Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B759CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4AC-0005W5-FJ; Thu, 18 Jun 2026 00:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A3-0005T4-6Z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:27 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A1-0005aB-Fe
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:26 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so249307a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756124; x=1782360924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9OcL1eG5TU1UTDD54e5zOZZZ7cUUNpp2dLnHbhNm1c=;
 b=X1Y9IkTFLRL2xE9klXuvHTOktnLdNrXlHgLizXaPgC1smjvS4Sh1e8DL2V6mQZ3pXc
 uApu++kg9wBX/7TiuSirRcNXloxFvPoxuduvcg/5WlSsJpqe2qVie8JQgLYncFOtvsd0
 /ryIodhDv42jXATsgiQ7XvEzgdi//noiYuMlEUJUPTUDYFQN4FrSeZ/tgA7rEofFszQU
 WdYlno99qqsKkggi1PFOrmxzzWseIDeFYza1ppUT1Z8ftkzWX2PtqCqL4eMpnHmmQIH9
 z48MFRPLzQq1cVQMWpmINYGGuLYSI81pEwCQ97M5cMjFuRhYa/hosSL41fqys794rJDz
 vDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756124; x=1782360924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s9OcL1eG5TU1UTDD54e5zOZZZ7cUUNpp2dLnHbhNm1c=;
 b=nsVefK22ycs1BjMbEhmFRycADukPublbjIDULPXiqucsucE3e7irr9juySH4UG8BnA
 bl8vqPbPR5DdxbPKNHuIQk/YzovhQ5vC216CPyK4UsQt1Mr5uAFFmlrhoCVYlggLfh/0
 A3Tor+XXEt2grCazL2FwLxRaEWMMuwxNfGxzskTN/WK7chfq7QP0/UABBvlV4zizY24F
 x1zNmTZ48wqfIKm8JUryw0mpfckl4rdD4kyMss5f1/X1AHeCYP0/4fzKvQxsr8nmH4Ly
 GmdBwyEdaVoncBbYJN2BdTuoAra8UyHcSdSgWKf+3YStoXYwvX01Y4BN2LybWl3fAgjz
 64qw==
X-Gm-Message-State: AOJu0YzxzLLojK4x4DdFw+gfdwW2UGsb0/KNAuYkAeF+N1q51lY96cYL
 mrrW/MuoBrgIx6yfGDsRQWdegGEv9acomfwk5nRZ+dMDDsnmRs0vasmBRO67WP18wzW6esBZIE5
 ScO1R
X-Gm-Gg: AfdE7clgHHA67tHqUUqfSDUwG4PVGw4WOvZmuliVmFDLibmxueIn62A/Z8rqmffboYa
 jJ5gdzR9vco575aM2EQlFIIg4TP64qelRLj+sOV71CJnv5gy70bHZsoCwEtjybLcGtDoRC7sJqz
 yOwQeaJcuO0XOI9cCFaA2FpvRuhXTTPNNKAVirNvwBj+EVR+zRmbq22P9lyNDT/HTtypJqxXGXN
 VKRVoJHVc111s6nyRF4w9FqwZCpSsskYQ4UyOvq9tAvNqT5nSDpV+ddxKUy+N7dzi7s9VONgWTO
 UW5HOFLewjA/yh2MiIqEe1rsknMuDhRMTge/LfiQSHgDsVKg4+TlWLOIqiewf5xhtvFOmI3En6T
 vOBQUmRZXiCwoqPY2wKlndVZJfxT1fKsDvs82Iqmq4qWr9K2gT+aBto8Bkp8mvy8vtQPyAGh0Ri
 d0Rf4X1VOAkUwdFdBfQvAvJThu1gU3mxgfi1b8Pjvy4nfzo5RWuw==
X-Received: by 2002:a17:902:d4cc:b0:2c1:a19:8396 with SMTP id
 d9443c01a7336-2c6bc26b19dmr67425605ad.31.1781756123548; 
 Wed, 17 Jun 2026 21:15:23 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/10] target/arm: Implement FMLALL (multiple and single
 vector)
Date: Wed, 17 Jun 2026 21:15:10 -0700
Message-ID: <20260618041517.573469-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/translate-sme.c | 49 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  4 +++
 2 files changed, 53 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 63c6e2c9b1..30487c34a0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1059,6 +1059,47 @@ static bool do_azz_acc_fp(DisasContext *s, int nreg, int nsel,
     return true;
 }
 
+static bool do_azz_acc_fp8(DisasContext *s, int nreg, int nsel,
+                           int rv, int off, int zn, int zm,
+                           int data, int shsel, bool multi,
+                           gen_helper_gvec_3_ptr *fn)
+{
+    /*
+     * TODO: Could plausibly reuse do_azz_acc_fp, after the fpmr check,
+     * but the fp8 helpers were written without a separate addend operand.
+     */
+    if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg, nsel);
+        TCGv_ptr t;
+
+        t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < nreg; ++r) {
+            TCGv_ptr t_zn = vec_full_reg_ptr(s, zn);
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm);
+
+            for (int i = 0; i < nsel; ++i) {
+                int o_za = (r * vstride + i) * sizeof(ARMVectorReg);
+                int desc = simd_desc(svl, svl, data | (i << shsel));
+
+                tcg_gen_addi_ptr(t, t_za, o_za);
+                fn(t, t_zn, t_zm, tcg_env, tcg_constant_i32(desc));
+            }
+
+            /*
+             * For multiple-and-single vectors, Zn may wrap.
+             * For multiple vectors, both Zn and Zm are aligned.
+             */
+            zn = (zn + 1) % 32;
+            zm += multi;
+        }
+    }
+    return true;
+}
+
+
 static bool do_fmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
@@ -1071,6 +1112,14 @@ TRANS_FEAT(FMLSL_n1, aa64_sme2, do_fmlal, a, true, false)
 TRANS_FEAT(FMLAL_nn, aa64_sme2, do_fmlal, a, false, true)
 TRANS_FEAT(FMLSL_nn, aa64_sme2, do_fmlal, a, true, true)
 
+static bool do_fmlall_fp8(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp8(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                          0, 0, multi, gen_helper_gvec_fmla_sb);
+}
+
+TRANS_FEAT(FMLALL_n1_b, aa64_sme_f8f32, do_fmlall_fp8, a, false)
+
 static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 {
     return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e668293efd..4956995924 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -445,6 +445,10 @@ FMLS_n1_h       11000001 001 1 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_s       11000001 001 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_d       11000001 011 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
 
+FMLALL_n1_b     11000001 001 1 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+FMLALL_n1_b     11000001 001 0 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=2
+FMLALL_n1_b     11000001 001 1 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
-- 
2.43.0


