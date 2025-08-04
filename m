Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBB1C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0nM-0007Vz-UY; Mon, 04 Aug 2025 15:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06Z-0001Ey-CT
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:19 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06U-0001Cq-1l
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:15 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76b6422756fso5528628b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332808; x=1754937608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7GETELPD3VGF6/REM63Q115JGqnxMS395y7OJ9SbQ4=;
 b=JwnMMieW59FlGFww36sqIQEcQKZ0fr8odNSGx6ZRys5nf/fLksQ6t5H8aqlqpgRn6C
 twWDDH8qYNquWY1OywI35q3tDHUByUdhtx12sLETIZRFn0hIW2yhPD2Bi4vJCPOmOVuP
 Hp7ghOgj08biZpDLXghE7XMvFOE/HaZudh12kCgoKcrLI7y3moCt7FZX4rxHi+NZ7nYo
 NURoEnzRrlvEu78fhZW6Mu2+UnfnLmU6sMJIuxTel4fgYzKQYYH3BFqLFcsIEeV+VBff
 VWxdayrGmmoXkanjUhxoXw1+5V8hzuAHgYBmYPV4mwBaHCJcdTN5Zj9Ltr6SoV5+mwoh
 +tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332808; x=1754937608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7GETELPD3VGF6/REM63Q115JGqnxMS395y7OJ9SbQ4=;
 b=LIGFHIfYknKNVC9WOoOXColQeOg7MoH/hiUXYZ52EjBcCxckc+MtX/AjWCdaIPMplT
 dAsXb5EvLd6vsCqKtOWnB0s9JLjFW/OULz4OreT4ZSMgDvBymuyALyQb6KjuWe8F+lKm
 9R49Iwqrtxet/rPr343bwVrVZ+yOF1TXlPvbBXPaR4XnSC5x8Sjp6tM0CdHdE7ly6FYX
 c2h2jzDqDklSupWr/HX/BVGWSVlLOp5w9fWsfjArI2zz13DurOscbs+LzwyzGyMEjikE
 MLcxwmPLTx6KKBJz/I//5A+6MU6s9fegoOOA1meWhXVy7xnXwgJLDSdgQ4LKtogk6NXo
 60SA==
X-Gm-Message-State: AOJu0YycGeuInydiuh9PTBwPjZx51uzPXPhuRhVlN/vn3UH7jSl9bs5r
 WzP5H6pRc5+EfZwRA1nBRWscKXA7Dfr1Dh2foyIrLAzvtrKUHR9071mpIpTVmfdtNSu0hLBQ4sD
 UlmN6
X-Gm-Gg: ASbGncttzZQKRB6JrzO523qURdACLlWRHyO5poS/xdD+FKeoQET03lAjJdjMUDyB5mH
 vTMMCp5HpeEIpEWXPXvmLdhwaYgyY1OFwd5Xe0zaIfWA6fdUpOIy0KJ1hyuUO+wuyMLeLks4PaK
 mNEObDzQ3xsm5gz1robgZ84QqmBIjGuAX6oerH5OHhnEVyjzQ7mekCsBm1wimoh855mVTcdWNxR
 dgTbyrKga/VGR/PaEfOYI+Dne0NQqvK3O/btjM60DNkdXBIEXsNj6WYpTgklEIFDUucNgSWjSdU
 MgU8tj9S5P1yQEVtMKa+a0qqXElnMsBC63KapNBkiS8aeR98FkFx/rH1jrZa/PSUPdxJwKDvjNF
 hgfomwqIB6cKvqIRy2haZGw==
X-Google-Smtp-Source: AGHT+IF20A0xw6dr748L3hzgexzxzqaCgMjAnpW2xiqCBQju9RkBDpCPap/SDvrOCHY1D6gQnUjbvg==
X-Received: by 2002:a05:6a20:1583:b0:21f:bdd5:d71b with SMTP id
 adf61e73a8af0-23df9714e59mr15191169637.2.1754332808287; 
 Mon, 04 Aug 2025 11:40:08 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 12/12] semihosting/arm-compat-semi: compile once in system
 and per target for user mode
Date: Mon,  4 Aug 2025 11:39:50 -0700
Message-ID: <20250804183950.3147154-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


