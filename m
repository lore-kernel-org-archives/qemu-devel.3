Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA91C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag50-0000il-TX; Thu, 15 Feb 2024 13:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4m-0008Vv-6b
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:15 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4h-00032Z-Tw
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:09 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a29c4bbb2f4so154154066b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020186; x=1708624986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uuVnrOUAIUZkKyymxTIXoVEwsBVaCFKYc2xJo7UVoM=;
 b=WE9D0xRRC0KpZU8AqRW7qCx4D3ffLDDLCcekHkLKVkftVfsZB9fryy0OGFKIUFS6oF
 ssFLWMSkmCFV5ht6SToCTvcUlzY9Tqd0M45g3iwEnxwh9mPjc6e713P9UB4gxwHWMtq9
 TMLPoOTu7czN9Chl1XFAA6mvkrfri4AqsMcu7cOHbP21kl/YqBeaX4Q1RTabVqhIDMUU
 usNGyDKI2BgfzKhmAhXvg1H3upqeMIfDEwrHK/Ic7f230II836p39ftOGlLgqKSrqL4H
 Ug2HXmQNTIapKAx2TLJEZ9OJH4AAlQ2eEz+3N+lhxGY0xxbMi9oN5WvMD6YV1j3KAWfh
 u6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020186; x=1708624986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uuVnrOUAIUZkKyymxTIXoVEwsBVaCFKYc2xJo7UVoM=;
 b=gJdGM15guaKMoOeOidJVtbSy2hsf/7JVOD84+ZjVZgKKHdouVaj/RksWHMGxpwKblU
 rEsrYIZaMCuKG9PpmiTL2tfPRarILnGbvfbljQldJ6qMhw+NH/slYCE9tlWepFqFIlUn
 LqXJHyJs1TVU7GWidLSngCJNZCBxfXDiBrR3IYdlMW4quSZh9rShFV/Az+9Ba+x1UWWN
 8U87RYVeGyzR58GQB2gqlSCZ8D4OeMyxW8QxL/5Lh55i37nLw5esIBvzj9a2d0BgTD+1
 VBCYDhGOMU1ISWB6lVQUDWydCjf3c23DUYe9wcilI+pI9iMxdpNX/mjOcLOPVsh6F4lm
 vIzA==
X-Gm-Message-State: AOJu0Yyz3lXo9Ta59eQX7D+kAs5eZcBqrDkgsch9KPSdk61B44t4pCWU
 XLErvhSxkBegc514zqmH6YCg5XI4CCyyPWZArVsAJ7VJRlUH2kVVJsPuQYkUuxV+CP8gebAzFS5
 v9LQ=
X-Google-Smtp-Source: AGHT+IFzNrAFpkhgI9AAEfrM70+Id1w8APsRyVcqFaRC29cQ06DcEs1n65KD1wenLMnXCHTH8bDjhA==
X-Received: by 2002:a17:906:bc5a:b0:a3c:875b:f378 with SMTP id
 s26-20020a170906bc5a00b00a3c875bf378mr1375359ejv.36.1708020185956; 
 Thu, 15 Feb 2024 10:03:05 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a170906079600b00a3d4b488970sm788570ejc.45.2024.02.15.10.03.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 46/56] hw/i386/q35: Simplify pc_q35_init() since PCI is always
 enabled
Date: Thu, 15 Feb 2024 18:57:40 +0100
Message-ID: <20240215175752.82828-47-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We can not create the Q35 machine without PCI, so simplify
pc_q35_init() removing pointless checks.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213041952.58840-1-philmd@linaro.org>
---
 hw/i386/pc_q35.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b7c69d55d6..a785bf7366 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -130,8 +130,7 @@ static void pc_q35_init(MachineState *machine)
     ISADevice *rtc_state;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    MemoryRegion *pci_memory;
-    MemoryRegion *rom_memory;
+    MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
     GSIState *gsi_state;
     ISABus *isa_bus;
     int i;
@@ -143,6 +142,8 @@ static void pc_q35_init(MachineState *machine)
     bool keep_pci_slot_hpc;
     uint64_t pci_hole64_size = 0;
 
+    assert(pcmc->pci_enabled);
+
     /* Check whether RAM fits below 4G (leaving 1/2 GByte for IO memory
      * and 256 Mbytes for PCI Express Enhanced Configuration Access Mapping
      * also known as MMCFG).
@@ -189,16 +190,6 @@ static void pc_q35_init(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    /* pci enabled */
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-    } else {
-        pci_memory = NULL;
-        rom_memory = system_memory;
-    }
-
     pc_guest_info_init(pcms);
 
     if (pcmc->smbios_defaults) {
@@ -212,14 +203,13 @@ static void pc_q35_init(MachineState *machine)
     /* create pci host bus */
     phb = OBJECT(qdev_new(TYPE_Q35_HOST_DEVICE));
 
-    if (pcmc->pci_enabled) {
-        pci_hole64_size = object_property_get_uint(phb,
-                                                   PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                                   &error_abort);
-    }
+    pci_hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
 
     /* allocate ram and load rom/bios */
-    pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    pc_memory_init(pcms, system_memory, pci_memory, pci_hole64_size);
 
     object_property_add_child(OBJECT(machine), "q35", phb);
     object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
@@ -243,7 +233,7 @@ static void pc_q35_init(MachineState *machine)
     pcms->bus = host_bus;
 
     /* irq lines */
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
@@ -286,9 +276,7 @@ static void pc_q35_init(MachineState *machine)
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (pcmc->pci_enabled) {
-        ioapic_init_gsi(gsi_state, "q35");
-    }
+    ioapic_init_gsi(gsi_state, "q35");
 
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
-- 
2.41.0


