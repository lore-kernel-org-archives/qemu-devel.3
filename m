Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99E2CAC5AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0x5a-00021K-IX; Tue, 23 Sep 2025 03:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0x4t-00018H-88; Tue, 23 Sep 2025 03:04:44 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0x4f-0007Lq-Q9; Tue, 23 Sep 2025 03:04:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D133160282;
 Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCBDC4CEF7;
 Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758611060;
 bh=ofcHBuhFOvjiK3eMBJ1InrkStaT2tzG2+P50HpbeTxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aemIy2SWHOc6ATLgHkw+cK0iTFhEhycmJO6RrWymsxhBePPw5dJxP9BXnMryrUf7H
 /AwiNDPo/XH9Cj1LFdihxGwnTf7SkwUAle/1xgUCdrudLHkJVvODF45k1jpkq1RhzE
 qmVtzY7mHKPLDe3yvQYxViAgRj8NeS3/NUiXbjVEqTa7KninF0v9ktBPViTm2kmmrU
 5r0zEpcWuljFMVUvDHjRkSBFXel+uSNUOsR7wDcrRFJY7hW2M3ZZZ3A/2d13+r2kJ/
 tZ8amCUi9RYxpKzl/+wBh0WQxOyOyq5KL6b5p48ZwWyrK7o+xchO74McXCKVfGFYOJ
 k6W52UiBUS5dQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0x4U-00000006bKS-0vcd; Tue, 23 Sep 2025 09:04:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v12 02/17] acpi/ghes: Cleanup the code which gets ghes ged
 state
Date: Tue, 23 Sep 2025 09:03:56 +0200
Message-ID: <2bbb1d3eb88b0a668114adef2f1c2a94deebba0e.1758610789.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758610789.git.mchehab+huawei@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the check logic into a common function and simplify the
code which checks if GHES is enabled and was properly setup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes-stub.c    |  7 ++++---
 hw/acpi/ghes.c         | 38 +++++++++++---------------------------
 include/hw/acpi/ghes.h | 14 +++++++-------
 target/arm/kvm.c       |  7 +++++--
 4 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 7cec1812dad9..40f660c246fe 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,12 +11,13 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
+int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                            uint64_t physical_address)
 {
     return -1;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
-    return false;
+    return NULL;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b709c177cdea..84b891fd3dcf 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -360,18 +360,12 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     /* Create a read-write fw_cfg file for Address */
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
         NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
-
-    ags->present = true;
 }
 
 static void get_hw_error_offsets(uint64_t ghes_addr,
                                  uint64_t *cper_addr,
                                  uint64_t *read_ack_register_addr)
 {
-    if (!ghes_addr) {
-        return;
-    }
-
     /*
      * non-HEST version supports only one source, so no need to change
      * the start offset based on the source ID. Also, we can't validate
@@ -390,35 +384,20 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
-void ghes_record_cper_errors(const void *cper, size_t len,
+void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
-    AcpiGedState *acpi_ged_state;
-    AcpiGhesState *ags;
 
     if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
         error_setg(errp, "GHES CPER record is too big: %zd", len);
         return;
     }
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    if (!acpi_ged_state) {
-        error_setg(errp, "Can't find ACPI_GED object");
-        return;
-    }
-    ags = &acpi_ged_state->ghes_state;
-
     assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
     get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                          &cper_addr, &read_ack_register_addr);
 
-    if (!cper_addr) {
-        error_setg(errp, "can not find Generic Error Status Block");
-        return;
-    }
-
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
@@ -444,7 +423,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     return;
 }
 
-int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
+int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                            uint64_t physical_address)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
@@ -470,7 +450,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     acpi_ghes_build_append_mem_cper(block, physical_address);
 
     /* Report the error */
-    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
+    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
 
     g_array_free(block, true);
 
@@ -482,7 +462,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     return 0;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -491,8 +471,12 @@ bool acpi_ghes_present(void)
                                                        NULL));
 
     if (!acpi_ged_state) {
-        return false;
+        return NULL;
     }
     ags = &acpi_ged_state->ghes_state;
-    return ags->present;
+
+    if (!ags->hw_error_le) {
+        return NULL;
+    }
+    return ags;
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 39619a2457cb..f96ac3e85ca2 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -66,7 +66,6 @@ enum {
 
 typedef struct AcpiGhesState {
     uint64_t hw_error_le;
-    bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
 void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
@@ -74,15 +73,16 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
-void ghes_record_cper_errors(const void *cper, size_t len,
+int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                            uint64_t error_physical_addr);
+void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
 /**
- * acpi_ghes_present: Report whether ACPI GHES table is present
+ * acpi_ghes_get_state: Get a pointer for ACPI ghes state
  *
- * Returns: true if the system has an ACPI GHES table and it is
- * safe to call acpi_ghes_memory_errors() to record a memory error.
+ * Returns: a pointer to ghes state if the system has an ACPI GHES table,
+ * NULL, otherwise.
  */
-bool acpi_ghes_present(void);
+AcpiGhesState *acpi_ghes_get_state(void);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c1ec6654ca67..bdc04aa41d54 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2443,10 +2443,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
+    AcpiGhesState *ags;
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
-    if (acpi_ghes_present() && addr) {
+    ags = acpi_ghes_get_state();
+    if (ags && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
@@ -2464,7 +2466,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
+                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SEA,
+                                             paddr)) {
                     kvm_inject_arm_sea(c);
                 } else {
                     error_report("failed to record the error");
-- 
2.51.0


