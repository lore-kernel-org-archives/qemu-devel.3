Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ED3CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZFI-00066V-K2; Tue, 16 Jun 2026 15:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8R-0004hi-S1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-0001AZ-2P
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4624c1409c9so80241f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636853; x=1782241653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=va+Qk8Dozw43WMNLNX2dHO7L1LT7PhC4dtXopinZQmE=;
 b=cK3y/W0UD47twVhzMTm2TnWpUxXbUfGhJJ3byYkvwj9ijbA4YLceDApjdJwXwJtr5D
 TvnyQ5nZnZaTDc9VpHoM7fTfktOJAiAoFw9HXcHzKLcttn+9y1eyNh6AX5A+Ww4lH1JP
 9vfB8TmdmdzE3N2+H7ApKc3NPFj1NQs0zPQU3ZztM43zYZjEMV1n79d19T9htAxX/3rp
 CJ/t+vSkjJYDtFEaZwuDz1QxUgX9fIBvrGZyCUw02a34HN/lgfLCZC2RPQaEvUJVjDPt
 v5heHwAR9qLEZ5uZcfaO2c0myeTGAISZ8lMpQd8ZsWB29vgzkh0Ugq6OnHwtUbqU3u1x
 6bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636853; x=1782241653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=va+Qk8Dozw43WMNLNX2dHO7L1LT7PhC4dtXopinZQmE=;
 b=XF1s3+CudBs7/9Cd4PuA4d+9sm3/exexGJZdMNsR/PMy0SGqcPQCreg8RjLBfCln3Y
 NvYjFLYcHSzGUtzte7cF82pK0M+9XA470uiE09Un9prdhSd9oBipOtqrwupgjaUPunMi
 aer6sPyOwH9lsxw/LLJJ0SATDhq0BfCyWJPGe4sSHVNgDt6TevoAOKv+t7qowl7xwedc
 1bT6rekUryFkRaAG/LtOoWNV18TaaAbxcoAPJYjJozllViRq8W5aOfJsOXVO05ZlRTcO
 uf3343vIxxH6utndhNyIXjGPsor52ChfCdJFr8DIeCdGpLiO93AnnWm9XzpYX3mfHo96
 25ZA==
X-Gm-Message-State: AOJu0Yz7xbtcUNHDnmc8ZwG2j/BB5NFLbciWm5EBy7+vm59+LZkJDItU
 wK4f7bVtmvRIEg3QCynGTJS36Nm1EvNEe4yQUVwBivQYgF4gX28os9kOgBRe/OjJyZ+1yvKCqOL
 X3aM1
X-Gm-Gg: Acq92OGIezFJ/jG43buUeCi7vlXRsy619S373QqRecna5ZVds73gfxBHQZuVOozO+RN
 wUQiISf+OySDLfnTWxnFqDSE9CSVua1SjPBgXK7NXXj//vzKXvkxBSm3r99vdpibliB4r/cKjzZ
 qd38/A3SJmXdaakkb0HaEPb+bYpl6viJwTfEbhALFlSuNN3Za64ZE4crS/g9r12/YWt12O1Bhub
 tZkFZB67T4apD8C5e1SdirkHGDLgtA3kbVXH7nKOSNtLTlkUsncF3oscW9ukZeDQz8fN+oibl95
 FptmRWaxbutm/VW7BcUbFNfstczAIK93m5u869DqDMTE1ynj8qLMiMfk6ZHEiqYYJny5Usrcoob
 LEejytL9ILvVtuPEs0Nl3jP+JFvzg+Q0cDDHMamL63loOKvVuv72fi8QubepKHhlbBQmhuR4uLW
 TZnObXp8388g2t2BrbUmrdtFdP+2Ogor7pKD9kliaKj5Sqlcpr+SBjTY3d/k+6E+7JD0y8qJ0ye
 2izy5gXvcGvaC18Cbq4cnjndYhv2K76
X-Received: by 2002:a5d:68d0:0:b0:460:3233:beed with SMTP id
 ffacd0b85a97d-4623908e2fbmr997333f8f.41.1781636853170; 
 Tue, 16 Jun 2026 12:07:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/61] target/arm: Enable zeroing in DO_ZPZ macros in
 sve_helper.c
Date: Tue, 16 Jun 2026 20:06:23 +0100
Message-ID: <20260616190639.3462006-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use the low bit of simd_data to hold a 'zeroing' bit.
The simd_data field is currently unused and always 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index d05d8addfd..9634517925 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -823,18 +823,20 @@ DO_ZPZW(sve_lsl_zpzw_s, uint32_t, uint64_t, H1_4, DO_LSL)
 
 #undef DO_ZPZW
 
-/* Fully general two-operand expander, controlled by a predicate.
- */
+/* Fully general two-operand expander, controlled by a predicate.  */
 #define DO_ZPZ(NAME, TYPE, H, OP)                               \
 void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
 {                                                               \
     intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    bool zeroing = simd_data(desc) & 1;                         \
     for (i = 0; i < opr_sz; ) {                                 \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));         \
         do {                                                    \
             if (pg & 1) {                                       \
                 TYPE nn = *(TYPE *)(vn + H(i));                 \
                 *(TYPE *)(vd + H(i)) = OP(nn);                  \
+            } else if (zeroing) {                               \
+                *(TYPE *)(vd + H(i)) = 0;                       \
             }                                                   \
             i += sizeof(TYPE), pg >>= sizeof(TYPE);             \
         } while (i & 15);                                       \
@@ -846,12 +848,15 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
 void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
 {                                                               \
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;                  \
+    bool zeroing = simd_data(desc) & 1;                         \
     TYPE *d = vd, *n = vn;                                      \
     uint8_t *pg = vg;                                           \
     for (i = 0; i < opr_sz; i += 1) {                           \
         if (pg[H1(i)] & 1) {                                    \
             TYPE nn = n[i];                                     \
             d[i] = OP(nn);                                      \
+        } else if (zeroing) {                                   \
+            d[i] = 0;                                           \
         }                                                       \
     }                                                           \
 }
@@ -4831,7 +4836,8 @@ DO_ZPZS_FP(sve_ah_fmins_h, float16, H1_2, helper_vfp_ah_minh)
 DO_ZPZS_FP(sve_ah_fmins_s, float32, H1_4, helper_vfp_ah_mins)
 DO_ZPZS_FP(sve_ah_fmins_d, float64, H1_8, helper_vfp_ah_mind)
 
-/* Fully general two-operand expander, controlled by a predicate,
+/*
+ * Fully general two-operand expander, controlled by a predicate,
  * With the extra float_status parameter.
  */
 #define DO_ZPZ_FP(NAME, TYPE, H, OP)                                  \
@@ -4839,6 +4845,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                       \
                   float_status *status, uint32_t desc)                \
 {                                                                     \
     intptr_t i = simd_oprsz(desc);                                    \
+    bool zeroing = simd_data(desc) & 1;                               \
     uint64_t *g = vg;                                                 \
     do {                                                              \
         uint64_t pg = g[(i - 1) >> 6];                                \
@@ -4847,6 +4854,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                       \
             if (likely((pg >> (i & 63)) & 1)) {                       \
                 TYPE nn = *(TYPE *)(vn + H(i));                       \
                 *(TYPE *)(vd + H(i)) = OP(nn, status);                \
+            } else if (zeroing) {                                     \
+                *(TYPE *)(vd + H(i)) = 0;                             \
             }                                                         \
         } while (i & 63);                                             \
     } while (i != 0);                                                 \
-- 
2.43.0


