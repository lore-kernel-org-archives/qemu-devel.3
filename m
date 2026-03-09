Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556CEFCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPE-0004hs-IK; Mon, 09 Mar 2026 16:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP3-0004f7-Tl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP0-0007hc-66
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/ptOc9JgQFyYATJ+GXdVFz1EZ/RN/UI8fL0fT+Qc04=;
 b=NyKc/QoUunBFdgFjRI2TKys5u65ezkkS44SjcqxGbAKFuTuJgbU3P0VZQemKhVDjQALuMy
 x4Er78IDldB5hDmm3a/G/OwPXki5ANV1RHb9uFJyn4LezzAXrVbv/L3L7zW6xJ3ao6IEQn
 E2K8OBYnvtg0u58X9Y0c14MGtDeF4rM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-wQrir5jTNP-2CPuJ5AJbcw-1; Mon, 09 Mar 2026 16:40:24 -0400
X-MC-Unique: wQrir5jTNP-2CPuJ5AJbcw-1
X-Mimecast-MFC-AGG-ID: wQrir5jTNP-2CPuJ5AJbcw_1773088824
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd767c51efso305166885a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088823; x=1773693623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/ptOc9JgQFyYATJ+GXdVFz1EZ/RN/UI8fL0fT+Qc04=;
 b=oTbX8t4P1kX3gcNz6zC9RchNZ6T7ruhn+RZxoMtUvvxAzcUp3pcmCJdqGHs6L5ocD7
 rFiyCmVtE3LWExWQbFCsYbo5q+8a0QKPfUER9g4n6recRupj0q0oNIvk5Sf5kvP9OrkT
 CZhz65lN4d50DDODt+1biFTeZRTOdFqxuFYP6zNIXlDObOULcqyfSz2g8emhW1EI6lEd
 wnsugYx1FQncUPqYOPnMbNwII0/UQh+lqTrU/+wJP0ayCPygX+2Fu2AOX2HihrEdUvCB
 UXJa+q0Q+GzOi1tD0/7hU/hbVyKEYsh83XEinNIXS6db/9LZKQGAN4dUtRWzyJ+iRyp5
 pBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088823; x=1773693623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I/ptOc9JgQFyYATJ+GXdVFz1EZ/RN/UI8fL0fT+Qc04=;
 b=JjmXg0fvAeDeAdwvPzEwySP7+g5tk3EtklZbkQsjyxni9uQYRrpGy2MuW6JTOaR8sO
 KaDUSzjvyKuVU1nj938nKTkItQfgiE6uIK2nkLh8JIJ0A2BdQeIG03u7z2r11q9KgawC
 UXkV/1gKXqLs+XSaPeLw6ysiddPBPiNL2if4fDUX3am2QwMfgdCYHgN+y7UNaUtRVwJG
 kd1pk5B+22LIZfZkh7mFrj7vYQ+/S19qIHvlwWZtOJj9WFJ8C4JAbTFSv9fk8ubiQnfP
 /Jmg5XEjJZCn0Bet+ldoCspGNAa0bLDzrn/lgD+FiqSJwh7VL3TNgOt8iETQLHrR2Q8x
 sqdQ==
X-Gm-Message-State: AOJu0YxhRgq+4XmzpNNUif1rJFBpi/XtDsyldI8Cq8t5OyeVaNYpEDNg
 KM3GKBDS4+rMU2WirPzbtA8lYqM4A8gWxruMiyUAcz+bMT497ODyEm2qPh2UMSjWcQHKElYhED/
 HVvf/VQ+D8xouOg9wCEbZx9pLIfrGB49xRM9S7OA8Q1Tvwuj9x/KWT9tjf2RgdgCTJdqDUXsHpv
 YANBhyGshURgE20caHulbPQU+bysQbwkycKi8BoQ==
X-Gm-Gg: ATEYQzzQFKsoZ1DGz5rrwA5JKgRSOXyMgJXZGuMTXKLlJUAza/sKmwdaTheBTV0W1Uu
 7CkAN5Nd+ApUkcj1nHMgthWkR0BjOmhxAKF86nlZamCMFe3LnzOfgc7mozGueilIkUgcRzbNnut
 zF4kIHNVvPDfIOOf0WbDQnGnCGfpfcj2K/gCSSJHRd4Mz/VkAkoIX3KArQzAQ6xTmhsqm4nG5MK
 4LTOIEMKIUpxSahsKLQAul0XS1xcftw0VSMHya5SmeXX6mkOAKqjH6QRdoBB21bi/6qXnyVI1+2
 sEp0bxls9J1zYfHqLIsyIZI4s/CTHX/JPtYXIlPiL6bRyxzwc3MAH2EaO22M0tluzxDXcGwILa9
 cMbBe73VB+qxsAGnTb9p6/hZ5NbTMzJl6kwIlK2+e1qkUd1YrfJsJjHqp8uUTQ69EbUstj9vsoO
 vQ7NJO2Q==
X-Received: by 2002:a05:620a:8782:b0:8cd:7c98:87c2 with SMTP id
 af79cd13be357-8cd7c988bc0mr649007485a.60.1773088822896; 
 Mon, 09 Mar 2026 13:40:22 -0700 (PDT)
X-Received: by 2002:a05:620a:8782:b0:8cd:7c98:87c2 with SMTP id
 af79cd13be357-8cd7c988bc0mr649004585a.60.1773088822264; 
 Mon, 09 Mar 2026 13:40:22 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 05/18] memory: Remove memory_region_init_ram_nomigrate()
Date: Mon,  9 Mar 2026 16:39:54 -0400
Message-ID: <20260309204007.1709441-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert the last remaining use outside of memory.c in vga to use
memory_region_init_ram_flags_nomigrate() instead and inline and remove
the memory_region_init_ram_nomigrate() variant. This leaves
memory_region_init_ram_flags_nomigrate() as the only nomigrate variant
that is still needed at a few places.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/d913d0694b792bc3aed3fbb432e63d00c556de39.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/memory.rst                         |  8 +++----
 .../memory-region-housekeeping.cocci          | 19 ---------------
 include/system/memory.h                       | 23 -------------------
 hw/display/vga.c                              |  4 ++--
 system/memory.c                               | 13 ++---------
 5 files changed, 7 insertions(+), 60 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 0bb5acab21..9083b18f08 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -110,11 +110,9 @@ migrated:
 
 For most devices and boards this is the correct thing. If you
 have a special case where you need to manage the migration of
-the backing memory yourself, you can call the functions:
-
-- memory_region_init_ram_nomigrate()
-
-which only initialize the MemoryRegion and leave handling
+the backing memory yourself, you can call the function
+memory_region_init_ram_flags_nomigrate()
+which only initializes the MemoryRegion and leaves handling
 migration to the caller.
 
 The functions:
diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index e45703141a..b23647a3d8 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -26,15 +26,9 @@ symbol true;
 expression E1, E2, E3, E4, E5;
 position p;
 @@
-(
   memory_region_init_ram@p(E1, E2, E3, E4, E5);
   ...
   memory_region_set_readonly(E1, true);
-|
-  memory_region_init_ram_nomigrate@p(E1, E2, E3, E4, E5);
-  ...
-  memory_region_set_readonly(E1, true);
-)
 @script:python@
 p << possible_memory_region_init_rom.p;
 @@
@@ -52,23 +46,10 @@ expression ALIAS, E5, E6, E7, E8;
 -  memory_region_set_readonly(ALIAS, true);
 
 
-// Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
-// code sequences with use of the new memory_region_init_ram function.
-// Similarly for the _rom and _rom_device functions.
 // We don't try to replace sequences with a non-NULL owner, because
 // there are none in the tree that can be automatically converted
 // (and only a handful that can be manually converted).
 @@
-expression MR;
-expression NAME;
-expression SIZE;
-expression ERRP;
-@@
--memory_region_init_ram_nomigrate(MR, NULL, NAME, SIZE, ERRP);
-+memory_region_init_ram(MR, NULL, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-@@
 typedef DeviceState;
 identifier device_fn, dev, obj;
 expression E1, E2, E3, E4, E5;
diff --git a/include/system/memory.h b/include/system/memory.h
index 7117699b10..d4793a08a7 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1374,29 +1374,6 @@ void memory_region_init_io(MemoryRegion *mr,
                            const char *name,
                            uint64_t size);
 
-/**
- * memory_region_init_ram_nomigrate:  Initialize RAM memory region.  Accesses
- *                                    into the region will modify memory
- *                                    directly.
- *
- * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
- * @name: Region name, becomes part of RAMBlock name used in migration stream
- *        must be unique within any device
- * @size: size of the region.
- * @errp: pointer to Error*, to store an error if it happens.
- *
- * Note that this function does not do anything to cause the data in the
- * RAM memory region to be migrated; that is the responsibility of the caller.
- *
- * Return: true on success, else false setting @errp with error.
- */
-bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp);
-
 /**
  * memory_region_init_ram_flags_nomigrate:  Initialize RAM memory region.
  *                                          Accesses into the region will
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 59a65cbbff..ee7d97b5c2 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2235,8 +2235,8 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
         return false;
     }
 
-    memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
-                                     &local_err);
+    memory_region_init_ram_flags_nomigrate(&s->vram, obj, "vga.vram",
+                                           s->vram_size, 0, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return false;
diff --git a/system/memory.c b/system/memory.c
index 65042bd9fa..e15f931a8a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1579,16 +1579,6 @@ void memory_region_init_io(MemoryRegion *mr,
     memory_region_set_ops(mr, ops, opaque);
 }
 
-bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp)
-{
-    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                  size, 0, errp);
-}
-
 bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
                                             Object *owner,
                                             const char *name,
@@ -3695,7 +3685,8 @@ bool memory_region_init_ram(MemoryRegion *mr,
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
+                                                size, 0, errp)) {
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.50.1


