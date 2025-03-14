Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAFDC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uE-00059k-OS; Fri, 14 Mar 2025 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uC-00058h-IB
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uA-00015k-76
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1172201f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958209; x=1742563009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DvXgBHhDfQDJ4cRYmWkhbN70Za6+ZucTF502DMfe7mw=;
 b=IvCwQhSM55pSEB1XkIJ2bNKSwfzH41tRb3r1qQ45ZpKJZHEyupZiL872utyvA4vX2J
 1A/r2Gcui3XBDGLcelIcjgAD2a8iXa9JlobKyGf6cjH7EFN7cEaPshoPKHhVsym3jKFf
 FlnSi1+C3MBMCNc0VOl5hR19zxJmAdel+F2miRQuExXrEcDQi8/FUKtnObOGZh/gvlMV
 N0LZyeoIRMGud5ozuHqkmk7vlI/le6zuGI+TnAiIu5BpftHXWAi5t+G0StnwOvMvyngm
 hBXfiAqCgl2rh2csTlTip318DwQCr90D/a+8UsZ/DsJQEHjMaNEl5t0mFmujAVuo8yT1
 +MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958209; x=1742563009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvXgBHhDfQDJ4cRYmWkhbN70Za6+ZucTF502DMfe7mw=;
 b=wJYoCY+oD5HRgqpD0bWmqs+O65LPey/4UyZU/l2p4QMx9RXxbx/mi5DjF9QB9/8RcV
 sIywcXKckZX6Y73rxXGXTo9kMEw+QizJWA5lrLl/z4ueydpLZI8UPBfU9kMDfkRLBVX5
 od6J13vKXLYIr+32FGffJ8WxPMi67I5QtMDWoLah9V1u/yrdejVEpNTSrJOqlpl8TCsi
 DC8t5mVrZDVUOZnpPIEtBMk8RyogYrHWlODonP6YEiTTyrZ2DQyO0JPv7Y7HNAZFyzkA
 yIGqpiBii8QzJiNp0rVWAYVey3XYy4j/ArkpIrxT8w5KKhw1b3bGxALdLayG3b97psEH
 F0ag==
X-Gm-Message-State: AOJu0YwyxGULQOZbdZhW0pLIKbdAXjp8jMbCiVakg0BbhH43t7eFpQ9e
 l1fg/eYCGBLySxCX3VADTPpWqVvSW3PGOtQbZd5Caqw1fi2DX4T+9fxkZmd2B8e9vGUqXgBYF6m
 N
X-Gm-Gg: ASbGncsRpW4Oe6x1Udf70coIeaIfbbN1mxDq7NUfjb/BFOsnL2siPFRTEC5oJxbPP0u
 wZWeNjuygtdlXrRTAGCyNcaShqGW3bndkOC2gemZ8+FBeg6kzwDPez0L5Qeba6ZFWOiOsX4uLsT
 2daaVGM+QjOGQpDhNkg49FSSdJ+l95Ggs/8ZaVvjofLoNLTEMXOYv8NFidJwgGDIttzXlH/h8yB
 C22+QNt5RNEkiXaNW69GuXbvmxHotTxA4jt+aBMMuanRCp3ZDx80DRixYG3wpWBrIVwuxEePXfU
 6+BjNnn102qXCn6VXk9GFRpPXxAVMQpzwo7A1Z7Tl8DXG2hxPCE=
X-Google-Smtp-Source: AGHT+IGacwWFEH/VSquE9OV46OYXHGOU8Csl+h3M9FYNVPiLyWjzQeYzu/q9QG0EF6tIQxMNilHEGA==
X-Received: by 2002:adf:e04d:0:b0:391:2d61:453f with SMTP id
 ffacd0b85a97d-3971ef3b428mr2560469f8f.24.1741958208736; 
 Fri, 14 Mar 2025 06:16:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] target/arm: Add cpu local variable to exception_return
 helper
Date: Fri, 14 Mar 2025 13:16:29 +0000
Message-ID: <20250314131637.371866-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
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

We already call env_archcpu() multiple times within the
exception_return helper function, and we're about to want to
add another use of the ARMCPU pointer. Add a local variable
cpu so we can call env_archcpu() just once.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 32f0647ca4f..e2bdf07833d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -631,6 +631,7 @@ static void cpsr_write_from_spsr_elx(CPUARMState *env,
 
 void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
 {
+    ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
     unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
     uint32_t spsr = env->banked_spsr[spsr_idx];
@@ -682,7 +683,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     }
 
     bql_lock();
-    arm_call_pre_el_change_hook(env_archcpu(env));
+    arm_call_pre_el_change_hook(cpu);
     bql_unlock();
 
     if (!return_to_aa64) {
@@ -710,7 +711,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         int tbii;
 
         env->aarch64 = true;
-        spsr &= aarch64_pstate_valid_mask(&env_archcpu(env)->isar);
+        spsr &= aarch64_pstate_valid_mask(&cpu->isar);
         pstate_write(env, spsr);
         if (!arm_singlestep_active(env)) {
             env->pstate &= ~PSTATE_SS;
@@ -749,7 +750,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     aarch64_sve_change_el(env, cur_el, new_el, return_to_aa64);
 
     bql_lock();
-    arm_call_el_change_hook(env_archcpu(env));
+    arm_call_el_change_hook(cpu);
     bql_unlock();
 
     return;
-- 
2.43.0


