Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23E0CFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTIu-0007ST-7k; Wed, 07 Jan 2026 08:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIq-0006xf-6h
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:10:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIo-0000cK-Fx
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:10:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477770019e4so17117035e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791416; x=1768396216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdCBdTAgg5DNMG8MNY7cl9gDDtL9mKyheHp1iT2HUIQ=;
 b=DaLWCFEs2Ce3yW9SdwAshGSxr3dx+k4y15pMQXvIY+K787jlTSGjG+Sk5stKQM7jne
 L1k9I/919wL3qJidgPwNRG69a5vNN7JOVGSVeSM711hBt9YJCUjeRCDgbCAQSKED6rFk
 4TTLZfWZRix+c1XG5dxvsEuIJB7TdTrMfqFGBb0uCB0/wxqnmMZr9ibR6ev8PSmD/jf3
 q5ndw2bLMVkz9MMnfDF21zSR2uA1RH8sqZ5R+4ezTqWgEhRxbRBtBbW4hm9N7gcSi88K
 zlSEdAt03cm9mQKKqeHyueMJM8wRBUwxKMo1ANkaAwZ5oL66tn8x5hD15Hy8hHl088cE
 oSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791416; x=1768396216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XdCBdTAgg5DNMG8MNY7cl9gDDtL9mKyheHp1iT2HUIQ=;
 b=qAbgQHUBstsA10bSYPk09AUX8AFs+5vvO/7K36HDBGXZ/4bjs9jJfNerZNgss67Ll5
 Cn+Vo3kDMPZUzjGsQ8LCS7cBqIYQhGgh/ABRkImH3GgitpZCN/2gAIhYQ+9p93TyrwFq
 5/eA0U+SAoiF9VKAr5GghD2ElEUCj38hvxcHJ1xcmsiwZjTsxPzi72Fg7+hTHi8x4Hyc
 CcmYZ0mkAHbm1cgYWuyoxFpMTJB0tRl4AQIryH6e4uoeiAvZU8x579APRvNSCgNOcM3y
 9o/08Z79NOL1CPz31OIraRap2hKyIdzDhzgVH3ZIIt9Hs4Jj9/1vPWJwloB+LfVGNjrl
 2q5w==
X-Gm-Message-State: AOJu0Ywkc6Y8WEzF+j5nHMVgs6zWQVpcooPVHlRTnlLfIdoxTM1+SaC6
 Zt/K2tcv2gQTOJg8TfM/mVQJSFOIuy8VeBaxycR//zpfUpRb0UueKHSN2IcE6yueUbUenoy7WfJ
 KbFulN5w=
X-Gm-Gg: AY/fxX7msfKG7fYYPzETMLYNo8yc5x5ZBdkXZSkmmZsOg3dPtOAJojEMoaRcMqTfLmB
 AsyrcaBu1NRbZE9q83StALfn/wgd6eldqqBArl6ifqY+j07zqXBMauqHw0/AOnFUSqt9mPjiyye
 KZdAvG09z2pF6u01FVcrMbq36dlukDA9Tts8ttJsUCm3qU7mgBvSgvKxTnm5TM4JRKEYXTlzZnN
 q5EEgFsFOXW9vhbI9OI6ahQncOaJx/KPVubWuJ1+YddXUBhwY/eXn8n5+T0GEB1rFK5AxUFNHLC
 uaFsSpU+I0GjIBjG66lDOWY1IDG+SEDV7NgWlUcBvx/5teGeQugyKgJWC/kGwHQ+OvFO7EdT4k/
 qKvnJGFjoYnJ3DEc1sRK7m33agHbkyhoYV7XYMpzY1kKLiC7WR1ONyGVtvCrruTWAfAVSwPHFyD
 2qfX4DKT3G5JA5jm+7hInzBcmm3n+Rpf7k8soRmjeD0+j36ID5f5x3ktUiou++
X-Google-Smtp-Source: AGHT+IFINcdsWJy/iBL9SR6imcHhiYgG6eS8dARCCXARFt9bN3YTD4pRZjEbk9Vic9xCKqZqEw0kbg==
X-Received: by 2002:a05:600c:4e8a:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-47d84b170famr31607375e9.10.1767791416252; 
 Wed, 07 Jan 2026 05:10:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm95026885e9.8.2026.01.07.05.10.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:10:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 18/18] target/s390x: Build system units in common source set
Date: Wed,  7 Jan 2026 14:08:06 +0100
Message-ID: <20260107130807.69870-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

For the qemu-system-s390x binary, this doesn't reduce the
number of built objects, but this ensure the files in the
meson source set won't get access to target_ulong and
TARGET_PAGE_SIZE definitions, thus forcing to use the
correct types instead (such vaddr, hwaddr, uint64_t, ...).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/meson.build     | 5 ++++-
 target/s390x/tcg/meson.build | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 3b34ae034cb..626a8e18f82 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -19,7 +19,9 @@ gen_features_h = custom_target('gen-features.h',
 s390x_ss.add(gen_features_h)
 
 s390x_system_ss = ss.source_set()
-s390x_system_ss.add(files(
+
+s390x_common_system_ss = ss.source_set()
+s390x_common_system_ss.add(files(
   'helper.c',
   'arch_dump.c',
   'diag.c',
@@ -41,4 +43,5 @@ subdir('kvm')
 
 target_arch += {'s390x': s390x_ss}
 target_system_arch += {'s390x': s390x_system_ss}
+target_common_system_arch += {'s390x': s390x_common_system_ss}
 target_user_arch += {'s390x': s390x_user_ss}
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 515cb8b473d..17c9374d09e 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -12,6 +12,6 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-s390x_system_ss.add(when: 'CONFIG_TCG', if_true: files(
+s390x_common_system_ss.add(when: 'CONFIG_TCG', if_true: files(
   'debug.c',
 ))
-- 
2.52.0


