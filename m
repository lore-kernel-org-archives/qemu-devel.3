Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAD6FCA187
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPA-0004fZ-IK; Mon, 09 Mar 2026 16:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP2-0004eO-0F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhOn-0007gx-4g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vehCZK5/R8j3vUwTjtp8zDbHvkpCYWmHpHas3VXqzU=;
 b=Eg862//JHCI8ij4qm7aoyGx6SFJxPpNlxJb4uHtv69nkfVllGxoP6awWLYP/6LrUbgJh0Q
 4qnoRYU8pOsN56KJcFmLHOBRyxr5yMeSLpd/o65cEXO705mZJ7CyfPCeJwVT9cvf3hRXMb
 L757mJW7/43r7H4E0J2HlX0GoQDaGhU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-k4bYsTy9NTauN8cGL0eFcQ-1; Mon, 09 Mar 2026 16:40:19 -0400
X-MC-Unique: k4bYsTy9NTauN8cGL0eFcQ-1
X-Mimecast-MFC-AGG-ID: k4bYsTy9NTauN8cGL0eFcQ_1773088819
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd77502295so1349969585a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088818; x=1773693618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vehCZK5/R8j3vUwTjtp8zDbHvkpCYWmHpHas3VXqzU=;
 b=RtpZs8PwByC6R11h9AeFN7mPOO0Sz/KDpvu24mH3A9PuqBvn+68P7xrfJsOAHAAD05
 tfgLk0s5lDuN7tKvNN/GS8/BchWDPYrHJK5cYGIgfU4cbEtJvnBaQIBDXBAwhv+rJHtZ
 mrb2MNwEzKWDMXO5Ggxj/xRYRdJI1nI5BFwxceeRP/TlI/MIXrrsB2O7R/6DCNNS7T4w
 mmnpdcqEaH8pdpjl3ZgCfRAYLc492Qrm17gtM5cuIxXcf+ocWLGIa+WUpPReG1TAB5yw
 F4ZfxXVQms2F2GLWxRCBVKcz7zq7Qk3QQRXHa5QkLdJzgOU4StMu1vK1JK7iJVYmA+MO
 zz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088818; x=1773693618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2vehCZK5/R8j3vUwTjtp8zDbHvkpCYWmHpHas3VXqzU=;
 b=tNzTwiMMnWnhEohe13n6bV3kmOJ4tPD12anNvaqrF55o846TZ/wHC93cN4r4k0uT9f
 fPaNyvMtfHKgH26K78wuV7r+hCho1rA5nrtDhbxt/rSFWGwyC7hlrQR3DDo/3OM2JIlo
 4l3jFBgDJg3AyDkIn/ZQHYlQz8H3pRqJSwwHa91ZDjskiK7KuoPZ5fMLAVEwCTF3foyp
 r7yladpIwgqvNxLNCPGhqgX6klOgNNxHe+XmCkYDiZ3UUsS4KElyU8Zd4GXGqwCL0mpb
 Q+JVkIfvvSF3tLOzFntfYM+y40YFgy+qLnb6TrH0T9sDstDEw07fS+xDSfRKMAEC4DT+
 OZCA==
X-Gm-Message-State: AOJu0Yyhyt7CPvsk0ZNepZjNqTkGb4pfxIGIu2hbbpPGDY02bLEUoauU
 fEYFkItW2BTucA3y6TUND/elvtLXDSKmanRpA72WQduD6d0BQX0XYq2ZAfuCGfHzOhSYFjHBfcZ
 yZvQa2ZYOvBosQI6oWYsLXOwXRXzIA/ST/W8RqzkpV0u8RJyrj/dkgJhD+aiQix7AtiH9KwsZhf
 87/iJj34J5zbi5M3Cy5tGsdFL8rSM8mszMOlVnKw==
X-Gm-Gg: ATEYQzw+n5QvhOa8FcxLAnEObHoofItc3o82qcZ+R0JiAZSERfKx6nvwKbx6a8hG2j7
 P6wBLiKkus7Luf7xMdwsuCwGJgook43rVpWmTg1zsnTA1y54/yGWKg7pRr1yvo9rXVuS2xh/7JO
 7ARFeINOPYDWl3tWRwTEoiQ/KOMd0Gr3tIRC56PeA6UMRLTeh8LxxFK9zCE0P21+7kViCNBx9uk
 5bZwad0HCenZRvmR2OYglBVd6bPglUPTNpZoQbr4pN80w4ealdQh2s/P+CpHVVgz4KUC1tRe/qr
 MScnDapBeGVulCz9sk0xx9IGlcK8l5z8+u0VqBJYLDZ1CuKZ8U8QMmid69wxBcnPND8nwVj9JRZ
 vKae2v4Ucn2jP6yYYzqd/0PXUuTbIgnzlnuRXJmVyqzlhO/bDdMepsG+4Wgwl+vwSTAQqlafU5h
 KfR64i6w==
X-Received: by 2002:a05:620a:480c:b0:8ca:2baa:6658 with SMTP id
 af79cd13be357-8cd6d4f7dd7mr1570852285a.70.1773088818314; 
 Mon, 09 Mar 2026 13:40:18 -0700 (PDT)
X-Received: by 2002:a05:620a:480c:b0:8ca:2baa:6658 with SMTP id
 af79cd13be357-8cd6d4f7dd7mr1570847785a.70.1773088817649; 
 Mon, 09 Mar 2026 13:40:17 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/18] memory: Remove memory_region_init_rom_nomigrate()
Date: Mon,  9 Mar 2026 16:39:51 -0400
Message-ID: <20260309204007.1709441-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
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

From: BALATON Zoltan <balaton@eik.bme.hu>

All users were converted so no longer needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/2665c92b578f5f6a602b34c7dde73451773e6148.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/memory.rst                         |  1 -
 .../memory-region-housekeeping.cocci          | 28 -------------------
 include/system/memory.h                       | 26 -----------------
 system/memory.c                               | 19 ++-----------
 4 files changed, 3 insertions(+), 71 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 8558f70a42..0bb5acab21 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -113,7 +113,6 @@ have a special case where you need to manage the migration of
 the backing memory yourself, you can call the functions:
 
 - memory_region_init_ram_nomigrate()
-- memory_region_init_rom_nomigrate()
 
 which only initialize the MemoryRegion and leave handling
 migration to the caller.
diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 7f89e9712e..e45703141a 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -16,17 +16,10 @@
 expression E1, E2, E3, E4, E5;
 symbol true;
 @@
-(
 - memory_region_init_ram(E1, E2, E3, E4, E5);
 + memory_region_init_rom(E1, E2, E3, E4, E5);
   ... WHEN != E1
 - memory_region_set_readonly(E1, true);
-|
-- memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
-+ memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
-  ... WHEN != E1
-- memory_region_set_readonly(E1, true);
-)
 
 
 @possible_memory_region_init_rom@
@@ -53,11 +46,7 @@ cocci.print_main("potential use of memory_region_init_rom*() in ", p)
 expression ROM, E1, E2, E3, E4;
 expression ALIAS, E5, E6, E7, E8;
 @@
-(
   memory_region_init_rom(ROM, E1, E2, E3, E4);
-|
-  memory_region_init_rom_nomigrate(ROM, E1, E2, E3, E4);
-)
   ...
    memory_region_init_alias(ALIAS, E5, E6, ROM, E7, E8);
 -  memory_region_set_readonly(ALIAS, true);
@@ -80,23 +69,6 @@ expression ERRP;
  ...
 -vmstate_register_ram_global(MR);
 @@
-expression MR;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
--memory_region_init_rom_nomigrate(MR, NULL, NAME, SIZE, ERRP);
-+memory_region_init_rom(MR, NULL, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-@@
-expression MR;
-expression OPS;
-expression OPAQUE;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
 typedef DeviceState;
 identifier device_fn, dev, obj;
 expression E1, E2, E3, E4, E5;
diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af3136..7117699b10 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1588,32 +1588,6 @@ void memory_region_init_alias(MemoryRegion *mr,
                               hwaddr offset,
                               uint64_t size);
 
-/**
- * memory_region_init_rom_nomigrate: Initialize a ROM memory region.
- *
- * This has the same effect as calling memory_region_init_ram_nomigrate()
- * and then marking the resulting region read-only with
- * memory_region_set_readonly().
- *
- * Note that this function does not do anything to cause the data in the
- * RAM side of the memory region to be migrated; that is the responsibility
- * of the caller.
- *
- * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
- * @name: Region name, becomes part of RAMBlock name used in migration stream
- *        must be unique within any device
- * @size: size of the region.
- * @errp: pointer to Error*, to store an error if it happens.
- *
- * Return: true on success, else false setting @errp with error.
- */
-bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp);
-
 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
  * that translates addresses
diff --git a/system/memory.c b/system/memory.c
index c51d0798a8..65042bd9fa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1738,21 +1738,6 @@ void memory_region_init_alias(MemoryRegion *mr,
     mr->alias_offset = offset;
 }
 
-bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp)
-{
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
-         return false;
-    }
-    mr->readonly = true;
-
-    return true;
-}
-
 void memory_region_init_iommu(void *_iommu_mr,
                               size_t instance_size,
                               const char *mrtypename,
@@ -3757,9 +3742,11 @@ bool memory_region_init_rom(MemoryRegion *mr,
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_rom_nomigrate(mr, owner, name, size, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
+                                                size, 0, errp)) {
         return false;
     }
+    mr->readonly = true;
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
      * unique name for migration. TODO: Ideally we should implement
-- 
2.50.1


