Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086FCFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9z-0006on-1h; Wed, 29 Apr 2026 20:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9q-0006c6-LH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:35 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9o-0006Kp-VW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-83177129e28so162111b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508492; x=1778113292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4y3ds3PSya04tloOheNtG2Ax9QruENgFVm/k1Dpe8E=;
 b=uJdcHmPu57QnSl+tMFX6VtmXVpxlgx2VUMh6UapB9OvvU+vsiI2wi2uYcoxsRx2+ib
 HsNR4gedU2bfkSz+ScnRHJlFvRqPwRv+0ji0TI0bCTofh+Ot4Jlw7/ak+FHH0FA1AXdB
 /nidrPfMkieoRl2P0PYzYFuTZVX6tSpiZzCyvrmKMQ2ypqaSGASOYhPwjU4t3mOFmF/m
 z2zKJw3b5AmZJkao6sUX8RlirymGEhqUGHY2ZcSa+w3gZVRd1Em//2tcZtw6bv+17/Mu
 jZGZx6psw4NyrEWjlgx9mgDw/GTTRwPJKrL405KBfScBLwkLKmfoOfvpoexZQbXhLT1Y
 VAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508492; x=1778113292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4y3ds3PSya04tloOheNtG2Ax9QruENgFVm/k1Dpe8E=;
 b=SDxvra+F0Zn5G263fesXQJ4pnzPk2MNLfpmRsLcWe68LeUwt0PV5hMFCSxjpd5aBkN
 r81FNVBWBK6Le1qYNWJXHxoSRkWDQal+Iy0gEDF69Lhk4FnFbG83ao7Wmi+e48blvNZH
 oiNmXl2TZBzCajED/+IkAv0EuYqkDnoyiQackFigtPmJV/A8sfDx/8fA1vqWjovdjtIw
 cWvhJWifMGmKwFBfw5uwvtufkan9awQGvYG2PhnrRAyt7BdGnUp1ZTQAgNQH4TGF1vHf
 vOD3pXEOZ+7yp1OQIHklQg9mjx7UPRjsmx0gbBkJ5JJDwA62u1DZO71XiWCOKRpMn3Y8
 uFwQ==
X-Gm-Message-State: AOJu0Yxl/i9dJaSBM3QL83Ch9nYxfgvb5u4r7O1fuJiAxPIl4Z4e4qbr
 KBXXY+P2CqBdQ/6kZ78n0VzdfnMZfQuxtZhRnZcyK7gNbAkUIAQtbV7fJgsbrD4fc/LhM36VgJc
 cCdCRJIg=
X-Gm-Gg: AeBDievUbe8Eb3mriKnNULNWQqjrKnxrT83YV8VCUAM9AgeGHhhYnJfql39S4lp6yND
 kHUpdaOOg6YHTLtXBLcoIuNsV33xUCpV3teEmWs8qvHsLQs1hfv0PuG4AZVdBHHS26TgWhGk2iB
 JWCLCqZMeaYQfreK/B7gN8DCPcjZ2YWJiUo/pkPw+WKsezf5SacDokyQdBzZbz38mDZaFkLl7U5
 S1nxMW39D8WQeJugCGnnLB16nskqOlGS8YQOlnFsSkHshGWYfgVdbDZrBLufYSLHuDjjrJrTaAb
 eIMg6/+CrFORieae9v6oq3sGSka4HkvWLKgYwjwKcxIT9UgMXUewUTE/7kWnT0w2HgCpEoEDI/V
 ZmYG/d7qVW27ueWhw8bYw2ye1m3iA6be1Q2QmdDTJqrSqxvsFpprxX20iZKawB0sGDhYjvkQqIM
 Xdpuu8FaDP9eWAoFVZXee8sCxgRTbOL1hmRtr776wI
X-Received: by 2002:a05:6a00:290e:b0:82f:8696:5a75 with SMTP id
 d2e1a72fcca58-834fdc5bf05mr823467b3a.28.1777508491535; 
 Wed, 29 Apr 2026 17:21:31 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 18/47] target/arm: Implement FSCALE for SME
Date: Thu, 30 Apr 2026 10:20:17 +1000
Message-ID: <20260430002046.59739-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 15 +++++++++++++--
 target/arm/tcg/sme.decode      |  6 ++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 590a7f6cf7..104e36b3ae 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1608,6 +1608,11 @@ static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool isar_feature_aa64_sme2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a67501226f..e2d17de165 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -707,9 +707,12 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
 {
     int esz = a->esz, n, dn, vsz, mofs;
     bool overlap = false;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     /* These insns use MO_8 to encode BFloat16. */
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
@@ -719,7 +722,6 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     mofs = vec_full_reg_offset(s, a->zm);
@@ -831,6 +833,15 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
 };
 TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
+    NULL,
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_z2z_n1_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_z2z_nn_fpst, a, f_vector_fscale)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9dec7318a4..ee874be1a6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -250,6 +250,9 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
 %zm_ax2         17:4 !function=times_2
@@ -291,6 +294,9 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
-- 
2.43.0


