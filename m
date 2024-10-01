Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0BBCEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfv8-0006bR-FZ; Tue, 01 Oct 2024 12:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfug-0005bQ-Jl
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuZ-00068b-VP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37ce9644daaso1745531f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800782; x=1728405582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6dLp/wHZBehRKngXgFzavNToxRCxJpfDSSmdCK9xE4o=;
 b=b+0jvtlYQCrPu5uDqI7bfa4/cMuuEX5tBfF2axk6evKf2U8Y56l2/Xdu0kd66LJ7v3
 qyuq8iXtWSlBJrD16LW8RkXyO15m4i3/RKSOALbKtHQr9EX8nfVT6JOrHpY8VRF3SMT9
 RpkZG//Z4i5jGZk6M+xG0lM9sQtmIISO8XUQkC4+5v13oH5fP18cbde9XHtnfrLCqEbT
 /pcSZwoEoewwTfx2xS9l/Lh2/SguddsVckitdJbaPAjH/q2BjEV/nGKZvbW5M7RkI/0g
 2GsvnNo9S1HCHiH5zrbz/jeAaV3DXGTukNnF8/FMrFJo2gmH9UoOXjNkU8W+Iiy1QUI0
 nu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800782; x=1728405582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dLp/wHZBehRKngXgFzavNToxRCxJpfDSSmdCK9xE4o=;
 b=e1UXLGs/UCpdMH67YU6k76s5YDMBdFK/YAPyB44UJINyZAb2SM19rs60UCfqTuR+iE
 ffDscMhygNGtuOpchIFz1A35By4NVd2a9RSuyeCXJm3xfZItwFxxS6ZBui5VDRdsgz+6
 UHaspCJFIfH7QiU775T11sHoiIN+cVAzEKg7FKAMfJO39jbYj2DaeQku411PKYMp77Sw
 zvxFgXvLanoRK8HL1rDY4nCyxfAQBjosgpidJO849kYuJrBHA+Koh096DfT2rbhuZaY4
 rIg+Qa6IJbSHr/3qLtCZcQxrrNXYTwbl90yMb7GsmdCCO3XPOzjETb293ARrJQu+ccvS
 ryIA==
X-Gm-Message-State: AOJu0YyB5QtYAkX/1S1Fq9dohA755dLBpm7lmTbExtO8kB52tP5iupXM
 o5Az7ZBzsN8z1eSbbUIo/CMgzndMaCoSN4TfCZcgvmoohijHSFxKWcKFORr0t4wnRiYT80ldn6a
 q
X-Google-Smtp-Source: AGHT+IE/+16qyKWehs/UaeYFc2lwVcKksZJ9awd+ZeTSsFndZw/z5OAeynH2VG2J7SjC1uHflvAr9Q==
X-Received: by 2002:a5d:6783:0:b0:37c:c5b6:ec11 with SMTP id
 ffacd0b85a97d-37cfba0a5dbmr155958f8f.39.1727800782552; 
 Tue, 01 Oct 2024 09:39:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/54] hw/char: Remove omap2_uart
Date: Tue,  1 Oct 2024 17:39:05 +0100
Message-Id: <20241001163918.1275441-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Remove the OMAP2 specific code from omap_uart.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-40-peter.maydell@linaro.org
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


