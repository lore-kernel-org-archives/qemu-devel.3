Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B4CD2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz13L-0007Hn-Sz; Thu, 10 Oct 2024 17:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13H-0007Fz-3s
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:33 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13F-0004dF-32
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:30 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2e050b1c3so649239a91.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597027; x=1729201827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKyDYgcDRvOCa3U0P656gHylFIpPG3mMrqsMWsAm0J8=;
 b=ACjVhsF0sy7wWSdgEWipskpRikcs1M0fDpTyeGzNFlrhQEff1NesOyX4K0BSQnCg1/
 Er2Ix97Qy9hYkOZILp9IQxIXn0xuovyyMyo/Vvm4HNchBM/INQyrfO8rvLWf1qkDVrYG
 Wvqgj3OjQne39fe7WZYMe6GjlpnScfkq94u9TfeWoYCt4UyBj8S2yDUKyhjS/JYtEHwm
 YzHcnRyAI5+8/II9tM7H+pIjf5+dFEk41OMm1W6TC8upH68KCiiBAV7Resa3WuI2zCXH
 XPDZi6ddsWsYI1KX6i5NoAAXQW54Kn4Vis3F3DhH0uQ7Ohub1VEW88HWYK1KqPyN0n17
 +dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597027; x=1729201827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKyDYgcDRvOCa3U0P656gHylFIpPG3mMrqsMWsAm0J8=;
 b=u5zuBgWfyQ5Oh4cDj9FhxlZ5VKYAU7JoItlju6ExInwY83te/+RLswSlXISCfx5Ryt
 TVRx1s3qPxa8LzVCTYDqHMUEqzbFZfHl+99rQe2LvPdaJ7xUYCOyDp8wcqCe6yjtyVYp
 Ckts6R3uatyXCPwe6k9mk4lr8Xep2kpLNnyhkqAM9Itz9IKDI4htMAwXu/CRQh730emr
 ejGmFrMxC6ZAj7iiwrlAmY6V5BlS2iYyx7VvR2mxjYG7NAl1Zbod1YLnOWF8zPVhadUK
 7Xhf/D1mvDKyyQoip6P1QK9NIDXaRtMfnkQEdddhNgwsxfOKOy9kb/JlCsdDIkTOOuo5
 8lCQ==
X-Gm-Message-State: AOJu0Yxztq+KKxbyG35ipsa9cLxI2F8zzDy7ahx2CJPZ4F6jgpJrHUdR
 v0W2Yn90g5ZPNCTpMiQWKEAxH707gQzK8icLePPqcpqNC3xIe4ZjEnSb3Sk7c7q1KaJBPfW3JFc
 q
X-Google-Smtp-Source: AGHT+IHvsbb5Pg3ami1xHz0C5e8j7MnZBD5Sbb7uK3Z5L7SziYzBA9Yc94VltHeA7CbuGHWwj1+Odw==
X-Received: by 2002:a17:90a:c2c6:b0:2e2:a5fd:7e4c with SMTP id
 98e67ed59e1d1-2e2f0aa8b36mr936591a91.8.1728597027291; 
 Thu, 10 Oct 2024 14:50:27 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a571a2ecsm4137373a91.33.2024.10.10.14.50.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:50:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 01/16] target/mips: Declare mips_env_is_bigendian() in
 'internal.h'
Date: Thu, 10 Oct 2024 18:49:59 -0300
Message-ID: <20241010215015.44326-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In order to re-use cpu_is_bigendian(), declare it on "internal.h"
after renaming it as mips_env_is_bigendian().

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241004162118.84570-6-philmd@linaro.org>
---
 target/mips/internal.h        |  5 +++++
 target/mips/tcg/ldst_helper.c | 15 +++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index a9a22ea00ec..84c8e5e1ae7 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -225,6 +225,11 @@ static inline void mips_env_set_pc(CPUMIPSState *env, target_ulong value)
     }
 }
 
+static inline bool mips_env_is_bigendian(CPUMIPSState *env)
+{
+    return extract32(env->CP0_Config0, CP0C0_BE, 1);
+}
+
 static inline void restore_pamask(CPUMIPSState *env)
 {
     if (env->hflags & MIPS_HFLAG_ELPA) {
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 97056d00a27..f92a923d7ad 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -53,11 +53,6 @@ HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
 
 #endif /* !CONFIG_USER_ONLY */
 
-static inline bool cpu_is_bigendian(CPUMIPSState *env)
-{
-    return extract32(env->CP0_Config0, CP0C0_BE, 1);
-}
-
 static inline target_ulong get_lmask(CPUMIPSState *env,
                                      target_ulong value, unsigned bits)
 {
@@ -65,7 +60,7 @@ static inline target_ulong get_lmask(CPUMIPSState *env,
 
     value &= mask;
 
-    if (!cpu_is_bigendian(env)) {
+    if (!mips_env_is_bigendian(env)) {
         value ^= mask;
     }
 
@@ -76,7 +71,7 @@ void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
 
@@ -100,7 +95,7 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
@@ -130,7 +125,7 @@ void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
 
@@ -174,7 +169,7 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
-- 
2.45.2


