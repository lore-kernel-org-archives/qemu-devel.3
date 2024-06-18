Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B280C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIY-0006yP-0d; Tue, 18 Jun 2024 12:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIU-0006kR-Mk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIS-00077J-2s
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:02 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6e43dad8ecso975497066b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726578; x=1719331378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yi1+oyDOeGjldJpCtaWr7mKsqw3FoNEfWgLcD7ET3s=;
 b=VCtRLuQvq5lPNdFmCU78KEZ2Ly1ippGfOwmEBl2k+4+o//MZEjsKkKXgsAYTLzvtgr
 lEVR5hHEseduYlxu5h1/U0R1J52fbvHFaSzjgX0eJ1uk1wNeOJtd3ch2gGgzbu5ntDCK
 K6JTjsfT6nEW8ZZHqbnnu+1+Ze6bVF8CkOfZYNpV8GmEydOSY8BLGTqQ3wtRRs4sn9cM
 d0wYA/4yM0aMvwZnxXc1QkGKx3NsjmxJZoN2+FjHP62k+6Cp7BSmmqsPh/W4YRz/TCcG
 yvnn8JU8U5b05qOpK/18JW4P+5n0hxAmvgh7e/ruKAon4t6E0BEF7s3j0KYLZhHekWd/
 wGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726578; x=1719331378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yi1+oyDOeGjldJpCtaWr7mKsqw3FoNEfWgLcD7ET3s=;
 b=qeB0uum5wU0qeXabt2/IJYJeA9k73wTQFT40vaj3fl+9EShlanmo0ajVv9ww7F8IbF
 F90oPAimfzEOZ5mSWKth37q9Lng12/WRvH4Uhcb685ZFCKQ6Dkn3zuDVNW1v8JNMUggE
 JDcLlI6Wr8fZ1WmQv0abRxAjy8yj9iMq/0b3R80pBe0YBc4KPA2C2cCWOOf+rPfzEXr2
 zZWdwtMF1atmRkQ0bVJ5JIzz2WnzqDjoIrE7/vv+MeYnueitnbd3Qm4CHzSXHpWqJgBl
 a+I++KnmkqzuC4ojc3KlnF9JyOW1Nhbh0PTnr5BQ/HUFIKdH+kkK0W8A7DogXClPd6mr
 MyPA==
X-Gm-Message-State: AOJu0Yy6tpNTFn/CT0QcE6et9bvDHyfuVSmxtWkaL2SVmFpttxIl6kMY
 9o9tLopNne2IgV1e7QDL6p+EQY8WpQoBGAeFkY4U7YZRxq2iJReTzgOjelYRhGTr3Pvx50SstTF
 E
X-Google-Smtp-Source: AGHT+IE6RNdi8m100eE6quoOpWpgLD+m7dnLz1ckXVMLmnjyRRI5rzV3gHJ/EGwNHgrusVUpHzSY8Q==
X-Received: by 2002:a17:907:cbc5:b0:a6f:996f:23ea with SMTP id
 a640c23a62f3a-a6fa4109cdfmr14068466b.15.1718726578053; 
 Tue, 18 Jun 2024 09:02:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f9802csm627137066b.189.2024.06.18.09.02.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:02:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 23/76] hw/i386/pc: Replace PCMachineClass::acpi_data_size by
 PC_ACPI_DATA_SIZE
Date: Tue, 18 Jun 2024 17:59:45 +0200
Message-ID: <20240618160039.36108-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

PCMachineClass::acpi_data_size was only used by the pc-i440fx-2.0
machine, which got removed. Since it is constant, replace the class
field by a definition (local to hw/i386/pc.c, since not used
elsewhere).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-24-philmd@linaro.org>
---
 include/hw/i386/pc.h |  4 ----
 hw/i386/pc.c         | 19 ++++++++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0b7a18a882..46bc411063 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -74,9 +74,6 @@ typedef struct PCMachineState {
  *
  * Compat fields:
  *
- * @acpi_data_size: Size of the chunk of memory at the top of RAM
- *                  for the BIOS ACPI tables and other BIOS
- *                  datastructures.
  * @gigabyte_align: Make sure that guest addresses aligned at
  *                  1Gbyte boundaries get mapped to host
  *                  addresses aligned at 1Gbyte boundaries. This
@@ -100,7 +97,6 @@ struct PCMachineClass {
 
     /* ACPI compat: */
     bool has_acpi_build;
-    unsigned acpi_data_size;
     int pci_root_uid;
 
     /* SMBIOS compat: */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 819a164373..77415064c6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -265,6 +265,16 @@ GlobalProperty pc_compat_2_4[] = {
 };
 const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
 
+/*
+ * @PC_FW_DATA:
+ * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
+ * and other BIOS datastructures.
+ *
+ * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
+ * reported to be used at the moment, 32K should be enough for a while.
+ */
+#define PC_FW_DATA (0x20000 + 0x8000)
+
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -646,8 +656,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                   pcmc->pvh_enabled);
+    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -986,8 +995,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                       pcmc->pvh_enabled);
+        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
@@ -1743,9 +1751,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->isa_bios_alias = true;
-    /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
-     * to be used at the moment, 32K should be enough for a while.  */
-    pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     x86mc->apic_xrupt_override = true;
-- 
2.41.0


