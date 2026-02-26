Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1CEFCE086
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbvQ-00037l-3E; Thu, 26 Feb 2026 09:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbv7-0002iO-Gc
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbv4-0006Kr-1l
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772114445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVM51KZ1grB02Ebp/ONla2ZoUr/rU2xVZe/nndet3tw=;
 b=aZovdSzz8+7kjVEeJxrTR5TZFJf9B0Y44OO8/6rba89PRRUS91kTDwVbsfYVS096G7SX51
 7x2tPNUaa2dOHOiM3aifdDfIib5gCyTKj94pmUwMePk/W7uXEBx9b9oeuMgTfmIzWVX4u/
 0yS4eYnESUMC43dNQC/cKdw5Qu/GxJE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-R2FHYCEiOXuYFKCgyd006g-1; Thu,
 26 Feb 2026 09:00:41 -0500
X-MC-Unique: R2FHYCEiOXuYFKCgyd006g-1
X-Mimecast-MFC-AGG-ID: R2FHYCEiOXuYFKCgyd006g_1772114440
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B88D318004AD; Thu, 26 Feb 2026 14:00:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 300F11956053; Thu, 26 Feb 2026 14:00:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 10/15] virtio-mem: remove replay_populated/replay_discarded
 implementation
Date: Thu, 26 Feb 2026 14:59:55 +0100
Message-ID: <20260226140001.3622334-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The replay iteration logic has been moved into the RamDiscardManager,
which now iterates at source granularity using is_populated(). The
source-level replay_populated/replay_discarded methods and their
helpers are no longer called.

Remove the now-dead replay methods, the VirtIOMEMReplayData struct,
the virtio_mem_for_each_plugged/unplugged_section() helpers (only used
by the replay methods), and the virtio_mem_section_cb typedef.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/virtio-mem.c | 112 -----------------------------------------
 1 file changed, 112 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ec165503205..2b67b2882d2 100644
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
2.53.0


