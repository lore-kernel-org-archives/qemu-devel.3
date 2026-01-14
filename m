Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EBBD38FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg513-0001oe-8v; Wed, 14 Jan 2026 12:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg510-0001oR-VE
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg50z-0008VQ-Ba
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768413040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdTCBkoADw6wT+61kjN+PmuT37K+aJSkJUAlrrepYtE=;
 b=MarnSlB3A+704i++ZHiV/6v8TGxSJ7ZYC+YdFNZkDmm9jx3NYWV1gZItj6fTztnOg+r4Xp
 lcAbHyvKl3yYjJKEHOsYRjF0fgFMgPczvSdvA8fHM3PI6VrPSJj6W9ILRuXoagdvypURDC
 NMSBSad2g8ReInkLuPP3U30IFo7+pcI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-3FN-1HY1PDORB1V75az_Qw-1; Wed,
 14 Jan 2026 12:50:37 -0500
X-MC-Unique: 3FN-1HY1PDORB1V75az_Qw-1
X-Mimecast-MFC-AGG-ID: 3FN-1HY1PDORB1V75az_Qw_1768413035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8457819560B2; Wed, 14 Jan 2026 17:50:35 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.224.90])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1FEB180009E; Wed, 14 Jan 2026 17:50:28 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v4 3/5] igvm: Add common function for finding parameter entries
Date: Wed, 14 Jan 2026 18:50:05 +0100
Message-ID: <20260114175007.90845-4-osteffen@redhat.com>
In-Reply-To: <20260114175007.90845-1-osteffen@redhat.com>
References: <20260114175007.90845-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
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

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm.c | 117 +++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 56 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index a350c890cc..ccb2f51cd9 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -95,6 +95,19 @@ typedef struct QIgvm {
     unsigned region_page_count;
 } QIgvm;
 
+static QIgvmParameterData*
+qigvm_find_param_entry(QIgvm *igvm, const IGVM_VHS_PARAMETER *param)
+{
+    QIgvmParameterData *param_entry;
+    QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            return param_entry;
+        }
+    }
+    return NULL;
+}
+
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
 static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
@@ -569,58 +582,53 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
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
+    param_entry = qigvm_find_param_entry(ctx, param);
+    if (param_entry == NULL) {
+        return 0;
+    }
+
+    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
 
+    retval = get_mem_map_entry(entry, &cgmm_entry, errp);
+    while (retval == 0) {
+        if (entry >= max_entry_count) {
+            error_setg(
+                errp,
+                "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
+            return -1;
+        }
+        mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
+        mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
+
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
     }
+    if (retval < 0) {
+        return retval;
+    }
+    /* The entries need to be sorted */
+    qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
+          qigvm_cmp_mm_entry);
     return 0;
 }
 
@@ -655,14 +663,11 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
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
+    param_entry = qigvm_find_param_entry(ctx, param);
+    if (param_entry != NULL) {
+        environmental_state =
+            (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
+        environmental_state->memory_is_shared = 1;
     }
     return 0;
 }
-- 
2.52.0


