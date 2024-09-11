Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC08AEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJj-0000ij-Pl; Wed, 11 Sep 2024 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHu-0001Fo-UB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHn-0007YS-Nf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so5962214f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057042; x=1726661842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNwBUYcUVU1y0Bv9EZ1zPpKAjm6wshMLuOdapkK29TA=;
 b=Hb5yUF6QOavms4ZyYKtF7GQvFclaVEiRrajADqRVZzepTm4GOMgr635MD25jPKeB13
 AzHSiY7uEEjKp2ulFFFyrdOojB5RWz7rWubltbOsOQECLlI6wxe60QvWeu/MB9qSQGaK
 DEPerup0Oo8fTHHrGpTuVnyOBzC/FKrNT5ljQ4ZsDV+E37vcvVZSKHHlwpGQEpsxd7Aw
 FeSPPYnl1AQZN3SGMgW7KGBESrg9JrhI8+cuv4Zw0CLeRPmIuYnoUyndGU5J5p42DeWe
 KsjSwdDVNqIzpKOBG+ef3H6nFrXyYks8WxHRltma0p9eNIdzhB6taEH3V8Nwc0bnOx9l
 Nz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057042; x=1726661842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNwBUYcUVU1y0Bv9EZ1zPpKAjm6wshMLuOdapkK29TA=;
 b=aTyLR/di61fTjmF8dUrb5qVUPM2vmKwXOMjNEC+OINRTIHTN6KhmMPsH8SWFBTMjch
 Bfzg7OZAMISDgS9TvzeBzgHYD3mrDFWmsujzLtAeaIahd2eoFPql7+aML+UW1DjfpaFR
 z+WvRnvjPvhJeX4vE+3JG1wdib6veAdx8Dof+QUd8Rj7esWKAtgdjDi9PAptFysP1DhG
 aPhxjy5XBLYK/qPfgxukfIio61i2aBzCR/LNQp9Vkjj9siUbWQvh726HSV2iCjOzMOjP
 qvqh7ljat/+v90lv06s9Ujyxm9GDptf97Nb95aGY+WF6XwBMJGLS0z5/amIVwjjTM3hu
 nxKQ==
X-Gm-Message-State: AOJu0Yxo1atMGbQtLydUK/jXHRN3CvC1buqcND/6rF/12pOh2NtAZm1W
 IPZHtf3TqSHSR5a1D5H+zalra+VckRFoQWHBE2diLOqQcKOw3RxLIlnzX+6Vx2VmfaSiSrtaiGM
 2
X-Google-Smtp-Source: AGHT+IEc4MkNI3BBdLfijH7VXlkaKenkXNtS5GfXMjoofQvRIo3w2tvsxiNLKXdE9T5eioZj52Zifg==
X-Received: by 2002:adf:f850:0:b0:374:bf18:6092 with SMTP id
 ffacd0b85a97d-3789243fd5bmr11325206f8f.38.1726057041662; 
 Wed, 11 Sep 2024 05:17:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d372dsm11439657f8f.73.2024.09.11.05.17.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/56] hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
Date: Wed, 11 Sep 2024 14:13:51 +0200
Message-ID: <20240911121422.52585-27-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

To be able to reset the RX or TX FIFO separately,
split pl011_reset_fifo() in two.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240719181041.49545-6-philmd@linaro.org>
---
 hw/char/pl011.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 22195ead7b..3d294c3b52 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -154,14 +154,21 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
     return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
 }
 
-static inline void pl011_reset_fifo(PL011State *s)
+static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
     s->read_pos = 0;
 
     /* Reset FIFO flags */
-    s->flags &= ~(PL011_FLAG_RXFF | PL011_FLAG_TXFF);
-    s->flags |= PL011_FLAG_RXFE | PL011_FLAG_TXFE;
+    s->flags &= ~PL011_FLAG_RXFF;
+    s->flags |= PL011_FLAG_RXFE;
+}
+
+static inline void pl011_reset_tx_fifo(PL011State *s)
+{
+    /* Reset FIFO flags */
+    s->flags &= ~PL011_FLAG_TXFF;
+    s->flags |= PL011_FLAG_TXFE;
 }
 
 static void pl011_put_fifo(void *opaque, uint32_t value)
@@ -410,7 +417,8 @@ static void pl011_write(void *opaque, hwaddr offset,
     case 11: /* UARTLCR_H */
         /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & LCR_FEN) {
-            pl011_reset_fifo(s);
+            pl011_reset_rx_fifo(s);
+            pl011_reset_tx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
             int break_enable = value & LCR_BRK;
@@ -619,7 +627,8 @@ static void pl011_reset(DeviceState *dev)
     s->ifl = 0x12;
     s->cr = 0x300;
     s->flags = 0;
-    pl011_reset_fifo(s);
+    pl011_reset_rx_fifo(s);
+    pl011_reset_tx_fifo(s);
 }
 
 static void pl011_class_init(ObjectClass *oc, void *data)
-- 
2.45.2


