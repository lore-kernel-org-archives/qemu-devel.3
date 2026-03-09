Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943FFFCA187
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPM-0004nF-Vu; Mon, 09 Mar 2026 16:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0004fc-IY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP1-0007hz-MF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6yzzY9kJRmx2RhAp5ydNbm/6HISn+r/lJ0rKal3hJQ=;
 b=G11z/amccIm/xWuU5N+iiBZawwdhZe040DBI+78M0MVpaF6wU2muCQ5hnjVpy9cGIB9gcu
 DFNR8yM2knm1lRrVlgrAbxO8sMxG5uMxj6+u2FiWRP6tOS36xydPWBbPpVJ11I7AoEFtLY
 6UJrb8fM42cPodB+IBgliva044vfvVo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-fkRR8UCBPK-iCodWbliuGg-1; Mon, 09 Mar 2026 16:40:28 -0400
X-MC-Unique: fkRR8UCBPK-iCodWbliuGg-1
X-Mimecast-MFC-AGG-ID: fkRR8UCBPK-iCodWbliuGg_1773088827
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd900cd3a7so387300785a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088827; x=1773693627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6yzzY9kJRmx2RhAp5ydNbm/6HISn+r/lJ0rKal3hJQ=;
 b=HOkV3J55z6jopYjuByqqIh6XEiR0tByFqqWAmgr9yfhqyyYtSv5xUpPkgPjsG/ppW1
 Tyd0gaqDZgXFd25a745I+cdOl72ZBWLbw+hz53LpiyOzTAL4VGEv3YtYkyc+59WE/FQz
 6e4GPS0hAB+AXzSHaBJehBcq0DjNHQIgDmn7VQzFSxKtqMRJC3RY2dT71ZyMS77rifV5
 JBhbcgUr6syOeh1/1kZ4J7E3+uOLMQWYktZjn34yCsufA++KXFjjHfdKdhhkXcr9bl+l
 l89ijRBEVG/yM+dNpm3D9jFKxY2yyUQXa8m8LMFcKzmRsDufMJ4rqks7+O3l4KEl6PdA
 gKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088827; x=1773693627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n6yzzY9kJRmx2RhAp5ydNbm/6HISn+r/lJ0rKal3hJQ=;
 b=kn78D6p8mLAiuMrP7LJB4VEVRupgMk6m3Zhg4Ri7ROuXhoB+lUp2KSQuM4bWEqKtuS
 a+5FEiWOk26YjuT3Fqstv3YnTgWeZL3zUeu4n0AsXnIpNLJkDCyv0SQ7/Qax/2S/wKCx
 k9JXuUAfA83FzIQ+SD3tq3KfGFO3EOG0BBrl4c7Z2gPHob2v8yJgpafb7Hrtu6+1YLsi
 KECEqylqNkPnxrvGBovo9L535QHavTlngzdDkJf+Z761WQnrjqoEaYzCvcInRRYXXJSl
 fHxCxJB/FPTRhZGv02znEUnr/OUcHvz6C5Y9jNrsE1mUIl6rz3+usp1gCy2VpXMxvDbP
 LMwg==
X-Gm-Message-State: AOJu0YzKXBM20KNMYhZR0gT7YCBX1YKrP8ztdVkQwO7Qh30Sxp3bt2e/
 RGHqr9NfcMTwQX/zSgGxKuajrCORdN4+0vgpxgeMylU9twtSvyB2tv7S4NPbL0U3tmjW5+CQ1kE
 p1mTd/bCYhMUYVQk8HTIHFtdEkHNsrm1znpsVWRRVkV+oEO77Q+qIIbLkQoMZbiFd1s8Vfy7U61
 GvAZO7uWXamEodvxDZzHiInz9BlEE8d6OwavLvBw==
X-Gm-Gg: ATEYQzyntWHitZOUvFuPvJJ6jSFH4ADQ0SW9zRoBcf1ePLEaPvgt2u8Vy6VPCM7CLcw
 bZ+TbB1RHXeyG6yTlBNl+SWZesK9M6b5Z4XpN9Kzti4mZranXeFb0COEYWwLKvmvCEqJ6TbjKEa
 gjTau/kYG6jTJGOZoCN7cTqpCU6108cOAHm1w/5TldlTTx3ITDVsva0teJqy6dUElnDLTf24UAa
 3UrvNBw6yhJvf4Q70INBc7Z1kR0zK0bxsyzkRftvanuxhlvvDU++13CB38mmcsLDyeYPfyN82Jj
 CAY+BZKWTlO2mS/k8ez9DB5hFEZzkgcZZfvoqwkdYnAxteW0Mtsxt1cj+kU7pw5s5WAyt9Gx9Hz
 gbw4SL9JPU2zZc3eSCmOi/LL/dEQ/DRQ2/iW8MZo0qoFebDOl07m6n0gD/2e2TGvqxd0x5QFbw0
 gpFCHfMA==
X-Received: by 2002:a05:620a:25c7:b0:8b2:e986:2707 with SMTP id
 af79cd13be357-8cd6d44161amr1628776385a.45.1773088827094; 
 Mon, 09 Mar 2026 13:40:27 -0700 (PDT)
X-Received: by 2002:a05:620a:25c7:b0:8b2:e986:2707 with SMTP id
 af79cd13be357-8cd6d44161amr1628771385a.45.1773088826352; 
 Mon, 09 Mar 2026 13:40:26 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 08/18] memory: Factor out common ram region initialization
Date: Mon,  9 Mar 2026 16:39:57 -0400
Message-ID: <20260309204007.1709441-9-peterx@redhat.com>
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

Introduce internal helper function to remove duplicated code from
different memory_region_init_*ram functions. Remove local err and
error_propagate and pass errp and check return value instead.
Also shorten some function prototypes while at it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/d6db01c283149b46023ffeb9c5b368c67f6acc8d.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 167 ++++++++++++++++++------------------------------
 1 file changed, 61 insertions(+), 106 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 9a12224555..2cda814bd6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1568,39 +1568,39 @@ static void memory_region_set_ops(MemoryRegion *mr,
     mr->terminates = true;
 }
 
-void memory_region_init_io(MemoryRegion *mr,
-                           Object *owner,
-                           const MemoryRegionOps *ops,
-                           void *opaque,
-                           const char *name,
-                           uint64_t size)
+void memory_region_init_io(MemoryRegion *mr, Object *owner,
+                           const MemoryRegionOps *ops, void *opaque,
+                           const char *name, uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
 }
 
-bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
-                                            Object *owner,
-                                            const char *name,
-                                            uint64_t size,
-                                            uint32_t ram_flags,
-                                            Error **errp)
+static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
 {
-    Error *err = NULL;
-    memory_region_init(mr, owner, name, size);
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
-    if (err) {
+    mr->ram_block = rb;
+    if (!rb) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
         return false;
     }
     return true;
 }
 
+bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
+                                            const char *name, uint64_t size,
+                                            uint32_t ram_flags, Error **errp)
+{
+    RAMBlock *rb;
+
+    memory_region_init(mr, owner, name, size);
+    rb = qemu_ram_alloc(size, ram_flags, mr, errp);
+    return memory_region_set_ram_block(mr, rb);
+}
+
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1611,116 +1611,74 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        void *host),
                                        Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb;
+
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
-                                              mr, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
+    rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
+    return memory_region_set_ram_block(mr, rb);
 }
 
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
-bool memory_region_init_ram_from_file(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      uint64_t align,
-                                      uint32_t ram_flags,
-                                      const char *path,
-                                      ram_addr_t offset,
+bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
+                                      const char *name, uint64_t size,
+                                      uint64_t align, uint32_t ram_flags,
+                                      const char *path, ram_addr_t offset,
                                       Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb;
+
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
     mr->align = align;
-    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
-                                             offset, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
+    rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, errp);
+    return memory_region_set_ram_block(mr, rb);
 }
 
-bool memory_region_init_ram_from_fd(MemoryRegion *mr,
-                                    Object *owner,
-                                    const char *name,
-                                    uint64_t size,
-                                    uint32_t ram_flags,
-                                    int fd,
-                                    ram_addr_t offset,
-                                    Error **errp)
+bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
+                                    const char *name, uint64_t size,
+                                    uint32_t ram_flags, int fd,
+                                    ram_addr_t offset, Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb;
+
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
-                                           offset, false, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
+    rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
+                                false, errp);
+    return memory_region_set_ram_block(mr, rb);
 }
 #endif
 
-void memory_region_init_ram_ptr(MemoryRegion *mr,
-                                Object *owner,
-                                const char *name,
-                                uint64_t size,
+void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
+                                const char *name, uint64_t size,
                                 void *ptr)
 {
-    memory_region_init(mr, owner, name, size);
-    mr->ram = true;
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
+    RAMBlock *rb;
 
+    memory_region_init(mr, owner, name, size);
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    memory_region_set_ram_block(mr, rb);
 }
 
-void memory_region_init_ram_device_ptr(MemoryRegion *mr,
-                                       Object *owner,
-                                       const char *name,
-                                       uint64_t size,
+void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
+                                       const char *name, uint64_t size,
                                        void *ptr)
 {
+    RAMBlock *rb;
+
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
-    mr->ram = true;
     mr->ram_device = true;
-    mr->destructor = memory_region_destructor_ram;
-
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    memory_region_set_ram_block(mr, rb);
 }
 
-void memory_region_init_alias(MemoryRegion *mr,
-                              Object *owner,
-                              const char *name,
-                              MemoryRegion *orig,
-                              hwaddr offset,
-                              uint64_t size)
+void memory_region_init_alias(MemoryRegion *mr, Object *owner,
+                              const char *name, MemoryRegion *orig,
+                              hwaddr offset, uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
     mr->alias = orig;
@@ -3732,21 +3690,18 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
                                    const char *name, uint64_t size,
                                    Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb;
 
     assert(ops);
     memory_region_init_io(mr, owner, ops, opaque, name, size);
-    mr->rom_device = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
+    rb = qemu_ram_alloc(size, 0, mr, errp);
+    if (memory_region_set_ram_block(mr, rb)) {
+        mr->ram = false;
+        mr->rom_device = true;
+        memory_region_register_ram(mr, owner);
+        return true;
     }
-    memory_region_register_ram(mr, owner);
-    return true;
+    return false;
 }
 
 /*
-- 
2.50.1


