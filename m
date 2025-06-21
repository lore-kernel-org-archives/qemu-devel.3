Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA47C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zE-0005Bj-HZ; Sat, 21 Jun 2025 19:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zC-0005AQ-6G
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zA-0004W7-Bi
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso2621143b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549859; x=1751154659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pDtUB3SFAGlyBLJTFAODVnujadtO4moFJnvQE3odk5c=;
 b=TGfhqy7saoJFf3+Tj7YqQiFcz09dILsJp2bSMARoY4EVZxidghqYE3O4RzAaPE2PlF
 pkiwBayOprAZJVcUSemyTr+9JEw2ojL4PDwf1vcu/QhHJeFHIAE6n6gtyyuz5bhJqCdb
 vGIAdSHkYywaTMrrZ3EaFXl/Dgy1KzIzPtAhXNcyqhCdIs6lVXs+/6NaNR8kDAZ5HkRs
 j5/WvLEqJB3zM5v/ilwXBRgimzcDudLDDTg92oWpSvtlpFN1nyID8Sv2W/2GDGQEYTZM
 avITISbjBj6JtDN3fzdd2FCuhzsBhnzVIkP1ZmPfRz6VQZRrebCV0dfp+moGzCydJSGm
 kwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549859; x=1751154659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDtUB3SFAGlyBLJTFAODVnujadtO4moFJnvQE3odk5c=;
 b=e+Ht9+9Fv3ObqNixgTGGWjqbEmIz/7gLk12wEnTnIV9QPcRG0LQmMnTHQMm6MEWCu2
 mLndwyCTyys0NGScYoBb6dJkcK0M4kK9wvH795IcpVAeeHB7eHPO/A4DKanrE8gcqUpO
 14FV3r6nsT+ABkhh1XVUFWlr6rfBT8ODgwQWJ6W7dYMmuS9nfgUmj229LFdZf0sF57Tc
 SXPLZDrpR1hRMb3kd1Y4MlSB65ovedsJ/ewlVKPmipsuST8nehZ1aKxvrWNnl+01yRj0
 LzQczv18QtAq8lGQv61SZK09NRP6sPOal7vp8RzC+fb7kCRXTu6II/AUI8X0971/dTpX
 vGwQ==
X-Gm-Message-State: AOJu0YxcjiAzSPLG8kTGRbvlio5txmS+uxIOOxabDnLDxC7mUTvWnSri
 RGOWkY+a+uYPex1ZWd2vrsaUHo6zLhe28bvQpzjW8TFmjtf872BtNFYYhnNV3EXF78pngLcvOid
 mH4Ev
X-Gm-Gg: ASbGncuSaBq6/S5hsux72s1r6LXpQPqEkX+p6vbfaVC00TmLAPJvk4NTlILUJs4bADN
 DTbNk7KfEY5vWbvPA+VEmsFM6PDOP80X3eu084OuoHC1mIPnDGaKDHCer0LOMBcevcs07aU/Do1
 5ZLwzFo805NoO0dBZBXlXpHXc7JTjlrkLBHcZrp6KLX77At8MlEhdD1KYa6Nbcu3Osvzc68Ct0y
 O584fYhzobVJFPJJpAu1KfcScahLDna80fOADSBtl+VVIDVZaUxx1az5ELC6LPjjb8Ze3Nt5SPq
 RdECUsvYpi2jG6VJG6ao726B48yqTG8+NhbQDNoxQGByDDTD3IQT8nBmslKBaCxylVM7aNqTuH6
 eVDtu0vGJydj8hh24vriRLkzodwVO6eg=
X-Google-Smtp-Source: AGHT+IEPJcF/BTI1UWH0JJLlN50qWIfDyA2jDna7o7qETdWCQH4NnC/b4n7LlOnmhTaatb8SWuhcGQ==
X-Received: by 2002:a05:6a00:1493:b0:742:b3a6:db09 with SMTP id
 d2e1a72fcca58-7490d6317b9mr10426847b3a.16.1750549859085; 
 Sat, 21 Jun 2025 16:50:59 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 031/101] target/arm: Implement SME2 ADD/SUB (array results,
 multiple and single vector)
Date: Sat, 21 Jun 2025 16:49:27 -0700
Message-ID: <20250621235037.74091-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/translate-sme.c | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 15 +++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a083b18ea3..8cf6324e2f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -641,6 +641,8 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
+typedef void GVecGen3FnVar(unsigned, TCGv_ptr, uint32_t, TCGv_ptr, uint32_t,
+                           TCGv_ptr, uint32_t, uint32_t, uint32_t);
 
 /* Function prototype for gen_ functions for calling Neon helpers */
 typedef void NeonGenOneOpFn(TCGv_i32, TCGv_i32);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 617621d663..09a4da1725 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -691,3 +691,32 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 };
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
+
+static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
+                      GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n, o_zm;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n);
+    o_zm = vec_full_reg_offset(s, a->zm);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zn = vec_full_reg_offset(s, (a->zn + i) % 32);
+
+        fn(esz, t_za, o_za, tcg_env, o_zn, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_sub_var)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 470592f4c0..8b81c0a0ce 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -245,3 +245,18 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
+
+### SME2 Multi-vector Multiple and Single Array Vectors
+
+&azz_n          n off rv zn zm
+@azz_nx1_o3     ........ .... zm:4 ...... zn:5 .. off:3     &azz_n rv=%mova_rv
+
+ADD_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+ADD_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+
+SUB_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
+SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
-- 
2.43.0


