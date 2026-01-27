Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E44D2D8DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 10:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfv2-0004OA-Rn; Tue, 27 Jan 2026 05:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vkfv1-0004KY-Jg
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vkfv0-0005Cm-0D
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 05:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769508209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJK70mYmfTu4Vb3wBxCU3kc4SeIhw8zwF2RBpz/uZU4=;
 b=OboVeXo6I/ZsablNJAfqRYOljgz2k3fcL+HGUB4edYkQSHqvHnPiZMa4b9T2ErIw10d04n
 Xm1iIVqd8rAm1L6fsZpCq/Xi4K3G+o1eRWeu1/2rM+hcIRXfxDGxRePmHS6g2KbA4IZ9BJ
 LS4i1aUhLzxrN1cDB/NKzcPCVOofTjQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-nRC6KdMoNiGhaHGupXgGog-1; Tue,
 27 Jan 2026 05:03:24 -0500
X-MC-Unique: nRC6KdMoNiGhaHGupXgGog-1
X-Mimecast-MFC-AGG-ID: nRC6KdMoNiGhaHGupXgGog_1769508203
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84EFD19775DE; Tue, 27 Jan 2026 10:03:23 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown
 [10.44.34.174])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCDAD180066A; Tue, 27 Jan 2026 10:03:17 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v5 3/6] igvm: Add common function for finding parameter entries
Date: Tue, 27 Jan 2026 11:02:54 +0100
Message-ID: <20260127100257.1074104-4-osteffen@redhat.com>
In-Reply-To: <20260127100257.1074104-1-osteffen@redhat.com>
References: <20260127100257.1074104-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
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

Move repeating code for finding the parameter entries in the IGVM
backend out of the parameter handlers into a common function.

A warning message is emitted in case a no parameter entry can be found
for a given index.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm.c | 143 ++++++++++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 66 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 4cf7b57234..213c9d337e 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/target-info-qapi.h"
 #include "system/igvm.h"
 #include "system/igvm-cfg.h"
@@ -97,6 +98,20 @@ typedef struct QIgvm {
     unsigned region_page_count;
 } QIgvm;
 
+static QIgvmParameterData*
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
@@ -571,58 +586,54 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
-    {
-        if (param_entry->index == param->parameter_area_index) {
-            max_entry_count =
-                param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
-            mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
-
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
-
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
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
+
+    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+
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
 
@@ -634,18 +645,18 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
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
 
@@ -657,15 +668,15 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
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


