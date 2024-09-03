Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3163CD37B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 21:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slbSj-0005CR-Ky; Tue, 03 Sep 2024 17:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slbSd-00058Q-VM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:53:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slbSc-0003lc-9o
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:53:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so83122f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725400391; x=1726005191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PFoSPik66t3P04q3BhIghhGuPh2Gj4nrJCiedrufNLE=;
 b=a9ZihmVfLRTF6XwtnbPKDMbGnbfa3eNYqyWlSD6C7C+67+G16Tv3vTGA/WulliDic3
 rFsPBJmClQt1Y0U1nzSbzbS5g6Lk6j2Md02c7XKsQvBCM4VfSHyPJ9L01VqyQj5au+z7
 mA5VeqtLx67ZK+BJHe5kuYcO+MxOWeggiFP/5s6TWZV0wcBTyw7NBStMvnrU0rsE4yc8
 yDq+ffXzef/1t3P+mGuCDYWxSQ6ByTQ5eLoqOKIgKFWCRWE3FCvHTGojQdBKwCihz8/z
 lTprS8GXqu7ZpeJYxhRg6O+REFM4C1UVVVtECF2xrZSIttIyEoUp08sJDgfpmIHnfvd2
 fDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725400391; x=1726005191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFoSPik66t3P04q3BhIghhGuPh2Gj4nrJCiedrufNLE=;
 b=M87SAbpN5zESz5gY4JL1QvHLdr+Ci8dvbig6dYGaDNIwB4fCmU7aL/hx1X+8ORY7fe
 WC08abBr4qsptw2h0Gkzs+QO7VJU0/lvrTq7qSAws2NfExk19ECmrUQDiZ1xRZY2swxS
 fceB4797LHPpZHqA1lms9/QpI1qxgpE5NdgGINm95e3cDuPJVE5xIzCYnc24AGE88enw
 utcwbuG5H50HhzrxqqotTDQ8wlFgQpNR67yyN5tm+r+Y8LTfIaY5AZh7jygB/sNgOuYI
 qjRoxKXiDzWf0VB6A7LSOk/bh/jK1qRsu5mSEmmwZX6R6Zl+WrNeVHZGnaKc2034+kU3
 IKiw==
X-Gm-Message-State: AOJu0YynLwcVNXSyMYFSwpO0BLtS7qnZx2a2fk+t6vzJnSsmjY50DJWQ
 cJ26SzSC8+kcPFqX5Vb67G9qCjamSRcDC/9bY2uyCxJ9z2xPwiibmlcWNlUFZ2KrSyuiD2zIi7q
 e
X-Google-Smtp-Source: AGHT+IGgLk360ptFkYrai5rHB1UA09lQEuDo7mZq1zmGYfHQt57QScH073ZRLeWDZTzQcbvkmCGufQ==
X-Received: by 2002:adf:fb42:0:b0:374:c318:2188 with SMTP id
 ffacd0b85a97d-37770c702b7mr184223f8f.42.1725400390981; 
 Tue, 03 Sep 2024 14:53:10 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c96a88ebsm7271259f8f.108.2024.09.03.14.53.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 14:53:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm/omap1: Remove unused omap_uwire_attach() method
Date: Tue,  3 Sep 2024 23:53:09 +0200
Message-ID: <20240903215309.32111-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The recently removed 'cheetah' machine was the single user
of the omap_uwire_attach() method. Remove it altogether with
the uWireSlave structure. Replace the send/receive callbacks
by Unimplemented logging.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240903160751.4100218-1-peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  8 --------
 hw/arm/omap1.c        | 29 ++++++++---------------------
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index cf5f0219a2..e1b6a7cdd9 100644
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
index 86ee336e59..25030c7e40 100644
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
2.45.2


