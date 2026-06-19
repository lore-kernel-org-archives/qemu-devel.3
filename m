Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9DACD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRBc-0000kg-Lo; Fri, 19 Jun 2026 00:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRBJ-0000N1-J2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:50:23 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRBF-0005oM-FR
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:50:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8422f395a4aso1147259b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781844605; x=1782449405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HO68ROaXgpgmoPhUOGfAjCfRCsOUvV6mmReMnRWPMyg=;
 b=bEUKqMsioN5HwssxklpxGfJdzCZFjI7l5Gi8burtk2xN4DhgXMVF1xGiFqj3BnAdLf
 Mlo0mkO5voZRRbkNZ6UHOOs9PKoc/rIdVXtiwhfY+DyHcJnreG9gJEtS03V6lpLncgkZ
 3Een9A0TyxGaLPe5Is8jPJPj9FXIyDeFyCx0qe8JO1yUUvCcwp14NojMIKIZCDbKEVrt
 n0jfZxH9W7P++mU5nMYHHoRf4/KWMxNCtxJf6Z6Tnm8z4ZchQiUv0ECHmq9VOhtBiIQz
 vrX0lCpR3K+dswQAw3iK7aoM1UEg729nVS1ZaIQ+OnULxWE1Hbsij9lEEP10MiJHBFQH
 FYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781844605; x=1782449405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HO68ROaXgpgmoPhUOGfAjCfRCsOUvV6mmReMnRWPMyg=;
 b=GIm6FSFIwx5Djt1NIoz+n9M/QwJcRZR6BebcAUBLEvD9MJEkbUPXjG/mRQSV9eJx0I
 T8+r74E99sIlffr6vibfoaCy0sHujuZn6WMujKV3Dn9MHWIVHCZ7pdeHCX50qyP3V2BD
 D0sn2/fZViCTn0heJ/OtInYrnKRREZWI52KFqZrdK6XEz5uW1BPonyQGsDLEfKKT08yk
 J+nAzrh5RAbvCRpjlcU2aDtNYlamzAXeqLaC1hrEw6Gw1IW1VL6C+znsJiODW0SM2B9h
 pUdFIe4qrUH2/MjMx6tc26btw8xbB6iCGrYghcGDIFbdtfHPDs5Auq7ofApeJrWZPOsY
 rDFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CXp3ZrFrNEMSNzfGO6UXNybYCiSBGLvLoBz22Ngny0MmtmiEYyArdce+NgYjHrtIuFW3IoO2pFnqr@nongnu.org
X-Gm-Message-State: AOJu0Ywbpr9U1SMIjjXCIeb/fCzsZL/60d5QnXQWHvyc4s3G9ab73qme
 aREhL1kccuO2aHO0v2srz1Wk9Fn09Y1xwtp3A7CbKZTaKnMOeOv7Ichq
X-Gm-Gg: AfdE7cl0zU2oYtAUVg/7qZY9mf+LcX0l1uurWgFdFIe+fiB/6FWoPbVcoirMB/H8+lR
 DyABECRTRM52rTwD1IcBNO5SZaaNoptohoXMCCkkID/iV16FTIb8KV66osInoKJGlBub+l54Cdw
 J+ISE9oC6si7paKzQHnvmIA2LJcbWer+1RPRW6O7GE2gjns+bDTUr9C8BLs6RFiMmW3/GDXGfEx
 59x5uy7TFfDLm+8R1TPj+rqI77twf+DfMKnfTgUjQD54bLKkzMA5UNiZQOMlvONQh78FwmpUcUU
 z2k9tdMZQT+gX+nA3aWVMpSWQ3zeSVIzTq8ud+YU51bs4tylkOdKohQa6JVJs+e7/K6GsUUQhha
 Ocfh0dcwNPQ6rXsGXi/i9mgdGXnKTTIZpqM7WgQ87aPvpRJfFgwUAZS8L341KsdzUF/Lcny6/e2
 vd+LlDH09a9qirfG4DpP83RdvOWMFyeb00OS1Wpm7K5DfrCaE1HU0VmVgZ21zCXHbVlXQhj0aoj
 7pDxOpR6Jup01MiupMF8NhYaZSkWT2HxH/okML8FQ==
X-Received: by 2002:a05:6a00:4fc7:b0:845:3033:6cbb with SMTP id
 d2e1a72fcca58-8455015fc65mr1591578b3a.11.1781844605133; 
 Thu, 18 Jun 2026 21:50:05 -0700 (PDT)
Received: from donnager-debian.. ([144.6.172.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455363da44sm870141b3a.8.2026.06.18.21.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:50:04 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 12/12] hw/riscv/atlantis: Add some i2c peripherals
Date: Fri, 19 Jun 2026 14:18:36 +0930
Message-ID: <20260619044838.1054677-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619044838.1054677-1-joel@jms.id.au>
References: <20260619044838.1054677-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42c.google.com
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
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 hw/riscv/Kconfig       |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index e6afd7627da8..9b64f26d2f76 100644
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
@@ -570,6 +593,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
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


