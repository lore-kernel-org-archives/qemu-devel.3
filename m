Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E97C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMe1-0001gb-DC; Fri, 24 Jan 2025 11:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZO-0005vv-SH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZD-0005o6-JQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43626213fffso22184765e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736198; x=1738340998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=phqWKrFmcHTgW6QQ28uLmFCKUWP0y8vEv9xKJtoc0vQ=;
 b=G1vWMb2wVMZ2enIicJMMhBT9OEF/8oa4viM0FxpZWLT96e5bO5qtyKLzQh6ruQhwCJ
 QEToXjuIvByoFaQW+kBNBMWTk4f2ynA32Rw+QaCd81FdyGY014ljZnAG9UGdMfi0zz4J
 QLFlQhIPlEo/3tN7fisuZ5W4cZbz7NxPnSWviM3xupdS+dxnSe3RalV5FuFZgJcbEOvu
 9CfGlQ9itGxgPfRSOup9Ix/BdeQJGW5ovFGxesgB6f66pgfyc4EaALpHJ/jkT/m6iCIg
 UWjztnam4gLmo7wrbLgDF9b81bRpxmxwhqJP35V2pbBkIiLZKLM8AeUNZiwtJCqowSC7
 idcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736198; x=1738340998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phqWKrFmcHTgW6QQ28uLmFCKUWP0y8vEv9xKJtoc0vQ=;
 b=bRbgtNtF3HR7TN5KljuuVSkHsIkFJOTH9/LLzFnlvy8gaqJZlcV780YiFjkr365IF7
 RKeEte/gb4SE+7m5ifA5ZxygSEQRNPhHD6KfdFgGIOEzFD7fdV3vtvF1jgnqRqnx54pl
 3gykzflUUG8OHfwXgcp50vxcLKAt6QkaOIsKfHoD5R66W0s1Btawc9e1ANmdC48LkpQ5
 HJak/8KkCRmHQjs88mMG/HjB3LNLXqYfRuw2QEiX0olJv3j/y5N1KQT2WN+vUtdthFYF
 RG4bBTGWVPSWBpQqtV6Rfj1I6BXDSdtge56lw8DpMrye/dqBxRr4L2fm87FNkXT1P3Jz
 6dbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh4cosk94uI+nm0t4wD32csy8mKiaMIk7SvnmJudfjGjUz1NK4CNhbnvjJm6o3RUVHrGL/r2vLUzlx@nongnu.org
X-Gm-Message-State: AOJu0YzJUsHRUMl7D1UfqXwJtKMRkn7xm6WOxnmyrH5s2vqFJOT3piQL
 FNQiARgUMyIjVxggU+7jp/1dnoLkmPpbYLO9dBy6L/0GSXNqjzmN/2kv0JgrBBg=
X-Gm-Gg: ASbGncscSiv0M/Buwq0ek4HQSlsx7qMInTe2aUtfJoK+tvsHdSTmlvzPs2PMokYs9J8
 +aktCDOWCM49mzERDps1mOJlLcp2POGEitqK664+Fses65uwebikwoy641aKQPkVHTKWqUy05yQ
 gRSYJex46dn6wbSzRDvYvNtZqlECjinSmFm/R92Bbz6afb72+9Lrja4QngnQwVeirp0jctGeDMb
 bpVO+vg87eTioTnSgxTG/FUPkuJZWcGyI87sobxDPS40LvLDtd2OxA10jev7J4P9h32F6uwJFql
 Dq6V9vfZx4w=
X-Google-Smtp-Source: AGHT+IHggNZ6Emk42RLJ/lQOf9z3VkgoXs0AzOYsgRFDrxp0J0HHgpN+l7BMqVGf/eU0V0QsUDLL1w==
X-Received: by 2002:a05:600c:1391:b0:434:ffb2:f9cf with SMTP id
 5b1f17b1804b1-438b88603femr75243415e9.14.1737736198236; 
 Fri, 24 Jan 2025 08:29:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 63/76] target/arm: Handle FPCR.AH in negation step in FMLS
 (indexed)
Date: Fri, 24 Jan 2025 16:28:23 +0000
Message-Id: <20250124162836.2332150-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics in FMLS
(indexed), by passing through FPCR.AH in the SIMD data word, for the
helper to use to determine whether to negate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 9 +++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3fe8e041093..c688275106f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6751,7 +6751,7 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                       esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
-                      (a->idx << 1) | neg,
+                      (s->fpcr_ah << 5) | (a->idx << 1) | neg,
                       fns[esz - 1]);
     return true;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index eef3623fd3a..a7033fe93ab 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3533,7 +3533,7 @@ static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
         gen_helper_gvec_fmla_idx_d,
     };
     return gen_gvec_fpst_zzzz(s, fns[a->esz], a->rd, a->rn, a->rm, a->ra,
-                              (a->index << 1) | sub,
+                              (s->fpcr_ah << 5) | (a->index << 1) | sub,
                               a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 }
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index bf6f6a97636..5e9663382a9 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1708,13 +1708,18 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
     intptr_t i, j, oprsz = simd_oprsz(desc);                               \
     intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
     TYPE op1_neg = extract32(desc, SIMD_DATA_SHIFT, 1);                    \
-    intptr_t idx = desc >> (SIMD_DATA_SHIFT + 1);                          \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 1, 3);                \
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 5, 1);                \
     TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
     op1_neg <<= (8 * sizeof(TYPE) - 1);                                    \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
         TYPE mm = m[H(i + idx)];                                           \
         for (j = 0; j < segment; j++) {                                    \
-            d[i + j] = TYPE##_muladd(n[i + j] ^ op1_neg,                   \
+            TYPE nval = n[i + j];                                          \
+            if (!(fpcr_ah && TYPE ## _is_any_nan(nval))) {                 \
+                nval ^= op1_neg;                                           \
+            }                                                              \
+            d[i + j] = TYPE##_muladd(nval,                                 \
                                      mm, a[i + j], 0, stat);               \
         }                                                                  \
     }                                                                      \
-- 
2.34.1


