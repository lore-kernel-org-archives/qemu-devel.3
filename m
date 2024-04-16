Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9924AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo4C-00038w-1r; Tue, 16 Apr 2024 15:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3u-0002Vv-TB
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:52 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3r-0005r3-6e
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:45 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-570097653faso3454494a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294101; x=1713898901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+KMTbrbI+PCZ7l2nXt22iBk719lD5OjaX/6s+DU33I=;
 b=uqo1AA4MdYaITEMhKzBuWX8qibui/rIMAGFD0NpeE2JTo0xa+AHzQkmlTimFPfD4ja
 VsiWJ/y2gBfD3PSInTWel+VIFUmtMSdoNsTcFCHiAlUNbr+ow3xdTXXtr7+5NZI+CCer
 /QvxqKIUwuhnZbRknddldKrK+Iwen+LTRJSm8UjwcVLmvAvAdHlkHvTDh+dfnMu1isch
 bU/Q0TyzQsARe8O8EFWOHz/Y/Qxq3ocnvXaKkdU1l7r0R3J9fDOgNmfv1ttjjOXFVg6i
 KA8JM8lTzKWZ7s0+bxhIqMbB0Mo9bSYyPvUXnHFtLFfWo//04X/STlertdgH4cDIOOX7
 BZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294101; x=1713898901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+KMTbrbI+PCZ7l2nXt22iBk719lD5OjaX/6s+DU33I=;
 b=uBYLk/7DzhI5Mi0o98dv0xQg+OO/Qe1lNDREyM2BGJi4RcvTJBqG2/1cmaLY0SXnzq
 viTlhgAsWMp5+ZR6hhyJxQtutGZg0+RXleMu3Xsdaf7XS80TgJ8wSFRG9mYftFf4pT0k
 yw+DJ89rvGaLP7bDoMkZMXykXh83udmigMEVFMd3IWIeH6XMOLtk1cpLMgvtK2KLBoZ8
 ADrKLVROXmi0AENvZ7konKqoFUvHry9Z35i0/wasok5/qKQ0uRVYBVKC50xwBNLLnjqF
 jBmpyAVJ2TjW01ecdLuWD0OHOSD8/qTo1McU18JpoP3VvwrITAYr82IN/LM92GvDB6P0
 Zgvg==
X-Gm-Message-State: AOJu0YzAWr+AADd7UDtcoWGfpMcVLQx6P6++Te8Ax8JVt9rcD516aUTb
 Ubbz7MrdzPH0r7Mczt/AykHXQzwisyAPxoev6A/sfc3lMJ/CrpETITspPrL4Isrz31d6XlBDjSD
 7
X-Google-Smtp-Source: AGHT+IHCXF2xNmCPdhDPQJn9LboRzz1geLxNJeviZck2aQ1GPeqJoFoTjUbGAbA50RPwfi6/KvckbA==
X-Received: by 2002:a17:907:72c9:b0:a52:53f3:af3c with SMTP id
 du9-20020a17090772c900b00a5253f3af3cmr8756708ejc.10.1713294101517; 
 Tue, 16 Apr 2024 12:01:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 cw4-20020a170906c78400b00a4e58c74c9fsm7141780ejb.6.2024.04.16.12.01.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:01:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 18/22] hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
Date: Tue, 16 Apr 2024 20:59:34 +0200
Message-ID: <20240416185939.37984-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

PCMachineClass::rsdp_in_ram was only used by the
pc-i440fx-2.2 machine, which got removed. It is
now always true. Remove it, simplifying acpi_setup().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/acpi-build.c | 35 ++++-------------------------------
 hw/i386/pc.c         |  1 -
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 10a8ffa0de..96ccb4583f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -100,7 +100,6 @@ struct PCMachineClass {
 
     /* ACPI compat: */
     bool has_acpi_build;
-    bool rsdp_in_ram;
     unsigned acpi_data_size;
     int pci_root_uid;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ab2d4d8dcb..ed0adb0e82 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2495,7 +2495,6 @@ static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     DeviceState *iommu = pcms->iommu;
     GArray *table_offsets;
@@ -2667,16 +2666,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
             .rsdt_tbl_offset = &rsdt,
         };
         build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
-        if (!pcmc->rsdp_in_ram) {
-            /* We used to allocate some extra space for RSDP revision 2 but
-             * only used the RSDP revision 0 space. The extra bytes were
-             * zeroed out and not used.
-             * Here we continue wasting those extra 16 bytes to make sure we
-             * don't break migration for machine types 2.2 and older due to
-             * RSDP blob size mismatch.
-             */
-            build_append_int_noprefix(tables->rsdp, 0, 16);
-        }
     }
 
     /* We'll expose it all to Guest so we want to reduce
@@ -2755,7 +2744,6 @@ static const VMStateDescription vmstate_acpi_build = {
 void acpi_setup(void)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -2817,25 +2805,10 @@ void acpi_setup(void)
                            tables.vmgenid);
     }
 
-    if (!pcmc->rsdp_in_ram) {
-        /*
-         * Keep for compatibility with old machine types.
-         * Though RSDP is small, its contents isn't immutable, so
-         * we'll update it along with the rest of tables on guest access.
-         */
-        uint32_t rsdp_size = acpi_data_len(tables.rsdp);
-
-        build_state->rsdp = g_memdup(tables.rsdp->data, rsdp_size);
-        fw_cfg_add_file_callback(x86ms->fw_cfg, ACPI_BUILD_RSDP_FILE,
-                                 acpi_build_update, NULL, build_state,
-                                 build_state->rsdp, rsdp_size, true);
-        build_state->rsdp_mr = NULL;
-    } else {
-        build_state->rsdp = NULL;
-        build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
-                                                 build_state, tables.rsdp,
-                                                 ACPI_BUILD_RSDP_FILE);
-    }
+    build_state->rsdp = NULL;
+    build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
+                                             build_state, tables.rsdp,
+                                             ACPI_BUILD_RSDP_FILE);
 
     qemu_register_reset(acpi_build_reset, build_state);
     acpi_build_reset(build_state);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c4a7885a3b..a1b0e94523 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1745,7 +1745,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
-    pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-- 
2.41.0


