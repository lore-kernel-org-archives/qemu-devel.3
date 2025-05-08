Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEBFC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0KK-0006OP-GD; Thu, 08 May 2025 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0KC-0006B9-IP
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:26:05 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0K7-0002nZ-6i
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:26:04 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso894936a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746707156; x=1747311956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPZMshn98yoJiqlJorSwXssaa0xtfmw+pcoeQEvQkF0=;
 b=kUF53B1XkARftKHq6QXz8xhIid2UyHUTI1++UsJe88PjKajIsqY0yqqNLyBVgMNAfa
 KYWLTIdQ4vzwnPvVcRScp2+Viilvt0c8Bni0LxhS9198ehHwau8JgUf4S+Xr9W0Xg9PO
 IBzzKN2IPSdRZerNtfU/znnZ7VyBUUGqlxLY/YEFrgCJ5SJhcCvyu39zsU6TwW2nomoc
 pc8IbXcVNGMivshHz0yxPQZ/zVcJngci0YQFX5pM1CeRxII7UcAzw+hpTmOVz+f5NH7P
 XKcz/Q0M5hfj2iFVPgE7I1BsPR9MjFlNIS1lyGX7p2zJC38DhTqmofELSUUt1YdD8zB5
 gC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746707156; x=1747311956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPZMshn98yoJiqlJorSwXssaa0xtfmw+pcoeQEvQkF0=;
 b=mpChz2uZbtiOiCGByUJg78ZRCUEtDaFT+ES1AZ9fqS1gWB2hv13TVttSEVsRw4URtX
 MLNlMYsRQty3bnYk806LKxP4wSslJWbMdC4ilhH9I/vTuPeGaA/1dzmeRv+QrxKIdHqF
 CHC6Gy5SCa2tvGHedYRICkeeai54HtwJ4XfLav8HHtpxm9UW/Wu/KdIEOsvhzq8YyNr0
 ZP+1WEvGWSEpPt0MKxJH7CLQfS8rLu7JxswDl2tlpAIgUtWtwVny2ketae9UkWpXLkHm
 huZYcYxzdca4JkLavfQQ6ZpHyLeBrSlmfxtooDxgAq4WOFeUhNBdgBJnvmD+20sJ/C2v
 vTXw==
X-Gm-Message-State: AOJu0YzRsT1v6rvCW5kXHL6RtJbIG+N0ov7i+WgbN/0wQBQG9KadqnRo
 Kzt8wATQ07GXm6F0/J9M39JMtDPrfAOiT+sDkMP2C7rIAjzjMDb5uMx+9fsCSN8Z5IQUxn3AuW4
 IVQKI7g==
X-Gm-Gg: ASbGncsKBuLw/EPs5NQ8igSst+Ulj0LjmBm6HTlWg0xJeL2Hu1FyFjyM7YRlF+zZ/W3
 +5MczVO9ssR1j+KRW/KOuiUWa4vpqG9RFRHGBgG8HXgFKIMYbkuosNIDAQwfZIv3Oo29vaU+oaa
 5g14RxVRhDNBJFKbEHiBFjhpPxz3kTdGTTxxVcWzvXkWbfrX4Rr4L4kYvC3HTxJ62sjV/2w3rwQ
 lcTnGsc+9BPbW09P4atehdk0JNSk+KfD8OLf1eHCMrhiguuXN8AvTsKxzv6NJ4MtH/80tjFoaU1
 tv8eGXvVckPNNweneY6piFYcc7L4bPdDhhtRX3702rM42xRtrmjF9Iq6o1mvuQOtVngI8a+co/m
 wdxRpWlx6994Mll4=
X-Google-Smtp-Source: AGHT+IG9lw7zKs6li2v5nppKJqI1gTmXtEXP2n/WmX1TJN3EE0D7yIWUnEYi1vuWNmM8gD+fPTa7RQ==
X-Received: by 2002:a05:6a20:c907:b0:1f5:790c:94a with SMTP id
 adf61e73a8af0-2148be0e4fcmr10505247637.25.1746707156160; 
 Thu, 08 May 2025 05:25:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b213ae23b0csm549325a12.35.2025.05.08.05.25.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 05:25:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-stable@nongnu.org,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/19] hw/i2c/imx_i2c: Always set interrupt status bit if
 interrupt condition occurs
Date: Thu,  8 May 2025 14:25:22 +0200
Message-ID: <20250508122522.73786-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508122522.73786-1-philmd@linaro.org>
References: <20250508122522.73786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x531.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

According to the i.MX 8M Plus reference manual, the status flag I2C_I2SR[IIF]
continues to be set when an interrupt condition occurs even when I2C interrupts
are disabled (I2C_I2CR[IIEN] is clear). However, the device model only sets the
flag when I2C interrupts are enabled which causes U-Boot to loop forever. Fix
the device model by always setting the flag and let I2C_I2CR[IIEN] guard I2C
interrupts only.

Also remove the comment in the code since it merely stated the obvious and would
be outdated now.

Cc: qemu-stable@nongnu.org
Fixes: 20d0f9cf6a41 ("i.MX: Add I2C controller emulator")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-ID: <20250507124040.425773-1-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/imx_i2c.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 91f84c2ad7d..d26177c85df 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -79,13 +79,12 @@ static void imx_i2c_reset(DeviceState *dev)
 
 static inline void imx_i2c_raise_interrupt(IMXI2CState *s)
 {
-    /*
-     * raise an interrupt if the device is enabled and it is configured
-     * to generate some interrupts.
-     */
-    if (imx_i2c_is_enabled(s) && imx_i2c_interrupt_is_enabled(s)) {
+    if (imx_i2c_is_enabled(s)) {
         s->i2sr |= I2SR_IIF;
-        qemu_irq_raise(s->irq);
+
+        if (imx_i2c_interrupt_is_enabled(s)) {
+            qemu_irq_raise(s->irq);
+        }
     }
 }
 
-- 
2.47.1


