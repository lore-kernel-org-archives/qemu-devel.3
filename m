Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BD9D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ4kQ-0008TO-5w; Mon, 01 Dec 2025 09:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4kF-0008QD-3y
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:19:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4kC-0008Lb-G4
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764598751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdTV+74vIxizRlieA9uyr9rY8BeSNKGquMiPkVB06BQ=;
 b=Hz3V1LRRSoGV5QP+m6G83hR1M28cc3VaGPRdyAFLJqqjw9Jm5PqgoVaFL4ghDKd4yoDmgW
 aWlo3SM9LccaHmNJ0xsbwbq/yaDiuk7xQPZDL9u/yAbSmYq+3ni0zwE5mijZEEvie6Hu91
 fwn0XfwCQEOUmvLEtX5PaW6xK3cYWmo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-dTUAxy84PwCmE3ZKlr86zw-1; Mon,
 01 Dec 2025 09:19:10 -0500
X-MC-Unique: dTUAxy84PwCmE3ZKlr86zw-1
X-Mimecast-MFC-AGG-ID: dTUAxy84PwCmE3ZKlr86zw_1764598747
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C59518002CD; Mon,  1 Dec 2025 14:19:07 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74B59195608E; Mon,  1 Dec 2025 14:18:59 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, imammedo@redhat.com, armbru@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 5/5] acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
Date: Tue,  2 Dec 2025 00:18:03 +1000
Message-ID: <20251201141803.2386129-6-gshan@redhat.com>
In-Reply-To: <20251201141803.2386129-1-gshan@redhat.com>
References: <20251201141803.2386129-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use error_fatal in acpi_ghes_memory_errors() so that the caller needn't
explicitly call exit(). The return value of acpi_ghes_memory_errors()
and ghes_record_cper_errors() is changed to 'bool' indicating an error
has been raised, to be compatible with what's documented in error.h.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes-stub.c    |  4 ++--
 hw/acpi/ghes.c         | 26 ++++++++++----------------
 include/hw/acpi/ghes.h |  6 +++---
 target/arm/kvm.c       |  9 +++------
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index b54f1b093c..5f9313cce9 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,8 +11,8 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                             uint64_t physical_address, Error **errp)
 {
     g_assert_not_reached();
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index c35883dfa9..3033e93d65 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -515,14 +515,14 @@ static bool get_ghes_source_offsets(uint16_t source_id,
 NotifierList acpi_generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(acpi_generic_error_notifiers);
 
-void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
+bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
 
     if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
         error_setg(errp, "GHES CPER record is too big: %zd", len);
-        return;
+        return false;
     }
 
     if (!ags->use_hest_addr) {
@@ -531,7 +531,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     } else if (!get_ghes_source_offsets(source_id,
                     le64_to_cpu(ags->hest_addr_le),
                     &cper_addr, &read_ack_register_addr, errp)) {
-            return;
+            return false;
     }
 
     cpu_physical_memory_read(read_ack_register_addr,
@@ -542,7 +542,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
         error_setg(errp,
                    "OSPM does not acknowledge previous error,"
                    " so can not record CPER for current error anymore");
-        return;
+        return false;
     }
 
     read_ack_register = cpu_to_le64(0);
@@ -557,16 +557,17 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     cpu_physical_memory_write(cper_addr, cper, len);
 
     notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
+
+    return true;
 }
 
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t physical_address)
+bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                             uint64_t physical_address, Error **errp)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
-    Error *errp = NULL;
     int data_length;
     g_autoptr(GArray) block = g_array_new(false, true /* clear */, 1);
 
@@ -583,15 +584,8 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     /* Build the memory section CPER for above new generic error data entry */
     acpi_ghes_build_append_mem_cper(block, physical_address);
 
-    /* Report the error */
-    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
-
-    if (errp) {
-        error_report_err(errp);
-        return -1;
-    }
-
-    return 0;
+    return ghes_record_cper_errors(ags, block->data, block->len,
+                                   source_id, errp);
 }
 
 AcpiGhesState *acpi_ghes_get_state(void)
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index df2ecbf6e4..5b29aae4dd 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -98,9 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t error_physical_addr);
-void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
+bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                            uint64_t error_physical_addr, Error **errp);
+bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
 /**
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index acda0b3fb4..76aa09810f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2456,12 +2456,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                             paddr)) {
-                    kvm_inject_arm_sea(c);
-                } else {
-                    exit(1);
-                }
+                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
+                                        paddr, &error_fatal);
+                kvm_inject_arm_sea(c);
             }
             return;
         }
-- 
2.51.1


