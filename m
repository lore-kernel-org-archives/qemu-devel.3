Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E1AC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrK6-0002Xu-BS; Wed, 19 Feb 2025 16:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrK4-0002Ul-62
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrK2-0000Af-07
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439a2780b44so1228625e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999372; x=1740604172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnXac85husRSdcAW6ArahXIi1CSZu6CjUp+G23JJFB0=;
 b=pDCbVahvKOj9yytNBiDMrAtCcJzffY2jZUHwMkL8A0h8mPJFyz/6QQ8TuB554Ah61N
 YOnr65K5xq6nAejL6P1FPan+K2pPBCagRy/l1TPo997KsiAC9MJFkmLHkyu2vpyQ9gJ2
 PV6/cgSZTc6Kio/k/BP4F/lxnF2Bc0MbPjIxDrwEb5RDgfKplqPkQf6tfaWNrI4o5Lbd
 CEI1hlzMLbiYp/3OfMtmLQ2YPPHLk3S7AsiCybsNWmatjMPAM3qPv4Ixzi1+9DM0Pifx
 A5bitkLiJRvM0sk7NXpDJ12QI3PAUfLHbb4K92ZkasEtJcyTPaYAZ3Ajrk1Ipxltarre
 IFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999372; x=1740604172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnXac85husRSdcAW6ArahXIi1CSZu6CjUp+G23JJFB0=;
 b=ij06o85rx/iS1o4t/m+u7+XJmD3FcZuNK4PudoXO850aKcUr6DlBDutVNqWPbeV5cU
 UT20uUlA6h9n8DkxgAVqMu4/hAq2kbqQ2tbbxgQF4Fd/TRINw3wGDuofeERg6VA1oRBW
 0umUlzcN6oxvMfls5gNNVtt6w/xUDv7hD6dOC3zxgy3bRwU1YJi13lB8XS6BkuD2jLFp
 eGUgMV9I2HE3iO0W0QH3goyUga+nR8zi31SI0+5tgiX23UECRG3X5uW1x40CqM9Fn5Ly
 JRZQ+Jt8ajmVtQLrAJjVrVSpqGOI5uNBUYqZZmXSj2fNbD/f18aCkAxInLKzCP45ocaq
 TWIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnDpJPF3Vs/dzFyaqic95/7dspiAzKvEp5zj2zYVv0SfJBwZG4Mn4rgatg06KpPKYaGBq5e58IFw8z@nongnu.org
X-Gm-Message-State: AOJu0Yw6HX1bpmyNpGnQX37JNg53sVvrXIuBOeQPHL3zmexRJRpMkUCL
 ktIHE8bt5PiF2RJW5AGeYpYsLpARBs6hAPyx58iPLosv9tQERvUkSbZ01i8Z2q8=
X-Gm-Gg: ASbGncsHFO+pivqddUC3L7a0ly7dR9tUib4MJEWt/NoVdk/oIUEkwGnHNuYFWBICRm3
 NXi4CtS7GzWw3wvJSX0HTEOV25q3Okj0v1r3BLG9pr04i4TPYhbLyARriiwcoZpN6OyN/jV9zWT
 vHmwXDdLNRlRGpZq1E6bAXHikvyN5oa1enZvzzc9ZNPEaXgSFHsNmIMQfokjelFXddm9/FqsQ+w
 QOY6cTCrNQ0fEqPMoLGjiyPaP6QKcFie2BTRdy8j8wJdAHqCxu1ZtMFW345yGS3Jg3BDfEpCCgU
 +TiUvkYUTt0RAk1qa9jEsd0gq0LkwPzdhbfZhm1RxC1/BT0705JWPmFzKNBWd/uZvw==
X-Google-Smtp-Source: AGHT+IE4Byg70J4EWT04Rr2EIOcLaDr6jugN8hJq25PFZ4HSMwrAbXNiUeRQpkmbDJFI9DGkfshlOg==
X-Received: by 2002:a05:600c:3b26:b0:439:31e0:d9a5 with SMTP id
 5b1f17b1804b1-43999dd1e1cmr44430935e9.22.1739999371753; 
 Wed, 19 Feb 2025 13:09:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439a0cc11c6sm13165315e9.16.2025.02.19.13.09.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:09:31 -0800 (PST)
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
Subject: [PATCH 9/9] hw/char/sh_serial: Return correct number of empty RX FIFO
 elements
Date: Wed, 19 Feb 2025 22:08:41 +0100
Message-ID: <20250219210841.94797-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

In the IOCanReadHandler sh_serial_can_receive(), if the Serial
Control Register 'Receive Enable' bit is set (bit 4), then we
returns a size of (1 << 4) which happens to be equal to 16,
so effectively SH_RX_FIFO_LENGTH.

The IOReadHandler, sh_serial_receive1() takes care to receive
multiple chars, but if the FIFO is partly filled, we only process
the number of free slots in the FIFO, discarding the other chars!

Fix by returning how many elements the FIFO can queue in the
IOCanReadHandler, so we don't have to process more than that in
the IOReadHandler, thus not discarding anything.

Remove the now unnecessary check on 's->rx_cnt < SH_RX_FIFO_LENGTH'
in IOReadHandler, reducing the block indentation.

Fixes: 63242a007a1 ("SH4: Serial controller improvement")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/sh_serial.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 247aeb071ac..41c8175a638 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -320,7 +320,7 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
 
 static int sh_serial_can_receive(SHSerialState *s)
 {
-    return s->scr & (1 << 4);
+    return s->scr & (1 << 4) ? SH_RX_FIFO_LENGTH - s->rx_head : 0;
 }
 
 static void sh_serial_receive_break(SHSerialState *s)
@@ -353,22 +353,20 @@ static void sh_serial_receive1(void *opaque, const uint8_t *buf, int size)
     if (s->feat & SH_SERIAL_FEAT_SCIF) {
         int i;
         for (i = 0; i < size; i++) {
-            if (s->rx_cnt < SH_RX_FIFO_LENGTH) {
-                s->rx_fifo[s->rx_head++] = buf[i];
-                if (s->rx_head == SH_RX_FIFO_LENGTH) {
-                    s->rx_head = 0;
-                }
-                s->rx_cnt++;
-                if (s->rx_cnt >= s->rtrg) {
-                    s->flags |= SH_SERIAL_FLAG_RDF;
-                    if (s->scr & (1 << 6) && s->rxi) {
-                        timer_del(&s->fifo_timeout_timer);
-                        qemu_set_irq(s->rxi, 1);
-                    }
-                } else {
-                    timer_mod(&s->fifo_timeout_timer,
-                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
+            s->rx_fifo[s->rx_head++] = buf[i];
+            if (s->rx_head == SH_RX_FIFO_LENGTH) {
+                s->rx_head = 0;
+            }
+            s->rx_cnt++;
+            if (s->rx_cnt >= s->rtrg) {
+                s->flags |= SH_SERIAL_FLAG_RDF;
+                if (s->scr & (1 << 6) && s->rxi) {
+                    timer_del(&s->fifo_timeout_timer);
+                    qemu_set_irq(s->rxi, 1);
                 }
+            } else {
+                timer_mod(&s->fifo_timeout_timer,
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
             }
         }
     } else {
-- 
2.47.1


