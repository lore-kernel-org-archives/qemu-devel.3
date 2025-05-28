Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7732C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDcD-0007tx-6I; Wed, 28 May 2025 06:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uKDar-0007XX-HV
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uKDam-0006Qp-Om
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOYI234zQluV45qVUegyctokG5CzG9B7KkBc7+iRx6A=;
 b=EWdDmiocyVJd0hPu3CRZZgaFVq3x5eKhNRjpgn/mGJdYl9OqQh1lRnyiZE3uEVWPAex0vU
 +Q+AffdWRoPrVha8d2PNV1rODWiaUNRyxpYQbbfRBPNEgP9Bxz5vOIWpKXVHs8PmfFjFKL
 7d6oos+cggrCwoK5dppG0P6iKvH0mrs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-4eTQVShDN5yr4EAlhaGBVw-1; Wed,
 28 May 2025 06:00:56 -0400
X-MC-Unique: 4eTQVShDN5yr4EAlhaGBVw-1
X-Mimecast-MFC-AGG-ID: 4eTQVShDN5yr4EAlhaGBVw_1748426455
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2D2D1800570; Wed, 28 May 2025 10:00:54 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEB8819560B0; Wed, 28 May 2025 10:00:49 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 mchehab+huawei@kernel.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 1/3] acpi/ghes: Extend acpi_ghes_memory_errors() to support
 multiple CPERs
Date: Wed, 28 May 2025 20:00:31 +1000
Message-ID: <20250528100033.159576-2-gshan@redhat.com>
In-Reply-To: <20250528100033.159576-1-gshan@redhat.com>
References: <20250528100033.159576-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the situation where host and guest has 64KB and 4KB page sizes, one
error on the host's page affects 16 guest's pages. we need to send 16
consective errors in this specific case.

Extend acpi_ghes_memory_errors() to support multiple CPERs after the
hunk of code to generate the GHES error status is pulled out from
ghes_gen_err_data_uncorrectable_recoverable().

No functional changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes-stub.c    |  2 +-
 hw/acpi/ghes.c         | 27 ++++++++++++++-------------
 include/hw/acpi/ghes.h |  2 +-
 target/arm/kvm.c       |  7 ++++++-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 40f660c246..c1f8c9bec9 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -12,7 +12,7 @@
 #include "hw/acpi/ghes.h"
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+                            GArray *addresses)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 1d02ef6dcb..34ff682048 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -214,18 +214,13 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
 
 static void
 ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
-                                            const uint8_t *section_type,
-                                            int data_length)
+                                            const uint8_t *section_type)
 {
     /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
      * Table 17-13 Generic Error Data Entry
      */
     QemuUUID fru_id = {};
 
-    /* Build the new generic error status block header */
-    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
-        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
-
     /* Build this new generic error data entry header */
     acpi_ghes_generic_error_data(block, section_type,
         ACPI_CPER_SEV_RECOVERABLE, 0, 0,
@@ -557,19 +552,20 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
 }
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+                            GArray *addresses)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
     Error *errp = NULL;
-    int data_length;
+    int data_length, i;
     GArray *block;
 
     block = g_array_new(false, true /* clear */, 1);
 
-    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
+    data_length = addresses->len *
+                  (ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH);
     /*
      * It should not run out of the preallocated memory if adding a new generic
      * error data entry
@@ -577,10 +573,15 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     assert((data_length + ACPI_GHES_GESB_SIZE) <=
             ACPI_GHES_MAX_RAW_DATA_LENGTH);
 
-    ghes_gen_err_data_uncorrectable_recoverable(block, guid, data_length);
-
-    /* Build the memory section CPER for above new generic error data entry */
-    acpi_ghes_build_append_mem_cper(block, physical_address);
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE, 0, 0,
+                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
+    for (i = 0; i < addresses->len; i++) {
+        ghes_gen_err_data_uncorrectable_recoverable(block, guid);
+        /* Memory section CPER on top of the generic error data entry */
+        acpi_ghes_build_append_mem_cper(block,
+                                        g_array_index(addresses, uint64_t, i));
+    }
 
     /* Report the error */
     ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index df2ecbf6e4..a8cbc520d5 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -99,7 +99,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t error_physical_addr);
+                            GArray *addresses);
 void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a1492bcaeb..97c1bce692 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2338,6 +2338,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     ram_addr_t ram_addr;
     hwaddr paddr;
     AcpiGhesState *ags;
+    GArray *addresses;
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2346,6 +2347,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            addresses = g_array_new(false, false, sizeof(paddr));
             kvm_hwpoison_page_add(ram_addr);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
@@ -2358,16 +2360,19 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              * later from the main thread, so doing the injection of
              * the error would be more complicated.
              */
+            g_array_append_vals(addresses, &paddr, 1);
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
                 if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                             paddr)) {
+                                             addresses)) {
                     kvm_inject_arm_sea(c);
                 } else {
                     error_report("failed to record the error");
                     abort();
                 }
             }
+
+            g_array_free(addresses, true);
             return;
         }
         if (code == BUS_MCEERR_AO) {
-- 
2.49.0


