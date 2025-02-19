Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B7EC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrK0-0002O0-KN; Wed, 19 Feb 2025 16:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJy-0002Ju-7j
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJw-00009t-Df
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so1690335e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999367; x=1740604167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1M+9N1O1172KT1xmekfC3o1CG3P7IIUgC0GICjqwA8E=;
 b=BeIxtc6ATc0K8SxIJCBYczOFq43fkGrX8B9ZB4YEpCaTPt5NGuqlQpHAD/0r2qgAiW
 NOx/axiSfNdVgojvX0a7M0GRp4tGHaXgMdogoCpK3rcd0h5aJD028z3XaF8UoV4sxhFt
 RgR8xEoVdVqGtz7XpMLjVehmDic58QRlV+SHaeN/dLfqpGMdOgrjQ8S9hErQa3/W19NF
 3TIb8szCmngzzY6OeYqm36qi4xt3Z0N2FmBAbb+S4zA0qGIUHR3+jT22LJUEpAbOweq2
 i8SHdVKHtfPUkIDJQa4mGP6h4aYoxadyGteWq+xrOO0yBMtPCT+6RSVsh1fdnLMjWm9s
 /ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999367; x=1740604167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1M+9N1O1172KT1xmekfC3o1CG3P7IIUgC0GICjqwA8E=;
 b=ppsdpjqI8VJinnKLLiHPPmQGnMe/xkMEqT1t0JPoITcVItaIhchhLfA/mlBKgJqvDD
 Hncbps71vcWXRF45H+VdFz7BA6BTrqLLOAlE6Gv1iyud62+pIiqA6IyiLt950vlP4SVF
 a/2cu/di633WrogOHKIuups4ffDRyuHEzBTB9VxIyzT9MKH0JbE1leOYjiiRUa0roLo+
 sYpiW8vEVtkPBcHxzEvknmo87qA0avAzhWFqKps/Qxj/iz5/+uYqERoE28oaSkcnI4UP
 BPHz1eHQpXceJqhx0wD5JPyfOqmgPsr6CuU89cv6Rbew7oCuMADrsNKN06i4zNEz5Fxv
 twiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlckREoULmsVeiLVfCTRXqUlAqIgIbys4WP+2TCUhsSr0PW7Qq4oHZI8cjT8Lo4Y/v37sPPjuFxcmE@nongnu.org
X-Gm-Message-State: AOJu0Yw9cxdxBkep7R8BfB0AxXEVUTlAgYIfZkDwWM6MmAhtoEaQc19j
 wm8UdOgi1zgp1qPF4vbGU1qAJBx1lPEfb3n1lEeHDLI8yVLV0qKtmXV2Io2843A=
X-Gm-Gg: ASbGncvzjVHCj2pV3IJLXQl4GbPUzB4B9N/Op1JI9gT96AbDp5yrUWjPFIe3lloDr3T
 AtK65HJeWkepae9C2HqSUMh8amci39ZGSd4cgDtmXOyllloWMaZ2l7gW21YeiLTVfOTuEeb4VSh
 /KL1SXjuQAa8918nr33j8UlwomobWjBz9Q6Y6+ihuh/zHsBV7bGqC+d6JAbVNZKRYh/oigSxirA
 DC5/e4jrc2BltYRL/c0isGMv+/7ok08VZBEHlgnDQtPdKgJYkEmaJ7kflW8d0TMsvf5E3G5rj/6
 ELEqu/+CZb5biQveYq0s0XRT2cbUFxVxKwTmW/8NbLmKkZAoLysExDQYTdPbQRM06g==
X-Google-Smtp-Source: AGHT+IHgQjtyqw6XWw6SOlJ72y8SLFeZ4PIEzvT9q1McUWRWY3RDiPIVRF2x3LtvdBdqtutQZFDrLw==
X-Received: by 2002:a05:600c:458a:b0:439:3d5c:8bfb with SMTP id
 5b1f17b1804b1-43999dd11d6mr47685055e9.22.1739999366853; 
 Wed, 19 Feb 2025 13:09:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f208sm221457235e9.6.2025.02.19.13.09.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:09:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Luc Michel <luc.michel@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 8/9] hw/char/mcf_uart: Really use RX FIFO depth
Date: Wed, 19 Feb 2025 22:08:40 +0100
Message-ID: <20250219210841.94797-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

While we model a 4-elements RX FIFO since the PL011 model
was introduced in commit 20dcee94833 ("MCF5208 emulation"),
we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/mcf_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 95f269ee9b7..529c26be93a 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -281,14 +281,16 @@ static int mcf_uart_can_receive(void *opaque)
 {
     mcf_uart_state *s = (mcf_uart_state *)opaque;
 
-    return s->rx_enabled && (s->sr & MCF_UART_FFULL) == 0;
+    return s->rx_enabled ? FIFO_DEPTH - s->fifo_len : 0;
 }
 
 static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     mcf_uart_state *s = (mcf_uart_state *)opaque;
 
-    mcf_uart_push_byte(s, buf[0]);
+    for (int i = 0; i < size; i++) {
+        mcf_uart_push_byte(s, buf[i]);
+    }
 }
 
 static const MemoryRegionOps mcf_uart_ops = {
-- 
2.47.1


