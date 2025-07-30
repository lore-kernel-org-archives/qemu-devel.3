Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0644C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhF0R-0002bx-1Q; Wed, 30 Jul 2025 18:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwe-0001iv-4u
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwY-0002em-VT
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2403ca0313aso3078885ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913197; x=1754517997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9Jt2nnjSdWUZl5mAbqo93xKPN/u158eZmI9MYg927A=;
 b=E8+AxWweCIMYOIuLSNdp4xT8Z6ka2mJ7ASyx+jZOpWAez2YUzeIznoJHUg7tw5QiSI
 PJgZ1GC8LOAW3Tnc70vVZ6Y2UXePPfNzjR8aneiUjw1S5+ZgzZpAEW3QeFEKbXkv4Hj1
 Gs1/X0izx0iMwkLasw7JLb4lY5mTp3pi2yY89O0VbgCkz794PEhWdK4zsJPyAKRTNJoV
 LswHkKeEhXujs1hOIYe585e+b/MrGfZuVZjJ6eWIXRbs10Sra8gjCFTWVLRIYZZp4RSI
 tPPb1+t4G96SiJ1Oz9i6qZAIIz+rwm+1WcQvhroQm3w4VUqIu1EJCPyXxa0+5uBu0zvt
 eGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913197; x=1754517997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9Jt2nnjSdWUZl5mAbqo93xKPN/u158eZmI9MYg927A=;
 b=V6iT6AmrKEntHTviTRv3jLEJBWvOFDFbDZ7CcVow071n5zbTHtnTw3689GQVeVzJjL
 pN/JosaglNUaUc19KyQMcSrrmov0UK8+dLZa4+CUmhhtXUs80NAsTlpRMSY1LqaXQ+mr
 y0Fu754o5mm7Tt92762jw5jsfmYxwWYyz2w9928lZVfmg1ljn8s4cMki65AkVzz0UXW4
 l1eL3CNhXTQY0u3BmfbwTC7EJHVOPfyd3XG9In64chL4Q7NZicMbEDb4fjSHWQkpSp3Y
 i17DtrpW2rcFeGTq3Rm7CLMAo/uJ8iY1pfmm8GpY2c0wi3hHvartHTSTnstWNjq7vrhm
 rHOg==
X-Gm-Message-State: AOJu0YwtK1BANkNUZv8H9sht2VBn/4ZJX8GNfs4qKh2/OgjhZNVLRng1
 L36Ql1gF90y5GHHtzYC0lm0ZL+Zvn2LpFBh/13l4hoJqCIy987ZFaGUXi6jvSNN44tiwU4eqQLX
 r5JgO
X-Gm-Gg: ASbGnct4Xuo/dpw+ELJYqNX5mACBO3uN9CYgdU+F+fyNimKhCaa4l7QlNbCG+Cjp1mA
 lmjpVsDZKsD2eBS4Iosvgofq8oQ5cyRumqVyYqximItTMMzNdeba5+TWGGHKceXCqJIwANbSl8j
 I4DAZYOByZy+afuSZjA7pTIPYnKSpLVELMrNHjE4y3NH7Ags1Wl54iL7zNd+6Gu7T/AXuFGJxRN
 jXTBBGLzTT7WNEj1S6VM/YxrqAt17fN+dhoH2+nxJMMp1K+7bNqC4YhPOwqVnPk/LSsyNe+zSPB
 NrAg4LYwpkDpUOIPK3eSjJLqeG/4TgGO+vQNXsP7qtQygg+hxcgA/TVJ10nXPgO7V/MTX7T0DUL
 Oja1cz4gUQmW8hqdFn/usXjVEs04Hw/+Y
X-Google-Smtp-Source: AGHT+IGDX57VB0I9QpChqVGeyhjh+hRxgaejT8za47l/v+1e6x5YM+ZvCahPZ3jmijncowPJN4d5SQ==
X-Received: by 2002:a17:902:ea10:b0:234:d778:13fa with SMTP id
 d9443c01a7336-24096b2364dmr64741585ad.26.1753913197120; 
 Wed, 30 Jul 2025 15:06:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d272sm981535ad.135.2025.07.30.15.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:06:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/10] semihosting/arm-compat-semi: compile once in system and
 per target for user mode
Date: Wed, 30 Jul 2025 15:06:21 -0700
Message-ID: <20250730220621.1142496-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

We don't have any target dependency left in system mode, so we can
compile once.

User mode depends on qemu.h, which is duplicated between linux and bsd,
so we can't easily compile it once.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index bb0db323937..99f10e2e2bb 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -12,9 +12,10 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+  if_true: files('arm-compat-semi.c'),
   if_false: files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
+specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING', 'CONFIG_USER_ONLY'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.47.2


