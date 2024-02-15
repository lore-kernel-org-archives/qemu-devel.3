Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DD1C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag4G-0006OL-U3; Thu, 15 Feb 2024 13:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4E-00064L-Bv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:38 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag49-0002sb-Nt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:37 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41211acfcfcso8437415e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020152; x=1708624952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcKvmadiGqmKN7g4qDe2Hjh8lZOAnNypphJxj7H8q5A=;
 b=f7paDpRxU1W1Jbr75o5aM8O4/n5UDydhEZasjhjNWqtb7lz1chLYUm7K7QI/6ejPpz
 VRmumpTnBw7L2BdwRE9scqyUQYX+J0ukicKE6hjoRrj6LV2sOn2Zj1w72x79X5o9/iBg
 JSUAz+gMVK5nol2asEY/l9DFuSsgJ4plcG5rvCNO69bGeoFI0Bf0RvMzV2xha7tcuP+I
 IswZnVMYWqKcroxeeu3uuTT2Lsr2faz/Kkqcsxp71L7UlQ7ZpbyzChNyPzd2zEKk2dLM
 qXedxhHGdtSXJLMH0jiYgDt6icq3IKgxHoDh+7ISkktT8r7FIFqLX1IT1dUYKxBx+EOY
 zIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020152; x=1708624952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcKvmadiGqmKN7g4qDe2Hjh8lZOAnNypphJxj7H8q5A=;
 b=RJEvzjTKuC7IMNiJJOU+JHjffqP1ivDBW4OqRREIss6LpysJbJtWagDsdL/cuLSElh
 Rlw0I5JSFZfFK5Q8SklXdRJqp45WOp6BZjssVc7MdDf/A6mGARfAiJXhJXIJ64nBYdW9
 yDVD2H1ysJNFITFERphQPNKzvRshMWqeLr3kkzj2xdwdGjVe+lodgdLJeyT4gm+eUyH2
 7RT1MndhJV9NP1W7RM1A4/w1GOrs6v4YzJcYWjeFCoW6n+bc1HUT0jg6VfeYIZDcrOVn
 SNEg4NHu/6HEOpBIKO+UrUcUUsh7s8V4d7ZQjmsRcyIJDFMEQcfW2bmgclIms2fBn+fa
 83YQ==
X-Gm-Message-State: AOJu0YynoCDzKpklWUYzTLzGhPNObTd0SADZHIUHvQZL4J9X8c7WMPIo
 bpPZbjT8YYvZXpaunQ7lqRhlxvcn+RWc2s7Da6ET4KVLSoSZrqpU45AqXS0WHZpIMBjxjHWiWsp
 EURY=
X-Google-Smtp-Source: AGHT+IHiaJRcMY4u8wTGvn9KBgTr7SAoeic6heIOgEeoKq6Fl4eW/uo1sF9Hh+d/ry5mnbFz3E3Vlw==
X-Received: by 2002:adf:fe86:0:b0:33c:f638:ed0b with SMTP id
 l6-20020adffe86000000b0033cf638ed0bmr2208959wrr.8.1708020151951; 
 Thu, 15 Feb 2024 10:02:31 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 n5-20020adffe05000000b0033b47ee01f1sm2432289wrr.49.2024.02.15.10.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 41/56] hw/sparc/leon3: Pass DeviceState opaque argument to
 leon3_set_pil_in()
Date: Thu, 15 Feb 2024 18:57:35 +0100
Message-ID: <20240215175752.82828-42-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240215144623.76233-2-philmd@linaro.org>
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


