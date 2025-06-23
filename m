Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D791BC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThhX-0008Po-CF; Mon, 23 Jun 2025 09:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThhA-0008Gt-4w
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThh5-0007IA-D3
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso4883941b3a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687121; x=1751291921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWwtJe7sGsUGEueqmsN3PVBl6pSQ948gCik+Qy6mwyc=;
 b=F0cNz4wjTLppFhMHQFPclwPGqV87cx3u9fuCusGtta1cbn+1TKIAaN+CeQXMLQq1K2
 iwYIi0PMB3gmGQNUPXUIfx8J5GWo1hd2LjzHFXwSod3HSaDu0DQQMXt22OR38w6WBAbq
 jz4eHinCwE0o0f3l4Sqs7mooWKbCgrNVvRDYGKpQrDJcmARhntAwqIw3aUA+zlThdl+f
 Do8LbqA/uJwUZuMdZk3bjE38Zn0e5UzKg5vta1m7yJbbg1x+52pcZOw6auZla2+W7RIC
 Ard7wlDjT9npXzcN05MKuKpTQLnj2Gv3iHcYaD8thR0/oFeKlsIroJHUNKDK2iUtBlfn
 p6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687121; x=1751291921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWwtJe7sGsUGEueqmsN3PVBl6pSQ948gCik+Qy6mwyc=;
 b=cKyguhY6xlezafNf9rnxGPtGZS2e6IepVWOoAA7EkCrsc/Cnv5HzwITrSkUtsnwfpg
 7ltJ4FG0T2VjZaimFBc26VLAPT+NjPTxVBesk4+KzfmHdM6V+gddaeQ4HsfdWyHUY+VU
 HFIHQ4Qerk3a5uv3o769sV/CpedN81hsxeLuYr9xDvq5jZ4Rs9apbkKXzGqiQXYuLpyx
 soyWxMTpKT0B0fL3hG6IsdFfK4amMAhMowrnAU0SkBsi0kxGImnrQXY+YARep8Fii/bI
 x9oy+v6+Az1f4uAv21kgdqkkjbn2OxLS7TW6zy0If250NJM4qgW20HYqbwg+1VoAZDb5
 54sA==
X-Gm-Message-State: AOJu0Yw+3oRJyHbvr8CAWMIbOm8ALlrXGR3teKg/5rdsZHnNSdee+iU7
 WKTl3Ec3FB44PfUug1m/ozgtKQ69lwIEz+7zJ1wWrGH3K3ySnKlTXazs0a/NssirCJq/WtXcODj
 GOdrh
X-Gm-Gg: ASbGncuzkhYsNfJYZ1p/OIQtvPUzbmr1FW1mgxMa5m8fHya5BF8chL1XGBRy8om5HAW
 hNT6FrNezNluqc7lf/cymY3oXnm+oNwyL2DK/2R7MC01rEN1kNTnRM1zleHvbp6w1pVJ9xkiZYp
 aiW8DXrx58pB9SSPtEWIn7I2oEaBH7DwqJu/vl42KO7LrAR3y1q/RJ+yTsO7bmKBmSsd+T1gqpJ
 FZV07//eSjkkeR5HodwfB5T65ntqzSolMrIzFhoRdwGvC/5GdlwRx78zLsJF+L/6pV4IA88PZae
 n4qP1I7ecn1zsgYNNQELOsTqVZvuyTAUHsOw4INBmH76t4lW1Yim1vE/Y+DnxQKMliY=
X-Google-Smtp-Source: AGHT+IEP5weTA9lYRUWvac9OZPElw8rZVoWde3YML9FuBKQ3hKjUCj61HEYec5CnNc434BOKk7xUmA==
X-Received: by 2002:a05:6a00:3c90:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-7490da07100mr18027642b3a.21.1750687120824; 
 Mon, 23 Jun 2025 06:58:40 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:40 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v5 5/9] hw/arm/virt-acpi-build: Factor out create_its_idmaps
Date: Mon, 23 Jun 2025 13:57:45 +0000
Message-Id: <20250623135749.691137-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135749.691137-1-gustavo.romero@linaro.org>
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Factor out a new function, create_its_idmaps(), from the current
build_iort code. Add proper comments to it clarifying how the ID ranges
that go directly to the ITS Group node are computed based on the ones
that go to the SMMU node.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt-acpi-build.c | 64 +++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e9cd3fb351..40a782a498 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -266,6 +266,42 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+/* Compute ID ranges (RIDs) from RC that do directly to the ITS Group node */
+static void create_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
+{
+    AcpiIortIdMapping *idmap;
+    AcpiIortIdMapping next_range = {0};
+
+    /*
+     * Based on the RID ranges that go to the SMMU, determine the bypassed RID
+     * ranges, i.e., the ones that go directly to the ITS Group node, by
+     * subtracting the SMMU-bound ranges from the full RID range, 0x0000–0xFFFF.
+     */
+     for (int i = 0; i < smmu_idmaps->len; i++) {
+        idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+
+        if (next_range.input_base < idmap->input_base) {
+            next_range.id_count = idmap->input_base - next_range.input_base;
+            g_array_append_val(its_idmaps, next_range);
+        }
+
+        next_range.input_base = idmap->input_base + idmap->id_count;
+    }
+
+    /*
+     * Append the last RC -> ITS ID mapping.
+     *
+     * RIDs are 16-bit, according to the PCI Express 2.0 Base Specification, rev
+     * 0.9, section 2.2.6.2, "Transaction Descriptor - Transaction ID Field",
+     * hence, the end of the range is 0x10000.
+     */
+    if (next_range.input_base < 0x10000) {
+        next_range.id_count = 0x10000 - next_range.input_base;
+        g_array_append_val(its_idmaps, next_range);
+    }
+}
+
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -276,7 +312,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
     size_t node_size, smmu_offset = 0;
-    AcpiIortIdMapping *idmap;
     uint32_t id = 0;
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
@@ -287,34 +322,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_begin(&table, table_data);
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        AcpiIortIdMapping next_range = {0};
-
         object_child_foreach_recursive(object_get_root(),
                                        iort_host_bridges, smmu_idmaps);
 
         /* Sort the smmu idmap by input_base */
         g_array_sort(smmu_idmaps, iort_idmap_compare);
 
-        /*
-         * Split the whole RIDs by mapping from RC to SMMU,
-         * build the ID mapping from RC to ITS directly.
-         */
-        for (i = 0; i < smmu_idmaps->len; i++) {
-            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-
-            if (next_range.input_base < idmap->input_base) {
-                next_range.id_count = idmap->input_base - next_range.input_base;
-                g_array_append_val(its_idmaps, next_range);
-            }
-
-            next_range.input_base = idmap->input_base + idmap->id_count;
-        }
-
-        /* Append the last RC -> ITS ID mapping */
-        if (next_range.input_base < 0x10000) {
-            next_range.id_count = 0x10000 - next_range.input_base;
-            g_array_append_val(its_idmaps, next_range);
-        }
+	/*
+	 * Knowing the ID ranges from the RC to the SMMU, it's possible to
+	 * determine the ID ranges from RC that go directly to ITS.
+	 */
+        create_its_idmaps(its_idmaps, smmu_idmaps);
 
         nb_nodes = 3; /* RC, ITS, SMMUv3 */
         rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
-- 
2.34.1


