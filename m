Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA13DC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT862-000871-Lq; Sat, 21 Jun 2025 19:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85g-0005wP-RW
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:45 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85e-0006cx-0T
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:44 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso3597100a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550260; x=1751155060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tce8s5LONiTVLfOvDuOLvpz9b12wHjhnb4n7QwHoAfM=;
 b=uRlnAuDmDDcspicT5sjHhqOIt6PbMCeVBuZweVo4AZFmCzLfvlKDN80caz2nAdz4al
 xc5Vxx124Wwb/P2mRIa7APqRD3dlLBcHC+J37+l50IrQeOMw9Jk5iemVfaiq2uT/rmTO
 dhXcfgUmkCLBGNN+N9k9LlDIFeK6ypaxsdySAVrDoO8bNqhy3W3Rtd1K4l4xYxiUHja0
 vkXzFB3pxnPqYb01wv26vuNHJKOVyrq/XmZxvcwP25JIZq7sLtMNNA7G0SKnubXCbZBM
 nIaqMfKTSQyb/X4UMsUerVWpHZxgIm0Q8o6tWgOsfTeN6wKHHdXajr3T54wrqfrLfCMc
 RK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550260; x=1751155060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tce8s5LONiTVLfOvDuOLvpz9b12wHjhnb4n7QwHoAfM=;
 b=m1CmFQz2q9Zxj44P9r3NCv1a4Dfojj8582SQtKm74Akc8ln3yWZdFKfnaOmRwuc8px
 Wc1iig8UxMOcl6jdrYMZ2mSX9rmHw6jqQUI2ZPO+VvqEFkBJGEh4RowOs0Gh7wEUzxgF
 2A7J/LysdSZJlwz87FFO4hMLxSg5MRUqCqX5XjtcBtBUERvskED/rUfEUNZT6mOlfynX
 azX0EALxo1HM5ZP6BPffk35wdymAtCDoQF25PQJgpMLokmNtbdr7kzcm/4S+6CeDObZ+
 L3350ts9Qtte2rHsSByTWNOFnid0bnq+UJgpYwibL5u8c9foNAki+A32Y4uZJ/bBBrO5
 EVzQ==
X-Gm-Message-State: AOJu0YyFhD7w1FX2wSAKflVqdABrSNWVg7WMnQ1z7462n03PW3eoIAs0
 H3GGs4QGQiIirS+vLT6SJ7S7Wgp310EhDDTlyX8F2EwGXQUxIODeryGj7uyAMC8SVX1qgllvFr8
 kA5Bpdgg=
X-Gm-Gg: ASbGncvb5NybR6i8vD/w8oTIoKZos1WlbyaJGBn2ihMXltsYdfEjWnbrI3TuO+jNu5D
 xrf5uXs20dENGyaXwxFjAxGx/fG/bT/Vog27oReV21/TPtMwABacsrWXPNzdskPg2f/UiWeCsVb
 jYr9ggxzrH2iES5TallToe1rzsvcPmVhYM16Dpt1yM1oJWfAK4sBm2pSuJ5iJAkETp/qBCmj+7Q
 coTBk5JDo55nZDkhvwgTlyakFoUhpj71RnDoLoh0Gcdyugi/7iCiYPjhQKJkD+hBDsnsWKaNwAR
 2hYfU5QCKTL1tfr1vc4scgkhw6nK70dvuDl7zsUiUBfFZj1MShND5zjo/NpoZuT7ZYlBJZaiI5v
 T4mT4iarj+6xIjl0XihAM
X-Google-Smtp-Source: AGHT+IHCpy0IwRNzekIWxubMZP4du59PXNZLXSE0y75BTLAWo3f49G2a4w3oorMMLNlkIrxWSH+TYQ==
X-Received: by 2002:a05:6a21:99a8:b0:1ee:e33d:f477 with SMTP id
 adf61e73a8af0-22026d9b183mr12561738637.15.1750550260307; 
 Sat, 21 Jun 2025 16:57:40 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 096/101] target/arm: Implement LD1Q, ST1Q for SVE2p1
Date: Sat, 21 Jun 2025 16:50:32 -0700
Message-ID: <20250621235037.74091-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 target/arm/tcg/helper-sve.h    | 16 ++++++++++++++++
 target/arm/tcg/sve_helper.c    |  6 ++++++
 target/arm/tcg/translate-sve.c | 34 ++++++++++++++++++++++++++++++++--
 target/arm/tcg/sve.decode      |  8 ++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index ade76ff664..c36090d13d 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2155,6 +2155,10 @@ DEF_HELPER_FLAGS_6(sve_ldsds_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
@@ -2264,6 +2268,10 @@ DEF_HELPER_FLAGS_6(sve_ldsds_le_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldqq_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
@@ -2549,6 +2557,10 @@ DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_le_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_be_zd, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_6(sve_stbs_zsu_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
@@ -2616,6 +2628,10 @@ DEF_HELPER_FLAGS_6(sve_stdd_le_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd_mte, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stqq_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
 
 DEF_HELPER_FLAGS_4(sve2_sqdmull_zzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 65183692bc..e933372ba4 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7534,6 +7534,9 @@ DO_LD1_ZPZ_D(dd_be, zsu, MO_64)
 DO_LD1_ZPZ_D(dd_be, zss, MO_64)
 DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
+DO_LD1_ZPZ_D(qq_le, zd, MO_128)
+DO_LD1_ZPZ_D(qq_be, zd, MO_128)
+
 #undef DO_LD1_ZPZ_S
 #undef DO_LD1_ZPZ_D
 
@@ -7920,6 +7923,9 @@ DO_ST1_ZPZ_D(sd_be, zd, MO_32)
 DO_ST1_ZPZ_D(dd_le, zd, MO_64)
 DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
+DO_ST1_ZPZ_D(qq_le, zd, MO_128)
+DO_ST1_ZPZ_D(qq_be, zd, MO_128)
+
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fe4bf6c57c..59fc69037c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6079,13 +6079,23 @@ gather_load_fn64[2][2][2][3][2][4] = {
                   gen_helper_sve_ldffdd_be_zd_mte, } } } } },
 };
 
+static gen_helper_gvec_mem_scatter * const
+gather_load_fn128[2][2] = {
+    { gen_helper_sve_ldqq_le_zd,
+      gen_helper_sve_ldqq_be_zd },
+    { gen_helper_sve_ldqq_le_zd_mte,
+      gen_helper_sve_ldqq_be_zd_mte }
+};
+
 static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
     bool be = s->be_data == MO_BE;
     bool mte = s->mte_active[0];
 
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (a->esz < MO_128
+        ? !dc_isar_feature(aa64_sve, s)
+        : !dc_isar_feature(aa64_sve2p1, s)) {
         return false;
     }
     s->is_nonstreaming = true;
@@ -6100,6 +6110,12 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
     case MO_64:
         fn = gather_load_fn64[mte][be][a->ff][a->xs][a->u][a->msz];
         break;
+    case MO_128:
+        assert(!a->ff && a->u && a->xs == 2 && a->msz == MO_128);
+        fn = gather_load_fn128[mte][be];
+        break;
+    default:
+        g_assert_not_reached();
     }
     assert(fn != NULL);
 
@@ -6267,6 +6283,14 @@ static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][2][3][4] = {
                gen_helper_sve_stdd_be_zd_mte, } } },
 };
 
+static gen_helper_gvec_mem_scatter * const
+scatter_store_fn128[2][2] = {
+    { gen_helper_sve_stqq_le_zd,
+      gen_helper_sve_stqq_be_zd },
+    { gen_helper_sve_stqq_le_zd_mte,
+      gen_helper_sve_stqq_be_zd_mte }
+};
+
 static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn;
@@ -6276,7 +6300,9 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
         return false;
     }
-    if (!dc_isar_feature(aa64_sve, s)) {
+    if (a->esz < MO_128
+        ? !dc_isar_feature(aa64_sve, s)
+        : !dc_isar_feature(aa64_sve2p1, s)) {
         return false;
     }
     s->is_nonstreaming = true;
@@ -6290,6 +6316,10 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     case MO_64:
         fn = scatter_store_fn64[mte][be][a->xs][a->msz];
         break;
+    case MO_128:
+        assert(a->xs == 2 && a->msz == MO_128);
+        fn = scatter_store_fn128[mte][be];
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f481f1479d..bd058e9fab 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1340,6 +1340,10 @@ LD1_zprz        1100010 10 1. ..... 1.. ... ..... ..... \
 LD1_zprz        1100010 11 1. ..... 11. ... ..... ..... \
                 @rprr_g_load_sc esz=3 msz=3 u=1
 
+# LD1Q
+LD1_zprz        1100 0100 000 rm:5 101 pg:3 rn:5 rd:5 \
+                &rprr_gather_load u=0 ff=0 xs=2 esz=4 msz=4 scale=0
+
 # SVE 64-bit gather load (vector plus immediate)
 LD1_zpiz        1100010 .. 01 ..... 1.. ... ..... ..... \
                 @rpri_g_load esz=3
@@ -1443,6 +1447,10 @@ ST1_zprz        1110010 .. 01 ..... 101 ... ..... ..... \
 ST1_zprz        1110010 .. 00 ..... 101 ... ..... ..... \
                 @rprr_scatter_store xs=2 esz=3 scale=0
 
+# ST1Q
+ST1_zprz        1110 0100 001 rm:5 001 pg:3 rn:5 rd:5 \
+                &rprr_scatter_store xs=2 msz=4 esz=4 scale=0
+
 # SVE 64-bit scatter store (vector plus immediate)
 ST1_zpiz        1110010 .. 10 ..... 101 ... ..... ..... \
                 @rpri_scatter_store esz=3
-- 
2.43.0


