Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C51C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MNG-0001HC-JD; Thu, 03 Apr 2025 11:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MMJ-0008LU-5r
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:20:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MMB-0000dg-QE
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c2688619bso693161f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693590; x=1744298390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzIe1y6exrD0xJczT8npcuq1OBfi7eudR1jNiJ2MiPM=;
 b=rtMFTxNa1LIUZ2J0UWGRPixJPRQR3DbW3YZS1f1oYSCIPEJw7m1IKSfNicXrMCKe9d
 8zgfNWkrP3qxx8wYlJNXNTEKe1wFrrJuvR10d8src82G91EHDUtlyMkKZraeNWeqoiFF
 PrvjBYF53ySSPJclhmIqoBcGRtO3+/VWOKaoZxBEPg9TsnwIuinKKWAtkyVhAbDxgzhu
 xQhQeEhBp58avjZLQyMUBDxom3Q8lU298JfhirncKaCLSHNXDX1YdDeZ76kIx0Y19gUB
 xgrZSwkW4b9ogZdCJ/HX3ms2Xf7y//W2HzoaKa/CeXTiYLR8MzcpedX9UutsN6wML6Ty
 6/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693590; x=1744298390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzIe1y6exrD0xJczT8npcuq1OBfi7eudR1jNiJ2MiPM=;
 b=uT46UBnJc+GvcxiKV6OGfqmVZ2dklge31lNOgb0ze0xHR28uiW1Kv/pCvH44SmsNC1
 Gb6THOrDPlsANxakxyB5ics5IHIczKw/Air/aYAXpsjuLLny+zNvZSkXI9TurWdUzwUC
 Zi00pybcfUsE7Kh4SmBWDdaPbrvUo7rc6z2VubiHdnyqafGgZfWlvcw67JsfEae1fsYD
 JR7ykedFlo+lej3lpIBk6Tw/zuJ4vBmF6xVFzo0R0i1A+oImn6FNvnAxtuWWb1MOxEPB
 Y5jy7/pPUo2Dqdfbx58hqWsdBMuBMHymaOjAj9U7USOixM9OanK3QxfRyD3RzCJYOKsi
 D3Mw==
X-Gm-Message-State: AOJu0YzCz1NKwUY4hIjI+U/oM8kAeVOZRvDo8ineCornmhucRqhNwsrh
 H8srqRMfc4nkcsRDUsIFR8XaOeXTrKA/dgxfRxaCWBqzQLqmBd8EyMf4BFAjsMbupB90xo5zx37
 G
X-Gm-Gg: ASbGncuC9+6E85O7MsN+5J6L0dSvhaNlY5/fud2YoPlNe2pszlTWzyUuFMF6TWGBHgZ
 L21bvayCCa64dTSYna52jxpGUYfJ9YOQ1vbdPOC0YQCrBF5UBosBmTAgjavF+C5qwUsXlPk4Y8I
 GpWJlvL6cujP2TZ5sEtDno5+fKtGBtv9+nPzk25N7TzFLdYHnHZxxNoOtZ509JbL1zt+f9vWVnF
 s6SfxVTLlco8xlbLf6mgkxwMPvA3/KGNAC7Ul8m70B7ZPdRNB3ulFp2PDR4YP9qqKm1DFtuyWow
 3h09HoLeTx3XXccVvyAP0fVguMFZpjI+7ig1LTip+/GLyOynZFWPUssy4zWqfDQZd8ib7PpZQ6C
 IdJyuOlIkNTOL9kFIBCE=
X-Google-Smtp-Source: AGHT+IFP5r5ixxIHZaNePUhh+j1T6iPhjWvcfbIAQTugdxudRBNRRHn2nU0VwfpVZLpfl2RJ/YT+hQ==
X-Received: by 2002:a05:6000:420b:b0:391:47d8:de3a with SMTP id
 ffacd0b85a97d-39c303af783mr2389195f8f.53.1743693589894; 
 Thu, 03 Apr 2025 08:19:49 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226acfsm2003872f8f.88.2025.04.03.08.19.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 12/14] hw/arm/virt-acpi: Always build IORT table
 (even with GIC ITS disabled)
Date: Thu,  3 Apr 2025 17:18:27 +0200
Message-ID: <20250403151829.44858-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Citing Gustavo [*]:

  Gating IORT table generation entirely based on the presence
  of ITS looks wrong because IORT table has data beyond GIC ITS,
  like for SMMUv3 etc..

[*] https://lore.kernel.org/qemu-devel/bae6e29a-7290-47d2-8caf-14702ee091f0@linaro.org/

Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt-acpi-build.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1c389ef5cdb..e7e27951cb9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -287,6 +287,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     uint32_t id = 0;
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    bool has_its = its_enabled(vms);
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
@@ -325,9 +326,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
         nb_nodes = 3; /* RC, ITS, SMMUv3 */
         rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
-    } else {
+    } else if (has_its) {
         nb_nodes = 2; /* RC, ITS */
         rc_mapping_count = 1;
+    } else {
+        nb_nodes = 1; /* RC */
+        rc_mapping_count = 1;
     }
     /* Number of IORT Nodes */
     build_append_int_noprefix(table_data, nb_nodes, 4);
@@ -336,17 +340,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    /* Table 12 ITS Group Format */
-    build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
-    node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
-    build_append_int_noprefix(table_data, node_size, 2); /* Length */
-    build_append_int_noprefix(table_data, 1, 1); /* Revision */
-    build_append_int_noprefix(table_data, id++, 4); /* Identifier */
-    build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
-    build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
-    build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
-    /* GIC ITS Identifier Array */
-    build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
+    if (has_its) {
+        /* Table 12 ITS Group Format */
+        build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */ //
+        node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
+        build_append_int_noprefix(table_data, node_size, 2); /* Length */
+        build_append_int_noprefix(table_data, 1, 1); /* Revision */
+        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
+        build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
+        build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
+        build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
+        /* GIC ITS Identifier Array */
+        build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
+    }
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
@@ -429,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, IORT_NODE_OFFSET);
         }
-    } else {
+    } else if (has_its) {
         /* output IORT node is the ITS group node (the first node) */
         build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
@@ -979,10 +985,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_enabled(vms)) {
-        acpi_add_table(table_offsets, tables_blob);
-        build_iort(tables_blob, tables->linker, vms);
-    }
+    acpi_add_table(table_offsets, tables_blob);
+    build_iort(tables_blob, tables->linker, vms);
 
 #ifdef CONFIG_TPM
     if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
-- 
2.47.1


