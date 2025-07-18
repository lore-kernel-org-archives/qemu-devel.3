Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801B2C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucp8Z-00009i-Mt; Fri, 18 Jul 2025 13:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov2-00054b-30
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucouy-0000rR-NT
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso1454243f8f.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859843; x=1753464643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyMsfSztYFHbGVMCLKLC5I8Ijnyva6nXu44zZ1IshgE=;
 b=ljupMkHrAwyFR9XozWzoypbNuZqqiZDg4n0HEJuO5c6aPfpLTjo6zbZuUaohmE106J
 5LiWxtbgq0EbDIEQR90PDHN+eveBM9P2s+19UzTOQjdGdQjpd4cMw98g0wxh7ZG7gfNb
 ThwInp5LjbR3gnK2BAZFSS0GlSFZAvqowIKQiLzGzwmX2zygy5vTyV+BALdMvGhsNqUe
 HMu1m2f3k9Nspf6MROhYGe/D7fi2lqkW2QMU+mRu9JYqPtBlaFcmIHp1Q6IOFgOkxqok
 g4/eC2V2NGAd1Fk0+AuU99lvuiFUm7UF9oBXv6HbpC/WHbjKqI2JNywgf5iTWbKnStt6
 wqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859843; x=1753464643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyMsfSztYFHbGVMCLKLC5I8Ijnyva6nXu44zZ1IshgE=;
 b=L4Qm7pHUUNrNIFCGGq9mrDg1CzTk7qD24vxCfDwaGk2gZeYYI57SH77MjxJe2EqpdR
 r+r59w+xDAHF7y5XhcpbceCqvCPn3qFoSPlAnvOKp+bDB95c+JVtx+U4O9mg/gYjijcr
 +s9gIjdgz1R/nT6lHbT9LI7mizt6AG97H54hXRBSKhm/Q93yLr3bSPaganmgIX9tda1s
 aXDKpb4f+lmMYHBUYqp3JmsAVbRcV92RBtBsDDNeBAkMPxo1fVzj7rY/x0DhhWuj0qZh
 Db+HsU9h/4D3+LKu7Z/DWBFqDSVpk2SHM40GCIeSAo2XBoG9fGUuRq8TeyZfq16JXdVw
 eOlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdzEK9tiIHK6CwfurKo51MCAm2QjQfQiVq0lrA23wTXDGvsstb0Y87gyCN6hrgyVgxWeCAuj5/5d2R@nongnu.org
X-Gm-Message-State: AOJu0YwjOu+tV03bM0QylVslcQjSbjSVkY2sZnb/oppmpnqkwwwJTUMW
 XcKBZdKRYSne+QAeR16kioFvWNJ85m5lSJOzMZ9sZ21nnwD5/xkxBkINjXvSqyy/bC1wurr3zk6
 2hAnH
X-Gm-Gg: ASbGncsyGN5AvqnC7nBeKK1WC1CexPHq4o141jri+WzdMaWuBrrSRQs+uUxCZwgs0qZ
 Oali8fHeBtApYBbwPh+9Y8F3HCKEX8ujpylbv3pA4ZStciAWoWVVpGoxO0w7QvVhfGkGgPIadH7
 xC0XWPFJHOBztoiNUu7Mqp22kmIcVmYyDQL6pJMsxGvH0uSoQlxxpDjORzh6RDPXyMeYdClJhUD
 I1s6FU2Y+nGlvffxVclX3J11ayQdTb7rpZOv04VMAhg1yCwiO5LPr2O6e/OxrE0+R4D3hS3vfh8
 GVVVY/2YmpH6FZzFQDQiJCfUj+VYl6wyntA8sadk73Inl+3l8Iktz5fobWEAPIoxBTs4Rsu7PQ3
 8rCaPd7ZvIxGRdCzQ3xmEXiwzQc5nim7sVj+TJBw=
X-Google-Smtp-Source: AGHT+IF8JvaDI+K4gJ6Ood9Ko2I0lJRIE7kQvERFUFXAxL5aRNdguIns1WeHEMxzzgU7H6yDCVb6vw==
X-Received: by 2002:a05:6000:2002:b0:3a3:ec58:ebf2 with SMTP id
 ffacd0b85a97d-3b60e4c4915mr7728316f8f.7.1752859842562; 
 Fri, 18 Jul 2025 10:30:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 06/10] target/arm: Add BFMLA, BFMLS (indexed)
Date: Fri, 18 Jul 2025 18:30:28 +0100
Message-ID: <20250718173032.2498900-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718173032.2498900-1-peter.maydell@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

FEAT_SVE_B16B16 adds bfloat16 versions of the FMLA and FMLS insns in
the SVE floating-point multiply-add (indexed) insn group.  Implement
these.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  2 ++
 target/arm/tcg/translate-sve.c | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a76f2236f43..a77b725c876 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1052,9 +1052,11 @@ FCMLA_zzxz      01100100 11 1 index:1 rm:4 0001 rot:2 rn:5 rd:5 \
 ### SVE FP Multiply-Add Indexed Group
 
 # SVE floating-point multiply-add (indexed)
+FMLA_zzxz       01100100 0. 1 ..... 000010 ..... .....  @rrxr_3 esz=0
 FMLA_zzxz       01100100 0. 1 ..... 000000 ..... .....  @rrxr_3 esz=1
 FMLA_zzxz       01100100 10 1 ..... 000000 ..... .....  @rrxr_2 esz=2
 FMLA_zzxz       01100100 11 1 ..... 000000 ..... .....  @rrxr_1 esz=3
+FMLS_zzxz       01100100 0. 1 ..... 000011 ..... .....  @rrxr_3 esz=0
 FMLS_zzxz       01100100 0. 1 ..... 000001 ..... .....  @rrxr_3 esz=1
 FMLS_zzxz       01100100 10 1 ..... 000001 ..... .....  @rrxr_2 esz=2
 FMLS_zzxz       01100100 11 1 ..... 000001 ..... .....  @rrxr_1 esz=3
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 37ecbc2b7c0..fc76624b5a1 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3883,24 +3883,31 @@ DO_SVE2_RRXR_ROT(CDOT_zzxw_d, gen_helper_sve2_cdot_idx_d)
  *** SVE Floating Point Multiply-Add Indexed Group
  */
 
+static bool do_fmla_zzxz(DisasContext *s, arg_rrxr_esz *a,
+                         gen_helper_gvec_4_ptr *fn)
+{
+    /* These insns use MO_8 to encode BFloat16 */
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
+        return false;
+    }
+    return gen_gvec_fpst_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, a->index,
+                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+}
+
 static gen_helper_gvec_4_ptr * const fmla_idx_fns[4] = {
-    NULL,                       gen_helper_gvec_fmla_idx_h,
+    gen_helper_gvec_bfmla_idx, gen_helper_gvec_fmla_idx_h,
     gen_helper_gvec_fmla_idx_s, gen_helper_gvec_fmla_idx_d
 };
-TRANS_FEAT(FMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
-           fmla_idx_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->index,
-           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FMLA_zzxz, aa64_sve, do_fmla_zzxz, a, fmla_idx_fns[a->esz])
 
 static gen_helper_gvec_4_ptr * const fmls_idx_fns[4][2] = {
-    { NULL, NULL },
+    { gen_helper_gvec_bfmls_idx, gen_helper_gvec_ah_bfmls_idx },
     { gen_helper_gvec_fmls_idx_h, gen_helper_gvec_ah_fmls_idx_h },
     { gen_helper_gvec_fmls_idx_s, gen_helper_gvec_ah_fmls_idx_s },
     { gen_helper_gvec_fmls_idx_d, gen_helper_gvec_ah_fmls_idx_d },
 };
-TRANS_FEAT(FMLS_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
-           fmls_idx_fns[a->esz][s->fpcr_ah],
-           a->rd, a->rn, a->rm, a->ra, a->index,
-           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FMLS_zzxz, aa64_sve, do_fmla_zzxz, a,
+           fmls_idx_fns[a->esz][s->fpcr_ah])
 
 /*
  *** SVE Floating Point Multiply Indexed Group
-- 
2.43.0


