Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E3EC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLo-00011Q-C7; Thu, 01 May 2025 17:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLj-0000xq-HZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:43 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLh-0001YU-K7
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:43 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3085f827538so1909457a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134500; x=1746739300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXwcdw9KH2AB3C2RsE6WjSiCvh4jeWGeibDuA8DDVDs=;
 b=jvopjJMImp2yERBUOFE3viwgzwx4ylQsz7ALjjnJlL7NB75QXOg+I20wcM2TWe6PSL
 ie1LPa+Y2/ueVIMvCniHN4D9nwIUL7krd6McBbzyvfA9yzWA2Ev0szl243qt9r3nl4c2
 vfjBO75mVPsOtV5BSKvm9oqlOcI1X4dznwKnAKGA+LMTA/4Xg36AvXNDcCgpTBnEOldN
 8MUWPT+AOkaCSabYR1ZGwyd2S+wdlXIlVcPGmqqQ7Tkt6iwm9YsP3W3Y62KiugCRDMnV
 WCF8SMEInDl08ORbq9fQoLW+LoDkTZBAMoZy2QtgCBbTt/px+JFUg1L4UZ0Gb3YOt/8f
 TCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134500; x=1746739300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXwcdw9KH2AB3C2RsE6WjSiCvh4jeWGeibDuA8DDVDs=;
 b=a3UlaP4MmY9W/49FEhJLpHTjU3xogfm/fnSVSmSkFmDY55w609kK038mBKN0Vt/U2v
 jTAJEo+IqotHMDVsfNprVLSv+iRQb/lPPWpzTOfnr8YRslqK0ox7ONFbZDHqWl0UsgLL
 gY7yczAOdDeu4jdjJszO0/1oxCreo0lEIe8Q7Vj8AWpfqRnX0MS3tv05GP/Jbjl4pYoF
 qLcOd4kY/CtVlPy5sT7zT3tr4LuUlAJeQqxxzPECqGscL9ZqhZHfcDolkaj7NjB1g3Sd
 GvqJime5koLtGJ3lUQcRYAnrsxTVAKAy4G4ORlxKTzN4iPqKGLNcDt9HotZOj+oHYqtn
 bFSA==
X-Gm-Message-State: AOJu0YyL6HSWG1/BObgbl61hTqcMZZ/tY4bOwosr4i0ODDNAswShqO7l
 g3J5caSoWvdTuHhOX3ITb/OAc/EGiT5WTZxMqnIwhuBzX9PH9TI+LrK9iqtQIFMhBwZgy81fEWx
 y
X-Gm-Gg: ASbGncsFIi2oaV+iTMxHpWJ2VlLGjFM3rUZTjUbPLSZTjNCSNyTU7mxjjCM3p6Mn7xE
 GdtTu4O7DD6FkRY7RO5AjLeDSm5ok+OLvJ9Fd92u//sXBHXpH7CLPjWF32x6z8Fk5hYiQGpvuGW
 lrRX4T5jvMwijTGK0iRovDCeuvguu12X1vxtXXzqM0AyTb764tnd4UOI2788Q6QRUwqqjYytiO2
 ZJrfAcahRxYJD57W1o1VYOWo4ksrlfgMaxE3AgeyBmwpNKvCwDZ6f18txqwa03VbcG3h1OuxDfQ
 uz6nojzQhykg0mr2gsZ9n9F6+p1upLtQsx8D+nokdvZzlNfEKfg82vyRfoqF82chvLBjupAmdE8
 =
X-Google-Smtp-Source: AGHT+IGXujHSgVEVHXowV4JIXG2C2kf6Mh6g31r8StoGlrDgbBb3f+AJOoocXatNo7dXLy9uxTF3pg==
X-Received: by 2002:a17:90b:2644:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-30a4e6adf1bmr753766a91.32.1746134499701; 
 Thu, 01 May 2025 14:21:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 30/59] target/arm: Unexport assert_hflags_rebuild_correctly
Date: Thu,  1 May 2025 14:20:44 -0700
Message-ID: <20250501212113.2961531-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

This function is no longer used outside of hflags.c.
We can remove the stub as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h  | 2 --
 target/arm/tcg-stubs.c  | 4 ----
 target/arm/tcg/hflags.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d3d84ffeb..382a4d1015 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1906,8 +1906,6 @@ static inline bool arm_fgt_active(CPUARMState *env, int el)
         (!arm_feature(env, ARM_FEATURE_EL3) || (env->cp15.scr_el3 & SCR_FGTEN));
 }
 
-void assert_hflags_rebuild_correctly(CPUARMState *env);
-
 /*
  * Although the ARM implementation of hardware assisted debugging
  * allows for different breakpoints per-core, the current GDB
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 93a15cad61..5e5166c049 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -21,10 +21,6 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
 {
     g_assert_not_reached();
 }
-/* Temporarily while cpu_get_tb_cpu_state() is still in common code */
-void assert_hflags_rebuild_correctly(CPUARMState *env)
-{
-}
 
 /* TLBI insns are only used by TCG, so we don't need to do anything for KVM */
 void define_tlb_insn_regs(ARMCPU *cpu)
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index e530f65ed7..5315264c28 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -499,7 +499,7 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
     env->hflags = rebuild_hflags_a64(env, el, fp_el, mmu_idx);
 }
 
-void assert_hflags_rebuild_correctly(CPUARMState *env)
+static void assert_hflags_rebuild_correctly(CPUARMState *env)
 {
 #ifdef CONFIG_DEBUG_TCG
     CPUARMTBFlags c = env->hflags;
-- 
2.43.0


