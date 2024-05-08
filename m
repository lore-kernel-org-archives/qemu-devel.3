Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495E7C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNM-0001QQ-EC; Wed, 08 May 2024 13:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMt-0000ZQ-6u
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMd-0007OW-SD
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:14 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59b097b202so2369166b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190357; x=1715795157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0D+uasY/TC43VRHTmSE3t0bnWfF6sxB20nwUatSjI7g=;
 b=Tqc4RXJi+azHFXIWMCtmjiNUJnAVlBSXuA8uhp5xS1k7WDpjKMWweRgknlxSwZKFQ7
 4G2faUxqS7rMjFeIn484ykRT8Zc4hLWROniIXsDftbFWP2bCR5b2mWGU9zn5IqkU7a9Q
 oVS3OzUs4ULuzUCBjc1vfWDxTRdLPgatSE5Cx12xJ3jA7uMQ+JXTgirpJd2pvcfZqq35
 vlcovXAw5OE2GuGYmjyY2beHyv5Qp01rpeKg2muZTzVannUxd8VKjfyCcKKMaE14HaYx
 0DBEocpMfbyPrT6o2/cnXMiV4FYJaCd+dWAEc8AKSFyLW3jIGHfQw5a4RqXtNuOKxu5F
 kFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190357; x=1715795157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0D+uasY/TC43VRHTmSE3t0bnWfF6sxB20nwUatSjI7g=;
 b=UbXLA1r9R2Y4nxaAeqkCR825QvDuZ2LXknSZmWGPOVloQQPU2Sh4/3w/y8VnE4lsY/
 3DQxVKzBUp2sLhHUsMI1mr+HcnjPFsmtu7SX3XQVRitZG4xY+Ta4W0EDmPSCzpw3LyWb
 6fDVL4bNQ4gS7VQRUw55JaUNpbRj3u4hQbVQep0ZdjyIeSih/7Xpml0/USsOjnjX0UtK
 EThfqGaf1PCeTmkoQlw0F0NEaoeBBYUo0YewaKKVEX3NQK9s/idAcUuLCXD8fdhpqOIJ
 q9J7Kbp1Y08VDOs1BgtoaIuqrALpXchPMyFNOMcGKDimKoEkHHjoURJBhLVK1wWOELGz
 vNdw==
X-Gm-Message-State: AOJu0Yys96Cs3ECTJ6Cswpr2/17BFim6ZPm5z7ezBkjcI9t2RjF2x+Z+
 uSaSEDp+lzULwcMtV/T0zzOpoq3GueYzxKqY9BOEm07WLi/mkdS04vR8UD9fuGXrnWqpc8oGUTk
 u
X-Google-Smtp-Source: AGHT+IFshR1nZ1RiDiVUtREG2ykge8D2iiqGrsM1RmxBCUaNT8vS48pHGmR5uDCRnBe/O2LsrNg+Uw==
X-Received: by 2002:a17:906:eb18:b0:a59:bde5:398 with SMTP id
 a640c23a62f3a-a59fb9211f4mr209170266b.14.1715190357584; 
 Wed, 08 May 2024 10:45:57 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 ze15-20020a170906ef8f00b00a59ae3efb03sm5453965ejb.3.2024.05.08.10.45.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/26] system/physmem: Per-AddressSpace bounce buffering
Date: Wed,  8 May 2024 19:44:52 +0200
Message-ID: <20240508174510.60470-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mattias Nissler <mnissler@rivosinc.com>

Instead of using a single global bounce buffer, give each AddressSpace
its own bounce buffer. The MapClient callback mechanism moves to
AddressSpace accordingly.

This is in preparation for generalizing bounce buffer handling further
to allow multiple bounce buffers, with a total allocation limit
configured per AddressSpace.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Message-ID: <20240507094210.300566-2-mnissler@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Split patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h | 19 +++++++++++
 system/memory.c       |  7 +++++
 system/physmem.c      | 73 ++++++++++++++++---------------------------
 3 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e1e0c5a3de..d417d7f363 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1112,6 +1112,19 @@ struct MemoryListener {
     QTAILQ_ENTRY(MemoryListener) link_as;
 };
 
+typedef struct AddressSpaceMapClient {
+    QEMUBH *bh;
+    QLIST_ENTRY(AddressSpaceMapClient) link;
+} AddressSpaceMapClient;
+
+typedef struct {
+    MemoryRegion *mr;
+    void *buffer;
+    hwaddr addr;
+    hwaddr len;
+    bool in_use;
+} BounceBuffer;
+
 /**
  * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
@@ -1129,6 +1142,12 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
+
+    /* Bounce buffer to use for this address space. */
+    BounceBuffer bounce;
+    /* List of callbacks to invoke when buffers free up */
+    QemuMutex map_client_list_lock;
+    QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
 };
 
 typedef struct AddressSpaceDispatch AddressSpaceDispatch;
diff --git a/system/memory.c b/system/memory.c
index 49f1cb2c38..642a449f8c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3174,6 +3174,9 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
+    as->bounce.in_use = false;
+    qemu_mutex_init(&as->map_client_list_lock);
+    QLIST_INIT(&as->map_client_list);
     as->name = g_strdup(name ? name : "anonymous");
     address_space_update_topology(as);
     address_space_update_ioeventfds(as);
@@ -3181,6 +3184,10 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
+    assert(!qatomic_read(&as->bounce.in_use));
+    assert(QLIST_EMPTY(&as->map_client_list));
+    qemu_mutex_destroy(&as->map_client_list_lock);
+
     assert(QTAILQ_EMPTY(&as->listeners));
 
     flatview_unref(as->current_map);
diff --git a/system/physmem.c b/system/physmem.c
index b76b3d2184..342b7a8fd4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3047,26 +3047,8 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
                                      NULL, len, FLUSH_CACHE);
 }
 
-typedef struct {
-    MemoryRegion *mr;
-    void *buffer;
-    hwaddr addr;
-    hwaddr len;
-    bool in_use;
-} BounceBuffer;
-
-static BounceBuffer bounce;
-
-typedef struct MapClient {
-    QEMUBH *bh;
-    QLIST_ENTRY(MapClient) link;
-} MapClient;
-
-QemuMutex map_client_list_lock;
-static QLIST_HEAD(, MapClient) map_client_list
-    = QLIST_HEAD_INITIALIZER(map_client_list);
-
-static void address_space_unregister_map_client_do(MapClient *client)
+static void
+address_space_unregister_map_client_do(AddressSpaceMapClient *client)
 {
     QLIST_REMOVE(client, link);
     g_free(client);
@@ -3074,10 +3056,10 @@ static void address_space_unregister_map_client_do(MapClient *client)
 
 static void address_space_notify_map_clients_locked(AddressSpace *as)
 {
-    MapClient *client;
+    AddressSpaceMapClient *client;
 
-    while (!QLIST_EMPTY(&map_client_list)) {
-        client = QLIST_FIRST(&map_client_list);
+    while (!QLIST_EMPTY(&as->map_client_list)) {
+        client = QLIST_FIRST(&as->map_client_list);
         qemu_bh_schedule(client->bh);
         address_space_unregister_map_client_do(client);
     }
@@ -3085,14 +3067,14 @@ static void address_space_notify_map_clients_locked(AddressSpace *as)
 
 void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
 {
-    MapClient *client = g_malloc(sizeof(*client));
+    AddressSpaceMapClient *client = g_malloc(sizeof(*client));
 
-    QEMU_LOCK_GUARD(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&as->map_client_list_lock);
     client->bh = bh;
-    QLIST_INSERT_HEAD(&map_client_list, client, link);
+    QLIST_INSERT_HEAD(&as->map_client_list, client, link);
     /* Write map_client_list before reading in_use.  */
     smp_mb();
-    if (!qatomic_read(&bounce.in_use)) {
+    if (!qatomic_read(&as->bounce.in_use)) {
         address_space_notify_map_clients_locked(as);
     }
 }
@@ -3110,15 +3092,14 @@ void cpu_exec_init_all(void)
     finalize_target_page_bits();
     io_mem_init();
     memory_map_init();
-    qemu_mutex_init(&map_client_list_lock);
 }
 
 void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh)
 {
-    MapClient *client;
+    AddressSpaceMapClient *client;
 
-    QEMU_LOCK_GUARD(&map_client_list_lock);
-    QLIST_FOREACH(client, &map_client_list, link) {
+    QEMU_LOCK_GUARD(&as->map_client_list_lock);
+    QLIST_FOREACH(client, &as->map_client_list, link) {
         if (client->bh == bh) {
             address_space_unregister_map_client_do(client);
             break;
@@ -3128,7 +3109,7 @@ void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh)
 
 static void address_space_notify_map_clients(AddressSpace *as)
 {
-    QEMU_LOCK_GUARD(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&as->map_client_list_lock);
     address_space_notify_map_clients_locked(as);
 }
 
@@ -3220,25 +3201,25 @@ void *address_space_map(AddressSpace *as,
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&bounce.in_use, true)) {
+        if (qatomic_xchg(&as->bounce.in_use, true)) {
             *plen = 0;
             return NULL;
         }
         /* Avoid unbounded allocations */
         l = MIN(l, TARGET_PAGE_SIZE);
-        bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        bounce.addr = addr;
-        bounce.len = l;
+        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
+        as->bounce.addr = addr;
+        as->bounce.len = l;
 
         memory_region_ref(mr);
-        bounce.mr = mr;
+        as->bounce.mr = mr;
         if (!is_write) {
             flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
-                               bounce.buffer, l);
+                          as->bounce.buffer, l);
         }
 
         *plen = l;
-        return bounce.buffer;
+        return as->bounce.buffer;
     }
 
 
@@ -3256,7 +3237,7 @@ void *address_space_map(AddressSpace *as,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len)
 {
-    if (buffer != bounce.buffer) {
+    if (buffer != as->bounce.buffer) {
         MemoryRegion *mr;
         ram_addr_t addr1;
 
@@ -3272,14 +3253,14 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         return;
     }
     if (is_write) {
-        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIED,
-                            bounce.buffer, access_len);
+        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
+                            as->bounce.buffer, access_len);
     }
-    qemu_vfree(bounce.buffer);
-    bounce.buffer = NULL;
-    memory_region_unref(bounce.mr);
+    qemu_vfree(as->bounce.buffer);
+    as->bounce.buffer = NULL;
+    memory_region_unref(as->bounce.mr);
     /* Clear in_use before reading map_client_list.  */
-    qatomic_set_mb(&bounce.in_use, false);
+    qatomic_set_mb(&as->bounce.in_use, false);
     address_space_notify_map_clients(as);
 }
 
-- 
2.41.0


