Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD007CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rgO-0002QD-7L; Thu, 09 Oct 2025 10:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rgJ-0002Nc-7l
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rgC-00032j-Rr
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso6314275e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020297; x=1760625097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=en3dcYp1l8Mnw3yI5A0cTlQE3qzHT+C3z70ER6xSWVg=;
 b=eZoHrsg1wQXHYXaMzLRcp/VUtBXKAaijst3LEc+rDjvMDS4qWkRbTtACntBHPIwtuB
 RUuhMJth14Kvhy7NriPLV8NA9a2nYfBR1kJea8A7U+MiZ93Dp7rB6kjHF89MRbNhuciK
 YYFouHsIXSosksjVL4i0aAvTmKlQJfYThGPBifiSY3iF/GfEIUioUvOoiDe442yOf8tx
 efOx30ME5x57/xm8I7Ww0CQr5JH8ofHppKZI4RUUEYjdDlZMXdq80XWN8MAtMTgUCUBb
 TT30gleeZ3bz+Dm9QVgNd1nmVapuVZWF06kkGs1976zz/QyPeywCmIdmL9887Dc1w1it
 /gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020297; x=1760625097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en3dcYp1l8Mnw3yI5A0cTlQE3qzHT+C3z70ER6xSWVg=;
 b=UCG1WHo/MdvcgSC7cvetlsNUGmNL5UxuDMZhSts9EZwNdZ1bw0I3QXrJlNmvVrvRdi
 QlujR18WzxorrVBuZqmIIsPBdppt6R7j0ZVQuSKSAuSXP3hiNORL4HJ5i/IAsdDxb6W2
 B0bbzpBwVOeb94Psqpb9Ri+h7c15+dQ5HfqZ1x7lVzVwGXi3z0puBLSJyETMsC5O+5jz
 G4a80UedgcqYioGi+E67NxIlxumcmit3v0CFn53yoL7uP+zKMpM0H+jaHAu0YSqvExco
 M67ytBNvX9Ti/GjRzd20vL/QP3gyw8kL/2JoUt11ut51qlQw02ALCjByG05effav6yBj
 O5iQ==
X-Gm-Message-State: AOJu0YzhCf2IlRA5wH6ZpSoGbv3kZXJ0aRMEVCuorekXnrQbYPvHfiac
 bm+8Ol7yVpYglmsxjV9OXNPtwdxLMjYDA0wLrJ5aq05wAdjmnr99Eq/NFv1lXp/YLR4hmwVy9wY
 6SRyxUvIiGmGP
X-Gm-Gg: ASbGncscp2zvwzT+NfuloEqh2scpUBm60tNK1bExxtRBWLjFvqJ+wAeCSAfUWYMakLV
 nTWk3gSJhWCu74W40g4yJwejHVba+oqfr5m9uGhtYLsXovJvHk5a1pyfo9bG0MxuoIRD32UMoVd
 9Ov7Rp01QiUn0b1UgW7Ey+TKN0fa10SWZ4ZJJtltGqmPwnGiIRChVZUWTxqtgCSiLPI/3nHFRp7
 ZcaAmXsd0ZYIKcFptHbLpjO5BrRqcfxYBDHqG8lr4npqGX0HXPiYOj9xAJ8NXQTM7p38cp2WU7I
 gNpmBr9kBIDStvNMhU7YAqt6q+BjxzChbJXqYQ/1dCnVmQzcgGXsowcpLS38JIYK40aLJniWOC/
 l9c7+1dEfhk8b5qyO2xBmha7h0t1e6gLuR8Ki5PjH+bpOVlzKDfOcYGBPNgwfNoCGKAahwd1tC2
 Pu7Yk3pygQ5fcUHmR1USlS8w1/oy3U3LMkZS8=
X-Google-Smtp-Source: AGHT+IE6XCqrEkYZB1CG3bgwp5GUeW9YMKqRzVMsUEGq39whnB9SXoJMtxcUNrfxeOCsEaZVfxA/xg==
X-Received: by 2002:a05:600c:4584:b0:46f:b42e:e367 with SMTP id
 5b1f17b1804b1-46fb42ee40cmr5271085e9.41.1760020296961; 
 Thu, 09 Oct 2025 07:31:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3e3520sm40997635e9.2.2025.10.09.07.31.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 07:31:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] hw/hppa: Move kernel addresses to
 HppaMachineState::boot_info structure
Date: Thu,  9 Oct 2025 16:31:06 +0200
Message-ID: <20251009143106.22724-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009143106.22724-1-philmd@linaro.org>
References: <20251009143106.22724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Restrict kernel* related variables scope, move fields that don't
belong to CPUHPPAState to HppaMachineState::boot_info::kernel.
Replace target_ulong -> vaddr type for virtual addresses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h |  3 ---
 hw/hppa/machine.c | 31 +++++++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 0aa06f6ebec..49d0243f677 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -271,9 +271,6 @@ typedef struct CPUArchState {
     struct {} end_reset_fields;
 
     bool is_pa20;
-
-    target_ulong kernel_entry; /* Linux kernel was loaded here */
-    target_ulong initrd_base, initrd_end;
 } CPUHPPAState;
 
 /**
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c315d13ea01..a50efac375d 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -50,6 +50,8 @@ struct HppaMachineState {
                 bool interactive_mode;
             } firmware;
             struct {
+                vaddr entry; /* Linux kernel was loaded here */
+                vaddr initrd_base, initrd_end;
                 hwaddr cmdline_paddr;
             } kernel;
         };
@@ -365,8 +367,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                                         TranslateFn *translate)
 {
     const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     const char *firmware = machine->firmware;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     HppaMachineState *hms = HPPA_COMMON_MACHINE(machine);
@@ -375,7 +375,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     char *firmware_filename;
     uint64_t firmware_low, firmware_high;
     long size;
-    uint64_t kernel_entry = 0, kernel_low, kernel_high;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
     SysBusDevice *s;
@@ -481,6 +480,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* Load kernel */
     if (kernel_filename) {
+        uint64_t kernel_entry;
+        uint64_t kernel_low, kernel_high;
+        const char *kernel_cmdline = machine->kernel_cmdline;
+        const char *initrd_filename = machine->initrd_filename;
+
         size = load_elf(kernel_filename, NULL, linux_kernel_virt_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high, NULL,
                         ELFDATA2MSB, EM_PARISC, 0, 0);
@@ -496,6 +500,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                       ", size %" PRIu64 " kB\n",
                       kernel_low, kernel_high, kernel_entry, size / KiB);
         hms->boot_info.is_kernel = true;
+        /* Keep initial kernel_entry for first boot */
+        hms->boot_info.kernel.entry = kernel_entry;
 
         if (kernel_cmdline) {
             hms->boot_info.kernel.cmdline_paddr = 0x4000;
@@ -529,8 +535,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             }
 
             load_image_targphys(initrd_filename, initrd_base, initrd_size);
-            cpu[0]->env.initrd_base = initrd_base;
-            cpu[0]->env.initrd_end  = initrd_base + initrd_size;
+            hms->boot_info.kernel.initrd_base = initrd_base;
+            hms->boot_info.kernel.initrd_end  = initrd_base + initrd_size;
         }
     }
 
@@ -544,9 +550,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                                                   : 0;
         hms->boot_info.firmware.bootorder = machine->boot_config.order[0];
     }
-
-    /* Keep initial kernel_entry for first boot */
-    cpu[0]->env.kernel_entry = kernel_entry;
 }
 
 /*
@@ -687,20 +690,20 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
 
     cpu[0]->env.gr[26] = ms->ram_size;
     cpu[0]->env.gr[25] = hms->boot_info.is_kernel
-                         ? cpu[0]->env.kernel_entry
+                         ? hms->boot_info.kernel.entry
                          : hms->boot_info.firmware.interactive_mode;
     cpu[0]->env.gr[24] = hms->boot_info.is_kernel
                          ? hms->boot_info.kernel.cmdline_paddr
                          : hms->boot_info.firmware.bootorder;
-    cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
-    cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
+    cpu[0]->env.gr[23] = hms->boot_info.kernel.initrd_base;
+    cpu[0]->env.gr[22] = hms->boot_info.kernel.initrd_end;
     cpu[0]->env.gr[21] = smp_cpus;
     cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
 
     /* reset static fields to avoid starting Linux kernel & initrd on reboot */
-    cpu[0]->env.kernel_entry = 0;
-    cpu[0]->env.initrd_base = 0;
-    cpu[0]->env.initrd_end = 0;
+    hms->boot_info.kernel.entry = 0;
+    hms->boot_info.kernel.initrd_base = 0;
+    hms->boot_info.kernel.initrd_end = 0;
     hms->boot_info.kernel.cmdline_paddr = 0;
     hms->boot_info.firmware.bootorder = mc->default_boot_order[0];
 }
-- 
2.51.0


