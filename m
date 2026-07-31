Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80218C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppyN-0004nv-RS; Fri, 31 Jul 2026 12:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyM-0004nO-AN
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyK-0000ST-DT
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so923784f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785514831; x=1786119631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dmffb3ULkb7vIrdJ/QxkfBW61OXPmSDopnqZevPnXk4=;
 b=eMCZ5CVBUTwOnQPpUfi6L1rlMMCdj6iERgDiRzpxoJN4vLJAQyJQM73ohITK7ooO2M
 BY74u9UsEnU3T1fyWH1+sCMsTEP0dzZ6Vs1ulo0EpjwmcZkN3DHDZt3N+ohrjJHUpGhE
 +hDP+3CHnEyAaAe2IpNzeLCvLVGJ5XbKZfTaQpnrsLHKqRDkwrl/e4IYNl42QQ79vBfr
 vNkmB3TnJU+K7wJv8+GHXouVrzl38zuk39aY3VINx7bW5shxdVITsMrzSuVy4ZnBvm/Q
 Uq1YzxYVzEAKAWgJQ9Fr8MVPVihbjXB0PxHxpz6zpMVq9Hgozee17BtdKBHL1+VwtzDP
 G1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785514831; x=1786119631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dmffb3ULkb7vIrdJ/QxkfBW61OXPmSDopnqZevPnXk4=;
 b=Al2WH2zz1sSfoC1goAWHxKpuv5yUEa75TwKRMIr27GhHqbzB4Th7AoVATXnWPr6z+E
 5RvUO9N0jyzIOTwUxcWDp2sUIj2NMlJde/aI43hxSGIuPP1OeGm8AXnQtxxAbfBkyAZY
 7qz8HhvR33Sx++IQkzyTSIvw+5lvnqc52ZQbyaCBgUjwu1aBivFVs+R/tQUTLLurCiFm
 6uZDrcxwMBfZniaf+U2xUG4bmvny+QqqCm+h+lhvGkqOHcKRKLWcc3YzWSzBolvfoQkT
 vN2u7CWubuFSQ3hIFWPbwdMqWB/pB1b1pKwW/cnuOAYidqO52wyIPPSVj/wpJFuZ7KHn
 xx2Q==
X-Gm-Message-State: AOJu0YzuTPBrBr7XUVgslECGANZfG17K1jk4cquDTObT9k2xanSIaIeZ
 EKsp0hgJCDiXt8Fixl+nq8CvmWLnSaS8FBWaJgHaHif05TxcZr9OydjF+gk5k7dUImCgV7Gaw50
 1JgbU
X-Gm-Gg: AR+sD10z49ybMjcDpqyZZTMUtvierK1CoYPuK7RubSoY6ZxJiMKLQvyi9pmMC7VJoNF
 IHzTUpnQIrJkduq/c8RMZWjNQM459u9Jsk/G0//jwiTdQBl2fcVFOm9L71vaVY/Mif3vQEshpzE
 Aet20B+XuakvprX385v3OyyL+RW3UTNH9/E1mC6ZZnLXRw8kF5kPiUvC4BbZmxq61Z62VXat41l
 gCD/UR05rfMTwPYy5MnN0dg+FmHdBds243Ofrz938XefEI0lw3walJFZVTALUBKnaoC7XH4oA//
 ISQ8pdy7lP4LS1xILVlUBQXo02wVULsKaZ687uLxZ/4tGXkbR8iINmjzoVFfhOAOxJhF2YDktQ4
 hpRz2l4fDVdm53n9+rrpw1dV2XspRdgQOXontxmVB4+7UZJGM8kNNdvgLOZ72cUaBhX/Q9Vn50c
 kNveH/60fW+pNKWxIaA+ZZ6AawZsYLuhzQBJQwBLnTpHENZvqdidTWao6HC432t3VkExY1kyx29
 +nxebSZqBDdzAKfYO1xv87Y1/v9nRaAUMWeySX3zH1nu9FcnEW2gWSuAMpXbaxd/0r8AthoTNHG
 u8ec
X-Received: by 2002:a05:6000:24c7:b0:47f:8b23:195f with SMTP id
 ffacd0b85a97d-47fd731f513mr514057f8f.46.1785514830411; 
 Fri, 31 Jul 2026 09:20:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm6328593f8f.34.2026.07.31.09.20.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:20:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] target/arm: Don't NOP the SEV insn on v6K CPUs
Date: Fri, 31 Jul 2026 17:20:22 +0100
Message-ID: <20260731162024.3097467-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731162024.3097467-1-peter.maydell@linaro.org>
References: <20260731162024.3097467-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

When we implememented SEV to do something on A-profile rather than
being a nop, we got the condition slightly wrong, and made it only
effective from v7.  In fact the instruction's Arm encoding has
non-NOP behaviour from ARMv6K.

The effect is that a kernel boot may hang on a v6K CPU like the
ARM11MPCore.

(This wouldn't have been so noticeable if we feature checked the WFE
instruction, and had made the same mistake for the condition on both
instructions.  But we never have done the feature checks that we
ought on WFE, so the mistake on SEV meant that we showed the 11mpcore
guest a WFE that did something and a SEV that was a NOP.)

The v7A Arm ARM is not entirely clear about whether v6K has the Thumb
SEV encoding or not: it says "ARMv7 (executes as NOP in ARMv6T2)",
leaving v6K not stated.  The 11MPCore TRM says it has at least WFI in
both Arm and Thumb, and the v7A Arm ARM uses the same condition text
for WFI, so I make the assumption that WFI, WFE, and SEV all get
their functionality for both Thumb and Arm in v6K.  It's possible
that this differed between v6K CPUs -- the 1176 TRM says it has the
v6K STREXD/STREXH/STREXB etc, but the WFI is the old-style cp15 one.

Keeping the condition check the same for both Thumb and Arm encodings
is the conservative choice: if guests try to execute the Thumb SEV
insn it will be because they want SEV, not because they want a NOP.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4044
Fixes: 60e7ee5bb7cd ("target/arm: implements SEV/SEVL for all modes")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260728111629.1705308-2-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index a1fc050618..6e52ad082e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3246,12 +3246,19 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
 static bool trans_SEV(DisasContext *s, arg_SEV *a)
 {
     /*
-     * SEV is a NOP for user-mode emulation. For v6T2 and earlier
-     * non-M-profile cores this encoding is a NOP hint.
+     * SEV is a NOP for user-mode emulation. The instruction is
+     * also a NOP hint on cores that pre-date the architectural
+     * feature that adds it:
+     * - M-profile always has SEV
+     * - for A/R profile, it exists from v6K onward
+     * The v7A Arm ARM is not entirely clear about whether v6K has the
+     * Thumb SEV or not; we make the condition the same, to be
+     * conservative. (If guests try to execute the Thumb SEV insn it
+     * will be because they want SEV, not because they want a NOP.)
      */
 #ifndef CONFIG_USER_ONLY
     if (arm_dc_feature(s, ARM_FEATURE_M) ||
-        arm_dc_feature(s, ARM_FEATURE_V7)) {
+        arm_dc_feature(s, ARM_FEATURE_V6K)) {
         gen_helper_sev(tcg_env);
     }
 #endif
-- 
2.43.0


