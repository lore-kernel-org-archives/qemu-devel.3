Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2860FC6169
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 06:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spM2j-0008EU-Vl; Sat, 14 Sep 2024 02:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2h-00083V-7Y; Sat, 14 Sep 2024 02:13:59 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2e-0000ux-3f; Sat, 14 Sep 2024 02:13:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BD413A4024A;
 Sat, 14 Sep 2024 06:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64D6C4CECD;
 Sat, 14 Sep 2024 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726294434;
 bh=4nkPL9h+S80jnhPl5MbfHcBCQhk2JE5FY0doqNnZLTA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NpQxbdkUfIAulECCdPSWhku5BWLFEwkbKeyUH8Dyfa0Bgtr6wvBSLR0W1VWWZ1v7O
 zZxq9GdmCSx3QJdaj/XJvxp9Z7RWplH0Sn+yB0h82rPh+UmiozUgmi3cmUM3W40ewO
 27n3W64ZD1Hi5uY8fCofyV6k2UPKUzlemcPx/5E43HDB1vi1WYFgENIg95N5jGh2Zy
 aOoltq0LvEEjp73bQHCDMG10Sjm+mtwqQ0Pk84RKFoqSgZvpQNOhA9psujT+RM6Hge
 EScpJiv6T7uesA8gdvwWZd+Ed+Mc/scOjK11hP6AIxgXQl07HesMG06i4TzLIw721F
 gCHysnv2VOqJA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2a-00000003V5r-0Uw1; Sat, 14 Sep 2024 08:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v10 07/21] acpi/ghes: rework the logic to handle HEST source ID
Date: Sat, 14 Sep 2024 08:13:28 +0200
Message-ID: <0dd7081717b23b4c1536bc86abfa926388cf2139.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
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

Changes from v9:
- patch split on multiple patches to avoid multiple changes
  at the same patch.

Changes from v8:
- Non-rename/cleanup changes merged altogether;
- source ID is now more generic, defined per guest target.
  That should make easier to add support for 86.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 95 ++++++++++++++++++++++++++++++------------
 include/hw/acpi/ghes.h |  6 ++-
 2 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 36fe5f68782f..6e5f0e8cf0c9 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -61,6 +61,23 @@
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
+/*
+ * Offsets with regards to the start of the HEST table stored at
+ * ags->hest_addr_le, according with the memory layout map at
+ * docs/specs/acpi_hest_ghes.rst.
+ */
+
+/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
+ * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
+ */
+#define HEST_GHES_V2_TABLE_SIZE  92
+#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
+
+/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
+ * Table 18-380: 'Error Status Address' field
+ */
+#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
+
 /*
  * Values for error_severity field
  */
@@ -401,11 +418,13 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
 
 int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 {
-    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
-    bool ret = -1;
+    uint64_t hest_read_ack_start_addr, read_ack_start_addr;
+    uint64_t hest_addr, cper_addr, err_source_struct;
+    uint64_t hest_err_block_addr, error_block_addr;
+    uint32_t i, ret;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
+    uint64_t read_ack;
 
     assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
 
@@ -414,44 +433,66 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     g_assert(acpi_ged_state);
     ags = &acpi_ged_state->ghes_state;
 
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
+    hest_addr = le64_to_cpu(ags->hest_addr_le);
 
     if (!physical_address) {
         return -1;
     }
 
-    start_addr += source_id * sizeof(uint64_t);
+    err_source_struct = hest_addr + ACPI_GHES_ERROR_SOURCE_COUNT;
 
-    cpu_physical_memory_read(start_addr, &error_block_addr,
-                                sizeof(error_block_addr));
+    /*
+     * Currently, HEST Error source navigates only for GHESv2 tables
+     */
+    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+        uint64_t addr = err_source_struct;
+        uint16_t type, src_id;
 
-    error_block_addr = le64_to_cpu(error_block_addr);
+        cpu_physical_memory_read(addr, &type, sizeof(type));
 
-    read_ack_register_addr = start_addr +
-        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+        /* For now, we only know the size of GHESv2 table */
+        assert(type == ACPI_GHES_SOURCE_GENERIC_ERROR_V2);
 
-    cpu_physical_memory_read(read_ack_register_addr,
-                                &read_ack_register, sizeof(read_ack_register));
+        /* It is GHES. Compare CPER source address */
+        addr += sizeof(type);
+        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
 
-    /* zero means OSPM does not acknowledge the error */
-    if (!read_ack_register) {
-        error_report("OSPM does not acknowledge previous error,"
-            " so can not record CPER for current error anymore");
-    } else if (error_block_addr) {
-        read_ack_register = cpu_to_le64(0);
-        /*
-         * Clear the Read Ack Register, OSPM will write it to 1 when
-         * it acknowledges this error.
-         */
-        cpu_physical_memory_write(read_ack_register_addr,
-            &read_ack_register, sizeof(uint64_t));
+        if (src_id == source_id) {
+            break;
+        }
 
-        ret = acpi_ghes_record_mem_error(error_block_addr,
-                                            physical_address);
-    } else {
+        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
+    }
+    if (i == ACPI_GHES_ERROR_SOURCE_COUNT) {
         error_report("can not find Generic Error Status Block");
+
+        return -1;
     }
 
+    /* Navigate though table address pointers */
+
+    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
+    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
+
+    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+
+    cpu_physical_memory_read(error_block_addr, &cper_addr,
+                             sizeof(error_block_addr));
+
+    cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr,
+                             sizeof(read_ack_start_addr));
+
+    /* Update ACK offset to notify about a new error */
+
+    cpu_physical_memory_read(read_ack_start_addr,
+                             &read_ack, sizeof(read_ack));
+
+    read_ack = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_start_addr,
+                              &read_ack, sizeof(read_ack));
+
+    ret = acpi_ghes_record_mem_error(error_block_addr, physical_address);
     return ret;
 }
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index c9bbda4740e2..7485f54c28f2 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -23,6 +23,7 @@
 #define ACPI_GHES_H
 
 #include "hw/acpi/bios-linker-loader.h"
+#include "qapi/error.h"
 
 /*
  * Values for Hardware Error Notification Type field
@@ -74,7 +75,10 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(uint8_t source_id,
+                            uint64_t error_physical_addr);
+void ghes_record_cper_errors(const void *cper, size_t len,
+                             uint16_t source_id, Error **errp);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
2.46.0


