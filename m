Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6A0CCFA19
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbyo-0006AM-1K; Wed, 05 Nov 2025 06:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyG-0005kw-8b
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyE-000332-47
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQPNfR7Z4o5b8yAIQSrssT0KUFwVLUHnqa1jRtT1UKQ=;
 b=FJTnqshC3VNZM42DpFvCSJgS6KC7i0Hp0do1u3QPYksoalPrLEurMMHgO55/wPrcGF5gCa
 ECpIGKphEA5LlViT1qSk1s+QYBTuw6G8WlaaVEFLKoOEfoee1b8ZBzRHsNZWO2YTZCWg9B
 CqSn6SAQfGyttUwXwjnGTH2Xs3SUV2E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-eftmmyP2MVSDDMjpvt79Bg-1; Wed,
 05 Nov 2025 06:46:28 -0500
X-MC-Unique: eftmmyP2MVSDDMjpvt79Bg-1
X-Mimecast-MFC-AGG-ID: eftmmyP2MVSDDMjpvt79Bg_1762343187
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2626195608F; Wed,  5 Nov 2025 11:46:26 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44E731800451; Wed,  5 Nov 2025 11:46:18 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to support
 multiple CPERs
Date: Wed,  5 Nov 2025 21:44:49 +1000
Message-ID: <20251105114453.2164073-5-gshan@redhat.com>
In-Reply-To: <20251105114453.2164073-1-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the situation where host and guest has 64KiB and 4KiB page sizes,
one problematic host page affects 16 guest pages. we need to send 16
consective errors in this specific case.

Extend acpi_ghes_memory_errors() to support multiple CPERs after the
hunk of code to generate the GHES error status is pulled out from
ghes_gen_err_data_uncorrectable_recoverable(). The status field of
generic error status block is also updated accordingly if multiple
error data entries are contained in the generic error status block.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes-stub.c    |  2 +-
 hw/acpi/ghes.c         | 60 +++++++++++++++++++++++-------------------
 include/hw/acpi/ghes.h |  2 +-
 target/arm/kvm.c       |  4 ++-
 4 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 40f660c246..4faf573aeb 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -12,7 +12,7 @@
 #include "hw/acpi/ghes.h"
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+                            uint64_t *addresses, uint32_t num_of_addresses)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a9c08e73c0..527b85c8d8 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -57,8 +57,12 @@
 /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
 #define ACPI_GHES_MEM_CPER_LENGTH           80
 
-/* Masks for block_status flags */
-#define ACPI_GEBS_UNCORRECTABLE         1
+/* Bits for block_status flags */
+#define ACPI_GEBS_UNCORRECTABLE           0
+#define ACPI_GEBS_CORRECTABLE             1
+#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE  2
+#define ACPI_GEBS_MULTIPLE_CORRECTABLE    3
+#define ACPI_GEBS_ERROR_DATA_ENTRIES      4
 
 /*
  * Total size for Generic Error Status Block except Generic Error Data Entries
@@ -212,26 +216,6 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
     build_append_int_noprefix(table, 0, 7);
 }
 
-static void
-ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
-                                            const uint8_t *section_type,
-                                            int data_length)
-{
-    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
-     * Table 17-13 Generic Error Data Entry
-     */
-    QemuUUID fru_id = {};
-
-    /* Build the new generic error status block header */
-    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
-        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
-
-    /* Build this new generic error data entry header */
-    acpi_ghes_generic_error_data(block, section_type,
-        ACPI_CPER_SEV_RECOVERABLE, 0, 0,
-        ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
-}
-
 /*
  * Build table for the hardware error fw_cfg blob.
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
@@ -557,19 +541,26 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
 }
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+                            uint64_t *addresses, uint32_t num_of_addresses)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
+    /*
+     * invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
+     * Table 17-13 Generic Error Data Entry
+     */
+    QemuUUID fru_id = {};
     Error *errp = NULL;
     int data_length;
     GArray *block;
+    uint32_t block_status, i;
 
     block = g_array_new(false, true /* clear */, 1);
 
-    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
+    data_length = num_of_addresses *
+                  (ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH);
     /*
      * It should not run out of the preallocated memory if adding a new generic
      * error data entry
@@ -577,10 +568,25 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     assert((data_length + ACPI_GHES_GESB_SIZE) <=
             ACPI_GHES_MAX_RAW_DATA_LENGTH);
 
-    ghes_gen_err_data_uncorrectable_recoverable(block, guid, data_length);
+    /* Build the new generic error status block header */
+    block_status = (1 << ACPI_GEBS_UNCORRECTABLE) |
+                   (num_of_addresses << ACPI_GEBS_ERROR_DATA_ENTRIES);
+    if (num_of_addresses > 1) {
+        block_status |= ACPI_GEBS_MULTIPLE_UNCORRECTABLE;
+    }
+
+    acpi_ghes_generic_error_status(block, block_status, 0, 0,
+                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
 
-    /* Build the memory section CPER for above new generic error data entry */
-    acpi_ghes_build_append_mem_cper(block, physical_address);
+    for (i = 0; i < num_of_addresses; i++) {
+        /* Build generic error data entries */
+        acpi_ghes_generic_error_data(block, guid,
+                                     ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                     ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
+
+        /* Memory section CPER on top of the generic error data entry */
+        acpi_ghes_build_append_mem_cper(block, addresses[i]);
+    }
 
     /* Report the error */
     ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index df2ecbf6e4..f73908985d 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -99,7 +99,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t error_physical_addr);
+                            uint64_t *addresses, uint32_t num_of_addresses);
 void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69..459ca4a9b0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2434,6 +2434,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     ram_addr_t ram_addr;
     hwaddr paddr;
     AcpiGhesState *ags;
+    uint64_t addresses[16];
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2454,10 +2455,11 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              * later from the main thread, so doing the injection of
              * the error would be more complicated.
              */
+            addresses[0] = paddr;
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
                 if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                             paddr)) {
+                                             addresses, 1)) {
                     kvm_inject_arm_sea(c);
                 } else {
                     error_report("failed to record the error");
-- 
2.51.0


