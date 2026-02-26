Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9BBFCE08C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbvP-00033K-1c; Thu, 26 Feb 2026 09:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbv7-0002iN-GB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbv2-0006KS-Di
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772114442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXYnbdQyIwBONsl+rO+1NpKwtNwPjj8Hi2z+cNrS7zU=;
 b=gDd0s9dA2sSYwVieNLAe06tLiMapkxzozXf+AQQ1Zzw2giLmrWfd6cRTpetBFKj2gn9mwp
 cCHqdi4PTvhbVznoOHcusw2VpVxcNSnHB/OruG74UUGosNHaGP0ZufxV8ZrVxPwKWcl4wv
 Jh2vnXFYh5qlM1MFZcbsE2DEFySfgFU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-fisDdXWDO0uZBI5AE8J7oA-1; Thu,
 26 Feb 2026 09:00:38 -0500
X-MC-Unique: fisDdXWDO0uZBI5AE8J7oA-1
X-Mimecast-MFC-AGG-ID: fisDdXWDO0uZBI5AE8J7oA_1772114437
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F50E1800464; Thu, 26 Feb 2026 14:00:37 +0000 (UTC)
Received: from localhost (unknown [10.45.242.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF2551800370; Thu, 26 Feb 2026 14:00:35 +0000 (UTC)
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
Subject: [PATCH v3 09/15] system/ram-discard-manager: implement replay via
 is_populated iteration
Date: Thu, 26 Feb 2026 14:59:54 +0100
Message-ID: <20260226140001.3622334-10-marcandre.lureau@redhat.com>
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Replace the source-level replay wrappers with a new
replay_by_populated_state() helper that iterates the section at
min-granularity, calls is_populated() for each chunk, and aggregates
consecutive chunks of the same state before invoking the callback.

This moves the iteration logic from individual sources into the manager,
preparing for multi-source aggregation where the manager must combine
state from multiple sources anyway.

The replay_populated/replay_discarded vtable entries in
RamDiscardSourceClass are no longer called but remain in the interface
for now; they will be removed in follow-up commits along with the
now-dead source implementations.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/ram-discard-manager.c | 85 ++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 1c9ff7fda58..25beb052a1e 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -27,26 +27,65 @@ static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
     return rdsc->is_populated(rds, section);
 }
 
-static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
-                                               const MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
+/*
+ * Iterate the section at source granularity, aggregating consecutive chunks
+ * with matching populated state, and call replay_fn for each run.
+ */
+static int replay_by_populated_state(const RamDiscardManager *rdm,
+                                     const MemoryRegionSection *section,
+                                     bool replay_populated,
+                                     ReplayRamDiscardState replay_fn,
+                                     void *opaque)
 {
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+    uint64_t granularity, offset, size, end, pos, run_start;
+    bool in_run = false;
+    int ret = 0;
 
-    g_assert(rdsc->replay_populated);
-    return rdsc->replay_populated(rds, section, replay_fn, opaque);
-}
+    granularity = ram_discard_source_get_min_granularity(rdm->rds, rdm->mr);
+    offset = section->offset_within_region;
+    size = int128_get64(section->size);
+    end = offset + size;
+
+    /* Align iteration to granularity boundaries */
+    pos = QEMU_ALIGN_DOWN(offset, granularity);
+
+    for (; pos < end; pos += granularity) {
+        MemoryRegionSection chunk = {
+            .mr = section->mr,
+            .offset_within_region = pos,
+            .size = int128_make64(granularity),
+        };
+        bool populated = ram_discard_source_is_populated(rdm->rds, &chunk);
+
+        if (populated == replay_populated) {
+            if (!in_run) {
+                run_start = pos;
+                in_run = true;
+            }
+        } else if (in_run) {
+            MemoryRegionSection tmp = *section;
+
+            if (memory_region_section_intersect_range(&tmp, run_start,
+                                                      pos - run_start)) {
+                ret = replay_fn(&tmp, opaque);
+                if (ret) {
+                    return ret;
+                }
+            }
+            in_run = false;
+        }
+    }
 
-static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
-                                               const MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
-{
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+    if (in_run) {
+        MemoryRegionSection tmp = *section;
 
-    g_assert(rdsc->replay_discarded);
-    return rdsc->replay_discarded(rds, section, replay_fn, opaque);
+        if (memory_region_section_intersect_range(&tmp, run_start,
+                                                  pos - run_start)) {
+            ret = replay_fn(&tmp, opaque);
+        }
+    }
+
+    return ret;
 }
 
 RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
@@ -78,8 +117,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    return ram_discard_source_replay_populated(rdm->rds, section,
-                                               replay_fn, opaque);
+    return replay_by_populated_state(rdm, section, true, replay_fn, opaque);
 }
 
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
@@ -87,8 +125,7 @@ int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    return ram_discard_source_replay_discarded(rdm->rds, section,
-                                               replay_fn, opaque);
+    return replay_by_populated_state(rdm, section, false, replay_fn, opaque);
 }
 
 static void ram_discard_manager_initfn(Object *obj)
@@ -182,8 +219,8 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
     rdl->section = memory_region_section_new_copy(section);
     QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
 
-    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                              rdm_populate_cb, rdl);
+    ret = ram_discard_manager_replay_populated(rdm, rdl->section,
+                                               rdm_populate_cb, rdl);
     if (ret) {
         error_report("%s: Replaying populated ranges failed: %s", __func__,
                      strerror(-ret));
@@ -208,8 +245,8 @@ int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)
     int ret = 0;
 
     QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
-        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                                  rdm_populate_cb, rdl);
+        ret = ram_discard_manager_replay_populated(rdm, rdl->section,
+                                                   rdm_populate_cb, rdl);
         if (ret) {
             break;
         }
-- 
2.53.0


