Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C19C282E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWK-00056U-CP; Tue, 04 Mar 2025 20:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUY-0002Lo-Q1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUW-0007CF-5v
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so31789515e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137846; x=1741742646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsw3hWIwysJpMOxIWVwDgeawOr5AGtB31cvISbXkIjI=;
 b=gB4KeL70UwMnRFx/HECn5QdOBHUVajlYN85JrM9ATad4YwGRr2Lx96JJdiVPR8/WKH
 wCKm9aN+BNZy2Wcxh4DeFteC0HILmPqBjxOCBbOzHexqP/Xqc7AkHNj97aEl+yBE5paX
 bvakTqmql+nAxAbW7T7M4ronz3Rz1JLhiZENe0cnCdnhHdgupJxbNRTH6p5eEY1lcvDn
 G2T+xZA9g2V33VT11RkdlA6p44YpcXHOVLXN7x6Au/BD15oiKQQf1HDJgIOu5YgOdM2X
 m4g66MnLwIkM//PpngZsR0IxX/vuxNWNvJ/AFyzn/0hELOt3vPOg+6zNTtIC/whcRzML
 POTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137846; x=1741742646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsw3hWIwysJpMOxIWVwDgeawOr5AGtB31cvISbXkIjI=;
 b=Y0lPJyl35H7EPINLzHLPMsczGpyG2pA0zVCGZFt2Fc1G1RYveQXfgfK3UyA1VR9eZW
 bCoJcRnGbnTcEcU+JLfi35xVMIfxNq9IXmtb0FmdLwVYBiTzNz8RQjFzA3iARyYdTgVp
 DESp7LoQP65Kj1+BdkaWgZ0Qa5Vb8vLUZf/jq4hTeFG0Fzrfy1XxhAG4hXUuWtK0aj2j
 pJvZ49buDmVrwfhIBXk2W3gKs4YPSuRqWu7HaFpfarWTx4s5+V1+nAyIzFcEXHbRwi6b
 buvJtsT8dGbeNocnTYEtCGWwzhiCDaLst+aDqf9Imcb1VindG1cXSvGLftsyalYqhkcb
 RvLA==
X-Gm-Message-State: AOJu0YwRaXXWAowf3kNskItwY8s2Bq9vqbqbYEPFCYGhRVyrO8vVQMI6
 GdxRP+gC1y4XbwXhGZTDpVHzIzg++roBVK0Tj33nbsLW8rhX2pMrMUAwP1g45QTaMtul1DlrntL
 EfOM=
X-Gm-Gg: ASbGncv4pOqHbx2BGgyDLvVJPKqgf9sVDPLE0/+Wa4Yuobw1SgsXkl0F7+gFHZr69yv
 qx3yuJITx/sHxAoqvxpan6/utXnWUNBIkX8SVQ++N4oBwG2Mn8Ea1ZuWZbc4lA5iy0peJU7jP0m
 A+SJ8TOO1abAFGKOoHlGZ069a/HWFeXqgO0Vx3s37IafIML4Xxg4Mri3TbRXok/bILMaoQCjIwn
 9FZ60o1KwTRy4WZhw/zkE+MHgqKu0imgyMdbvEeecxZEEtOK+tgxzOL+MVkQgVyFUjisfmls8/N
 D0hR7pkkiQU3Hcd5QinUfHdyRY0qzj2t2+DHoCiE2nmRuHkJfq/+V90qopLNUs/RNt64mFrSOdB
 pNf+lJXlmEwt9zDXYY20=
X-Google-Smtp-Source: AGHT+IG9ZmacBlKb5ZVQcmDUs9qj5tagOwc/FyygnJ6KABY3skoFkrFA0rNRxJS1t2tQYkQMx+bXsw==
X-Received: by 2002:a7b:ce94:0:b0:43b:cf9c:700c with SMTP id
 5b1f17b1804b1-43bd29847ffmr8044605e9.16.1741137846353; 
 Tue, 04 Mar 2025 17:24:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c8050sm1989855e9.21.2025.03.04.17.24.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/41] hw/char/mcf_uart: Really use RX FIFO depth
Date: Wed,  5 Mar 2025 02:21:41 +0100
Message-ID: <20250305012157.96463-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

While we model a 4-elements RX FIFO since the MCF UART model
was introduced in commit 20dcee94833 ("MCF5208 emulation"),
we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250220092903.3726-9-philmd@linaro.org>
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


