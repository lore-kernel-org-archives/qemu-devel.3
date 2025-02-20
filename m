Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D13AC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2sD-0008GQ-1E; Thu, 20 Feb 2025 04:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2sB-0008G2-0j
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:29:35 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2s9-0003Qp-FB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:29:34 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-221050f3f00so13053655ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043771; x=1740648571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvVgNJ/E5bcHmFtQhvSS1dYamLv2zmBpjT3Espofk2I=;
 b=O6vXiRKOLWTfNJ+gvtzjELWrXHwl8RkzwfAUZrVi50YrP1Nh3xTWYzdnKKCLi1hGyd
 +24imDDGtakOdjlrFy/g6J9KdecZFaGAK4k0m8cI01D7LZbkpHwxM6AEvVlcrQUJXTFC
 H60YQTK+9dnuJ8CtBrE9rqv8r5D6ENOIMABS1TThmmG2T6AN0fU23TB544v+DsRq4j7P
 lT5SWxMMNvDgZOXRyBtecqjrvBqcQr1fWLxAea3dH2PGF2IzTrnUFauSqVFvfyY6D1w7
 SJkiP1kAKFX0OtO+5+Y6L+MoyZmWDYWMegYzV3xpASHLgYIvGhg7+svR3ZHcq3K7eXKS
 71KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043771; x=1740648571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvVgNJ/E5bcHmFtQhvSS1dYamLv2zmBpjT3Espofk2I=;
 b=Bsm90OaBL5AwreAsFFkrHDpd/bnhISulzjjR3bTKzBM4t75xzMXGaqrnMeQ6FwOuM4
 ivALGom3qjv38iQ5WuuKR7c80nh53iwaMun6W8d1V0IyzJEAydvBHHaCg7LJxY3MXdyq
 fPPsxUgnVgD7ofj3zIpRj+L3mhnlXxPOa138sNlWtGLifypX9+t5zdNBdNC4TfmWiYpg
 AL4iQsR05bGD2DJA73UornK50PiiOz8/rZfv5sDhIM4vxYUgrw8cqVbbc0VFztGaUTyL
 aJjZiyA+JBclbJ2eRL0F/BH1v67CIV92wiVUCGUCG2utt8uJlurh0Yq1IY1EUTq7BS98
 Wehw==
X-Gm-Message-State: AOJu0YyJVZs+xD+Ooni7TXryq+iH9CtST2gHi/jzeqco4EmfygVGTez7
 EPBAkP6IZ0ILznh4lW53QGm0jrL2sPGB7t/n47PS4o+Y7HTO2VKyRF0cwWYHfWsO2ttoRbBCGFH
 d+eY=
X-Gm-Gg: ASbGncvlWjxONN5YlgWJoL7no3noHtmQT09BAc1bqsMByO5sxk6EicOAt4gM5/BOtgB
 HmjlLJN1gQs+01Z5JhmYD0LVt5zS/jTNsXTpR8UO9qNO8mlTUZD+mp94FLE8lo8h01+NjYOxho1
 xdA5FjB+zurKDa8x3VXWIgv0oZBpEzCfyhgbb77Vm3Ol4f2Ry1NQh1iQ+rVgdcUOhc2xX1jgtz1
 CSP4uhpB0IdgQrQ1AqRuhvyfQS0A2WltjBwmzTeg8Kwe7wgbSHv0OZWJK7kgP+9nUqHOswxKIfj
 ZD3ZQGyYiKdXxjBmWgFpVHOuss0Y8JoD6EKxvpXY+9n7+7w98u945qe7Q7TaLrZPvg==
X-Google-Smtp-Source: AGHT+IGz1/2rco9w0NsUMI3Bogl20f+NwzvY99BxTc3Zo+a38NqQzxwOJpfAGgW5KrZjoc4ZoRcQEA==
X-Received: by 2002:aa7:888e:0:b0:730:8d25:4c24 with SMTP id
 d2e1a72fcca58-7326179e908mr31597617b3a.10.1740043771021; 
 Thu, 20 Feb 2025 01:29:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73264729945sm10067375b3a.179.2025.02.20.01.29.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 01:29:30 -0800 (PST)
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
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/9] hw/char/pl011: Warn when using disabled receiver
Date: Thu, 20 Feb 2025 10:28:54 +0100
Message-ID: <20250220092903.3726-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x629.google.com
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

We shouldn't receive characters when the full UART or its
receiver is disabled. However we don't want to break the
possibly incomplete "my first bare metal assembly program"s,
so we choose to simply display a warning when this occurs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 06ce851044d..12a2d4bc7bd 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -85,6 +85,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_OUT1     (1 << 12)
 #define CR_RTS      (1 << 11)
 #define CR_DTR      (1 << 10)
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_LBE      (1 << 7)
 #define CR_UARTEN   (1 << 0)
@@ -487,6 +488,14 @@ static int pl011_can_receive(void *opaque)
     PL011State *s = (PL011State *)opaque;
     int r;
 
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 receiving data on disabled UART\n");
+    }
+    if (!(s->cr & CR_RXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 receiving data on disabled RX UART\n");
+    }
     r = s->read_count < pl011_get_fifo_depth(s);
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
-- 
2.47.1


