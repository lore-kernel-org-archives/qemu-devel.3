Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F73FCEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuw-00060f-AX; Tue, 01 Oct 2024 12:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuh-0005c9-OW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:52 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfub-000699-0p
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37ccfbbd467so3442489f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800783; x=1728405583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pLjR9+4ntpVFrMa71G4Zk/cNxT8KcG7e1lT6CH4TPlo=;
 b=N4nA6XN/UK97XslqFp55a6hdZOc9P5yZmihDtsnQd1CSN2rPcxej5Rk4p0UcZxC5gg
 v7am2wJ62HFbw8ZXon7a0DLrCXFDw0iMCy5ywoNU7j8EPFyXDzzs4OkUlJOpL+/HANrG
 oZqqRsFxfYnWgnJjEtQ3EIm7KEqnozI9BRi0AvWTEaMkyCZ5nJAuF2maaRrmQz5SiBzO
 HqLBT10WtZ3ZDDRr+AUTxgHmLqVjc31JqzfxXL+Xm3e9N9QJhrzNYB2+fSkQKt7FGT3j
 Sri98p2lTtnAkLWcPd7G6JZCGOTlpgEWVNjRPNPAAPgk3XQUeybH2PxOMBkoyRKPwf5Y
 IWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800783; x=1728405583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLjR9+4ntpVFrMa71G4Zk/cNxT8KcG7e1lT6CH4TPlo=;
 b=cSJwu3MAEmp6uRo3Zfq7cysG/Eac5zRL3LfcDDHN6YWZStf1SrtmATGL+TsCdXmo8k
 2Rm6IcRklaDM9p+rUi2+wUVXIsNJh4wim+ajNKxaDBfSvPFS+X7WyEkgObIEdhqxzhA/
 kBA2HiX/FgfxAAU1m57OsqzvlsZqSRmp+g3Y7WGN1uQ+wrLf7ba33o0b92fQShJbqg2P
 eyxVAe/NNxwsUYl23dZsj7iuhx6/4CdR7Uffzp589TCcB3yAdy5jvQkGSp/Jbr9Uh5JR
 +WKNzsQx2N+use06lEtgbyflAUuIPf8T2vDujzG4pEdysWZoFquobiEfXaNjqJnOP05G
 ff0g==
X-Gm-Message-State: AOJu0YyJMZTbV+PZ33XWGiTdKvmGwakOUsNj92vIUJAO4CeqgvVKNqEb
 aPp8bLinVo6Zwh43FsjIgsKuMS4R1XWx882wnHensHAWKnfKTPrZSf3OOkFx40hMhn9YY+LO3Q3
 R
X-Google-Smtp-Source: AGHT+IFXVhD4ABhR71hFJYupoisgXqIhcGeyyZCQFbaFyRNKDbi0OSgWoSH37lDnAIG13yw1H6ATsA==
X-Received: by 2002:a5d:4d4e:0:b0:35f:d70:6193 with SMTP id
 ffacd0b85a97d-37cfba06961mr129699f8f.41.1727800783499; 
 Tue, 01 Oct 2024 09:39:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/54] hw/sd: Remove omap2_mmc device
Date: Tue,  1 Oct 2024 17:39:07 +0100
Message-Id: <20241001163918.1275441-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Remove the OMAP2 specific code from omap_mmc.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-42-peter.maydell@linaro.org
---
 include/hw/arm/omap.h |  5 ----
 hw/sd/omap_mmc.c      | 63 -------------------------------------------
 2 files changed, 68 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 67bb83dff5d..b0bd1e6f540 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -797,12 +797,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
                 MemoryRegion *sysmem,
                 BlockBackend *blk,
                 qemu_irq irq, qemu_irq dma[], omap_clk clk);
-struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
-                BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
-                omap_clk fclk, omap_clk iclk);
 void omap_mmc_reset(struct omap_mmc_s *s);
-void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover);
-void omap_mmc_enable(struct omap_mmc_s *s, int enable);
 
 /* omap_i2c.c */
 I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index edd3cf2a1eb..91e9a3f1c6a 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -573,24 +573,6 @@ static const MemoryRegionOps omap_mmc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void omap_mmc_cover_cb(void *opaque, int line, int level)
-{
-    struct omap_mmc_s *host = opaque;
-
-    if (!host->cdet_state && level) {
-        host->status |= 0x0002;
-        omap_mmc_interrupts_update(host);
-        if (host->cdet_wakeup) {
-            /* TODO: Assert wake-up */
-        }
-    }
-
-    if (host->cdet_state != level) {
-        qemu_set_irq(host->coverswitch, level);
-        host->cdet_state = level;
-    }
-}
-
 struct omap_mmc_s *omap_mmc_init(hwaddr base,
                 MemoryRegion *sysmem,
                 BlockBackend *blk,
@@ -617,48 +599,3 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
 
     return s;
 }
-
-struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
-                BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
-                omap_clk fclk, omap_clk iclk)
-{
-    struct omap_mmc_s *s = g_new0(struct omap_mmc_s, 1);
-
-    s->irq = irq;
-    s->dma = dma;
-    s->clk = fclk;
-    s->lines = 4;
-    s->rev = 2;
-
-    memory_region_init_io(&s->iomem, NULL, &omap_mmc_ops, s, "omap.mmc",
-                          omap_l4_region_size(ta, 0));
-    omap_l4_attach(ta, 0, &s->iomem);
-
-    /* Instantiate the storage */
-    s->card = sd_init(blk, false);
-    if (s->card == NULL) {
-        exit(1);
-    }
-
-    s->cdet = qemu_allocate_irq(omap_mmc_cover_cb, s, 0);
-    sd_set_cb(s->card, NULL, s->cdet);
-
-    omap_mmc_reset(s);
-
-    return s;
-}
-
-void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover)
-{
-    if (s->cdet) {
-        sd_set_cb(s->card, ro, s->cdet);
-        s->coverswitch = cover;
-        qemu_set_irq(cover, s->cdet_state);
-    } else
-        sd_set_cb(s->card, ro, cover);
-}
-
-void omap_mmc_enable(struct omap_mmc_s *s, int enable)
-{
-    sd_enable(s->card, enable);
-}
-- 
2.34.1


