Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A96ACDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YZ-0004Z1-Sr; Tue, 23 Jun 2026 08:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YY-0004YC-E9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YU-00071T-Hy
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMugfKkzQoQqUMR/78UE4ehQnL4nusRrCbVz2kVTbW0=;
 b=eOD5ufHUCtbWSspLIkG0QcXDdANNtWht1GYVGgCqJf+bU4qY+HJlZIs3nLR1gFzUkk0oM8
 0ICI2Q4YFgydxRZlVL36fE1LbwCKH7mh7bv8s+vjhq9tbH5F3gdROqjLOVUPV73rOONhgo
 ZZb+BlpmCoRBC58XLs2Ssbw+p5gjnRY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-fMc0wzIUNgitub8kt6A8ww-1; Tue, 23 Jun 2026 08:48:38 -0400
X-MC-Unique: fMc0wzIUNgitub8kt6A8ww-1
X-Mimecast-MFC-AGG-ID: fMc0wzIUNgitub8kt6A8ww_1782218918
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a08feb103so63580171cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218918; x=1782823718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMugfKkzQoQqUMR/78UE4ehQnL4nusRrCbVz2kVTbW0=;
 b=ZXLXFATwFKi+7wNdtK7ZLfoxozz37g0ywLH18Pq6jiuLFcvKfppiszpxMUGOxBvCY0
 C3xU9tMQ/7VwY9O88HUKn3fkaI5sYgECYARyj6R8vC0BWtCXEZgGNpf9GRngzx74V5TB
 WVV3IXjYPNFzoK5wBhgebfDqbOlbTj+MnGcRDGDNmqtRQdjb/hy1LTd6WJTDBDRiWFdR
 fLc0d2i/0OwZ1T6QTMBVeS6lC1RzXEVh1UYSpi3p2U1kfYcWcCbEnvUG78RxuTFpCAtn
 jctY8xVQHVlm2KxYm/HBMW9aN/NzhDFDpmlORpqmvpo4Dm31c7QTi4dhWg81Ldte7kWY
 /C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218918; x=1782823718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GMugfKkzQoQqUMR/78UE4ehQnL4nusRrCbVz2kVTbW0=;
 b=iLKUPmnDbzRrmd9Hf1bhKIxaBbRnll9QwjlBWffI8EjHDgslGmPXiozck+8Fub+h0J
 xtXwZDYpLY2ywl6CbMqJtT6RSAMzjmGZiOQTpKVt2qNZ49KaStfvW4jI7S59jWFkf0Xz
 un6BddmnKRtswL/0CKEt196b2/JiQ2Hv2L4vXoDO7TbL55fS6LeVgOus9Chma2u4IAjX
 OrIG9rvy6PbtxQ3wJKxL2Kg3JSuUNl1Ta9ITLPntINlp55la4kAcJeIhg6CA2HAANThd
 tScLaQ13T+rqokEzHMdnwabSIE9EW8krzmaMdYZyLT8fX8qTsbhYD7dMcxxVfDZC+cYK
 654A==
X-Gm-Message-State: AOJu0YwsyFkV676YQBy9esDDPbf/9rzulvFkBzqYaYGBJsE6iKdIw2/T
 MIkxBgI5hsS8CtSSdH1D3rxc9fH//iUtSVRC2dK0u3x9Q4vN/jpdT4HGI0SPH1km/7x4xl8xltR
 PPeMNRkrblA2Ma1J+8VMt+TIMfFebY1KMPrYotTiVNeCP7i12CXZn6uEnlEB71AYB+VC154W6nm
 6RI7LZZC060fUkJPTscun786o8zRFQCV553gSqaw==
X-Gm-Gg: AfdE7ckg0j+J9KpH/Wz+TwShs6gb/gNSB5Rh8Z2V87sUeMYSbS6XmLz6KRtjFMbxpVY
 d+M38pAnromBZJQPwODsgI7ErEtEleQsew6ISjcZDRQR9H1EfxdoQ1cP2W0JWuGNHqLBqio7oPk
 RWrOBkmtt8NedDDjkiSuvcDgyeOlkINRYN8nMw/VRvM57Dr4Xu44aW8hxeA12BvFNjR2nkRlVUM
 80A06P8zksbm16sn3H+C1vvkXjoBFmwqYoR1kJHMGzqqBDxWzp0bAs0FsF4hOJxEHIE2XLTq7r8
 fXEfBxamR6OSKtkMVUKh9lhO5P0BrGzqJZpeUMjmsTTQ0IDwp6pPBSZKwKp1Sph3iDK8vJ9F9t0
 a/Q==
X-Received: by 2002:ac8:5d0e:0:b0:517:6351:b401 with SMTP id
 d75a77b69052e-519e4dd3a8bmr276013191cf.44.1782218917826; 
 Tue, 23 Jun 2026 05:48:37 -0700 (PDT)
X-Received: by 2002:ac8:5d0e:0:b0:517:6351:b401 with SMTP id
 d75a77b69052e-519e4dd3a8bmr276012481cf.44.1782218917019; 
 Tue, 23 Jun 2026 05:48:37 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 12/18] virtio-mem: remove replay_populated/replay_discarded
 implementation
Date: Tue, 23 Jun 2026 08:47:53 -0400
Message-ID: <20260623124759.125399-13-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The replay iteration logic has been moved into the RamDiscardManager,
which now iterates at source granularity using is_populated(). The
source-level replay_populated/replay_discarded methods and their
helpers are no longer called.

Remove the now-dead replay methods, the VirtIOMEMReplayData struct,
the virtio_mem_for_each_plugged/unplugged_section() helpers (only used
by the replay methods), and the virtio_mem_section_cb typedef.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260604-rdm5-v5-5-5768e6a0943d@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/virtio-mem.c | 112 -----------------------------------------
 1 file changed, 112 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ec16550320..2b67b2882d 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -259,72 +259,6 @@ static int virtio_mem_for_each_plugged_range(VirtIOMEM *vmem, void *arg,
     return ret;
 }
 
-typedef int (*virtio_mem_section_cb)(MemoryRegionSection *s, void *arg);
-
-static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
-                                               const MemoryRegionSection *s,
-                                               void *arg,
-                                               virtio_mem_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    int ret = 0;
-
-    first_bit = s->offset_within_region / vmem->block_size;
-    first_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size, first_bit);
-    while (first_bit < vmem->bitmap_size) {
-        MemoryRegionSection tmp = *s;
-
-        offset = first_bit * vmem->block_size;
-        last_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size,
-                                      first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * vmem->block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-        ret = cb(&tmp, arg);
-        if (ret) {
-            break;
-        }
-        first_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size,
-                                  last_bit + 2);
-    }
-    return ret;
-}
-
-static int virtio_mem_for_each_unplugged_section(const VirtIOMEM *vmem,
-                                                 const MemoryRegionSection *s,
-                                                 void *arg,
-                                                 virtio_mem_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    int ret = 0;
-
-    first_bit = s->offset_within_region / vmem->block_size;
-    first_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size, first_bit);
-    while (first_bit < vmem->bitmap_size) {
-        MemoryRegionSection tmp = *s;
-
-        offset = first_bit * vmem->block_size;
-        last_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size,
-                                 first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * vmem->block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-        ret = cb(&tmp, arg);
-        if (ret) {
-            break;
-        }
-        first_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size,
-                                       last_bit + 2);
-    }
-    return ret;
-}
-
 static void virtio_mem_notify_unplug(VirtIOMEM *vmem, uint64_t offset,
                                      uint64_t size)
 {
@@ -1667,50 +1601,6 @@ static bool virtio_mem_rds_is_populated(const RamDiscardSource *rds,
     return virtio_mem_is_range_plugged(vmem, start_gpa, end_gpa - start_gpa);
 }
 
-struct VirtIOMEMReplayData {
-    ReplayRamDiscardState fn;
-    void *opaque;
-};
-
-static int virtio_mem_rds_replay_cb(MemoryRegionSection *s, void *arg)
-{
-    struct VirtIOMEMReplayData *data = arg;
-
-    return data->fn(s, data->opaque);
-}
-
-static int virtio_mem_rds_replay_populated(const RamDiscardSource *rds,
-                                           const MemoryRegionSection *s,
-                                           ReplayRamDiscardState replay_fn,
-                                           void *opaque)
-{
-    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
-    struct VirtIOMEMReplayData data = {
-        .fn = replay_fn,
-        .opaque = opaque,
-    };
-
-    g_assert(s->mr == &vmem->memdev->mr);
-    return virtio_mem_for_each_plugged_section(vmem, s, &data,
-                                               virtio_mem_rds_replay_cb);
-}
-
-static int virtio_mem_rds_replay_discarded(const RamDiscardSource *rds,
-                                           const MemoryRegionSection *s,
-                                           ReplayRamDiscardState replay_fn,
-                                           void *opaque)
-{
-    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
-    struct VirtIOMEMReplayData data = {
-        .fn = replay_fn,
-        .opaque = opaque,
-    };
-
-    g_assert(s->mr == &vmem->memdev->mr);
-    return virtio_mem_for_each_unplugged_section(vmem, s, &data,
-                                                 virtio_mem_rds_replay_cb);
-}
-
 static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
 {
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_OFF) {
@@ -1766,8 +1656,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
 
     rdsc->get_min_granularity = virtio_mem_rds_get_min_granularity;
     rdsc->is_populated = virtio_mem_rds_is_populated;
-    rdsc->replay_populated = virtio_mem_rds_replay_populated;
-    rdsc->replay_discarded = virtio_mem_rds_replay_discarded;
 }
 
 static const TypeInfo virtio_mem_info = {
-- 
2.54.0


