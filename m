Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48213CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5V-0000td-3x; Tue, 03 Sep 2024 12:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5T-0000lV-7A
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5O-0002vB-Ke
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374ca7a10d4so1350215f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379733; x=1725984533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6KZWNBjhhzjYgLlW+2QJ75y9er/DhS+ckZ21pfSiKUs=;
 b=IofOdgyzqc6pJWcJRxFCRiBlrsloL6Wk6RIz4BA9Vv1PSfFIGoOFPpLZs5+vGKCU0U
 Be1RzkCpTY80oquR/PBEH1UMlwLZIIQJgg03y/+8DPcRH7ToW0e8iOJeMxlRSovIdd9D
 3quNR7hqOV7kf2ImNC2KY/PJDl5r/scD6WEBEbS5roCH6ieAtNqYgZlvqST+Nd2+FGlX
 4xVjI658JMXUwOj3xdks83baZ9NKJ7uGA543Lfe7LJX6vgnkT2O72IXg0n0prhfoJOW1
 Edd5agCvzMDmmdncLSuvt3FUaAdJmb+T8Zz9v4ldpO4w+NxxRGj+Mvbckr1veCk3u0dM
 6taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379733; x=1725984533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KZWNBjhhzjYgLlW+2QJ75y9er/DhS+ckZ21pfSiKUs=;
 b=R7zwtBpn1/6xVUYmsd0HNgqXnFf6xfVTTr8sTu3uFa7q2k7qoePbhBFrTsk8mxScqP
 uA9vwMh77qrTklufmTVF+i6Rdrq85Llutzge8tGVNe8gGXL75c26pBEuK0zsRtsKjp35
 un4W7F5X7yaIwQElzN7UlTRrqfFuAmNID/wv96O+soIejbMeUbYWLZMC3DJYakiZAa2q
 AN/RZjznmFj8PF9nceY64sl6vuI2M/Wf+S3Cdxtvs7H3zBsMcsFj5Ml/7y9mfJmJOL/R
 7sKYtOa1d+SR4H3vKPF0R9qOHE5oLjl6ORrFBX1k5eC21l3A9yA0F3ahLI7YE86Jv79a
 3YaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy2onuQMxgsTSM72ungVATYdio2+V0uiFcWUd9NAUZy2CnxDl2BMNig4bshOPgoa/NBIAT8nkYw44r@nongnu.org
X-Gm-Message-State: AOJu0YzTEJ1obOM6t4ed6ONeDKHFPg4XHnXdW/j3FHzoqWosBVNmH5b4
 Tc7rTRNEMoQ8vTFbjJ+rmVUm0AQSli0DNLqGGdPkM1IpHVElB+cEOhBaKN5QbTs=
X-Google-Smtp-Source: AGHT+IGLSy9KpfY1okcyiikC/zGAUI4aPdmkBYZiL/QBxKdzKbonoF5n2Vrtlh7PepyAhK//lvvFuQ==
X-Received: by 2002:a5d:4608:0:b0:374:c31e:971a with SMTP id
 ffacd0b85a97d-374c31e991emr6538557f8f.0.1725379732903; 
 Tue, 03 Sep 2024 09:08:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 39/53] hw/char: Remove omap2_uart
Date: Tue,  3 Sep 2024 17:07:37 +0100
Message-Id: <20240903160751.4100218-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove the OMAP2 specific code from omap_uart.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |   5 --
 hw/char/omap_uart.c   | 113 ------------------------------------------
 2 files changed, 118 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index b569580b09e..67bb83dff5d 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -709,11 +709,6 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
                 qemu_irq txdma, qemu_irq rxdma,
                 const char *label, Chardev *chr);
-struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
-                struct omap_target_agent_s *ta,
-                qemu_irq irq, omap_clk fclk, omap_clk iclk,
-                qemu_irq txdma, qemu_irq rxdma,
-                const char *label, Chardev *chr);
 void omap_uart_reset(struct omap_uart_s *s);
 
 struct omap_mpuio_s;
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index c2ef4c137e1..d789c253b49 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -28,7 +28,6 @@ struct omap_uart_s {
     MemoryRegion iomem;
     hwaddr base;
     SerialMM *serial; /* TODO */
-    struct omap_target_agent_s *ta;
     omap_clk fclk;
     qemu_irq irq;
 
@@ -36,8 +35,6 @@ struct omap_uart_s {
     uint8_t syscontrol;
     uint8_t wkup;
     uint8_t cfps;
-    uint8_t mdr[2];
-    uint8_t scr;
     uint8_t clksel;
 };
 
@@ -66,113 +63,3 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
                                DEVICE_NATIVE_ENDIAN);
     return s;
 }
-
-static uint64_t omap_uart_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct omap_uart_s *s = opaque;
-
-    if (size == 4) {
-        return omap_badwidth_read8(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x20:  /* MDR1 */
-        return s->mdr[0];
-    case 0x24:  /* MDR2 */
-        return s->mdr[1];
-    case 0x40:  /* SCR */
-        return s->scr;
-    case 0x44:  /* SSR */
-        return 0x0;
-    case 0x48:  /* EBLR (OMAP2) */
-        return s->eblr;
-    case 0x4C:  /* OSC_12M_SEL (OMAP1) */
-        return s->clksel;
-    case 0x50:  /* MVR */
-        return 0x30;
-    case 0x54:  /* SYSC (OMAP2) */
-        return s->syscontrol;
-    case 0x58:  /* SYSS (OMAP2) */
-        return 1;
-    case 0x5c:  /* WER (OMAP2) */
-        return s->wkup;
-    case 0x60:  /* CFPS (OMAP2) */
-        return s->cfps;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_uart_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_uart_s *s = opaque;
-
-    if (size == 4) {
-        omap_badwidth_write8(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x20:  /* MDR1 */
-        s->mdr[0] = value & 0x7f;
-        break;
-    case 0x24:  /* MDR2 */
-        s->mdr[1] = value & 0xff;
-        break;
-    case 0x40:  /* SCR */
-        s->scr = value & 0xff;
-        break;
-    case 0x48:  /* EBLR (OMAP2) */
-        s->eblr = value & 0xff;
-        break;
-    case 0x4C:  /* OSC_12M_SEL (OMAP1) */
-        s->clksel = value & 1;
-        break;
-    case 0x44:  /* SSR */
-    case 0x50:  /* MVR */
-    case 0x58:  /* SYSS (OMAP2) */
-        OMAP_RO_REG(addr);
-        break;
-    case 0x54:  /* SYSC (OMAP2) */
-        s->syscontrol = value & 0x1d;
-        if (value & 2) {
-            omap_uart_reset(s);
-        }
-        break;
-    case 0x5c:  /* WER (OMAP2) */
-        s->wkup = value & 0x7f;
-        break;
-    case 0x60:  /* CFPS (OMAP2) */
-        s->cfps = value & 0xff;
-        break;
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_uart_ops = {
-    .read = omap_uart_read,
-    .write = omap_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
-                struct omap_target_agent_s *ta,
-                qemu_irq irq, omap_clk fclk, omap_clk iclk,
-                qemu_irq txdma, qemu_irq rxdma,
-                const char *label, Chardev *chr)
-{
-    hwaddr base = omap_l4_attach(ta, 0, NULL);
-    struct omap_uart_s *s = omap_uart_init(base, irq,
-                    fclk, iclk, txdma, rxdma, label, chr);
-
-    memory_region_init_io(&s->iomem, NULL, &omap_uart_ops, s, "omap.uart", 0x100);
-
-    s->ta = ta;
-
-    memory_region_add_subregion(sysmem, base + 0x20, &s->iomem);
-
-    return s;
-}
-- 
2.34.1


