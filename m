Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3757AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXK-0002g8-Bb; Tue, 06 May 2025 10:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVT-00029G-Ga
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVR-0002BK-Qo
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-441d1ed827cso4608615e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542568; x=1747147368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i+QMorwpUEytgCmmdGbZfkGf25KtJrpacfldZ2jwkgI=;
 b=va3hfedojbGZEG55KkKPi6X86tpfKHn8xSd1NJ1Vm+iWe0lb7rgFy1Q06vYjKcrhM7
 pnPTPs7QyQ4DPujkXvW//ngOpTzX015Q7DQrF7AgKEgp7dugNZWjw1Rll/qUQLFCV2id
 8RdUWTHxa4+55k7O8PqCYYsP8iQPOMBIvbfZUQfDd6oBr875bcd1GnrvO7A4PWk7WhoP
 ue3JDW0ZDLpXwDjhLIJri7HAvsPo2ygaAo8P5sl+WexUdiRv/f7PTa7eWCLlGNk0Lgli
 62HmC/qO/1XHJOXljuDtYbU0NsqOhFMz1e4SYDswtqGiWCzDaGSkyldE5JGIpHohJvhz
 SY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542568; x=1747147368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+QMorwpUEytgCmmdGbZfkGf25KtJrpacfldZ2jwkgI=;
 b=M0geBT1+ElFyuaqxNDdBs0r5z6rZbul8HUC2xYHapuup94YtPZW0TVhOi3dsULUF5k
 dLM56cXkKE10rssrcKy/biGaOrQmgI58tB3mj+rBH1DzOQItGqnnyuyCbi8h5iowkdoC
 UtdU2uSoRK6wDJN5k0LArFD6K9DECaSNh9rftl+b2JIOFvGcyveqfn6gcNOp5LSJw2Wu
 pookqx+Jdo/EeBXthH90CBV8Iq+WB0zh/wZF98e2Z24aSLD7N3vcuUL9U0BGdlTExPYD
 TL4ICDF2g75/rrqtt5lMi0k+6bx+X/sx0EmvgrfvsoVlKaPn6ViARt4K19LB6Bv0Zjur
 +cvA==
X-Gm-Message-State: AOJu0YyB6uXBt/IW7NTfur99DolRLwIEOLkx6xGNalm7Ggcqh8Khft7E
 LDjifx0K1eh63MEnZPW9sdxSiqKWN35k6ehXMrJhNpY7BD2+8oYBT5fDIXUGwCyNWA8MhKYoc40
 A
X-Gm-Gg: ASbGncvKCuZRQfGV2Dx5SBXkbeGJqDrNIjPnduS9vjKVRCJ61T+P+yO21hwkP+3rY/A
 Pfm801TiW5vaRDBwvCS+XzV7HzQTs/BdB+fyKjzUxwTUkrBv+U+G7azM4ufZqcbRkJhp6ThQ7gG
 jp9LZzGVBhaWkgPV3EwTT/IcgbATm+s/lKxfnNQJ+flg46RZvmGQYfp8GlCckiZoIjiwzKAW+pQ
 GS+E8xZ9N4l0YSI0+Zn0R/gA+CRZJ4YDtGB05PJklPakFtk0fELV4stLv976O11+d+bdgOrPiAk
 8sgkeqpJT116ppD9tl/ie0XOXFzJfUjLO6yVLnS9hHg4Y58=
X-Google-Smtp-Source: AGHT+IHYjYmPDWNNSoIC0FCIcHtGwDQtwjwbtG5mel3nmwHWS3FR03xDr1+oO+/D3GT/86tjyvEv4A==
X-Received: by 2002:a05:600c:a03:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-441d054c884mr33139045e9.30.1746542568421; 
 Tue, 06 May 2025 07:42:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
Date: Tue,  6 May 2025 15:42:10 +0100
Message-ID: <20250506144214.1221450-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

According to the i.MX 8M Plus reference manual, a GPIO pin is
configured as an output when the corresponding bit in the GDIR
register is set.  The function imx_gpio_set_int_line() is intended to
be a no-op if the pin is configured as an output, returning early in
such cases.  However, it inverts the condition.  Fix this by
returning early when the bit is set.

cc: qemu-stable@nongnu.org
Fixes: f44272809779 ("i.MX: Add GPIO device")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250501183445.2389-4-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/imx_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index f23c52af26d..450ece45482 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -72,7 +72,7 @@ static void imx_gpio_update_int(IMXGPIOState *s)
 static void imx_gpio_set_int_line(IMXGPIOState *s, int line, IMXGPIOLevel level)
 {
     /* if this signal isn't configured as an input signal, nothing to do */
-    if (!extract32(s->gdir, line, 1)) {
+    if (extract32(s->gdir, line, 1)) {
         return;
     }
 
-- 
2.43.0


