Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88387C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg8i-0001BQ-8A; Mon, 23 Jun 2025 08:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8d-0001AR-0I
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8X-0000Q1-0L
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so26533145e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681133; x=1751285933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBZvBlUJJ4ZZzRhwp1RRYC3txHSba+iTcUIOSqbdq4E=;
 b=c/w4tztCELL4Lzva7Ti4ye02bUzEJ97YCVdXFQ7AeWaiSV+LLq3Gtgmc3DyBXEaRmy
 NwoPt5TkNaCmON5HVP82Ys//LY38/o4ainKZmN/DlfKil7AUdDGWhaiXAVk4RAyFwwHn
 33VhbUvNAclne5IJroyVsW2IGVK7FQMUX+Bu/gyf95Z3c0lMR3w8NBDkYXOxhRFjcVT2
 XjQUupwp80cCzpuLIfXmZmfYtymU9jQaK4GrNieOiuUFc4uzDOLZja7nXH0i3hrrG+lJ
 wnKOusZ+T+6fTyGH+jLZVrV+8hycKu8K3Zf5fzMcUgFTycSy1ak5MuTzbPsVu/0r6x+Z
 lCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681133; x=1751285933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBZvBlUJJ4ZZzRhwp1RRYC3txHSba+iTcUIOSqbdq4E=;
 b=Et/EHcYGDRK9FhdhHo1SLmg6AW5Agf4zpGB+ibsZwZ8LJvNDjtL+ZGr4ZI5EOJRMTf
 qxO+PUmcjEvr8VE4QCua5cZV6o2wAlgUfjpgKoYiHMJbJf4OsBmEd4ek1k01xF1gPN3z
 HDVtluPBwjYtcLM475oFIvwVS1kAPsHOIQYwPrLnqPrYqrYhyCgv7qbWya6KExvYgH4i
 EFwjSJgB6PjGUI5ifGvOZmi8cRmbJPp32/YpTWsrsl6AtHGmcerI7M61NgRyZd6p5vJn
 tle+maw97u/lIXzwTIoE803Iv10L5VdXpSgWkrmniFOriN6HwS2uPw5iG2PuIPaAOGij
 m3tw==
X-Gm-Message-State: AOJu0Yx7Lho+AzHDN8UgH2+JcTJ1aC9JfoCsMiASxDGQHMOatx3Blkzn
 fexLHo6OIYlqx24paGe4wEXgW4DQmzo2HgHL9/nyxTJfsAzhBBImOsW3TIzPh8MzsXUknwxAKGx
 Uqv++
X-Gm-Gg: ASbGncuQ1nxWBOmjMmHQ6IefYw3fMw8ty3tu4AZYp+hfEHzimGZlXIj2/RxpPG7bT47
 RS8z1kW3+igfZX5hRwETx+6hkHNV8mfkQy8N1kFCQGyVA1URlq2eJA7X2iZD6EbyFH0l8vtzLHo
 8/RSXY0qKObY7MBWLjz539yvsPyd6M7n4Q8Q4vtcwW6T/pqtbtWR7BcZ0hr1O7FYn9uz+siXiLu
 BiZCDvLf9extnOnFhM8y8vyUp3TY+7LettuFf/kADuzeO9pwouVSj901e3yjonht1fLsRzosJYt
 3TnxzJoS+xbwZd6b7an9nBwZ88nZ521qusZFnElibeGKMDt1YmAFS09ChCUqu7vwO3v46MSRoNR
 +Y8dubTyi+loJsQILMFYgu4Cz4P5q8HgKhzHU
X-Google-Smtp-Source: AGHT+IFC7OEULrZU5qbGkE5mHTI4DDkyLTxB305hu8Ey7qsg+WC3Ig6FIv2n+cvmO2DD/y8MEEbwgA==
X-Received: by 2002:a05:600c:458b:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-453655c6142mr118583055e9.21.1750681133114; 
 Mon, 23 Jun 2025 05:18:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45377aebaddsm15398735e9.1.2025.06.23.05.18.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:18:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 01/26] target/arm: Remove arm_handle_psci_call() stub
Date: Mon, 23 Jun 2025 14:18:20 +0200
Message-ID: <20250623121845.7214-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since commit 0c1aaa66c24 ("target/arm: wrap psci call with
tcg_enabled") the arm_handle_psci_call() call is elided
when TCG is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3360de9150f..5ed25d33208 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -650,16 +650,12 @@ static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
     return false;
 }
-static inline void arm_handle_psci_call(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
 #else
 /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
+#endif
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
-#endif
 
 /**
  * arm_clear_exclusive: clear the exclusive monitor
-- 
2.49.0


