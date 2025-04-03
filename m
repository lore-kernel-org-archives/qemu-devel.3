Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191B3C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RNI-0000bk-6n; Thu, 03 Apr 2025 16:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RNB-0000Wb-Qv
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RN9-00056D-Jm
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso9486075e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712869; x=1744317669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzIe1y6exrD0xJczT8npcuq1OBfi7eudR1jNiJ2MiPM=;
 b=s+rknz10+5TcCyvo2fbjrz69Orcn8pi/St4AhB4/J5pNxRdm323XiVwcAioaaCWMlp
 QoJ7B3M+zuo6NGX6Pt+Ry8MxCvlUV9onNHsEh4qZqNVmJhkEt1FCkTsXusFYbfo/LXRd
 nyUihKn5EeBDW3I6Zq4ToRMd9vD1hqfK6BJjYC5xTye0m+apuOupEgzpoddfxzyphHXj
 BEi5vm+UukArFt3p5hqJTAWt0CYruNoNlffuNA2+roiW6wrSzWlhE7HcdC0NlunLoHkV
 2egl9LYZW19AtMEE+HutjnCaNS0VcniWtjXq77fqqwsF/X5YyiDY4fJcsxq7AkeZed8X
 vFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712869; x=1744317669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzIe1y6exrD0xJczT8npcuq1OBfi7eudR1jNiJ2MiPM=;
 b=kOHnDW13cfsNsRkrVEXo41mH21Qgv2Y6Mt4ub4IfVptSk14ceoyw4ZY5H+ve5sB/Oz
 vbT0WGidq9Cu15ttD1+Qox4hRSGNYLaTKjgTudS6ECSze52SYfUItyERY/z21bzS40cV
 5RzB7MdPpzj5zDOr7H6bwasma5FFDkVjnuLhvvTNB7Tc4w0VHFoSLHr6deOdzOJfZ/6D
 mR4GTeVEckU7gGWHkTSRldgwK1l/c2yJ8sCaNBDo2RyHY5C0zsNJ3ipn46HR59TCMEjZ
 83g9A92880EIfyF4DpQL5anZdSBWD9zDNZMdT0ImBS+uI6ilb0+yJq60x/L/Q6Mdj+mR
 sn0w==
X-Gm-Message-State: AOJu0Yy6+Mzvy8d28dRUqkWU1NvwQhFkNha1UAzFijTb9rFFIzOd+OBn
 K3+LDqeemTkI5SuRyXmby1wZyujluBqpAmBF7xr34az/dUR5GiHx/IbIDTryGzo4mAFKIx2e+Vv
 G
X-Gm-Gg: ASbGnctAi3N57D3mLRNBANcu2OwLGMr/GcwgXMpwV3A0mSNY8BP3zu9ZPCXzo2P7J7s
 cN4cgZQJ5J95e1GQQhMd00lkLD16qknsscEVAwMvvuZrgHsPk/5WWW8C2KDgtQo8E8ANnkaonC2
 wTGvfsdjU9vkPmrYli8HuLqaforVLGlpBRinVO5YepnWlmAOzNoD5Zyx3rjL1g2qxWcSQu0C48h
 BZ36/ECj05Z36O4+5l37jtDhjfoOGSUqPxpkPUfT0+zbqUjEBncJlbPxtTh73QGde4MxzCUNWc6
 3Gijyky5QmGGZD2UluiAurMaspo7AkO13HNbI7rtY1xhEG+KdjJfrN46svP5XiTzzd/S9nQ4WTM
 jFfb6M6XLthzwt3MhJZC5zPn8
X-Google-Smtp-Source: AGHT+IGf6uH+7GL3enjPwL35FczmiuP3WQ9HgY23LIOqkXLkKIH/Lul8LuROoosf3k3pEiGcm8IRjQ==
X-Received: by 2002:a05:6000:2509:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-39cb35b1a8cmr571814f8f.35.1743712868622; 
 Thu, 03 Apr 2025 13:41:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630ddesm30923505e9.5.2025.04.03.13.41.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:41:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v3 7/9] hw/arm/virt-acpi: Always build IORT table
 (even with GIC ITS disabled)
Date: Thu,  3 Apr 2025 22:40:27 +0200
Message-ID: <20250403204029.47958-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


