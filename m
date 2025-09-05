Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D7FCA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 15:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuY5I-0007wM-UF; Fri, 05 Sep 2025 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uuY4t-0007bb-Mn; Fri, 05 Sep 2025 11:10:19 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uuY4c-0005zu-5T; Fri, 05 Sep 2025 11:10:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05647602A2;
 Fri,  5 Sep 2025 15:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F416C4CEF7;
 Fri,  5 Sep 2025 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757084974;
 bh=4yv2rjNBd8hAvZyMViY9N4TK8U5HT/EcD4khMKN6+lA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u1RgYTFOv5wAY+7R2ex7rSidBAhz/RJnYK7cGNKpWOUb1Qci9WdVau8S8+er4vYKh
 SggKMcD8LqFG2oVMHl9scURilflTPGX58RhZjw4OJ6tlmv7yn0VZAavB+rfuJq+EnF
 1uY+hDKIAcCKNJ1a+iGWdujPGu+F/NpBMXa3xotP3DwG6wE/w4etaFH9b9ybKZ9liZ
 1pNW8snZaDCmfBUSgLEHeh+SyccqyxaVaAM3LXM0j5JehOv/rMbD2hjXpcP1XUQGwS
 Qs3rTIY+W1NOfFZf3+XCWUugggurZ4Vx9tTYKC72ngrQ9/fIMPp/weksYeeKOW16EO
 IB38TUnD2dJAw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1uuY49-0000000HEUv-35rs; Fri, 05 Sep 2025 17:09:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>
Subject: [PATCH v11 05/17] acpi/ghes: Use HEST table offsets when preparing
 GHES records
Date: Fri,  5 Sep 2025 17:09:12 +0200
Message-ID: <b7a0142b4363972c57852046ea5d351fef2c0389.1757084668.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757084668.git.mchehab+huawei@kernel.org>
References: <cover.1757084668.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There are two pointers that are needed during error injection:

1. The start address of the CPER block to be stored;
2. The address of the read ack.

It is preferable to calculate them from the HEST table.  This allows
checking the source ID, the size of the table and the type of the
HEST error block structures.

Yet, keep the old code, as this is needed for migration purposes
from older QEMU versions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c         | 100 +++++++++++++++++++++++++++++++++++++++++
 include/hw/acpi/ghes.h |   2 +-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index cbc96c1909f0..668ca72587c7 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -41,6 +41,12 @@
 /* Address offset in Generic Address Structure(GAS) */
 #define GAS_ADDR_OFFSET 4
 
+/*
+ * ACPI spec 1.0b
+ * 5.2.3 System Description Table Header
+ */
+#define ACPI_DESC_HEADER_OFFSET     36
+
 /*
  * The total size of Generic Error Data Entry
  * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
@@ -61,6 +67,30 @@
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
+/*
+ * See the memory layout map at docs/specs/acpi_hest_ghes.rst.
+ */
+
+/*
+ * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
+ * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
+ */
+#define HEST_GHES_V2_ENTRY_SIZE  92
+
+/*
+ * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
+ * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
+ * Read Ack Register
+ */
+#define GHES_READ_ACK_ADDR_OFF          64
+
+/*
+ * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
+ * Table 18-341 Generic Hardware Error Source Structure
+ * Error Status Address
+ */
+#define GHES_ERR_STATUS_ADDR_OFF  20
+
 /*
  * Values for error_severity field
  */
@@ -408,6 +438,73 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
+static void get_ghes_source_offsets(uint16_t source_id,
+                                    uint64_t hest_addr,
+                                    uint64_t *cper_addr,
+                                    uint64_t *read_ack_start_addr,
+                                    Error **errp)
+{
+    uint64_t hest_err_block_addr, hest_read_ack_addr;
+    uint64_t err_source_entry, error_block_addr;
+    uint32_t num_sources, i;
+
+    hest_addr += ACPI_DESC_HEADER_OFFSET;
+
+    cpu_physical_memory_read(hest_addr, &num_sources,
+                             sizeof(num_sources));
+    num_sources = le32_to_cpu(num_sources);
+
+    err_source_entry = hest_addr + sizeof(num_sources);
+
+    /*
+     * Currently, HEST Error source navigates only for GHESv2 tables
+     */
+    for (i = 0; i < num_sources; i++) {
+        uint64_t addr = err_source_entry;
+        uint16_t type, src_id;
+
+        cpu_physical_memory_read(addr, &type, sizeof(type));
+        type = le16_to_cpu(type);
+
+        /* For now, we only know the size of GHESv2 table */
+        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
+            error_setg(errp, "HEST: type %d not supported.", type);
+            return;
+        }
+
+        /* Compare CPER source ID at the GHESv2 structure */
+        addr += sizeof(type);
+        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
+        if (le16_to_cpu(src_id) == source_id) {
+            break;
+        }
+
+        err_source_entry += HEST_GHES_V2_ENTRY_SIZE;
+    }
+    if (i == num_sources) {
+        error_setg(errp, "HEST: Source %d not found.", source_id);
+        return;
+    }
+
+    /* Navigate through table address pointers */
+    hest_err_block_addr = err_source_entry + GHES_ERR_STATUS_ADDR_OFF +
+                          GAS_ADDR_OFFSET;
+
+    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+    error_block_addr = le64_to_cpu(error_block_addr);
+
+    cpu_physical_memory_read(error_block_addr, cper_addr,
+                             sizeof(*cper_addr));
+    *cper_addr = le64_to_cpu(*cper_addr);
+
+    hest_read_ack_addr = err_source_entry + GHES_READ_ACK_ADDR_OFF +
+                         GAS_ADDR_OFFSET;
+    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
+                             sizeof(*read_ack_start_addr));
+    *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
+}
+
 void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -423,6 +520,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     if (!ags->use_hest_addr) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
+    } else {
+        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
+                                &cper_addr, &read_ack_register_addr, errp);
     }
 
     cpu_physical_memory_read(read_ack_register_addr,
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index ea9baab764e2..5265102ba51f 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -78,7 +78,7 @@ enum {
 typedef struct AcpiGhesState {
     uint64_t hest_addr_le;
     uint64_t hw_error_le;
-    bool use_hest_addr;         /* Currently, always false */
+    bool use_hest_addr; /* True if HEST address is present */
 } AcpiGhesState;
 
 void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
-- 
2.51.0


