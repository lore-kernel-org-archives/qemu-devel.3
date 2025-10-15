Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F568CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zcI-0000Bn-4i; Wed, 15 Oct 2025 07:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zc4-00009Q-81
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zbs-0003El-6Y
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760527436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOTVJE4znw/zNoERVFcl7Z/SeuXdNa7jD4n1nPt3Z/g=;
 b=Bx9Dx6OExwDuA93JjoaEwT0Fzq4KN88WuHZvT1cWZYMBkCi9hidwKpcHNbhHCdf8gEaQte
 ZNp7idyjFcC+v0im2S2uU4CClQCW7zE5KcG8nQulml0qO9pODV/7C5OqC98vETobSpYXYi
 JRkvEH7Yrc7O77TQ8l2XZUc9Bke6zTc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-EJ2oRJ7XNsSqXWV21KNLtg-1; Wed,
 15 Oct 2025 07:23:51 -0400
X-MC-Unique: EJ2oRJ7XNsSqXWV21KNLtg-1
X-Mimecast-MFC-AGG-ID: EJ2oRJ7XNsSqXWV21KNLtg_1760527430
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B32371800BC0; Wed, 15 Oct 2025 11:23:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50D9F1955BE3; Wed, 15 Oct 2025 11:23:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 08ABB180099C; Wed, 15 Oct 2025 13:23:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 4/5] igvm: track memory regions created
Date: Wed, 15 Oct 2025 13:23:41 +0200
Message-ID: <20251015112342.1672955-5-kraxel@redhat.com>
In-Reply-To: <20251015112342.1672955-1-kraxel@redhat.com>
References: <20251015112342.1672955-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

Keep a linked list of the memory regions created by igvm.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index ee5ee74c7a66..1690fb334bf5 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -28,6 +28,11 @@ typedef struct QIgvmParameterData {
     uint32_t index;
 } QIgvmParameterData;
 
+typedef struct QIgvmMemoryRegion {
+    QTAILQ_ENTRY(QIgvmMemoryRegion) next;
+    MemoryRegion mr;
+} QIgvmMemoryRegion;
+
 /*
  * Some directives are specific to particular confidential computing platforms.
  * Define required types for each of those platforms here.
@@ -73,6 +78,7 @@ typedef struct QIgvm {
     uint32_t compatibility_mask;
     unsigned current_header_index;
     QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
+    QTAILQ_HEAD(, QIgvmMemoryRegion) memory_regions;
     IgvmPlatformType platform_type;
 
     /*
@@ -185,7 +191,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
                                   int region_identifier, Error **errp)
 {
     ERRP_GUARD();
-    MemoryRegion *igvm_pages = NULL;
+    QIgvmMemoryRegion *pages = NULL;
     Int128 gpa_region_size;
     MemoryRegionSection mrs =
         memory_region_find(get_system_memory(), addr, size);
@@ -219,20 +225,21 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
          */
         g_autofree char *region_name =
             g_strdup_printf("igvm.%X", region_identifier);
-        igvm_pages = g_new0(MemoryRegion, 1);
+        pages = g_new0(QIgvmMemoryRegion, 1);
         if (ctx->cgs && ctx->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
+            if (!memory_region_init_ram_guest_memfd(&pages->mr, NULL,
                                                     region_name, size, errp)) {
                 return NULL;
             }
         } else {
-            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
+            if (!memory_region_init_ram(&pages->mr, NULL, region_name, size,
                                         errp)) {
                 return NULL;
             }
         }
-        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
-        return memory_region_get_ram_ptr(igvm_pages);
+        memory_region_add_subregion(get_system_memory(), addr, &pages->mr);
+        QTAILQ_INSERT_TAIL(&ctx->memory_regions, pages, next);
+        return memory_region_get_ram_ptr(&pages->mr);
     }
 }
 
@@ -928,6 +935,7 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
     }
 
     QTAILQ_INIT(&ctx.parameter_data);
+    QTAILQ_INIT(&ctx.memory_regions);
 
     for (ctx.current_header_index = 0;
          ctx.current_header_index < (unsigned)header_count;
-- 
2.51.0


