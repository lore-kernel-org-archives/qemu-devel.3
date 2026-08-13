Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259F5C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSm3-0005vO-EW; Thu, 13 Aug 2026 06:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm2-0005v8-7o
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm0-00008c-L7
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=Of3nVQ3xDwAUoiQaydiRJ5KUP9UfwOXSeRHGRYIlNYeMhQ+p2b08ITYpU7lXJR64kQFqX1
 hWKqtVdmuX4yfGq2xjAt//1dUOi+omCBV5IKjVQYJcjPnZ3h9I4hjhms/wadETb52v+QE/
 kra4vyAfB/Y1o6YhqIVsRj/9aZMBT4A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-H4YQHCtKNbW6J6-Uvsf7kA-1; Thu, 13 Aug 2026 06:34:54 -0400
X-MC-Unique: H4YQHCtKNbW6J6-Uvsf7kA-1
X-Mimecast-MFC-AGG-ID: H4YQHCtKNbW6J6-Uvsf7kA_1786617293
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so3127734a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617293; x=1787222093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=WkI/8nwpY1vJk1mjSOGDJ1GKSgFtD72euEjsN2UocJ3hKQuntmqPlRzYHt0Mn/yGTz
 duMZzCVDJfeCKw2Zc8BVqiFuYauiCrJxaJcSGpN/CXRaYjsImGUhOGmTmKTzlkDEgY4g
 X0ok0YIcYuUkbao4fDAZIYszH8xu8HXXnHs3cN5G4fZEPmRpC+tKoe/AmOYsGItxkHxi
 pLEDAv2EdCyTRIi7cNRlHBbIUgTEOUmcrYQedsx966q9+BipvrV/5WkmTFUt6tZzEKtz
 jjz6YwWd1rNLo4tGDs5rz5RZJNuzctF2dhI0cvxKzNMG2Biv1OVvvURmt5VcxRpDokCD
 EyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617293; x=1787222093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=phzUeIu+M3Q8c4ocpIdc1ElojfaRfTqE0ClAEbk3UQkR9Om+c8QY6j7m8Xnh3FpPYP
 BdZlKSOzJDLiCUcJ8YoC9MMoPWMs7yv3FTJXTZkHFrpDoeJ7/eq4+2Kn1W4J6GWUG7sc
 ZHqSZ6/BIzFs54Xo4mCLDupW9kAZpeOSlcs3pWDE1tPJzhQ+bgXb5pPq5QlzS5sODDk6
 pLR2LQnLjlg3LIb19cFfy5xlu39syx/BWdfRGzTAi89IamE+dvW4YoX+mG/YXgfxiEfN
 ZU+tne7DMFUBx0bM2kiqxktB3PEEUprymEUhp2ASLoxuxl5tNJO0oBC1TMUo64UGzlYE
 WJ6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6AUpvcWa9+ciPlYNxPt4Z1faQKYqKifKG8H+VFloDDJfBOrf34Lqy1phP2VcIDmntkyC6+3vzmIUg@nongnu.org
X-Gm-Message-State: AOJu0Yysf6s0s60sMKBCZ/XMLe0et7TiOye7tNjP8eB3TMsJIEF1DEuo
 1L39emt++8wQF3vfeRHDYW+oaRetRonO6R9zvLa+j6XktjfHAOOQxOmqiwjxN1aXQiMOdI7xdzl
 iWTqDD89J32y8DA12TIKJdXB/IEHMzcTqzluYIIuLqVaEzxHsnTwdTz/D
X-Gm-Gg: AR+sD13zSOPZ/rWTe8ZpCz9fj6dUOoyYkkOueAg4mt4v7eSFJNLnxnUjyduzCYIKYA1
 TxUVGNBIqnDL1O+DQKdELim79AV9kbMGSk928LJpfxzCBitlNyXa2sGpjrR25qldX9fIyTDX9g+
 4c/yBScBeEvpYsony6uwZHUSutoXV7y3cPzPwVpsrLbw7a8w2ldzMyuXLkFcI7B0KSFSPQ/aO/2
 BIIpGXgDzJHFdYwUOyTzfKS1fO+KFMCwLNHoYQ9BsN4iwKK94YO3EA8LvRlFwkIddHKblcuZ3sa
 d9PjFNZlgmgEEhpEBauNcbm51QiNPoF69SNwJLkD9sAztzWDGS91SP16uTmT0e2z3ngT6f2xjHg
 V/3vVQlX8dqhC4R3b1d/nMtOOG/oCJKyzDQ==
X-Received: by 2002:a17:90b:52cc:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-3931e29921emr5042863a91.16.1786617293352; 
 Thu, 13 Aug 2026 03:34:53 -0700 (PDT)
X-Received: by 2002:a17:90b:52cc:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-3931e29921emr5042816a91.16.1786617292817; 
 Thu, 13 Aug 2026 03:34:52 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:34:52 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v5 02/11] igvm: track memory regions
Date: Thu, 13 Aug 2026 16:04:04 +0530
Message-ID: <20260813103425.24474-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


