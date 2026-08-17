Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852FBC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyCj-00005L-Gv; Mon, 17 Aug 2026 10:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCh-0008WR-DY
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCf-0002dU-Kz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=g784Gck2up/YoKLM4yvr8IAySMN2E1uXYsDHBj2tKvjArvVXOlovtWAklHvno0x9A4iHAm
 Wi+pfN2TQqFlnt7rdleDtXbzeJLy1A/P06nRxanldXNz+QfbWdafl/RiaArbIO6x0buSuW
 keT7G5g39WeL4QMn22oYUjhVqoLk6Og=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-970voelaOuy0_jbh-UhczQ-1; Mon, 17 Aug 2026 10:20:39 -0400
X-MC-Unique: 970voelaOuy0_jbh-UhczQ-1
X-Mimecast-MFC-AGG-ID: 970voelaOuy0_jbh-UhczQ_1786976438
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cea6a46766so60276155ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976438; x=1787581238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=mDLCV8i7YCZNiZk/BR6AsIoiL8hhb2fyNYsr3sBH3xm0nONq8uIyGCxRSyer6n3CbX
 ZJ0XqaukWd2Xgeo9SgZpSl3S9UjoRLL+Vw3PcD6eRgwFO/xf0vWseLdzZjKtC8IXhX/B
 GFjgv+M2SvumOGZF+NMUj9AXgLsDfsLlfq3a8+Q47spL9HttMvB1mDBjtdVWXZ6tBUuW
 l2FumQFUxnwIqSc+mc3NSXx0e74bK9nD7DyKENwT9nDEsSpgaHBSoLYXNDGybqt65oii
 CVP9uh9mxy2FlKuG4EmQoNvhcuiqMmLRcjAHz81adci40+hMIdpls0qF8AdIgLBQG7+C
 Cu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976438; x=1787581238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNWWes4hozHIIm8ixM4SKBd90yNYXauRvQz5BFyDsnY=;
 b=bvBHycV6QU0n4bSNB9kIzLEAAIUmHsE/PsFQ+KY5UUN3T2SM5S47qG44C95AF78pV2
 xJade0DHm6xM9QVh0LMm166LX4pNtvSqdAuhaY/7YZXhxkmRzEK9N/im9Ad1jVQ0nF0Q
 hv0sKfCsbDzD3L8L3uL463uJDFsG9arVSRTryUnhYWLNtVmSfjYwXZitMAhvLiLKE8Zg
 FAp1JDerGTbRFrLChC449mJsmLMmiqtbcVmm62nDTmNqjy4ASZki6G+UVnesBQQ3YJkA
 dnqLcqz+U1fXG11PmDq5fp4rgiQSarLdBGNtAVnaK2d7yfNN6sby7HD4b/URdc55nFNx
 69KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPk3y56H1zodYZVoc2NkDF2B20zCkH0VLDrPWWmzyQ0xFiQrJ9BXJdmyFEsz+tPYxsnxRW7Ep/COII@nongnu.org
X-Gm-Message-State: AOJu0YyY67EQI0KbriiUjtr2Bd32uuI7JrWK8wkO5RMNnAKyjDXJfa6Z
 ogbjOiM2/dahcm/xr4XDzOOvh2t77qlPcldtRX/LueKOtqKjz+1NiTaaYtM8XvzA6RYo6dyGvRQ
 LtoD7kLaqBmzFWjAfGdqEuTEkFVo1CtV1JMm5RcZ1JacntdtkYjEmUqAm
X-Gm-Gg: AR+sD13tmjq8OAtiGQhClVdtg8ys62FKuTYWA8AFwNA7vqjv6dEFr3BYGlesHEuEmSG
 ytYo+WAiT2IM1LnzmKqo6wQOuSCnS0fRKLtGZbuJ782KfR9UHPBhDFpdKtVDk3uKMZov9nsGHzV
 CpoD44hWJsFCkasYdfGeP4YQSktSKXrIQGADs2Qs6TYgpg4E1xBbJB5QP3dlN5yjI72SJR/rZ5j
 ZGnntcfgUSsjD7CT1p0sTwUd8Wag1mFIzoHML9CJ4KVQh1Ik/EbFodNV58AwVu5LVKdaOSonHrB
 AvqamY77BlvDeU11SyDLkc8ufKFGW0ZcSv6QN8/3trgwYEGHBwfCR8V+Qw/BirxawKcjG/CIJDm
 v5NUSJM8f/ZYijt63+DW+EbPCpCIVC3To9g==
X-Received: by 2002:a17:902:f788:b0:2cf:a1c0:d4ca with SMTP id
 d9443c01a7336-2d5c5479555mr6150765ad.22.1786976437949; 
 Mon, 17 Aug 2026 07:20:37 -0700 (PDT)
X-Received: by 2002:a17:902:f788:b0:2cf:a1c0:d4ca with SMTP id
 d9443c01a7336-2d5c5479555mr6150255ad.22.1786976437525; 
 Mon, 17 Aug 2026 07:20:37 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:20:37 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v6 02/11] igvm: track memory regions
Date: Mon, 17 Aug 2026 19:49:57 +0530
Message-ID: <20260817142010.80693-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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


