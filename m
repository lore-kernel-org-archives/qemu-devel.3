Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4307CC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD6A-0001Jn-Tb; Fri, 07 Aug 2026 01:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD69-0001Iz-6i
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD67-0000jc-Fj
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=eqgZcH+pAYUHM6C+ozlgK//o/Rvprjq+iAJcKFQVpdX8B4MBuLs2y+6CYF+ketr/ZMqZDV
 PYPGvrwjjtxP73YAjmQhkcBQcPCTY3JCcUDudUCFo9T9P4LOARt/NpYgVXJmPB+n72LFa/
 6nSHjjBzfgJaL+asfyrS3XLnw8T7xe0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-A8aGionyNpSnyztSpA5yGQ-1; Fri, 07 Aug 2026 01:26:14 -0400
X-MC-Unique: A8aGionyNpSnyztSpA5yGQ-1
X-Mimecast-MFC-AGG-ID: A8aGionyNpSnyztSpA5yGQ_1786080373
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38827cee19eso3769135a91.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080373; x=1786685173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=liSm35In4iXraBLk47aH+5iG2f4XPZ8D4TL+Dtwj3dWIGvoIke/CuH1J/aJNkjOqmY
 CUp6ecUV9i9IfYsIm0aX0OpxI9ss0SJDAx2AFKPCNDRZWY4BTT0Fnt+TYDv2aU46z7LK
 XqHS94Y4fF7PGwsohp4E3mK8EUpwWcWRZjeAsNXYGjfH5UsMkLGxn/aSWhsfUNTFEK0p
 I+4RqUtR3R85YQkMhtgWouQ+Mavxs2bHTJlK7+6BgV2AkWpZj952pM/8Rjt/dgyde3f2
 rf2s3h51cCkdSHjDwklsKB/VQs4jJTjiMdkDlme1WwJM9oIdHHm+1QtNwTBv3r9RuxUw
 9U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080373; x=1786685173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=QVjSOE2sz2E7CuiGqiq0qJtPrZVte/nA4ELlqUCtNnMgKrDlNeY8vu+YtjpMgHdfNe
 yziMZ7OSYath8nC58Imc98lNOFbuOqqMr3PIfKgohwb/fhdB98LSDzf3xJbuYru2QdQB
 fGeSFlSKq4F5q/pwC5SXGwV0wLdNzWkbVy1dWHw+LWEhMcQbaIWQJtlVZLrirGCFu7hE
 ONLTesyeGDy4z9ieh+1x2rtUOWlwm4+tFFaTxgSAIjubSQPPI23pkVgFaxoQ7SYhI97q
 vX3HWhFxqCJLXfsRNAvqpvCc8dxInLmNGgGe5ehT6juTGtclFJt8r7EpJc5WvBpEwbUk
 RagA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFwDhlR8MnI1LFGcrvQuh+X0MEGCKla79LlwV+fWyBf2SmAhRoEQgYvLjZWgr/4HqO/adtZ1pXEBXi@nongnu.org
X-Gm-Message-State: AOJu0Yzon8m8Ha/Uw8YMTZ2s2092EKi51CBV4c1q7DD3ibac8+2wfMVw
 JzH/Xd13sRRoouhhC0taqtPFUl6yTSloS7FgdOaPnvfoCBOfmHF+fo4+/Rr3dJtz+vUvqQyQZI0
 rwHN+4gCuKIwzpsKTpF0DMmg4x4e2Cz6ZthJW3/P0EIpCdfoYr4yMkDlP
X-Gm-Gg: AR+sD13Z5qdlCI4f3yKhwdGIECSSHMfWk5rnQNVnXOD1Vo1rXc3RJRBzIkaZ8OSJnRg
 a4wAiHWaXzmWliQuHPDWnp5JCYnkyTOeoNU4Kl1c9Lk1xkrGfz/RGANekP33tlveK2o3RxIH2+3
 vSKDBR1RnRxMqMWARTKsd5JlFJiH0IuHE/L3xT5XtgTngbaejsZcHYUgMN6O5XiFhSh2+uOyYn1
 BvEMn3Mh70GWFEGvEbgtZjQ0uYdeT4Uc8WCTQV3Af95sUARyRcFyecJvMPmosCMVadeh1QBZlPC
 PfuPneEq8e9e10Xv8/msDV13ku//3cIdjlJhov3E5tcCJESuRoFgss/ZvOnm710QojZ9olFgCOY
 tM2z+P9wWyoJl3qSecpE0FlshxZIBJGgvrg==
X-Received: by 2002:a17:90b:4f91:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-3903ba0745emr17851045a91.0.1786080373140; 
 Thu, 06 Aug 2026 22:26:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4f91:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-3903ba0745emr17851014a91.0.1786080372672; 
 Thu, 06 Aug 2026 22:26:12 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:12 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: agraf@csgraf.de,
	graf@amazon.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 02/11] igvm: track memory regions
Date: Fri,  7 Aug 2026 10:55:44 +0530
Message-ID: <20260807052559.50643-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260807052559.50643-1-anisinha@redhat.com>
References: <20260807052559.50643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Alexander Graf <graf@amazon.com>
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


