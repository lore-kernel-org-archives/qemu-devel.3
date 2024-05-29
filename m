Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66917C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBgp-0002dJ-KE; Wed, 29 May 2024 01:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgi-0002EG-3m
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBge-0005Us-Cq
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354f3f6c3b1so1330868f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959839; x=1717564639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqcbdlkR2ui35s3mBkq0drbvjn2gkPP4SIGHg4kmOag=;
 b=xUuDaIGPjYyvpbsvehyGJc9sGXRvpLBgusnTAajIgnapCh3qICbNAO25Ypf1yh3UHk
 +hZrGPOMFq4gFPhhJSQaXatNBnsB9EQ5Gj+L/jpAVAiUCh5gJKsFHSIOUDsgyCMI9J6y
 pEObftO+FrHMJlM7n1itI0RhuF9eWYzVWFB5FHgq0/dKTqh8j+XwOv1zSfzclZ7kgehs
 1Oiu1Rj9tW208tGkZuyIUgUO1yvY+ERrolOSkzHHGQ0yXS67+KNSEvHU11YbbXogBCRa
 qIzrVbTDfMMPT1O1dHmjkNF+AtvUWtbe1iiuWlCx2K9QhkX9LxGIfarZxWXklAr+Tpd9
 IEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959839; x=1717564639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqcbdlkR2ui35s3mBkq0drbvjn2gkPP4SIGHg4kmOag=;
 b=VhjTM7GtSdthRey5ajspRmQ2vvmrGl4LzUobqGfhTWILyzVg4lYiidUb90AUAV2htr
 V0T/AJktrhDBTr/VOEtJZu60kmhNwP5jgidBpeQCptShnFFcbvtvnRs5X5JA6fkd3/G2
 PfwxC+zJdh8k3AppcH82io2Z1hGQjp4aZ0igYAjkFAfNsTm7WespAeCLQvuDJbn9ZcOi
 NRizraGf+zlNklu/ncPsmohmUDpBRmuLAquYL6RVtNo5VGuMVAfhGcg1dYp94rtWWysb
 E6Lef/kbsABLqq6xjEi+AVT5EAoWm2/Yg5Lm6wn5762fPNU1qU+m64dJpb4VgNJfyJiU
 W6RA==
X-Gm-Message-State: AOJu0YzvkU+n+OYzd6dnwJFFFn0gWMlwpev8jhLifEJGI4RKTIfEzbzQ
 rTRfCLm6BkwkaI2Yz3J8kzg4YsSJohbKY0A3/rPgwxvsNX5Q9HVhPfFU0l+zStG3eHfLqVa4X7M
 R
X-Google-Smtp-Source: AGHT+IHJUgCnvZmpiWow4SSgH/UlvWwt/9Pu6ZrEHclDP9g2KUv9HUAyU+MnnKmcgTsp9uwRBeTVtA==
X-Received: by 2002:a05:6000:1284:b0:355:1ad:90da with SMTP id
 ffacd0b85a97d-3552fdfa487mr9122381f8f.51.1716959838817; 
 Tue, 28 May 2024 22:17:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f5299dsm193019945e9.20.2024.05.28.22.17.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:17:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 18/23] hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
Date: Wed, 29 May 2024 07:15:34 +0200
Message-ID: <20240529051539.71210-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
---
 include/hw/i386/pc.h |  1 -
 hw/i386/acpi-build.c | 35 ++++-------------------------------
 hw/i386/pc.c         |  1 -
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 808de4eca7..63568eb9e9 100644
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
index fae21f75aa..8e51d1f1bb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1757,7 +1757,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
-    pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-- 
2.41.0


