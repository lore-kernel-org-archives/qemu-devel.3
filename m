Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6C3C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEG7-0006rI-CP; Thu, 06 Mar 2025 11:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG4-0006oz-1C
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG1-0004c5-3j
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:39 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso6021925e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279175; x=1741883975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=drdpohR6Dj+KXd2wNLa0BIt2hP6cDbsQHnby3gMJcxE=;
 b=GyzJ/WOv8bJzxSkuKfLH+GxrynXPq+CYjXxiVCvrfz21ayLzUEeBu/rP2u4EF9+3fI
 j6cSUhc5ZRQJWcQvEZYVGmDBTK27TKE89h0jqHOTPaLXJcljQGmDmaxlVjkTb++CRUc8
 0TnOWBBGyFeIteegVVuJK2xAjJ4xzPSpQNzK+/bCRfjsKkaWLwE/jQ0imm1bYnXQqtRH
 w2znJ7ylOrvf38zwvgvmES/X/iBw9mPoFR3+7qBmSEErpWbTzsdr/fAx5bNfnYFfhcy6
 UA1+lENcN2nDk5BgxXGMcJrqNlWl7Sls/9ZLaJVDpGgz8m1YQ4CCFzrR3jzxjYj9Mmhc
 7A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279175; x=1741883975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drdpohR6Dj+KXd2wNLa0BIt2hP6cDbsQHnby3gMJcxE=;
 b=mQgwYG2K5gaQadc2LBLMCZI+6A/cSxg3Cvl0bBfDZO9TGyuqz/NtHv332p3nD/jbHm
 gCYyEx0zZhQtQYAJAA34GhH/aEd2y8Bu6unYHaTrym17E7wfab3e2JcDe/5QM9cRq6wU
 SYsVM8IrbpaFSSfwmVysiZdxPk8AFNAsOUuqeqPQuGKGIIU9KBradRxz9d33RvLbvB3n
 yzlmTDA9Lc7MRwcshCKguw7hn+v0mEXZAbIfyTP56yltSij6U4mOEB8nsbCxW+0SswrI
 QpG6uCf44yGYBz5HlKIO3Y6wWx//l3XdgIgYzTZxsDsqTRUJy6I1LLaXo1s/she9TNc1
 gn3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU41bt4FKAac4S3R9/4NgN/qfMnetUDyyK9xMga9v6EqjyeG24+ZVupt5hJ/7vvH1zBUL/tIbdRo/5u@nongnu.org
X-Gm-Message-State: AOJu0YxD2NhEkE7l0AsJaEhagH5cdgWzwGJNxjC0Ag3cfIy1TDWUQCvG
 +UJwgcPJ0kGvvsvlCVyQgsMuUd/5CvCCVf+DzH6k84Z/60iAGT4ozjHl4FFrbrWerkhOwn5J/eA
 s
X-Gm-Gg: ASbGncvKZv/yGkWthwsnfqhE7ar100Yk2tI0CHQE7ECAOh5d6UXQKS230/VgrhGCAlp
 6L0OYhZHzxy1Bls0dtJM43YPFD/w363TWlHMUnXxeT4NES/Jncm/zr5HYtGP21w1IZbY67eHh80
 dkl4ih4noO6EcGOpO5R7xS0F1uYq1OncLzuN4+34ERCId+ZpAK5mRUYKardjmGYjlaQSi2yodxZ
 zGKJT9HWbZ+2TR/qMbODlUHbiKBNbYwjfjiII7UNd25OvyssCiu3PRTm/ONviGhKaPD+O1Bq+34
 Bni+W6v/DAYDLZWzRg0YvPknPu8b91q4zBtskJfDYcHXkiMKJBk=
X-Google-Smtp-Source: AGHT+IFNN8F/4sELOsNc+0T3Px0KR+vrozTFstGGTSCZTMFbAxhKS3Gy/GEBZf/tmjTF/9oad+6zZA==
X-Received: by 2002:a05:600c:358e:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-43c5a60eab5mr1862695e9.14.1741279175508; 
 Thu, 06 Mar 2025 08:39:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/10] target/arm: Add cpu local variable to exception_return
 helper
Date: Thu,  6 Mar 2025 16:39:23 +0000
Message-ID: <20250306163925.2940297-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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


