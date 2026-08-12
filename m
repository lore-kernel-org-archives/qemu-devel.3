Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32D1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAgB-0007Zk-Nz; Wed, 12 Aug 2026 11:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAg9-0007Vl-CY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAg7-00079k-Cg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoqA1ZaTEbS0pqgotOLPlk7qgStthSVvyDWDGPx2uz8=;
 b=WF4dDNvaqyzNKi9/p/3pg1qmZbJKnwfxECKfsblY/TMVXCqDW5JDaeCB68dwLxRhRB0ZDT
 JfxndkP96MazW2VDABzmEFBsKDPzkJ55yURLPIHO5fq7fTqFmIQx+d33BjN2lfVR3I/YRF
 C2oif+fKfrWoz+1tg3vq2B/Lg6xqWjw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-DvAWVUPUNfSFfNnCyE2yQg-1; Wed, 12 Aug 2026 11:15:36 -0400
X-MC-Unique: DvAWVUPUNfSFfNnCyE2yQg-1
X-Mimecast-MFC-AGG-ID: DvAWVUPUNfSFfNnCyE2yQg_1786547736
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c12e43b98so13034551cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547736; x=1787152536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VoqA1ZaTEbS0pqgotOLPlk7qgStthSVvyDWDGPx2uz8=;
 b=tD3MNHnKeP5qxrjOhAMuHijUMd82/kCUJpkWgjy7vlcYk0bv03lJKaugL6q9O0D5xo
 v2OhR1xw43ENuhWdbo+TZwmLvg/WhCiQJuhp9ItZMQn7VPU8s79J/lQFqNackeJ06OvA
 KquMNz2sglzBlTeX7QaEp7/1bbPXqU6xMJcsrIA/fLUZdE7c5FAsAXcn6Z/JTiPujx31
 Pc9DUMfazxN7uM+4JfjWlyCh2zIvgL85pZM/nd37AFNhy5mxeyPcSV9sdTwcfBjzMJNl
 Z+whWKhjojLhk85LdF/RvGY1VoJqz97p6gnvg1Wwi/FmAm5d5V8SA2MSmLJyMTyY11Qw
 +bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547736; x=1787152536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VoqA1ZaTEbS0pqgotOLPlk7qgStthSVvyDWDGPx2uz8=;
 b=SgLqXn9h/4PNsKs8OWzQHIit6kE3FfQdlU3JuwMC7yub6RncRYmFiXnUV+HkRLeHOC
 MSNqdLYSM/sXQlig5+kkkSHiciWEuryBelAYMZsOe5ZC+rX6YPflbOakA5bYh8j4sgY/
 8LyDa2WyWx0FO81qnUJBO9i6uW6UJPfbKuqG3iOFrSneSbsIQ8UekE7MiF7RL5/OlPEv
 T1V+0oio4+X3+TZuWbF7zOgChHvEexNwsy05SZ3bsHbKWoXBTnk/Omn+vXpKL0OcIhUk
 c+7ISjigF/AiTjvs87WveX6BXj5mw0qFIoKrOAdcP1l4AJjkk/upFhrI5EtQBLTzzlUy
 0hEA==
X-Gm-Message-State: AOJu0Yyv8H0xz604lJInPFcmoAIwy/yPSsoNDFbS61E35ZGsc3vKUKFb
 7RTQOIY9gFETYsliRPCA4HGxHFErnztN1umD/WZIxxxZHHJfrzI+Lgaax1NJXLe23pYWj9AvWo6
 5Tow19ZbxukpNM4yIRP9xA76qsA6iIdMO4ye7EM7oV6B4jKKRoJsDhLtbU+k/vWw9nEhm1rtu6P
 DFz9PeA4qGQG3FwGd3VH8XcuobilLjOoKMx4ttcg==
X-Gm-Gg: AR+sD12iOjiQW0Odd2LKlXiJKv0MqVFSPSDpfl1hi2geBHyoPmQ2TWBqd4ARu+Z4w+r
 j1lyxLpBXdiJx8GtU1A+os0aLtcZ4B1CR3mkwqZuxmy2xkxu7ycUxKLAMTOremY5WEiK6Sxvm6W
 2EdR38S2oiDo4EfKMMnUhO3WV2ODqOEbdD2t5DeHZiyy0mD/6rkrYYwPqEGj9PcU2JHmmJ6RtcW
 da0+hAXNnDkvWxhtNhK3IU47z5auwIxXre4N5z3X1vtA8xTQor+7kENp1LpyNeqZQU3BJk095Hb
 TzaDZC1FsMI5BnjNc2zO7Kc2jvrXOVSVIVT+cTDU4PyssOi74ebPF/rx5Sq0BUABaw==
X-Received: by 2002:ac8:5a84:0:b0:51c:1e69:bcc9 with SMTP id
 d75a77b69052e-52d6471a403mr52750481cf.12.1786547735606; 
 Wed, 12 Aug 2026 08:15:35 -0700 (PDT)
X-Received: by 2002:ac8:5a84:0:b0:51c:1e69:bcc9 with SMTP id
 d75a77b69052e-52d6471a403mr52749101cf.12.1786547734804; 
 Wed, 12 Aug 2026 08:15:34 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Julia Graham <jugraham@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/10] system/memory: Make ram device region directly accessible
Date: Wed, 12 Aug 2026 11:14:38 -0400
Message-ID: <20260812151444.2611689-6-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Gavin Shan <gshan@redhat.com>

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
Link: https://lore.kernel.org/r/20260728031731.286666-4-gshan@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 11 ++---------
 system/memory.c         | 41 +----------------------------------------
 system/trace-events     |  2 --
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 4de5bf2577..1dc761058f 100644
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
2.54.0


