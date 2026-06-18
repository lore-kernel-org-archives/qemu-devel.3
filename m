Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E14CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42N-0000uI-BX; Thu, 18 Jun 2026 00:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42J-0000rz-GH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42H-00045W-C0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-37c6cd1ac98so390442a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755644; x=1782360444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKE+K4ONkFnKt67fOnUjNENJCavXPLh6g/eMW2WZm30=;
 b=rvrNyZ74pw9hCYHQVk52dO/T7OlU4wOEuNHyL05vJ6IoLay8GvTAbuwjUmfAsBYluS
 /XcERJIu6MD4hBs+GtjA1zIIL4/NUKoeBcQsOar209Uu3BogLvuEb9CWtAtnnNFuBScF
 JNODionqa3l+r8doe+D3WG5A7XBLkn540wdXHZg7TmZa3+B/t+5ZbfzqCUDk+YjPtMS6
 v3qV3+LnqpxqIx2nG7eHKezNeRTbacqgzF5JyWEzLzfGk36bezeUNA0CyZuAivZ62a6u
 2n1l8VnCm6h8UklIqOGEgDb1LNhjmlRIw3ASS1f0cZxajmPhdmjz9h0fKlp7DFOo7mQx
 S0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755644; x=1782360444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iKE+K4ONkFnKt67fOnUjNENJCavXPLh6g/eMW2WZm30=;
 b=fHJAdhv7jUh+RWU0Aj2tipi9LhfEIZYPOee+fML4pqBrYGhsLD/TNUjg64YCTBRT5X
 S8w8R4j84V3QWc4NoGXx0RKDkukYLIr9di0R6PG4QY+p8vBQCGnYLReUEu6vWpfGx1oI
 IC3gJ36CeT0c8oDF7PprjipvWEc4Eb8//sP/IJaa0ka2PbHrLuHZtgJqkmeqrRBTz2zw
 Zzhe7HMTAksAlO6wwG6PjewKrDALXcI7NaBwXy4VuDVZihHECDJkiDVCFr5vTqd5434a
 5PSis3K/TfERE/9ldYO8rUW0Yxv+RbLoA4HkVQSqavK5Z7n5e/6I2CLREK0NW11trmlN
 tucQ==
X-Gm-Message-State: AOJu0Yy1zccDfUp4eIi3asQQ6Rvpn7gvtIFUSvZknKiAQWwv0795s9jP
 q5BT/kfRBqQktri9pMhVlStT0gUAa1cNIudt4nk0EJSOTHEBXFaaVrgTqtnsOvBqMYPsbcvG+zn
 2o3BC
X-Gm-Gg: AfdE7cm2r29B25VyHCv6WlW++YLlR3i5/jTBl1FfF299GqA2a0oqVej03Hgi6vJlLXW
 BojOCMUoWW5ZUqsMiZF5VvmUlGb4v3/B333LccBY1HiXoWUyi9I1ocqMlniM8i09jg22R2gC46L
 3E3LnYJKVcWKn3RNHxyRNmNTUxV0SdJX0WY6hycwu1aoLWXaCPDiJsHIDe246gzWFFstrjMzjpU
 zjYLMzaFRfrW4NvuwAuqpDIETc9mtTjZjbCXV46JkcGoDeJ4VTa6HFLm3LEY33UP5xLWV8tgseF
 g6y5n1rbZS3C4mSOfK0ZFfjv5rzHHZd9amgjwOEnp94CmnNXE7XbcolVMVE+yj8w05OMoaL5i6p
 CmxfU8ReT8xcfpCbGD6Mfge5/UUbebrECMPov7V9WAsiKGTBbb3TVQ8KhIIduDCHepnJSqlmU6D
 OKYs9x64A2jBf+pz3KibJZwTcWTiUgJn5P80EkqGZIjqodhAWMjg==
X-Received: by 2002:a17:90a:ec87:b0:36d:ae6a:22f0 with SMTP id
 98e67ed59e1d1-37c9e9c8c71mr5971052a91.14.1781755644000; 
 Wed, 17 Jun 2026 21:07:24 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/8] target/arm: Implement COMPACT for byte/halfword
Date: Wed, 17 Jun 2026 21:07:14 -0700
Message-ID: <20260618040718.572950-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
References: <20260618040718.572950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  2 ++
 target/arm/tcg/sve_helper.c      |  2 ++
 target/arm/tcg/translate-sve.c   | 22 +++++++++++++++++-----
 target/arm/tcg/sve.decode        |  1 -
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index 1d9066dcbb..b64a0faa19 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -733,6 +733,8 @@ DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_trn_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_compact_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_compact_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9b45b0d331..bd8fa2da7e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3657,6 +3657,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
     }                                                                 \
 }
 
+DO_COMPACT(sve_compact_b, uint8_t, H1)
+DO_COMPACT(sve_compact_h, uint16_t, H1_2)
 DO_COMPACT(sve_compact_s, uint32_t, H1_4)
 DO_COMPACT(sve_compact_d, uint64_t, H1_8)
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 57c21a13e8..01199dbd78 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2769,11 +2769,23 @@ TRANS_FEAT_NONSTREAMING(TRN2_q, aa64_sve_f64mm, do_interleave_q,
  *** SVE Permute Vector - Predicated Group
  */
 
-static gen_helper_gvec_3 * const compact_fns[4] = {
-    NULL, NULL, gen_helper_sve_compact_s, gen_helper_sve_compact_d
-};
-TRANS_FEAT_NONSTREAMING(COMPACT, aa64_sve, gen_gvec_ool_arg_zpz,
-                        compact_fns[a->esz], a, 0)
+static bool trans_COMPACT(DisasContext *s, arg_COMPACT *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_compact_b, gen_helper_sve_compact_h,
+        gen_helper_sve_compact_s, gen_helper_sve_compact_d
+    };
+
+    if (!dc_isar_feature(aa64_sme2p2, s)) {
+        if (!(a->esz >= MO_32
+              ? dc_isar_feature(aa64_sve, s)
+              : dc_isar_feature(aa64_sve2p2, s))) {
+            return false;
+        }
+        s->is_nonstreaming = true;
+    }
+    return gen_gvec_ool_arg_zpz(s, fns[a->esz], a, 0);
+}
 
 /* Call the helper that computes the ARM LastActiveElement pseudocode
  * function, scaled by the element size.  This includes the not found
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5ec1d420c2..a3eefd60e5 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -693,7 +693,6 @@ TBXQ            00000101 .. 1 ..... 001 101 ..... .....         @rd_rn_rm
 ### SVE Permute - Predicated Group
 
 # SVE compress active elements
-# Note esz >= 2
 COMPACT         00000101 .. 100001 100 ... ..... .....          @rd_pg_rn
 
 # SVE conditionally broadcast element to vector
-- 
2.43.0


