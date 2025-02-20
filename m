Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECEFC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Ir-0006gr-Us; Thu, 20 Feb 2025 11:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iq-0006fq-0T
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Io-0008AE-Do
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:31 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439a2780b44so7529835e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068489; x=1740673289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j6+66/H4Jj2ErW/tNOhpsPJs241J28yxPfDTi7fj4YM=;
 b=mkO7jWMCb6HZbf8F3xtKxu2dziLbPIuK3s7v9dEJ6pqDzoKe7pMLKEUqKCARQQbyUm
 dip8wRPrLlgJ7nm8iTXiUJ408qdP5mHP5Rij/KMJJ7+TbIlGHl1p+0t1rI6LxUM5BCzC
 4yAf3izX0LbflG0twVP+BRA+D0buZLT/5O2o5ekVdcEfQS8z9GFtPDhrCpsCXOUplWl+
 LZ7ZJYRrbJmc0gV8RhKSFiRceuCHyFTJ57DssnEn7k17QwGYNxHKZbziH8ipmSCkjcuB
 NQGkLpmqz1wOehibxFFNSa8JmxJrLme9qqHCva0ER1IMu47A/MU/cxjHYh6RCvUAPW6a
 MXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068489; x=1740673289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6+66/H4Jj2ErW/tNOhpsPJs241J28yxPfDTi7fj4YM=;
 b=Ce66fpOAfeDL+4peL79/SBg2rRlVKkhm7KeqBAk4bPE/PJ4a33TwjWltIJtGOqwDuf
 i/Szdiluus9FkLNrbbRK1MOJPuRg/RvUyaJrMqhJ9Cn5EFmWMnYc7WxfhS3sym6xAVWA
 JGYGSY8TlIVmyT6Ycp7D+0tQoFmctjMQ/jUnc2PHHcoyroluvnRu879k5uKA2/KBRebb
 FwhSwwIJqIREjv4AxBr7e7x4AYCIAOlIlbSGjpMBLyjvU/JPlWnvt296fXbHaLg82BAc
 1uLHQVVK2S750QtGJI9gGdVIZZb1SNrW4/Q5sedjAtlzHALpTAoD+nkCVqToCzmtO4DK
 s0/g==
X-Gm-Message-State: AOJu0YzPh1aEhm70PQNVP4IvWmsiJvwW3wGroCN6G2vqTKCidWtb832J
 i77a07eTIQqKrF0Ln0ac0wWiCoSR+HrizQg7xq7UoF272SoV2qAZ20L1/43g0I7w8T8GSZ3cc/e
 2
X-Gm-Gg: ASbGncuWv9VOpRUxDgvLajBXA59RBsXBhvHD+FItcDJbtTL2pmJJMeVJrjmm/8On1Xi
 m+CNHZp6wEdczCFLm3Icp3OxqvLYMmNIKi01r00BU+Nex5MDZp+vTELrk9dd1hm35kZ8WO7bigQ
 0/bWTA8pRzo0x3zPkv9JILWV5zwhXs6c/iDgmXhG4c2Br1HPDjwzlOf6MIbmWltKuJ1KaNH4B9H
 IxFf8ubfq2Y8j/3NG5LdOgazQxDgN48NGJNibEkPkZ0V0BvS0OiISypRhSfohH+VjnbRjfO61rN
 wGyu+iJKHaGmQt8oloT2gA==
X-Google-Smtp-Source: AGHT+IGBb5RnYTADPvYABSw8QxiykrWAveOyZyUmuzOEMpore2pyIwJcm1M//ywlZByWzI2JhRQ5vw==
X-Received: by 2002:a05:600c:4f84:b0:439:94f8:fc68 with SMTP id
 5b1f17b1804b1-43999d16123mr91835715e9.0.1740068488987; 
 Thu, 20 Feb 2025 08:21:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] target/arm: Report correct syndrome for UNDEFINED S1E2
 AT ops at EL3
Date: Thu, 20 Feb 2025 16:20:44 +0000
Message-ID: <20250220162123.626941-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The pseudocode for AT S1E2R and AT S1E2W says that they should be
UNDEFINED if executed at EL3 when EL2 is not enabled. We were
incorrectly using CP_ACCESS_TRAP and reporting the wrong exception
syndrome as a result. Use CP_ACCESS_TRAP_UNCATEGORIZED.

Cc: qemu-stable@nongnu.org
Fixes: 2a47df953202e1 ("target-arm: Wire up AArch64 EL2 and EL3 address translation ops")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-4-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9ed1a67b767..f4af2d2de54 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3611,7 +3611,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     if (arm_current_el(env) == 3 &&
         !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return at_e012_access(env, ri, isread);
 }
-- 
2.43.0


