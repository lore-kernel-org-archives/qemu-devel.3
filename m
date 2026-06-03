Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1768FCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfaa-0005GB-QU; Wed, 03 Jun 2026 03:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfaU-00056o-Iz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:00:28 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfaQ-0006hK-LP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:00:25 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36dac5d5d05so1491689a91.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780470020; x=1781074820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ao+oazFExSoDtdt9k3pepZ6wp9rhNY0/mLOZwCYpF8=;
 b=baxOukm+Bcvp1LJDJPcETkC4bUTdzjL44vxhfzIB5eUWkOauAwNlPaUa9aPimtoMue
 /gLfTWjzTK6nCl2A5DiRRW1DOdJ4O8wBK+ccthjyfMtTtgLH61v6vFtgclwpnPHy/bnF
 eCoTA2fROs7tSJZKaEyQjikBvku9W4zMuUOxBbMZkKXrReXmYLmNQ2oldu3I3H+bOjQW
 hSNH4HLsmcAoRCdSnUT7DtvQYRE1pzgaXANnDrTTAnyFObNp61IZdw21Lf+ZGxp6O0Tm
 0eIxHTiHUU+dGp2LbP4J2tfpVqaSHKiCVnVp2pp4gMiAlRqeucqndZ0jiekYacLNNEUg
 XMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780470020; x=1781074820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ao+oazFExSoDtdt9k3pepZ6wp9rhNY0/mLOZwCYpF8=;
 b=eOM60EySxk9irTbYxNWSepzpeslYF5oLU6Duq7KgWr84crL8uCb4GBLzswZa//2AKz
 ECZ044kaMzDtBaBW0RTH2oJJyMFXbuMPHRIHgebZeTtU5dmmB+tNDAtLUyNBJgeGY9Qc
 C1uAIuMKgk1t83GpuqLjthlwVvVC/C9uVH/SUdFo2UTvwRxc6h13r4rTHVGgCM26h/8O
 FE36hzpWO4iYvB0P4M7TGYVUcI/SpXxjsORQ124XDdMcSAcXYMkOvvzqO1lbI+H2a+YM
 GAUdPGGoUpk3BHtGSxYWDMDOeqtYu4WZmRcr0Dx7sxzo6Yv1W1GEQsJl8XXReVcHYNtn
 7SDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/im5y/KMawj9l1SbNht0No4wg6choIAp2/f7/0E9uVHpKvLSsoGiRCV2E71A04FpvtXoUOKL3l4sHB@nongnu.org
X-Gm-Message-State: AOJu0YzaA20LrSGkkaBUVgi7h+L75CzkqpkYmBgMkooIfoPb6L3ZSf57
 iNwVpu/pCImHh2yRMbxK5TgD3v6ePUvA9dfkFlpo7FEwTXQjVO2hDSGA
X-Gm-Gg: Acq92OGx6fA5cf1rNpnmK0t7ymZnG/JLirE8QFWgRDNWUV7DFD1LVVaRw2YyFRDzCK6
 QlCmC4sEkiQAlIs9p6Yi9QTgIQgyhy+mzxcaPmLj72Go5UXh4jWfSVurUHNjVgOAI8Z1tjg/lVa
 zfw+RIrD06MVzuzxyjW/rNXMocmd5jdDFXip9eTbbZKKJAceAoafS1nCa/47BdwldkdF0U+cgoQ
 /SuKUWfrinlRQn+gLoDaRRThejwZ+/CUhILDrDRMkxbSDu51jcJ853NL7xjtnguGCiZIiBSWEx2
 xSz3vsYZIUSSIX0B2ZeaaDX8twHu1acqUeghMYYIbtiZoxX407bxLNSZS7Cr1FuB6WUZJ4SHDUh
 WTOysRtUGxIUjcap5fF9GZ/qIsRv6Zfrreudc3aWYDHjyaVjvL8cPkQNQ0lmixrW4SIcieT0RU7
 mEqh7yNwY0VT7sT570dP1lgow135Xs5t/4Wc/XemeC7BJ1JlPmmTNp6gvqhksEVsjYd+Jbkem+/
 l2CmmJdyUZf/tSRLXCRZLhadLt7JiSzOCDDAq2i1+TizXfAoZpu1pM5fJfhnOaX
X-Received: by 2002:a17:90b:5289:b0:36a:7c8f:1423 with SMTP id
 98e67ed59e1d1-36e30e14912mr2034897a91.9.1780470019339; 
 Wed, 03 Jun 2026 00:00:19 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm1283261a12.2.2026.06.03.00.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 00:00:18 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 12/12] hw/riscv/atlantis: Add some i2c peripherals
Date: Wed,  3 Jun 2026 16:28:56 +0930
Message-ID: <20260603065859.592063-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603065859.592063-1-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1030.google.com
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
index b1ff0cbe2f61..5434650dd41e 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -63,6 +63,13 @@ static const MemMapEntry tt_atlantis_memmap[] = {
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
@@ -367,6 +374,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
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
@@ -394,6 +414,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, periph_clk_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -640,6 +663,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
index 38180a903fbf..ff2d250ee439 100644
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


