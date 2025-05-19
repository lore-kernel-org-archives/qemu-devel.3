Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC93AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrvM-0004zV-0h; Mon, 19 May 2025 00:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrp6-00006A-H2
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrp4-0004Pr-OF
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-231e011edfaso27288075ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627793; x=1748232593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUel07T2/HTvJ6gY1GwCmjy3NTY5KoJHQtLnCUJUAEU=;
 b=SM3PalkiXrCxgzQLxniBirgUMFuogBybo4XQ+0+snlXtwd8Mv72Veba85nqOReijgb
 FD7bNhzKwWQYRU/+9+sRV2vvy4p7BwJeZHauAz42TS6yUI0iAkwyRdyIBst99CsuMW6d
 FAmXfP2vXdMx8IErLXXEXRWjecZOl6FliL2uGTmbWeV5uzXYi6Wu8AFSc4m5e2XcHcfT
 az/+pffx9tzYthou0okS2+41pR0cBPjNIaGEZ/Bx7YyBRJKcwGG5PyRTln1N2QiAmrhy
 NF/GhDKH5Uf7F9JQvKlB2P0lB6TgRG9nytcv4rFvh6Q9uT3bHENfIxsA5hqdNSyjHLCO
 HVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627793; x=1748232593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUel07T2/HTvJ6gY1GwCmjy3NTY5KoJHQtLnCUJUAEU=;
 b=msvt4GfGjkaVxRMtDNHvy6byrnZJvN8bKZ1U7ZPosPxqooz7j0550Bfai4OSHW++Pn
 Az+vudmtM2Ak+SK6e/krYoHqGumXHZb7TYOUXUl8X2Kil94skSIwEXCHzbRkHY8UYuL0
 v+YEVVfR/rs8Ixk1GH2ASTXYeePwdXjRy+KSOe6ecWm8l7XKxn9W/TiCVnuQ/Oo1/7h5
 I3GoZLfdqMBzGYCS2sTAsSMNcjKBCiOUyldu4HZvpDm9npxjDbwJjkkPGn+QLL2q6Det
 FE4M/9G7D1t1+xu7HgOJxMn4HnR6fqDw3NSoxn4HlJPYK4HnVe8rnCTJr9HmFpTRj6e7
 sUxQ==
X-Gm-Message-State: AOJu0YyMhtnUiTQAbC6FctgR/ZZjhwpCGAic5EOGKXNldWV6VdxgZdaH
 5XljnDsoFWeLtmfa2Fn3+2MpwwWcomnbb40TI9kj9U3TxKxb9B6Yq0jWXlnKhg==
X-Gm-Gg: ASbGncv9OeuDkNq9FhBNn+pMynLmAevXzIP2jmoxGQWnMNNjWvtxyMdT5pZ2OREnNlM
 uEb89hkhpuahl9n1Qm8OYz67hozCFzPIoD4IJVaB6i8lVc4edHGV88zvI5ZVOb2Orf5HK/53VbO
 27evAJEwl5Ce9DTHGfjnFncldyd2F5CfeIr6myVnwJxKP3b2U09h+U666gEJcC0qCw6N5qmEh3S
 GjF6hyi0m0OwD7WmcJf61jzUZU8muMnJ0suj/b37jGgGFDkbPtMtmFfd91qP6qMheQhFdRynLv0
 KjKBEi7ghXzE4BzSyno8Ya8KpySSnBzwkxLNdnlbmpamkEc9yt5XISPvCVQziz10861uKvKJqg2
 5M3qyG9U+bOf279HPIMwHva0kuwwLkf6FACdneGb33YMeVMU6uHAL0eXw
X-Google-Smtp-Source: AGHT+IH9fqUZrtkC5hWQMTn99H9X7r9jPEkKrrO5YVoc9icGHi5nEsHaQrirIjyUTif4qZO6QDCEBg==
X-Received: by 2002:a17:903:324c:b0:231:e331:b7c8 with SMTP id
 d9443c01a7336-231e331bbedmr113702865ad.17.1747627792935; 
 Sun, 18 May 2025 21:09:52 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 52/56] hw/riscv/virt.c: use s->memmap in create_fdt() path
Date: Mon, 19 May 2025 14:05:49 +1000
Message-ID: <20250519040555.3797167-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

create_fdt(), create_fdt_flash() and create_fdt_fw_cfg() can access the
memmap via their RISCVVirtState pointers.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3d547f7c2b..8a703a0233 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -996,7 +996,7 @@ static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
     }
 }
 
-static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memmap)
+static void create_fdt_flash(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
     hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
@@ -1011,11 +1011,11 @@ static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
 }
 
-static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
+static void create_fdt_fw_cfg(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
-    hwaddr base = memmap[VIRT_FW_CFG].base;
-    hwaddr size = memmap[VIRT_FW_CFG].size;
+    hwaddr base = s->memmap[VIRT_FW_CFG].base;
+    hwaddr size = s->memmap[VIRT_FW_CFG].size;
     g_autofree char *nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
 
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -1146,7 +1146,7 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
 }
 
-static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
+static void create_fdt(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
     uint8_t rng_seed[32];
@@ -1173,7 +1173,8 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
      * The "/soc/pci@..." node is needed for PCIE hotplugs
      * that might happen before finalize_fdt().
      */
-    name = g_strdup_printf("/soc/pci@%lx", (long) memmap[VIRT_PCIE_ECAM].base);
+    name = g_strdup_printf("/soc/pci@%lx",
+                           (long) s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_add_subnode(ms->fdt, name);
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
@@ -1185,8 +1186,8 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_flash(s, memmap);
-    create_fdt_fw_cfg(s, memmap);
+    create_fdt_flash(s);
+    create_fdt_fw_cfg(s);
     create_fdt_pmu(s);
 }
 
@@ -1715,7 +1716,7 @@ static void virt_machine_init(MachineState *machine)
             exit(1);
         }
     } else {
-        create_fdt(s, s->memmap);
+        create_fdt(s);
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-- 
2.49.0


