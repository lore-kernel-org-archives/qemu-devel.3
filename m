Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608E4C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rad0h-0006mC-PX; Thu, 15 Feb 2024 09:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0U-0006gu-6e
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:34 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0S-00072F-JQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:33 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563d017696eso233115a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708008391; x=1708613191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUfNPLmItBjPVQVkIuFZlyu1sOPgu8JxvvGpQGChzxE=;
 b=MGm3er0MwW9oNWe4prVX2uSI8V6rvz14sqC7pGqJPS3KZjLHj8wIvVP3+tFz5+sm4y
 Ham03+zMTmt7jD44o4GAIeREkk4ArGoEY3K0py1U+aja+v3oAU7k3iE9B6oO6m+enbzQ
 hHtFJ6G+84fepdGYjvWZYUKCUXe2rEWWQfTfaE5IfhLZfyL0+2mi7ZrwRUGyYkYQBGRM
 BZD1pDRw5Z73g/gbAMbIw70GogyGYIp8X/u9Qpth3Cdppfi9fDlNzgu+oUBw/TH75Idr
 OKh0UCZqs+Rt6SpWUD+4oymn/fsxwCeCtUvYRWFVfaDP9hI36lNQ8f9ayEsdEw/gcXUd
 l0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008391; x=1708613191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUfNPLmItBjPVQVkIuFZlyu1sOPgu8JxvvGpQGChzxE=;
 b=vhzRADrt6KVqQSECIBWp7ZrTakIkcZ0okmu36HVF+Fj7JSkT/j5ZOw+wRKgMsnPdBr
 gzKs+N9HBggjPG2Hj7oXqSpIiOSoYs07VnDOTBlyMgTuVhmOcr9GmS30fbtjYOpvlnT0
 A7MSVqKigW7fkr0FVNpVbNeM6HG2oSJTJmzjh2bobWGzN6NW0ZupT8fsiU2Z2r89/yXG
 5EwgyNMN4cUfeECyzSgbaNBU3H/COF075e2R1F8xMKKkFy3BWz7R6TAW5eG6z04MOj/E
 s1yQk4I3UEkwypJhUGOTmYFa5Jt25IRqE1mJ2X15DVvoWC+ROLuh8jR4CgI2X3tEo1vp
 sdnA==
X-Gm-Message-State: AOJu0Yw5sW5QvxtCifmXdw3GFa1/kCZDy/6YWO9jmfvJZJ41hPkCn68X
 zoXOMFp9VFSjYaXStMor+Mh7e0TljmubXLN5UkYxdr3rj+DT8K1qWFksrPZ77uj+pAjN/6KmsK7
 Oodw=
X-Google-Smtp-Source: AGHT+IHQewN413f9xZb/7KQbO7T0WqihjrTkZiKw6ZmroIKGo+VxUO1jTBkS+pgUUUsoXeGN0zCsjQ==
X-Received: by 2002:a05:6402:4306:b0:563:bd85:bc49 with SMTP id
 m6-20020a056402430600b00563bd85bc49mr1284105edc.12.1708008390891; 
 Thu, 15 Feb 2024 06:46:30 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 ig4-20020a056402458400b00560c6ff443esm592789edb.66.2024.02.15.06.46.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:46:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 1/3] hw/sparc/leon3: Pass DeviceState opaque argument to
 leon3_set_pil_in()
Date: Thu, 15 Feb 2024 15:46:20 +0100
Message-ID: <20240215144623.76233-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215144623.76233-1-philmd@linaro.org>
References: <20240215144623.76233-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

By passing a DeviceState context to a QDev IRQ handler,
we can simplify and use qdev_init_gpio_in_named() instead
of qdev_init_gpio_in_named_with_opaque().

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index bea84f3ad6..a15f90e142 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -202,9 +202,10 @@ static void leon3_irq_ack(CPUSPARCState *env, int intno)
  */
 static void leon3_set_pil_in(void *opaque, int n, int level)
 {
-    CPUSPARCState *env = opaque;
+    DeviceState *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    CPUSPARCState *env = cpu_env(cs);
     uint32_t pil_in = level;
-    CPUState *cs;
 
     assert(env != NULL);
 
@@ -220,7 +221,6 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
 
                 env->interrupt_index = TT_EXTINT | i;
                 if (old_interrupt != env->interrupt_index) {
-                    cs = env_cpu(env);
                     trace_leon3_set_irq(i);
                     cpu_interrupt(cs, CPU_INTERRUPT_HARD);
                 }
@@ -228,7 +228,6 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
             }
         }
     } else if (!env->pil_in && (env->interrupt_index & ~15) == TT_EXTINT) {
-        cs = env_cpu(env);
         trace_leon3_reset_irq(env->interrupt_index & 15);
         env->interrupt_index = 0;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -316,8 +315,7 @@ static void leon3_generic_hw_init(MachineState *machine)
         qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
                                     qdev_get_gpio_in_named(DEVICE(cpu),
                                                            "start_cpu", 0));
-        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
-                                            env, "pil", 1);
+        qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
         qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
                                     qdev_get_gpio_in_named(DEVICE(cpu),
                                                            "pil", 0));
-- 
2.41.0


