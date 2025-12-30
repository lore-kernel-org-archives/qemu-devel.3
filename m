Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DC0EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyN-0007MI-CL; Tue, 30 Dec 2025 16:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagy9-0006pk-9y
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagy6-0002Kd-Bx
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so62836695e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128964; x=1767733764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O8snffjzsXivY+VrMCvVGRQf0hPgiUgCcuP0Hn1j+LY=;
 b=CowzSSeTLmlEtl2iXBO/3EZ4nPWpLERq+F0hKBY8TytoPcQSS8S238O3U4L7NOwEzY
 sC6BdX2Ty6vvRsg+OTQmAzCErvd1i54CjHw6QeWczLStB0AvyElEDyU2H1YctEejoexV
 8sNJMUYRJ5iOBK7wR4Ysk/+n5mMiKcj7y1Hw928gASgBUAmo91J0rNaTFv08ag+3AcNP
 ilMD+bcIi50mSumSKCt173oeopIjgSdPL1j92mZuwPT1PBpWSJXXmhYPsDrbsX6QsM6S
 xl0SSwspQSv52E4ugrPUKSKGHLXdifKuvMJGfJb/1lpbC31vLddyr/3whslBRSuAw6yr
 4RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128964; x=1767733764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O8snffjzsXivY+VrMCvVGRQf0hPgiUgCcuP0Hn1j+LY=;
 b=t7/OI0YQaIPoI9ibjFYcZsEgI0vFeiwxoS5M/SvOSfdcULJU3vr8uanjS/9R9QBfQ2
 dgD8CLjSR4X8SPbxe3+r8Pr9+qHVHioYsdS/mgf1WwRleZ/8MU+RNU78k7BH6zgTdnAU
 ZXdYzTbzBbsFqZ9lqnCTAIL7R/AR1jZH7t8TTMqAx3mDPw2DLl9iCMJGSvgIpBYbcu5X
 9tPOg3AKa123lWWGZ9rAQ60KPgY3tGSXfsfvYWjrSwbo8b79URHuRnKhG39L4Av4ddzW
 69IwLF6JYiPefk3gEIhecNwCpjMt+XkTIIen9wqAhm+6+5OJ3gJ24Avntvbs6qdb3ldN
 tadA==
X-Gm-Message-State: AOJu0Yz3TKx15vZFq4oXXPUlv6Ez/M1SH4DVMCZe+bJnYgAyElF4cbrw
 YQvkMhlUno18Q05m/laAnoaerPDUFEJpxS8G33m6PHkCg2Trk4HWaAXcupz4KMkyO7RzHT1oTMM
 VwNzMJ5Je4w==
X-Gm-Gg: AY/fxX7YSFZ7JlSO84OlqF9tXNtPF87QO6Em2AuVNygh5+BNi8xHzHknHRYMY4rn95L
 7JubJnvxbWEi4TV7Naz/GhUcDjOHjCSJjSwCt+knbn0fkQ3hdNrjJBuWDPZ/sVB8Pr1AlZAarbG
 9oA8aCJJS3Pu5dGBAuKImdYtfJMAa69RwN/TeEMm/MNG70r9HWI/o2KmeUAdeYKf/hGYJ7L3ON+
 L0gl/eJ8/kWOihcMat6Og0idl8cod/jKE2QsOHobWIe7DrqsLEzHzVqdDn5qH29/mAa9hblgEqb
 nr2Zu8roOKJFYzgxXpsf5+M0xPSrLI+mRtE1OcrGBby6g3pfl2vO+oklRhq6imIjhseXi3rqeI8
 RGXMfAjo7+yptKV1jgmKISroOgz3IlE1j+ccmTGWOyiTONSaAv9FOdy4EAd0jDFMp4H/8/0yVCO
 n0azvxlUWxrF+vlU2iYHDoinlSRQsP0U4gNdayRD4Ztk8GUXrlPudCjmPfDqgPzA1g08qsu88=
X-Google-Smtp-Source: AGHT+IEPtTkrXnXhRPm8BP0968p2YnVr1BxfbkhxAheNo5shjVnpHKIvMLJpOFNQBOi9vJiFXmGH9A==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-47d18b0ad6fmr398817425e9.0.1767128964259; 
 Tue, 30 Dec 2025 13:09:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cba81sm601445195e9.10.2025.12.30.13.09.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/34] hw/net/opencores: Clarify MMIO read/write handlers
 expect 32-bit access
Date: Tue, 30 Dec 2025 22:07:35 +0100
Message-ID: <20251230210757.13803-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

The read/write handlers access array of 32-bit register by index:

 277 struct OpenEthState {
  ..
 287     uint32_t regs[REG_MAX];
  ..
 291 };

 546 static uint64_t open_eth_reg_read(void *opaque,
 547                                   hwaddr addr, unsigned int size)
 548 {
  ..
 551     OpenEthState *s = opaque;
 552     unsigned idx = addr / 4;
  ..
 559             v = s->regs[idx];
  ..
 563     return v;
 564 }

This is a 32-bit implementation. Make that explicit in the
MemoryRegionOps structure (this doesn't change the maximum
access size, which -- being unset -- is 64-bit).

Move the structure just after the handlers to ease code review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224134644.85582-3-philmd@linaro.org>
---
 hw/net/opencores_eth.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 6abeffcc9c7..a25f8eccff3 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -683,6 +683,15 @@ static void open_eth_reg_write(void *opaque,
     }
 }
 
+static const MemoryRegionOps open_eth_reg_ops = {
+    .read = open_eth_reg_read,
+    .write = open_eth_reg_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static uint64_t open_eth_desc_read(void *opaque,
         hwaddr addr, unsigned int size)
 {
@@ -706,12 +715,6 @@ static void open_eth_desc_write(void *opaque,
     open_eth_check_start_xmit(s);
 }
 
-
-static const MemoryRegionOps open_eth_reg_ops = {
-    .read = open_eth_reg_read,
-    .write = open_eth_reg_write,
-};
-
 static const MemoryRegionOps open_eth_desc_ops = {
     .read = open_eth_desc_read,
     .write = open_eth_desc_write,
-- 
2.52.0


