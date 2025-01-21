Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144DFC0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGxk-0000UC-9e; Tue, 21 Jan 2025 11:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxe-0000T4-Oe
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:42 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxd-00061D-0w
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so67587445e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476318; x=1738081118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yt2HLyysx4apERQYQylU+akZvlVRd55ruaMuX7GMQQg=;
 b=NApL2wfOBlYWofXS/PwGNVOei6Y5HnKhrmJ5MuwswUzBO7kINn7pY9/j44JRG23XEc
 ek+T3rPqATDdLw56D/JL9EVRro0OhI4JZADhJSo1BGqj4X0VGMJJXaMQOWUJC6Nrfp5+
 so+I+gthqfkiOQDgh/uIPgyBSnV1lbKFpEGgSQGv5Rmv9odoroLll96V5kGUiS2V1brE
 pRQ3brgRTRhOfdxUV4+Bst3Tzw75VrupUqS3in66bxWmZTPxOYqeKVBLgQMFXHc+OQdi
 uL/7im+MoQWnkAbBmIHPgNhOVQzG0r4lpy9fEdorG6xjYY4IQMqhVkHgUl8oLgk881BN
 ZzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476318; x=1738081118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt2HLyysx4apERQYQylU+akZvlVRd55ruaMuX7GMQQg=;
 b=pHZOZwX8Div2DbbP2hJ+tZE8bOq9YKGqg30LoLndtToKbV6OescYXiDAtGg0orZmyI
 4dnDqU6ugatsZv59bjwmNgbzulTOLFP4rBUgYxBk5GVEdXF4rijWOhzbHa7rDaNRvA2x
 JT7DwAPmWk11djptCaWiUwDLzWS/OI/fNFTg7PPhipB4xSwyagz97rnbAQy+egxVdK+d
 m+MtxSWCD881nUFhxOj2kKMJtKyM1vSqH+cVVuX9yW4as7csMPh8TYz2akw4Nlm81XNC
 HDszlNvV+8wcW7qwHW5q13dPQ5tK13hc44Yvk3tkkypl/cjphG4xRyq3qBg9oo+XEAip
 DO6Q==
X-Gm-Message-State: AOJu0YwzV/crJtd59XNdVHeQfozCzadk0deSld7suPzIff0h/DI/362M
 jDFXsXFJcwi8UQacRiZKayjT0k6cGarKUseNWhXt71v3e7yV01M6RtoUafNukonQtK07ei7bYEV
 z/wk=
X-Gm-Gg: ASbGncsTK/iReh8xNVVVzN/IsjvVQ6TIkj4Y8yVJpCk+SpSGrCOnkRPOtKg0lQcY1tb
 p3dERGYEERUElGsVC+SaVL3NZwCZEC/juMx/e5ll1ylI05qgUXDlYX6ysQb8jYu5LA7DdUUJuu0
 oxoKAxpauwY2YBbqugPA9VjcLglV9OF6i/4+J11I/ISOKUTsuorMXyyyrlRARKG71+1E0dRTfkM
 Lz1bwIUlkLvmcd05ZEKHIzF2gvUUjSiZHCSI9OKu2EFPZU8WP4gB9B5PWZVzFhXYynsAEEFrYT1
 +HKdvNkqb6fAUeBPPh1SgwMpgS9iNJM7i3gkaaHa/H3R
X-Google-Smtp-Source: AGHT+IGZW3JIAN3dV0dqZL4zhY0trbXlZuYejIcfpvgB1Hx5XWPeh0szKqLz6CCqWXYDoBRdEgQSBg==
X-Received: by 2002:a05:600c:5027:b0:435:294:f1c8 with SMTP id
 5b1f17b1804b1-4389143164dmr146199865e9.28.1737476318079; 
 Tue, 21 Jan 2025 08:18:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac61csm244464805e9.14.2025.01.21.08.18.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 08:18:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 4/6] target/mips: Pass env to cpu_mips_clock_init()
Date: Tue, 21 Jan 2025 17:18:15 +0100
Message-ID: <20250121161817.33654-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121161817.33654-1-philmd@linaro.org>
References: <20250121161817.33654-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Simplify cpu_mips_clock_init() by having it directly take
a CPU env, move its declaration from "cpu.h" to "internal.h",
as it shouldn't be accessible from hw/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h              | 1 -
 target/mips/internal.h         | 1 +
 target/mips/cpu.c              | 2 +-
 target/mips/system/cp0_timer.c | 4 +---
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b4..e5767ea9cf3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1361,7 +1361,6 @@ uint64_t cpu_mips_phys_to_kseg1(void *opaque, uint64_t addr);
 /* HW declaration specific to the MIPS target */
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 void cpu_mips_irq_init_cpu(MIPSCPU *cpu);
-void cpu_mips_clock_init(MIPSCPU *cpu);
 
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 28eb28936ba..69452aae5bc 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -214,6 +214,7 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t value);
 void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value);
 void cpu_mips_start_count(CPUMIPSState *env);
 void cpu_mips_stop_count(CPUMIPSState *env);
+void cpu_mips_clock_init(CPUMIPSState *env);
 
 static inline void mips_env_set_pc(CPUMIPSState *env, target_ulong value)
 {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 95df8985bc6..99f442a4b98 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -479,7 +479,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     /* Init internal devices */
 #ifndef CONFIG_USER_ONLY
     cpu_mips_irq_init_cpu(cpu);
-    cpu_mips_clock_init(cpu);
+    cpu_mips_clock_init(env);
 #endif
     if (!clock_get(cpu->clock)) {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
index ca16945cee1..07641cab521 100644
--- a/target/mips/system/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -133,10 +133,8 @@ static void mips_timer_cb(void *opaque)
     cpu_mips_timer_expire(env);
 }
 
-void cpu_mips_clock_init(MIPSCPU *cpu)
+void cpu_mips_clock_init(CPUMIPSState *env)
 {
-    CPUMIPSState *env = &cpu->env;
-
     /*
      * If we're in KVM mode, don't create the periodic timer, that is handled in
      * kernel.
-- 
2.47.1


