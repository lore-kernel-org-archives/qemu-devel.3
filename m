Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42DFE7FDD6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnF8p-0008DB-4k; Tue, 03 Feb 2026 07:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8d-0007th-JD
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8a-0007gI-FJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770120247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrSw04nlkdlYcIirhB7fqJ0J28GwLGgUnBPN7bI9HoA=;
 b=LyagRKoQ5gc4ghqMq5iAFjWm2VA2EhdMMN2a73TBWFk/AhZ6cKqxaJcrs6Nm+9iTYHMKso
 +e9YR83g1ohFyBp3fVGdAYv5giF87rwzp78TskFf4Q0l1Zvo+ghuT4t9cdjeS243ewx+9X
 rsDKcfdGnTRW4cfZ4EbqyS7KQFidGaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-TnnP8uwxMCWj0pkguosPBA-1; Tue,
 03 Feb 2026 07:04:04 -0500
X-MC-Unique: TnnP8uwxMCWj0pkguosPBA-1
X-Mimecast-MFC-AGG-ID: TnnP8uwxMCWj0pkguosPBA_1770120243
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F48F18002C4; Tue,  3 Feb 2026 12:04:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BEB51956053; Tue,  3 Feb 2026 12:04:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6EDD31826267; Tue, 03 Feb 2026 13:03:44 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 13/17] igvm: Add common function for finding parameter entries
Date: Tue,  3 Feb 2026 13:03:38 +0100
Message-ID: <20260203120343.656961-14-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Oliver Steffen <osteffen@redhat.com>

Move repeating code for finding the parameter entries in the IGVM
backend out of the parameter handlers into a common function.

A warning message is emitted in case a no parameter entry can be found
for a given index.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Oliver Steffen <osteffen@redhat.com>
Message-ID: <20260130054714.715928-6-osteffen@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |   3 +
 backends/igvm.c                | 139 ++++++++++++++++++---------------
 2 files changed, 78 insertions(+), 64 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9c8e887d6f60..019f95e86615 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -70,4 +70,7 @@ typedef struct QIgvm {
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
+QIgvmParameterData*
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
+
 #endif
diff --git a/backends/igvm.c b/backends/igvm.c
index 3a3832dc2dde..ea3f9d6b008f 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/target-info-qapi.h"
 #include "system/igvm.h"
 #include "system/igvm-cfg.h"
@@ -60,6 +61,20 @@ struct QEMU_PACKED sev_id_authentication {
 
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
+QIgvmParameterData*
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
+{
+    QIgvmParameterData *param_entry;
+    QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
+    {
+        if (param_entry->index == parameter_area_index) {
+            return param_entry;
+        }
+    }
+    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
+    return NULL;
+}
+
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
 static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
@@ -534,58 +549,54 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
-    {
-        if (param_entry->index == param->parameter_area_index) {
-            max_entry_count =
-                param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
-            mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
 
-            retval = get_mem_map_entry(entry, &cgmm_entry, errp);
-            while (retval == 0) {
-                if (entry >= max_entry_count) {
-                    error_setg(
-                        errp,
-                        "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
-                    return -1;
-                }
-                mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
-                mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
+    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
 
-                switch (cgmm_entry.type) {
-                case CGS_MEM_RAM:
-                    mm_entry[entry].entry_type =
-                        IGVM_MEMORY_MAP_ENTRY_TYPE_MEMORY;
-                    break;
-                case CGS_MEM_RESERVED:
-                    mm_entry[entry].entry_type =
-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
-                    break;
-                case CGS_MEM_ACPI:
-                    mm_entry[entry].entry_type =
-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
-                    break;
-                case CGS_MEM_NVS:
-                    mm_entry[entry].entry_type =
-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PERSISTENT;
-                    break;
-                case CGS_MEM_UNUSABLE:
-                    mm_entry[entry].entry_type =
-                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
-                    break;
-                }
-                retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
-            }
-            if (retval < 0) {
-                return retval;
-            }
-            /* The entries need to be sorted */
-            qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
-                  qigvm_cmp_mm_entry);
+    retval = get_mem_map_entry(entry, &cgmm_entry, errp);
+    while (retval == 0) {
+        if (entry >= max_entry_count) {
+            error_setg(
+                errp,
+                "IGVM: guest memory map size exceeds parameter area defined "
+                "in IGVM file");
+            return -1;
+        }
+        mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
+        mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
 
+        switch (cgmm_entry.type) {
+        case CGS_MEM_RAM:
+            mm_entry[entry].entry_type = IGVM_MEMORY_MAP_ENTRY_TYPE_MEMORY;
+            break;
+        case CGS_MEM_RESERVED:
+            mm_entry[entry].entry_type =
+                IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+            break;
+        case CGS_MEM_ACPI:
+            mm_entry[entry].entry_type =
+                IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+            break;
+        case CGS_MEM_NVS:
+            mm_entry[entry].entry_type = IGVM_MEMORY_MAP_ENTRY_TYPE_PERSISTENT;
+            break;
+        case CGS_MEM_UNUSABLE:
+            mm_entry[entry].entry_type =
+                IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
             break;
         }
+        retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
+    }
+    if (retval < 0) {
+        return retval;
     }
+    /* The entries need to be sorted */
+    qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
+          qigvm_cmp_mm_entry);
     return 0;
 }
 
@@ -597,18 +608,18 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
     uint32_t *vp_count;
     CPUState *cpu;
 
-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
+
+    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
+    *vp_count = 0;
+    CPU_FOREACH(cpu)
     {
-        if (param_entry->index == param->parameter_area_index) {
-            vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
-            *vp_count = 0;
-            CPU_FOREACH(cpu)
-            {
-                (*vp_count)++;
-            }
-            break;
-        }
+        (*vp_count)++;
     }
+
     return 0;
 }
 
@@ -620,15 +631,15 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
     QIgvmParameterData *param_entry;
     IgvmEnvironmentInfo *environmental_state;
 
-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
-    {
-        if (param_entry->index == param->parameter_area_index) {
-            environmental_state =
-                (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
-            environmental_state->memory_is_shared = 1;
-            break;
-        }
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
     }
+
+    environmental_state =
+        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
+    environmental_state->memory_is_shared = 1;
+
     return 0;
 }
 
-- 
2.52.0


