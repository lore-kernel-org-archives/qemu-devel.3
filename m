Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EEBC9832E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADox-0008PI-II; Fri, 25 Sep 2026 17:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoE-0007lr-N0
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:27 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoA-0007nA-5x
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:21 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-86b90133ae8so738062b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373016; x=1790977816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tQfq9b5gBx/LgSnqN5kSQmZ7qxJt+3ELV+MU7inlpJI=;
 b=xqQf/+m6nt9v1mUlD6mXbZm7SCObMH5SjuVT8UMwK7+RoPljnipZjs0Gk9sewEiYUj
 iQZkg16d6T/2SpQN5BhKQS/zXw1W47kPLDUgdvP4i+iBr24ZuFnhrtssO88vK4KTLpyF
 A+5TYPq6yEHZhFesoTgvxl2UHG2t+9zAJGAph0iqBMMqY7guZuw1ryB1U4vbHAI5/IIy
 SlKHE0i8Pqa/7Oq+wxAgHN72qTAVhvBsEjG7SN9+Kjad7Q9W14aPqW5qQzW6fXDvlF9x
 M8C1psVjCB2LMcRnDrgV0igSTfvjxCZX1gt4Q2CGnZVj8iCdjUn3+6ebboNWy0352Jx/
 G+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373016; x=1790977816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tQfq9b5gBx/LgSnqN5kSQmZ7qxJt+3ELV+MU7inlpJI=;
 b=sLiSmLcjr5tSVbZbRPVgRX1G/khPIy1aZPUqzIwgEt1INLDcgY2+ulVuJ0v4sCylca
 De8hzhHdfMuGwc0yxi4T9LLCxJcd4y/wYR2bhihkczXs49v+yiylh/GBeOFLrDoh2+cq
 ImQ2KH4UCzGjr0EHIW4cSDyWGlihJ9LFpTiMVJVkvbk3mq0JQIhvVvmXul2GndGxaSRH
 2IBOFCLhGUN6zlGlRfsq5o8/NJGX8hrWk3vC561X73zuOK1vc4rBMaV6+vDmxCwvndA9
 cYzErkb6NEYbB7dTLT7VkM7HFPHzregnOxcwcna363R+fXntEVs6UxqED7bnaFcVKWa4
 t/GQ==
X-Gm-Message-State: AFuF++mODO8s2yxp6rfHHnMAmuD8z7oyUoyfAot//HOO5kCtnwFr/JVe
 zP3W/s8ugJO/bAkBOWqiyRcIWV7fwwl13fk5szkWubiqRJ6+d0Hx/ufHdP1FQpTYSjYwljGjGt3
 5CwTF
X-Gm-Gg: AYBFou3/7yQMdT6PBTUgjAg3ncloDhR/gmoxuKTKYZ+1lEbpr2aWbvaR3CPQbpHgd4H
 NXeENeH3uSN5qK0yHdI2wBfq1P0XKEhRa02JouCGtgNaDMJ4M95giro1fg8PUDjHNBNq5i9PSqy
 bfyQcVzUxMjTHcjtb6+/NVucuA9FOv+z4PQ0pw2YqUkUZD+Q8qsEkIwzvh6/CZF5jNAoLo8MKM1
 aK0jLx/CbhaOBeb5lhZ6YvHvEGG4MWtDPkl8itBcFJiE4xyg7rtE0qgvA+c0HDTmKzLKJxz0aXF
 4q1Ee3TtBMwh/EsqvYSxPApTaSCXmlLt1PVQ010llTav+3kdtkLkHXxUxlKunqxmPOv2jjn1eoZ
 IhJY1e2GH6ImtW2NDnbF1AZOKQM80erEPzYzKbzDPAVZ9UyJ++zWElzgTfnJw9iG5M59p11j+nQ
 1g7AlRbpZz2WWowzQDOgu5fLSPm8wYdXeJx249rm/y9zmqJxI22YB8oBWE6n3h6zxVVdorBcd9L
 XvELFRE/CYUcvBUobzIBM40ZFgA8+zdfbatQ7wJ
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f63e with SMTP id
 d2e1a72fcca58-87e9b896643mr5303369b3a.32.1790373016444; 
 Fri, 25 Sep 2026 14:50:16 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 10/14] target/arm: Read and write PSTATE.UINJ
Date: Fri, 25 Sep 2026 14:50:00 -0700
Message-ID: <20260925215004.456336-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

With FEAT_UINJ, allow PSTATE.UINJ to be set from aa64 and aa32 modes.
Read the value back for SPSR_ELx from aa32 mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 +++
 target/arm/helper.c    | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 843e12487ec..c41fa5225c7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1392,6 +1392,9 @@ static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
     if (isar_feature_aa64_nmi(id)) {
         valid |= PSTATE_ALLINT;
     }
+    if (isar_feature_aa64_uinj(id)) {
+        valid |= PSTATE_UINJ;
+    }
 
     return valid;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2034f1d1f17..ee48442383c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9385,8 +9385,9 @@ uint64_t cpsr_read_for_spsr_elx(CPUARMState *env)
         ret &= ~CPSR_DIT;
         ret |= PSTATE_DIT;
     }
-    /* Merge PSTATE.SS into SPSR_ELx */
-    ret |= env->pstate & PSTATE_SS;
+
+    /* Merge PSTATE.{SS,UINJ} into SPSR_ELx */
+    ret |= env->pstate & (PSTATE_SS | PSTATE_UINJ);
 
     return ret;
 }
@@ -9395,6 +9396,14 @@ void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val)
 {
     uint32_t mask;
 
+    /* Save SPSR_ELx.UINJ into PSTATE. */
+    if (unlikely(val & PSTATE_UINJ)
+        && arm_feature(env, ARM_FEATURE_AARCH64)
+        && cpu_isar_feature(aa64_uinj, env_archcpu(env))) {
+        env->pstate |= PSTATE_UINJ;
+        val &= ~PSTATE_UINJ;
+    }
+
     /* Save SPSR_ELx.SS into PSTATE. */
     env->pstate = (env->pstate & ~PSTATE_SS) | (val & PSTATE_SS);
     val &= ~PSTATE_SS;
-- 
2.53.0


