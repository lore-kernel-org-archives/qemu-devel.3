Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5A7F5A8D2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3kR-0001FO-DO; Tue, 21 Apr 2026 01:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3kN-0000nJ-6S
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:34:08 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3kK-0004bB-3r
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:34:06 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so200740a91.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749642; x=1777354442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cb167ruVDMxU0ClBbxjLtNhRudkBM0dnTEahrKy7ou8=;
 b=msoyVbd2IU9CpF0OzFWAuI73wXxOPwuxCHpeR4ONk/qE0HIJ1QKJbncEwQR6r0qwkJ
 rV1vsZV0Csrzo+tZhtyNok7kAjLjBifeXjk1k5LDg8J/Zq3o8rKEpSfh1MIo3gawqcXg
 Ra3NlHwFiDTZLs8y4qXQu68j7J1nn6BuSlPyW3TaVcKuTCJfVO/e8a5ljjEr3NwYFlJF
 IYOW6nMN1iysO92yS+ySVT6Jh6vytszKmqx0a44ihsiJMO0jBeI6LdSg9xoCfAPe5Mjd
 rlj/d0ntD46tTHHPJ16kCNwAOODnKyL6QIPl47dnk5G5/czzrlsUMDduAPF/5kQHgjfZ
 f+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749642; x=1777354442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cb167ruVDMxU0ClBbxjLtNhRudkBM0dnTEahrKy7ou8=;
 b=kRTLqqvBu1Z3o7gMcyNUYoxAImV4JDa+ElRdeOzby41PqGt7xgk62RTlC2k2aRxWJG
 D0hQN5sa6rqxNrLMzV5vedtt0wv/SoA8xIpGHIOuJwJU4FUDfNypVjvJXvGiP6KdA1vT
 08EKfA2yjFsVWQP2/RkneyhTgA9v2zE3ak8l1RAKjc/Empgo1GqOJ+O/c8ub1g5M4saY
 Viemf2xlNlTsLqDiDJeHlgwyGNxpwku1Rle3YPMJJsLpg+cxjOm3UoYi+ZgVhc7iE4rC
 0YeiDu5zlldmIfyfNMLrdkX6oNW/7FBsFkqBAzU3/vaI2CpEtd8qsuRxPsBv52XdX0FA
 rdqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+clepY5nYCoNdWvA/GSqTgXkMdwhQtFK54m3j52iiVbfoXFd2rGtQAXWsuOMnXEaf3IzryChpBRmz5@nongnu.org
X-Gm-Message-State: AOJu0Yx8gRby+wCNjKMf+bwjAKi+z5JRx3EWasrdlS18jwsRkgIserPh
 RNQO+/mWwYnkUNF2iJ357JQWsSSx6lN3dNBDGkNuCnJVcBHz6pWeXhMW
X-Gm-Gg: AeBDieskP8UFcayhrmRAm+Ta1deMVV4gBy8hxydU9lEXxXvdbnqwK0a9vsadDLLSoM4
 7lQRVqxruZsgTL6bBJZyOGoNJk+daqM+f0sWzrJHI9c7oMh5NiVRxt/mAIW8WkO+pJu/w95b2H5
 4mgByJ6zj5NOajBAgT3vSzKqu3vWwHMQRWi/CqxMWC9SwpPFdLEgUkaG5oUsXInKJx3nOrkg6Lu
 75E4A2NnVKd0ZjODMkU1CrIztbOLCgane8htuhPf/QxaSCb9NbN5VCAoze+OBhACeHYuy7xqawH
 pOtLKzOfuWnXZ7Ld8S3Km3H4OKybqwdVW1U8YvZRNd6zLL7JJjOH81KGEzhthsyuJBDSOX+9Inr
 BeTnZAufkxpmEOZM0bMDiSgIW8MYvJfuhY044aMpRb9Z12LgbpNCseXFT/jStr0AmeMuXmWXiq/
 1mtU98C3IatbKRN7jMYUu4y9anOpH9ewVGh/w8Jop0O5RxXwk2hNI2ze1/RiCnXITHtpL3omnNZ
 a+rJtSocZlSUk3HQMvBb3YSrhe2erPOlQfJjw==
X-Received: by 2002:a17:90b:4fcc:b0:35d:8fdb:4f26 with SMTP id
 98e67ed59e1d1-361403b7d66mr17266421a91.1.1776749641998; 
 Mon, 20 Apr 2026 22:34:01 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:34:01 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 13/13] hw/riscv/atlantis: Add some i2c peripherals
Date: Tue, 21 Apr 2026 15:31:38 +1000
Message-ID: <20260421053140.752059-14-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102f.google.com
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Use HWADDR_PRIX in i2c device string consistent
---
 hw/riscv/tt_atlantis.c | 18 ++++++++++++++++++
 hw/riscv/Kconfig       |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index bf08b7ed320e..5a6149064f1a 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -505,6 +505,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
+static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
+                                  const char *compat, int addr)
+{
+    void *fdt = MACHINE(s)->fdt;
+    hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX"/sensor@%x",
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
@@ -542,6 +555,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, periph_clk_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "national,lm75", 0x48);
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -870,6 +886,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
+    i2c_slave_create_simple(s->i2c[0].bus, "ds1338", 0x6f);
+    i2c_slave_create_simple(s->i2c[0].bus, "tmp105", 0x48);
 
     /* Load or create device tree */
     if (machine->dtb) {
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 4c2cf01995e7..a4427ba79807 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -137,6 +137,8 @@ config TENSTORRENT
     select RISCV_IMSIC
     select FW_CFG_DMA
     select DESIGNWARE_I2C
+    select DS1338
+    select TMP105
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


