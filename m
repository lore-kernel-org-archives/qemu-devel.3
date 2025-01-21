Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B08C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdr-0005px-PO; Tue, 21 Jan 2025 06:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdi-0005gg-Em
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:50 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCda-0003RU-V3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso39752305e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459699; x=1738064499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbmqBhov6nOW5WRBICFiiuCzE2uEl3xQcd3ZviTByWc=;
 b=dsnDzGPke5MdZwrS83aUUy8aE0nfygNv4So3jBELCOgnquQVI/tzUc4w+8uJs0kRbN
 gBjMThm094Vq+r9yxP5m7BHYPx3gVxHNO7rjSipUSN5zhW5zh34CZQXM42az/bn547Qt
 hUKbN80fpWs2SkbHfLTT3un7OcFtEh9Roh0MIAF7ARWp0EiJI1pQVhpElnkuaTB/7big
 POaawaOAvkhBCKCcG70nCdNSyEe5ON7d2ndkumxIeY6r3LwQKHmjywomR1ktkbsEWISy
 vTOfYgrUO15ppGbBI3K10ZENd1ZPfnjLbaMAQ2km5z9AiYpicD857lQiuhWNmTa6LPSr
 8BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459699; x=1738064499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbmqBhov6nOW5WRBICFiiuCzE2uEl3xQcd3ZviTByWc=;
 b=ZFxexqUmW7gdFCLDh16F4oIrdp5rMURBviVi8bYLpTkyOHNgHN2Z6/KKV24DM9bpjO
 zwIfofffZsWFCPrgaHBkAqEHwm3/GpxLcL8FhwBQNCVFK2cQW1dXZW1BWCZfxp2wAg5t
 GnBTX2aD6CBppRjLreNc9DFMQ2OsI9I5RsuxpwXNLnIcB1H0QgAo6hL5u/NLSEpApztw
 0UkGhifQNlNmNg71FU9ngj/y7w3jDXIV0Szjz9tHCiqRoZm1KpaPkPAEzbmZaP38VQyS
 urMy7etN3pdekY7M1aDA9WDXygGCDIbZP9h8COwH3KUCR4o96uW+MjPQensj4tMgOwXA
 ntqQ==
X-Gm-Message-State: AOJu0YyxYF49j8QnPdiH6vEfHVn5gnKnRvfBM/hclQIsTWcIuM8KvuaX
 tURLHXfWSuhfUqFYAP44roqqCRipcr9M8zTd+LxeBnL4Gwzm1zjjScNZ+oGP9rEr5FKvEoDivXW
 eyas=
X-Gm-Gg: ASbGncs5ytloeeBZ1jOUDe99fszUw+hXXnAUGMphMLh/yKjoj3aJ+mGcEK+u1HjN7oA
 6D8Ba2VboeqcwFf8R5V0SHgt2z39+v33/gH2LpTXOIcEChVfS/7fhTY2bgbqdVamxX89mG0TDAz
 lhocced2Ew2pYGioK8eWfmVzwszo7hTkggEchKCpp069Bv4idKSi66Z7rQGa918I34wS7vBIh7D
 nB9cA0vaJKJrM1wMiVI0/TQk6Xd5yt+mEGf0okGASeCJdOUKAN5VWZ/Z6tDNuStpfrGIxpD9txp
 12aOxjAyXnvCMIiJZx4IjtRf1/fn/8cMAen1iOuUg1o8
X-Google-Smtp-Source: AGHT+IFvrLae6bJODFDwt+1EVnAkGSeOwOakfLBXI2a6CaNkQA7Dm+nSRgUsdOq69rgIxYGYYEYnSg==
X-Received: by 2002:a05:600c:4ece:b0:434:f609:1afa with SMTP id
 5b1f17b1804b1-438913c6787mr153654015e9.4.1737459699396; 
 Tue, 21 Jan 2025 03:41:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221b70sm12914454f8f.26.2025.01.21.03.41.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/11] target/arm: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Tue, 21 Jan 2025 12:40:54 +0100
Message-ID: <20250121114056.53949-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c         | 3 +--
 target/arm/tcg/cpu-v7m.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dc0231233a6..048b825a006 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -846,7 +846,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 
 static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = cpu_env(cs);
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
@@ -946,7 +945,7 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
  found:
     cs->exception_index = excp_idx;
     env->exception.target_el = target_el;
-    cc->tcg_ops->do_interrupt(cs);
+    cs->cc->tcg_ops->do_interrupt(cs);
     return true;
 }
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 03acdf83e00..d2d0b94b630 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -19,7 +19,6 @@
 
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     bool ret = false;
@@ -35,7 +34,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD
         && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
         cs->exception_index = EXCP_IRQ;
-        cc->tcg_ops->do_interrupt(cs);
+        cs->cc->tcg_ops->do_interrupt(cs);
         ret = true;
     }
     return ret;
-- 
2.47.1


