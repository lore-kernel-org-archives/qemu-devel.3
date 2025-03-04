Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3BFC282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSNC-0000EH-Di; Tue, 04 Mar 2025 08:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMr-00008R-5N; Tue, 04 Mar 2025 08:31:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMo-0004Ym-UO; Tue, 04 Mar 2025 08:31:28 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 34B195C5CCE;
 Tue,  4 Mar 2025 13:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8055CC4CEE5;
 Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741095076;
 bh=GST5qcNeRlg7u6y0ST05fcX+0FAmxCQwqPk5rZdMmvI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mhrTaof2ZW8bzlwAkf9KYcy89ChGQ63SOkPhYVu/ouN5c7NMvCOvZsWs8VSUB4+JG
 ck9U5LG/RkeNsdt+GrY1IDPrpUA5NrYcFrLiCBv0SWy22AC80B3bj51PjRK45ZrGmp
 KiLhjfF9FTdt/jRl5VkqiqtM7+L2oZTQy/47QmvgTU1fLnVWrNKx1rk6Fh2KkXsTzk
 mftqLLvSYZ+BTOlGzc5TZwZOpyWVqIqNEg/S5U/uwpsT7sw0Cv6ifSqn1OuiMRxheo
 WDFpcC9AnmZAQcQe7UtQUc3ZQGFxWjsIBqzb7RRRcHHznrNxnifFGFnfOM0Wc7unVi
 HSqxROUUjs6UA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMc-00000005rnP-1tjP; Tue, 04 Mar 2025 14:31:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/3] acpi/ghes: move use_hest_addr out of acpi_build_hest()
Date: Tue,  4 Mar 2025 14:30:56 +0100
Message-ID: <e1abcd0e1c5b66d91a7faed5b4147951c11b2e6d.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741094512.git.mchehab+huawei@kernel.org>
References: <cover.1741094512.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The only reason why we're passing ags to acpi HEST table build
is to check if migration will be used or not.

Well, we only need migration for arm, as other architectures
will only use the new code. So, move this out of acpi_build_hest(),
as otherwise we can't use it for x86, as the hotplug logic there
may not initialize ags during acpi table build time.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c           | 16 ++++++++--------
 hw/arm/virt-acpi-build.c | 12 ++++++++----
 include/hw/acpi/ghes.h   | 25 +++++++++++++------------
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 1fd5ba941771..ea00fed75c16 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -243,7 +243,7 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
+static void build_ghes_error_table(GArray *hardware_errors, bool use_hest_addr,
                                    BIOSLinker *linker, int num_sources)
 {
     int i, error_status_block_offset;
@@ -289,7 +289,7 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
                                        i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
     }
 
-    if (!ags->use_hest_addr) {
+    if (!use_hest_addr) {
         /*
          * Tell firmware to write hardware_errors GPA into
          * hardware_errors_addr fw_cfg, once the former has been initialized.
@@ -372,7 +372,7 @@ static void build_ghes_v2_entry(GArray *table_data,
 }
 
 /* Build Hardware Error Source Table */
-void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
+void acpi_build_hest(GArray *table_data, bool use_hest_addr,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
                      const AcpiNotificationSourceId *notif_source,
@@ -386,7 +386,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 
     hest_offset = table_data->len;
 
-    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
+    build_ghes_error_table(hardware_errors, use_hest_addr, linker, num_sources);
 
     acpi_table_begin(&table, table_data);
 
@@ -398,7 +398,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 
     acpi_table_end(linker, &table);
 
-    if (ags->use_hest_addr) {
+    if (use_hest_addr) {
         /*
          * Tell firmware to write into GPA the address of HEST via fw_cfg,
          * once initialized.
@@ -411,13 +411,13 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
-                          GArray *hardware_error)
+                          bool use_hest_addr, GArray *hardware_error)
 {
     /* Create a read-only fw_cfg file for GHES */
     fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
-    if (ags->use_hest_addr) {
+    if (use_hest_addr) {
         fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
             NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
     } else {
@@ -529,7 +529,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
         return;
     }
 
-    if (!ags->use_hest_addr) {
+    if (ags->hw_error_le) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
     } else {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 154337e1a77b..71da17b652b2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -964,9 +964,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         acpi_ged_state = ACPI_GED(vms->acpi_dev);
         ags = &acpi_ged_state->ghes_state;
         if (ags) {
+            bool use_hest_addr = ags->use_hest_addr;
+
             acpi_add_table(table_offsets, tables_blob);
 
-            if (!ags->use_hest_addr) {
+            if (!use_hest_addr) {
                 notify = hest_ghes_notify_9_2;
                 notify_sz = ARRAY_SIZE(hest_ghes_notify_9_2);
             } else {
@@ -974,7 +976,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                 notify_sz = ARRAY_SIZE(hest_ghes_notify);
             }
 
-            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
+            acpi_build_hest(tables_blob, use_hest_addr, tables->hardware_errors,
                             tables->linker, notify, notify_sz,
                             vms->oem_id, vms->oem_table_id);
         }
@@ -1143,8 +1145,10 @@ void virt_acpi_setup(VirtMachineState *vms)
     if (vms->ras) {
         assert(vms->acpi_dev);
         acpi_ged_state = ACPI_GED(vms->acpi_dev);
-        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
-                             vms->fw_cfg, tables.hardware_errors);
+        AcpiGhesState *ags = &acpi_ged_state->ghes_state;
+
+        acpi_ghes_add_fw_cfg(ags, vms->fw_cfg, ags->use_hest_addr,
+                             tables.hardware_errors);
     }
 
     build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index df2ecbf6e4a9..eae6d4d0a562 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,31 +73,32 @@ typedef struct AcpiNotificationSourceId {
     enum AcpiGhesNotifyType notify;
 } AcpiNotificationSourceId;
 
-/*
- * AcpiGhesState stores GPA values that will be used to fill HEST entries.
+/**
+ * struct AcpiGhesState - GPA values that will be used to fill HEST entries
  *
- * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
- * is stored at hw_error_le. This is the default on QEMU 9.x.
+ * @hest_addr_le: GPA of the HEST table. Used on QEMU 10.x and above.
+ * @hw_error_le: GPA of the etc/hardware_errors firmware.
+ *               Used only on arm64 virt-9.x to preserve compatibility
+ *               with QEMU 9.x.
+ * @use_hest_addr: True if HEST address is present. Used only on arm64,
+ *                 to identify if QEMU 9.x migration is needed.
  *
- * When use_hest_addr is true, the GPA of the HEST table is stored at
- * hest_addr_le. This is the default for QEMU 10.x and above.
- *
- * Whe both GPA values are equal to zero means that GHES is not present.
+ * When both GPA values are equal to zero means that GHES is not present.
  */
 typedef struct AcpiGhesState {
     uint64_t hest_addr_le;
     uint64_t hw_error_le;
-    bool use_hest_addr; /* True if HEST address is present */
+    bool use_hest_addr;
 } AcpiGhesState;
 
-void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
+void acpi_build_hest(GArray *table_data, bool use_hest_addr,
                      GArray *hardware_errors,
                      BIOSLinker *linker,
                      const AcpiNotificationSourceId * const notif_source,
                      int num_sources,
                      const char *oem_id, const char *oem_table_id);
-void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
-                          GArray *hardware_errors);
+void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
+                          bool use_hest_addr, GArray *hardware_error);
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
                             uint64_t error_physical_addr);
 void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
-- 
2.48.1


