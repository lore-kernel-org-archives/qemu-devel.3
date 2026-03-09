Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3153FF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbxT-0004Vn-Us; Mon, 09 Mar 2026 10:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwO-0003ey-SC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwM-0005fv-Kv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so9113582f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067837; x=1773672637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YdImuSiTgRit+WE2vfmD4259XqnT2hI0YRmPa0sotE=;
 b=eN4PiNCBHp1kAZjodDUHriMuZkgtsD04ueO75TQzjfOYytVtqLLW6vQY1W1Ac8qA96
 KOSvKOUjhb8N18UHYeny3/Nd369lpya1G2nVir4KPco+H03QsIPNOgyu3TskZNrHBRoo
 y/b6Jow9FveLOX3C6PgvqTjwkOxICXsUSu1+wRkItli59UjbY5kRHSmwqx/0xOzZgKqz
 m2ozWXK797b/f7h5yOufZcXdpOp2bQK/B1Zz2EayAzJqGgb0+w6itwaBcN8vRGEvnHvz
 rmMf9pko5m1MpSps8HVYhOiCVbL5gxR8u9b4PqDmEk5VE36fOO5c4Z5EBpsxaNHZ/RNL
 D7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067837; x=1773672637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4YdImuSiTgRit+WE2vfmD4259XqnT2hI0YRmPa0sotE=;
 b=GVrrt56JUkkFl2QiMxecQy9Ok55Aybgu2UbRdtDkMmxSoDh2cSRnF5mrDkzuPxuEri
 qZwyVY46wi3c93Do2FcK7XyVHBObCIaT90OLJJ+py/rKdP3YPYVTbqlU4krBulAI2I6w
 0IVte5CLjiQLw+af58MepAkH+R0AhvMtSlZX+XJK1iRxOLHnC7woUDdxsEmtuS3OpFpr
 7PJKQIBxWR6K3PmclZU8yt/95MqWK67aQnKKNd5V6e1U3J/nv91r5s2CHKSZjRpzyzUv
 GhRm8vG/zvIUrHmIBus4PSTKxPyl2qGmOuScM45PHGIjAXBzj9RRiVIvsiIUH4/bolyV
 PsDA==
X-Gm-Message-State: AOJu0YzGuC0l151aZUunlEtqvNY1zO5Ybio3Vr7fSvYf4ujtR5UDcNFs
 UuRrBpC8RxHWD+q6vnohC99MTQ3fyDegz67oEOLEv5bgczPyGLrNu/K/JbDIER37Yx3oMyruU9E
 LEEsjWCo=
X-Gm-Gg: ATEYQzyavBaUdI8kjwhW6GRcjfggimu8fg9olO+W0ala3e41a2IG8rwAJjyekMiXBOF
 KWUjFCaEOOBwgarTPa3tAyY+Z1wJOrW/cE0+Yib8KUN1KI6o4CCJ1b/XYHszrNUHzDRTYCyRaYX
 2DotjJ4y97u8Ow6kPexXcGs6hRQoZLqmNnZ74PX4nXwiLKapTvcB++iEZGgMit5I+z7SfUUYwoL
 87VjK0AI8HoPdVR5Wm8g4+c92H5kUBlmUMogyyPigQTiOSfBMym+PSv9RUidD/018IIlz21UlTv
 NtYj+go+cC5WcNeb+FHJmEtf8Sc4tl09qBzQBQPX3yrJjIaXaC1aPthMWwu6xiCRIFWFxL4AWQ2
 yuiviipB0XI448bJjcRJkfxMr6kQ6cCH6plE2Dqnhy3+5QodYMCuQh6jxONEMRzP6ip4JjOX40W
 2t6UzumvNPlyF6jQiwsds3e0152uLiD7EYOew4ZtzwKpqNhi2a2E/UmiByT/ynW83nddCqrHQFa
 Jcqnw==
X-Received: by 2002:a05:6000:420b:b0:439:b3d2:3765 with SMTP id
 ffacd0b85a97d-439da55a1f6mr18047442f8f.1.1773067836734; 
 Mon, 09 Mar 2026 07:50:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3c80esm24290704f8f.29.2026.03.09.07.50.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:50:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <graf@amazon.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PATCH v2 03/10] hw/i386/x86: Remove @pvh_enabled argument in
 x86_load_linux()
Date: Mon,  9 Mar 2026 15:50:05 +0100
Message-ID: <20260309145013.44327-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

x86_load_linux()'s @pvh_enabled is now always %true: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-4-philmd@linaro.org>
---
 include/hw/i386/microvm.h | 2 +-
 include/hw/i386/x86.h     | 3 +--
 hw/i386/microvm.c         | 2 +-
 hw/i386/nitro_enclave.c   | 2 +-
 hw/i386/pc.c              | 4 ++--
 hw/i386/x86-common.c      | 3 +--
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 6b9a5065272..184b7a8c094 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -79,7 +79,7 @@ struct MicrovmMachineClass {
     HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
     void (*x86_load_linux)(X86MachineState *x86ms, FWCfgState *fw_cfg,
-                        int acpi_data_size, bool pvh_enabled);
+                           int acpi_data_size);
 };
 
 struct MicrovmMachineState {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index a85a5600ce9..71fe6b5e122 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -129,8 +129,7 @@ void x86_bios_rom_reload(X86MachineState *x86ms);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-                    int acpi_data_size,
-                    bool pvh_enabled);
+                    int acpi_data_size);
 
 bool x86_machine_is_smm_enabled(const X86MachineState *x86ms);
 bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7ff20512636..5a7889f21b8 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -330,7 +330,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        mmc->x86_load_linux(x86ms, fw_cfg, 0, true);
+        mmc->x86_load_linux(x86ms, fw_cfg, 0);
     }
 
     if (mms->option_roms) {
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 640b1d8c548..8e72dc49f34 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -199,7 +199,7 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
         machine->kernel_cmdline = eif_cmdline;
     }
 
-    x86_load_linux(x86ms, fw_cfg, 0, true);
+    x86_load_linux(x86ms, fw_cfg, 0);
 
     unlink(machine->kernel_filename);
     unlink(machine->initrd_filename);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3fc2f0a057e..00581dd8b44 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -597,7 +597,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
+    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
@@ -931,7 +931,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
+        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index db8d4e855f4..fde05fa7d7b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -642,8 +642,7 @@ static bool load_elfboot(const char *kernel_filename,
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-                    int acpi_data_size,
-                    bool pvh_enabled)
+                    int acpi_data_size)
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
-- 
2.53.0


