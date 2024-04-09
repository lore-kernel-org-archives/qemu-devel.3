Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF0DC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBhE-0007Lc-Ao; Tue, 09 Apr 2024 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgX-0006Ah-KT
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:54 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgR-0008FV-Sq
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:46 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d8b194341eso4265381fa.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669921; x=1713274721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWebOFnaO2YfqkM2Zqjj72nsNguBU6W//GqzHg4t0x0=;
 b=Qmf28Bqt9/Lk8VbUT/Uc313cTBuk3nl4lQP5KX8ZeS8GuAWTX2MbYz9C9XPSO4O1fF
 I77tuA9SO39o+EDBWIOhWNAgMVHe24e+xckBxIjBA4nBXBAYlmuPJpPbwUgmEGKlrzcJ
 G+UKytPg3lxUkcbdbDaR1r9HLiXABHva30zAQn7oWA0uu3vVuJKMXDKW3HuiOH3Dkk/5
 tOhJT8LHescq/62o/EanEkYKghAPApMIjBMe3/1HNW6EDmND9hnM57KbmKRnYQn7QWD8
 v2yjfdHMHYzUpfZsH4G4RWuj72D+b6mgKx2JF6CnH4hy9FYjCHG0n2i47lIv93BTa6CV
 U+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669921; x=1713274721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWebOFnaO2YfqkM2Zqjj72nsNguBU6W//GqzHg4t0x0=;
 b=RXqqVXEP0dMmbbtPuq8Jyn+AXpxx+65JIORJei8SmnVfT3g8iZjsRBJZDsSGD5fcVi
 LWhu5w+7pKHjAZxxos/Vr/46XBf7IRHAyEqGH358EsJZU6/baI1dzIXT+Yi/JIp3FIs/
 o7FOEt2ELR5xQckYgwryAfOqC+uf/o0qWfKvhiAaEejIe2iS19BFbTcEHZeFJ+rY0ICt
 DFLZLL7bDdSHVVTfJV9pFmdEgDVpN8D/6mTXKb92KRCn9DnkhcW688z3xoT5vE9f0vKf
 ApLOvdjbiHCjW6L6x8xdqld/gFJlV3cgZQrT+F8K7pIAbnpDLNVOhqyVpJzBuCkXw2xG
 E2yQ==
X-Gm-Message-State: AOJu0YxxRqzdbGwjcNzMAXsXOIsfFjM5XEPy/QB9vIc1g7xK8GVPOTvr
 tDSjcJQTnTKsWYEJ5EbeLwlUfJg9MOpUG1bJBb+RpqaVZpjHJwA8oAnZa0Eakg1rkk6RmasAlkH
 E
X-Google-Smtp-Source: AGHT+IH4G2ntijOoEIJR8CTEkeuHXC9H2zW1m+FdRHjMT5LRXs4HGgpqB5a7S0q9RTm5ovblVUgtOQ==
X-Received: by 2002:a05:651c:794:b0:2d8:67ee:2a44 with SMTP id
 g20-20020a05651c079400b002d867ee2a44mr6899106lje.8.1712669921293; 
 Tue, 09 Apr 2024 06:38:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a05600c199400b0041691379a84sm1446429wmq.1.2024.04.09.06.38.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 07/11] hw/net/lan9118: Rename tx_fifo_size ->
 tx_fifo_bytes
Date: Tue,  9 Apr 2024 15:37:56 +0200
Message-ID: <20240409133801.23503-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

tx_fifo_size is a byte count, rename it to avoid confusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index ba92681e2e..a983ce193b 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -251,7 +251,7 @@ struct lan9118_state {
     int32_t eeprom_writable;
     uint8_t eeprom[128];
 
-    int32_t tx_fifo_size;
+    int32_t tx_fifo_bytes;
     LAN9118Packet *txp;
     LAN9118Packet tx_packet;
 
@@ -322,7 +322,7 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_UINT32(phy_int_mask, lan9118_state),
         VMSTATE_INT32(eeprom_writable, lan9118_state),
         VMSTATE_UINT8_ARRAY(eeprom, lan9118_state, 128),
-        VMSTATE_INT32(tx_fifo_size, lan9118_state),
+        VMSTATE_INT32(tx_fifo_bytes, lan9118_state),
         /* txp always points at tx_packet so need not be saved */
         VMSTATE_STRUCT(tx_packet, lan9118_state, 0,
                        vmstate_lan9118_packet, LAN9118Packet),
@@ -456,7 +456,7 @@ static void lan9118_reset(DeviceState *d)
     s->txp->cmd_b = 0xffffffffu;
     s->txp->len = 0;
     s->txp->fifo_used = 0;
-    s->tx_fifo_size = TX_DATA_FIFO_BYTES;
+    s->tx_fifo_bytes = TX_DATA_FIFO_BYTES;
     s->tx_status_fifo_used = 0;
     s->rx_status_fifo_size = 704;
     s->rx_fifo_size = 2640;
@@ -757,7 +757,7 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
 {
     int n;
 
-    if (s->txp->fifo_used == s->tx_fifo_size) {
+    if (s->txp->fifo_used == s->tx_fifo_bytes) {
         s->int_sts |= TDFO_INT;
         return;
     }
@@ -1285,7 +1285,7 @@ static uint64_t lan9118_readl(void *opaque, hwaddr offset,
         return (s->rx_status_fifo_used << 16) | (s->rx_fifo_used << 2);
     case CSR_TX_FIFO_INF:
         return (s->tx_status_fifo_used << 16)
-               | (s->tx_fifo_size - s->txp->fifo_used);
+               | (s->tx_fifo_bytes - s->txp->fifo_used);
     case CSR_PMT_CTRL:
         return s->pmt_ctrl;
     case CSR_GPIO_CFG:
-- 
2.41.0


