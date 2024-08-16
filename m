Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8275FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serXK-0007gz-SV; Fri, 16 Aug 2024 03:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serXI-0007Yk-MW; Fri, 16 Aug 2024 03:38:12 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serX9-0005v5-0r; Fri, 16 Aug 2024 03:38:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 18460CE1EF6;
 Fri, 16 Aug 2024 07:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D5C4AF12;
 Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723793873;
 bh=CVbWcAOnbhzuAqQUj9IQkyqnNpkcMiuJof1ZiJ1dGRA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FCfYt9Lqm6OC4uvG675SboMAdiq2f6O4aVkWr4zC9swcaazaVbq5pNHWs903JbpFl
 25Q/xXJnLm9M8SIPLwMkFedoMx/K3W2GqKmtK8rLgv0eMhnQLndGZjaKPWfVawfOgW
 6axe2Ae23THZRGliJGhuty74vnts7zGDfUtohNQmVbKCo0YiVM8Ex+9ZU2YaQoI6Kf
 At6GTFMcIW/Mq83W0piu5ZB4orrrrfcbZRxA9emGL95pnTStH+lHq0svlXs3s/ppOf
 okUbX2q54itYt7w28ScBHp5SXYR09vfvms77zoo6TCXOS1avxRCuNmGkQKeYgLyCI2
 YADVLhGUlVztw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1serWx-000000055ej-2Tik; Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v8 07/13] acpi/ghes: cleanup the memory error code logic
Date: Fri, 16 Aug 2024 09:37:39 +0200
Message-ID: <b7837d0db674d535139971ae81c5da70c18f1d41.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Better organize the code of the function, making it to use the
raw CPER function, thus removing duplicated code.

While here, rename the function to actually reflect what it does.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes-stub.c    |   2 +-
 hw/acpi/ghes.c         | 125 +++++++++++++++--------------------------
 include/hw/acpi/ghes.h |   4 +-
 target/arm/kvm.c       |   2 +-
 4 files changed, 50 insertions(+), 83 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 8762449870b5..a60ae07a8e7c 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+int acpi_ghes_memory_errors(enum AcpiGhesNotifyType notify,
                             uint64_t physical_address)
 {
     return -1;
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a3ae710dcf81..4f7b6c5ad2b6 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -206,51 +206,30 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
     build_append_int_noprefix(table, 0, 7);
 }
 
-static int acpi_ghes_record_mem_error(uint64_t error_block_address,
-                                      uint64_t error_physical_addr)
+static void
+ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
+                                            const uint8_t *section_type,
+                                            int data_length)
 {
-    GArray *block;
-
-    /* Memory Error Section Type */
-    const uint8_t uefi_cper_mem_sec[] =
-          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
-                  0xED, 0x7C, 0x83, 0xB1);
-
     /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
      * Table 17-13 Generic Error Data Entry
      */
     QemuUUID fru_id = {};
-    uint32_t data_length;
 
-    block = g_array_new(false, true /* clear */, 1);
-
-    /* This is the length if adding a new generic error data entry*/
-    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
     /*
-     * It should not run out of the preallocated memory if adding a new generic
-     * error data entry
+     * Calculate the size with this block. No need to check for
+     * too big CPER, as CPER size is checked at ghes_record_cper_errors()
      */
-    assert((data_length + ACPI_GHES_GESB_SIZE) <=
-            ACPI_GHES_MAX_RAW_DATA_LENGTH);
+    data_length += ACPI_GHES_GESB_SIZE;
 
     /* Build the new generic error status block header */
     acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
         0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
 
     /* Build this new generic error data entry header */
-    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
+    acpi_ghes_generic_error_data(block, section_type,
         ACPI_CPER_SEV_RECOVERABLE, 0, 0,
         ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
-
-    /* Build the memory section CPER for above new generic error data entry */
-    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
-
-    /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_address, block->data, block->len);
-
-    g_array_free(block, true);
-
-    return 0;
 }
 
 /*
@@ -448,59 +427,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
-                            uint64_t physical_address)
-{
-    uint64_t cper_addr, read_ack_register = 0;
-    uint64_t read_ack_start_addr;
-    enum AcpiHestSourceId source;
-    AcpiGedState *acpi_ged_state;
-    AcpiGhesState *ags;
-
-    if (ghes_notify_to_source_id(ACPI_HEST_SRC_ID_SEA, &source)) {
-        error_report("GHES: Invalid error block/ack address(es) for notify %d",
-                     notify);
-        return -1;
-    }
-
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    g_assert(acpi_ged_state);
-    ags = &acpi_ged_state->ghes_state;
-
-    cper_addr = le64_to_cpu(ags->ghes_addr_le);
-    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
-    read_ack_start_addr = cper_addr + source * sizeof(uint64_t);
-
-    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
-    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
-
-    if (!physical_address) {
-        error_report("can not find Generic Error Status Block for notify %d",
-                     notify);
-        return -1;
-    }
-
-    cpu_physical_memory_read(read_ack_start_addr,
-                             &read_ack_register, sizeof(read_ack_register));
-
-    /* zero means OSPM does not acknowledge the error */
-
-    read_ack_register = cpu_to_le64(0);
-    /*
-     * Clear the Read Ack Register, OSPM will write it to 1 when
-     * it acknowledges this error.
-     */
-    cpu_physical_memory_write(read_ack_start_addr,
-                              &read_ack_register, sizeof(uint64_t));
-
-    return acpi_ghes_record_mem_error(cper_addr, physical_address);
-}
-
 NotifierList acpi_generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
 
-void ghes_record_cper_errors(uint8_t *cper, size_t len,
+void ghes_record_cper_errors(const void *cper, size_t len,
                              enum AcpiGhesNotifyType notify, Error **errp)
 {
     uint64_t cper_addr, read_ack_start_addr;
@@ -557,6 +487,43 @@ void ghes_record_cper_errors(uint8_t *cper, size_t len,
     notifier_list_notify(&acpi_generic_error_notifiers, NULL);
 }
 
+int acpi_ghes_memory_errors(enum AcpiGhesNotifyType notify,
+                            uint64_t physical_address)
+{
+    /* Memory Error Section Type */
+    const uint8_t guid[] =
+          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
+                  0xED, 0x7C, 0x83, 0xB1);
+    Error *errp = NULL;
+    GArray *block;
+
+    if (!physical_address) {
+        error_report("can not find Generic Error Status Block for notify %d",
+                     notify);
+        return -1;
+    }
+
+    block = g_array_new(false, true /* clear */, 1);
+
+    ghes_gen_err_data_uncorrectable_recoverable(block, guid,
+                                                ACPI_GHES_MAX_RAW_DATA_LENGTH);
+
+    /* Build the memory section CPER for above new generic error data entry */
+    acpi_ghes_build_append_mem_cper(block, physical_address);
+
+    /* Report the error */
+    ghes_record_cper_errors(block->data, block->len, notify, &errp);
+
+    g_array_free(block, true);
+
+    if (errp) {
+        error_report_err(errp);
+        return -1;
+    }
+
+    return 0;
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 6e349264fd8b..a24fe8a3bc33 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -71,7 +71,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
+int acpi_ghes_memory_errors(enum AcpiGhesNotifyType notify,
                             uint64_t error_physical_addr);
 void ghes_record_cper_errors(const void *cper, size_t len,
                              enum AcpiGhesNotifyType notify, Error **errp);
@@ -80,7 +80,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
  * Returns: true if the system has an ACPI GHES table and it is
- * safe to call acpi_ghes_record_errors() to record a memory error.
+ * safe to call acpi_ghes_memory_errors() to record a memory error.
  */
 bool acpi_ghes_present(void);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 849e2e21b304..915f07376c8f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2373,7 +2373,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
+                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
                     kvm_inject_arm_sea(c);
                 } else {
                     error_report("failed to record the error");
-- 
2.46.0


