Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09090D31A02
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsbZ-0006AQ-CN; Tue, 13 Jan 2026 23:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbV-00069i-Ox
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:35 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbU-0008Kf-6u
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:33 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81f478e5283so2997890b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768365330; x=1768970130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9olK44AYgWu2ZXXXtInH5+BcooZTljrg2yaMIZdD0E=;
 b=CpLQqK5tPB9QLpaFrBkX2Od3l7D4FnKAA6WeoWQoAnUYRvGOexcv7rpVbQHT/ZFyHP
 JP8yNCHOBqsf03DuHdVufPZShHfCKUvddN5e4JzTXtnsu8dHiwUJvHAXUebQSvwIBlKf
 K3QZ00ScEIREgQ8gdKqCsQMdMCP03SwlUW7trrIWLVUVt6ST0KAfyfevqnOdn0iFlaYb
 WLqJHSVF3mmsctNqAwQztqcksKKLqqOrojXejgv35Ge2jwUVXDoo6h7T20Qlz+W91RIO
 sH4o2bwqMWdZxorhOcukwIEojIsNCPDwN8/h5HdALyMbv5lg9WYjLXSAL7M2NpMsZzNj
 9P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768365330; x=1768970130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A9olK44AYgWu2ZXXXtInH5+BcooZTljrg2yaMIZdD0E=;
 b=bBVar0VTh0piptJjiVUYqEoH6XC2AiEIKYBdCDQu1zF4ifRxOU357M/uhzETTlfnC1
 FlG/4iFy2hN+xed2FNyf0KmbmpKPXNXdkbXw7VB0vlEfBCECeSYHfmi9RBHCwgJN/4c+
 bhasfWfyFKwgXc9bUqhQ6dvuoivdMDVFMFxLh2fBUUU06t9QisZTEHc6rLn+a3PEFksn
 PEh0bifolM9PuRMa2wGWwI6vuZC5TDgGKXArX1dKn/dRT2aAIuWSfwpOcHlaHiUnA0SB
 V8nGpZRN6IW4n4ezr7IXcgeenE2/75Nxz5XiRqb+YlE0/gw4t5mgiy+MQw/TofuJzQyj
 NTYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVS9b+kzg5P1Q8slKMi3m0/58SwaDPIQ29M06e6PeBghNQnY1laKpoWVb4cBcq4BeAS7Pg6iL8/km6@nongnu.org
X-Gm-Message-State: AOJu0YxKWDbGyyjj4hK0bruFZUd3oD6lrXHODFHaMWFiYHyeVjxhNs8F
 EvaI/8KGC0z65bhtoHxfDHg2v2w2dK4oiTSSR6T782fBXeS1tasrVGIu
X-Gm-Gg: AY/fxX4A9utJlK4MPcUdrwo+5OklOLt2LaRH18VXsHMLRmMa+GW0tU+bWthfz4NZSCr
 5gAkGIYGyv1V/2kfvhntVigN5KisQQZEppuhWo93haaxWN+NxcE6Ae92IyMnumj7ywoaOO39HKa
 y6LGgkuOF7NOnHjEzMCgZWupq/a8Vt380CEIXOs9JLU2MNMhSEFsBT7wUUZJEc6dyTKtOwaMsMX
 nreG2W+BGxJ5Pe8SDRdNWy4opjdFZN3ptJz0Q5uPo5KGscGVE+R3HLvMpHa73eBRrUpYZO3xHPQ
 v+S+9cyukRxn7xtAmEsJ08HQTbCuhMp6THH/dijdC327bL6iO4Yu/gRvRrouxCUBBrgyH2QdxMc
 I0Lbe2jdhVB75mOiaL5x5mrJ6qqDZkNOgQRawgDRD//idD+PmIpZAFHNRJazdhLGuj/JF4jTtqy
 Oro+wo8yqY2mte0c/I6fEK
X-Received: by 2002:a05:6a20:729b:b0:361:2d0c:fd81 with SMTP id
 adf61e73a8af0-38befaf6a41mr1207832637.28.1768365329916; 
 Tue, 13 Jan 2026 20:35:29 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cb5352268sm20702659a12.0.2026.01.13.20.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:35:29 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 5/6] hw/riscv/atlantis: Add some i2c peripherals
Date: Wed, 14 Jan 2026 15:04:27 +1030
Message-ID: <20260114043433.1056021-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114043433.1056021-1-joel@jms.id.au>
References: <20260114043433.1056021-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

Add an I2C RTC device and a temperature sensor. These are not present
on the board but help for testing.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 18 ++++++++++++++++++
 hw/riscv/Kconfig       |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 2d0add278c20..2e96c5954268 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -497,6 +497,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
+static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
+                                  const char *compat, int addr)
+{
+    void *fdt = MACHINE(s)->fdt;
+    hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%"PRIx64"/sensor@%d",
+                            base, addr);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", compat);
+    qemu_fdt_setprop_cell(fdt, name, "reg", addr);
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
@@ -531,6 +544,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "national,lm75", 0x48);
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -851,6 +867,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
+    i2c_slave_create_simple(s->i2c[0].bus, "ds1338", 0x6f);
+    i2c_slave_create_simple(s->i2c[0].bus, "tmp105", 0x48);
 
     /* Load or create device tree */
     if (machine->dtb) {
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index ee876557ef15..0367d25d48da 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -138,6 +138,8 @@ config TENSTORRENT
     select FW_CFG_DMA
     select PLATFORM_BUS
     select DESIGNWARE_I2C
+    select DS1338
+    select TMP105
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


