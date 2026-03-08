Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB29EEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMmR-0006H6-9p; Sun, 08 Mar 2026 18:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmH-00062l-RZ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmE-0003j8-Ig
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so17238655e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009548; x=1773614348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v7GyfBp3Wi3fm2ZsMpcG7W6DRqITpDr3CQqKgZBHl2M=;
 b=OudZd6VkGyUKZ0b0G8Vb4nKjnWgc9Ux8LGtcZQ46vKxDRjK3VxO73feRf2J/jcPlsT
 dbLdR9KpuZP3QvthaJzOg4zii+thgj2Mu0lMd7fZEmkQftPmLy9oeRNZQ22SaZ6Noyal
 /WVnwciu+DyrKQ6s3ZI7BzQ/5t5Vir2teBpZ5bAXDspmFtpyvP715/TeDeF4ra/KUjMF
 zkoFBT2dqgJ+C4gvkk0NlXouK0TsS4uPLMep3C0f1ffQMoeJNGk0md9yldXnBCA3tS08
 oYJ+TJD0uJ5TDNK8ldx4G2VS3FQrYEcKsBuimlQEqyvbIWwQK1JYezFRvx8xojDArWKk
 n0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009548; x=1773614348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v7GyfBp3Wi3fm2ZsMpcG7W6DRqITpDr3CQqKgZBHl2M=;
 b=q0FA96vq3V2Wwdkmdsu7hVHppnEzyFW45AjU7v3ulT4ej4QIfe1oSL1rAJ194MGlP/
 eBIwoI4AwkWhyJmezlBKDRfhSAI6bpjZJJCwgOSRgJ/MVGUp+cl5YcOr/sFkopbGSnzJ
 g9+RDJTXx56PbzOuNrCX61a7d/VylEOEMyon5vs+NhqXebV3yx6Uc9POl6hw/S2N6nm+
 9h9QS8ilcd3iYKWiKwPOlWS6YMvwMYgJl1e/i34JwXa3S2Og13QEIgvzY2pxraHXhoGr
 19OBrLolsUeC0mX5mfcN8ZB253lrjfeR9ydCWee/0n9X5wjZQa7nUZRtS7Lageq2CVNa
 t3bQ==
X-Gm-Message-State: AOJu0YymnI+tyv7Ota35vUzZecgi2LQTjKYzcNxj6YkQgBn5CS6OCCPD
 cnunuqQYDWu7uHgZCmL0dqcGSpPU0aKzLwN3xWMOCTCBDfOmBi4i0Tj7HbTK9a2Pe10HgSb3s0E
 KvdQ3Xwo=
X-Gm-Gg: ATEYQzxL27SN4yP8PPq2g5huHkKSvgun9wzDz8JFshNX7HuUHIPtUj98QJ+Wx3mdgZx
 hVXbkeKXXof7UtHRj0k2MC6j1RwvPawY2EHlgTPEN6bgy/5efSFoNHH4kL4PYtRI0p8hSsFmB1f
 +hHgdPcrWBog5WZHy+btbeM/KjXQi1GrTEt+aBpepukuJgUL8ky8p6r+Wwz/QqNy2tHKsLspYRb
 ZqIREthz9r6sBbEQ0gY7pyQyFT1Z9lCjnE2/hfEkNk5hmnl3PBVFxwkL1GOplXLxB9vW5nR0mBE
 KL3SXp/dhVRzAU7NCdUJZm+3EU8TPzLXSMGGBSER243sBb9G8W0/VnPOuKBSXP01JQYBYtgszk/
 eLtLDtCgkIhTk8Xq4tRdKutcWUxSjXrtw0PcnyZzyDRU1KuuWRM3BenwKAzKMkj7RaSuboP9mU9
 aMaHfl6tgGO8hi+FUW2a/x7X8YjtWeoWLnxu0p0seHQtedg6JPkD2eqIku2qLDl05zi83CZM/VJ
 MKPIg==
X-Received: by 2002:a05:600c:620c:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-4853cf3111bmr4424425e9.2.1773009548503; 
 Sun, 08 Mar 2026 15:39:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852e38c013sm282928305e9.8.2026.03.08.15.39.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/49] hw/char/serial: Remove redundant reset
Date: Sun,  8 Mar 2026 23:34:24 +0100
Message-ID: <20260308223433.25503-41-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

There is no need to invoke the reset method in realize since the reset
framework will do so anyway before the machine starts.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260305220911.131508-11-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 485b98f03ff..0f3469a1e8f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -934,7 +934,6 @@ static void serial_realize(DeviceState *dev, Error **errp)
                              serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
-    serial_reset(s);
 }
 
 static void serial_unrealize(DeviceState *dev)
-- 
2.53.0


