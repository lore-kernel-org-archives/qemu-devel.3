Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C024DFF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcvF-0008Fx-Sx; Sat, 25 Apr 2026 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcul-0007i2-TK
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcui-0000NT-Eo
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-83178c0f29cso1816563b3a.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123155; x=1777727955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFdee4nHaejEKDKlQFwGR+4gsOxo5tQfJ+kbcTE/iEU=;
 b=Itbrf03ijXOhhC85VUiRXVQ6+UR+nJEXCK8AtAxE6+WL/oBPaDXsXI2Qckfo7gOIOL
 ZsOBQqQVsGLHDuubAaNf1LUWe6RIILuoL/bqWylZ9En1NhsBv70TZGsAfW9I0ifWjA+5
 qNd+aoLCEAAdc9IGyuAR+TyjRAUy9qHQkpkEP6aAWIkhhIH/LdevuCEokSS7JmdkwukE
 TbA8RFCAv+ZgRkxAv2Y0LgxhJf2X6J0FBGUSvyfXDxCPxFX6Ny1d8m6H40n8qS9rZEk7
 +6KEIIBRNkQ2DX4nd2O2eIyTR2a1mZiXWpMuF749Ni+lJISbBGRR1VNjDnoXAvE7cK+Q
 kqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123155; x=1777727955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFdee4nHaejEKDKlQFwGR+4gsOxo5tQfJ+kbcTE/iEU=;
 b=FFWwpgoOfxbGlu4EeGjPpp+13aPdolVqAIKJUVjNCJsn7LyveFPyMCVmdNHUD8kyD7
 2Dsi+P43rJNn2GJO9XWNku/GAJNop2wO6nJEO1D73PdAveRJpNnXoZPFZAkhG0WYpDaY
 JFWSwifUWn1AEBVlTzfPrOpZPZTTKgxLbGiet0hzqOoX3JsgMnzfNN61QNv1Ou+A/B/w
 8ZkxliLux2YqTGor5HFlatadNBBMfPsUD1M8Taf8vDYj0jbLUrrtY3KhXEEX9egTpEhy
 eYXUTTDuoq6yBp75pwa004Hdp36FWYzm+JaPX/qsO9f6KA9ZjiTdfd7XwQzy8dzoFBNT
 ax8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ860aUwXZfsJP/q0PU6nZmCbY+5B/OuFaxe+dpPwyOdVL/KLaBjkPrtJcacH4wGJCeP9txnj7oKX8B3@nongnu.org
X-Gm-Message-State: AOJu0YyCED6aA1tWA/8W6LCXIrqrO+PRl36h95pFF3KETGjsXgSXShMt
 TQKokTJtiFPeVkvKOGsgCPiWtomJylXL+Y2lPkIzDZc+8wHlsKwGGbyj
X-Gm-Gg: AeBDiet/WVGZ83j+T2gfB6Q9N+Ug1+xeA7eLWRrK5RQitmjp8WgYOpG/XZH2jXbAdUU
 OvT3hXB9jUgnDLPv7bYtoxsEWGDX+44wgXMgcyQ7ZhJxjPMLluCgJOxRRqSxT0T/ZZUKAVrn8UW
 wXUA0bPdkaP0ZhZu4XXD7r+hlw5F3sb/b4pm2Xrcnpj5dt6nT/fNTjpdLwn3//hnf4zp0adO/HR
 3iRNN5R50ukRi3xS+HygsfE6KWltsqWaNta7HNjID9U7FmTCiHkos+29kEnbYIUkMGCU/iIGTLE
 WWFO+j2aJtwlXVJ2YwdHXJB/5kOXfhBc4+3EGKqigHFVBbMYXcxeR+wFBH/Epo/JPnZs4ymQwJc
 OzagsO/Ics7TAwvshjIpvq3TpdhpCaXskkTkbVIZPf1TLxvxJH/hYQgrIML1s7xjVOr5fI7O4qz
 9moQ9gfrJT/z8WANK7PIo8QkLnvbljrS+/q7gXDhU84jZYw6uVYafrAJu8m9lATirmXZKRukuz4
 NR0BAAsg+XCuTIn/fcpfIZvqg7qKnCJ
X-Received: by 2002:a05:6a00:1953:b0:82c:d861:3caf with SMTP id
 d2e1a72fcca58-82f8c907fbfmr39138122b3a.36.1777123154850; 
 Sat, 25 Apr 2026 06:19:14 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:19:14 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 13/13] hw/riscv/atlantis: Add some i2c peripherals
Date: Sat, 25 Apr 2026 23:17:19 +1000
Message-ID: <20260425131721.932250-14-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add an I2C RTC device and a temperature sensor. These are not present
on the board but help for testing.

The tmp105 is a lm75 compatible temperature sensor used by the
SENSORS_LM75 Linux kernel driver.

The ds1338 is a RTC device that is used by the RTC_DRV_DS1307 Linux
kernel driver.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v4:
  - Place i2c on bus 0 and 4
  - lm75 compatible to tmp105, which is same qemu model and linux driver
  - Mention the kernel drivers in the commit message
v3: Use HWADDR_PRIX in i2c device string consistent
---
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 hw/riscv/Kconfig       |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d517d0aee2d1..521748af1b99 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -94,6 +94,13 @@ static const PciMapEntry tt_atlantis_pci_map[]  = {
                                                   FDT_PCI_RANGE_PREFETCHABLE },
 };
 
+static I2CBus *i2c_get_bus(TTAtlantisState *s, unsigned busnr)
+{
+    assert(busnr < TT_ATL_NUM_I2C);
+
+    return s->i2c[busnr].bus;
+}
+
 static uint32_t next_phandle(void)
 {
     static uint32_t phandle = 1;
@@ -514,6 +521,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
+static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
+                                  const char *compat, int addr)
+{
+    void *fdt = MACHINE(s)->fdt;
+    hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX"/sensor@%x",
+                                            base, addr);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", compat);
+    qemu_fdt_setprop_cell(fdt, name, "reg", addr);
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
@@ -552,6 +572,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, periph_clk_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -874,6 +897,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
 
+    /* I2C peripherals: qemu specific */
+    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
+
     /* Load or create device tree */
     if (machine->dtb) {
         machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2db8f409b926..6ad7b3e07e9e 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -136,6 +136,8 @@ config TENSTORRENT
     select RISCV_IMSIC
     select FW_CFG_DMA
     select DESIGNWARE_I2C
+    select DS1338
+    select TMP105
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


