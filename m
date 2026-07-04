Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AECCC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 04:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfsNd-000336-Mx; Sat, 04 Jul 2026 00:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfsNc-00032c-H0
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 00:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfsNZ-0007ha-MR
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 00:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783140803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CNVx6liB/UNUdd/yZShSDPiIsbIMeABUGo+654/gsY=;
 b=M3T8dC77u+X3kHjIlti59B+DsOVg/7IiJlIl7gi4+RPTFgXqN63AkX3Aui/nZi/wzOrp64
 z+/ReyLCmnd60Nj0iUCN1/buAoTWF/fDMUCvM/iKkhOtsBf5Au/8CD6VGzWAEDWGaYM21o
 j3quut7s25/ZxWJT/6WfKqK0sqwvR/0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-YQCojCXXMOSKoouvgPSRnQ-1; Sat,
 04 Jul 2026 00:53:20 -0400
X-MC-Unique: YQCojCXXMOSKoouvgPSRnQ-1
X-Mimecast-MFC-AGG-ID: YQCojCXXMOSKoouvgPSRnQ_1783140799
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C165619560BA; Sat,  4 Jul 2026 04:53:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C836930030E3; Sat,  4 Jul 2026 04:53:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 67F7D1800618; Sat, 04 Jul 2026 06:53:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 1/3] igvm: Report error on missing parameter area in directive
 handlers
Date: Sat,  4 Jul 2026 06:53:14 +0200
Message-ID: <20260704045316.1624628-2-kraxel@redhat.com>
In-Reply-To: <20260704045316.1624628-1-kraxel@redhat.com>
References: <20260704045316.1624628-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Luigi Leonardi <leonardi@redhat.com>

Parameter areas are how an IGVM file tells QEMU to allocate buffers
for runtime information the guest needs — VP count, memory map,
MADT and so on. Usage directives reference a parameter area by index
to tell QEMU where to write each piece of data. If the index doesn't
match any declared parameter area, the data has nowhere to go and
should be treated as an error.

The directive handlers that look up a parameter area all return 0
(success) when `qigvm_find_param_entry()` can't find it. Therefore,
the load succeeds but the guest never gets the expected parameters.

Note that the IGVM library already validates parameter area indices
when the file is loaded, so this path should only be reachable with
a malformed file that bypassed library validation. This is defensive
programming against that case.

Report the error with error_setg() and return -1 instead.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20260626-microvm_device_tree-v6-1-9cd13cf057e2@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h |  3 ++-
 backends/igvm.c                | 26 ++++++++++++++++----------
 target/i386/igvm.c             |  5 +++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 7f131c4d0392..7eb3792ed8c5 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -72,6 +72,7 @@ struct QIgvm {
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp);
 
 #endif
diff --git a/backends/igvm.c b/backends/igvm.c
index 3f4b97a5d417..a5a2a4eccc19 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -81,7 +81,8 @@ struct QEMU_PACKED sev_id_authentication {
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp)
 {
     QIgvmParameterData *param_entry;
     QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
@@ -90,7 +91,8 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
             return param_entry;
         }
     }
-    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
+    error_setg(errp, "IGVM: parameter area index %u not found",
+                   parameter_area_index);
     return NULL;
 }
 
@@ -528,9 +530,10 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
         return 0;
     }
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
@@ -601,9 +604,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
@@ -660,9 +664,10 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
     uint32_t *vp_count;
     CPUState *cpu;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
@@ -683,9 +688,10 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
     QIgvmParameterData *param_entry;
     IgvmEnvironmentInfo *environmental_state;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     environmental_state =
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index f41b498b8924..ad9bf87761fb 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -191,9 +191,10 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
     int result = 0;
 
     /* Find the parameter area that should hold the MADT data */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
-- 
2.55.0


