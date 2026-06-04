Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D0FCD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoN-0006wB-7J; Thu, 04 Jun 2026 19:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoI-0006rv-C3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoF-0007zN-PQ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2bf55c39e16so10737795ad.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616950; x=1781221750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5keFFD8RhaG/QP5KTy8CIfk9qHLYNxUXSARl0rphmE=;
 b=Y78SSrkfljpVgy+WXvEVnRcBAK3+b5CNu6o01RUucNW08FcAjKUwzf/Ajk2T4LS26M
 91djaKjphjXCsSc3R3PkZZS6cHl7huHCghQQwXYag8WkQ2Fe9LPNSwrUXBNfbnQJ3nf8
 adCkEtG6MiIcB7MxIKjjLUurEIj6lFFavpX/lirRlw2PDfI69Kn2SDO1WiQhykpFON/q
 mqAr9ZSUNcMVGIH5A0POimJIZiscmBTUexlZ6PApdnLNXtUCBW1vYvn6oZInW9823s56
 mmgxaxdsx/1mrDYCOFvImJA3h5pr+/0vKvVCx3A2neDgbRBVFphbnwpbbwqY2aDMJXeW
 zVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616950; x=1781221750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5keFFD8RhaG/QP5KTy8CIfk9qHLYNxUXSARl0rphmE=;
 b=cs8tyDrQ1COtWBPVSah2mN5VQdBrcQummWVXJAL+sUJ/1bhm0GtiIp7uBBd2786Ane
 8Jaw7mIa9NLqVq58rx/PD+lnVkllQJBd8bUvVnXV97N3i4Mj/hq/F1jGfFjxXDJ1pmtn
 Oh1trsTyaIa5A7TsxZoB+0EqX8WMO/CQIjqRPlGya1O9PVDnjbWW5bIuoP4fCSWu8saw
 1yavJ12YfJvasfUW4TgJeZqmPm4bS0yl8mWH78wrdhoWI4TCnfwI7dHeEmEW5AK7kh19
 sPilqghYHT7Sfd6A9NhvK7GhTJ1ZVB03lFKnsjqMUok9yEpZniEkwqAarsiSg3gjl8ac
 sI1w==
X-Gm-Message-State: AOJu0YzmpW5h7PWb8lFSDF3DRfWpSi5Kx3ZnpjHavDCVx+dFl8h6ey04
 20GcBcgfNW/QGTL9iAGPZXO2gQL/FvskRMjZ7ZRh2tM44qr779nO27/i3q4DIH8f/lPrVPywH36
 mzUOGvM0=
X-Gm-Gg: Acq92OH5gK7XVVVH4jmtMxEb7QxoK07cjYcBwiIZfqgCU5Y0RM49O3q/NEr09RXWPAY
 caRdEfcJwRTZiHhptmxg1i6vs8vMvmXnZVHrwzfDPKsRDDgn3k9AJhkgx1wkiHPBdg88ecba0uk
 wmwD4DwoQso9R5PLjxHkNf2pTBjkgBTi0po9JoJYv/5m9QJR0N9LCNoWydbR2UjGk8UkNboOqy/
 rkCmwgy8t8V9NIfGIfI7kIlO8q1v1bfDRIWul0ZeitRd/pI25ON03gGToRwP5RrYfSAC6ywuVZz
 ZgrjnUDq17d9Q939SwJOPjiPrCC3Hk/bCXYpgm1bxuzUkEHbiP2SXOSYMGxJcb9kIp2OFqDYY53
 OOUB81sEKR9UqTm42lYS9fMM9KpnIX0S+y8YZ9h9uHCX5hnpFxPxscmJIj5gY651nXLWYwNlZL7
 oLtDPWEKXkWmj67wWtEmTWHpEk33LWF0OmSpAqISI=
X-Received: by 2002:a17:902:f706:b0:2bc:977b:846d with SMTP id
 d9443c01a7336-2c1ec66cf3bmr1723805ad.5.1780616950329; 
 Thu, 04 Jun 2026 16:49:10 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 23/25] target/arm: Enable FEAT_SVE2p2 for -cpu max
Date: Thu,  4 Jun 2026 16:48:50 -0700
Message-ID: <20260604234852.573178-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 4887a3a7b7..c4d2d35741 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -173,6 +173,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
+    GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 15c1ece4b7..38e5a8d912 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1359,7 +1359,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 3);    /* FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 64b2a87e1a..868ba37e3a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -178,6 +178,7 @@ the following architecture extensions:
 - FEAT_SVE_SM4 (Scalable Vector SM4 instructions)
 - FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SVE2p1 (Scalable Vector Extension version 2.1)
+- FEAT_SVE2p2 (Scalable Vector Extension version 2.2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
 - FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
-- 
2.43.0


