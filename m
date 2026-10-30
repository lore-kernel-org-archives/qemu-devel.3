Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EB606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojN+UzSS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMq8D-0008Ar-1I; Fri, 30 Oct 2026 13:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq8B-0008AB-DI; Fri, 30 Oct 2026 13:11:07 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq86-0004Ag-No; Fri, 30 Oct 2026 13:11:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B1A1417EB;
 Fri, 30 Oct 2026 17:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CA61F000C1;
 Fri, 30 Oct 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793380261;
 bh=uvX5opH9clYpCPrSpWiIsfd16Ptvvb6rqbcvuiAE7GA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ojN+UzSSfPEEybcMi6u63MmPRGiYXfuNkAy//z9ypAVgzMT7YxfyoDUeDWQTObhwh
 ebD6Y5pWzhoN4v33OU7uTIi1JQjynmCdg959bN9DrHeoL9ecXYrV6bzJpwPxzDlHA0
 ST6ctaVin6GDYJlM4/wzqjuyCdTOYSEux7sNsU1kEoA+xtKGYU4g+AHHJaUZwtHTss
 Kr7L3K4V79vVIE9D6xqKmfTUXalqp/eExBycIccqHCMoqkBHj2sPv+4hgsQYVjAWz4
 YEL/VZsYpv/rGexLMmsIrpTHoMmdzNcFxqtT44CO1ktGOpu9K/FVEp+PzqEKlQGJPx
 Bhxw21Eyai8cQ==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Sam Li <faithilikerun@gmail.com>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Daejun Park <daejun7.park@samsung.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v16 4/9] qcow2: add zoned emulation capability
Date: Fri, 30 Oct 2026 18:10:31 +0100
Message-ID: <20261030171038.702962-5-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030171038.702962-1-cassel@kernel.org>
References: <20261030171038.702962-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sam Li <faithilikerun@gmail.com>

By adding zone operations and zoned metadata, the zoned emulation
capability enables full emulation support of zoned device using
a qcow2 file. The zoned device metadata includes zone type,
zoned device state and write pointer (WP) of each zone, which is
stored to an array of unsigned integers.

WP accessor (qcow2_rw_wp_at) routes reads and writes of an 8-byte
WP slot through the write pointer cache. The write pointer cache is
written to disk after the qcow2 metadata is written, thus guaranteeing
that the write pointer is updated after the corresponding data is
written. Per-completion cache flush is deferred. The WP cluster reaches
disk on the next flush.

Each zone of a zoned device makes state transitions following
the zone state machine. The zone state machine mainly describes
five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
READ ONLY and OFFLINE states will generally be affected by device
internal events. The operations on zones cause corresponding state
changing.

Zoned devices have limits on zone resources, which put constraints on
write operations on zones. It is managed by active zone queues
following LRU policy.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes by Niklas Cassel:
- account for the zoned metadata in the refcount check, so that qemu-img
  check does not report the clusters it occupies as leaked
- reset and report the last zone of an image whose size is not a multiple
  of the zone size, which is shorter than the others
- clamp the write pointer that a zone finish leaves behind to the end of
  the writable part of the zone
- drop the zone append size limit, which the geometry now bounds
- report zone errors with the errnos from block-common.h instead of
  EIO, EINVAL and EBUSY: BLK_ZE_UNALIGNED_WRITE, BLK_ZE_BOUNDARY,
  BLK_ZE_OPEN_RESOURCE, BLK_ZE_ACTIVE_RESOURCE and, for a write to a
  full zone, BLK_ZE_FULL
- refuse the management of a conventional zone with EINVAL, as other
  invalid requests, rather than EIO
- manage the zone resources as in the NVMe ZNS specification
  (2.1.1.4.1): a write to an empty zone checks the active zone limit
  also when the open zone limit is not reached, OPEN ZONE of an empty
  zone checks the open zone limit too, and an implicitly open zone is
  closed to make room regardless of the active zone limit, as it
  remains active
- manage the open zone resources for FINISH ZONE of an empty zone, as
  ZBC requires (ZBC-3 4.5.3.2.4)
- check the zone capacity before the zone resources, so that a write
  past the zone capacity does not close another zone
- drop the redundant zone capacity check for zone appends
- shorten two comments that were longer than 80 columns
- report the length of a conventional zone as its capacity, as the
  whole zone is writable; Linux refuses a disk with a conventional zone
  whose capacity is smaller than its length
- refuse a write that starts in a conventional zone and reaches a
  sequential zone, without writing any data (ZAC-3 4.7.2)
- remove a closed zone from the closed list when a write fills it, so
  that it no longer counts as an active zone
- trace rejected zone requests instead of reporting them with
  error_report(), which a guest could use to flood stderr
---
 block/qcow2-cache.c    |   11 +-
 block/qcow2-refcount.c |   18 +
 block/qcow2.c          | 1244 +++++++++++++++++++++++++++++++++++++++-
 block/qcow2.h          |    2 +
 block/trace-events     |   10 +
 5 files changed, 1279 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 23d9588b08..73f2be3641 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -275,14 +275,23 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
 {
     int ret;
 
+    /*
+     * If the dependency graph is unchanged, nothing to do. This avoids
+     * a synchronous flush on every call below.
+     */
+    if (c->depends == dependency) {
+        return 0;
+    }
+
     if (dependency->depends) {
+        /* Flatten any chain on the dependency side as a cycle-breaker. */
         ret = qcow2_cache_flush_dependency(bs, dependency);
         if (ret < 0) {
             return ret;
         }
     }
 
-    if (c->depends && (c->depends != dependency)) {
+    if (c->depends) {
         ret = qcow2_cache_flush_dependency(bs, c);
         if (ret < 0) {
             return ret;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index df7f6d2f23..0f20fa353e 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1239,6 +1239,13 @@ int qcow2_write_caches(BlockDriverState *bs)
         }
     }
 
+    if (s->wp_cache) {
+        ret = qcow2_cache_write(bs, s->wp_cache);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     return 0;
 }
 
@@ -2304,6 +2311,17 @@ calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
+    /* zoned metadata */
+    if (s->zoned_header.zoned != QCOW2_Z_NONE) {
+        ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
+                                       s->zoned_header.zonedmeta_offset,
+                                       (int64_t)s->zoned_header.nr_zones *
+                                       sizeof(uint64_t));
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     /* bitmaps */
     ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table,
                                         nb_clusters, fix);
diff --git a/block/qcow2.c b/block/qcow2.c
index 01215bcf9b..e8bbad0cdd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -195,6 +195,331 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+#define QCOW2_WP_CONV_BIT       (1ULL << 63)
+#define QCOW2_ZT_IS_CONV(wp)    ((wp) & QCOW2_WP_CONV_BIT)
+#define QCOW2_GET_WP(wp)        ((wp) & ~QCOW2_WP_CONV_BIT)
+
+/*
+ * To emulate a real zoned device, closed, empty and full states are
+ * preserved after a power cycle. The open states are in-memory and will
+ * be lost after closing the device. Read-only and offline states are
+ * device-internal events, which are not considered for simplicity.
+ *
+ * The qcow2 state lock must be held when called.
+ */
+static inline BlockZoneState qcow2_get_zone_state(BlockDriverState *bs,
+                                                  uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+    uint64_t zone_wp = bs->wps->wp[index];
+    uint64_t zone_start;
+
+    if (QCOW2_ZT_IS_CONV(zone_wp)) {
+        return BLK_ZS_NOT_WP;
+    }
+
+    if (QTAILQ_IN_USE(zone_entry, exp_open_zone_entry)) {
+        return BLK_ZS_EOPEN;
+    }
+    if (QTAILQ_IN_USE(zone_entry, imp_open_zone_entry)) {
+        return BLK_ZS_IOPEN;
+    }
+
+    zone_start = (uint64_t)index * bs->bl.zone_size;
+    if (zone_wp == zone_start) {
+        return BLK_ZS_EMPTY;
+    }
+    if (bdrv_zone_is_full(bs, index)) {
+        return BLK_ZS_FULL;
+    }
+    if (zone_wp > zone_start) {
+        if (!QTAILQ_IN_USE(zone_entry, closed_zone_entry)) {
+            /*
+             * The number of closed zones is not always updated in time when
+             * the device is closed. However, it only matters when doing
+             * zone report. Refresh the count and list of closed zones to
+             * provide correct zone states for zone report.
+             */
+            QTAILQ_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
+            s->nr_zones_closed++;
+        }
+        return BLK_ZS_CLOSED;
+    }
+    return BLK_ZS_NOT_WP;
+}
+
+/* The qcow2 state lock must be held when called */
+static void qcow2_rm_exp_open_zone(BDRVQcow2State *s,
+                                   uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_REMOVE(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
+    s->nr_zones_exp_open--;
+}
+
+/* The qcow2 state lock must be held when called */
+static void qcow2_rm_imp_open_zone(BDRVQcow2State *s,
+                                   int32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry;
+    if (index < 0) {
+        /* Apply LRU when the index is not specified. */
+        zone_entry = QTAILQ_LAST(&s->imp_open_zones);
+    } else {
+        zone_entry = &s->zone_list_entries[index];
+    }
+
+    QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+    s->nr_zones_imp_open--;
+}
+
+/* The qcow2 state lock must be held when called */
+static void qcow2_rm_open_zone(BDRVQcow2State *s,
+                               uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    if (QTAILQ_IN_USE(zone_entry, exp_open_zone_entry)) {
+        qcow2_rm_exp_open_zone(s, index);
+    } else if (QTAILQ_IN_USE(zone_entry, imp_open_zone_entry)) {
+        qcow2_rm_imp_open_zone(s, index);
+    }
+}
+
+/* The qcow2 state lock must be held when called */
+static void qcow2_rm_closed_zone(BDRVQcow2State *s,
+                                 uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_REMOVE(&s->closed_zones, zone_entry, closed_zone_entry);
+    s->nr_zones_closed--;
+}
+
+/* The qcow2 state lock must be held when called */
+static void qcow2_do_imp_open_zone(BDRVQcow2State *s,
+                                   uint32_t index,
+                                   BlockZoneState zs)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        break;
+    case BLK_ZS_CLOSED:
+        qcow2_rm_closed_zone(s, index);
+        break;
+    case BLK_ZS_IOPEN:
+        /*
+         * The LRU policy: update the zone that is most recently
+         * used to the head of the zone list
+         */
+        if (zone_entry == QTAILQ_FIRST(&s->imp_open_zones)) {
+            return;
+        }
+        QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+        s->nr_zones_imp_open--;
+        break;
+    default:
+        return;
+    }
+
+    QTAILQ_INSERT_HEAD(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+    s->nr_zones_imp_open++;
+}
+
+/* The qcow2 state lock must be held when called */
+static void qcow2_do_exp_open_zone(BDRVQcow2State *s,
+                                   uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_INSERT_HEAD(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
+    s->nr_zones_exp_open++;
+}
+
+/*
+ * The list of zones is managed using an LRU policy: the last
+ * zone of the list is always the one that was least recently used
+ * for writing and is chosen as the zone to close to be able to
+ * implicitly open another zone.
+ *
+ * We can only close the open zones. The index is not specified
+ * when it is less than 0.
+ *
+ * The qcow2 state lock must be held when called.
+ */
+static void qcow2_do_close_zone(BlockDriverState *bs,
+                                int32_t index,
+                                BlockZoneState zs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneListEntry *zone_entry;
+
+    if (index >= 0) {
+        zone_entry = &s->zone_list_entries[index];
+    } else {
+        /* before removal of the last implicitly open zone */
+        zone_entry = QTAILQ_LAST(&s->imp_open_zones);
+    }
+
+    if (zs == BLK_ZS_IOPEN) {
+        assert(zone_entry != NULL);
+        qcow2_rm_imp_open_zone(s, index);
+        QTAILQ_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
+        s->nr_zones_closed++;
+        return;
+    }
+
+    if (index >= 0 && zs == BLK_ZS_EOPEN) {
+        qcow2_rm_exp_open_zone(s, index);
+        /*
+         * The zone state changes when the zone is removed from the list of
+         * open zones (explicitly open -> empty). The closed zone list is
+         * refreshed during get_zone_state().
+         */
+        qcow2_get_zone_state(bs, index);
+    }
+}
+
+/*
+ * Read/Write the new wp value for zone `index` through write pointer
+ * cache. Reads return the value currently held in the cache, which may
+ * be ahead of the on-disk value if the cache hasn't been flushed yet.
+ * Writes update the cache and mark the entry dirty.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_rw_wp_at(BlockDriverState *bs, uint64_t *wp,
+                  int32_t index, bool is_write)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t wp_byte_off = sizeof(uint64_t) * index;
+    uint64_t cluster_file_off =
+        s->zoned_header.zonedmeta_offset +
+        (wp_byte_off & ~((uint64_t)s->cluster_size - 1));
+    size_t off_in_cluster = wp_byte_off & (s->cluster_size - 1);
+    void *cluster_buf;
+    uint64_t *slot;
+    int ret;
+
+    assert(s->wp_cache != NULL);
+
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_cache_get(bs, s->wp_cache, cluster_file_off, &cluster_buf);
+    if (ret < 0) {
+        qemu_co_mutex_unlock(&s->lock);
+        error_report("Failed to %s WP slot (zone %d): %s",
+                     is_write ? "write" : "read", index, strerror(-ret));
+        return ret;
+    }
+
+    slot = (uint64_t *)((char *)cluster_buf + off_in_cluster);
+    if (is_write) {
+        *slot = cpu_to_be64(*wp);
+        qcow2_cache_entry_mark_dirty(s->wp_cache, cluster_buf);
+    } else {
+        *wp = be64_to_cpu(*slot);
+    }
+    qcow2_cache_put(s->wp_cache, &cluster_buf);
+    qemu_co_mutex_unlock(&s->lock);
+
+    trace_qcow2_wp_tracking(index, *wp >> BDRV_SECTOR_BITS);
+    return 0;
+}
+
+/* The qcow2 state lock must be held when called */
+static bool qcow2_can_activate_zone(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    /* When the max active zone is zero, there is no limit on active zones */
+    if (!s->zoned_header.max_active_zones) {
+        return true;
+    }
+
+    /* Active zones are zones that are open or closed */
+    return s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_closed
+        < s->zoned_header.max_active_zones;
+}
+
+/*
+ * This function manages open zones under active zones limit, as described in
+ * the NVMe ZNS specification (2.1.1.4.1 Managing resources). It checks if a
+ * zone in state @zs can transition to open state while maintaining max open
+ * and active zone limits, and returns 0 or the zone resource error that
+ * prevents it (-BLK_ZE_OPEN_RESOURCE or -BLK_ZE_ACTIVE_RESOURCE).
+ *
+ * The qcow2 state lock must be held when called.
+ */
+static int qcow2_check_open_zone(BlockDriverState *bs, BlockZoneState zs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    /*
+     * An empty zone becomes active when it is opened, whereas a closed zone
+     * already is.
+     */
+    if (zs == BLK_ZS_EMPTY && !qcow2_can_activate_zone(bs)) {
+        return -BLK_ZE_ACTIVE_RESOURCE;
+    }
+
+    /* When the max open zone is zero, there is no limit on open zones */
+    if (!s->zoned_header.max_open_zones) {
+        return 0;
+    }
+
+    /*
+     * The open zones are zones with the states of explicitly and
+     * implicitly open.
+     */
+    if (s->nr_zones_imp_open + s->nr_zones_exp_open <
+        s->zoned_header.max_open_zones) {
+        return 0;
+    }
+
+    /*
+     * Zones are managed one at a time. Thus, the number of implicitly open
+     * zone can never be over the open zone limit. Close only one implicitly
+     * open zone; it remains active, so the number of active zones does not
+     * change.
+     *
+     * Only an implicitly open zone can be evicted to make room. If every
+     * open zone is explicitly open, the open zone limit cannot be satisfied.
+     */
+    if (!s->nr_zones_imp_open) {
+        return -BLK_ZE_OPEN_RESOURCE;
+    }
+    qcow2_do_close_zone(bs, -1, BLK_ZS_IOPEN);
+    trace_qcow2_imp_open_zones(0x23, s->nr_zones_imp_open);
+    return 0;
+}
+
+static inline int coroutine_fn GRAPH_RDLOCK
+qcow2_refresh_zonedmeta(BlockDriverState *bs)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t wps_size = s->zoned_header.nr_zones * sizeof(uint64_t);
+    g_autofree uint64_t *temp = NULL;
+
+    QEMU_BUILD_BUG_ON(!BDRV_ZT_IS_CONV(QCOW2_WP_CONV_BIT));
+
+    temp = g_new(uint64_t, s->zoned_header.nr_zones);
+    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
+                     wps_size, temp, 0);
+    if (ret < 0) {
+        error_report("Cannot read metadata");
+        return ret;
+    }
+
+    for (uint32_t i = 0; i < s->zoned_header.nr_zones; i++) {
+        bs->wps->wp[i] = be64_to_cpu(temp[i]);
+    }
+    return 0;
+}
+
 /*
  * Returns true if zone_opt is valid for an image with clusters of
  * @cluster_size bytes, false otherwise.
@@ -540,6 +865,9 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
             zoned_ext.max_active_zones =
                 be32_to_cpu(zoned_ext.max_active_zones);
+            zoned_ext.zonedmeta_offset =
+                be64_to_cpu(zoned_ext.zonedmeta_offset);
+
             /*
              * A zoned image has the zoned incompatible feature bit set,
              * which a version 2 image cannot have.
@@ -601,6 +929,38 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 }
             }
 
+            bs->wps = g_malloc(sizeof(BlockZoneWps)
+                + s->zoned_header.nr_zones * sizeof(uint64_t));
+            ret = qcow2_refresh_zonedmeta(bs);
+            if (ret < 0) {
+                g_free(bs->wps);
+                bs->wps = NULL;
+                return ret;
+            }
+
+            s->zone_list_entries = g_new0(Qcow2ZoneListEntry,
+                                          zoned_ext.nr_zones);
+            QTAILQ_INIT(&s->exp_open_zones);
+            QTAILQ_INIT(&s->imp_open_zones);
+            QTAILQ_INIT(&s->closed_zones);
+            qemu_co_mutex_init(&bs->wps->colock);
+
+            s->zone_wp_state = g_new0(Qcow2ZoneWPState, zoned_ext.nr_zones);
+            for (uint32_t i = 0; i < zoned_ext.nr_zones; i++) {
+                QTAILQ_INIT(&s->zone_wp_state[i].in_flight);
+                QTAILQ_INIT(&s->zone_wp_state[i].completed_pending);
+                qemu_co_queue_init(&s->zone_wp_state[i].drain);
+            }
+
+            s->wp_cache = qcow2_cache_create(bs,
+                DIV_ROUND_UP(zoned_ext.nr_zones * sizeof(uint64_t),
+                             s->cluster_size),
+                s->cluster_size);
+            if (!s->wp_cache) {
+                error_setg(errp, "Could not allocate the write pointer cache");
+                return -ENOMEM;
+            }
+
 #ifdef DEBUG_EXT
             printf("Qcow2: Got zoned format extension: "
                    "offset=%" PRIu64 "\n", offset);
@@ -2961,21 +3321,304 @@ static coroutine_fn GRAPH_RDLOCK int qcow2_co_pwritev_task_entry(AioTask *task)
                                  t->l2meta);
 }
 
+/*
+ * Walk the per-zone completed_pending list while the head's LBA equals
+ * the cached persisted-WP, advancing persisted-WP and marking each
+ * covered request RESOLVED. On any advance, the new persisted-WP is
+ * written into the WP cache and depends-on qcow2 L2 table cache is
+ * established so write pointer is updated after the corresponding write
+ * completes.
+ *
+ * Caller holds bs->wps->colock.
+ */
 static int coroutine_fn GRAPH_RDLOCK
-qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      QEMUIOVector *qiov, size_t qiov_offset,
-                      BdrvRequestFlags flags)
+qcow2_wp_greedy_advance_locked(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneWPState *zs = &s->zone_wp_state[index];
+    uint64_t wp_byte_off = sizeof(uint64_t) * index;
+    uint64_t cluster_file_off =
+        s->zoned_header.zonedmeta_offset +
+        (wp_byte_off & ~((uint64_t)s->cluster_size - 1));
+    size_t off_in_cluster = wp_byte_off & (s->cluster_size - 1);
+    void *cluster_buf;
+    uint64_t *slot;
+    uint64_t persisted_wp, new_persisted_wp;
+    Qcow2WPReq *head;
+    bool any_advanced = false;
+    int ret;
+
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_cache_get(bs, s->wp_cache, cluster_file_off, &cluster_buf);
+    if (ret < 0) {
+        qemu_co_mutex_unlock(&s->lock);
+        return ret;
+    }
+    slot = (uint64_t *)((char *)cluster_buf + off_in_cluster);
+    persisted_wp = be64_to_cpu(*slot);
+    new_persisted_wp = persisted_wp;
+
+    QTAILQ_FOREACH(head, &zs->completed_pending, entry) {
+        if (head->lba != new_persisted_wp) {
+            break;
+        }
+        new_persisted_wp += head->len;
+        any_advanced = true;
+    }
+
+    if (!any_advanced) {
+        qcow2_cache_put(s->wp_cache, &cluster_buf);
+        qemu_co_mutex_unlock(&s->lock);
+        return 0;
+    }
+
+    *slot = cpu_to_be64(new_persisted_wp);
+    qcow2_cache_entry_mark_dirty(s->wp_cache, cluster_buf);
+    qcow2_cache_put(s->wp_cache, &cluster_buf);
+
+    qcow2_cache_set_dependency(bs, s->wp_cache, s->l2_table_cache);
+    qemu_co_mutex_unlock(&s->lock);
+
+    while (!QTAILQ_EMPTY(&zs->completed_pending)) {
+        head = QTAILQ_FIRST(&zs->completed_pending);
+        if (head->lba >= new_persisted_wp) {
+            break;
+        }
+        QTAILQ_REMOVE(&zs->completed_pending, head, entry);
+        head->state = QCOW2_WP_REQ_RESOLVED;
+        qemu_co_queue_restart_all(&head->wait);
+    }
+
+    return 0;
+}
+
+/*
+ * Insert req into the zone's completed_pending list in ascending LBA
+ * order. Data writes may complete out of order; greedy_advance walks
+ * the list head while head->lba == persisted_wp, so the list must
+ * stay sorted.
+ *
+ * Caller holds bs->wps->colock.
+ */
+static void
+qcow2_wp_insert_pending_locked(Qcow2ZoneWPState *zs, Qcow2WPReq *req)
+{
+    Qcow2WPReq *iter;
+
+    req->state = QCOW2_WP_REQ_PENDING;
+
+    QTAILQ_FOREACH(iter, &zs->completed_pending, entry) {
+        if (iter->lba > req->lba) {
+            QTAILQ_INSERT_BEFORE(iter, req, entry);
+            return;
+        }
+    }
+    QTAILQ_INSERT_TAIL(&zs->completed_pending, req, entry);
+}
+
+/*
+ * Peer requests with lba > failed_lba are marked ABORTED. Survivors
+ * with lba < failed_lba are left untouched. Logical WP is rolled back
+ * to the contiguous extent above persisted-WP that remains covered by
+ * survivor requests.
+ *
+ * Caller holds bs->wps->colock.
+ */
+static void
+qcow2_wp_abort_higher_peers_locked(BlockDriverState *bs, uint32_t index,
+                                    uint64_t failed_lba)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneWPState *zs = &s->zone_wp_state[index];
+    Qcow2WPReq *r, *next;
+    uint64_t logical_wp;
+
+    QTAILQ_FOREACH(r, &zs->in_flight, entry) {
+        if (r->lba > failed_lba && r->state != QCOW2_WP_REQ_ABORTED) {
+            r->state = QCOW2_WP_REQ_ABORTED;
+            qemu_co_queue_restart_all(&r->wait);
+        }
+    }
+    QTAILQ_FOREACH_SAFE(r, &zs->completed_pending, entry, next) {
+        if (r->lba > failed_lba) {
+            r->state = QCOW2_WP_REQ_ABORTED;
+            QTAILQ_REMOVE(&zs->completed_pending, r, entry);
+            qemu_co_queue_restart_all(&r->wait);
+        }
+    }
+
+    /* Rewind logical_wp to the highest survivor end_offset. */
+    logical_wp = failed_lba;
+    QTAILQ_FOREACH(r, &zs->in_flight, entry) {
+        if (r->lba < failed_lba && r->lba + r->len > logical_wp) {
+            logical_wp = r->lba + r->len;
+        }
+    }
+    QTAILQ_FOREACH(r, &zs->completed_pending, entry) {
+        if (r->lba < failed_lba && r->lba + r->len > logical_wp) {
+            logical_wp = r->lba + r->len;
+        }
+    }
+    bs->wps->wp[index] = logical_wp;
+}
+
+/*
+ * If it is an append write request, the offset pointer needs to be updated to
+ * the wp value of that zone after the IO completion. The unique pointer is
+ * passed on to this function to prevent the value being changed in condition of
+ * multiple concurrent writes.
+ *
+ * For host-managed zoned writes, the WP lock is acquired across the WP
+ * check and advance, with the qcow2 state lock nested for the zone
+ * state TAILQ traversals.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_pwv_part(BlockDriverState *bs, int64_t *offset_ptr, int64_t bytes,
+                  QEMUIOVector *qiov, size_t qiov_offset, bool is_append,
+                  BdrvRequestFlags flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t host_offset;
+    int64_t offset = *offset_ptr;
     QCowL2Meta *l2meta = NULL;
     AioTaskPool *aio = NULL;
+    int64_t start_offset, start_bytes;
+    BlockZoneState zs;
+    int64_t end_zone, end_offset;
+    uint64_t *wp;
+    int64_t zone_size = bs->bl.zone_size;
+    int64_t zone_capacity = bs->bl.zone_capacity;
+    int index = 0;
+    Qcow2WPReq req;
+    Qcow2WPReq *wp_req = NULL;
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
+    start_offset = offset;
+    start_bytes = bytes;
+    if (bs->bl.zoned == BLK_Z_HM) {
+        index = start_offset / zone_size;
+        wp = &bs->wps->wp[index];
+        qemu_co_mutex_lock(&bs->wps->colock);
+        if (QCOW2_ZT_IS_CONV(*wp)) {
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            /*
+             * The conventional zones are the first zones of the image. A write
+             * that starts in one and reaches a sequential zone writes nothing
+             * (ZAC-3 4.7.2: WRITE BOUNDARY VIOLATION).
+             */
+            if (start_offset + start_bytes >
+                s->zoned_header.conventional_zones * zone_size) {
+                trace_qcow2_zone_write_conv_to_seq(bs,
+                                                   start_offset + start_bytes);
+                return -BLK_ZE_BOUNDARY;
+            }
+        } else {
+            if (bdrv_zone_is_full(bs, index)) {
+                /* A full zone has no write pointer to write at */
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                trace_qcow2_zone_write_full(bs, (uint64_t)index * zone_size);
+                return -BLK_ZE_FULL;
+            }
+            if (offset != *wp && !is_append) {
+                /* The write offset must be equal to the zone write pointer */
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                trace_qcow2_zone_write_unaligned(bs, offset, *wp);
+                return -BLK_ZE_UNALIGNED_WRITE;
+            }
+
+            if (is_append) {
+                /*
+                 * The offset of append write is the write pointer value of
+                 * that zone.
+                 */
+                start_offset = *wp;
+            }
+
+            end_offset = start_offset + start_bytes;
+
+            /*
+             * Align up (start_offset, zone_size), the start offset is not
+             * necessarily power of two.
+             */
+            end_zone = index * zone_size + zone_capacity;
+            /*
+             * Write cannot exceed the zone capacity. Check this before the
+             * zone resources, which may close another zone.
+             */
+            if (end_offset > end_zone) {
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                trace_qcow2_zone_write_past_capacity(bs, end_offset / 512,
+                                                     end_zone / 512);
+                return -BLK_ZE_BOUNDARY;
+            }
+
+            qemu_co_mutex_lock(&s->lock);
+
+            /* Only allow writes when there are zone resources left */
+            zs = qcow2_get_zone_state(bs, index);
+            if (zs == BLK_ZS_CLOSED || zs == BLK_ZS_EMPTY) {
+                ret = qcow2_check_open_zone(bs, zs);
+                if (ret < 0) {
+                    qemu_co_mutex_unlock(&s->lock);
+                    qemu_co_mutex_unlock(&bs->wps->colock);
+                    trace_qcow2_zone_no_resources(bs,
+                        ret == -BLK_ZE_OPEN_RESOURCE ? "open" : "active");
+                    return ret;
+                }
+            }
+
+            /*
+             * Real drives change states before it can write to the zone. If
+             * the write fails, the zone state may have changed.
+             *
+             * The zone state transitions to implicit open when the original
+             * state is empty or closed. When the wp reaches the end, the
+             * open states (explicit open, implicit open) become full.
+             */
+            zs = qcow2_get_zone_state(bs, index);
+            if (end_offset == end_zone) {
+                /* Reaching the zone capacity implies full state */
+                if (zs == BLK_ZS_CLOSED) {
+                    qcow2_rm_closed_zone(s, index);
+                } else {
+                    qcow2_rm_open_zone(s, index);
+                }
+                trace_qcow2_imp_open_zones(0x24,
+                                           s->nr_zones_imp_open);
+            } else {
+                qcow2_do_imp_open_zone(s, index, zs);
+                trace_qcow2_imp_open_zones(0x24,
+                                           s->nr_zones_imp_open);
+            }
+
+            qemu_co_mutex_unlock(&s->lock);
+
+            /*
+             * Submission for a zone append write. The logical-WP is updated
+             * while the on-disk WP is not touched.
+             */
+            if (is_append) {
+                *offset_ptr = start_offset;
+                offset = start_offset;
+            }
+
+            wp_req = &req;
+            wp_req->lba = start_offset;
+            wp_req->len = start_bytes;
+            wp_req->state = QCOW2_WP_REQ_INFLIGHT;
+            qemu_co_queue_init(&wp_req->wait);
+            QTAILQ_INSERT_TAIL(&s->zone_wp_state[index].in_flight,
+                               wp_req, entry);
+
+            *wp = end_offset;
+            qemu_co_mutex_unlock(&bs->wps->colock);
+        }
+    }
+
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
 
         l2meta = NULL;
@@ -3036,14 +3679,81 @@ fail_nometa:
         if (ret == 0) {
             ret = aio_task_pool_status(aio);
         }
-        g_free(aio);
+        g_free(aio);
+    }
+
+    if (wp_req != NULL) {
+        qemu_co_mutex_lock(&bs->wps->colock);
+        QTAILQ_REMOVE(&s->zone_wp_state[index].in_flight, wp_req, entry);
+        if (QTAILQ_EMPTY(&s->zone_wp_state[index].in_flight)) {
+            qemu_co_queue_restart_all(&s->zone_wp_state[index].drain);
+        }
+
+        if (wp_req->state == QCOW2_WP_REQ_ABORTED) {
+            /*
+             * A peer's failure handler aborted us. Whether our data
+             * write itself succeeded or not, reject it.
+             */
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            ret = ret < 0 ? ret : -EIO;
+            goto wp_done;
+        }
+
+        if (ret < 0) {
+            /*
+             * This req's data write failed. Higher-LBA peers (still
+             * in_flight or already completed_pending) are marked ABORTED,
+             * their waiters woken; logical-WP rewinds to the highest
+             * surviving end_offset below this LBA. The zone remains usable.
+             */
+            qcow2_wp_abort_higher_peers_locked(bs, index, wp_req->lba);
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            goto wp_done;
+        }
+
+        qcow2_wp_insert_pending_locked(&s->zone_wp_state[index], wp_req);
+
+        ret = qcow2_wp_greedy_advance_locked(bs, index);
+        if (ret < 0) {
+            if (wp_req->state == QCOW2_WP_REQ_PENDING) {
+                QTAILQ_REMOVE(&s->zone_wp_state[index].completed_pending,
+                              wp_req, entry);
+            }
+            qcow2_wp_abort_higher_peers_locked(bs, index, wp_req->lba);
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            goto wp_done;
+        }
+
+        /* Block until this write pointer req is RESOLVED or ABORTED. */
+        while (wp_req->state == QCOW2_WP_REQ_PENDING) {
+            qemu_co_queue_wait(&wp_req->wait, &bs->wps->colock);
+        }
+
+        if (wp_req->state == QCOW2_WP_REQ_ABORTED) {
+            ret = -EIO;
+        } else {
+            assert(wp_req->state == QCOW2_WP_REQ_RESOLVED);
+            ret = 0;
+        }
+        qemu_co_mutex_unlock(&bs->wps->colock);
     }
 
+wp_done:
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
 
     return ret;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                      QEMUIOVector *qiov, size_t qiov_offset,
+                      BdrvRequestFlags flags)
+{
+    return qcow2_co_pwv_part(bs, &offset, bytes, qiov, qiov_offset, false,
+                             flags);
+}
+
+
 static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -3072,6 +3782,15 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
                      strerror(-ret));
     }
 
+    if (s->wp_cache) {
+        ret = qcow2_cache_flush(bs, s->wp_cache);
+        if (ret) {
+            result = ret;
+            error_report("Failed to flush the WP cache: %s",
+                         strerror(-ret));
+        }
+    }
+
     /*
      * A read-only node cannot resolve an inherited dirty bit here;
      * leave it dirty, same as plain read access already does.
@@ -3083,6 +3802,25 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
     return result;
 }
 
+static void qcow2_do_close_all_zone(BDRVQcow2State *s)
+{
+    Qcow2ZoneListEntry *zone_entry, *next;
+
+    QTAILQ_FOREACH_SAFE(zone_entry, &s->imp_open_zones, imp_open_zone_entry,
+                        next) {
+        QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+        s->nr_zones_imp_open--;
+    }
+
+    QTAILQ_FOREACH_SAFE(zone_entry, &s->exp_open_zones, exp_open_zone_entry,
+                        next) {
+        QTAILQ_REMOVE(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
+        s->nr_zones_exp_open--;
+    }
+
+    assert(s->nr_zones_imp_open + s->nr_zones_exp_open == 0);
+}
+
 static void coroutine_mixed_fn GRAPH_RDLOCK
 qcow2_do_close(BlockDriverState *bs, bool close_data_file)
 {
@@ -3098,6 +3836,10 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     cache_clean_timer_del_and_wait(bs);
     qcow2_cache_destroy(s->l2_table_cache);
     qcow2_cache_destroy(s->refcount_block_cache);
+    if (s->wp_cache) {
+        qcow2_cache_destroy(s->wp_cache);
+        s->wp_cache = NULL;
+    }
 
     qcrypto_block_free(s->crypto);
     s->crypto = NULL;
@@ -3122,6 +3864,12 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
 
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
+    qcow2_do_close_all_zone(s);
+    g_free(s->zone_list_entries);
+    s->zone_list_entries = NULL;
+    g_free(s->zone_wp_state);
+    s->zone_wp_state = NULL;
+    g_free(bs->wps);
 }
 
 static void GRAPH_UNLOCKED qcow2_close(BlockDriverState *bs)
@@ -3438,6 +4186,8 @@ int qcow2_update_header(BlockDriverState *bs)
             .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
             .max_active_zones   =
                 cpu_to_be32(s->zoned_header.max_active_zones),
+            .zonedmeta_offset   =
+                cpu_to_be64(s->zoned_header.zonedmeta_offset),
         };
         ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
                              &zoned_header, sizeof(zoned_header),
@@ -3846,7 +4596,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     int version;
     int refcount_order;
     uint64_t *refcount_table;
-    int ret;
+    uint64_t zoned_meta_size, zoned_clusterlen;
+    int64_t offset;
+    int ret, i;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
@@ -4211,6 +4963,48 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             ret = -EINVAL;
             goto unlock;
         }
+
+        uint32_t nrz = s->zoned_header.nr_zones;
+        zoned_meta_size =  sizeof(uint64_t) * nrz;
+        g_autofree uint64_t *meta = NULL;
+        meta = g_new0(uint64_t, nrz);
+
+        for (i = 0; i < s->zoned_header.conventional_zones; ++i) {
+            meta[i] = i * s->zoned_header.zone_size;
+            meta[i] |= QCOW2_WP_CONV_BIT;
+        }
+
+        for (; i < nrz; ++i) {
+            meta[i] = i * s->zoned_header.zone_size;
+        }
+
+        offset = qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
+        if (offset < 0) {
+            ret = offset;
+            error_setg_errno(errp, -ret, "Could not allocate clusters "
+                                         "for zoned metadata size");
+            goto unlock;
+        }
+        s->zoned_header.zonedmeta_offset = offset;
+
+        zoned_clusterlen = size_to_clusters(s, zoned_meta_size)
+                * s->cluster_size;
+        ret = qcow2_pre_write_overlap_check(blk_bs(blk), 0, offset,
+                                            zoned_clusterlen, false);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Overlap check failed for zoned "
+                                         "metadata");
+            goto unlock;
+        }
+        for (i = 0; i < nrz; ++i) {
+            meta[i] = cpu_to_be64(meta[i]);
+        }
+        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Could not write zoned metadata "
+                                         "to disk");
+            goto unlock;
+        }
     } else {
         s->zoned_header.zoned = QCOW2_Z_NONE;
     }
@@ -4615,6 +5409,442 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return ret;
 }
 
+static int coroutine_fn
+qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
+                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t zone_size = s->zoned_header.zone_size;
+    uint64_t zone_capacity = s->zoned_header.zone_capacity;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t size = bs->bl.nr_zones * zone_size;
+    unsigned int nrz, si, i = 0;
+
+    if (offset >= capacity) {
+        trace_qcow2_zone_report_invalid(bs, offset, capacity);
+        return -EINVAL;
+    }
+
+    nrz = ((*nr_zones) < bs->bl.nr_zones) ? (*nr_zones) : bs->bl.nr_zones;
+    si = offset / zone_size; /* Zone size cannot be 0 for zoned device */
+    qemu_co_mutex_lock(&bs->wps->colock);
+    for (; i < nrz; ++i) {
+        if (i + si >= bs->bl.nr_zones) {
+            break;
+        }
+
+        zones[i].start = (si + i) * zone_size;
+
+        /* The last zone can be smaller than the zone size */
+        if ((si + i + 1) == bs->bl.nr_zones && size > capacity) {
+            uint64_t l = zone_size - (size - capacity);
+            zones[i].length = l;
+            zones[i].cap = MIN(zone_capacity, l);
+        } else {
+            zones[i].length = zone_size;
+            zones[i].cap = zone_capacity;
+        }
+
+        uint64_t wp = bs->wps->wp[si + i];
+        if (QCOW2_ZT_IS_CONV(wp)) {
+            zones[i].type = BLK_ZT_CONV;
+            zones[i].state = BLK_ZS_NOT_WP;
+            /* A conventional zone is writable in full */
+            zones[i].cap = zones[i].length;
+            /* Clear masking bits */
+            wp = QCOW2_GET_WP(wp);
+        } else {
+            zones[i].type = BLK_ZT_SWR;
+            qemu_co_mutex_lock(&s->lock);
+            zones[i].state = qcow2_get_zone_state(bs, si + i);
+            qemu_co_mutex_unlock(&s->lock);
+        }
+        zones[i].wp = wp;
+    }
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    *nr_zones = i;
+    return 0;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_open_zone(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    qemu_co_mutex_lock(&s->lock);
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+    trace_qcow2_imp_open_zones(BLK_ZO_OPEN, s->nr_zones_imp_open);
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        ret = qcow2_check_open_zone(bs, zs);
+        if (ret < 0) {
+            goto unlock;
+        }
+        break;
+    case BLK_ZS_IOPEN:
+        qcow2_rm_imp_open_zone(s, index);
+        break;
+    case BLK_ZS_EOPEN:
+        qemu_co_mutex_unlock(&s->lock);
+        qemu_co_mutex_unlock(&bs->wps->colock);
+        return 0;
+    case BLK_ZS_CLOSED:
+        ret = qcow2_check_open_zone(bs, zs);
+        if (ret < 0) {
+            goto unlock;
+        }
+        qcow2_rm_closed_zone(s, index);
+        break;
+    case BLK_ZS_FULL:
+        /*
+         * A full zone has no writable capacity left and holds no zone
+         * resources, so opening it is not a valid transition. It has to be
+         * reset before it can be opened again.
+         */
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+
+    qcow2_do_exp_open_zone(s, index);
+    ret = 0;
+
+unlock:
+    qemu_co_mutex_unlock(&s->lock);
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_close_zone(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    qemu_co_mutex_lock(&s->lock);
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        break;
+    case BLK_ZS_IOPEN:
+        break;
+    case BLK_ZS_EOPEN:
+        break;
+    case BLK_ZS_CLOSED:
+        /* Closing a closed zone is not an error */
+        ret = 0;
+        goto unlock;
+    case BLK_ZS_FULL:
+        break;
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+    qcow2_do_close_zone(bs, index, zs);
+    ret = 0;
+
+unlock:
+    qemu_co_mutex_unlock(&s->lock);
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_finish_zone(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+
+    /* Wait for any in-flight writes to this zone to drain. */
+    if (s->zone_wp_state) {
+        while (!QTAILQ_EMPTY(&s->zone_wp_state[index].in_flight)) {
+            qemu_co_queue_wait(&s->zone_wp_state[index].drain,
+                               &bs->wps->colock);
+        }
+    }
+
+    qemu_co_mutex_lock(&s->lock);
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        /*
+         * An empty or closed zone becomes implicitly open before it becomes
+         * full, which needs zone resources as for a write (ZBC-3 4.5.3.2.4).
+         */
+        ret = qcow2_check_open_zone(bs, zs);
+        if (ret < 0) {
+            goto unlock_state;
+        }
+        break;
+    case BLK_ZS_IOPEN:
+        qcow2_rm_imp_open_zone(s, index);
+        trace_qcow2_imp_open_zones(BLK_ZO_FINISH, s->nr_zones_imp_open);
+        break;
+    case BLK_ZS_EOPEN:
+        qcow2_rm_exp_open_zone(s, index);
+        break;
+    case BLK_ZS_CLOSED:
+        ret = qcow2_check_open_zone(bs, zs);
+        if (ret < 0) {
+            goto unlock_state;
+        }
+        qcow2_rm_closed_zone(s, index);
+        break;
+    case BLK_ZS_FULL:
+        ret = 0;
+        goto unlock_state;
+    default:
+        ret = -EINVAL;
+        goto unlock_state;
+    }
+
+    qemu_co_mutex_unlock(&s->lock);
+
+    uint64_t old_wp = *wp;
+    *wp = bdrv_zone_writable_end(bs, index);
+    ret = qcow2_rw_wp_at(bs, wp, index, true);
+    if (ret < 0) {
+        /* Keep the in-memory write pointer equal to the on-disk one. */
+        *wp = old_wp;
+        goto unlock;
+    }
+
+    /*
+     * Flush the WP cache so the on-disk write pointer reflects the new state
+     * on return.
+     */
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_cache_flush(bs, s->wp_cache);
+    qemu_co_mutex_unlock(&s->lock);
+    goto unlock;
+
+unlock_state:
+    qemu_co_mutex_unlock(&s->lock);
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
+                            int64_t len)
+{
+    BDRVQcow2State *s = bs->opaque;
+    unsigned int nrz = bs->bl.nr_zones;
+    int64_t zone_size = bs->bl.zone_size;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t zone_start;
+    unsigned int n;
+    int ret = 0;
+    bool any_dirtied = false;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+    if (len == capacity) {
+        n = nrz;
+        index = 0;
+        wp = &bs->wps->wp[0];
+    } else {
+        /*
+         * A trailing zone that is shorter than the zone size still counts as
+         * a whole zone, otherwise resetting it alone would round down to no
+         * zone at all.
+         */
+        n = DIV_ROUND_UP(len, zone_size);
+    }
+
+    for (unsigned int i = 0; i < n; ++i) {
+        uint64_t *wp_i = (uint64_t *)(wp + i);
+        uint64_t wpi_v = *wp_i;
+        if (QCOW2_ZT_IS_CONV(wpi_v)) {
+            continue;
+        }
+
+        /* Wait for any in-flight writes to this zone to drain. */
+        if (s->zone_wp_state) {
+            while (!QTAILQ_EMPTY(&s->zone_wp_state[index + i].in_flight)) {
+                qemu_co_queue_wait(&s->zone_wp_state[index + i].drain,
+                                   &bs->wps->colock);
+            }
+        }
+
+        qemu_co_mutex_lock(&s->lock);
+        BlockZoneState zs = qcow2_get_zone_state(bs, index + i);
+        switch (zs) {
+        case BLK_ZS_EMPTY:
+            break;
+        case BLK_ZS_IOPEN:
+            qcow2_rm_imp_open_zone(s, index + i);
+            trace_qcow2_imp_open_zones(BLK_ZO_RESET, s->nr_zones_imp_open);
+            break;
+        case BLK_ZS_EOPEN:
+            qcow2_rm_exp_open_zone(s, index + i);
+            break;
+        case BLK_ZS_CLOSED:
+            qcow2_rm_closed_zone(s, index + i);
+            break;
+        case BLK_ZS_FULL:
+            break;
+        default:
+            ret = -EINVAL;
+            qemu_co_mutex_unlock(&s->lock);
+            goto unlock;
+        }
+        qemu_co_mutex_unlock(&s->lock);
+
+        if (zs == BLK_ZS_EMPTY) {
+            continue;
+        }
+
+        /*
+         * Zero the data extent first. Data write fires before the WP cluster
+         * hits disk. So the wp advance cannot become durable while stale data
+         * is still readable.
+         *
+         * The last zone is shorter than the zone size when the device
+         * capacity is not a multiple of it, so stop at the end of the device.
+         */
+        zone_start = (uint64_t)(index + i) * zone_size;
+        ret = qcow2_co_pwrite_zeroes(bs, zone_start,
+                                     MIN(zone_size, capacity - zone_start), 0);
+        if (ret < 0) {
+            error_report("Failed to clear zone data at zone %u",
+                         index + i);
+            goto unlock;
+        }
+
+        qemu_co_mutex_lock(&s->lock);
+        qcow2_cache_depends_on_flush(s->wp_cache);
+        qemu_co_mutex_unlock(&s->lock);
+
+        uint64_t old_wp = *wp_i;
+        *wp_i = zone_start;
+        ret = qcow2_rw_wp_at(bs, wp_i, index + i, true);
+        if (ret < 0) {
+            /* Keep the in-memory write pointer equal to the on-disk one. */
+            *wp_i = old_wp;
+            goto unlock;
+        }
+        any_dirtied = true;
+    }
+
+    if (any_dirtied) {
+        /* Single flush at the end. */
+        qemu_co_mutex_lock(&s->lock);
+        ret = qcow2_cache_flush(bs, s->wp_cache);
+        qemu_co_mutex_unlock(&s->lock);
+    }
+
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
+                   int64_t offset, int64_t len)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret = 0;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t zone_size = s->zoned_header.zone_size;
+    int64_t zone_size_mask = zone_size - 1;
+    uint32_t index = offset / zone_size;
+    BlockZoneWps *wps = bs->wps;
+
+    if (offset >= capacity) {
+        trace_qcow2_zone_mgmt_invalid(bs, op, offset, len,
+                                      "offset beyond the capacity");
+        return -EINVAL;
+    }
+
+    if (offset & zone_size_mask) {
+        trace_qcow2_zone_mgmt_invalid(bs, op, offset, len,
+                                      "offset not zone aligned");
+        return -EINVAL;
+    }
+
+    /* The length must be zone-aligned and within the device capacity. */
+    if ((len < capacity - offset && (len & zone_size_mask)) ||
+        len > capacity - offset) {
+        trace_qcow2_zone_mgmt_invalid(bs, op, offset, len,
+                                      "length not zone aligned");
+        return -EINVAL;
+    }
+
+    qemu_co_mutex_lock(&wps->colock);
+    uint64_t wpv = wps->wp[index];
+    qemu_co_mutex_unlock(&wps->colock);
+
+    if (QCOW2_ZT_IS_CONV(wpv)) {
+        /*
+         * ZONE_RESET_ALL is a global operation that is allowed when the
+         * starting zone is conventional; the zone reset path itself skips
+         * conventional zones.
+         */
+        if (op != BLK_ZO_RESET || len != capacity) {
+            trace_qcow2_zone_mgmt_invalid(bs, op, offset, len,
+                                          "conventional zone");
+            return -EINVAL;
+        }
+    }
+
+    switch (op) {
+    case BLK_ZO_OPEN:
+        ret = qcow2_open_zone(bs, index);
+        break;
+    case BLK_ZO_CLOSE:
+        ret = qcow2_close_zone(bs, index);
+        break;
+    case BLK_ZO_FINISH:
+        ret = qcow2_finish_zone(bs, index);
+        break;
+    case BLK_ZO_RESET:
+        ret = qcow2_reset_zone(bs, index, len);
+        break;
+    default:
+        trace_qcow2_zone_mgmt_invalid(bs, op, offset, len,
+                                      "unsupported operation");
+        ret = -ENOTSUP;
+        break;
+    }
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector *qiov,
+                     BdrvRequestFlags flags)
+{
+    assert(flags == 0);
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t zone_size_mask = bs->bl.zone_size - 1;
+    int64_t len = 0;
+
+    if (*offset >= capacity) {
+        trace_qcow2_zone_append_invalid(bs, *offset,
+                                        "offset beyond the capacity");
+        return -ENOSPC;
+    }
+
+    if (*offset & zone_size_mask) {
+        trace_qcow2_zone_append_invalid(bs, *offset, "offset not a zone start");
+        return -EINVAL;
+    }
+
+    len = qiov->size;
+
+    return qcow2_co_pwv_part(bs, offset, len, qiov, 0, true, 0);
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_copy_range_from(BlockDriverState *bs,
                          BdrvChild *src, int64_t src_offset,
@@ -6697,6 +7927,10 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_pwritev_compressed_part    = qcow2_co_pwritev_compressed_part,
     .bdrv_make_empty                    = qcow2_make_empty,
 
+    .bdrv_co_zone_report                = qcow2_co_zone_report,
+    .bdrv_co_zone_mgmt                  = qcow2_co_zone_mgmt,
+    .bdrv_co_zone_append                = qcow2_co_zone_append,
+
     .bdrv_snapshot_create               = qcow2_snapshot_create,
     .bdrv_snapshot_goto                 = qcow2_snapshot_goto,
     .bdrv_snapshot_delete               = qcow2_snapshot_delete,
diff --git a/block/qcow2.h b/block/qcow2.h
index 7757b98385..0092eb9e3d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -296,6 +296,8 @@ typedef struct Qcow2ZoneWPState {
     QTAILQ_HEAD(, Qcow2WPReq) in_flight;
     /* PENDING reqs, sorted by lba */
     QTAILQ_HEAD(, Qcow2WPReq) completed_pending;
+    /* zone mgmt ops wait here until in_flight has drained */
+    CoQueue drain;
 } Qcow2ZoneWPState;
 
 typedef struct Qcow2UnknownHeaderExtension {
diff --git a/block/trace-events b/block/trace-events
index 950c82d4b8..e746c2aa30 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -70,12 +70,22 @@ luring_resubmit_short_io(void *req, int ndone) "req %p ndone %d"
 qcow2_add_task(void *co, void *bs, void *pool, const char *action, int cluster_type, uint64_t host_offset, uint64_t offset, uint64_t bytes, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p qiov_offset %zu"
 qcow2_writev_start_req(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
+qcow2_zone_write_conv_to_seq(void *bs, uint64_t end_offset) "bs %p end_offset 0x%" PRIx64
+qcow2_zone_write_full(void *bs, uint64_t zone_offset) "bs %p zone 0x%" PRIx64
+qcow2_zone_write_unaligned(void *bs, uint64_t offset, uint64_t wp) "bs %p offset 0x%" PRIx64 " wp 0x%" PRIx64
+qcow2_zone_write_past_capacity(void *bs, uint64_t end_sector, uint64_t zone_end_sector) "bs %p end 0x%" PRIx64 " zone end 0x%" PRIx64
+qcow2_zone_no_resources(void *bs, const char *kind) "bs %p no more %s zones available"
+qcow2_zone_report_invalid(void *bs, int64_t offset, int64_t capacity) "bs %p offset %" PRId64 " capacity %" PRId64
+qcow2_zone_mgmt_invalid(void *bs, int op, int64_t offset, int64_t len, const char *reason) "bs %p op 0x%x offset %" PRId64 " len %" PRId64 ": %s"
+qcow2_zone_append_invalid(void *bs, int64_t offset, const char *reason) "bs %p offset %" PRId64 ": %s"
 qcow2_writev_start_part(void *co) "co %p"
 qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
 qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_pwrite_zeroes(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset 0x%" PRIx64 " nb_clusters %d"
+qcow2_wp_tracking(int index, uint64_t wp) "wps[%d]: 0x%" PRIx64
+qcow2_imp_open_zones(uint8_t op, int nrz) "nr_imp_open_zones after op 0x%x: %d"
 
 # qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
-- 
2.56.0


