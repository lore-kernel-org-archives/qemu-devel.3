Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C85BC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 04:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZkH2-00054B-2t; Mon, 12 Feb 2024 23:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZkH0-000543-Vl
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 23:19:58 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZkGz-0002rz-B8
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 23:19:58 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3566c0309fso471758766b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 20:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707797995; x=1708402795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4c+pEmVTR6F0UzIp4J5WPN/yZvO+7j9ZAv4sXZea+Z4=;
 b=hf2T9nCm1lmjHVehaCvpLu2lppp0VtKtaL91CpKxmCTgfOX/6T07/EyZHMZwu5IQFH
 QJXNOPsc4J7H7AgOTSH7PndatcHU1GSYUn8RRCCtgW8DzCHjxr+MNTzXRumwMfai84O6
 pTAPKo7ZFBoffbjy7c63OtHaWP/Lupnuu4mb9sedRe8dPf9SIJY0FXpj2jIxgVyO8xC7
 UAwiMISW4iAUbJ0W3JASMFt4CpwJjSbs8jc/Q/exQ4ehka0F1Y9q4YPpEHfXh/F9biVR
 8CVZvwpKBoY50zf45WC687vT0m8OvRDdTDw+26y7Wi+RavcgScYSBmkboqloTkeLjWpm
 4aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707797995; x=1708402795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4c+pEmVTR6F0UzIp4J5WPN/yZvO+7j9ZAv4sXZea+Z4=;
 b=OTUwwcD3p/mcLML2s7qZ03iiKCWl0KzjRwr2/qGr4PVMIU58eb06+4tsW3x6IArcni
 ddFzbOIeeRCyS391yDi0pmk13biWkNgXVGQt+VFxzQFUeoqHW+yG8EmpSp98rCPGsxg0
 ekEjkwHdENKA9GGPC398fSJKT+1wuuV5CVaVbu0YWZwc1raTsPdsxEXTG4rkEL5i/Dd3
 Pt6sFN5WcIBCGOyHdHDrr1LVvuK0HAM86GOsk4kpm0vQRH8LKGRNEfoJ7WZmeBx39pqS
 ZNXQDEoGFQOVmZ96MZD7AxerrNwIbgOBiErtXhQijmvLcwdwTnnYCLPOyrZAjN3eaaXn
 Bbig==
X-Gm-Message-State: AOJu0Yx/N01hHkRIeyNySF0vRM3Mgs0HK0dWnplgIqHVl70DvN7fl4nw
 2UvSII5ZVJLaDiHwlOjEAyY0sb0VtbDt038yBZrs1bp5xZOozNQJXB5Y08FHYAsgWtqppjxr3kB
 3
X-Google-Smtp-Source: AGHT+IHTNWLwS5ARg1hXVXiwxaPuD4PD9L4aSzbSlrxZ338G70lnFvgi0mGLwTPjZXkMbK7YOtWWuA==
X-Received: by 2002:a17:906:5ad8:b0:a3c:9bc7:7a0e with SMTP id
 x24-20020a1709065ad800b00a3c9bc77a0emr3199632ejs.9.1707797995308; 
 Mon, 12 Feb 2024 20:19:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUMU9UWbR8rzOiPYzCS+C32rtoQTffTPX9Ensw9MBqKktpZyQcUsi255DsHdZgZL/pizKcvPqLw8GAUWg02CeHw7QdxBBd8mScX8aRK82W3X8htq1wGee7sFwOEf2SDLXZ37bUVhZ0rqmBv5VEeLv4AsBH6U5VILyLMTfHQnqrOV+JjSdkhyYSlvQyMtRTYZNdAVK53KDlaDZnhS/1wNA7Nq+YNevCkK+eSVQ==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 vi16-20020a170907d41000b00a3ce31d3ffdsm697108ejc.93.2024.02.12.20.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Feb 2024 20:19:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/i386/q35: Simplify pc_q35_init() since PCI is always
 enabled
Date: Tue, 13 Feb 2024 05:19:52 +0100
Message-ID: <20240213041952.58840-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 hw/i386/pc_q35.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7ca3f465e0..5923621845 100644
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


