Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABEBC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeT-000853-SU; Thu, 15 Feb 2024 12:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeL-0007yu-74
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:54 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeG-0003xe-M9
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:51 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3394b892691so815028f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018546; x=1708623346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YREWR7Kx96bTWJZLqvLF8xpReMnA8ENSRS/qSjx7oF4=;
 b=yGXncg1EHlxMg3R5p0LyWlvygWkKySa83tYsK1dSiydEevJFhYC/EOMmgZIC63CXOg
 gBzwFK5qIIA3Ao1Tjp3qKECa8yBkWGpIvQMo1nHxW+xWZjkVgjPlZgeMTp5+WU9I4i0D
 D0/wQJvsS7VGELSgR4xcj5/lNsFz6XkzSrqoMZ9aWG2v+FUkdOhjVsUFg/aOBuGjMCOk
 3s8O+uva3EZYN3q6xKauO0L/fiU67xKBI8b41xVcJKMN2k0NcQPU7yC95T8mbqAiBCqP
 ePKa/Ym1w4zvnHkNII1jDrWq4A17L8pswKupK+5tm5E5HZtop/SKws1dci5JY4NO/2/P
 3tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018546; x=1708623346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YREWR7Kx96bTWJZLqvLF8xpReMnA8ENSRS/qSjx7oF4=;
 b=d/0XyRIATKR3ePzbexhgyTZXwUvFLYcR6xXFkAWphFOV/LSLQ6BTJEx9CAV2ZtPT0F
 6cnQNMhUT/ujRXqTbU1B0rEiGsRZ0eQMQ+CA14L46/D9aVHtn2FbBAalsIq5UCusR7gR
 6PoMuXZ1bCf9SgRBeWM3x8NTbGyz6BRP0zC4p5V5ZtKntKmIx8LfJOfv0ECkv+K4Elnj
 cUv4KQNsm6cmfjUkseqQ4Ino2svLNmnPHIsXF9BM8WI5qFKimJO/eiQ7NnfCZ/WE/QSx
 LJqZunxuupRKHx2fqfCEeLwxHauBCJxZgSsMQa5LNPZBtJGWy1GthGZFnhIjzLzDmtqF
 HFyA==
X-Gm-Message-State: AOJu0YwzCLOOsPyxenspWU3XmkhGez5DYgNCOuUR3jwObQnuG9KI4/mS
 XQrmD34Hebqv2FbR3vFKq+VJbUYIyTlmjC9kuyRGSSl5aMbOwMsjWkDs0hv1iDM/Aff4krTBiLC
 C
X-Google-Smtp-Source: AGHT+IFUZrnyzY9XSs1uXdIyQnXso/Q1lQxqG4vlozVj8Ea7aaOPCsr8gAoUaowRM61rfFpsmv0KXw==
X-Received: by 2002:a05:6000:d82:b0:33d:113a:4336 with SMTP id
 dv2-20020a0560000d8200b0033d113a4336mr1243352wrb.0.1708018546523; 
 Thu, 15 Feb 2024 09:35:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/35] target/arm: Don't get MDCR_EL2 in pmu_counter_enabled()
 before checking ARM_FEATURE_PMU
Date: Thu, 15 Feb 2024 17:35:19 +0000
Message-Id: <20240215173538.2430599-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It doesn't make sense to read the value of MDCR_EL2 on a non-A-profile
CPU, and in fact if you try to do it we will assert:

#6  0x00007ffff4b95e96 in __GI___assert_fail
    (assertion=0x5555565a8c70 "!arm_feature(env, ARM_FEATURE_M)", file=0x5555565a6e5c "../../target/arm/helper.c", line=12600, function=0x5555565a9560 <__PRETTY_FUNCTION__.0> "arm_security_space_below_el3") at ./assert/assert.c:101
#7  0x0000555555ebf412 in arm_security_space_below_el3 (env=0x555557bc8190) at ../../target/arm/helper.c:12600
#8  0x0000555555ea6f89 in arm_is_el2_enabled (env=0x555557bc8190) at ../../target/arm/cpu.h:2595
#9  0x0000555555ea942f in arm_mdcr_el2_eff (env=0x555557bc8190) at ../../target/arm/internals.h:1512

We might call pmu_counter_enabled() on an M-profile CPU (for example
from the migration pre/post hooks in machine.c); this should always
return false because these CPUs don't set ARM_FEATURE_PMU.

Avoid the assertion by not calling arm_mdcr_el2_eff() before we
have done the early return for "PMU not present".

This fixes an assertion failure if you try to do a loadvm or
savevm for an M-profile board.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2155
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240208153346.970021-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c1ff16f0d9..7c531ee9cff 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1187,13 +1187,21 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
     bool enabled, prohibited = false, filtered;
     bool secure = arm_is_secure(env);
     int el = arm_current_el(env);
-    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
-    uint8_t hpmn = mdcr_el2 & MDCR_HPMN;
+    uint64_t mdcr_el2;
+    uint8_t hpmn;
 
+    /*
+     * We might be called for M-profile cores where MDCR_EL2 doesn't
+     * exist and arm_mdcr_el2_eff() will assert, so this early-exit check
+     * must be before we read that value.
+     */
     if (!arm_feature(env, ARM_FEATURE_PMU)) {
         return false;
     }
 
+    mdcr_el2 = arm_mdcr_el2_eff(env);
+    hpmn = mdcr_el2 & MDCR_HPMN;
+
     if (!arm_feature(env, ARM_FEATURE_EL2) ||
             (counter < hpmn || counter == 31)) {
         e = env->cp15.c9_pmcr & PMCRE;
-- 
2.34.1


