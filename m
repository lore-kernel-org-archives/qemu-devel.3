Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949D6CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE76-000410-79; Mon, 15 Jun 2026 16:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE75-00040d-8z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE73-000304-9z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOR5Fz4I8fH5dZge/t0gwMnAmkObJtYhqnACaNL668s=;
 b=E7AsSsetThPklIfo9/q5SaBejVBsmIngq+mnk38MpLkLEC1X5259tXZJU+lyrbJsEOPF19
 Xn7rkI56XzD6hDeOWOonjJ0XxgCU43yWZ0f2ig6pUVQA606arzHWgXkkDA2EH1CAheu247
 BFma1Pl4F6c7LH+67Mg7pAHF73+2z08=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-inQYq1bTMJ2fpN__Qhc1Nw-1; Mon,
 15 Jun 2026 16:40:49 -0400
X-MC-Unique: inQYq1bTMJ2fpN__Qhc1Nw-1
X-Mimecast-MFC-AGG-ID: inQYq1bTMJ2fpN__Qhc1Nw_1781556048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A20D91800345; Mon, 15 Jun 2026 20:40:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7160719560B2; Mon, 15 Jun 2026 20:40:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:01 +0400
Subject: [PATCH v2 35/53] virtio-balloon: convert guest-stats property to
 QAPI type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-35-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10057;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XCk/M4Otn8oLL/1a9v9H08MZ1uICAg0OSwJBeYuC2LI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPt/eOowbKeYty/ipPETkYX6tMK5d2yTCmk
 1o9EzvIpC6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5a87D/0aONkurI0Istem1lRgIKaiFnHFN12tNFuSf1vTqYNpaAjFZqmjuGaPCPQjshun9Dngmab
 0NOUupnhDySe1KbHMLIKdiA4sTkud6TRbp4uEkmUICxbcrEZu7uhb2qY/meuutgtwpbYafv7Ijs
 tFs10HGk/Wty3ekImgWjyasSedp3D+8W+KHn5yMjOcp8oRToxMqMt1uuXponV7NX2vnwec9Od8J
 s/9Q4annZs9Vk2l74EgExiYxb7coWGK0XQ5cLJkia+EsF526ISRFDzmplDcAvCiE4TMzr9dxLD7
 Hty4Rme2sYS4LFVZxq55775I0ExA9VIdj4on0BSndJr/DMhbKZCBnE4jCdQUC4ROf3qhuy3Phiy
 Fnc41x3RiPfJJzDEKxY5jeZBAe9CkWCvholdffar/yLnKKae8o5ly/oZ3Q2hwlHun5Q9E1EW9iu
 BiFBXqwd0+RIfM7L8c1hHxq7lrOO9jKO+7f0dh9hEX5BCKugr9kocVovpIh/hL3ffmm8gY4x8I7
 mANrKlpIheQ6s7tNJast6tQl3WZQXD9eHg1Zs6AQ7vxNxbmsZf6eObopOH/ZHxOHhwOPcbbAeAJ
 mx1yO7g/kyFqqPBaWLs1vYUTrzyq+BY1kMgY0+ffbZcj5W26N5RRcIlllqQiMYjLIVkyKf1rsRE
 riR3yh3l649dWrg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define VirtioBalloonStats and VirtioBalloonGuestStats QAPI struct types
in the schema, replacing the hand-rolled visitor in balloon_stats_get_all()
with a generated visit_type_VirtioBalloonGuestStats() call.

The wire format is preserved: the JSON output from qom-get is identical
to the previous hand-rolled visitor output.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/virtio-balloon-stats.rst | 22 +--------
 qapi/machine.json                     | 92 +++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-balloon.c            | 86 ++++++++++++--------------------
 3 files changed, 124 insertions(+), 76 deletions(-)

diff --git a/docs/interop/virtio-balloon-stats.rst b/docs/interop/virtio-balloon-stats.rst
index b9a6a6edb22..88d3271bbb0 100644
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
index 685e4e29b87..3327f985be2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1131,6 +1131,98 @@
 ##
 { 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
 
+##
+# @VirtioBalloonStats:
+#
+# VirtIO balloon device guest memory statistics.
+#
+# If the guest doesn't support a particular stat, or if it couldn't
+# be retrieved, its value will be -1.
+#
+# @stat-swap-in: The amount of memory that has been
+#     swapped in (in bytes).
+#
+# @stat-swap-out: The amount of memory that has been
+#     swapped out to disk (in bytes).
+#
+# @stat-major-faults: The number of major page faults
+#     that have occurred.
+#
+# @stat-minor-faults: The number of minor page faults
+#     that have occurred.
+#
+# @stat-free-memory: The amount of memory not being used
+#     for any purpose (in bytes).
+#
+# @stat-total-memory: The total amount of memory available
+#     (in bytes).
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
+# @stat-htlb-pgfail: The number of failed hugetlb page
+#     allocations
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
+# Since: 11.1
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
+#
+# Guest statistics from the VirtIO balloon device.
+#
+# @last-update: timestamp in seconds of the last stats
+#     update from the guest (since this timestamp is generated
+#     by the host, a buggy guest can't influence its value),
+#     or 0 if no update has been received yet.
+#
+# @stats: balloon memory statistics
+#
+# Since: 11.1
+##
+{ 'struct': 'VirtioBalloonGuestStats',
+  'data': {
+    'last-update': 'int',
+    'stats': 'VirtioBalloonStats' } }
+
 ##
 # @query-balloon:
 #
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 9e43948128f..c9873f8cf0c 100644
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
@@ -169,33 +171,8 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
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
+/* Update VirtioBalloonStats QAPI type when new stats are added */
+G_STATIC_ASSERT(VIRTIO_BALLOON_S_NR == 16);
 
 /*
  * reset_stats - Mark all items in the stats array as unset
@@ -257,33 +234,31 @@ static void balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
-    bool ok = false;
-    int i;
-
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
+    VirtioBalloonGuestStats guest_stats = {
+        .last_update = s->stats_last_update,
+        .stats = &stats,
+    };
+    VirtioBalloonGuestStats *argp = &guest_stats;
+
+    visit_type_VirtioBalloonGuestStats(v, name, &argp, errp);
 }
 
 static void balloon_stats_get_poll_interval(Object *obj, Visitor *v,
@@ -1020,7 +995,8 @@ static void virtio_balloon_instance_init(Object *obj)
     s->free_page_hint_cmd_id = VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
     s->free_page_hint_notify.notify = virtio_balloon_free_page_hint_notify;
 
-    object_property_add(obj, "guest-stats", "guest statistics",
+    object_property_add_qapi(obj, "guest-stats",
+                        &VirtioBalloonGuestStats_type_info,
                         balloon_stats_get_all, NULL, NULL, NULL);
 
     object_property_add_qapi(obj, "guest-stats-polling-interval", &int_type_info,

-- 
2.54.0


