Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBA4C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0sJ-0000G1-1t; Tue, 13 Aug 2024 19:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0sF-0008S8-HA; Tue, 13 Aug 2024 19:24:19 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0sB-0006qu-VC; Tue, 13 Aug 2024 19:24:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 946F26192A;
 Tue, 13 Aug 2024 23:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F569C4AF12;
 Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723591451;
 bh=bwenX6wHabHpmTrica6FvqsqNFRBHQuBfjqww4NqP6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sll9plgXVrmRbPMFy9b7MlARCn2iU/5z6SpbKAxJWaayV1PxdhyD5Arc5x6z+aERM
 EMVeJ8P1WspoXhJK5fITj5JeBwJsxVgHr4VnvRFMHj/6av9/UJqWNgw1GtJn787WR6
 g2QXNWbHOWLa/6ng70BDpNNXEe6MzuPOIagn5wz0PnDX0rPp2w0N1+9aMfSEmy+6J2
 +IDpTAoQVdvTKovORFNhWb9P72X+uVOGgouxDK8JCV+Y21r352y5yMXeNbeGpbGbSY
 VkbO5Wt/xhkga0HVsu4Es26esD65AxL/7HtwMVJY4W1RB1w0A2msp7hrLiRZouBtIX
 8sb+VgUsVdkew==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0s5-00000002asQ-1fJg; Wed, 14 Aug 2024 01:24:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v7 05/10] acpi/ghes: rework the logic to handle HEST source ID
Date: Wed, 14 Aug 2024 01:23:27 +0200
Message-ID: <9f5843c6f774035e80a7a19e0091c347edff9d02.1723591201.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The current logic is based on a lot of duct tape, with
offsets calculated based on one define with the number of
source IDs and an enum.

Rewrite the logic in a way that it would be more resilient
of code changes, by moving the source ID count to an enum
and make the offset calculus more explicit.

Such change was inspired on a patch from Jonathan Cameron
splitting the logic to get the CPER address on a separate
function, as this will be needed to support generic error
injection.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes-stub.c      |   3 +-
 hw/acpi/ghes.c           | 204 +++++++++++++++++++++++----------------
 hw/arm/virt-acpi-build.c |   5 +-
 include/hw/acpi/ghes.h   |  17 ++--
 4 files changed, 133 insertions(+), 96 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index c315de1802d6..8762449870b5 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,8 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+                            uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 280674452a60..f93499d7d647 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -28,14 +28,23 @@
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
 
-#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
-#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
+#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
+#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
+#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
 
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
 
-/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
-#define ACPI_GHES_ERROR_SOURCE_COUNT        2
+/*
+ * ID numbers used to fill HEST source ID field
+ */
+enum AcpiHestSourceId {
+    ACPI_HEST_SRC_ID_SEA,
+    ACPI_HEST_SRC_ID_GED,
+
+    /* Shall be the last one */
+    ACPI_HEST_SRC_ID_COUNT
+} AcpiHestSourceId;
 
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
@@ -63,6 +72,15 @@
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
+/*
+ * Offsets with regards to the start of the HEST table stored at
+ * ags->hest_addr_le, according with the memory layout map at
+ * docs/specs/acpi_hest_ghes.rst.
+ */
+#define ACPI_HEST_TABLE_SIZE     40
+#define HEST_GHES_V2_TABLE_SIZE  92
+#define HEST_ACK_OFFSET          (68 + ACPI_HEST_TABLE_SIZE)
+
 /*
  * Values for error_severity field
  */
@@ -236,17 +254,17 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 {
     int i, error_status_block_offset;
 
     /* Build error_block_address */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
         build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
     }
 
     /* Build read_ack_register */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
         /*
          * Initialize the value of read_ack_register to 1, so GHES can be
          * writable after (re)boot.
@@ -261,20 +279,20 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 
     /* Reserve space for Error Status Data Block */
     acpi_data_push(hardware_errors,
-        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
+        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_HEST_SRC_ID_COUNT);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
-    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
+    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
         /*
          * Tell firmware to patch error_block_address entries to point to
          * corresponding "Generic Error Status Block"
          */
         bios_linker_loader_add_pointer(linker,
-            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
-            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
+            ACPI_HW_ERROR_FW_CFG_FILE, sizeof(uint64_t) * i,
+            sizeof(uint64_t), ACPI_HW_ERROR_FW_CFG_FILE,
             error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
     }
 
@@ -282,16 +300,39 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
      * tell firmware to write hardware_errors GPA into
      * hardware_errors_addr fw_cfg, once the former has been initialized.
      */
-    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
-        0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
+    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
+                                     sizeof(uint64_t),
+                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
+}
+
+static bool ghes_notify_to_source_id(enum AcpiGhesNotifyType notify,
+                                     enum AcpiHestSourceId *source_id)
+{
+    switch (notify) {
+    case ACPI_GHES_NOTIFY_SEA:             /* ARMv8 */
+        *source_id = ACPI_HEST_SRC_ID_SEA;
+        return false;
+    case ACPI_GHES_NOTIFY_GPIO:
+        *source_id = ACPI_HEST_SRC_ID_GED;
+        return false;
+    default:
+        /* Unsupported notification types */
+        return true;
+    }
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
+static void build_ghes_v2(GArray *table_data,
+                          enum AcpiGhesNotifyType notify,
+                          BIOSLinker *linker)
 {
     uint64_t address_offset;
+    enum AcpiHestSourceId source_id;
 
-    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
+    if (ghes_notify_to_source_id(notify, &source_id)) {
+        error_report("Error: notify %d not supported", notify);
+        abort();
+    }
 
     /*
      * Type:
@@ -319,24 +360,13 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
-        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_HW_ERROR_FW_CFG_FILE,
+                                   source_id * sizeof(uint64_t));
 
-    switch (source_id) {
-    case ACPI_HEST_SRC_ID_SEA:
-        /*
-         * Notification Structure
-         * Now only enable ARMv8 SEA notification type
-         */
-        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
-        break;
-    case ACPI_HEST_SRC_ID_GED:
-        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
-        break;
-    default:
-        error_report("Not support this error source");
-        abort();
-    }
+    /* Notification Structure */
+    build_ghes_hw_error_notification(table_data, notify);
 
     /* Error Status Block Length */
     build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
@@ -350,9 +380,10 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-        address_offset + GAS_ADDR_OFFSET,
-        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
-        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
+                                   address_offset + GAS_ADDR_OFFSET,
+                                   sizeof(uint64_t),
+                                   ACPI_BUILD_TABLE_FILE,
+                                   address_offset + GAS_ADDR_OFFSET);
 
     /*
      * Read Ack Preserve field
@@ -365,89 +396,100 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 }
 
 /* Build Hardware Error Source Table */
-void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
+void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+                     BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
+    build_ghes_error_table(hardware_errors, linker);
+
+    int hest_offset = table_data->len;
+
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
-    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
-    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GED, linker);
+    build_append_int_noprefix(table_data, ACPI_HEST_SRC_ID_COUNT, 4);
+    build_ghes_v2(table_data, ACPI_GHES_NOTIFY_SEA, linker);
+    build_ghes_v2(table_data, ACPI_GHES_NOTIFY_GPIO, linker);
 
     acpi_table_end(linker, &table);
+
+    /*
+     * tell firmware to write into GPA the address of HEST via fw_cfg,
+     * once initialized.
+     */
+    bios_linker_loader_write_pointer(linker,
+                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
+                                     sizeof(uint64_t),
+                                     ACPI_BUILD_TABLE_FILE, hest_offset);
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
                           GArray *hardware_error)
 {
     /* Create a read-only fw_cfg file for GHES */
-    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
+    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
     /* Create a read-write fw_cfg file for Address */
-    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
+    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
         NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
 
+    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
+        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+                            uint64_t physical_address)
 {
-    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
-    bool ret = -1;
+    uint64_t cper_addr, read_ack_register = 0;
+    uint64_t read_ack_start_addr;
+    enum AcpiHestSourceId source;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
-    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
+    if (ghes_notify_to_source_id(ACPI_HEST_SRC_ID_SEA, &source)) {
+        error_report("GHES: Invalid error block/ack address(es) for notify %d",
+                     notify);
+        return -1;
+    }
 
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
     g_assert(acpi_ged_state);
     ags = &acpi_ged_state->ghes_state;
 
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
+    cper_addr = le64_to_cpu(ags->ghes_addr_le);
+    cper_addr += 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
+    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
 
-    if (physical_address) {
-        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
-            start_addr += source_id * sizeof(uint64_t);
-        }
+    read_ack_start_addr = le64_to_cpu(ags->hest_addr_le);
+    read_ack_start_addr += source * HEST_GHES_V2_TABLE_SIZE + HEST_ACK_OFFSET;
 
-        cpu_physical_memory_read(start_addr, &error_block_addr,
-                                 sizeof(error_block_addr));
-
-        error_block_addr = le64_to_cpu(error_block_addr);
-
-        read_ack_register_addr = start_addr +
-            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
-
-        cpu_physical_memory_read(read_ack_register_addr,
-                                 &read_ack_register, sizeof(read_ack_register));
-
-        /* zero means OSPM does not acknowledge the error */
-        if (!read_ack_register) {
-            error_report("OSPM does not acknowledge previous error,"
-                " so can not record CPER for current error anymore");
-        } else if (error_block_addr) {
-            read_ack_register = cpu_to_le64(0);
-            /*
-             * Clear the Read Ack Register, OSPM will write it to 1 when
-             * it acknowledges this error.
-             */
-            cpu_physical_memory_write(read_ack_register_addr,
-                &read_ack_register, sizeof(uint64_t));
-
-            ret = acpi_ghes_record_mem_error(error_block_addr,
-                                             physical_address);
-        } else
-            error_report("can not find Generic Error Status Block");
+    if (!physical_address) {
+        error_report("can not find Generic Error Status Block for notify %d",
+                     notify);
+        return -1;
     }
 
-    return ret;
+    cpu_physical_memory_read(read_ack_start_addr,
+                             &read_ack_register, sizeof(read_ack_register));
+
+    /* zero means OSPM does not acknowledge the error */
+
+    read_ack_register = cpu_to_le64(0);
+    /*
+     * Clear the Read Ack Register, OSPM will write it to 1 when
+     * it acknowledges this error.
+     */
+    cpu_physical_memory_write(read_ack_start_addr,
+                              &read_ack_register, sizeof(uint64_t));
+
+    return acpi_ghes_record_mem_error(cper_addr, physical_address);
 }
 
 NotifierList acpi_generic_error_notifiers =
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1769467d23b2..79635bc7a0a8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -944,10 +944,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_dbg2(tables_blob, tables->linker, vms);
 
     if (vms->ras) {
-        build_ghes_error_table(tables->hardware_errors, tables->linker);
         acpi_add_table(table_offsets, tables_blob);
-        acpi_build_hest(tables_blob, tables->linker, vms->oem_id,
-                        vms->oem_table_id);
+        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
+                        vms->oem_id, vms->oem_table_id);
     }
 
     if (ms->numa_state->num_nodes > 0) {
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 99d12d69c864..2524b5e64624 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -29,7 +29,7 @@
 extern NotifierList acpi_generic_error_notifiers;
 
 /*
- * Values for Hardware Error Notification Type field
+ * ACPI spec values for Hardware Error Notification Type field
  */
 enum AcpiGhesNotifyType {
     /* Polled */
@@ -60,24 +60,19 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
-/* Those are used as table indexes when building GHES tables */
-enum {
-    ACPI_HEST_SRC_ID_SEA = 0,
-    ACPI_HEST_SRC_ID_GED,
-    ACPI_HEST_SRC_ID_RESERVED,
-};
-
 typedef struct AcpiGhesState {
+    uint64_t hest_addr_le;
     uint64_t ghes_addr_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
-void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
-void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
+void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+                     BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+                            uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
2.46.0


