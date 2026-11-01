Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC9606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fEbwn+45
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc1K-0006iv-O5; Sun, 01 Nov 2026 15:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzp-00050C-Fb
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzf-0007Cq-FX
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC6uhmvLQ89fZfF2IyFMV1DNvqleHpRBGBmy/p89T6s=;
 b=fEbwn+45bhqbah4qZhUs4BvCwPTf7n8qYEk0fjn618bVPFOsLgIA1m03jtvEhAxIjiIHMY
 SX0TyNtqYBaqBfjPjgoV7oSZMtEIdGz5bzhwbeAG1a+WByMcQGoTfmjyNpCUy7EUjc+/zZ
 09gyfWyF3ZizfULkQCpuUFA62mnZjAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-upkMJw51O4Kdese9Nkwoiw-1; Sun,
 01 Nov 2026 15:17:29 -0500
X-MC-Unique: upkMJw51O4Kdese9Nkwoiw-1
X-Mimecast-MFC-AGG-ID: upkMJw51O4Kdese9Nkwoiw_1793564249
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2A851956079
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AF95195608B
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5670721E682C; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 40/56] virtio-balloon: convert guest-stats property to QAPI
 type
Date: Sun,  1 Nov 2026 21:17:01 +0100
Message-ID: <20261101201717.3911097-41-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Define VirtioBalloonStats and VirtioBalloonGuestStats QAPI struct types
in the schema, replacing the hand-rolled visitor in balloon_stats_get_all()
with a generated visit_type_VirtioBalloonGuestStats() call.

The wire format is preserved: the JSON output from qom-get is identical
to the previous hand-rolled visitor output.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/virtio-balloon-stats.rst | 22 +------
 qapi/machine.json                     | 88 +++++++++++++++++++++++++++
 hw/virtio/virtio-balloon.c            | 85 +++++++++-----------------
 3 files changed, 119 insertions(+), 76 deletions(-)

diff --git a/docs/interop/virtio-balloon-stats.rst b/docs/interop/virtio-balloon-stats.rst
index b9a6a6edb2..88d3271bbb 100644
--- a/docs/interop/virtio-balloon-stats.rst
+++ b/docs/interop/virtio-balloon-stats.rst
@@ -22,27 +22,7 @@ polling the guest's balloon driver for new stats in the specified time
 interval.
 
 To retrieve those stats, clients have to query the guest-stats property,
-which will return a dictionary containing:
-
-  * A key named 'stats', containing all available stats. If the guest
-    doesn't support a particular stat, or if it couldn't be retrieved,
-    its value will be -1. Currently, the following stats are supported:
-
-      - stat-swap-in
-      - stat-swap-out
-      - stat-major-faults
-      - stat-minor-faults
-      - stat-free-memory
-      - stat-total-memory
-      - stat-available-memory
-      - stat-disk-caches
-      - stat-htlb-pgalloc
-      - stat-htlb-pgfail
-
-  * A key named last-update, which contains the last stats update
-    timestamp in seconds. Since this timestamp is generated by the host,
-    a buggy guest can't influence its value. The value is 0 if the guest
-    has not updated the stats (yet).
+which will return a VirtioBalloonGuestStats (see QAPI documentation).
 
 It's also important to note the following:
 
diff --git a/qapi/machine.json b/qapi/machine.json
index 9b145c635b..80348b5350 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1126,6 +1126,94 @@
 ##
 { 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
 
+##
+# @VirtioBalloonStats:
+#     VirtIO balloon device guest memory statistics.
+#
+# If the guest doesn't support a particular stat, or if it couldn't be
+# retrieved, its value will be -1.
+#
+# @stat-swap-in: The amount of memory that has been swapped in (in
+#     bytes).
+#
+# @stat-swap-out: The amount of memory that has been swapped out to
+#     disk (in bytes).
+#
+# @stat-major-faults: The number of major page faults that have
+#     occurred.
+#
+# @stat-minor-faults: The number of minor page faults that have
+#     occurred.
+#
+# @stat-free-memory: The amount of memory not being used for any
+#     purpose (in bytes).
+#
+# @stat-total-memory: The total amount of memory available (in bytes).
+#
+# @stat-available-memory: An estimate of how much memory is available
+#     (in bytes) for starting new applications, without pushing the
+#     system to swap.
+#
+# @stat-disk-caches: The amount of memory, in bytes, that can be
+#     quickly reclaimed without additional I/O.  Typically these pages
+#     are used for caching files from disk.
+#
+# @stat-htlb-pgalloc: The number of successful hugetlb page
+#     allocations
+#
+# @stat-htlb-pgfail: The number of failed hugetlb page allocations
+#
+# @stat-oom-kills: The number of OOM killer invocations
+#
+# @stat-alloc-stalls: The number of memory allocation stalls
+#
+# @stat-async-scans: The number of memory scanned asynchronously
+#
+# @stat-direct-scans: The number of memory scanned directly
+#
+# @stat-async-reclaims: The number of memory reclaimed asynchronously
+#
+# @stat-direct-reclaims: The number of memory reclaimed directly
+#
+# Since: 11.2
+##
+{ 'struct': 'VirtioBalloonStats',
+  'data': {
+    'stat-swap-in': 'uint64',
+    'stat-swap-out': 'uint64',
+    'stat-major-faults': 'uint64',
+    'stat-minor-faults': 'uint64',
+    'stat-free-memory': 'uint64',
+    'stat-total-memory': 'uint64',
+    'stat-available-memory': 'uint64',
+    'stat-disk-caches': 'uint64',
+    'stat-htlb-pgalloc': 'uint64',
+    'stat-htlb-pgfail': 'uint64',
+    'stat-oom-kills': 'uint64',
+    'stat-alloc-stalls': 'uint64',
+    'stat-async-scans': 'uint64',
+    'stat-direct-scans': 'uint64',
+    'stat-async-reclaims': 'uint64',
+    'stat-direct-reclaims': 'uint64' } }
+
+##
+# @VirtioBalloonGuestStats:
+#     Guest statistics from the VirtIO balloon device.
+#
+# @last-update: Timestamp in seconds of the last stats update from the
+#     guest.  Since this timestamp is generated by the host, a buggy
+#     guest can't influence its value.  The value is 0 if the guest
+#     has not updated the stats, yet.
+#
+# @stats: balloon memory statistics
+#
+# Since: 11.2
+##
+{ 'struct': 'VirtioBalloonGuestStats',
+  'data': {
+    'last-update': 'int',
+    'stats': 'VirtioBalloonStats' } }
+
 ##
 # @query-balloon:
 #     Return information about the balloon device.
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 366f88e048..547173e035 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -29,6 +29,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-events-machine.h"
+#include "qapi/qapi-type-infos-machine.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qemu/error-report.h"
@@ -170,34 +172,6 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     }
 }
 
-/*
- * All stats upto VIRTIO_BALLOON_S_NR /must/ have a
- * non-NULL name declared here, since these are used
- * as keys for populating the QDict with stats
- */
-static const char *balloon_stat_names[] = {
-   [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
-   [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
-   [VIRTIO_BALLOON_S_MAJFLT] = "stat-major-faults",
-   [VIRTIO_BALLOON_S_MINFLT] = "stat-minor-faults",
-   [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
-
-   [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
-   [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
-   [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
-   [VIRTIO_BALLOON_S_HTLB_PGALLOC] = "stat-htlb-pgalloc",
-   [VIRTIO_BALLOON_S_HTLB_PGFAIL] = "stat-htlb-pgfail",
-
-   [VIRTIO_BALLOON_S_OOM_KILL] = "stat-oom-kills",
-   [VIRTIO_BALLOON_S_ALLOC_STALL] = "stat-alloc-stalls",
-   [VIRTIO_BALLOON_S_ASYNC_SCAN] = "stat-async-scans",
-   [VIRTIO_BALLOON_S_DIRECT_SCAN] = "stat-direct-scans",
-   [VIRTIO_BALLOON_S_ASYNC_RECLAIM] = "stat-async-reclaims",
-
-   [VIRTIO_BALLOON_S_DIRECT_RECLAIM] = "stat-direct-reclaims",
-};
-G_STATIC_ASSERT(G_N_ELEMENTS(balloon_stat_names) == VIRTIO_BALLOON_S_NR);
-
 /*
  * reset_stats - Mark all items in the stats array as unset
  *
@@ -258,33 +232,33 @@ static void balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
-    bool ok = false;
-    int i;
+    VirtioBalloonStats stats = {
+        .stat_swap_in = s->stats[VIRTIO_BALLOON_S_SWAP_IN],
+        .stat_swap_out = s->stats[VIRTIO_BALLOON_S_SWAP_OUT],
+        .stat_major_faults = s->stats[VIRTIO_BALLOON_S_MAJFLT],
+        .stat_minor_faults = s->stats[VIRTIO_BALLOON_S_MINFLT],
+        .stat_free_memory = s->stats[VIRTIO_BALLOON_S_MEMFREE],
+        .stat_total_memory = s->stats[VIRTIO_BALLOON_S_MEMTOT],
+        .stat_available_memory = s->stats[VIRTIO_BALLOON_S_AVAIL],
+        .stat_disk_caches = s->stats[VIRTIO_BALLOON_S_CACHES],
+        .stat_htlb_pgalloc = s->stats[VIRTIO_BALLOON_S_HTLB_PGALLOC],
+        .stat_htlb_pgfail = s->stats[VIRTIO_BALLOON_S_HTLB_PGFAIL],
+        .stat_oom_kills = s->stats[VIRTIO_BALLOON_S_OOM_KILL],
+        .stat_alloc_stalls = s->stats[VIRTIO_BALLOON_S_ALLOC_STALL],
+        .stat_async_scans = s->stats[VIRTIO_BALLOON_S_ASYNC_SCAN],
+        .stat_direct_scans = s->stats[VIRTIO_BALLOON_S_DIRECT_SCAN],
+        .stat_async_reclaims = s->stats[VIRTIO_BALLOON_S_ASYNC_RECLAIM],
+        .stat_direct_reclaims = s->stats[VIRTIO_BALLOON_S_DIRECT_RECLAIM],
+    };
+    /* Update VirtioBalloonStats QAPI type when new stats are added */
+    G_STATIC_ASSERT(VIRTIO_BALLOON_S_NR == 16);
+    VirtioBalloonGuestStats guest_stats = {
+        .last_update = s->stats_last_update,
+        .stats = &stats,
+    };
+    VirtioBalloonGuestStats *argp = &guest_stats;
 
-    if (!visit_start_struct(v, name, NULL, 0, errp)) {
-        return;
-    }
-    if (!visit_type_int(v, "last-update", &s->stats_last_update, errp)) {
-        goto out_end;
-    }
-
-    if (!visit_start_struct(v, "stats", NULL, 0, errp)) {
-        goto out_end;
-    }
-    for (i = 0; i < VIRTIO_BALLOON_S_NR; i++) {
-        if (!visit_type_uint64(v, balloon_stat_names[i], &s->stats[i], errp)) {
-            goto out_nested;
-        }
-    }
-    ok = visit_check_struct(v, errp);
-out_nested:
-    visit_end_struct(v, NULL);
-
-    if (ok) {
-        visit_check_struct(v, errp);
-    }
-out_end:
-    visit_end_struct(v, NULL);
+    visit_type_VirtioBalloonGuestStats(v, name, &argp, errp);
 }
 
 static void balloon_stats_get_poll_interval(Object *obj, Visitor *v,
@@ -1037,7 +1011,8 @@ static void virtio_balloon_instance_init(Object *obj)
     s->free_page_hint_cmd_id = VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
     s->free_page_hint_notify.notify = virtio_balloon_free_page_hint_notify;
 
-    object_property_add(obj, "guest-stats", "guest statistics", NULL,
+    object_property_add(obj, "guest-stats", "guest statistics",
+                        &VirtioBalloonGuestStats_type_info,
                         balloon_stats_get_all, NULL, NULL, NULL);
 
     object_property_add(obj, "guest-stats-polling-interval", "int",
-- 
2.55.0


