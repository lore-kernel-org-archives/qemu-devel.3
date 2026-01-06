Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C66CD043A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd05X-0005Gq-7q; Tue, 06 Jan 2026 00:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05T-00051I-IH
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:35 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05S-0002Fg-3d
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:35 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso595324b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679111; x=1768283911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKlNbHdgqXcrykZtAzAjsZ4B0GkSRVg9B9qhi2MmnfI=;
 b=UriKetAiZgXLyl5gH0wsZOuvS8zJp6ipk6xLYszb3bFlMyQ60ndw9Cljhw+czuBb4j
 7ZzBkS2pp0RSqWxLkKEBeXa1aPqfzcHY0hZMnS+irjeyJUCp+rv2it9fAXaUgIktZVZj
 xldyuykTzEL1qtUJ8hxX3+LwLLM5po4cuPQPv/XDHO8JBmAcJLV/n6qrAyVGMkmiJ4u+
 Wc3kModNxSIo/wRQC2UfqO7HtUNUIY7qk5/SFYUit1l/STxj3xq78Pm7EohEvle5N2YJ
 duUAjLUBuYNT3TPvTSIRYXhclYuFKb+PeI5fPz6wV1/Hmxk5nBrs4UBDYdaFXhpgTQvW
 WWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679111; x=1768283911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zKlNbHdgqXcrykZtAzAjsZ4B0GkSRVg9B9qhi2MmnfI=;
 b=kb5GZhK4CsI7inT24Kya2BNEi4HsvACPsoATuqHFH04eBShqjeWvpcaCv87ClZdNaW
 KilTRKeGpDltpz7k4B0nF7Djnbj9nipAL4pWtF6V5M+QvO/mpAysB3T3RJKyeHbss4su
 zIIAQkQe2KaoY9f0D0BIbPhPfCBRXjW4bPF+rRalSSGp6p01nJ6F56RC5Ra8hGSd/emt
 CsVDCyzNLOLNAbb8/qgcTjezVoL/qSo4TwG3/S8aZYXSotk2z4sc2hwXINbJ6wsEengf
 wqM2s1S7UoCnhPfNpepCpoFG8bE1FeSgQ69hreHP8MAzJA4b58ApJl+BaQ1MEYlxxGCg
 iJvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDtwr0HqbyoBSd540dseZr19ekWMrVEpiqq0eJz6t9Hkqj0oGn2rS/ztWXNwzKJow7yxiz7pR+weTR@nongnu.org
X-Gm-Message-State: AOJu0YxWc86NDdaZkMjYWLbLyqa3X1orhTtWQJ1bpxeivcGahWRD3XR4
 +2hLOQHMBxifckMzK2S9MB8tqek2HbQP5OfAFov5ecFehwh6SxH3bDF0
X-Gm-Gg: AY/fxX7lDpNNKPkrt77yIFRIDRqk23X5g2bXlkilYhIQRd3jBk681Nh0fqp99kmRidY
 9QlrOvNQAMIiERwtpqwSjBxkaScdYqHvu1fZAmEdIdudS/oDAjc93zLARU+xQ+Q0HE3f7gT5gHK
 UAXFPADfT1Hi9RsVfDvGN7kmaNNAVDQfybv8tNnRSY3T6TtA2OBBncSO3NG6gBRw/1I3DcYOApZ
 MzRKEBWSkLT3hen4mOwxVpLBAQhO4qyULcqGmqTqIQ3YEM0MArzYoiaX2Bho7BA1vkxkZ+kRSH5
 hCsOaKdQZ7dzEXG+cFiqzpXBGgMdP1Dn3uBmrblkfWZthEj+HiqAQge+Eyy0NbCBs18sKa4FYlh
 ppjmYapsVscoud0MuLhEkVUoe4278uxiLX5YOIlmmZfGO4HqWOXzEIfGvm/dIg8cyPXmhX0AV8s
 0glEEjYmOA7GtNnme8RUzc
X-Google-Smtp-Source: AGHT+IGLaOKVtG3bIj9Gu/F73cyxh3DvZQ/C5mXSsagK2j42yWAbR/iZmCMMwGY4ngCwaJ/KD7ny1Q==
X-Received: by 2002:a05:6a20:7492:b0:350:31b3:218c with SMTP id
 adf61e73a8af0-389822eda00mr1685252637.19.1767679110965; 
 Mon, 05 Jan 2026 21:58:30 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:30 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 13/16] hw/riscv/atlantis: Add some i2c peripherals
Date: Tue,  6 Jan 2026 16:26:53 +1030
Message-ID: <20260106055658.209029-14-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

Add an I2C RTC device and a temperature sensor. These are not present
on the board but help for testing.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 18 ++++++++++++++++++
 hw/riscv/Kconfig       |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 31714666b67f..f0ad7d574e03 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -498,6 +498,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
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
@@ -532,6 +545,9 @@ static void finalize_fdt(TTAtlantisState *s)
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle);
     }
+
+    create_fdt_i2c_device(s, 0, "national,lm75", 0x48);
+    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -852,6 +868,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
+    i2c_slave_create_simple(s->i2c[0].bus, "ds1338", 0x6f);
+    i2c_slave_create_simple(s->i2c[0].bus, "tmp105", 0x48);
 
     /* Load or create device tree */
     if (machine->dtb) {
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e2b6951192df..9662c32e4b04 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -147,3 +147,5 @@ config TENSTORRENT
     select FW_CFG_DMA
     select PLATFORM_BUS
     select DESIGNWARE_I2C
+    select DS1338
+    select TMP105
-- 
2.47.3


