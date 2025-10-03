Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F408ACCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHS-0001pJ-4h; Fri, 03 Oct 2025 13:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHK-0001l1-VM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGW-0006Fo-PA
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4ee87cc81eso2275858a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511292; x=1760116092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8jzmwbEOdXd1Y+zB9l972AjYHk0b/qSjoQoHCfbnn8=;
 b=bu9OG5LNSjnHxd1DmJKkmhXBF7X7iMY6IuF7iKByFiMduej+ivfIltwkMRR/4KiyIT
 RFm2sHW9TNYSctCfZHUG3IcEkr5ndyTbu/YIugRB3ILabtnKfXS34/9UkBzHyBnNgLxm
 TtIS8wmcBxvskDQasQptRTFP6+sw+zj/CtuuMYzMfu9KDHuS4LHmdBeMRxOfSHt06fkK
 KKG7i6frHII8hH12SJJk8J6P1BbHm53ZrWPDiBdYxVoJmVuwh2H959reFhPEbukvo+Bf
 R98cFQoEJnva+mhaxzM29KXm8YjbLr4eaPUDCcDgf3KfHQmR9hRgvUqsedBYR88xSNRI
 YScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511292; x=1760116092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8jzmwbEOdXd1Y+zB9l972AjYHk0b/qSjoQoHCfbnn8=;
 b=k9DoblIwEmHqPp0XhRR4LggB64lU5LJIGJ8qzjbqKjoC3pxHIrN6iiO3oMWsRHaguD
 BiIseVY/9rA9qvcaJRlyW12SluBEm2Dd9b2EoI7nRpwRjQK/A8oBAULaZ25TplTxoO+t
 OcrWxu7zHrAykwzgMaYJ46z/5JeDn/BrjMb8EkCoq8NrYChXYhWb9vXDR4b7V/f+7tT2
 Xz7UeUkBVOloJplmj1crc+NY9hxN4Tlo5s6smKFnklztM5/yL0QQlsMwmnwp0FiFpDW1
 9RYmESExoPJjRBI87DZp269o3vsL8iTtdV+RMH1/c6/kpBPoj1rnpT6/4Azq72lHVg5O
 feuA==
X-Gm-Message-State: AOJu0YwSGF8hJw2gjYXV2vjNifPeU+Apn/EB5zxItVyjB0BRKvEHlbdg
 ez6u3/5FJ2ZDiHHCC4g9Ao8UnDHu1A6GmG7kCe7u5c+3pfELpvDCsJtieE90nDuSOWcyLTX/UNM
 SOhOemog=
X-Gm-Gg: ASbGncuvrG1VCn9LuSZMQdlJGg6/tAI2OYrtCdevMIyGtT2QtOOK5jFrRPG3ItqiChj
 DJnjwotUaQ0X6ZxpMYkLUU1KQCzyuw1lMcJ708UayV9qYH8xIXw4+lmIS771iJ+81PimWXlOSmK
 MUivOst3RNHZ3PIZBC2lVPnmYvxPkE3EVU9D0gKzsasax6tq2PtLBdzdWF7RQWK3aQbgATdk7ti
 gJd9meIZ1EzpP/7dBPm9cKAcvYcNFUNKTjSa/qG/nBmAGKyoYRx3CwzkkhzJpsJ3mDdOFvxfL0i
 tfJq+UXnpy5nnBNqqNU+LstGxWaWhUhrPuL6Y7388NAB0piyL5ME8jFGG/ebyekXebo0HX5FvZs
 HiqG9DTERHNmUTR3yFIj/Grf2g751XH4mWBtOgFy1iBBVliEtt4v764E7J77IL1Fvsb4=
X-Google-Smtp-Source: AGHT+IFUbSL7h/dDpwA3Nx+JYto/xWnQxc9kUgy3u1MpGOdDSzaFETfMceu/QK8A81CMghafCl0NuA==
X-Received: by 2002:a17:903:3d07:b0:268:500:5ec7 with SMTP id
 d9443c01a7336-28e9a5b9441mr44641475ad.2.1759511291679; 
 Fri, 03 Oct 2025 10:08:11 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 11/73] target/arm: Expand syndrome parameter to
 raise_exception*
Date: Fri,  3 Oct 2025 10:06:58 -0700
Message-ID: <20251003170800.997167-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Prepare for raising exceptions with 64-bit syndromes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 6 +++---
 target/arm/tcg-stubs.c     | 2 +-
 target/arm/tcg/op_helper.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 22947c4b78..b59650959e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -304,14 +304,14 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
  * and never returns because we will longjump back up to the CPU main loop.
  */
 G_NORETURN void raise_exception(CPUARMState *env, uint32_t excp,
-                                uint32_t syndrome, uint32_t target_el);
+                                uint64_t syndrome, uint32_t target_el);
 
 /*
  * Similarly, but also use unwinding to restore cpu state.
  */
 G_NORETURN void raise_exception_ra(CPUARMState *env, uint32_t excp,
-                                      uint32_t syndrome, uint32_t target_el,
-                                      uintptr_t ra);
+                                   uint64_t syndrome, uint32_t target_el,
+                                   uintptr_t ra);
 
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aac99b2672..aeeede8066 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -16,7 +16,7 @@ void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
     g_assert_not_reached();
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     g_assert_not_reached();
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 5373e0e998..dd3700dc6f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -46,7 +46,7 @@ int exception_target_el(CPUARMState *env)
 }
 
 void raise_exception(CPUARMState *env, uint32_t excp,
-                     uint32_t syndrome, uint32_t target_el)
+                     uint64_t syndrome, uint32_t target_el)
 {
     CPUState *cs = env_cpu(env);
 
@@ -70,7 +70,7 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     cpu_loop_exit(cs);
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
-- 
2.43.0


