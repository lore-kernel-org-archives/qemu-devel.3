Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFB3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weOZG-0004cO-0c; Mon, 29 Jun 2026 22:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOZA-0004bu-61
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:51:16 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOZ7-0002lt-2f
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:51:15 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-37e11438c66so1587051a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782787871; x=1783392671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5i2HJZAo+KK0Z/zDUj9Z8Rbai8WnFXe2qEi9yRXKlcw=;
 b=RlaGfpm06ZBJVi49yg6XafXXJQ2s9Qy0N/1JjfxoWciFPyTqj6NO2Ohu+mKn9x7tQw
 SuBOzb5w+PgdZGU7H6WpFKnB/JJJ7+dKePoh70a0XEKuzds/yuA60BmnGgzAeFt3Jmut
 GDayNadL9dXNA1sCel/oCLvy6iH8flcsQgVwPZTm7awMrFsVLWsk6fgmpnGNdsbmRoy3
 uAKdtIdAk+trTsJ5nGKZpzyYKxu/iU+QsY/nDWQ08siOswdMmzLbQQ2TqrHDG5WJSo9j
 DDkrfZJwxspWF4RirDETWxCQYVs7itFQRwYqiI2m8Ih6v3iT3BDZYFVF6YDf8P33QXGL
 9rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782787871; x=1783392671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5i2HJZAo+KK0Z/zDUj9Z8Rbai8WnFXe2qEi9yRXKlcw=;
 b=Em1gKxIYEj6vitK6U5QGH4tJszjUzwxUOJs63O7xBfWMPxpEz0tdy+gRsPNOaywgeN
 V6KMHlrCSn553WQUri5NE+1NxBa+cvlZGpIJBs+dNi/MWQPeDE2rQzvqdzgpGwjyML2F
 F2GnjrctXBV7E/icHPe5LShZLs+PMDg121pGxinsldtt7IXPcvzIEF2I0yklyzNq138J
 WpG/Za5hKKcBlfQhDJnAjr9IWvvpc9GUH9hVHcqzHawLCUoCC3U7+p3t77s7RqjDHbZ9
 33zQy8W/Ym+vSC1lHiXksbEjMF1Cu+l9GX3tv8fFp24iimzBZ3AKfJfoBDF6wjyH2QAO
 50CQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7Twn9mNfBzciZ7NEbrj/5OZPIYiHzhLL6XTVEZdv3XDnwd/lskiqBpnewXgVpGS7bkbLd4NeN8Btt@nongnu.org
X-Gm-Message-State: AOJu0YySXLbreGDP2WuUpLPndrSOgaYmnqg0Dc9VmFLnnWvRVguWLJvX
 LCGPlQqs6yXzNwfMBAtsjiwphc6/l73W3socXnNKb8w50fhsPS53hax5Zf9kSuDB
X-Gm-Gg: AfdE7clS91C0byinc1k9rZ4eM3ihJinWZeCnA0mV5zGJwtOb/DQZtmkPRXqW0qU24oi
 w+BZLv0c1VWAiNZ8N4d87hKRTtgxJmYC+glUeyJWzWH63ABKBuJ6X1ZDHxhzK93ENAoLq5Cc8Mc
 xTHJjixOtKsoO//Es8FzEZ088GL20l7RmpjOV33T6/7AtGruUgPMa3liVcEjXX7Fy2xgttBBExn
 uP5Am5YR7o6zyu9cgQp2rZRn49I2WQrcSLU0N+gxdXqzTEnsnFDFDhwmdVdBOC29PoWif1ndAHI
 dUAnY1oyZoHgqWvlwjBLvIiISlzzp/fDvu28ZzxmFER/j+7dUbB5kvHOhxaKJRbTZjCDjZYrDLS
 4O6fjOb18/UzqkkiCWceNMPJk7tFQrT6mXh6zHehcJB/EdNGBbSmteiHNH/FhZEa9Bg/SFcAbMZ
 L0Dj90/UAE/t5iqJaNdvO1y6ZJjH7ikeVSWpGFaTuYCut/Vca+AxjuXVWzcn5e5o7cGxCJaQSD/
 7iCCHWSfyS5aGLxfMaS/s7I0i1AgFSxF6SJL83XPUQ=
X-Received: by 2002:a17:90b:3e4d:b0:37f:9ce2:348b with SMTP id
 98e67ed59e1d1-380527fcd46mr1221775a91.28.1782787871441; 
 Mon, 29 Jun 2026 19:51:11 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f32661sm704545a91.9.2026.06.29.19.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:51:10 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 12/12] hw/riscv/atlantis: Add some i2c peripherals
Date: Tue, 30 Jun 2026 12:19:50 +0930
Message-ID: <20260630024952.1520546-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630024952.1520546-1-joel@jms.id.au>
References: <20260630024952.1520546-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 hw/riscv/Kconfig       |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 5ce150fff7e9..beaf64e0c114 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -64,6 +64,13 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
 
+static I2CBus *i2c_get_bus(TTAtlantisState *s, unsigned busnr)
+{
+    assert(busnr < TT_ATL_NUM_I2C);
+
+    return s->i2c[busnr].bus;
+}
+
 static uint32_t fdt_phandle = 1;
 static uint32_t next_phandle(void)
 {
@@ -309,6 +316,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
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
@@ -336,6 +356,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, periph_clk_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -551,6 +574,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
 
+    /* I2C peripherals: qemu specific */
+    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
+
     /* Load or create device tree */
     if (machine->dtb) {
         load_fdt(s);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index dcce819bf6e9..de37c08caece 100644
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
-- 
2.47.3


