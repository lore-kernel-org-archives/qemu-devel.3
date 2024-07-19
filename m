Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278ADC3DA7E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs4n-0002bu-P1; Fri, 19 Jul 2024 14:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4b-0002GE-WB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4Y-0003nu-DQ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so16418445e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412669; x=1722017469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKEyUF5vAQXhfPoZ9bEoVMEJKlfitjNK1zaxUdDv/iQ=;
 b=K+xj+DNn+cLdbOJg2lsW1RNdGSbc2+LzGrWNlsg+GVp3iTOknM7bX3ktPnQ/oadrdI
 vpMhCfL9tpyETxVcsEpjm94mPO6fnLfPguYYf4Nw5FL1XRrw4+7Sy25oh/5L3csN0JKj
 p/r7UYS/ZKtt7n9NyGlafq815UviiokuLJhoEGks0Q8pifEAXz0ZU0vHAJn/VkkOQpXb
 wozv0c4ZXB3hUyHSC30hzSzDiE7K2wkeYo5IhpNCygwwtSacwpWmbU1UYTnnQy8i81ks
 PnG0UaKqqd5ovW5hBpOicppQut2NRsmlBvq6fAOmQc2JeeczIVru2z6T0An2s/HEKnur
 UK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412669; x=1722017469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKEyUF5vAQXhfPoZ9bEoVMEJKlfitjNK1zaxUdDv/iQ=;
 b=YR8h+ElBJraR/Dq4wnRbBCMUAESw5zlnjn2yI0hzMgIy0vTymccNbn9MOAoKSc/CWo
 Wwk2hdV7UwyTC+TgBrbvTQ6YYasezD+ERklHoHzbROiagaXUfIUhK17t7idL72dH1W1B
 qu4e2OHs5jOWzn0UBKBXupQJhdn9XRd1Kl1W3J/pgk770dmF8fAWR1A0TtG+gZDgN1CK
 fpceKoNmhbnlatKP+6inR1sxHCkoRFS7Srqp8UXDZ2Zy9OYKPz9kGqV1qHLBcA9fjyXM
 qmP1nOSyrpDMZaGkvtwy5CuD3AF+zCdpBxOF/fRQ3Awr6IfPziB4V+zgiQnmWLKNIbbU
 Z0qA==
X-Gm-Message-State: AOJu0YzQgNpXKS6uuymPX6XnURSCemhlrEgybzI1LLtR5FLMD/yQkk3u
 8mbMuzUs1Wfnbc77jdRXtEQMXrw8KCOCI3Lxtu24h4bB/jkn+FdArMQRHCUCkFTUCGcP4VkEvgJ
 9
X-Google-Smtp-Source: AGHT+IHyINAIOVHPFb5Xhz+3TG7BuvPnB2fxoM9BRSAld2ZTy5lvo3sJctcadYjTj6qh6JVt9fe1yw==
X-Received: by 2002:a05:600c:3b8f:b0:426:5520:b835 with SMTP id
 5b1f17b1804b1-427c2cacf1emr61880365e9.5.1721412668901; 
 Fri, 19 Jul 2024 11:11:08 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d7263687sm29524065e9.4.2024.07.19.11.11.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 04/16] hw/char/pl011: Move pl011_loopback_enabled|tx()
 around
Date: Fri, 19 Jul 2024 20:10:29 +0200
Message-ID: <20240719181041.49545-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We'll soon use pl011_loopback_enabled() and pl011_loopback_tx()
from functions defined before their declarations. In order to
avoid forward-declaring them, move them around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 66 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index edb5395fb8..22195ead7b 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -138,6 +138,11 @@ static void pl011_update(PL011State *s)
     }
 }
 
+static bool pl011_loopback_enabled(PL011State *s)
+{
+    return !!(s->cr & CR_LBE);
+}
+
 static bool pl011_is_fifo_enabled(PL011State *s)
 {
     return (s->lcr & LCR_FEN) != 0;
@@ -181,6 +186,34 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
     }
 }
 
+static void pl011_loopback_tx(PL011State *s, uint32_t value)
+{
+    if (!pl011_loopback_enabled(s)) {
+        return;
+    }
+
+    /*
+     * Caveat:
+     *
+     * In real hardware, TX loopback happens at the serial-bit level
+     * and then reassembled by the RX logics back into bytes and placed
+     * into the RX fifo. That is, loopback happens after TX fifo.
+     *
+     * Because the real hardware TX fifo is time-drained at the frame
+     * rate governed by the configured serial format, some loopback
+     * bytes in TX fifo may still be able to get into the RX fifo
+     * that could be full at times while being drained at software
+     * pace.
+     *
+     * In such scenario, the RX draining pace is the major factor
+     * deciding which loopback bytes get into the RX fifo, unless
+     * hardware flow-control is enabled.
+     *
+     * For simplicity, the above described is not emulated.
+     */
+    pl011_put_fifo(s, value);
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -290,11 +323,6 @@ static void pl011_trace_baudrate_change(const PL011State *s)
                                 s->ibrd, s->fbrd);
 }
 
-static bool pl011_loopback_enabled(PL011State *s)
-{
-    return !!(s->cr & CR_LBE);
-}
-
 static void pl011_loopback_mdmctrl(PL011State *s)
 {
     uint32_t cr, fr, il;
@@ -336,34 +364,6 @@ static void pl011_loopback_mdmctrl(PL011State *s)
     pl011_update(s);
 }
 
-static void pl011_loopback_tx(PL011State *s, uint32_t value)
-{
-    if (!pl011_loopback_enabled(s)) {
-        return;
-    }
-
-    /*
-     * Caveat:
-     *
-     * In real hardware, TX loopback happens at the serial-bit level
-     * and then reassembled by the RX logics back into bytes and placed
-     * into the RX fifo. That is, loopback happens after TX fifo.
-     *
-     * Because the real hardware TX fifo is time-drained at the frame
-     * rate governed by the configured serial format, some loopback
-     * bytes in TX fifo may still be able to get into the RX fifo
-     * that could be full at times while being drained at software
-     * pace.
-     *
-     * In such scenario, the RX draining pace is the major factor
-     * deciding which loopback bytes get into the RX fifo, unless
-     * hardware flow-control is enabled.
-     *
-     * For simplicity, the above described is not emulated.
-     */
-    pl011_put_fifo(s, value);
-}
-
 static void pl011_loopback_break(PL011State *s, int brk_enable)
 {
     if (brk_enable) {
-- 
2.41.0


