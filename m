Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA8CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo4P-0004id-Hs; Tue, 16 Apr 2024 15:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo4M-0004N5-KR
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:02:14 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo4I-0005um-ON
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:02:14 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516f2e0edb7so5851778e87.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294129; x=1713898929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMNnC0CtBUMfvsWtjsnWY6TflDR4yCy2djdqUVTuvak=;
 b=t8qs/JL8yAg1ebnAvx1Dg30Vhcqu7XK6aUmJbOqPN3aK2zHtuVx8yJ1wnXj5OKCEv1
 ff+HuhQ6I4YoZFL54caz/HOwpwFp8RkK42zn/nhGyO8YbQWY7cDXd77LLXU6UwHVy2zC
 lmS6fWa59XnTxFEUnOBwiExbsC4eZRx5CuLakiz7xa09hxh+5RO23gHWidxPDrFxlJLk
 myYdxS4F+L2oAout86NnOcqQHfiqe/jb1L+hQ4m0mNHW9Oft+JHx5MmQE5/u0mwcc8Q1
 iO+Xe38b20rqI1rdM7Fl37zblJy2l7aJFxpYgnQiYP5i8NgqKtSR80JM4FJd5Ag7+xZB
 cVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294129; x=1713898929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMNnC0CtBUMfvsWtjsnWY6TflDR4yCy2djdqUVTuvak=;
 b=sNtyvDgAHMOACrkf1IYuP+T31fNPqUk68tYy7Uo122FQlmhQ/maN2u7+T42lQhASTN
 2dPLgmAa5CBa6WIhogTGBnGVXjNb3WFz8R+jMs/LtTV4ajR5kMlbtGyNePob1NaX5vD8
 SNXFcrdxx83bBW2yv+EP7B2NAWeMvvH4FHW7c5gzjROw0pf8siequuovktA4gSPq39Mb
 9LWk1sboMfSX1MuzqIK29tkcXijmkpo6E5JLhnZsQKbKvT5XaVWVMAXxQNTnYI7lmiIm
 Nm9ekrYcPUxxk0wYWsnG4Ka/bJyg1jCQR+GGDXV+CHyYndPMSRrPYcTBDgDRNoZBkYyB
 FN7Q==
X-Gm-Message-State: AOJu0YxBS7ToSVPgDawXGviu5HV8FimRIN5lS+dgGWKJd1mQ9nNFZW8Q
 2A9XEvE1vvOocvqIljzSp/2G1HihLBVB8S/W+NdF+CRY7FkcZEuDpOH8QbB/gYWt4TFZvm4/5+Q
 Y
X-Google-Smtp-Source: AGHT+IGfYRyj7r002C9yM3FRzUGXQloA8hUqiyYSxfijYilgXSYfYJaEenswdOWXoxEW0bqJoGIMTA==
X-Received: by 2002:a05:6512:33c8:b0:518:b069:3b7d with SMTP id
 d8-20020a05651233c800b00518b0693b7dmr6333284lfg.6.1713294128761; 
 Tue, 16 Apr 2024 12:02:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a170906c21300b00a553846966csm1570949ejz.24.2024.04.16.12.02.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:02:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 22/22] hw/i386/pc: Replace PCMachineClass::acpi_data_size
 by PC_ACPI_DATA_SIZE
Date: Tue, 16 Apr 2024 20:59:38 +0200
Message-ID: <20240416185939.37984-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 include/hw/i386/pc.h |  4 ----
 hw/i386/pc.c         | 19 ++++++++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 96ccb4583f..0ad971782c 100644
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
index 2e2146f42b..0be8f08c47 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -256,6 +256,16 @@ GlobalProperty pc_compat_2_4[] = {
 };
 const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
 
+/*
+ * @PC_ACPI_DATA_SIZE:
+ * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
+ * and other BIOS datastructures.
+ *
+ * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
+ * reported to be used at the moment, 32K should be enough for a while.
+ */
+#define PC_ACPI_DATA_SIZE (0x20000 + 0x8000)
+
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -634,8 +644,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                   pcmc->pvh_enabled);
+    x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabled);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -969,8 +978,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                       pcmc->pvh_enabled);
+        x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabled);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
@@ -1724,9 +1732,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
-    /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
-     * to be used at the moment, 32K should be enough for a while.  */
-    pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     x86mc->apic_xrupt_override = true;
-- 
2.41.0


