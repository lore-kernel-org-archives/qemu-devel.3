Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D555D6100A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQJF-0002Tb-GX; Thu, 29 Jan 2026 06:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIm-0002CZ-IP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:12 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIg-0007kn-Op
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso8717775e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769686497; x=1770291297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jC9qLuc2CCbEtH481L2TMiLEHw029Qtt0ng0mG6BJ2o=;
 b=r4S6GX22YLF6KxJAKIRiilr9/pYSA4S6WsfPyxaSThdACHYqjOGOxcFKDQoSnbjrP5
 5ikzmIPUlvM9xN5fJWxOtYh5mdEI6CPseGv7nlcXp2mvl2QrFsaQlMcvlhATihC+IBl4
 0MqrKIHr8mbo7BHYANpTar3SIg361pzwV1+yyNbagY7br2Usz6NdslIQeWED4T5eO41u
 3ISXxRdjatZr9FfOaIi98RVYuFcFMpLlSqqs5ovNb6E58uYEFy+aA+gPnYL2z1Gc1nuS
 oj4MTL8g5/Dak45fsHos30Jsmhl7OWW6Mv37qrloMTIDn7qaHrOZhUHV4kPzKe4rR0eM
 r9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686497; x=1770291297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jC9qLuc2CCbEtH481L2TMiLEHw029Qtt0ng0mG6BJ2o=;
 b=VoqVr1ZvH7njCmaOXDvVut+7mIdZJi2Vgsv+Ps+EO1wQIvAX/vYl6uY3JSDe338kQ1
 /gaissLRwu2A06FYJZ+B1qiLF0ProBw766xw4sDlZ8+rYZ2TrAJW978dVKpXJ+xiikGL
 596IIuWO8LeQ8NRgqDYCB0QdSC5PLsjG2qdbhAeRg331Xc9QKuB6Y8RbjZA3G3NTjLrm
 /0Z0UqInEzTN78q8c9MvW6IIPBz2Wy7BsIdFkjo9dZl/5IQ4YF/u2a9l18wyH/RqBDf2
 IABWrgkOdlKxjnTPIvl4S/buW6MaN488rJsLVkqNotFqawN55X8yeVsh8ZJ7PDqDu5gW
 xSgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy/SC1CvI6y6wtdErGwzau7KgsnjEgOHSeM2HT/wbFJmoLLKmLte4P9pFhcRsSMsZ4zAgJetj8QOcr@nongnu.org
X-Gm-Message-State: AOJu0YwZoWvr09nCbaSEfvWhERpGXaeMpGhlm8WllW6MlFO/K7CoClda
 hJyaqM+iQyvNg3wwrbjOixnasnqxfGCw6InusIVyWTln3ylXQh8X7SqBW65n1fpccBI=
X-Gm-Gg: AZuq6aKTE73LV9w5R7XNjEBBBsi2fjNZ7ItUUsAdSQBnvn86pYTD1ZCytcUt/GGwaQe
 jz4DAxKXsyPn/KudhaLOF1fJi2Vx43IIlXb8aFFokYMArBgDICtvfVgzOwxRRlMa5apzyNix8BR
 3QtpJgx0NyvkJaVrICGfAWbX5JUVASTcwCk2G+YCh58E2ZkmMFD02xC2Obm96zusZluoRJnCWNc
 Xr0zC9RQLrLUQ9O7xYER+YtHW0SRwbZ6rDQGn5tu575TDUhJgGoC2Ft79swEW1grU4bSnOtdHp0
 79Ud/sgHtm2ODCkyIB7zfkTz5CC+e+dWgIWpV2k2CLDcH6lOwQdLYYZgKnRQDkuqcotW0cWwcmg
 WNeEh5q4ljkK8YRqGI/V9VaOpZbMwWasr9mAiE8G2g94DvvvJWaPFGckRhUXJhwmkt544Lg+I5R
 RKyY1Lxvw9SLKNewqVOglnhO0WEBuKUrOjM6K57I6a
X-Received: by 2002:a05:600c:4746:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-48069c5547amr112824575e9.30.1769686497361; 
 Thu, 29 Jan 2026 03:34:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm196311075e9.14.2026.01.29.03.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:34:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 0/6] target/arm: Allow SME-only TCG CPUs
Date: Thu, 29 Jan 2026 11:34:49 +0000
Message-ID: <20260129113455.1283266-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These patches add support to TCG for a CPU with SME but not SVE.  We
originally prevented users from doing that in the run-up to a
release, in commit f7767ca30179 ("target/arm: Disable SME if SVE is
disabled") by forcing SME to off if SVE wasn't implemented.  This was
a simple way to avoid users hitting an assertion failure.

Changes since v1:
 * reorder patches to put the ones that affect SME+SVE
   CPUs and are worth backporting to stable first
 * change approach to fixing the smcr_write() assertion
 * fix a non-SME-aware assert in aarch64_sve_narrow_vq()
 * correct a bug in how we report the vector registers in
   the gdbstub: this fixes the problem where gdb hit an
   internal error when we emulate SME-only CPU
 * squash FEAT_SME_FA64 on SME-only CPUs

This has still not really had a great deal of testing, but
I think it's now good enough to remove the RFC tag.

thanks
-- PMM

Peter Maydell (6):
  target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
  target/arm: Report correct vector width in gdbstub when SME present
  target/arm: Handle SME-only CPUs in sve_vqm1_for_el_sm()
  target/arm: Handle SME-without-SVE on change of EL
  target/arm: Squash FEAT_SME_FA64 if FEAT_SVE is not present
  target/arm: Permit configurations with SME but not SVE

 docs/system/arm/cpu-features.rst | 10 ++++++++--
 target/arm/cpu.c                 | 10 ----------
 target/arm/cpu64.c               |  5 +++++
 target/arm/gdbstub64.c           | 12 ++++++------
 target/arm/helper.c              | 14 ++++++++++----
 target/arm/internals.h           |  9 +++++++++
 6 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.43.0


