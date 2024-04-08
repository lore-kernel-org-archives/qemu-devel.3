Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423CACD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtqqr-0004qT-9E; Mon, 08 Apr 2024 11:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtqqf-0004p0-1S
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:23:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtqqc-0005QQ-7f
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:23:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34388753650so1965086f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712589828; x=1713194628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uw8YHTNyC106MuzA62WIiauW6nzUr+KdLlKVTICYJPA=;
 b=aAD4PAV5z+K5/L+dLwI5czMd4fU6QHZGH4OSqlvwU6pew5YDnvCIjserkcwszbvsvj
 zUO2fZke3yyVVbjeZBXIUZCdZwa0/HjAn7vt2vgTfOVbGMRYq0rZn8Nu3c4bdgiVkB15
 CKKpkqEI3WJKUWC0MZLyC/ZB3TZ2HypkyS5XuaIF7fccdiFNFVLEADH7+Czf1H1Tye0H
 PcYryB/SA5LhetrVH9iTcgX5YhyfE9bEby0J5qEkTLljiOw18xpVWP/lroZLj5Z3ber5
 Enwoc1emOT5a7yH9u2Lfiby4fe28PnfYaxoeZuDfFS/p4+dtFl4snPgvoYnD537LpFqN
 9MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712589828; x=1713194628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uw8YHTNyC106MuzA62WIiauW6nzUr+KdLlKVTICYJPA=;
 b=eXlQG4a2C7Y83WQ+bx2/D+3XKcnPAXjtVMt9AibFKBeRacwqGo4997ORUZTtN6z/KQ
 /+2C3ImX4MucU45nt/qE5ynwRx0OEnjcT+3VbxoHzoFEc4p7VEMZJ6cQM3j0I52tQjDq
 zT4giYpXGQ1aUSzmVYyEG01CWP9yU1A0hjZVs2Obo4qGYrqpupWcTAwgySdzmR02ggaO
 NwaI6JPmAA1/tlvC4U+yPErxBzjVtoMMDjjPny1e0qgxtxlF6QDrX5DgcyrKXVwieWA6
 5uBmdq90q/VrB1TCR3is/+Np6uDVYSx5w2V2LYaQ1uX8m1IOJPWRb5+/8VQ4MAw6S4yP
 vcfg==
X-Gm-Message-State: AOJu0Yz5JlPYZoj9tvlAa+3VcAXtldM2tVxEA1xYuyFzTuTB+N78Y2lY
 TuCKpE0p5t1HaV82NIE5Rg6ujfXol5U5Jx+ub9fO0No5WTtD0mHAHx/vb/SWQfHosaLjnZeEosg
 g
X-Google-Smtp-Source: AGHT+IFpIijWY+PUc/yHpz4z5tNsUHxYrQfxqLb7FL3jaqDvwFL8qztr3Ux6MLgSbOc3lXv611SUuw==
X-Received: by 2002:a05:6000:b0f:b0:343:9af4:7a90 with SMTP id
 dj15-20020a0560000b0f00b003439af47a90mr6169536wrb.69.1712589828517; 
 Mon, 08 Apr 2024 08:23:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0041496734318sm17298667wmb.24.2024.04.08.08.23.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:23:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] target/arm: Use correct SecuritySpace for AArch64 AT ops
 at EL3
Date: Mon,  8 Apr 2024 16:23:46 +0100
Message-Id: <20240408152346.3937318-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408152346.3937318-1-peter.maydell@linaro.org>
References: <20240408152346.3937318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

When we do an AT address translation operation, the page table walk
is supposed to be performed in the context of the EL we're doing the
walk for, so for instance an AT S1E2R walk is done for EL2.  In the
pseudocode an EL is passed to AArch64.AT(), which calls
SecurityStateAtEL() to find the security state that we should be
doing the walk with.

In ats_write64() we get this wrong, instead using the current
security space always.  This is fine for AT operations performed from
EL1 and EL2, because there the current security state and the
security state for the lower EL are the same.  But for AT operations
performed from EL3, the current security state is always either
Secure or Root, whereas we want to use the security state defined by
SCR_EL3.{NS,NSE} for the walk. This affects not just guests using
FEAT_RME but also ones where EL3 is Secure state and the EL3 code
is trying to do an AT for a NonSecure EL2 or EL1.

Use arm_security_space_below_el3() to get the SecuritySpace to
pass to do_ats_write() for all AT operations except the
AT S1E3* operations.

Cc: qemu-stable@nongnu.org
Fixes: e1ee56ec2383 ("target/arm: Pass security space rather than flag for AT instructions")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2250
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240405180232.3570066-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 13ad90cac1e..a620481d7cf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3879,6 +3879,8 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMMMUIdx mmu_idx;
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
+    bool for_el3 = false;
+    ARMSecuritySpace ss;
 
     switch (ri->opc2 & 6) {
     case 0:
@@ -3896,6 +3898,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             break;
         case 6: /* AT S1E3R, AT S1E3W */
             mmu_idx = ARMMMUIdx_E3;
+            for_el3 = true;
             break;
         default:
             g_assert_not_reached();
@@ -3914,8 +3917,8 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         g_assert_not_reached();
     }
 
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type,
-                                       mmu_idx, arm_security_space(env));
+    ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
+    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
 #else
     /* Handled by hardware accelerator. */
     g_assert_not_reached();
-- 
2.34.1


