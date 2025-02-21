Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DF1C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlU8H-0000IO-Bs; Fri, 21 Feb 2025 09:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tlU84-000099-Dy; Fri, 21 Feb 2025 09:35:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tlU82-0003ft-6u; Fri, 21 Feb 2025 09:35:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6BD6F5C656B;
 Fri, 21 Feb 2025 14:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7996DC4CEE2;
 Fri, 21 Feb 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740148535;
 bh=MD9m6HxT+Wh3bJR70SzttGZ7CO3vkJrZC9LiPrH4gCo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OnNsFKgYsfNEZIlTIDScQR5eFJ/XmQ9OYSiOR74EK5omTjQslRPr387RGbSaNXE/1
 5a8woO/4Ow00uMzN3EnEQ8O+9X00s09wTap4rLi1b780mcUhLjFp3oMI/02OGe8YWf
 XwphOTG9DeCPvObsllUpg30Y1JSWcai3kctuoEV0hNZI3nxwiOkwySnsVH0wm/pmv3
 R7c9Z5N0PTgbtFm4WNNboNCZ5p/E/VZFdjfDLlVKAboG9JRsYHg6AmR+6QeRQ88L0N
 2GZ6x/X/+pQorexR0SVeu7R9JdOhSQqNI/XOKnFV4agyZUdDqI9yOMCB4W9C1//7i4
 rSCsDauz/FP3A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tlU7m-00000002jDn-2nkp; Fri, 21 Feb 2025 15:35:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/14] acpi/ghes: don't hard-code the number of sources for
 HEST table
Date: Fri, 21 Feb 2025 15:35:13 +0100
Message-ID: <13755cc3680bfee1435fee2e366b621d2a940a1a.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The current code is actually dependent on having just one error
structure with a single source, as any change there would cause
migration issues.

As the number of sources should be arch-dependent, as it will depend on
what kind of notifications will exist, and how many errors can be
reported at the same time, change the logic to be more flexible,
allowing the number of sources to be defined when building the
HEST table by the caller.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c           | 38 +++++++++++++++++++++-----------------
 hw/arm/virt-acpi-build.c |  8 +++++++-
 include/hw/acpi/ghes.h   | 17 ++++++++++++-----
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 7efea519f766..4a4ea8f4be90 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -238,17 +238,17 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
 static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
-                                   BIOSLinker *linker)
+                                   BIOSLinker *linker, int num_sources)
 {
     int i, error_status_block_offset;
 
     /* Build error_block_address */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
     }
 
     /* Build read_ack_register */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         /*
          * Initialize the value of read_ack_register to 1, so GHES can be
          * writable after (re)boot.
@@ -263,13 +263,13 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
 
     /* Reserve space for Error Status Data Block */
     acpi_data_push(hardware_errors,
-        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
+        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
     bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         /*
          * Tell firmware to patch error_block_address entries to point to
          * corresponding "Generic Error Status Block"
@@ -295,12 +295,14 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2(GArray *table_data,
-                          BIOSLinker *linker,
-                          enum AcpiGhesNotifyType notify,
-                          uint16_t source_id)
+static void build_ghes_v2_entry(GArray *table_data,
+                                BIOSLinker *linker,
+                                const AcpiNotificationSourceId *notif_src,
+                                uint16_t index, int num_sources)
 {
     uint64_t address_offset;
+    const uint16_t notify = notif_src->notify;
+    const uint16_t source_id = notif_src->source_id;
 
     /*
      * Type:
@@ -331,7 +333,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   source_id * sizeof(uint64_t));
+                                   index * sizeof(uint64_t));
 
     /* Notification Structure */
     build_ghes_hw_error_notification(table_data, notify);
@@ -351,8 +353,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
-                                   * sizeof(uint64_t));
+                                   (num_sources + index) * sizeof(uint64_t));
 
     /*
      * Read Ack Preserve field
@@ -368,22 +369,26 @@ static void build_ghes_v2(GArray *table_data,
 void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId *notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
     uint32_t hest_offset;
+    int i;
 
     hest_offset = table_data->len;
 
-    build_ghes_error_table(ags, hardware_errors, linker);
+    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
 
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
-    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, linker,
-                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
+    build_append_int_noprefix(table_data, num_sources, 4);
+    for (i = 0; i < num_sources; i++) {
+        build_ghes_v2_entry(table_data, linker, &notif_source[i], i, num_sources);
+    }
 
     acpi_table_end(linker, &table);
 
@@ -529,7 +534,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
 
     if (!ags->use_hest_addr) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8ab8d11b6536..4439252e1a75 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -893,6 +893,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -956,7 +960,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
             acpi_add_table(table_offsets, tables_blob);
             acpi_build_hest(ags, tables_blob, tables->hardware_errors,
-                            tables->linker, vms->oem_id, vms->oem_table_id);
+                            tables->linker, hest_ghes_notify,
+                            ARRAY_SIZE(hest_ghes_notify),
+                            vms->oem_id, vms->oem_table_id);
         }
     }
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2f06e433ce04..51c6b6b33327 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -57,13 +57,18 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
-enum {
-    ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
-
-    ACPI_GHES_ERROR_SOURCE_COUNT
+/*
+ * ID numbers used to fill HEST source ID field
+ */
+enum AcpiGhesSourceID {
+    ACPI_HEST_SRC_ID_SYNC,
 };
 
+typedef struct AcpiNotificationSourceId {
+    enum AcpiGhesSourceID source_id;
+    enum AcpiGhesNotifyType notify;
+} AcpiNotificationSourceId;
+
 /*
  * AcpiGhesState stores an offset that will be used to fill HEST entries.
  *
@@ -86,6 +91,8 @@ typedef struct AcpiGhesState {
 void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-- 
2.48.1


