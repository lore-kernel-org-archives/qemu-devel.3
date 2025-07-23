Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC4C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueckQ-0006ew-Iw; Wed, 23 Jul 2025 12:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckL-0006SD-Qb
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckI-0007Bs-Up
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45600581226so375355e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753289709; x=1753894509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgGqaIHsbVQXAi+NjeZQAHrhXcK+K5i9LycDUSR887M=;
 b=uLdsifBTi37lDOpnNB3v0oUBdOa3htt0vMZNP2dUv7xMLZJBnw17a8H8hCqlk1Sb0M
 Er4dGz0/GnzzD872dvdmCN/cvEHuhcK9y9pGSuoC+FRld0Eo3nyJC6cBITO/kfI4jUzT
 qMhoEFnRn3cBZ9cuGEe4+87MiA1v8UX0qTaWuRCG31hKTRuknPR8CGgiG/7eIDDTSfsP
 63Ysi82+05vqO9zEILaOZuFE2Z+qTcUVfpOaMEQDWzReSoec7EqBKxv2SNxuZRaLYKxP
 GYyJPdnT+5vea2mGBmU8Nuy/cl4dmrWJplKwTGoRuu0c2YU8r9nx/FKxRaBijFrY6bbw
 t0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753289709; x=1753894509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgGqaIHsbVQXAi+NjeZQAHrhXcK+K5i9LycDUSR887M=;
 b=wnGIeh+bbUuFWzG6U4R2F0cLCTvEcPG7vo5+bV17uuplH3G91+ui7tgNmUmqL2e+1D
 vQgf7y2eFzjbVDy9JWn+ALFfNvsrMZGwqdrTdyIrXkr8t8+ww9WJcXqEi1TlgdBBeuTd
 xIhFIopIF3Vt9tz004xyfZN9fqRvahNTCTpiOst+JNAv/0xY1QrzX6IWufejTih/7op9
 Jsnx4CUefKiKue2s6x6dODcV7I528BgBvZaxhwqx9aDT0CU7S8ZNlbRsTTNNq2swUcdd
 sXtKWUhEm6SBRQ35WX5TX0JONfNnoMyxHMBWdZr3ObHodNVqW/0rwIJYimV7Y/gw6NBe
 YLWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkTPfChh99NARHyF55bDAnk28K+L+In1kxu1BFl/SmSUuu3Lf4mSTShDjBy0fULcut8QuHF2gZddU/@nongnu.org
X-Gm-Message-State: AOJu0Yx/S08taBxri5mW6RhWw21dW1sanOMLCactyhHxKC+ZpY9U8FWO
 q7HPil9cjeoU5EjoX6Caa9RB91ZSbVj1TtsGLl4i+3+bXOEgq6JEitJ659UMuHMZAf8=
X-Gm-Gg: ASbGnctuB02Vp7cPXBzdnIRDcNCno91gUQO6PO+jBXSccmF4J9NXhncDCAwgKm9R1PM
 iNRxMHiUBcbSkdUQMGTbDfsq8jXOWTURidGtvQalT0+n2v06J/ydyuAF1xA0gH4ubFz6xBe+dOT
 OBTr05XkTGveRERPO+R1eWM0JXyCGflfDerSktvKe0tpRpmmZ6K4+vR8Wz7TtAdM27/zbGCmfw7
 2RTLBu4EciJT1enojN+Q3Z+OiOxcMwesm5iMa7MwQvh9sOAT96b5qGr2zygoT/WZgHQ64TGIrgp
 YPF3P0XB/4Kmg/bb1Di5iCT5wF8jAHumImjNiN0sZ4I4rvv7g1+Lsyl/Shea+DkKyfsJUeQRhP9
 Jahz2vh1eVfvfFsjHheXRdmxJnCPB
X-Google-Smtp-Source: AGHT+IGUHzp2t14xcxnogL5suHHHiFaBprX6aNR7y2fQPnsvlhfssAORLHkjuyMjJHzWNmI86vLlcA==
X-Received: by 2002:a05:600c:6307:b0:456:1923:7549 with SMTP id
 5b1f17b1804b1-4586d6db9e7mr10451365e9.26.1753289709078; 
 Wed, 23 Jul 2025 09:55:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd224sm28559825e9.21.2025.07.23.09.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:55:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 4/6] target/arm: LD1Q, ST1Q are vector + scalar,
 not scalar + vector
Date: Wed, 23 Jul 2025 17:54:56 +0100
Message-ID: <20250723165458.3509150-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723165458.3509150-1-peter.maydell@linaro.org>
References: <20250723165458.3509150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Unlike the "LD1D (scalar + vector)" etc instructions, LD1Q is
vector + scalar. This means that:
 * the vector and the scalar register are in opposite fields
   in the encoding
 * 31 in the scalar register field is XZR, not XSP

The same applies for ST1Q.

This means we can't reuse the trans_LD1_zprz() and trans_ST1_zprz()
functions for LD1Q and ST1Q. Split them out to use their own
trans functions.

Note that the change made here to sve.decode requires the decodetree
bugfix "decodetree: Infer argument set before inferring format" to
avoid a spurious compile-time error about "dtype".

Fixes: d2aa9a804ee678f ("target/arm: Implement LD1Q, ST1Q for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 12 +++----
 target/arm/tcg/translate-sve.c | 65 ++++++++++++++++++++++++++--------
 2 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index aea7f519730..ab63cfaa0f0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1343,9 +1343,9 @@ LD1_zprz        1100010 10 1. ..... 1.. ... ..... ..... \
 LD1_zprz        1100010 11 1. ..... 11. ... ..... ..... \
                 @rprr_g_load_sc esz=3 msz=3 u=1
 
-# LD1Q
-LD1_zprz        1100 0100 000 rm:5 101 pg:3 rn:5 rd:5 \
-                &rprr_gather_load u=1 ff=0 xs=2 esz=4 msz=4 scale=0
+# LD1Q. Note that this is subtly different from LD1_zprz because
+# it is vector + scalar, not scalar + vector.
+LD1Q            1100 0100 000 rm:5 101 pg:3 rn:5 rd:5
 
 # SVE 64-bit gather load (vector plus immediate)
 LD1_zpiz        1100010 .. 01 ..... 1.. ... ..... ..... \
@@ -1450,9 +1450,9 @@ ST1_zprz        1110010 .. 01 ..... 101 ... ..... ..... \
 ST1_zprz        1110010 .. 00 ..... 101 ... ..... ..... \
                 @rprr_scatter_store xs=2 esz=3 scale=0
 
-# ST1Q
-ST1_zprz        1110 0100 001 rm:5 001 pg:3 rn:5 rd:5 \
-                &rprr_scatter_store xs=2 msz=4 esz=4 scale=0
+# ST1Q. Note that this is subtly different from ST1_zprz because
+# it is vector + scalar, not scalar + vector.
+ST1Q            1110 0100 001 rm:5 001 pg:3 rn:5 rd:5
 
 # SVE 64-bit scatter store (vector plus immediate)
 ST1_zpiz        1110010 .. 10 ..... 101 ... ..... ..... \
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5cba7b87bdc..07b827fa8e8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6179,9 +6179,7 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
     bool be = s->be_data == MO_BE;
     bool mte = s->mte_active[0];
 
-    if (a->esz < MO_128
-        ? !dc_isar_feature(aa64_sve, s)
-        : !dc_isar_feature(aa64_sve2p1, s)) {
+    if (!dc_isar_feature(aa64_sve, s)) {
         return false;
     }
     s->is_nonstreaming = true;
@@ -6196,10 +6194,6 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
     case MO_64:
         fn = gather_load_fn64[mte][be][a->ff][a->xs][a->u][a->msz];
         break;
-    case MO_128:
-        assert(!a->ff && a->u && a->xs == 2 && a->msz == MO_128);
-        fn = gather_load_fn128[mte][be];
-        break;
     default:
         g_assert_not_reached();
     }
@@ -6210,6 +6204,32 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
     return true;
 }
 
+static bool trans_LD1Q(DisasContext *s, arg_LD1Q *a)
+{
+    gen_helper_gvec_mem_scatter *fn = NULL;
+    bool be = s->be_data == MO_BE;
+    bool mte = s->mte_active[0];
+
+    if (!dc_isar_feature(aa64_sve2p1, s)) {
+        return false;
+    }
+    s->is_nonstreaming = true;
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    fn = gather_load_fn128[mte][be];
+    assert(fn != NULL);
+
+    /*
+     * Unlike LD1_zprz, a->rm is the scalar register and it can be XZR, not XSP.
+     * a->rn is the vector register.
+     */
+    do_mem_zpz(s, a->rd, a->pg, a->rn, 0,
+               cpu_reg(s, a->rm), MO_128, false, fn);
+    return true;
+}
+
 static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
@@ -6386,9 +6406,7 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
         return false;
     }
-    if (a->esz < MO_128
-        ? !dc_isar_feature(aa64_sve, s)
-        : !dc_isar_feature(aa64_sve2p1, s)) {
+    if (!dc_isar_feature(aa64_sve, s)) {
         return false;
     }
     s->is_nonstreaming = true;
@@ -6402,10 +6420,6 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     case MO_64:
         fn = scatter_store_fn64[mte][be][a->xs][a->msz];
         break;
-    case MO_128:
-        assert(a->xs == 2 && a->msz == MO_128);
-        fn = scatter_store_fn128[mte][be];
-        break;
     default:
         g_assert_not_reached();
     }
@@ -6414,6 +6428,29 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     return true;
 }
 
+static bool trans_ST1Q(DisasContext *s, arg_ST1Q *a)
+{
+    gen_helper_gvec_mem_scatter *fn;
+    bool be = s->be_data == MO_BE;
+    bool mte = s->mte_active[0];
+
+    if (!dc_isar_feature(aa64_sve2p1, s)) {
+        return false;
+    }
+    s->is_nonstreaming = true;
+    if (!sve_access_check(s)) {
+        return true;
+    }
+    fn = scatter_store_fn128[mte][be];
+    /*
+     * Unlike ST1_zprz, a->rm is the scalar register, and it
+     * can be XZR, not XSP. a->rn is the vector register.
+     */
+    do_mem_zpz(s, a->rd, a->pg, a->rn, 0,
+               cpu_reg(s, a->rm), MO_128, true, fn);
+    return true;
+}
+
 static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
-- 
2.43.0


