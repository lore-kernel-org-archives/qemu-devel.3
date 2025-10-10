Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C52CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76T4-0001jA-O5; Fri, 10 Oct 2025 02:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76T2-0001h0-AQ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:19:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76Sz-0001HJ-Oy
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:19:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso9721875e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760077137; x=1760681937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74/Rvt9xzTS9fCSsduCNSLfQP+B5/7nDG11bj0TrU+M=;
 b=a1iAUAgOhu+0ixKtLrUhpmPznQz+bRidXlnvAsRqaUS9UAnYHw5+hlXvoFe7L2cJWx
 ZfVVEP4JImENrFA4EfOqJSeFQQLQi3huMiLp4oyim398Bz0gKqSLssgSAVkEa0Oh5KjV
 h/x0bEFTgAnMLJTRpa7JblmBypSsMhI/ziVFbK/SICz6lSN+mx3lAOo9Bb0yLgX0Oj+p
 M9JcfdZas0YyEL87GHxRXSOJH+cIxTyyk/ivlRjIrSc6tY5T78u9HN7nl9qwCuAFtSEz
 kQh+RpcyMAlZgUEYRlB8O3WDr5gQtsTcyyqqmZk2L+A0bTu/AANNmjMu2sLssguir5aX
 +PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077137; x=1760681937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74/Rvt9xzTS9fCSsduCNSLfQP+B5/7nDG11bj0TrU+M=;
 b=jyZFAj29nd0pPJe4c+D7pK9EuM22XDqvkJtIhPBWxutfuwmQi0tMPInYybuRp6pd2g
 Nr7g2hPxU5+0ZAcxWC+iCLr6Mb6Yh/J4SWI7O/kalGzyCfd5rhQKJFFB5k31HN42Sz/Y
 WxqqeRfFloafDmy9YVCr0uUltB92nG9HcYhYuR8IdW+SGPZ0sSVPPCAl+Wa4Dtb4rsx1
 9p9anzJcnX15hCwa/RBWPUeb0RC5mAePaESDyH1Q4c51G2YMYsHhh4dSKGa47LgP2+Oy
 26DgI75hjNTgLczqcg8BF1hqCO+dJkJHN6NqFeqDybAEplF8bzizEHFKmt0XFpHYxUtG
 vITw==
X-Gm-Message-State: AOJu0YzbbaE5uo8JsjdSgMubULunZ4KxWDbY5KyOwYS8VhObUgIq7kgv
 e54WvUjPKlPdnfAu5CUxBA1zBD0MWJaglynnH7QbU7GEl5xZfanSONhuFl6WTPpP47qouDLGRJb
 z/3wGjeFst0MA
X-Gm-Gg: ASbGncv4UHFKt/khuZ10K37fHAeBBphloD1YjhYhCfKkChc+JV2eFNqHM0AyVdfk4T1
 ruTWaj151wC+ffm2yESrNVl9bs3N5G8rJydgTDHg1BW6s6nJ7Rd0XE6MkM4LrVy6mTD09S1k1/d
 1SS2WbjzPw564nt9AT0cAsWFMWKwNVrTErYq1BTmwdUT2yKvFI5L7lWo5CxduLrlvvwFKgxtYr4
 9eksslMHY93Q0uQm5DTsKmh7pU9Nw8ek8kzfPNhahF8gQ1KVV319//elRwfxiWmtuuujwUVKQXG
 CgCNWXJ8dsW9HzHZY7lv/CWnpRTmqlYs1f83EpjDtN/4kp7n9htyrVVUfGyctAMNGvPX6kNSogC
 bORfdps1mlUNkPJflN9cqipnx3iR/Reuow9jdMDVihKP2Hml55HY8DHX5RAn2jfCIY93vMW9SMs
 iHpiOkfyn6+ZyPmYhQugmXGCzS
X-Google-Smtp-Source: AGHT+IHbUXpWdQ/Sl4NeVsEe2ZoNLivsjOsukVXkPfl+2FWwOGiq6nhJUHxhxdgcY2XaTGRTrSZTKg==
X-Received: by 2002:a05:600c:46c7:b0:46e:36f2:2a62 with SMTP id
 5b1f17b1804b1-46fa9b08c22mr67037975e9.27.1760077137084; 
 Thu, 09 Oct 2025 23:18:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4989601sm27999805e9.9.2025.10.09.23.18.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 23:18:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/6] hw/hppa: Move CPU::kernel_entry ->
 Machine::boot_info.gr25
Date: Fri, 10 Oct 2025 08:18:34 +0200
Message-ID: <20251010061836.45739-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010061836.45739-1-philmd@linaro.org>
References: <20251010061836.45739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Current code uses CPUHPPAState::@kernel_entry to hold either:
 - kernel entry virtual address
 - firmware interactive mode
and CPUHPPAState::@cmdline_or_bootorder to either:
 - kernel &cmdline physical address
 - firmware boot order

Besides, these variables don't belong to CPUHPPAState, they
depend on how the machine is started, and only apply to the
first CPU.

The MachineReset handler initialize some registers of the
first CPU. Hold these register reset values in the MachineState,
initializing them once in machine_HP_common_init_tail().

Start by addressing the kernel entry and firmware interactive
mode values, stored in $GP25.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h |  1 -
 hw/hppa/machine.c | 28 ++++++++++++++++------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e14f238827b..f54634db7f1 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,7 +272,6 @@ typedef struct CPUArchState {
 
     bool is_pa20;
 
-    target_ulong kernel_entry; /* Linux kernel was loaded here */
     target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
 } CPUHPPAState;
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cddca69b938..7066f6d575c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -41,6 +41,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, HPPA_COMMON_MACHINE)
 
 struct HppaMachineState {
     MachineState parent_obj;
+
+    struct {
+        uint64_t gr25;
+    } boot_info;
 };
 
 #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
@@ -353,10 +357,10 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 {
     const char *kernel_filename = machine->kernel_filename;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    HppaMachineState *hms = HPPA_COMMON_MACHINE(machine);
     DeviceState *dev;
     PCIDevice *pci_dev;
     long size;
-    uint64_t kernel_entry = 0;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
     SysBusDevice *s;
@@ -468,7 +472,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     if (kernel_filename) {
         const char *kernel_cmdline = machine->kernel_cmdline;
         const char *initrd_filename = machine->initrd_filename;
-        uint64_t kernel_low, kernel_high;
+        uint64_t kernel_entry, kernel_low, kernel_high;
 
         size = load_elf(kernel_filename, NULL, linux_kernel_virt_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high, NULL,
@@ -484,6 +488,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                       "-0x%08" PRIx64 ", entry at 0x%08" PRIx64
                       ", size %" PRIu64 " kB\n",
                       kernel_low, kernel_high, kernel_entry, size / KiB);
+        /* Keep initial kernel_entry for first boot */
+        hms->boot_info.gr25 = kernel_entry;
 
         if (kernel_cmdline) {
             cpu[0]->env.cmdline_or_bootorder = 0x4000;
@@ -520,19 +526,16 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             cpu[0]->env.initrd_base = initrd_base;
             cpu[0]->env.initrd_end  = initrd_base + initrd_size;
         }
-    }
-
-    if (!kernel_entry) {
+    } else {
         /* When booting via firmware, tell firmware if we want interactive
-         * mode (kernel_entry=1), and to boot from CD (cmdline_or_bootorder='d')
+         * mode (interactive_mode=1), and to boot from CD (cmdline_or_bootorder='d')
          * or hard disc (cmdline_or_bootorder='c').
          */
-        kernel_entry = machine->boot_config.has_menu ? machine->boot_config.menu : 0;
+        hms->boot_info.gr25 = machine->boot_config.has_menu
+                            ? machine->boot_config.menu
+                            : 0;
         cpu[0]->env.cmdline_or_bootorder = machine->boot_config.order[0];
     }
-
-    /* Keep initial kernel_entry for first boot */
-    cpu[0]->env.kernel_entry = kernel_entry;
 }
 
 /*
@@ -650,6 +653,7 @@ static void machine_HP_C3700_init(MachineState *machine)
 
 static void hppa_machine_reset(MachineState *ms, ResetType type)
 {
+    HppaMachineState *hms = HPPA_COMMON_MACHINE(ms);
     unsigned int smp_cpus = ms->smp.cpus;
     int i;
 
@@ -670,7 +674,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     }
 
     cpu[0]->env.gr[26] = ms->ram_size;
-    cpu[0]->env.gr[25] = cpu[0]->env.kernel_entry;
+    cpu[0]->env.gr[25] = hms->boot_info.gr25;
     cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
     cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
     cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
@@ -678,7 +682,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
 
     /* reset static fields to avoid starting Linux kernel & initrd on reboot */
-    cpu[0]->env.kernel_entry = 0;
+    memset(&hms->boot_info, 0, sizeof(hms->boot_info));
     cpu[0]->env.initrd_base = 0;
     cpu[0]->env.initrd_end = 0;
     cpu[0]->env.cmdline_or_bootorder = 'c';
-- 
2.51.0


