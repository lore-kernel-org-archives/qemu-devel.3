Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589A4C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkk-0003El-EJ; Thu, 03 Jul 2025 04:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkW-0002wL-0M; Thu, 03 Jul 2025 04:56:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkU-0008DQ-2B; Thu, 03 Jul 2025 04:56:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-235f9ea8d08so72315825ad.1; 
 Thu, 03 Jul 2025 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751533012; x=1752137812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlweHpW5fp62HujQOYN5IEIifrxslp9W9q5Rd++5zyE=;
 b=U3pmi3rk7rKJ2BvE+wwT3XSPROk8bjGHUmtKYObdZCxmp5ao1yt9zy+k5iFukD6jws
 FnohXfM+u0GDcrLzWAfUMuVv2Xbeq/TweEJQ8u4el5wbmBa1iK1daRLks8L7poJTjdTy
 meU/3lsaS0U4vDJKElafioeAZKTSQzkl+34jIeZDpRw5LLGTWVb2a4PIIOSifdbN8p4s
 Kw2hkKTqfqCjcUI8X2CeuoFLt3MCMoWzt2ZVasyz0BOIjLljzxw7+0lzAhxVLSFCWOwb
 DyNJKTky5LpbCbtEhQSkwm2Cnw2FSLfuMnQJW/hOCbNSdU/OlHqlWJzA9stDoSuMStU7
 4YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533012; x=1752137812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlweHpW5fp62HujQOYN5IEIifrxslp9W9q5Rd++5zyE=;
 b=Lx1ZobtFJmYbBtykMTUVP4gktPk79UlLNYF+0LKeH9SJovF6KiS4V9H/v96CoHIxrX
 4Mg8UTSHk0zpa++46N4KruPJ02n90Goliket2jkRxHAeqC9zmCBkpfE4iLbLQY5pnYPM
 ALEBf+ICH2SKav4wWLEPaIIO9IbAIDQ65PJIb8IbZV+fFF/mK/YgPPASvOLw1E4motzR
 +rVWzkyXUEcJt4jCWjqKgs/NeeAeDn6R1D2FHg/4+4CoEoRxxsI/Rx7Garn19ZSyLdjD
 CUG7S1Gq8obUCZKpRzy1s80/JEZhyuowbfuUMtW1ZRLu6kk/x2LbXpoXSYn6vW3pv58h
 d8IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWegqcEJa1pb3Pgdv5lUkJpY3WaAoCX8kVJEVR2eTCWsaXHPXVgtUGpXi4y1G2B9MHnnuaQTtcHzw==@nongnu.org
X-Gm-Message-State: AOJu0YwFAL9ErLEFGPbP7VEOud1yVPE3TMAQkPaiIwwIm9U1BELYS80K
 Ylp67UaMhZMw5P2SJRZpp4bca/JTfGS/eh9JD0sxPrCrnbiDPPA0hEOQth0CCoRpjFo=
X-Gm-Gg: ASbGncvN3wBIfeFyhvX7wYoUIphHgMq5bzjOm5DkZcHL81GXYBhVgD0sb8yLohUY4p6
 +pA/ckBFCp1qPJiWQYZWaKLTPgb3gfvgai1IAM99SAOfB0t6/GD7ZGu/2FpmvCvuQo7WCKqcnlV
 bQzkSc6/pCVY7BAhRkmF0fPgCVyJCL84jhSZM3hofQMYsUzcogrJAVJ/074P8C5Fb7z1Txo53Q9
 f03Encj6d8Wt4/4A9EGeWPaeoKlpYBG7p2APHM7hBeQVygxoq4Er3jD7e6bj9D7W6mIgjWjZtNh
 ZJ5/oNSxMtbnnDQ+aIJaViz16KmcOj2bb5OoopAk3x2YmIDsHG5ntMFRTdLRvgwh9K7AjhMTPEk
 UexpgyC8HktWC8nEdj04Q0Y3GZSEbIk844d5RkWkoMNI=
X-Google-Smtp-Source: AGHT+IFQzip9lbsYdcynhldNUXjJdq7jRyo6hd0xt79MhSICX8f7gTN5nz2beMJIHLqqTzwHpQ4Aiw==
X-Received: by 2002:a17:903:985:b0:22e:6cc6:cf77 with SMTP id
 d9443c01a7336-23c6e5e2804mr107805445ad.53.1751533011822; 
 Thu, 03 Jul 2025 01:56:51 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb2f2569sm157045585ad.64.2025.07.03.01.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:51 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 08/11] target/arm: Fix VLD4 helper load alignment checks
Date: Thu,  3 Jul 2025 18:26:01 +0930
Message-ID: <20250703085604.154449-9-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations in the VLD4
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 2d21625f24..7069910db4 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -403,13 +403,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint16_t mask = mve_eci_mask(env);                              \
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 4; e++, data >>= 8) {                       \
                 uint8_t *qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + e); \
                 qd[H1(off[beat])] = data;                               \
@@ -427,13 +429,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t addr, data;                                            \
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 8 + (beat & 1) * 4;               \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + y);             \
             qd[H2(off[beat])] = data;                                   \
             data >>= 16;                                                \
@@ -452,13 +456,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int y;                                                          \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             y = (beat + (O1 & 2)) & 3;                                  \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + y);             \
             qd[H4(off[beat] >> 2)] = data;                              \
-- 
2.48.1


