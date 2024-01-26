Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFB5C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUKa-0000nz-RF; Fri, 26 Jan 2024 17:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKF-00086c-3L
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:05:27 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKD-00045g-D7
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:05:26 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a2a17f3217aso126018766b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306723; x=1706911523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLJcVa0Wo/+9a3++1/N2vAccbtpACcy2YfF/nJ2X7yI=;
 b=jQJJKVLSKy8r4LiJN1/Mq/0JnTligGkOeNkUXIGJ/M0t3HUHwr4xIGzm1z83jOpGpA
 4yK1B8Ozk/9CRJyiDEMTZPsUPHJ78EaMOsqE4TDfsW+efgGskbgj4jqBbcOQdp2+MsNH
 SVmD/XwQuJIhZDgzMdAqcE04ljkR0kncCbDPss5BYD6tT+fQjEAGjJkkM5AnqXd2rQbr
 5wfJHoHMYf5Uy9c40HKssUyYxNv9MP+dA0MS+lBWhY2xfndWSXp2+GiK6Vcm8/6IQkuQ
 EZCvPIbGiLx35IlrfzSwueCelg2DpiNp1n5SS3ZN+9aK/7c50YnHQt3SMFeDHBzWE8Ta
 /Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306723; x=1706911523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLJcVa0Wo/+9a3++1/N2vAccbtpACcy2YfF/nJ2X7yI=;
 b=NWibqrWxygcbD69iY82zl0oVADHIADEmh7AvC1kvuUDKbER0ssx5nmcQJt7tMzYUJP
 IOgrGK0A46zbyxm1mf2ix5fRgHa19PBqRMEGRltCUg+0UWyDRTjP4UIfZ2E3TcWFhrDt
 Jle3jj2nBHMcvkKWz6ZK1EoiN2hP4kEoJg+t+hCimmehaYsDpVgtvVj8alGMgitGUra0
 woecrCyKRSGChgQqK5yizlJqoogpz25KDwcam6aRFieHJBJbNqHB3XtPu8hOyJGsM6Ga
 DnsKCxkIIUxpAojP2o2nNnaeH7w3JkJ0shWANOZN5MgRQXdFWYmEnXFZnOSpiXsZbqNe
 JfMg==
X-Gm-Message-State: AOJu0YzxEV7E0g0qMlUH6fZtfKBzRg3f4x/AzivIy1Nr2F1svfxMAaeF
 ynwlFpK8rOKQuOrHPjwuBlTgObM5sGg3P+cWyDInZHVQGstdv2YcfZzaKFpdk6qLJWBcC+xzeqt
 i
X-Google-Smtp-Source: AGHT+IHJ5scN1N+LgHfCxF25aRO27r0CuYmRbnWRaojOW0krzmjgy0JozVqr5YlJ8Os1eVjZ42JmZA==
X-Received: by 2002:a17:907:170e:b0:a30:86ec:44dd with SMTP id
 le14-20020a170907170e00b00a3086ec44ddmr379991ejc.67.1706306723230; 
 Fri, 26 Jan 2024 14:05:23 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a17090652cf00b00a2e81e4876dsm1047463ejn.44.2024.01.26.14.05.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:05:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 12/23] target/microblaze: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Date: Fri, 26 Jan 2024 23:03:54 +0100
Message-ID: <20240126220407.95022-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/helper.c    | 3 +--
 target/microblaze/translate.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 98bdb82de8..bf955dd425 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -253,8 +253,7 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 
 bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
 
     if ((interrupt_request & CPU_INTERRUPT_HARD)
         && (env->msr & MSR_IE)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 49bfb4a0ea..1c6e4fcfe4 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1800,8 +1800,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
 void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
     uint32_t iflags;
     int i;
 
-- 
2.41.0


