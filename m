Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E589AD6100B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQJ7-0002Ne-9c; Thu, 29 Jan 2026 06:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIn-0002Ce-RP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIf-0007kv-Hv
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so6667615e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769686498; x=1770291298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WqMWGMMgAwpDdsjGebmVf+TWll8M5Sqgy4tjAwHbyk=;
 b=yqs5LXo0uCtlngDu9IpMBsf8Rq1FbLwPv9cFJUXD4zWrZ9aNitNcxP/2L3NAo2On06
 xOEy39nHO4hAhB0ug+0ES5QO5WY5CEM6QdEMoL4vBnEGWZu1+ADKSxRoQsrICu+DemVW
 4kfBJDe4vLkmbl85Np46gpv1NEMmjsYN01ac97p57p2ElXxlvfBqy2U8zyoRwwFH370O
 jaJc7F27V1w5yP8Dmbvyu+1GdxX7Q4f7X/lRJ4kCgHxo/QTWv8sNu8bp/SCg6MrMx/bc
 K6vxT69OXgnYbJs+OsQSnAoA+9uTCQqxu6E7M3mqeMk4WH9foXyyVlrXgWX+iHrTfLM+
 V+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686498; x=1770291298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8WqMWGMMgAwpDdsjGebmVf+TWll8M5Sqgy4tjAwHbyk=;
 b=KJCmBCNXbBbV5vK/tJb1KkPzEJlG5Z5K3qD1YT9Kh61Eoa8cYb5CGEy6HRx/+hNWuI
 3iYprJCtQm7le1ZztfNx1s21WMQp+WNfNjFC8/yE6lcsaGj5nu8b9HoWmlvagf3/+wsz
 T19Y/LJuPUlsfES1e4h0F2NPU6o8YugYCwgXOhZRyrukEd3+iE5bvMbum8r59dhedOJV
 wgVktI00phEmtmZ3vKq9gGWQ5yKzo/4+Dw0yfB0CnNOig5SztMknrpmF78NuEQiuvmGD
 t0Jd8lL7rVwVQPO3QvWLLZYlbhUgYLS9DFfszEPM49Zdj53sCy9HvJ3gvfe0t3E2JE/m
 zhSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3L4A//3ywhz8RZWVyIL4QFX9I9E2xYtHAmjDbVLHCjeuD6RUFMy4orAKsSrW5naoQfZBv2Rl98FT4@nongnu.org
X-Gm-Message-State: AOJu0YxIfb/Y9YuJJaida9RSEXvM9T3rcu3QG/2ptk/C+r+Ne2jPTQGN
 RUfzv21IYdO4bIumaXSjNLZ/GgU3rn/ZlVZjl8aNbm5QyPKZUK1HBT2vkleinkW/mavjYHwlkaJ
 UPTNfIS4LZw==
X-Gm-Gg: AZuq6aJPNFccTIjyu2WZBUWUOKuYVEnjU0zDvM5zWgNWQqCcjFmjrO8HuqwOIGjDVdp
 H6TV2skPBU3E65O2H6tPnsQwbc0l+ZYPWpHZQoFNQBhDn7NLNWMINLGVQlzC4YAM13pKsTamdQL
 YYT2HGHTgyc5Z+kcwj2HP/8Nt9hEexX2tHOeEE0pOcUXWblvovGFpB0UZIInbjS9t8jMHcD8WTX
 mqp0pTPPiGhj9O7a00nK0J9wL1mOSkGWlymnaXjOZQu0eNOJrSIJURzpLobjPMkXDQxYSR9dQhF
 78cvKgrbS8QvlrFZ6S+rFfjvHeL56VNK3O6C3vhdm9sqPiiymsCNS0U8s1GfOHSXzl8BT6rIWok
 F+5jtioNQa7904IgJXb6jjhXC5O4CgRhut5Op6CclQzqI7iAWh006jlCpgj4Cs4d3Hrc36DKjiW
 7yaAiTSA+ndo1zXZ5to6NrYfk6aGcYpA==
X-Received: by 2002:a05:600c:1c1c:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-48069b9d651mr130760635e9.0.1769686498369; 
 Thu, 29 Jan 2026 03:34:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm196311075e9.14.2026.01.29.03.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:34:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 1/6] target/arm: Account for SME in aarch64_sve_narrow_vq()
 assertion
Date: Thu, 29 Jan 2026 11:34:50 +0000
Message-ID: <20260129113455.1283266-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129113455.1283266-1-peter.maydell@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

In aarch64_sve_narrow_vq() we assert that the new VQ is within
the maximum supported range for the CPU. We forgot to update
this to account for SME, which might have a different maximum.

Update the assert to permit any VQ which is valid for either
SVE or SME.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
CC stable on this one, because it might also be a problem for
a CPU with both SME and SVE but where the SVE max VL is less
than the SME max VL.
---
 target/arm/helper.c    | 2 +-
 target/arm/internals.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dce648b482..7ceab0b503 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10076,7 +10076,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
     uint64_t pmask;
 
     assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= env_archcpu(env)->sve_max_vq);
+    assert(vq <= arm_max_vq(env_archcpu(env)));
 
     /* Zap the high bits of the zregs.  */
     for (i = 0; i < 32; i++) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f7b641342a..8ec2750847 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1808,6 +1808,15 @@ static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
     ((1 << (1 - 1)) | (1 << (2 - 1)) |                  \
      (1 << (4 - 1)) | (1 << (8 - 1)) | (1 << (16 - 1)))
 
+/*
+ * Return the maximum SVE/SME VQ for this CPU. This defines
+ * the maximum possible size of the Zn vector registers.
+ */
+static inline int arm_max_vq(ARMCPU *cpu)
+{
+    return MAX(cpu->sve_max_vq, cpu->sme_max_vq);
+}
+
 /*
  * Return true if it is possible to take a fine-grained-trap to EL2.
  */
-- 
2.43.0


