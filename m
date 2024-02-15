Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B4AC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2v-0002MF-Ts; Thu, 15 Feb 2024 13:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2n-00022O-Ny
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:10 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2j-0002PA-Bt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:09 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3566c0309fso144975166b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020062; x=1708624862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9qIQKhs5a0rBnt1RjYr8e6nFgX9Qz3kgk9xy5OfTBw=;
 b=jcVjhbk2wkTr1VOMW5l/6dNmOeMuZB74HM5kfddyqgAVVruzA1PdZHXL+gT/pACIhS
 ahasEDmR3iDZmges47KRqiyG8nO4n50WBcPMpgVE/opa1PbkuRjFgfBoiBjaeduZc+I7
 o2TgNBInpZsw6FQ/9q5MKriad6XTWZUo0/K8T/PMfZLNtWU+5zf6ZJ/YdG0rMXn0k17G
 l+d2ROaA3cRyOocmf+J7Lt/6BYbhtSahjmInFEFHeLsCsvOjOUZQ/qeXvYmW+ctbi3qx
 IJ4c58la/jHWX8ENCYPp0RyT1egkUd5qfykEOzs91DfupJEKHXlKc7Lp6Uk0j7aKU9be
 WIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020062; x=1708624862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9qIQKhs5a0rBnt1RjYr8e6nFgX9Qz3kgk9xy5OfTBw=;
 b=niz4yZYRRBSg3igITjZlvrpv1GiW1jzO3mJeeT6h1Qq4YaLUyhlHx18mrg4aj0AmtN
 LJ7d8RP7jc0ICEOvfttRKe7eMiZSy2RoKOqHSHBg7L0k78W9n0sYRb11NwKQlT8wxuGf
 mFfI8tnln9T8lTPibe4lfCx4P4MvYQqXo2dSJmob+3IE7Z364Da040q6nFsKYqVAL84R
 rj8vYaToBC17l6hUtuUznnqqirPTr6qydr1mEZJyrc/cd1eJrkqe4v2F+5tTrUr9xXga
 JxveLvNwEjZiSm99EYDyTIHAP47XHvJQr7uZRGr1JR5dy4TGJr288jT0tLJcwOrOMvwx
 TXhA==
X-Gm-Message-State: AOJu0YyTIHf1+aledvYhOCEBfM4mEVeUdSfEZFb45DbylgIBRYPc2COj
 1Wimc9fUOR2lRpj3WcnP5/R9nzREechigZu0nM2v0dBoUJ+uC+4rNdQAr/8UHkfcaESgxAfFqpt
 ko+o=
X-Google-Smtp-Source: AGHT+IGs8bPSzV6GsHeWtPeuS3MEKu+yURJ22WpA3Pkl6Lrwbc2ZWj0JmQfFpdqNDopyYHJg4mMr+A==
X-Received: by 2002:a17:906:7d86:b0:a3d:e9c:6d3a with SMTP id
 v6-20020a1709067d8600b00a3d0e9c6d3amr1800135ejo.49.1708020062128; 
 Thu, 15 Feb 2024 10:01:02 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a17090699cc00b00a3d943558b8sm744210ejn.134.2024.02.15.10.01.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:01:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Damien Hedde <dhedde@kalrayinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 28/56] hw/sparc64/cpu: Initialize GPIO before realizing CPU
 devices
Date: Thu, 15 Feb 2024 18:57:22 +0100
Message-ID: <20240215175752.82828-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Inline cpu_create() in order to call
qdev_init_gpio_in_named_with_opaque()
before the CPU is realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Damien Hedde <dhedde@kalrayinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-13-philmd@linaro.org>
---
 hw/sparc64/sparc64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 72f0849f50..3091cde586 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -24,6 +24,7 @@
 
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/sparc/sparc64.h"
@@ -271,9 +272,10 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
     uint32_t  stick_frequency = 100 * 1000000;
     uint32_t hstick_frequency = 100 * 1000000;
 
-    cpu = SPARC_CPU(cpu_create(cpu_type));
+    cpu = SPARC_CPU(object_new(cpu_type));
     qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
                             "ivec-irq", IVEC_MAX);
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
     env = &cpu->env;
 
     env->tick = cpu_timer_create("tick", cpu, tick_irq,
-- 
2.41.0


