Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98435C27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6YO-0000Vb-Fy; Mon, 17 Jun 2024 03:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Y6-0000D9-HO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:07 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Y4-0002R6-0w
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:06 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so605308466b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608382; x=1719213182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CICPp7ONNms071FlcjYp5y+HRs28YYfuYPm/XCkTbls=;
 b=OQGehU/HlwVela+C/fj5zzegrQ8Xfsmr/F3QIICMcSCf6nvMS+WJ7FWkcA81Iu/kTf
 drVsJI81yXZD0f/YktEwJgswpafLhs50n97PJikMwYQ4+y07Iy4Btx64CRsJhJne8gwK
 aO5DspOplx5YyaBNNwIHak2OWSvpB6aHqGn4i2dZYKXVYt6zcCKqGoyL8F6uEy8fZOQL
 R11IyKKzhY4DcFdpzhKxkqexwN+613BFf2Sy7svl431JelNwjzxVRKiYqZPN1gjmPiTB
 NM+pwKGKSPdl3yIZ6nxUkj3mq9nQikY6LyPCENN0L43rV2g/qMt+V0VNoYrx5qknkGDc
 Gb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608382; x=1719213182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CICPp7ONNms071FlcjYp5y+HRs28YYfuYPm/XCkTbls=;
 b=I51IBNr23SJ6188XX5CT+VkDeSb3EUHlE86m+HafxcFHOpbogt5rxahs+LiD0TXFs/
 t7r3s/wQN96uSnd5wzrUcgIZxPJC9V2OqSuJ7n3uyVeNRnTeASfNpqjgB4ncW92xwv8a
 XjyXy9GEqNIValc34mzRlBsaGnPZY6iwzgAxFK0KrLzNvdMkKZnG3jQIQoqPfKFLFD9s
 DS9fQ74QB/pOGhnrJMRYAYZnnpK/B8SMom0rcxTXmY+nen9wYAXDgiSv7SM66JhjbqZH
 CjwCyV96lRt9WF/uVt3r4gahbfj6eosZDky2yYVtEixJ0Zo+Xo2BLXzCjcWWPcG3Q1Hd
 0F+g==
X-Gm-Message-State: AOJu0YzDamRN9bOX0iWHb7x9kP9y4aONgR+fzZcsmQKWjzG6XseFzIqs
 BqaLGRTBe3M7IR+ZsL6PhTaR467sxUuXJbcF/uRGms8ASkfHsc2Q+BH7yBQPuCvII58mA+3QFS8
 UF2Y=
X-Google-Smtp-Source: AGHT+IFlmEPlLpKa1wGxWh0Un3RD8E9rgDcrDtOKg+RS8ealq9zOGvBvSV43sik3y3kiSqu1x67vGw==
X-Received: by 2002:a17:906:607:b0:a6f:39e3:3265 with SMTP id
 a640c23a62f3a-a6f60dc56ccmr556900166b.62.1718608382144; 
 Mon, 17 Jun 2024 00:13:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f881fbdfcsm88545666b.121.2024.06.17.00.13.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:13:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 18/23] hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
Date: Mon, 17 Jun 2024 09:11:13 +0200
Message-ID: <20240617071118.60464-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

PCMachineClass::rsdp_in_ram was only used by the
pc-i440fx-2.2 machine, which got removed. It is
now always true. Remove it, simplifying acpi_setup().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/acpi-build.c | 35 ++++-------------------------------
 hw/i386/pc.c         |  1 -
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d01ddc4618..0b7a18a882 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -100,7 +100,6 @@ struct PCMachineClass {
 
     /* ACPI compat: */
     bool has_acpi_build;
-    bool rsdp_in_ram;
     unsigned acpi_data_size;
     int pci_root_uid;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index eafc3761c8..158e74f64a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2494,7 +2494,6 @@ static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     DeviceState *iommu = pcms->iommu;
     GArray *table_offsets;
@@ -2666,16 +2665,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
@@ -2754,7 +2743,6 @@ static const VMStateDescription vmstate_acpi_build = {
 void acpi_setup(void)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -2816,25 +2804,10 @@ void acpi_setup(void)
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
index a6d50df500..b0fc8686d8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1763,7 +1763,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
-    pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-- 
2.41.0


