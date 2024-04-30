Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A080DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p4T-0000zb-Dk; Tue, 30 Apr 2024 11:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4O-0000yk-At
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:00 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4L-00009c-CY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e78970853so11277467a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714489615; x=1715094415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0i9FUHD/N+BQW7gsC/zN6TOWAHyJbmLzPXaTR2+a3Ic=;
 b=RArW63rN7rX6pgirg32Ox7lxHnC3itzs3fleV23M+mHpylhXkC7jfbTpYsRy0WCivd
 SushV+0ZrCW8+U8hnj/YUbOVM7E/ANGaEr0687IEfEHTgWEOhjWJ8NY/KZzXpqbp7rSC
 SiMk1RP0HfnJxdXprTjpoDOZ9XFpQAIqggQaqzZgfi+cE7qbBuHcn7aFPeCCOcPsggaP
 CZyMC+7hbwqnVkTg0MqQO9mHxCpTPJV2fRdmdGvG0J8Pmw51Zs/jhIhmFR+YYLgENrP/
 87/X0c45DQvrx8yVeTZF0rAusm5AKOoegliogbd77EdFsm1CVRxeQbFY/f1V2V089Wzc
 d+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489615; x=1715094415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0i9FUHD/N+BQW7gsC/zN6TOWAHyJbmLzPXaTR2+a3Ic=;
 b=Hb5C6XBRGBMp1CENHaVU/5xImLcgQauuLQW8vW80LVRy1QyuE7oESSQnzlJXD2SbKn
 Ps0aZi4OvtwlXHu15l3xhVzTVGYSENQM7j0EZOGKDC1Uxty31HRO/2DW22Q2VUMY1I2O
 K6FUfnYbO0S97qujD2hSGM/BnlVW8tgg4Mj4WdMFi7bEij15Ueua7x1uET6BAGNVwHJc
 yWEA1bzUta5hJ+bElAc9vWBIqS/mkUZJwkPB6uFC7ZSiZoAIAe4uo9RdeXsi9RJGYiSw
 fIf71LL8LL/WR2QKhfKd/BJPf5WfordZcyeaFwzjJZ5qnG+oVNkQ1UUteH3fxcMHlBdv
 +dTw==
X-Gm-Message-State: AOJu0YzMZ1QuXGG1haGx00QjScyjBgkgX5XqZrA2byRGnw/YFKZcUnVf
 KDvpIsmA73jDe0z2SKUXv5DeNk3z7OKSKMXNK48erXBYXAxdbfNX6BUbLQ==
X-Google-Smtp-Source: AGHT+IEl/sT8uXkYHBLS25tg8JhDzAHwSfLnAl/EisDKH33OJ9zw2WR5+tZ5b7qlFYzxfk0oilSVKA==
X-Received: by 2002:a50:8750:0:b0:571:da40:22d9 with SMTP id
 16-20020a508750000000b00571da4022d9mr2651583edv.10.1714489614789; 
 Tue, 30 Apr 2024 08:06:54 -0700 (PDT)
Received: from archlinux.. (pd9ed788d.dip0.t-ipconnect.de. [217.237.120.141])
 by smtp.gmail.com with ESMTPSA id
 11-20020a0564021f4b00b005727e826977sm2345741edz.19.2024.04.30.08.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 08:06:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 3/6] hw/i386/x86: Don't leak "isa-bios" memory regions
Date: Tue, 30 Apr 2024 17:06:40 +0200
Message-ID: <20240430150643.111976-4-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240430150643.111976-1-shentey@gmail.com>
References: <20240430150643.111976-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fix the leaking in x86_bios_rom_init() and pc_isa_bios_init() by adding an
"isa_bios" attribute to X86MachineState.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h | 2 ++
 hw/i386/pc_sysfw.c    | 7 +++----
 hw/i386/x86.c         | 9 ++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index cb07618d19..271ad50470 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -18,6 +18,7 @@
 #define HW_I386_X86_H
 
 #include "exec/hwaddr.h"
+#include "exec/memory.h"
 
 #include "hw/boards.h"
 #include "hw/intc/ioapic.h"
@@ -51,6 +52,7 @@ struct X86MachineState {
     DeviceState *ioapic2;
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
+    MemoryRegion isa_bios;
 
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 59c7a81692..82d37cb376 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -40,11 +40,10 @@
 
 #define FLASH_SECTOR_SIZE 4096
 
-static void pc_isa_bios_init(MemoryRegion *rom_memory,
+static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
                              MemoryRegion *flash_mem)
 {
     int isa_bios_size;
-    MemoryRegion *isa_bios;
     uint64_t flash_size;
     void *flash_ptr, *isa_bios_ptr;
 
@@ -52,7 +51,6 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
     memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                            &error_fatal);
     memory_region_add_subregion_overlap(rom_memory,
@@ -136,6 +134,7 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 static void pc_system_flash_map(PCMachineState *pcms,
                                 MemoryRegion *rom_memory)
 {
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     hwaddr total_size = 0;
     int i;
     BlockBackend *blk;
@@ -185,7 +184,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(rom_memory, flash_mem);
+            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
 
             /* Encrypt the pflash boot ROM */
             if (sev_enabled()) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6d3c72f124..457e8a34a5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1133,7 +1133,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 {
     const char *bios_name;
     char *filename;
-    MemoryRegion *bios, *isa_bios;
+    MemoryRegion *bios;
     int bios_size, isa_bios_size;
     ssize_t ret;
 
@@ -1173,14 +1173,13 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(bios_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
-                                        isa_bios,
+                                        &x86ms->isa_bios,
                                         1);
-    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
+    memory_region_set_readonly(&x86ms->isa_bios, !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.45.0


