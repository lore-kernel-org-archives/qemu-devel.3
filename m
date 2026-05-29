Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A2FCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwgX-0005Dr-5H; Fri, 29 May 2026 08:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wSwgV-0005C2-Bu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:51:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wSwgT-0006Oi-LF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:51:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso5740395ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780059088; x=1780663888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2zfqS8MXtuTTKrwyVtoNZLOJDJV7lQ5nawu6+oWpRg=;
 b=Cn3f3t2uTd0mgQd+cB49g9xmARd5ovjRXTCWNw2MxEoHdxQ9Wh7lkigHzLpA2Jy9v/
 LL3zQ9yywGzkjmAJ6BqtGZYrGLcHkqH8VnqiLtpZ0ybZoFeWMoxkbIGmCRU1PHlBbMNU
 VlMWom7Ci8MbDi7IkuASaauxM+90XsQDwICQe9U0cgKNoPJZO0urG1eJEDHyiIvUN2rY
 d26qUNXtBXIaPZ/pJM4FIBGcA8AGUDizgan2dJXjpdhhHhrmU250IdoCFI461BN7Ab0d
 6puMYRrgIFvyglGhsYOv9B2yLq9hRgaliXCOOMrR7AwG4FCwJrQb4FIK3PSWbLE0kWQR
 tF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780059088; x=1780663888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2zfqS8MXtuTTKrwyVtoNZLOJDJV7lQ5nawu6+oWpRg=;
 b=VLXht+T+NcxclgpEsEoXbf/iG0m+Y2oMLS7s15cv85GeP3XacHIFHjWnu3caH3gmuc
 FWNRNG1xG2UDiANGxNe0mklEDhOBzO5o0XmleUmBAHAb97+llIYudTup/cHnhS4Z5TGU
 JGKRuFgOnN3X+YKGHhxMXrC53wdJVSsizT0hX5xeI8aS6DTs2P058lOz+9qJvQs8N04a
 yswaUZxGCcyyK1GSn+GQ2NhTIhvTVkOyoE5Mx8L74+pO+a9yiNkiEMbyPw9eZdxnASSp
 F4oeAUuLzaUQOjPT+Xqk0S5NcbsVHEJfemhTQ+9uhwiSTtT27+G+uOpIkF+89kJDf9aM
 GwLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UHi0BcygK8i3iaC1YTxymnSbelhpebUXYbC+TiCx0Bj+CqGDxcul9iFp8Z2UGNkkdRHYMpgdLcupR@nongnu.org
X-Gm-Message-State: AOJu0Yy7RDp0NmtNw3BpDZhuWNg7bHt4pYiagKc7rz18B1JDXNAvvIDE
 s2CUfb8eZYfFOVmc/10Ck+/Amx6vPDCy0F41w9wvD+cHv+yO+tY7LXlO
X-Gm-Gg: Acq92OHXd+cRHR9qWLNvNyGx2hlRdQzfB4vyLSdm4WukDBKCAAGtYHfm9Feel9IORNX
 lNsoki4e8sRFH1jTiu/3uxfh9caEDAKdiW1CYir7npCqH7E1IaZdGO2DeFg0evzPuyjt/RNijdg
 63UcVRAX3EmIXKxNhKad3XO+nZ3ZvmaIigjWQeaP3MVP9v1tUilWama+MmYwjyGsdQApahU/7RP
 u+5V7OF1Bq2wLDv97cKkXqWu9bZEmeNLmkBkQkyBCulnVdx7VQ+PGcRW0/PmJumoUVa1BTDYpp/
 +f9YEM4Z3ZtwCzX7fGZtbq2lcHoIQw37W9BN8aLwig1gjdR47Jqd9ZcAPApg8dVLQatGF56jNoV
 XFiBu9e/8wJMrjHQNCE+fJuTvRoc/PoUhljbkWkhnktyClpAulmVyAdTsXPkFbZQAwcBjhQhYxE
 ZC6NxsGMNdSFhazLCo5fpbyHAvDcTDWTikCAh0eeHEn4GabwV2+5kx2Y/bZ4cDssTLIBf9EfKHD
 /WXeei2
X-Received: by 2002:a17:902:fc8f:b0:2b0:4fb6:85ce with SMTP id
 d9443c01a7336-2bf20977e87mr33743095ad.21.1780059088203; 
 Fri, 29 May 2026 05:51:28 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23b00ebcsm19248475ad.51.2026.05.29.05.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:51:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 10/10] hw/riscv/atlantis: Add some i2c peripherals
Date: Fri, 29 May 2026 05:50:35 -0700
Message-ID: <20260529125036.728206-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529125036.728206-1-npiggin@gmail.com>
References: <20260529125036.728206-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Add an I2C RTC device and a temperature sensor. These are not present
on the board but help for testing.

The tmp105 is a lm75 compatible temperature sensor used by the
SENSORS_LM75 Linux kernel driver.

The ds1338 is a RTC device that is used by the RTC_DRV_DS1307 Linux
kernel driver.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/riscv/Kconfig       |  2 ++
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 38180a903f..ff2d250ee4 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -130,6 +130,8 @@ config TENSTORRENT
     select SERIAL_MM
     select DEVICE_TREE
     select DESIGNWARE_I2C
+    select DS1338
+    select TMP105
 
 config XIANGSHAN_KUNMINGHU
     bool
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 39979c662b..e43b58826a 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -69,6 +69,13 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
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
@@ -359,6 +366,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
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
@@ -386,6 +406,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, periph_clk_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -595,6 +618,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
 
+    /* I2C peripherals: qemu specific */
+    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
+
     /* Load or create device tree */
     if (machine->dtb) {
         machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
-- 
2.53.0


