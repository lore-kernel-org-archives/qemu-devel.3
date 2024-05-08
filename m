Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6805FC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lVr-0001Bk-Lg; Wed, 08 May 2024 13:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVl-0001AS-9Y
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:25 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVh-00027w-Km
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:23 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a599a298990so407166b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715190919; x=1715795719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJDIVyxjPNuLrERcUUBAFqkvrcsC+w94NadcVcwbfE8=;
 b=fjgCW4K1u/rWLhqB32PJ1ahsIZHBFWERA7gHJ+vtzqD9j+ULLwLuSBHuidqu95rfyj
 +pzkpEjljXpSCR6JC2UySVcj393COPu+4tthEHysERgPtrtEYrI4zBY4525MmMFVjxt4
 6mmgYmVaSsbLVczQA2oiA3hRoO059W/DkSYtoRH5/cz+4BshGXEZvcMwZFW8nIopm8Qo
 RYziIh+snS6Md7JGUyZUkbQwrVhVf2l7OOtYeLKhKWzLHi+VBwXhzZRqTDHP7QOBlB89
 msBeyaOxNybVnVzDMUW7l1d6WM2oK+kE4SwO+txfZZ5IMcjj8axl4F9FX886okiaysfj
 n7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190919; x=1715795719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJDIVyxjPNuLrERcUUBAFqkvrcsC+w94NadcVcwbfE8=;
 b=obVFbQdCVpQfi5R+fgcWWvQ01g5q2UD2tDs/Nfc5YiWaI7ADm5h8ENWGeDVsn3yy83
 xjrf5YwwrjVY88sfFUNjKFot/R5eQTLTXts6L1UDYMysRsecJhRMDAQs+zXxqthDF182
 2bw3gyxZP8Zt7TY459RcjQ+9KI+S22rRJDqofSuGiTiqSjBwOpn9Xzqg+8h4xpeOPWOx
 Ii8LW+2ruUNJG1gNQKaIvj1gL5I9sXX0YWTukGCaPdsyGmmBvt32/tlgiLHa+QfSWwrM
 EuOmOBdUrdI+FmUy960S9Ju2+bujqufaYPnoLDIwE0v275/TzWHBQ97dToydyMwBYQvY
 aFjg==
X-Gm-Message-State: AOJu0YyE0i0guwtXKc/FVVmTdW7G7zlQXz9rYEHPQ5f0CPT1ke7S5UVc
 sPfrjRHGAN7D1vKvNPTR+5GrrYYdivlZbVHh2JbU7FdJJCpx0B9zQFoeoA==
X-Google-Smtp-Source: AGHT+IFwJm8yLM/cJw31QY5OGB2pf+OKfGhDNpWVW2zFV7wdn2Dz4pbG1gIiPhJ/EvklV3Lik0bvTQ==
X-Received: by 2002:a17:906:3544:b0:a59:c319:f1de with SMTP id
 a640c23a62f3a-a59fb92142cmr205465366b.15.1715190918964; 
 Wed, 08 May 2024 10:55:18 -0700 (PDT)
Received: from archlinux.. (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm4483821ejp.80.2024.05.08.10.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 10:55:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 2/6] hw/i386: Have x86_bios_rom_init() take X86MachineState
 rather than MachineState
Date: Wed,  8 May 2024 19:55:03 +0200
Message-ID: <20240508175507.22270-3-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
References: <20240508175507.22270-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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

The function creates and leaks two MemoryRegion objects regarding the BIOS which
will be moved into X86MachineState in the next steps to avoid the leakage.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h | 2 +-
 hw/i386/microvm.c     | 2 +-
 hw/i386/pc_sysfw.c    | 4 ++--
 hw/i386/x86.c         | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4dc30dcb4d..cb07618d19 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -116,7 +116,7 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
-void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 
 void x86_load_linux(X86MachineState *x86ms,
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 61a772dfe6..fec63cacfa 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -278,7 +278,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     default_firmware = x86_machine_is_acpi_enabled(x86ms)
             ? MICROVM_BIOS_FILENAME
             : MICROVM_QBOOT_FILENAME;
-    x86_bios_rom_init(MACHINE(mms), default_firmware, get_system_memory(), true);
+    x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
 }
 
 static void microvm_memory_init(MicrovmMachineState *mms)
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 87b5bf59d6..59c7a81692 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -205,7 +205,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
     if (!pcmc->pci_enabled) {
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, true);
+        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
         return;
     }
 
@@ -226,7 +226,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     if (!pflash_blk[0]) {
         /* Machine property pflash0 not set, use ROM mode */
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, false);
+        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2a4f3ee285..6d3c72f124 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1128,7 +1128,7 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
-void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     const char *bios_name;
@@ -1138,7 +1138,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
     ssize_t ret;
 
     /* BIOS load */
-    bios_name = ms->firmware ?: default_firmware;
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         bios_size = get_image_size(filename);
-- 
2.45.0


