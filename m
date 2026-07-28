Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F30C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woYKu-0003LE-Ti; Mon, 27 Jul 2026 23:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woYKt-0003Kq-EY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woYKr-0005XZ-Tp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785208709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8sCFvVSDQ3//CPWi+9BWF+8046Ug5/Bej/Dzg+yFmRY=;
 b=H8WNOkd2gOpUBBZ4ZkAlOhjY5JvGSC04Y3ckqYoI/3UHG1gi8kqXhzdHN9d+9zj43EoR4K
 AIw5htLLifKe7A/g/dUL0fDGG+sUYxPdyx1vHCNz0jQGGXW/eBO6MLpJJltKNDTSczDX5N
 x1eKmqeSKb7lCEaapXKFfFvOxq345jU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-YUNT_ExDNgGMtjONsMzlIQ-1; Mon,
 27 Jul 2026 23:18:25 -0400
X-MC-Unique: YUNT_ExDNgGMtjONsMzlIQ-1
X-Mimecast-MFC-AGG-ID: YUNT_ExDNgGMtjONsMzlIQ_1785208703
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 621B91956079; Tue, 28 Jul 2026 03:18:23 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.50])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4059E5B2; Tue, 28 Jul 2026 03:18:13 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: [PATCH v5 3/3] system/memory: Make ram device region directly
 accessible
Date: Tue, 28 Jul 2026 13:17:31 +1000
Message-ID: <20260728031731.286666-4-gshan@redhat.com>
In-Reply-To: <20260728031731.286666-1-gshan@redhat.com>
References: <20260728031731.286666-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

This basically reverts 4a2e242bbb30 ("memory: Don't use memcpy for
ram_device regions") to make ram device region directly accessible
again. With this, the bounce buffer is bypassed in address_space_map()
when a ram device region is involved, potentially avoid to overrun
the (small) bounce buffer.

Reported-by: Julia Graham <jugraham@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Peter Xu <peterx@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/memory.h | 11 ++---------
 system/memory.c         | 41 +----------------------------------------
 system/trace-events     |  2 --
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 2965d922de..dbc17741ac 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2718,15 +2718,8 @@ static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
     if (memory_region_is_romd(mr)) {
         return true;
     }
-    if (!memory_region_is_ram(mr)) {
-        return false;
-    }
-    /*
-     * RAM DEVICE regions can be accessed directly using memcpy, but it might
-     * be MMIO and access using mempy can be wrong (e.g., using instructions not
-     * intended for MMIO access). So we treat this as IO.
-     */
-    return !memory_region_is_ram_device(mr);
+
+    return memory_region_is_ram(mr);
 }
 
 static inline bool memory_access_is_direct(const MemoryRegion *mr,
diff --git a/system/memory.c b/system/memory.c
index 5fc36708ec..da710bbade 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1364,43 +1364,6 @@ const MemoryRegionOps unassigned_mem_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static uint64_t memory_region_ram_device_read(void *opaque,
-                                              hwaddr addr, unsigned size)
-{
-    MemoryRegion *mr = opaque;
-    uint64_t data = ldn_he_p(mr->ram_block->host + addr, size);
-
-    trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
-
-    return data;
-}
-
-static void memory_region_ram_device_write(void *opaque, hwaddr addr,
-                                           uint64_t data, unsigned size)
-{
-    MemoryRegion *mr = opaque;
-
-    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
-
-    stn_he_p(mr->ram_block->host + addr, size, data);
-}
-
-static const MemoryRegionOps ram_device_mem_ops = {
-    .read = memory_region_ram_device_read,
-    .write = memory_region_ram_device_write,
-    .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = true,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = true,
-    },
-};
-
 bool memory_region_access_valid(MemoryRegion *mr,
                                 hwaddr addr,
                                 unsigned size,
@@ -1692,10 +1655,8 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
 {
-    memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
-    mr->ram = true;
+    memory_region_init_ram_ptr(mr, owner, name, size, ptr);
     mr->ram_device = true;
-    memory_region_set_ram_ptr(mr, size, ptr);
 }
 
 void memory_region_init_alias(MemoryRegion *mr, Object *owner,
diff --git a/system/trace-events b/system/trace-events
index 51b4a4679a..d483b31419 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -20,8 +20,6 @@ memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, u
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
 memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_sync_dirty(const char *mr, const char *listener, int global) "mr '%s' listener '%s' synced (global=%d)"
 flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
-- 
2.55.0


