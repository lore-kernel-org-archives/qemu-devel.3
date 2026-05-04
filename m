Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154B6FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsSC-0001TM-QI; Mon, 04 May 2026 08:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsS4-00015t-Ou
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsS2-0006j4-CH
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUBA0s7szbp/er2TRFMEykM5Ea4rCVBQ3zpJubH8msk=;
 b=QU9t2ubJubTKcSNJbUgu0J8r6g7XS4wcz8VenJ9bDLUVOdmFR1aAFQV1sStzz+rEtJeqHr
 ljEM3awoZvJoGVjaIVRC7I0WvWqJVxmdZhVSTEu3dYRdl/5z+mIUP5USS0oqiiWI3LRnJa
 7YB32+94zU9bRV+xP9cOQhE3C7ZldZE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-0F1lTv4aMqu7nZfImvYFag-1; Mon,
 04 May 2026 08:31:04 -0400
X-MC-Unique: 0F1lTv4aMqu7nZfImvYFag-1
X-Mimecast-MFC-AGG-ID: 0F1lTv4aMqu7nZfImvYFag_1777897863
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7DCE19560B3
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:31:03 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C1F9180067F; Mon,  4 May 2026 12:30:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:12 +0400
Subject: [PATCH v4 06/13] system/ram-discard-manager: drop replay from
 source interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-6-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10135;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LagjNkx5jJwTlNYlGl9d5LXUz8QuOg7ey/7ZJZChstY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFZE6pRQnCUTs3vx+aj1B7XtOchwUwMBwxkX
 pQxpQUiu+SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWQAKCRDa6OEJdZac
 5QgvD/wLYX95ivfcc+aUtsMqH/gqtK0maOxgmSWOFTBjX3D1kuIbvocJnWlFP109spY1onp0FLV
 lRoSPZmEMC6qdaaaKrUblIPnL/6qhQdAJcr7ygti3uXx6VpJ3iSrRJCVxmEycpIL51mECj54EAr
 wVqTNxa9T8G2K1VZnqZrHxkDThvPKY9C//nIIOqYZApg/AU3XAIr+fKehy+UJVIdlwFRJE3VriU
 42d2gVFlmlV3cE4MJjU70392cGSW7Yb4dMgYV61HIrBdfczyl2lWcpK9tSMA2uL0BN/DukJn0wp
 Dn8IqfljjqcCcrm1Jw9GKGkfdYXn3zFRNWfgibgqgJ6+PipoW5l/CN3PNl62qazdE10Q6i/XYPl
 tE3llTyCoba74P09fL8K7T/7hBGjZImwmPRb6tHh/7lzxJIA+7xwBjCLdB4xyiPlT7rWOPig5/B
 Df+j0uc01RvD7ho5Vq4eglx2KnFNCh2ldUFzsSLPMs55yC0JnwaN2Fn9rWbBYcgLQsA31Dm3rbj
 0CAwZGl2dDjkxLAqpOUwMAYg9mWGsUS6A4EK4g5PgYuiwTqH10xzWtq0QiTdnVqmJZitkQ/j2al
 gzCjRNV0Xa5RrSId0b/0Kv1PAS9JLTo4yl+r6G9jxhLDcpCwkHncsyuHcjB72Kkg+QOemkBbsGX
 +VEgfpwNy7NqwCw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Remove replay_populated and replay_discarded from RamDiscardSourceClass
now that the RamDiscardManager handles replay iteration internally via
is_populated.

Remove the now-dead replay methods, helpers, and
for_each_populated/discarded_section() from ram-block-attributes, which
was the last source still carrying this code.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/ram-discard-manager.h |  52 +++-----------
 system/ram-block-attributes.c        | 130 -----------------------------------
 2 files changed, 10 insertions(+), 172 deletions(-)

diff --git a/include/system/ram-discard-manager.h b/include/system/ram-discard-manager.h
index b188e09a30f..b5dbcb4a82d 100644
--- a/include/system/ram-discard-manager.h
+++ b/include/system/ram-discard-manager.h
@@ -77,8 +77,8 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
 /**
  * typedef ReplayRamDiscardState:
  *
- * The callback handler for #RamDiscardSourceClass.replay_populated/
- * #RamDiscardSourceClass.replay_discarded to invoke on populated/discarded
+ * The callback handler used by ram_discard_manager_replay_populated() and
+ * ram_discard_manager_replay_discarded() to invoke on populated/discarded
  * parts.
  *
  * @section: the #MemoryRegionSection of populated/discarded part
@@ -134,42 +134,6 @@ struct RamDiscardSourceClass {
      */
     bool (*is_populated)(const RamDiscardSource *rds,
                          const MemoryRegionSection *section);
-
-    /**
-     * @replay_populated:
-     *
-     * Call the #ReplayRamDiscardState callback for all populated parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * In case any call fails, no further calls are made.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_populated)(const RamDiscardSource *rds,
-                            const MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
-
-    /**
-     * @replay_discarded:
-     *
-     * Call the #ReplayRamDiscardState callback for all discarded parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_discarded)(const RamDiscardSource *rds,
-                            const MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
 };
 
 /**
@@ -226,8 +190,10 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_populated:
  *
- * A wrapper to call the #RamDiscardSourceClass.replay_populated callback
- * of the #RamDiscardSource sources.
+ * Iterate the given #MemoryRegionSection at minimum granularity, calling
+ * #RamDiscardSourceClass.is_populated for each chunk, and invoke @replay_fn
+ * for each contiguous populated range. In case any call fails, no further
+ * calls are made.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
@@ -244,8 +210,10 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_discarded:
  *
- * A wrapper to call the #RamDiscardSourceClass.replay_discarded callback
- * of the #RamDiscardSource sources.
+ * Iterate the given #MemoryRegionSection at minimum granularity, calling
+ * #RamDiscardSourceClass.is_populated for each chunk, and invoke @replay_fn
+ * for each contiguous discarded range. In case any call fails, no further
+ * calls are made.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 79c7e97d9a1..718c7075cec 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -32,106 +32,6 @@ ram_block_attributes_get_block_size(void)
     return qemu_real_host_page_size();
 }
 
-typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
-                                               void *arg);
-
-static int
-ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
-                                                const MemoryRegionSection *section,
-                                                void *arg,
-                                                ram_block_attributes_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size();
-    int ret = 0;
-
-    first_bit = section->offset_within_region / block_size;
-    first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                              first_bit);
-
-    while (first_bit < attr->bitmap_size) {
-        MemoryRegionSection tmp = *section;
-
-        offset = first_bit * block_size;
-        last_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
-                                      first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-
-        ret = cb(&tmp, arg);
-        if (ret) {
-            error_report("%s: Failed to notify RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            break;
-        }
-
-        first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                                  last_bit + 2);
-    }
-
-    return ret;
-}
-
-static int
-ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
-                                                const MemoryRegionSection *section,
-                                                void *arg,
-                                                ram_block_attributes_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size();
-    int ret = 0;
-
-    first_bit = section->offset_within_region / block_size;
-    first_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
-                                   first_bit);
-
-    while (first_bit < attr->bitmap_size) {
-        MemoryRegionSection tmp = *section;
-
-        offset = first_bit * block_size;
-        last_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                                 first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-
-        ret = cb(&tmp, arg);
-        if (ret) {
-            error_report("%s: Failed to notify RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            break;
-        }
-
-        first_bit = find_next_zero_bit(attr->bitmap,
-                                       attr->bitmap_size,
-                                       last_bit + 2);
-    }
-
-    return ret;
-}
-
-
-typedef struct RamBlockAttributesReplayData {
-    ReplayRamDiscardState fn;
-    void *opaque;
-} RamBlockAttributesReplayData;
-
-static int ram_block_attributes_rds_replay_cb(MemoryRegionSection *section,
-                                              void *arg)
-{
-    RamBlockAttributesReplayData *data = arg;
-
-    return data->fn(section, data->opaque);
-}
-
 /* RamDiscardSource interface implementation */
 static uint64_t
 ram_block_attributes_rds_get_min_granularity(const RamDiscardSource *rds,
@@ -159,34 +59,6 @@ ram_block_attributes_rds_is_populated(const RamDiscardSource *rds,
     return first_discarded_bit > last_bit;
 }
 
-static int
-ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
-                                          const MemoryRegionSection *section,
-                                          ReplayRamDiscardState replay_fn,
-                                          void *opaque)
-{
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
-    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
-
-    g_assert(section->mr == attr->ram_block->mr);
-    return ram_block_attributes_for_each_populated_section(attr, section, &data,
-        ram_block_attributes_rds_replay_cb);
-}
-
-static int
-ram_block_attributes_rds_replay_discarded(const RamDiscardSource *rds,
-                                          const MemoryRegionSection *section,
-                                          ReplayRamDiscardState replay_fn,
-                                          void *opaque)
-{
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
-    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
-
-    g_assert(section->mr == attr->ram_block->mr);
-    return ram_block_attributes_for_each_discarded_section(attr, section, &data,
-        ram_block_attributes_rds_replay_cb);
-}
-
 static bool
 ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
                                     uint64_t size)
@@ -346,6 +218,4 @@ static void ram_block_attributes_class_init(ObjectClass *klass,
 
     rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
     rdsc->is_populated = ram_block_attributes_rds_is_populated;
-    rdsc->replay_populated = ram_block_attributes_rds_replay_populated;
-    rdsc->replay_discarded = ram_block_attributes_rds_replay_discarded;
 }

-- 
2.54.0


