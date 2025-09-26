Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C51ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 11:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v26BO-0007Bz-2U; Fri, 26 Sep 2025 07:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v26BH-0007At-B7
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v26B4-0007SY-Tx
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758884379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBEMiCFVj3xvS3M2nmY01HIfGjSvVC9LBpvAbZyiaFI=;
 b=Zes8eZMY+P4Ei06tFDipnlR8qjGjlXHLK8qLgiOQBe3++P4EleXO/i0Acry3gmdBo9UFyl
 PfRsO/5mTBiWa9wYJl3cgbFYgxuZ88iewvaZp2EkNVRV4Cu+bELyGV1qv6DGCAyFWwYJkt
 lXnye83gYYox4/nC6II+BlkJ8+GkLSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-3V-8H5E2PvCXV_Xg2O_6JA-1; Fri,
 26 Sep 2025 06:59:36 -0400
X-MC-Unique: 3V-8H5E2PvCXV_Xg2O_6JA-1
X-Mimecast-MFC-AGG-ID: 3V-8H5E2PvCXV_Xg2O_6JA_1758884376
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6B5C19774E5; Fri, 26 Sep 2025 10:59:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.43])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A20C1195419F; Fri, 26 Sep 2025 10:59:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4E9ED1800619; Fri, 26 Sep 2025 12:59:27 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 4/4] igvm: track memory regions created
Date: Fri, 26 Sep 2025 12:59:26 +0200
Message-ID: <20250926105926.121890-5-kraxel@redhat.com>
In-Reply-To: <20250926105926.121890-1-kraxel@redhat.com>
References: <20250926105926.121890-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 47600c361db4..5a8b4196149c 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -34,6 +34,11 @@ typedef struct QIgvmParameterData {
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
@@ -79,6 +84,7 @@ typedef struct QIgvm {
     uint32_t compatibility_mask;
     unsigned current_header_index;
     QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
+    QTAILQ_HEAD(, QIgvmMemoryRegion) memory_regions;
     IgvmPlatformType platform_type;
 
     /*
@@ -191,7 +197,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
                                   int region_identifier, Error **errp)
 {
     ERRP_GUARD();
-    MemoryRegion *igvm_pages = NULL;
+    QIgvmMemoryRegion *pages = NULL;
     Int128 gpa_region_size;
     MemoryRegionSection mrs =
         memory_region_find(get_system_memory(), addr, size);
@@ -225,20 +231,21 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
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
 
@@ -934,6 +941,7 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
     }
 
     QTAILQ_INIT(&ctx.parameter_data);
+    QTAILQ_INIT(&ctx.memory_regions);
 
     for (ctx.current_header_index = 0;
          ctx.current_header_index < (unsigned)header_count;
-- 
2.51.0


