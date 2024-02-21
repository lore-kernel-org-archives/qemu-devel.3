Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5482EC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyw-00073U-6p; Wed, 21 Feb 2024 16:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctys-0006gI-F1
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:18 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyq-00015l-2g
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:17 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d8d208b6cso595f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550294; x=1709155094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NDbYpJ4EdF7CcKKuGkJjZq3a85KtwD7y7arPJ8C56o=;
 b=Fcy48vvJC/x4A5u1WeCitCOwaTN71l2VQcECTFTZ22Rr+V93KuX88rQ3CWmOWOUh05
 B1bp2SHHSrLPDI9XhGKbKafEP0Cavhva9vRUs6WJ4W7JE5+GnVi1dbUbq7zzkc3z/5M5
 PP/SnK586LUNmAXtw8nJTutPoABAKP4VVHrpz5wc1r0mnCObZvNvQgYuB1UzDHU8DVRh
 1Opl6xAAdxnu30FESgKlcwWOequgKOLUy2wCXeQ/aCfRkV52VgtBwRc/Mt/uCQiwW7FF
 Tf6nR72AwY4ElxKRQV5uN6I7LcuBFS+1J9UUdre+p6gvz5P6SyZ7Fo4/55i96S6YnQoi
 6Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550294; x=1709155094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NDbYpJ4EdF7CcKKuGkJjZq3a85KtwD7y7arPJ8C56o=;
 b=iAjRFRoxO1JOtX91HNBoCIfH5Xko/LZYyzDn81Jk8A1IRSY7sUCmIjuA8GGekmEBiD
 xFVX1aSGp31nqiQtmkPgNP/+zZFbQY8iyqNfo9mfIP+ZLl66tR2taU7lz53nBcKKz8zH
 i3VY14yGBF2HlG8yegcLbe5eZDpG4uZLbyhQK6LWHp1gD45Q5GEe7LOC/+xMMX28VUw7
 CvE8zPVwydCZpThQQOOzMGsa0c1MIiRsh1ioEI8p3EikVpFsEs0WGJJGy2DpNg5J97nN
 vWEp2PcOxpurqvUa/BVq/xtE+79ua1YJ3/lQOAyzxkXdKz704LBEDcAvwOwObN+K1B2l
 JVGw==
X-Gm-Message-State: AOJu0YzSNh8xslXpdA6fGEOqn1GSbIihUO+T8hAOkuSVdwA9HE+d9K26
 fEfekHgEqUYTaP/1sYJoatuBJmwEBBuVqwCr5j/g9FWdc6zV3iZKqmxfvtUoZYJZyBm7OHN03Kf
 7WBs=
X-Google-Smtp-Source: AGHT+IFAx7WCd1TmdeuPOUJGYz3Po7jcSdPBcpZ4VkRMx4n8rWfj2TcxiZ5Yag6MirfHH2ycOOKfpA==
X-Received: by 2002:adf:d1ef:0:b0:33d:2198:f2fc with SMTP id
 g15-20020adfd1ef000000b0033d2198f2fcmr15766982wrd.2.1708550294459; 
 Wed, 21 Feb 2024 13:18:14 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 e6-20020adffd06000000b0033cf60e268fsm17873029wrr.116.2024.02.21.13.18.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 13/25] hw/i386/pc: Defer smbios_set_defaults() to machine_done
Date: Wed, 21 Feb 2024 22:16:13 +0100
Message-ID: <20240221211626.48190-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Handling most of smbios data generation in the machine_done notifier is similar
to how the ARM virt machine handles it which also calls smbios_set_defaults()
there. The result is that all pc machines are freed from explicitly worrying
about smbios setup.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240208220349.4948-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg.h     |  3 ++-
 include/hw/i386/pc.h |  1 -
 hw/i386/fw_cfg.c     | 12 +++++++++++-
 hw/i386/pc.c         |  2 +-
 hw/i386/pc_piix.c    | 10 ----------
 hw/i386/pc_q35.c     |  9 ---------
 6 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 86ca7c1c0c..1e1de6b4a3 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -10,6 +10,7 @@
 #define HW_I386_FW_CFG_H
 
 #include "hw/boards.h"
+#include "hw/i386/pc.h"
 #include "hw/nvram/fw_cfg.h"
 
 #define FW_CFG_IO_BASE     0x510
@@ -22,7 +23,7 @@
 FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                uint16_t boot_cpus,
                                uint16_t apic_id_limit);
-void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
+void fw_cfg_build_smbios(PCMachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 39cdb9b933..0a8a96600c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -12,7 +12,6 @@
 #include "hw/hotplug.h"
 #include "qom/object.h"
 #include "hw/i386/sgx-epc.h"
-#include "hw/firmware/smbios.h"
 #include "hw/cxl/cxl.h"
 
 #define HPET_INTCAP "hpet-intcap"
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 7362daa45a..98a478c276 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -48,15 +48,25 @@ const char *fw_cfg_arch_key_name(uint16_t key)
     return NULL;
 }
 
-void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
+void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
 {
 #ifdef CONFIG_SMBIOS
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area *mem_array;
     unsigned i, array_count;
+    MachineState *ms = MACHINE(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
+    if (pcmc->smbios_defaults) {
+        /* These values are guest ABI, do not change */
+        smbios_set_defaults("QEMU", mc->desc, mc->name,
+                            pcmc->smbios_legacy_mode, pcmc->smbios_uuid_encoded,
+                            pcms->smbios_entry_point_type);
+    }
+
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 694de8e130..e526498164 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -689,7 +689,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (x86ms->fw_cfg) {
-        fw_cfg_build_smbios(MACHINE(pcms), x86ms->fw_cfg);
+        fw_cfg_build_smbios(pcms, x86ms->fw_cfg);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index eeca725504..34203927e1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -36,7 +36,6 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
-#include "hw/firmware/smbios.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
@@ -225,15 +224,6 @@ static void pc_init1(MachineState *machine,
                                                &error_abort);
     }
 
-    if (pcmc->smbios_defaults) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-        /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc,
-                            mc->name, pcmc->smbios_legacy_mode,
-                            pcmc->smbios_uuid_encoded,
-                            pcms->smbios_entry_point_type);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8053d8cccb..ab7750c346 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -45,7 +45,6 @@
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/display/ramfb.h"
-#include "hw/firmware/smbios.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/intc/ioapic.h"
@@ -188,14 +187,6 @@ static void pc_q35_init(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->smbios_defaults) {
-        /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc,
-                            mc->name, pcmc->smbios_legacy_mode,
-                            pcmc->smbios_uuid_encoded,
-                            pcms->smbios_entry_point_type);
-    }
-
     /* create pci host bus */
     phb = OBJECT(qdev_new(TYPE_Q35_HOST_DEVICE));
 
-- 
2.41.0


