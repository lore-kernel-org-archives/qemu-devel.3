Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E2BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutk6-0003Uo-Ss; Wed, 19 Mar 2025 09:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjw-0003LU-8z
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjt-000448-VN
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so33504605e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391944; x=1742996744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+uCNdGR7Q/g7PWEHJ64I2sH/b8RzXSLv7jzZO24+jg=;
 b=z81AiAA88CtFA/u66YLSXWl6B92M1iKMX4SswGvwyLXJgP1u3jgx8DbRnHDjhBGd5U
 dCmELXfPITs10wH3Bzn0W4wWZtCXHPbK86KJ91Z9sqwwKdHiuq3+HlPcnJcEiDa6oGdw
 RvDA61yOLCqq6Utk0Pup4+miwEv8XCqU6lhZFSm8WDtokXadHgPY7c9wDe1OXqBC07ek
 r2pP+5uRKlzXR5f8YoYc1C6sVT7JLxNRh/05JSAT5eLUnwzplHa/NTpbj5B1558y2gd0
 9i5pPD+y0Zwc4zAfSiA7ycG0uRc9rJxpaE5O/5G3CNJjBBY055iUZBfh4o9+iMUhSzjv
 fH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391944; x=1742996744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+uCNdGR7Q/g7PWEHJ64I2sH/b8RzXSLv7jzZO24+jg=;
 b=M8fBbCv4kMwVG/CpJzKZYjKwFBuOX0jDt/HBvhRpQHT8bws5gvRVqXm1dkUNIlE+lY
 lNO7+xRngbZHPGDdo5XFOr2lqKWe+yLUU49TLAbLQIeEOylbgcFIEAywmOU9WBFKKGeO
 8Q/X4kwOMYjR4KCkILhTERRlUXo3HUV9qDg6JxrP5cFnaa/jzgKkmmaNicXBq8vxx2ZF
 Puj35cGCMSGveF2v4I6nuSheHw2C/SxbV+eOPD4z6Vj16WMOrYoOYtelfLD8jz1GD30q
 ma4TF3R797lEi/EgbZ6P65CejNVQZZEI/fKvN/boSiaGb1kXFRmPbCii/hiXM3OhnCxj
 9yHg==
X-Gm-Message-State: AOJu0Yz28Vqp0JddVUestbtiMtUJYrVQxiscRjHDre/sRDCdvVFhPw2j
 5Bfz0qV7ELEqGDSoorKyu7GfAxryPQvo2ZCK9FuB4WAH17r3tMY7Pjf5tQ/C5sQ1S/7NVFSsAW7
 c
X-Gm-Gg: ASbGncsLVQxGCrG7Th8BGtr80wJQhkFDSFxdLtneL9et+wLmfYa9k7sZACQ4bliczfY
 W5Xq807BXFtAAmpIyCnB51UwLYTZ+HmnkQ4+85J5OrdY3seomZh3Y7oTULz9NWUFVBnPJpJ4m4x
 GTdQmX9hQ+bPLs9ledobfRnuHVwyQCG8Sc46R5u7Q19UtZoY/AScBpld03a8zewnuKMPFPwKxC4
 ijxBT8nsDUfNDDsNVy3Rbd1mfuBtuFAlJdguu9pkROoaa96C7tJTTyitTgqdd8fTuQTpE8JKbs4
 c9KIdMYsxwAzCWtaVRLow5C5ucwkFgJAOBdZ2A0+1GouvLhYQnHnRVeAx2Lou2g+M5Us2CJd4lr
 Ww+Mf2fHJG51BcJBEoMM=
X-Google-Smtp-Source: AGHT+IEUDgLuxAEOS+0wGmUt/nIU3D649ewu1fNMP5VEU8XW0l44zGJNiSkd2Dcbl/H9dUZM0Y/9Dg==
X-Received: by 2002:a05:600c:3d17:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-43d4378617dmr26394205e9.2.1742391944101; 
 Wed, 19 Mar 2025 06:45:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43ed6sm19274365e9.13.2025.03.19.06.45.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 07/12] tcg: Check TARGET_INSN_START_EXTRA_WORDS range
 at runtime
Date: Wed, 19 Mar 2025 14:45:01 +0100
Message-ID: <20250319134507.45045-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Define TARGET_INSN_START_WORDS_MAX and use it to check
TARGET_INSN_START_EXTRA_WORDS at runtime in tb_gen_code().

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op.h      | 4 +---
 include/tcg/tcg.h         | 2 ++
 accel/tcg/translate-all.c | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 1f0d3b95304..0915043adf8 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -41,7 +41,7 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
 }
-#elif TARGET_INSN_START_EXTRA_WORDS == 2
+#elif TARGET_INSN_START_EXTRA_WORDS >= 2
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
 {
     unsigned insn_start_words = tcg_ctx->insn_start_words;
@@ -52,8 +52,6 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, a2);
 }
-#else
-#error Unhandled TARGET_INSN_START_EXTRA_WORDS value
 #endif
 
 #if TARGET_LONG_BITS == 32
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 84d99508b65..92a23e10218 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -577,6 +577,8 @@ static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
     return (TCGv_vec)temp_tcgv_i32(t);
 }
 
+#define TARGET_INSN_START_WORDS_MAX 3
+
 static inline TCGArg tcg_get_insn_param(TCGOp *op, int arg)
 {
     return op->args[arg];
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 54bba995a04..5e2a89dc474 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -66,6 +66,7 @@
 #include "internal-target.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
+#include "tcg/tcg-op.h"
 
 TBContext tb_ctx;
 
@@ -351,6 +352,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
+    tcg_debug_assert(tcg_ctx->insn_start_words <= TARGET_INSN_START_WORDS_MAX);
 #ifdef TCG_GUEST_DEFAULT_MO
     tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
 #else
-- 
2.47.1


