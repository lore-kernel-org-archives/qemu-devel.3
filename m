Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0613FC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2t6-0000rj-2R; Thu, 20 Feb 2025 04:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2sv-0000Zq-UT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:30:22 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2st-0003lA-CX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:30:21 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso1064016a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043818; x=1740648618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvVsiU9gHWUTHtLBaCZuBn83g9TL7f813w+LHlaQeOA=;
 b=TKvcOZhL1f2Ri8icb+KZTXIiYzEOWqglsWUVncYMVmyN1+ZoMhqMbxU+IchVkDOP4A
 gbkZTRtMO2qZPaTRDpWDyhx6TBL7fnRyafsIpIaZMX6xL0JKJqZtTpI9NMtXF8KbUtdI
 RBF5JxT+aNKEzoMyzbbGogl3c7hq63st4HVXDJuRMiWlYpjM8TvuzRJ/l0sF8g6yb7fn
 oPVy0MYgwP9VTm1RF29qUUsZc54YwVNH5SqiD3afcUketqu2ek1LfqV9stF7nT3dgXY8
 4bStXaNNbraoP6S5vpZvZY+ko9ujG4hhGcm5TOSSWiuuAXvl55CFW/RSVfVXrrRu7kct
 CSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043818; x=1740648618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvVsiU9gHWUTHtLBaCZuBn83g9TL7f813w+LHlaQeOA=;
 b=ku0qMN2eNPBc6CWidYSI+WBxFlBjnFdG4ku13fSYDajjuhtJLbrgn5mUtcN6+6i8L/
 Ahl8thLbOweyGce8UdfwppAb5VryfBE3NmPg2q3YEbFWyNK1tf6CxzhzBQGm5fms7geW
 yg6/zYPb0+CnBxvGbyeiy4n1rJ52EZElKpnYdQMdpHhWI+O2nAUolG/ZbI6YkultdTA7
 2ZLa8mvYCUfRDw55ceit+66LHRcbYxH9lR3EHpzidEb0Nnr/UKOhb9tZfycej5s3VLpk
 fxI1NM12LDFYKY4FN1Ty65CVpG2J1BQQnw3B1WG9QplKA34acdoWlyUPpxhV6QJ80wwE
 Qq8A==
X-Gm-Message-State: AOJu0YwEwGNuC5RwPtAZbNz0p3RVNsPK5AUYvL5BQ6AjY3uC/w13i93x
 2KiiZZiQa1zKTTvgPN75+9oBLMYBppz0IAETENZtNDEfGil80J8V+k6SZ071OzJpL/Lm5M70qoi
 dMI0=
X-Gm-Gg: ASbGnctY27/L/RSJaNHpIVtQCvFoen8v5DmMo52saWXOFb6Bef3zD5KE3vQrFmo/xUD
 1WSUPw1xJb87SNKkg7spIOxZkrWgwMRKU5A2JbHFOeUoXPpD/ly+VsnAgQEJv3i30SjLKXP5Eh6
 V/YumplQl7tR5Gv2Zc95Pk4ptufxuwAe8XVJ2Bwx0j8AGVnkhgSqCfurlG4wEkRIXE7sIhoiCob
 ghhpGpSXjOMFgQFpgipZXEkfjNHLlimAGhmqnsAEyuyVi1U7uqoZNZ4+jF3EG1mDeRkk1jfYqpM
 S+p+6QgNm8l4uRyt0xSb1Bs0w/4de5kJqLGlur1D/nnEcavu/oOoQ/+6WV0cO3O1Sg==
X-Google-Smtp-Source: AGHT+IHzI2BhsfiokxmBSO07mnhrE1lfDAUfHI43hrZrrWil5lel1nwpv/KfiUdjZbefthfEcx4r8A==
X-Received: by 2002:a17:90b:2e45:b0:2ee:cdea:ad91 with SMTP id
 98e67ed59e1d1-2fcb5a3681dmr11780241a91.15.1740043817688; 
 Thu, 20 Feb 2025 01:30:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c45sm15328183a91.2.2025.02.20.01.30.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:30:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 4/9] hw/char/pl011: Really use RX FIFO depth
Date: Thu, 20 Feb 2025 10:28:57 +0100
Message-ID: <20250220092903.3726-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102a.google.com
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
Reviewed-by: Luc Michel <luc.michel@amd.com>
---
 hw/char/pl011.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f7485e7c541..23a9db8c57c 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -489,7 +489,6 @@ static int pl011_can_receive(void *opaque)
     PL011State *s = (PL011State *)opaque;
     unsigned fifo_depth = pl011_get_fifo_depth(s);
     unsigned fifo_available = fifo_depth - s->read_count;
-    int r = fifo_available ? 1 : 0;
 
     if (!(s->cr & CR_UARTEN)) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -500,7 +499,8 @@ static int pl011_can_receive(void *opaque)
                       "PL011 receiving data on disabled RX UART\n");
     }
     trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
-    return r;
+
+    return fifo_available;
 }
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
@@ -515,7 +515,9 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
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


