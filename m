Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDB9C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x052J-0002rC-47; Fri, 28 Aug 2026 18:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052I-0002q4-4y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052F-0002KP-2d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so15870715ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956009; x=1788560809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c3prOMqPHLIQmXgwFNllZn8rehgch0RbINfq/i5tMyY=;
 b=KvQLtlO5usCcGXAas8GbRqL776w9litSjoSPeCXf9scYI03MOSPgbkIuSgcuMizx3r
 Df99Qq0/75nt6XKmR/xirGYfptnlBNYIWa8zt838ZccK8IvS+/V4K0WbkYuJVozbSMEl
 ucvsIsOARcdpmBp9vZ7oLrUDzDRMnnvEE1NJwaQjNlyLcBq7ozqXchWyaJ/Q/1bIiTrU
 CsxAz6+05mZyDg1WpBkEJ1x8KU5MuypdnO+hbv3kBDQJzzp0JJvPzxjaQxPDXOry6za6
 +tOghy7ltluZ7DUibDIKNgjKPSJ70ZCKakHqB3tCyoUvMn2ohCAulTRc6m9+BZn2CXJI
 MenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956009; x=1788560809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c3prOMqPHLIQmXgwFNllZn8rehgch0RbINfq/i5tMyY=;
 b=DGnaYchliA2YaQRyDvlviNuH+MLhjM239rk457L7DhK7qEfKlx/vzUoGjNkfLC0LYN
 k3FmjT7fNhUa/tONMkaOpT4sWeDA0cESXQhE8H7e8zMOdb3VlDLUBu60nTc+56oK3gXv
 qMz8Hc10gTrqS/LZIaS0bTWtB6gGtOEkvWb6xeOjRcPtfUc+uQ65rMaQzrZonyWCv41Z
 hnG9lXXgOTuxOfzarOuX7AuI6VhkJAaOs93A5hwnXfv+cL0Efw0VAoPL1AlOliKYYATS
 AKl1YW+YpyaaHMQwc0sC7ew5hPx5r/dep5RdiZfgrwQb/K5ey73hG6pBAuRc5jPBD2mP
 GicA==
X-Gm-Message-State: AFuF++lFQPg55vTR49iXHmRUIs6Lat1ZU069tbkVr9SBpQSpalW8UiWo
 uAEmfcVczXFAda7Ox5F+x/jZ32NeoQoN0yBinfSs0Z5QyP2QqVxhxJSbTqRAy+2OChKJF5+fa0W
 c6uPpVDc=
X-Gm-Gg: AYBFou0Ec2Bw1apefM2K9YBYgEDM8xf8dux2hyPoyzpot7KDYa3xPpHkLt2TsA0yHwW
 svqd8hfGzlnXOmVAQWFkoYsdEGNXHvE+wopojqHfEN1JfjvXf+kr7yCcia8cPAr3JNOhfZYvFwC
 giqD0Yf950HrTCeks+YGDKrYfHRjleX2ZY2AWvh0gex6nUCWOnSFJdxrlULN9vsNEoorzOwjHGj
 2NptbPj1SxLlIJQV4rG69CQ7tu58ELkF4ubXhCe2J1LQ5AhNKtFMmBLCDM0hQnlFETdHUTfpgVT
 SzL1Xsd9jRkbobhYHg4nXo8B4+4mKy5yRljgc5XFaaYL7Dv+yh0abnVikJqUx23jok7iOdyfjwN
 4cZuQdqPcEa/y+z0mqWilM6/0T6oVnfsdoyaAuYDj1JdN6BDGqJqUXoW/r/WZqMg24cAjVm1lzC
 rEv6WS8Z0S6rvW5tRRp9ZW4YRO+DJJP/dfz8XcqX0e5UO7OXpWweV6Og+lF5NN2liBLZQX8Q+fd
 TJncg0XPrEmtS4LlRPK
X-Received: by 2002:a17:903:3504:b0:2cf:8aa7:7810 with SMTP id
 d9443c01a7336-2d8d4a0176fmr27776185ad.2.1787956008963; 
 Fri, 28 Aug 2026 15:26:48 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/13] target/arm: Read and write PSTATE.UINJ
Date: Fri, 28 Aug 2026 15:26:36 -0700
Message-ID: <20260828222639.1432046-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 +++
 target/arm/helper.c    | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 69c9256984a..eac1f7f379d 100644
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
index e6b16eade76..a4a7fa69ff1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9362,8 +9362,9 @@ uint64_t cpsr_read_for_spsr_elx(CPUARMState *env)
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
@@ -9372,6 +9373,14 @@ void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val)
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


