Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CDFCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42N-0000uT-GE; Thu, 18 Jun 2026 00:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42H-0000r7-Ji
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:27 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42F-000450-QT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:25 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-37c6cd1ac98so390433a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755642; x=1782360442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJNYyxkPZZLm2j4qOnGcl3pJUfyQigIuYwn5g7Qoayk=;
 b=DMQ9X44ldnmHzoouFtPp6Om/DBM3jOig/TMPZPIgyEMILA5av3O411KGJ2dfZ0cdX+
 1irOz//qALFOAJtPQH+FyA4cAe+jZfFdKogyWprECAg/VBhNzontjfov3KFCksdgoyio
 nxToqWK/oAtNkF4UrSof2cqCO6Af/Fm1UnIwcIVnayBSI/RIfJevKUNQh2QA5bIXG1Su
 IOOkUCDNyw74hqjtoXGov2x6kuebcj2A30rdia0Nna1O3yBkgcbwrHqHoMGy3HlnC0cy
 BR3Q67zNWHLQLaqhpBPWW87ICjlIge05lKMg31hnfTKnvxs5e6acA594F1mO9kBAqaCw
 1KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755642; x=1782360442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KJNYyxkPZZLm2j4qOnGcl3pJUfyQigIuYwn5g7Qoayk=;
 b=ZuP7ou/GdiBUZNruBPiczAT2bVdngnRdGqX5bghTXVremJWePqABtmS2cSpizMpAOj
 5pZVAichTEW4DaheWQBfJ70w0kMJKg4HYiPY+B2l0iGlUwa5te8Vg/ADuq2a2afcb6zQ
 7e+1yqHTFmnK3V7+JhFxKDfNmLxcvjP7nqavPMqbxNKc56JOkm4ET9yKz6HI0e9aqvN8
 h61BWkAZbQY51+GuGYUP132SVk9H2tvzolyPP8YuU8EbiqYEXkX1p8SkHGtpg0tJl9c3
 VmP8vQ3iWKIla5q0pkFZR3MP3PglLCgCHAepp11bNib1uXnLqi4qhJhvdQLj6dK5phoj
 X3tg==
X-Gm-Message-State: AOJu0YwTcrDrRgUOCtL8sA8AmKgGKKm6PlIGvt9hDxk07Xnrs+znJf61
 5FQGqlv1+KxEKPVQ6IwFPYKmrhVEeVpUhieBFBGF7MECIg+4p29RFS/sAoyqHnbtCgihr9rSsfi
 nOZ8N
X-Gm-Gg: AfdE7cl5PpT6LVsBKAeZB+kFj+AEy7SEhrWp0YeYS3eA0Q+QnAm7PmJ6Qsa+4lEZDpe
 J4YYNT/rXGrS6uEOUwHquuEf9glvbiU8I4LCkfR1BShBqdOD3TljQvwPs3XDs6CbXjTiHUFUCBc
 cnFhuB2CZaaOiM81R47NRzZ4wYyILriOut6RSXImObTZ3lkfTFVxuiLbv2wci7WwBbo3cuJRWqH
 w+FtVgGZulQPz3O4Y1HIfKo/rgKyT8fHMXsVdNij6dvkjcV3GKvoTgryjkRfHQw6Av4zckFz8zo
 mprBcctG7OuEkB688mKgdQZSEfdnymCQzq+QUGsbeYMq9n3EocC/0a+0l3DFOinRqq4lT/vOQYm
 wA+JaTWBQSH5GWJ/UxNuBfEzQtj/eUIOf+t5f8yaxu2Hy/1fHUuslHk/qRNmOmrlWvm6RbNOsk/
 3d6jYpyDYgATkJy0sP9DHClQsdw8jDcbmRlwL2EujSF4/9/fNQTg==
X-Received: by 2002:a17:90b:584b:b0:36a:8ce7:b879 with SMTP id
 98e67ed59e1d1-37c9da9a091mr5889490a91.5.1781755642267; 
 Wed, 17 Jun 2026 21:07:22 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/8] target/arm: Implement EXPAND
Date: Wed, 17 Jun 2026 21:07:12 -0700
Message-ID: <20260618040718.572950-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
References: <20260618040718.572950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  5 +++++
 target/arm/tcg/sve_helper.c      | 26 ++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  7 +++++++
 target/arm/tcg/sve.decode        |  2 ++
 4 files changed, 40 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index de2254bb19..1d9066dcbb 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -3203,3 +3203,8 @@ DEF_HELPER_FLAGS_6(sve2_famin_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_famin_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_4(sve_expand_b, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_expand_h, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_expand_s, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_expand_d, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a0a189eb1e..2517362189 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3671,6 +3671,32 @@ void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
     }
 }
 
+#define DO_EXPAND(NAME, TYPE, H)                                      \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
+{                                                                     \
+    intptr_t oprsz = simd_oprsz(desc);                                \
+    ARMVectorReg tmp_n = *(ARMVectorReg *)vn;                         \
+    for (intptr_t i = 0, j = 0; i < oprsz; ) {                        \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
+        do {                                                          \
+            TYPE nn = 0;                                              \
+            if (pg & 1) {                                             \
+                nn = *(TYPE *)((void *)&tmp_n + H(j));                \
+                j += sizeof(TYPE);                                    \
+            }                                                         \
+            *(TYPE *)(vd + H(i)) = nn;                                \
+            i += sizeof(TYPE);                                        \
+            pg >>= sizeof(TYPE);                                      \
+        } while (i & 15);                                             \
+    }                                                                 \
+}
+
+DO_EXPAND(sve_expand_b, uint8_t, H1)
+DO_EXPAND(sve_expand_h, uint16_t, H1_2)
+DO_EXPAND(sve_expand_s, uint32_t, H1_4)
+DO_EXPAND(sve_expand_d, uint64_t, H1_8)
+
+#undef DO_EXPAND
 /* Similar to the ARM LastActiveElement pseudocode function, except the
  * result is multiplied by the element size.  This includes the not found
  * indication; e.g. not found for esz=3 is -8.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9a72e03513..57c21a13e8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6956,6 +6956,13 @@ static gen_helper_gvec_3 * const sqneg_fns[4] = {
 TRANS_FEAT(SQNEG_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
 TRANS_FEAT(SQNEG_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 1)
 
+static gen_helper_gvec_3 * const expand_fns[4] = {
+    gen_helper_sve_expand_b, gen_helper_sve_expand_h,
+    gen_helper_sve_expand_s, gen_helper_sve_expand_d,
+};
+TRANS_FEAT_STREAMING_IF(EXPAND, aa64_sme2p2_or_sve2p2, aa64_sme2p2,
+                        gen_gvec_ool_arg_zpz, expand_fns[a->esz], a, 0)
+
 DO_ZPZZ(SQSHL, aa64_sme_or_sve2, sve2_sqshl)
 DO_ZPZZ(SQRSHL, aa64_sme_or_sve2, sve2_sqrshl)
 DO_ZPZZ(SRSHL, aa64_sme_or_sve2, sve2_srshl)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 2795c2ec7f..5ec1d420c2 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -742,6 +742,8 @@ SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
 # SVE2 vector splice (predicated, constructive)
 SPLICE_sve2     00000101 .. 101 101 100 ... ..... .....         @rd_pg_rn
 
+EXPAND          00000101 .. 110 001 100 ... ..... .....         @rd_pg_rn
+
 ### SVE Select Vectors Group
 
 # SVE select vector elements (predicated)
-- 
2.43.0


