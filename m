Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9DBCD4F46
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 00:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO374-0000IM-QU; Fri, 15 May 2026 20:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO373-0000Gw-4X
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:41 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO370-0001v7-W7
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:40 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-130c9dcbd25so1046829c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778892157; x=1779496957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yls46R/LgoP+X+gXXLEasNr3guubwxoCbJukRxMefmo=;
 b=Deh2yIbQZT0+mMK1541UY12AaZ4cwAGIOD8Ux8X54iQADvtn2OiqAArRqL28FTsHsM
 ImwlAELJO+CzgMqs5z9nws6pLj+pdt8lCptixA/VZbtHRWvCbdm3XRvaBFaRvxnqbAJ4
 65bRARLMQNg81xDKrtTCZxvYY9Pw1WD98R4+IVINYRjaHzc6ucDahz55q4jABRYS8dpF
 QnZ+iKVqDD6ZeML333Aq98qoBrU4ZItrkse6iy8JNIrOFL52BijVNJbAOFI+prXYycho
 ft5ifgI8IEmPvRpq4rOyEK6kNFlPseUFpqDgqwkazVi9p7xE1NQAd8V2sgk7DIRh2/AU
 kHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778892157; x=1779496957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yls46R/LgoP+X+gXXLEasNr3guubwxoCbJukRxMefmo=;
 b=HVbPOUeIk4sDst7lJi/ZShRfBk9uIinyylwzKHeyf/G7b+wOyI4Gmf6x753VjPE6Xd
 CadqJDVUr4wRsBt9Z1vi1Nf1PqoQlO03NTxYZB7ex3IfmRJ4hnalv2yWwrEDMl+rPLcB
 4g94Zn7f8TYEcdJb5YsGi9+jRE1VUMV2w3HS50NOssSxiHxHcqbd6LWLViKcOWB/KbXu
 FXoNrCl1N09Vsof5K7S6Zwof+/JVNDEO6OPnSb0w0lowYxmQsO56fAc1N/srXCp8TTfC
 ZT1lR0wNNhCKv3tzZxKWyUlqlkQCroi6IKBz0B6oKrAh1uUyPdgX33zQN3BeporTRAG0
 bwQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ81gjcfuhKphu9xIxQaLhxtp2og8pQI4a2HpA8CQei8rWCmFdm402p/jZEysZ8XK4cgw5VwIYGgkpTo@nongnu.org
X-Gm-Message-State: AOJu0YzNokTYk/yzw7zcIYKBaiMp1rbVm7gz2hzCS93/nDqTRkZCfHxx
 ztGjzmsO+bO4WS9S0/xG3ymeoOrGUC1N+qSP7pFhwL5EtLHmHoxNnqd9
X-Gm-Gg: Acq92OFXG7L3xxc2jHQFUAUBknxwQPne/eZnnbOHsy7uZnPz35E8ozzoWBmTzUklzd4
 66mHL7b6xSDUupwJKj1Zn2KJRfStHIsde8af0MFmnfvopLw7DublOpDsoiRy5quDTvX4SUHHnxq
 9L9ZHDDgVZsSC2Woi6Ad9wpHcar92VrF3ytz2zgCEc1drhUrgvBBaqkLty4dJW7v1v9oBYOrNVp
 EE9XAX8GFjNjOF2Zby5pNxLkGfnvTyoDfM0NELu9mbBQQcyqtjh3z3SK/4NPQhY2R4DXuFPtmed
 GDBVPtCEz3a0hvC6uf6OBtcPGXbyep7ZYbtqWV1ILbuKmyQehOjkwc6iwpGaJ0gODF/r1wWg2vR
 dM8K24nkDD5PN0f9dJSX+aNCvFjs+uFKhneyKtPiHZQMf7BlDPTxJ7QLmpUczuEOUZQRSYMRX7D
 WngiPX7EudJm60my3cB2F9wXWHmWl7xpA=
X-Received: by 2002:a05:7022:43a8:b0:12c:81b:c74b with SMTP id
 a92af1059eb24-134c880b9a3mr4870930c88.1.1778892157458; 
 Fri, 15 May 2026 17:42:37 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ef5sm11327220c88.2.2026.05.15.17.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 17:42:36 -0700 (PDT)
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
Subject: [PATCH v6 10/10] hw/riscv/atlantis: Add some i2c peripherals
Date: Fri, 15 May 2026 17:42:05 -0700
Message-ID: <20260516004206.169035-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516004206.169035-1-npiggin@gmail.com>
References: <20260516004206.169035-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=npiggin@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 38be593b18..55d3f2a08a 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -68,6 +68,13 @@ static const MemMapEntry tt_atlantis_memmap[] = {
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
@@ -358,6 +365,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
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
@@ -385,6 +405,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, periph_clk_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -594,6 +617,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
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


