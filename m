Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304ABCD342E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 17:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJEc6-0003mz-4W; Wed, 12 Nov 2025 12:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEbv-0003fg-OX
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEbt-0008S4-Un
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762968381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmdcTshu+EcHkzgTKmN9yyxbdB55kwI4YPUhWNkQ42M=;
 b=P7Es9tfLUBsf/QfeChvQog92IwfHnB8fwJOKX1h+5JWR0gHGan1s4fk9pDe6fFLljJYf4q
 POGe9rHmb61zhRTGoI0tPk9/Pn+KnS5+kL796kqu9KrMRftdOw/rHtsn1N9NNRtErfNZY5
 NJUxApwyc5b8hRVuR1blgxPqGLE/Hf0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-GCaXJryzNHq0its3_tW_jw-1; Wed,
 12 Nov 2025 12:26:15 -0500
X-MC-Unique: GCaXJryzNHq0its3_tW_jw-1
X-Mimecast-MFC-AGG-ID: GCaXJryzNHq0its3_tW_jw_1762968373
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECC0619560B2; Wed, 12 Nov 2025 17:26:12 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2849D1955F1A; Wed, 12 Nov 2025 17:26:04 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, armbru@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v4 1/8] acpi/ghes: Make GHES max raw data length dynamic
Date: Thu, 13 Nov 2025 03:25:28 +1000
Message-ID: <20251112172535.403042-2-gshan@redhat.com>
In-Reply-To: <20251112172535.403042-1-gshan@redhat.com>
References: <20251112172535.403042-1-gshan@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Make GHES max raw data length dynamic, preparing for the increased
length from 1KiB to 4KiB because we need to send 16 consective
errors in case a problematic 64KiB host page affects 16 4KiB guest
pages.

GHES max raw data length remains 1KiB as before until a compat
property is added to customize it in the subsequent patch.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes.c         | 30 +++++++++++++++++++-----------
 include/hw/acpi/ghes.h |  1 +
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 06555905ce..06f75df43d 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -32,9 +32,6 @@
 #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
 #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
 
-/* The max size in bytes for one error block */
-#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
-
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
 
@@ -232,6 +229,15 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
         ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
 }
 
+static inline uint32_t ghes_max_raw_data_length(AcpiGhesState *ags)
+{
+    if (ags->error_block_size == 0) {
+        return 1 * KiB;
+    } else {
+        return ags->error_block_size;
+    }
+}
+
 /*
  * Build table for the hardware error fw_cfg blob.
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
@@ -263,7 +269,7 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
 
     /* Reserve space for Error Status Data Block */
     acpi_data_push(hardware_errors,
-        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
+        ghes_max_raw_data_length(ags) * num_sources);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
     bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
@@ -280,7 +286,7 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
                                        sizeof(uint64_t),
                                        ACPI_HW_ERROR_FW_CFG_FILE,
                                        error_status_block_offset +
-                                       i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
+                                       i * ghes_max_raw_data_length(ags));
     }
 
     if (!ags->use_hest_addr) {
@@ -295,7 +301,8 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2_entry(GArray *table_data,
+static void build_ghes_v2_entry(AcpiGhesState *ags,
+                                GArray *table_data,
                                 BIOSLinker *linker,
                                 const AcpiNotificationSourceId *notif_src,
                                 uint16_t index, int num_sources)
@@ -323,7 +330,7 @@ static void build_ghes_v2_entry(GArray *table_data,
     /* Max Sections Per Record */
     build_append_int_noprefix(table_data, 1, 4);
     /* Max Raw Data Length */
-    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
+    build_append_int_noprefix(table_data, ghes_max_raw_data_length(ags), 4);
 
     address_offset = table_data->len;
     /* Error Status Address */
@@ -339,7 +346,7 @@ static void build_ghes_v2_entry(GArray *table_data,
     build_ghes_hw_error_notification(table_data, notify);
 
     /* Error Status Block Length */
-    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
+    build_append_int_noprefix(table_data, ghes_max_raw_data_length(ags), 4);
 
     /*
      * Read Ack Register
@@ -387,7 +394,8 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
     /* Error Source Count */
     build_append_int_noprefix(table_data, num_sources, 4);
     for (i = 0; i < num_sources; i++) {
-        build_ghes_v2_entry(table_data, linker, &notif_source[i], i, num_sources);
+        build_ghes_v2_entry(ags, table_data, linker,
+                            &notif_source[i], i, num_sources);
     }
 
     acpi_table_end(linker, &table);
@@ -518,7 +526,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
 
-    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+    if (len > ghes_max_raw_data_length(ags)) {
         error_setg(errp, "GHES CPER record is too big: %zd", len);
         return;
     }
@@ -575,7 +583,7 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
      * error data entry
      */
     assert((data_length + ACPI_GHES_GESB_SIZE) <=
-            ACPI_GHES_MAX_RAW_DATA_LENGTH);
+           ghes_max_raw_data_length(ags));
 
     ghes_gen_err_data_uncorrectable_recoverable(block, guid, data_length);
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index df2ecbf6e4..c98bd6d1e2 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -88,6 +88,7 @@ typedef struct AcpiGhesState {
     uint64_t hest_addr_le;
     uint64_t hw_error_le;
     bool use_hest_addr; /* True if HEST address is present */
+    uint32_t error_block_size;
 } AcpiGhesState;
 
 void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
-- 
2.51.1


