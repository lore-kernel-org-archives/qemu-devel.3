Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2383CCEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveAi-0003wC-3N; Tue, 01 Oct 2024 10:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sveAA-00034w-Og; Tue, 01 Oct 2024 10:47:43 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sveA8-0004XH-9O; Tue, 01 Oct 2024 10:47:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 339C05C548A;
 Tue,  1 Oct 2024 07:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21519C4AF09;
 Tue,  1 Oct 2024 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727766251;
 bh=2mlfX2QWqbukd38FKj+LVr/77D7WaOjiB5Yx+metSsc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f0sSX034qrLL6+X0oXhUOtU7ZS1Jm2snNt5VKXyWO9acOOgWXrgngvxGEEn2RiJGI
 s7XB69tDbYqX6+CTEFtqHf/mEgPZpAVTvpWQcTSuCRkiZBlZno4CSqZ8fYMYeTN/lU
 U+6CeSOB/9f9ZQKcaeT3WCBZBaeu30855egKNRcUxP0T1yOcd951oKAI+HtsKu/naa
 yt6JVEgYSS7o6RismuV/OjcD5J37giVjkFrdoUHnNPd1Qn5xNXxeFVsDwZtcsTJ9Yk
 naAdTcYR/lEqnRZgkBE6VOxG+Rs2fOK8BZ2LAL11dbCR0X7xqGbZMOVXKdsuDoyqhE
 lGCdnWiznHm+w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab@kernel.org>) id 1svWvY-00000001V0t-2Yvu;
 Tue, 01 Oct 2024 09:04:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 08/15] acpi/ghes: Prepare to support multiple sources on
 ghes
Date: Tue,  1 Oct 2024 09:03:45 +0200
Message-ID: <c1b1735a490db9b29ca3b989d07f839b5329eefb.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The current code is actually dependent on having just one
error structure with a single source.

As the number of sources should be arch-dependent, as it
will depend on what kind of synchronous/assynchronous
notifications will exist, change the logic to dynamically
build the table.

Yet, for a proper support, we need to get the number of
sources by reading the number from the HEST table. However,
bios currently doesn't store a pointer to it.

For now just change the logic at table build time, while
enforcing that it will behave like before with a single
source ID.

A future patch will add a HEST table bios pointer and
change the logic at acpi_ghes_record_errors() to
dynamically use the new size.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c           | 65 ++++++++++++++++++++++++----------------
 hw/arm/virt-acpi-build.c |  5 ++++
 include/hw/acpi/ghes.h   | 21 ++++++++-----
 3 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index edc74c38bf8a..f3d0283beb3b 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -233,17 +233,26 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
+                                   int num_sources)
 {
     int i, error_status_block_offset;
 
+    /*
+     * TODO: Current version supports only one source.
+     * A further patch will drop this check, after adding a proper migration
+     * code, as, for the code to work, we need to store a bios pointer to the
+     * HEST table.
+     */
+    assert(num_sources == 1);
+
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
@@ -258,13 +267,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 
     /* Reserve space for Error Status Data Block */
     acpi_data_push(hardware_errors,
-        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
+        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
     bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         /*
          * Tell firmware to patch error_block_address entries to point to
          * corresponding "Generic Error Status Block"
@@ -286,10 +295,12 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
 static void build_ghes_v2(GArray *table_data,
                           BIOSLinker *linker,
-                          enum AcpiGhesNotifyType notify,
-                          uint16_t source_id)
+                          const AcpiNotificationSourceId *notif_src,
+                          uint16_t index, int num_sources)
 {
     uint64_t address_offset;
+    const uint16_t notify = notif_src->notify;
+    const uint16_t source_id = notif_src->source_id;
 
     /*
      * Type:
@@ -318,7 +329,7 @@ static void build_ghes_v2(GArray *table_data,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
         address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
-        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
+        ACPI_GHES_ERRORS_FW_CFG_FILE, index * sizeof(uint64_t));
 
     /* Notification Structure */
     build_ghes_hw_error_notification(table_data, notify);
@@ -335,9 +346,10 @@ static void build_ghes_v2(GArray *table_data,
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET,
-        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
-        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
+                                   (num_sources + index) * sizeof(uint64_t));
 
     /*
      * Read Ack Preserve field
@@ -352,19 +364,23 @@ static void build_ghes_v2(GArray *table_data,
 /* Build Hardware Error Source Table */
 void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
+    int i;
 
-    build_ghes_error_table(hardware_errors, linker);
+    build_ghes_error_table(hardware_errors, linker, num_sources);
 
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
-    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, linker,
-                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
+    build_append_int_noprefix(table_data, num_sources, 4);
+    for (i = 0; i < num_sources; i++) {
+        build_ghes_v2(table_data, linker, &notif_source[i], i, num_sources);
+    }
 
     acpi_table_end(linker, &table);
 }
@@ -391,28 +407,27 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
-    assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
-
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
     g_assert(acpi_ged_state);
     ags = &acpi_ged_state->ghes_state;
 
+    /*
+     * Current version supports only one source, as assured during table build,
+     * so no need to change the start offset based on the source ID.
+     */
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
-    if (!physical_address) {
-        return -1;
-    }
-
-    start_addr += source_id * sizeof(uint64_t);
-
     cpu_physical_memory_read(start_addr, &error_block_addr,
                              sizeof(error_block_addr));
 
     error_block_addr = le64_to_cpu(error_block_addr);
 
-    read_ack_register_addr = start_addr +
-                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+    /*
+     * As the current version supports only one source, the ack offset is
+     * just sizeof(uint64_t).
+     */
+    read_ack_register_addr = start_addr + sizeof(uint64_t);
 
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bafd9a56c217..476c365851c4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -890,6 +890,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -945,6 +949,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (vms->ras) {
         acpi_add_table(table_offsets, tables_blob);
         acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
+                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
                         vms->oem_id, vms->oem_table_id);
     }
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 9295e46be25e..d6e2801d9cd9 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -56,20 +56,27 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
-enum {
-    ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
-
-    ACPI_GHES_ERROR_SOURCE_COUNT
-};
-
 typedef struct AcpiGhesState {
     uint64_t ghes_addr_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
+/*
+ * ID numbers used to fill HEST source ID field
+ */
+enum AcpiGhesSourceID {
+    ACPI_HEST_SRC_ID_SYNC,
+};
+
+typedef struct AcpiNotificationSourceId {
+    enum AcpiGhesSourceID source_id;
+    enum AcpiGhesNotifyType notify;
+} AcpiNotificationSourceId;
+
 void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-- 
2.46.0


