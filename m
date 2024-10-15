Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AF6CFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewT-0006cT-47; Tue, 15 Oct 2024 06:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewQ-0006bp-EG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewO-0005vO-Kr
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso2868189f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988690; x=1729593490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mjarHtZFM/0LLvrqr3eopb6Cr3L/9s4YSKz09v4sDCo=;
 b=BIKXYdNcX1ndlG0L7L40aKnfvY8yC0kt/cRJepWyf7Ra5LYLEHiIV8FSwFvJeJE80A
 vlI8JKj5rCHpQMsiZPZ6jrEVTlqk1sP0ojx0cSF96/SrUHY+ii0/a1FB/OXTpci18EiH
 oJWNMG98mt+Hg1O+Y0ri7Lc8arkDmpsb8VsWHoyGmuGDMAyNE7qRIFitLZ4MORDpjMtW
 9ocDbtqwD+u2rA4txmpicyPF6QedNS6dFkf5c5UNiLjnDKXIv1UUlcfof1DSG/Xq3WrS
 zLC2/hwkj4Q93bP3+zQVVu6dhiJfGdx8IoDYXCaenXr0/z8TWEFnScbavRB5sNzHlTLI
 xEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988690; x=1729593490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjarHtZFM/0LLvrqr3eopb6Cr3L/9s4YSKz09v4sDCo=;
 b=IY/tjihKGahbniEvDTBz9M7XuYw5nHiPUE6JTvMOe+cr2v0AGYK2u0otFEa7K8wHrv
 iYD1jhov8vxJ9Er/aUO0FFXWmYrMXG94/QWgGmOxuAyYNQ/rApGJm09hq6faTDMPJvGP
 HUcvaxOlPV5wJoSQ4JyJZzLW6BJ/hd03zose5+s7drXGdKt/fnxFzGk66esjq/Ie82bZ
 vI1KAWR/jVeJzjEBW1KzqMiU/rl+bhkKcPCMFGqCFDWMU+nLam8N4zwpoq39awzKfAnf
 ztGiVtM/HRYwIm911vq+dd5rENGnLBKPuUZAg6gP+HzZIuDVoQLIOpL0Va/9ICWU98Ev
 VDaQ==
X-Gm-Message-State: AOJu0YzALn/B4ajBY+JloSCKHHF8YrWZMexMkr2zDrK8Al5AAUdc9BKF
 In7og6ZAXUZKgmcd5m/fxENn03drR8IgvEXHEpYscBGrA+rF3ZRiEWkUrc74x5HRwZFvOISMKeh
 o
X-Google-Smtp-Source: AGHT+IFmJ3B+LNtkTdWWpz6S+uueyOULSOOOE3sL8maLHJj89ONzjOfgXfMv7J2rURSCKI1GVEST/g==
X-Received: by 2002:a5d:464e:0:b0:37d:4318:d8e1 with SMTP id
 ffacd0b85a97d-37d551ca148mr9223670f8f.23.1728988690181; 
 Tue, 15 Oct 2024 03:38:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/28] hw/arm/omap1: Remove unused omap_uwire_attach() method
Date: Tue, 15 Oct 2024 11:37:41 +0100
Message-Id: <20241015103808.133024-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The recently removed 'cheetah' machine was the single user
of the omap_uwire_attach() method. Remove it altogether with
the uWireSlave structure. Replace the send/receive callbacks
by Unimplemented logging.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  8 --------
 hw/arm/omap1.c        | 29 ++++++++---------------------
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index cf5f0219a2f..e1b6a7cdd93 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -490,15 +490,7 @@ qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
 void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handler);
 void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down);
 
-typedef struct uWireSlave {
-    uint16_t (*receive)(void *opaque);
-    void (*send)(void *opaque, uint16_t data);
-    void *opaque;
-} uWireSlave;
-
 struct omap_uwire_s;
-void omap_uwire_attach(struct omap_uwire_s *s,
-                uWireSlave *slave, int chipselect);
 
 struct I2SCodec {
     void *opaque;
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 86ee336e599..25030c7e404 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -2170,29 +2170,27 @@ struct omap_uwire_s {
     uint16_t rxbuf;
     uint16_t control;
     uint16_t setup[5];
-
-    uWireSlave *chip[4];
 };
 
 static void omap_uwire_transfer_start(struct omap_uwire_s *s)
 {
     int chipselect = (s->control >> 10) & 3;		/* INDEX */
-    uWireSlave *slave = s->chip[chipselect];
 
     if ((s->control >> 5) & 0x1f) {			/* NB_BITS_WR */
-        if (s->control & (1 << 12))			/* CS_CMD */
-            if (slave && slave->send)
-                slave->send(slave->opaque,
-                                s->txbuf >> (16 - ((s->control >> 5) & 0x1f)));
+        if (s->control & (1 << 12)) {       /* CS_CMD */
+            qemu_log_mask(LOG_UNIMP, "uWireSlave TX CS:%d data:0x%04x\n",
+                          chipselect,
+                          s->txbuf >> (16 - ((s->control >> 5) & 0x1f)));
+        }
         s->control &= ~(1 << 14);			/* CSRB */
         /* TODO: depending on s->setup[4] bits [1:0] assert an IRQ or
          * a DRQ.  When is the level IRQ supposed to be reset?  */
     }
 
     if ((s->control >> 0) & 0x1f) {			/* NB_BITS_RD */
-        if (s->control & (1 << 12))			/* CS_CMD */
-            if (slave && slave->receive)
-                s->rxbuf = slave->receive(slave->opaque);
+        if (s->control & (1 << 12)) {       /* CS_CMD */
+            qemu_log_mask(LOG_UNIMP, "uWireSlave RX CS:%d\n", chipselect);
+        }
         s->control |= 1 << 15;				/* RDRB */
         /* TODO: depending on s->setup[4] bits [1:0] assert an IRQ or
          * a DRQ.  When is the level IRQ supposed to be reset?  */
@@ -2321,17 +2319,6 @@ static struct omap_uwire_s *omap_uwire_init(MemoryRegion *system_memory,
     return s;
 }
 
-void omap_uwire_attach(struct omap_uwire_s *s,
-                uWireSlave *slave, int chipselect)
-{
-    if (chipselect < 0 || chipselect > 3) {
-        error_report("%s: Bad chipselect %i", __func__, chipselect);
-        exit(-1);
-    }
-
-    s->chip[chipselect] = slave;
-}
-
 /* Pseudonoise Pulse-Width Light Modulator */
 struct omap_pwl_s {
     MemoryRegion iomem;
-- 
2.34.1


