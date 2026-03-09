Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D4FCA187
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPH-0004jt-8O; Mon, 09 Mar 2026 16:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhPD-0004hR-SA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhPC-0007q2-5u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dulq0T1zzOTRkDz99a96A58d86es7ym6LZ7eZmdWwUw=;
 b=WKQ7fRQSI6UDCc9Ml5zcmSq3MeTh2u06p/2F3IHzP+tcuotSvvuULBQRci5AxtcsfHDhSo
 UIUAKF76xnX5x8MAe/2AzN4xjsyiB1WVDNcavED3ulUhwAC1q0igrPGmM9Vqk/No+PcQsx
 covA0LY0/leVdiig6CJgJCFToAqgHro=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-1WjBShxbP-W-syRQbhUFUQ-1; Mon, 09 Mar 2026 16:40:44 -0400
X-MC-Unique: 1WjBShxbP-W-syRQbhUFUQ-1
X-Mimecast-MFC-AGG-ID: 1WjBShxbP-W-syRQbhUFUQ_1773088844
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so1071438085a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088844; x=1773693644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dulq0T1zzOTRkDz99a96A58d86es7ym6LZ7eZmdWwUw=;
 b=pZNIqXKbIe3sBEzaSB7YmHnLacpBFQVbTNedglYUZsEXZbZWq1XwB1CErO1yMadIqw
 pKBeG4guXyBrpBSdUshAoFMeLx3a5laK3cakFy2Jx5uxJSoZIGSPjJHZG3pwsCrDjvW/
 BkzdIQrPN2gdYC0LT70AhqjVg5U4+kFFL5Gf5wF+ef3paBU6HDarjevF7I5PWLPvt82M
 W0pjLUT4J3bpBpe2k9fypiiSNp8gnTWSoYVZkId4zJBh1w3T4gs/ugflbdJcxdfVOozk
 fMc6wC+s2LhZ9E0/X+2PaA9mcEroNICwLpdp7mJzy4m7FrevUfNn20OafYgxin2Mx0IH
 b8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088844; x=1773693644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dulq0T1zzOTRkDz99a96A58d86es7ym6LZ7eZmdWwUw=;
 b=rKRhKTPyH7ERb48c7auaoBjcHvFiT5EQi+lYWM8vGDxPS2UyjX0EBN8/9Ft4J49RGG
 rcPEgvZTKZc1TXEsoushqR3ZQZZeZNPnHCgyyd1NwlzA69Eez6EVumFHJ7MzX5YBJRqR
 ZHERA+GGHVMY2cSQZQEuiyyWqUF8xS/1/MG5qX26PcgZJwBrTpTCIRgNGaSfEEXPdais
 q88/1Zz8DU7yTDVm5WLguZAwE0tPE1LGyOf189KmiM4RJTSjPlBNL8ucXxPWPTKjXcuX
 Lcd+BHJYkikFpWQ3vKDvt45y6LmogoXlsW14dI6yIDThVls3DXzuvd0R3lK1v1rTkLWa
 P22Q==
X-Gm-Message-State: AOJu0YymRHQFPqLrJRJVZ96t7z7aYk9WhStd2DLq++EP/AyemczcjENP
 i421Fg+rZXXlzidnaOcsfNq6y2j4lS530mdgNFZJzoJoAj6qFDMvI8xvqxgPikVjJnGMPKCacV0
 D0kMZTjhBBDxXMTj7X8cwo+CcvyUHkSzpQGWD4osVEagDS4fKVlAlGA0713JSBZvNU+BdvdsN2D
 SkyaPMu1SkM8RHoOoU/C7+uMex0vSw/K20VDtnKQ==
X-Gm-Gg: ATEYQzzSNKuozqH1gABkAKrrADhszuKIyYSknr7RwHOUvbvDPDZ7a8aqcAVNOIlYS0S
 ztp9w0CZW3B7ElL7ABsnZULZmSg8mISuPr0ZLt2kfnH6wiU8fw2nXNyH0ec0xYplNORkhM8TWq/
 NplKOO2CahH1+lKqtywV8xODTnPCb6HBLz6nPqFTDNuisuzip/wQdUb64rISxTR+yAw9cRIS4jJ
 Y5eZ/wwr+m9uy86udVvZhFg3qIlsozC1/IqZzjQtXnouhSorqicG/D4X3K6EI09sewckLCztsM9
 LoOmZuwTIGmKKoaLDvjQdWjvLBoYSLk+eyw0EnNAhjKBGrWIkF4twGHcVY6yVmNyNf6IO8IvfvV
 a3a7yEzyAsRMC2v9YhI5nnfQx4l6WJR3LNJeNv2hbiMzF3L7z8uAzyFrsfdKQX5lmDa8TdZLYdr
 pNLxRmag==
X-Received: by 2002:a05:620a:2847:b0:8ca:2086:a148 with SMTP id
 af79cd13be357-8cd6d453d81mr1669284685a.28.1773088843557; 
 Mon, 09 Mar 2026 13:40:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2847:b0:8ca:2086:a148 with SMTP id
 af79cd13be357-8cd6d453d81mr1669279685a.28.1773088842894; 
 Mon, 09 Mar 2026 13:40:42 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 17/18] system/xen: Constify various MemoryRegion arguments
Date: Mon,  9 Mar 2026 16:40:06 -0400
Message-ID: <20260309204007.1709441-18-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the MemoryRegion structure const when is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/r/20260309183536.88976-4-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/xen-mapcache.h | 2 +-
 include/system/xen.h          | 6 +++---
 hw/xen/xen-hvm-common.c       | 8 ++++----
 hw/xen/xen-mapcache.c         | 2 +-
 hw/xen/xen_stubs.c            | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
index c46190dd0c..114d1929c8 100644
--- a/include/system/xen-mapcache.h
+++ b/include/system/xen-mapcache.h
@@ -16,7 +16,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
 bool xen_map_cache_enabled(void);
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
+uint8_t *xen_map_cache(const MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
                        ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write);
diff --git a/include/system/xen.h b/include/system/xen.h
index 9a7c53f283..43b857e4d1 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -30,7 +30,7 @@ extern bool xen_allowed;
 
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp);
-bool xen_mr_is_memory(MemoryRegion *mr);
-bool xen_mr_is_grants(MemoryRegion *mr);
+                   const MemoryRegion *mr, Error **errp);
+bool xen_mr_is_memory(const MemoryRegion *mr);
+bool xen_mr_is_grants(const MemoryRegion *mr);
 #endif
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index eb7f6270a0..62d88804c4 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -23,19 +23,19 @@
 MemoryRegion xen_memory, xen_grants;
 
 /* Check for any kind of xen memory, foreign mappings or grants.  */
-bool xen_mr_is_memory(MemoryRegion *mr)
+bool xen_mr_is_memory(const MemoryRegion *mr)
 {
     return mr == &xen_memory || mr == &xen_grants;
 }
 
 /* Check specifically for grants.  */
-bool xen_mr_is_grants(MemoryRegion *mr)
+bool xen_mr_is_grants(const MemoryRegion *mr)
 {
     return mr == &xen_grants;
 }
 
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
-                   Error **errp)
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   const MemoryRegion *mr, Error **errp)
 {
     unsigned target_page_bits = qemu_target_page_bits();
     unsigned long nr_pfn;
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index a3c162cd4c..85cf0cf359 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -460,7 +460,7 @@ tryagain:
     return mc->last_entry->vaddr_base + address_offset;
 }
 
-uint8_t *xen_map_cache(MemoryRegion *mr,
+uint8_t *xen_map_cache(const MemoryRegion *mr,
                        hwaddr phys_addr, hwaddr size,
                        ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
index a39efb5062..f830768d99 100644
--- a/hw/xen/xen_stubs.c
+++ b/hw/xen/xen_stubs.c
@@ -19,12 +19,12 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 }
 
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp)
+                   const MemoryRegion *mr, Error **errp)
 {
     g_assert_not_reached();
 }
 
-bool xen_mr_is_memory(MemoryRegion *mr)
+bool xen_mr_is_memory(const MemoryRegion *mr)
 {
     g_assert_not_reached();
 }
@@ -44,7 +44,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     g_assert_not_reached();
 }
 
-uint8_t *xen_map_cache(MemoryRegion *mr,
+uint8_t *xen_map_cache(const MemoryRegion *mr,
                        hwaddr phys_addr,
                        hwaddr size,
                        ram_addr_t ram_addr_offset,
-- 
2.50.1


