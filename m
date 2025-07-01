Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35592C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSW-0005bd-6j; Tue, 01 Jul 2025 13:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSR-0005Ye-Si
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSN-0003VU-R4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso2773235f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389662; x=1751994462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2pAEd0wAmhj6AVBc7K+tCwpRXx/59qh0ouwfhyi5hL0=;
 b=K6Lnjmjcz4nQ2+dosBGG0XjfrkG1Gw4e3mXFKjTXZ537N+P2BCPholIkosTGuoLHsI
 oDVx/Y6Qnt97LQRRkOuVzGTuVBSKtkeeH6UV7QFjiA32lxIbCapnhO9BWoE8VW1Xqw12
 0GO19TcvGilTbBKxQ+/E3cSeSHSM08B6jmex61cLLxgpGqgOPuAdRqwfImL3lNQTrYuy
 o5Ej+6rv1tMt2x9WqAITIcyKfSsUHfRZagzhRXZFH/wYPX/JEoTZqWGC7nWy87GS1BJG
 rioNAucPa62aySBbMdM/D+UrYdamFAt31ThKxpya08JNizuDC2BQgnCSGmV6+3ztq8jO
 q2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389662; x=1751994462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pAEd0wAmhj6AVBc7K+tCwpRXx/59qh0ouwfhyi5hL0=;
 b=Lnm5qBXAKtqrlkqy0ujAcMEa0nX31PPUseq3z6TlNcz8eXvG74XzXPMCy9Z/BszZ5l
 TxtmhW7OKSzX15xRB6/mv+WwHr/8EL4tlKtUgvLZgIM1NfWDlp8xV6Sf5Rg6bIBv/r1i
 orKh698UowkmD2jsIkzuQn3w/KysTF077qtmBs3tSvqKG6yP6GklLSJ5ukehGx7fp3RI
 FAoyZgwbXgLXiccfxbqfopQuay5Qd4z3/drYo4XBLMKqQvFtdfd1MhtOw9Bu0TaTRQc1
 QeJfPsi8F7hpRSnZqKJHiUpG2806MKhYdDDxlT9T5ysgJy2/l+dXQgKARDPTOZsXRRi+
 ZjmA==
X-Gm-Message-State: AOJu0Ywu+6vh3t4o/a/+iuWvKTNFO5fxwxWy9yWYSCryw4OooZLPFWLz
 D++LAJ7wEaopzpAKp9NHnG2qqPR7N9BRZoc+0BWw5DEW6nI2Dybp1b6c/z3I9OUta8K5CYBvPWs
 BC7n6
X-Gm-Gg: ASbGncskpji+QqpkvIeb1q0K+y0yc42PQTmbPBnQqDg9tJYPl7IGHWOGZotwF/Apwkm
 deKJQXRwW3mUZVIROlcJB23lsU1heumyOVwXl8VKxVOu2HPWubyPeEitmYZuWecUqQJDJ8TGxDz
 cyDI3+eBb0EW4CqHm1ivK2nrek+IWMwAEn46ovVuIoqH6hPU+j9ZT5961wy8RmQ1CqArjj3GYXq
 5u4eNDVAx+BM0M1gLgAmzRROnpKrKOmmRTFAy8Ldgp3wJyld5DmLnlIgnXzrTDbltn1Ar9xp9/f
 Bic2J1Np/UkiSRpWBsXPYov0z1ewTW2SKvF/pU/Hgfi1WuMsepTUb7cunGVp26wmcZqa
X-Google-Smtp-Source: AGHT+IFxQG/EMmlROKRvb8QC6DoGBQ/+bikAu7HPaIH0ha84szBcdWzu+TIVo3JMD5yZf+RwSXon7Q==
X-Received: by 2002:a05:6000:400b:b0:3b1:3466:6734 with SMTP id
 ffacd0b85a97d-3b134666914mr2336991f8f.44.1751389661713; 
 Tue, 01 Jul 2025 10:07:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/43] hw/arm/virt-acpi-build: Factor out create_its_idmaps
Date: Tue,  1 Jul 2025 18:06:55 +0100
Message-ID: <20250701170720.4072660-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Factor out a new function, create_its_idmaps(), from the current
build_iort code. Add proper comments to it clarifying how the ID ranges
that go directly to the ITS Group node are computed based on the ones
that are directed to the SMMU node.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20250628195722.977078-6-gustavo.romero@linaro.org
[PMM: drop hardcoded tabs]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 61 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e9cd3fb3511..5886192fe3f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -266,6 +266,43 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+/* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
+static void create_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
+{
+    AcpiIortIdMapping *idmap;
+    AcpiIortIdMapping next_range = {0};
+
+    /*
+     * Based on the RID ranges that are directed to the SMMU, determine the
+     * bypassed RID ranges, i.e., the ones that are directed to the ITS Group
+     * node and do not pass through the SMMU, by subtracting the SMMU-bound
+     * ranges from the full RID range (0x0000–0xFFFF).
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
+     * hence the end of the range is 0x10000.
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
@@ -276,7 +313,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
     size_t node_size, smmu_offset = 0;
-    AcpiIortIdMapping *idmap;
     uint32_t id = 0;
     GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
     GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
@@ -287,8 +323,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_begin(&table, table_data);
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        AcpiIortIdMapping next_range = {0};
-
         object_child_foreach_recursive(object_get_root(),
                                        iort_host_bridges, smmu_idmaps);
 
@@ -296,25 +330,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         g_array_sort(smmu_idmaps, iort_idmap_compare);
 
         /*
-         * Split the whole RIDs by mapping from RC to SMMU,
-         * build the ID mapping from RC to ITS directly.
+         * Knowing the ID ranges from the RC to the SMMU, it's possible to
+         * determine the ID ranges from RC that are directed to the ITS.
          */
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
+        create_its_idmaps(its_idmaps, smmu_idmaps);
 
         nb_nodes = 3; /* RC, ITS, SMMUv3 */
         rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
-- 
2.43.0


