Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFFFC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacE-0006QX-On; Mon, 10 Feb 2025 15:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacE-0006QG-6M
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:50 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacC-0003dP-LZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:49 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dd14c9a66so1121764f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220167; x=1739824967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nuHHIvM6pSqnytPWoTxGSW68RW0qHiT+ueaTC+djWc=;
 b=kOPYnT+9VNjGqZo7qzVn7sBkaEFFdhSTYD8WwFNxLAwVyXPxFRj3oUa77j3Yv6vN90
 2O97kuw1UvmVjlgBoNBBhF1rnPlCbQERs5yrYIF62QBm57SGi8Zgz73xLVCmJXDfjdok
 1oATUn4fJpHl4XrslYdtWy7tDLguAzAug6HsrhNluXBLC36+BCK5ZGh0r7aQYYCdYWit
 ETBHEFDcNl6PAlzxRRgJMgbHGxHuAWvpNdnBaWAQo427NTItnSte3CkNWuPZ7QftUsIk
 gjxVD8EY9X62Ys21J1+SUTjvY3RPzWG/swtyk80wHB/OiyXh3lf0z/BomH2+mJS4AD2P
 cN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220167; x=1739824967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3nuHHIvM6pSqnytPWoTxGSW68RW0qHiT+ueaTC+djWc=;
 b=tSSjM0Z/zhx27kvg06Xt9jMpwb2tuU2rBKLVG+JK/xIEFr/rqBcviGNIbWQ6EhuxvP
 su7zJIvjYJ7G6APmGT3F42lX8eHeQWX5o+OKjNVcZiMh4xilLEb3HQgKTCHju2HOrooW
 ctGruXPA6h/Igs87Us2Yangh0uQutzoch2wkLZSSiqP8Q1H/YonWzSJkX9/wHGNs5qJ2
 SAOmA8KBxvchoQcViDqDk40r4YyTTNtOW5asr8wOMAhB8kc/q1Ny2ERioZrIKPHpEKk0
 3FqyJQKljBFGar5XK6cZjqdopGhvVNtQDL5k8FUdlQPgXbUGIVWHY0j34ff7TJtgoYXl
 PHKA==
X-Gm-Message-State: AOJu0YxFLkJGy6IPIEja91WVMTNMKCqCUCO95gDch0EfTF+rROn6+Rjh
 WS/qDKIP+4+qgqfyffkdpdBNZDFFwQqewFwy5m0wDnXGovDkTBf9JqWMEbOz26M/1x58EHtozJX
 3KjM=
X-Gm-Gg: ASbGnctA5VaUP2nuYEuiq7G1FzrD6gRs+Puvfh6WdcwrpRfrLT7w5xbyxtkkM7C/y8m
 nyVJktUy8gGJHth/bZK98AaT1zNJIRPL56jRbOUYI2mXqJu3KeJ/0NA/8qOLFySmcwKcw+MoaLQ
 JuywiuVBb1LMba59Hp729a7xYU56YYWetcbjNgs/qP3pwpqT3rwTy5FHzxWHPk4reeAQMrff9jq
 d28vFprxIO26BW10ScpS5Xu8u8Fa0qgDzS5oKZMcxbFFHvH4S9mSk21FdHHMbLzQGFFQFBFloV2
 LmUpaS1OC7GsX60hnzwQVHyGbVN5bxTZlzDHcmB86zHGg13PjbRBTLQ2Ngx/sjQrTA==
X-Google-Smtp-Source: AGHT+IHwlNMgul/D9utFFraEy6LdQZUaJIELgo6s4YE6KmLK+PZ+9vj+uPcsY2ppKMQyN4J3NsFygQ==
X-Received: by 2002:a5d:64c7:0:b0:38d:d4b5:84d6 with SMTP id
 ffacd0b85a97d-38dd4b587a1mr7734341f8f.3.1739220166892; 
 Mon, 10 Feb 2025 12:42:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd49d2cafsm7673117f8f.16.2025.02.10.12.42.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/32] hw/intc/apic: Fixes magic number use,
 removes outdated comment
Date: Mon, 10 Feb 2025 21:41:40 +0100
Message-ID: <20250210204204.54407-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

This changes replaces the use of an explicit literal constant for
the APIC base address mask with the existing symbolic constant
intended for this purpose.

Additionally, we remove the comment about not being able to
re-enable the APIC after disabling it. This is no longer
the case after the APIC implementation's state machine was
modified in 9.0.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241209203629.74436-11-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/apic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index d1d343d4216..d18c1dbf2cb 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -350,9 +350,8 @@ static int apic_set_base(APICCommonState *s, uint64_t val)
         return -1;
     }
 
-    s->apicbase = (val & 0xfffff000) |
+    s->apicbase = (val & MSR_IA32_APICBASE_BASE) |
         (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
-    /* if disabled, cannot be enabled again */
     if (!(val & MSR_IA32_APICBASE_ENABLE)) {
         s->apicbase &= ~MSR_IA32_APICBASE_ENABLE;
         cpu_clear_apic_feature(&s->cpu->env);
-- 
2.47.1


