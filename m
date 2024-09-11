Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A78EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIj-00043F-4f; Wed, 11 Sep 2024 08:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHt-0001AS-Gb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHi-0007Y8-O3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso23657985e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057036; x=1726661836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elIxjmyAyoAhIo/NQZzBwt7GxZ1ngMgFdcN/6EhC+o4=;
 b=apcW8j7tK0865PUwRZHVKy5EIEXlw7/Z5XL30l9QkMa4+pgelr6F1CheH9T+defV2x
 k0GEF6EprqXRLky2fezxFAXoKwewCefZiB0l07GSdO2lc/TeGra4jWJwomrYZDoCtk6N
 84CYZ5QpdmtxWyxib2qXrcqZVG9ChG1osAl5xhChulJlRKeNbhOvD4/AGPd0DM3Vzikm
 asMSM1tWNjWBST6U9etCNw2vw1OM389TlKcHXJ1/BK5Dx8IvcKoGfHvmQjtxVn8HAKoH
 i+WkMB670znhxKgD1l/AH85/VDs/Yi6uiiLDQCIC1t+rMbEdEwYb1clR0Y3ixehscuhJ
 Vbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057036; x=1726661836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elIxjmyAyoAhIo/NQZzBwt7GxZ1ngMgFdcN/6EhC+o4=;
 b=R1NN02j4e+G8MuBDhutHK/fHCZrg0sz+kJAvMkYsRf6nFbG3wsKFKdiSp31nzLmZBs
 /DOWhlgHHUzKgO0YlzZhNYAs9vS/CtiewMPUpDK0AlmYI5Gw3MHyNuATF0v98kgCgQir
 o0Uz6XYA/s0vkO4b0pnKOPHOdS6NMR+J9uegj/jpcd4RbB4IaWc1gishn51feXGZ9scS
 3UvPiGhVHt3Ktfp9bMJcC2QZHBJtJDFgDa12Nr2qK75uwUxiI4f9R8aX4TB47roRbVnX
 a/H62QTb5ZMRx3n6Y6dMGjqF2jsM+DjNIiuTc0zVxu5ON6OVlPusXL5E6wxhG6C/agbj
 iFZA==
X-Gm-Message-State: AOJu0YxA2OOvTDU2ueZV00ObHjjGW/oJFqmQufuecOHl4M+8K4vsyETS
 8GwlvK8g+sZjevZDKtaFW6IBy5Wb8fIJLueNbuwiLy909D5sq1BCvLicNqmX4jzVhj31Q4fOapw
 f
X-Google-Smtp-Source: AGHT+IHc2JN6uObN0/Ds3bRoq+HVesDzHtqpADNDo6JYTHFfr4CzReeLDxicV7Ah6/5hovp0rGMzNw==
X-Received: by 2002:a05:600c:1c06:b0:42c:ba0d:c766 with SMTP id
 5b1f17b1804b1-42cba0dca47mr60000335e9.6.1726057035589; 
 Wed, 11 Sep 2024 05:17:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc1375189sm52193145e9.1.2024.09.11.05.17.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 25/56] hw/char/pl011: Move pl011_loopback_enabled|tx() around
Date: Wed, 11 Sep 2024 14:13:50 +0200
Message-ID: <20240911121422.52585-26-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
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

We'll soon use pl011_loopback_enabled() and pl011_loopback_tx()
from functions defined before their declarations. In order to
avoid forward-declaring them, move them around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240719181041.49545-5-philmd@linaro.org>
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
2.45.2


