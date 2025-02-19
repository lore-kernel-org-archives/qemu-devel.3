Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40511C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJg-00020T-Bn; Wed, 19 Feb 2025 16:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJd-0001wV-84
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:09 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJb-00004u-Dl
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:08 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f2cb1ba55so182299f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999346; x=1740604146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSZGsSKza9FznsLK+BKXxumGhe4yyrC/EclHmT2ykjo=;
 b=S4cwFKccf3iM87a3oolHfT9KUL99dAyHKSV7Ulpl4G33Fzpnfno7J7RRqcg6g47QkD
 Dq1oxFfcFtoHUuze45ndyTq1JfETrIA/TG4zsoEsT4z6BYY2qbcPjFl2umpKoGo6JMgv
 iv5frpGcAlJFN7KdmsEYLDYXzRbo0SyVnjSi7NSZNKy3uGO3IK0E4kbycqzr1bIj+R8b
 nSbvXoJNEJbxt6BqAlsMU3sIzlvNqOx+GFH/kHTXAsaVHgiDIxgL4t4DpnOyCpsF5quz
 zlWbh5YiHa/8FMXCtOd6T4dGwCSIvRFCfVOBNlSFwxvQPfbFcf6XuyPEnw0UYnQILhXU
 acZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999346; x=1740604146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSZGsSKza9FznsLK+BKXxumGhe4yyrC/EclHmT2ykjo=;
 b=n7IoA0UieiCrHA6WUG83G+LcKUJQPGIahn5ggUmaH7QZM+/qlevv/9YHIJymJuBblo
 Pf1rUIARWRRSaMwwatHYBlI8nAeuJmfHZesXkP+94HkliieRjmzXeueEh9ifYPxq7JPi
 4ms46d7bDhZo8Y4W1QPc4dAHybHVst6jtwM23LsVYBXyB67Lz8pDbNr7xYbOpurdk/KN
 MQ2kuPRdrPvgCDHX1UqXXkZYIYgaIzTZhUs0Nradzx9cVbqzYBSL8tW3QpHPC2kjxFKv
 +x9T/YwfxrLNpUJhTcplttEiu/ac/mKlKEyZAisv7Rb/7KHF9LEfgrUH0NOOrYCWGQyP
 iTuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVJW0CrqdZlFFpDVWdrMrubdAbKj98bI7kXc5JlvPI+MPlpmItW7F2czRAxWC97Q00kohE4Avi60p5@nongnu.org
X-Gm-Message-State: AOJu0Yy8O9kKEzPCkRoDrQuQOsTBuvwbLpImpDOvjesQu3iB4b3CBk8T
 nvYCWU52AJInHTNT4UNCdfSgZBVlXzasMS2s4dHF0R9UwDaPdSivazlmb6ObrQ4=
X-Gm-Gg: ASbGnctxkov9LsslKXgdR5ADK6XcG79VQREv+7uGZhGUgpuq47mfL9zKd1RjYdNptlz
 3CsZY0X8XWPocmAiZUVxZe+Ig3/KwPGZXsTBN0fMShOqgD1wCSuQ5ErdZ06sQdd2eoFggAVVSPl
 NB1pFL5Wl+BZvDbDPNlQpUseidcLg7b9Mi7p8YN3+tOOjiTo/LMybeEwUFrKdwh3omdaQjBO73e
 wi/llq/AvtUo6G3qPWhJ/A71E+ctHt8UzVskAPRYq8TuytpOVGOarfC+uGMO5PZkUvwP4e1mZ5J
 RdyacKxqi6ogadOnZAhQiKgFDcqPl9GH89CiN7TMOYD5CKaTS7OCLhYjhZVmFtDjVg==
X-Google-Smtp-Source: AGHT+IH8vWve1zzP4GhRmEIzBXAdPoQ6GxQ483+xddSgCnCPWr2rFU7i87czS1ardmTIRDJw8prvFA==
X-Received: by 2002:a05:6000:196b:b0:38a:8ec6:f46f with SMTP id
 ffacd0b85a97d-38f587f184cmr4267743f8f.53.1739999345774; 
 Wed, 19 Feb 2025 13:09:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43992ad82cfsm64238765e9.37.2025.02.19.13.09.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:09:04 -0800 (PST)
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
Subject: [PATCH 4/9] hw/char/pl011: Really use RX FIFO depth
Date: Wed, 19 Feb 2025 22:08:36 +0100
Message-ID: <20250219210841.94797-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

While we model a 16-elements RX FIFO since the PL011 model was
introduced in commit cdbdb648b7c ("ARM Versatile Platform Baseboard
emulation"), we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Example of FIFO better used by enabling the pl011 tracing events
and running the tests/functional/test_aarch64_virt.py tests:

  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_receive recv 5 chars
  pl011_fifo_rx_put RX FIFO push char [0x72] 1/16 depth used
  pl011_irq_state irq state 1
  pl011_fifo_rx_put RX FIFO push char [0x6f] 2/16 depth used
  pl011_fifo_rx_put RX FIFO push char [0x6f] 3/16 depth used
  pl011_fifo_rx_put RX FIFO push char [0x74] 4/16 depth used
  pl011_fifo_rx_put RX FIFO push char [0x0d] 5/16 depth used
  pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
  pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
  pl011_write addr 0x038 value 0x00000050 reg IMSC
  pl011_irq_state irq state 1
  pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
  pl011_read addr 0x03c value 0x00000030 reg RIS
  pl011_write addr 0x044 value 0x00000000 reg ICR
  pl011_irq_state irq state 1
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 4/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x00000072 reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 4/16, can_receive 12 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 3/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x0000006f reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 3/16, can_receive 13 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 2/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x0000006f reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 2/16, can_receive 14 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 1/16
  pl011_irq_state irq state 1
  pl011_read addr 0x000 value 0x00000074 reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 1/16, can_receive 15 chars
  pl011_read addr 0x018 value 0x00000080 reg FR
  pl011_read_fifo RX FIFO read, used 0/16
  pl011_irq_state irq state 0
  pl011_read addr 0x000 value 0x0000000d reg DR
  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_read addr 0x018 value 0x00000090 reg FR
  pl011_read addr 0x03c value 0x00000020 reg RIS
  pl011_write addr 0x038 value 0x00000050 reg IMSC
  pl011_irq_state irq state 0
  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
  pl011_read addr 0x018 value 0x00000090 reg FR
  pl011_write addr 0x000 value 0x00000072 reg DR

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 148a7d0dc60..57d293d1e3a 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -489,7 +489,6 @@ static int pl011_can_receive(void *opaque)
     PL011State *s = (PL011State *)opaque;
     unsigned fifo_depth = pl011_get_fifo_depth(s);
     unsigned fifo_available = fifo_depth - s->read_count;
-    int r = fifo_available ? 1 : 0;
 
     if (!(s->cr & CR_UARTEN)) {
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled UART\n");
@@ -498,7 +497,8 @@ static int pl011_can_receive(void *opaque)
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled TX UART\n");
     }
     trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
-    return r;
+
+    return fifo_available;
 }
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
@@ -513,7 +513,9 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
         return;
     }
 
-    pl011_fifo_rx_put(opaque, *buf);
+    for (int i = 0; i < size; i++) {
+        pl011_fifo_rx_put(opaque, buf[i]);
+    }
 }
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
-- 
2.47.1


