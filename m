Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AB6CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZA-00071G-Fa; Wed, 24 Jun 2026 01:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZ4-00070X-Kv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZ3-00063f-1Y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlIB0gyVXIdZ9I8a3u7xyO2vP3rsljTTT0Q5gAGep+E=;
 b=J3Zq754/W1u8mJbdwLcEmJUxTFblFmZe+bN0EBi7DLC5xsPSyz2JRLHHyAwH04WZpLbB7N
 uL0IWdyS7uJ+BsUTcGvdD533MPRdeGK9EUSmFcEYYaNq5f6Ha+TqKz6Fksnugmc+U4Qr6V
 N+GID/no7IVl+ceKASekUBfV+LFMjJ8=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-6SeZwH7cNYq-HF44q88H4g-1; Wed, 24 Jun 2026 01:54:18 -0400
X-MC-Unique: 6SeZwH7cNYq-HF44q88H4g-1
X-Mimecast-MFC-AGG-ID: 6SeZwH7cNYq-HF44q88H4g_1782280458
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c13bb8ca9so832812eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280458; x=1782885258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlIB0gyVXIdZ9I8a3u7xyO2vP3rsljTTT0Q5gAGep+E=;
 b=UAgKix9wcV+2ckQZmbKT87iCXTauykTp6n/6BERh7+SFxsSMTQbI7BQN2YlnbKwTob
 ChQQfvRfnOmjQ2JvWXnJQz40XHK/rmzoMFjW7xoHt9XJzCykjpzcW79bkwLVtLt11+ay
 Q1v+KSpCHAKxBMW2dBpXauTlbWQ1ELdm9bAxpljhlIehp/luHyqj95uAa1tHVuTWGSus
 ChCK9a7Pe1OeJ9G3vHzV46e3BewFmsg2pn0DkySGXkcBwTV1BEt+ne7wBS+49/WZ19ed
 AknXTrz7l0b7UyH0DcVkK4Jr3kT2jJQryUF514JoFYllWnpICXASfN+q1tdwwvYxhHsk
 cvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280458; x=1782885258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlIB0gyVXIdZ9I8a3u7xyO2vP3rsljTTT0Q5gAGep+E=;
 b=rsEPrGciNSHNatWJD0IBTwUYoZRv77QiYck6R4Ph1/IWidCR85K0UV5k7PPgekmhTD
 0BeZrDGQe2abzi87lG8XNLhxJ8FYsnrZuPX5skb8oEOyohXt5ix/8rNzzjLLDLGKr6sJ
 FTr6c1BbNqe0FwIstxn2pKhC8OqqwVEc/ykW6Dfrm1DCm8dT99b2ENm+MU3kx/Tuvv0Q
 nzx0CYXGl6CarY3BC8Oa1/EiSv39ear3udZvgMD5kaor2Nx7hhOeyvBYP03ydbXHE1bO
 0vKIATCikqKo8ru0nDwLAgdRcozAND5T3srv4MaTAKIYKwkygvLKcjqH+14u6ReCPduO
 VD+w==
X-Gm-Message-State: AOJu0YyXAVgNnvmM3u1cjY+8AQ5Ted+srI4ovwbKqarGwnv5r3adtg54
 4PXPmi2Bb1+pGbF56KNkqik1oPHZvt80OdgP9N+w0bIxDurgY/gwVYYfUUKpLcKhyz4gWDOxoxH
 4gzn/yYNH3M3hNI7gGMHOF2TXWOLQ4NDHDjL30NmQeEPZE33DAhFdAe7U
X-Gm-Gg: AfdE7cl9Kp/VS2kwCDdTY4Irt+/yNTYOtkcQ5/ff+7/77/Iq17BeuMkJpDLa5prKd+N
 09MYVIjofMcs4pwQ4i/wxG+ds+kDV6u7MqqPn7F+B7BIfRDIjCdr/OVPGITYVrbm48t65j8i2/P
 f+sz1ZrjKMTabjg+KVnqEXjXF7vWsDZvebY0ROAehbqD7tl5jG9KT2ydO+qSPbL4SWnQU22xpTT
 tq6m03M6qPaNs1CRDxavrrOl2m/FHer15y1iSxLdSP4IKb/hVbIgmEY9tngv6gY4LtdNkSVmnIN
 YDQ00nH14QdGrIxbEDVKcycfJwTlDH9Ir5mZPQToVi2Pe8EINyFup5eK+VUaGa8eiyegwCDB+na
 OzH42PSYw1epKh3HabZ5SjQ6Ji+e4M31WVVX7c3wu4vU9
X-Received: by 2002:a05:7300:7245:b0:30b:c4e3:8235 with SMTP id
 5a478bee46e88-30c68def98bmr2162752eec.27.1782280457570; 
 Tue, 23 Jun 2026 22:54:17 -0700 (PDT)
X-Received: by 2002:a05:7300:7245:b0:30b:c4e3:8235 with SMTP id
 5a478bee46e88-30c68def98bmr2162734eec.27.1782280457027; 
 Tue, 23 Jun 2026 22:54:17 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v1 2/8] igvm: track memory regions
Date: Wed, 24 Jun 2026 11:23:24 +0530
Message-ID: <20260624055339.46862-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260624055339.46862-1-anisinha@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm-cfg.c            |  1 +
 backends/igvm.c                | 17 +++++++++--------
 include/system/igvm-internal.h |  6 ++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

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
index 2995e82cee..1c9751812d 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -206,7 +206,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
                                   int region_identifier, Error **errp)
 {
     ERRP_GUARD();
-    MemoryRegion *igvm_pages = NULL;
+    IgvmMemoryRegion *imr = NULL;
     Int128 gpa_region_size;
     MemoryRegionSection mrs =
         memory_region_find(get_system_memory(), addr, size);
@@ -240,23 +240,24 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
          */
         g_autofree char *region_name =
             g_strdup_printf("igvm.%X", region_identifier);
-        igvm_pages = g_new0(MemoryRegion, 1);
+        imr = g_new0(IgvmMemoryRegion, 1);
         if (ctx->machine_state->cgs &&
             ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
+            if (!memory_region_init_ram_guest_memfd(&imr->mr, NULL,
                                                     region_name, size, errp)) {
-                g_free(igvm_pages);
+                g_free(imr);
                 return NULL;
             }
         } else {
-            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
+            if (!memory_region_init_ram(&imr->mr, NULL, region_name, size,
                                         errp)) {
-                g_free(igvm_pages);
+                g_free(imr);
                 return NULL;
             }
         }
-        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
-        return memory_region_get_ram_ptr(igvm_pages);
+        memory_region_add_subregion(get_system_memory(), addr, &imr->mr);
+        QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
+        return memory_region_get_ram_ptr(&imr->mr);
     }
 }
 
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index b55b35328a..cab74cfd1d 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -18,6 +18,11 @@
 #include "system/confidential-guest-support.h"
 #include <igvm/igvm.h>
 
+typedef struct IgvmMemoryRegion {
+    QTAILQ_ENTRY(IgvmMemoryRegion) next;
+    MemoryRegion mr;
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


