Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C21C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs4b-0002Es-Sl; Fri, 19 Jul 2024 14:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4S-00029p-8k
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4P-0003l5-27
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:07 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3685afd0c56so760932f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412663; x=1722017463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pcbf3AvGHvD4fhRiEOLagM3LlfJ7dGGey9tdUSZ+O4Q=;
 b=mhKZhomJyM87Wnf33M27vaUvQnkhzXG5qTx9GbmHTTOxcPqxGmLBUQXkvtk0B6NwlB
 oEHREdYmApFHZt6UE5lriGCOuvZmxk8uL/tIP17jl1VCwFOh1UNgyhaHaPthbqDEhLSE
 Jkf2d9agKlW69TtapaqaAMjhxoLHs6L1uidVyfMFmWLs16tFKsEZbSsOMe/+voA31JRi
 SrQmdfsexzUwhnvgfdTriwCE9E3qOo1+MRxAXFSIZkQ5sEhxAhyCqnTb54YPNIk/SloC
 wXzZdD4dTenzZkk6ihcqeXpymQM2cIOcf9SYMWpvAVKwYuUYIleUqXCyehcGK8xg/Bev
 0ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412663; x=1722017463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcbf3AvGHvD4fhRiEOLagM3LlfJ7dGGey9tdUSZ+O4Q=;
 b=rpL7n6uxT58uesBHYs6lkJD3YTwbFLJcVMUByk8J4efcbm5zQ2b2PYiWEPsmsn+geG
 xL57cX9jYAEdyleEQ3m0zkC0QEgtMU02aIgq6F/qDlX6L05GWZ1k0J57MicFF7EJcVfb
 FmimhhbERAsJS3GX7v5zz+UZuNUnz2xDcZXVH9v7OG8P0MyfYmHy0zRlrFT1HJp2FiuD
 40xCFhK6qeLu37bLrwmH6W8mH907jrhsQEVqOFcU2xK3jqBX5ov2HdMFHI6LrzxvwdrF
 wZjbUB2evQL58fpoNG+qvAufyWo3KueQnWSMp5Y2BN6sitqUvxuY9qlkz2c4e3/RPR6U
 F8hw==
X-Gm-Message-State: AOJu0Yx6ZyMfLRa+mM7TWuJ8VWLpCKvIA4QNyDaGsSlIxU/CbcfkLYRE
 ek0ZviUZ7mLxpUg/tKwNYYQt4mpYdLyvOryZpAQ/BpnJM8zFLMTygan7MUv5JYDKefRQ5u/6PP2
 V
X-Google-Smtp-Source: AGHT+IHKGAtGplxlsw04A5Xyo5rKG4NyQ6nejAtmR2e06wwDRwmeAjWCa1URvp0UhWUd79dYwqRQjQ==
X-Received: by 2002:a5d:4cc4:0:b0:367:f054:7aba with SMTP id
 ffacd0b85a97d-3683175ce54mr5619270f8f.41.1721412663012; 
 Fri, 19 Jul 2024 11:11:03 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868420fsm2231578f8f.3.2024.07.19.11.11.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 03/16] hw/char/pl011: Move pl011_put_fifo() earlier
Date: Fri, 19 Jul 2024 20:10:28 +0200
Message-ID: <20240719181041.49545-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Avoid forward-declaring pl011_put_fifo() by moving it earlier.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 260f5fc0bc..edb5395fb8 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -159,6 +159,28 @@ static inline void pl011_reset_fifo(PL011State *s)
     s->flags |= PL011_FLAG_RXFE | PL011_FLAG_TXFE;
 }
 
+static void pl011_put_fifo(void *opaque, uint32_t value)
+{
+    PL011State *s = (PL011State *)opaque;
+    int slot;
+    unsigned pipe_depth;
+
+    pipe_depth = pl011_get_fifo_depth(s);
+    slot = (s->read_pos + s->read_count) & (pipe_depth - 1);
+    s->read_fifo[slot] = value;
+    s->read_count++;
+    s->flags &= ~PL011_FLAG_RXFE;
+    trace_pl011_put_fifo(value, s->read_count);
+    if (s->read_count == pipe_depth) {
+        trace_pl011_put_fifo_full();
+        s->flags |= PL011_FLAG_RXFF;
+    }
+    if (s->read_count == s->read_trigger) {
+        s->int_level |= INT_RX;
+        pl011_update(s);
+    }
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -314,8 +336,6 @@ static void pl011_loopback_mdmctrl(PL011State *s)
     pl011_update(s);
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value);
-
 static void pl011_loopback_tx(PL011State *s, uint32_t value)
 {
     if (!pl011_loopback_enabled(s)) {
@@ -440,28 +460,6 @@ static int pl011_can_receive(void *opaque)
     return r;
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value)
-{
-    PL011State *s = (PL011State *)opaque;
-    int slot;
-    unsigned pipe_depth;
-
-    pipe_depth = pl011_get_fifo_depth(s);
-    slot = (s->read_pos + s->read_count) & (pipe_depth - 1);
-    s->read_fifo[slot] = value;
-    s->read_count++;
-    s->flags &= ~PL011_FLAG_RXFE;
-    trace_pl011_put_fifo(value, s->read_count);
-    if (s->read_count == pipe_depth) {
-        trace_pl011_put_fifo_full();
-        s->flags |= PL011_FLAG_RXFF;
-    }
-    if (s->read_count == s->read_trigger) {
-        s->int_level |= INT_RX;
-        pl011_update(s);
-    }
-}
-
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
     /*
-- 
2.41.0


