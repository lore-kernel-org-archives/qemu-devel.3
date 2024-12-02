Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7A4D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Su-0006pd-76; Mon, 02 Dec 2024 08:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gc-0002Lg-0K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:16 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GR-0003Uf-LI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:09 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so4796428e87.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145289; x=1733750089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mmqERnKJTYNHU5Lv8qXJWCaRjH14PqNpgofF/931Yw=;
 b=iuKSdGLo3VJrEuzjp61CqULeyjxSFNo3t9kt8jMcSzdpvnDwrHeHiXT4sV1VtfbnLA
 B2YIq+reKf+ToL0DUypC5gTi9xge/FZCOK6/YNbX9IUXHlwM8R80PSmaG9uaBFh78JVD
 pY9ly6cGlLuJDLYHloBQ5F2i0E+Wnmz7rjU5PeAxejUarF3ZGnS5IRZ8v/idrd6fxkCJ
 nTjIDF/QLl32as+HLOeokbz8LoWG/ARmanQqp8XqHfsRN3kqEr3UEi7Irl9zVLzD6L80
 OGDOq4JYSyV3DXBd6iwyk+ygAx2Wf1D7+OGir43V5Ka5z2ra7BClUDTg6mDVA9mjsqg0
 lzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145289; x=1733750089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mmqERnKJTYNHU5Lv8qXJWCaRjH14PqNpgofF/931Yw=;
 b=iifiVnf5FRjIxZ+rvXZCF/4GTPVd9+6eNlG4xpg5SIbR5RkJ7IwNgirkAITnQDaY9N
 pomSMjwTqr+VXd6Vhoz85ZueUFYpmmOXAygNEKslzhiLQ/6PUKKlLHfAE/wpORYg172K
 njy088IbA+14RIStl7g1H7qg0RFdYT9fjLWA72OJNA3qYnPDGMu2e+4SlWmguiBJRafr
 +yluGzpNMzNRoftwtWd/bCnw5mEwPjHFu1FitIQYXIl71aqqt1WwPhCyMuWrfEMURJ1i
 bvY6QzTBecNKuKIbkCyA9U8RWovTx4NBGxbrHHvhRvns50GxJv639cv41MuBExPlR7vM
 hdeA==
X-Gm-Message-State: AOJu0YwqPEAxghi8P1JClXuVlkjYGN/GNyVaMBi9P/LyjpsjTrpI5uMz
 XP6oePNtaJtpGqcU9Jc4jVmHAK0kHVELIAND1BH5MVc+og64PFp4OumWjvT5U9M8m2c2Rt5AIsO
 C
X-Gm-Gg: ASbGncveM9nIvnI9cmbzLbsCTQtw/Yt9bLTLSY4r3uHpEet6PvczODASAoWxpDoxbp7
 vVkQ1x5zj4FCnNMQDO6lNwRQKih9lJrx7mey0JPuu2P2wi7XCuGuS8SI/icEh6rBrakVkA/I7/l
 +fqOmhuntNCfccn2F0asOhYO6W9nBUx/5fOHp8NvTMbf9auYxv1Kc0ez+NXJMiA78pZkHzMvG+I
 bzIQ9LszE0NOfxBLPRdqwA9ld3Ufj7OSpkB5MKpm7N3JEQM/tiLn28=
X-Google-Smtp-Source: AGHT+IHoNh9oBV49L/bH9Rnq+59oW7g+9/k/G/yiTTjNWH4zraotaaGroDgjZj+LGtjioc8WBOrUTw==
X-Received: by 2002:a05:6512:400f:b0:53d:a93c:649e with SMTP id
 2adb3069b0e04-53df0109024mr13214815e87.35.1733145287794; 
 Mon, 02 Dec 2024 05:14:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 42/54] target/m68k: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:35 +0000
Message-Id: <20241202131347.498124-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

Set the default NaN pattern explicitly for m68k.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/cpu.c              | 2 ++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 13b76e22488..9de8ce67078 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -105,6 +105,8 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
      * preceding paragraph for nonsignaling NaNs.
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
+    /* Default NaN: sign bit clear, all frac bits set */
+    set_float_default_nan_pattern(0b01111111, &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
     for (i = 0; i < 8; i++) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b5ec1944d15..ecb7a52ae7c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -136,7 +136,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint8_t dnan_pattern = status->default_nan_pattern;
 
     if (dnan_pattern == 0) {
-#if defined(TARGET_SPARC) || defined(TARGET_M68K)
+#if defined(TARGET_SPARC)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
 #elif defined(TARGET_HEXAGON)
-- 
2.34.1


