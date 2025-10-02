Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5093BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 03:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4A7h-0008MN-Ll; Wed, 01 Oct 2025 23:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4A7b-0008LL-Sd
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:36:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4A7P-0006r1-Qh
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:36:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so5062065e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759376185; x=1759980985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yV9sqx+Poz2PWxVls0xDyr5kFFjf5hrB1+fQedhcp7o=;
 b=yqZe6iBWwBbV4WIrB4RpeknMJvEkCUnj/MJ0++ryk9Fcu8c2YQfZib0J9R6sL+nyXy
 /YKiVsb4x0LOHzVoDobPDqCj7OaCZW4ZlDFTUSbXWpF5/fLrNfMsW854c+XqAN0PwEAc
 Ozc1KeKqy6/PKZcpNMfNoQBifnkAzyK6yrqAszc5qsi30KlTdaeIHySoQndEW4pncEl0
 mhn+vQ+CpufyB+WNpEp5G7AZRS1E7NAnMYYSa70SoHu/driRG1VeaBVuaxQ98rImKqFW
 8hnQKjTyCqmVvjACXFvotJ79wKJvfZj+wcrZhBExBrXs7ntVeDaH8abuMLCCBpLDofAF
 WjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759376185; x=1759980985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yV9sqx+Poz2PWxVls0xDyr5kFFjf5hrB1+fQedhcp7o=;
 b=D4w0sNpaYmxAAeQSWutVfx7OT+Y2aTu+kpU/o2EwAIz9CeAjF87vP1BC9JTVgjquMB
 l2rQCnf+Z2KNO3NoNYZpCXGtjwfjwYGVi8fkfy00FZi6zwWFlqwwV9Wk+bXARjqpGUKV
 eXPQ5BokxhPi3R+9CeyWHhbMqV1VqZSSjuKNEpe87U0RDYj8T9jXo7EMsmli9z/S1sui
 eH35BYeGQzYNwHfj/uhpqEHBTmpkXLOj4PktOObi5gD2eIwE6bECyzs0bvxnMxUSdMuC
 Z7SQJGiTSmKsjEfKas/Gxht0DbcBe8oyj4hOlBptUvcqI5ppNJNerksLfzxc8x/f0COC
 HyfQ==
X-Gm-Message-State: AOJu0YzQ2kxJSuhwdCgFfTWQu+elI2hYhPxwufSnpIRivxLfXF0Y8mWd
 X4tCiw6+KRrlk2ds7ZXfpuUlpIEgqqYXzBaVsZVjr62gj3IJRKaKDowPKgH4mnON0KHRVrgd9ku
 KpHb661v+MA==
X-Gm-Gg: ASbGncsQUN2cGH71AKfXXsEzMVgo4e+hDs90/GXiuE8ZxCCC4RiKYhgo4bS4up4FYTm
 3PRyg3RCj2Npxs6S1R/scczOCqGF6vq/Df7Zx6qdxkHpiFArLvJ3t5PLCmoTUcjkAHdVXbq3rY/
 jaRU5SjoEHxnNGVgSipPOMSTLcLGI7DQsQuVyx1BmUZy7zHLhP/jXAtrsqmXumUy7MQVNmm1C79
 6uJZLP2+YLNjIz2+z93h/EuJjmfgc/0m1mYyK7GE+k3QocQhr8IUSaQOFRIRaCNB9UCBCRYAvOu
 StlW3qyDhyJ338svfrDRCNgznHWK+4vZPpjwiaFNGt+TIJNvQPVNb3mEpRWyf/mK7+caOVYYrYN
 EDY5qoqhq2CdUSrwONSE7P+q8zwq8GP6qFb8f+WRm7T8gxi+gqVMj9pBTWkI/dY7Csa8osIORpd
 WmIZ4ocezxyUrlJLX8TC+KHS/lXiYnkQ==
X-Google-Smtp-Source: AGHT+IEfyxQjVBOSKg1TJMnP/q3wUWWVHjqRPnthAhrWLdgavTRwFxD9GUuEo5ad0rzPYeuK7Jsnmg==
X-Received: by 2002:a05:600c:c4aa:b0:46e:59dd:1b55 with SMTP id
 5b1f17b1804b1-46e6125d619mr44902105e9.2.1759376184871; 
 Wed, 01 Oct 2025 20:36:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0241bsm60808805e9.11.2025.10.01.20.36.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 20:36:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/sparc/leon3: Remove unnecessary CPU() QOM cast
Date: Thu,  2 Oct 2025 05:36:23 +0200
Message-ID: <20251002033623.26800-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

env_cpu() already returns a CPUState type, no need to cast.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 0aeaad3becc..09d2cec488c 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -192,7 +192,7 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    CPUState *cpu = CPU(env_cpu(env));
+    CPUState *cpu = env_cpu(env);
     grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
 }
 
-- 
2.51.0


