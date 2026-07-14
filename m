Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1B2C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjTA2-0008NP-M0; Mon, 13 Jul 2026 22:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTA0-0008Mt-U8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjT9y-0006bE-Vo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783997174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcjFc/7/NHyuFbF0/DRanapEJL83S3ru+B67fe+lavo=;
 b=Ma/zKw7rjs0urItQQOtkLU51sg0cRIrubtIKI5ezUKoq3SDNhMN5Hri9mCPhGk+/HoLZAh
 JuxY0VmBfIjESuXwziVrMXm9oY8qkgwoBMeuoL+69otKqvbj4VUhHdN/jV4gZHm/TamuAf
 1tLWiv6gQLKxchvhe5Ci8Yr3E/ZuwLo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-8UBnKblcP1uFUAbs6tf5yA-1; Mon, 13 Jul 2026 22:46:12 -0400
X-MC-Unique: 8UBnKblcP1uFUAbs6tf5yA-1
X-Mimecast-MFC-AGG-ID: 8UBnKblcP1uFUAbs6tf5yA_1783997171
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so5866387a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783997171; x=1784601971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TcjFc/7/NHyuFbF0/DRanapEJL83S3ru+B67fe+lavo=;
 b=DK7YQYDJDx151luOa2pIXgyxFHdGn9TravERhblC40W565GErji+yot78selt0dEgn
 GEUX4WufspGfUzKlkaQqNUwXgnun8Htt/zRWwcZ8yMk1an9uQXQxtKAg6dpX8jAxVH6y
 x77JW3a65578bHvA86QUvwR1Iyg1rmJEqYsPE8XY3IEZ3r11J8wm3yPgYEux3CX8yD+9
 7uz/Bau9Z1VOa8MtQdo7N/v7p22Xpt0IuMrRnC+FYFdae0T2WJ87t/b2nosUeQDcBrXb
 Lrvb5IqmKEOUPVS0IS84IeCoA1FPRVqa/5MDmzjt/BG7kgh3r+/7ySqjhxNCe51Sr+tv
 iRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783997171; x=1784601971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TcjFc/7/NHyuFbF0/DRanapEJL83S3ru+B67fe+lavo=;
 b=sC0WPaI8yAttIuBNlYZ32UkoP5juDsICkC12mDfQJiXPTHfppOQhognaeuuvvD/Fj1
 6TBoEZzq0/htXvbn4J0I3tH301I8dJFrjdEuTmUqSkWi/OBfqxqIX1GGEZeTiXLGE9lx
 cGnP8xpyhNdDb1K6eR98MnXpkauV4QYK7jH6SzQjpTLNE2P7EI40kWuenEY+dkGynwNx
 pnSl9S+BWe1FmFc8xtNDL0edCYr37X0iGT+GsDKHMBiBQx6IsDVgjV6SQsCVXR72b+K+
 hrf6FFi6yT5GriwGXB0vjr+7EjMmd8cNDiNgVivdR8nVJQz1nEXiVcG3QuYVr6lI+h5b
 iZIA==
X-Gm-Message-State: AOJu0YyIbNYN74KwJwf4qw99E7zkNrOe5o3VoOehmbdTf8gvIPY7Kbb+
 Ol+h7nMiFLOtJ4VLw1PzKuPVr1i3Ctrerciyj1CIkcgRXFAArCJE9OYmIbJ5b1aIVGubcH6ltzV
 bwe24Hlx0/P8FhNwAk4LraQQms3SGohxI/sNLveY4idjmPWwyAOlTW2Cp
X-Gm-Gg: AfdE7ckYSQlM1s8v9Pqv7eY7rsRrZgY+5piigcbWgnu+ZESEJT/gYIgSZqUSFARWAVh
 lnXslZX1L6VTDjHAo40b/2R9dVGfOYZzW8h5I0lKoXixPjk02vjh0EHuky+spsUQLeRd6twwShL
 BBb8lEvM8fdqextqJDDoYh7NVxSyYD6Pvtv9FC4SDxYynA0Bqi9y3rLxuehN/aXg0CxpLZaL72c
 VAzPCigJdzlcpmK1UMs+We/CYvGkNOBBEDpHUqnEiVptQmWkZqZbAwDgauHXbByw2mGd1MKpnuG
 np/HsaBMK1bRQ0gcvr73tmsADpOMqXdATkyhV9/DcP3stVl5ePjRVRNHmd+GVRlYLj0g+eg6vo8
 jC3qVzC5bRh/pEK7JngfG6lmawOcP0NhsIQ2O9cCK2vRImw==
X-Received: by 2002:a05:6a20:cd8f:b0:3c0:9c19:6597 with SMTP id
 adf61e73a8af0-3c110b6c159mr13098674637.63.1783997171384; 
 Mon, 13 Jul 2026 19:46:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:cd8f:b0:3c0:9c19:6597 with SMTP id
 adf61e73a8af0-3c110b6c159mr13098630637.63.1783997170908; 
 Mon, 13 Jul 2026 19:46:10 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm60184658c88.1.2026.07.13.19.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:46:10 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] igvm: track memory regions
Date: Tue, 14 Jul 2026 08:15:21 +0530
Message-ID: <20260714024557.204578-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260714024557.204578-1-anisinha@redhat.com>
References: <20260714024557.204578-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=anisinha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Memory regions added by the current IGVM needs to be tracked so that they can be
freed when a new IGVM is loaded.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm-cfg.c            |  1 +
 backends/igvm.c                | 20 ++++++++++++--------
 include/system/igvm-internal.h |  6 ++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index e1f09855f6..38438a7b1e 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, Error **errp)
     IgvmCfg *igvm = IGVM_CFG(uc);
 
     igvm->file = qigvm_file_init(igvm->filename, errp);
+    QTAILQ_INIT(&igvm->memory_regions);
 }
 
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
diff --git a/backends/igvm.c b/backends/igvm.c
index 534032fed8..9e7c90d386 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -220,7 +220,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
                                   int region_identifier, Error **errp)
 {
     ERRP_GUARD();
-    MemoryRegion *igvm_pages = NULL;
+    IgvmMemoryRegion *imr = NULL;
     Int128 gpa_region_size;
     MemoryRegionSection mrs =
         memory_region_find(get_system_memory(), addr, size);
@@ -254,23 +254,27 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
          */
         g_autofree char *region_name =
             g_strdup_printf("igvm.%X", region_identifier);
-        igvm_pages = g_new0(MemoryRegion, 1);
+        imr = g_new0(IgvmMemoryRegion, 1);
+        imr->mr = g_new0(MemoryRegion, 1);
         if (ctx->machine_state->cgs &&
             ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
+            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
                                                     region_name, size, errp)) {
-                g_free(igvm_pages);
+                g_free(imr->mr);
+                g_free(imr);
                 return NULL;
             }
         } else {
-            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
+            if (!memory_region_init_ram(imr->mr, NULL, region_name, size,
                                         errp)) {
-                g_free(igvm_pages);
+                g_free(imr->mr);
+                g_free(imr);
                 return NULL;
             }
         }
-        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
-        return memory_region_get_ram_ptr(igvm_pages);
+        memory_region_add_subregion(get_system_memory(), addr, imr->mr);
+        QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
+        return memory_region_get_ram_ptr(imr->mr);
     }
 }
 
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index b5720fae0c..9e9fa1d9af 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -18,6 +18,11 @@
 #include "system/confidential-guest-support.h"
 #include <igvm/igvm.h>
 
+typedef struct IgvmMemoryRegion {
+    QTAILQ_ENTRY(IgvmMemoryRegion) next;
+    MemoryRegion *mr;
+} IgvmMemoryRegion;
+
 struct IgvmCfg {
     Object parent_obj;
 
@@ -29,6 +34,7 @@ struct IgvmCfg {
     char *filename;
     IgvmHandle file;
     ResettableState reset_state;
+    QTAILQ_HEAD(, IgvmMemoryRegion) memory_regions;
 };
 
 typedef struct QIgvmParameterData {
-- 
2.42.0


