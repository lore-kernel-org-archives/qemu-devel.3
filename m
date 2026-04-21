Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C3F94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbE-0000yq-F6; Tue, 21 Apr 2026 16:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb8-0000xM-Sp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb6-0008Qt-DX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08GGg3JxwpdseV0NCpC++cfwyRjqfD6+A5Dnd/iqc6Y=;
 b=YhStOHSQlN9vY7UL0GH8CPDPkd7GeCKRlT6VV73x7dUIr2xxlNqcMCz7GzTFozCBC+eAxL
 eglNitEP30JUD8SIYQ7KzWjLI9E5KUUQ0leYHIj1vPHvv6CMnFJPDasrKJIeXfG7joaIlH
 /Bb0SZDO2+CkWhXNROynPN8rjJlLhWM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-GYCqj8JLMpiQdSr7yrD_Og-1; Tue, 21 Apr 2026 16:21:26 -0400
X-MC-Unique: GYCqj8JLMpiQdSr7yrD_Og-1
X-Mimecast-MFC-AGG-ID: GYCqj8JLMpiQdSr7yrD_Og_1776802886
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ae752c5273so86571906d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802885; x=1777407685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08GGg3JxwpdseV0NCpC++cfwyRjqfD6+A5Dnd/iqc6Y=;
 b=Mq9cjpQ4jqZpIUFvb/dn8E/L6eskXKKmvqIXYU9RvW1GkSU+LZRR7XrUkLBvpMuvAR
 3YCz0aUiPveWPLrzYtzS5sHTgcNRVMmcTwPWtdfNvgygU1B2+TxMbGIPZdTdVpM0H5th
 rih7FaGENpOzK5ZL1gzxsi+kTXU12BtB8E6r+JVt6PidQu4xS05I9fW5uld2DmYKf7Yq
 sqrbiu4pxP6PPJiJAaRGEacE3suOZLaoIu/VL6mnZUVXkdfdLmTLV8i8e/TgRJRHv4tL
 NX1wwbQziRbTV2FvpKinZf4iFkRQA9G5mpj28Vb3dNSpGbAuQjdcXlQOwc2V8JSQYMN3
 /vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802885; x=1777407685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=08GGg3JxwpdseV0NCpC++cfwyRjqfD6+A5Dnd/iqc6Y=;
 b=VX1ObUbum5CzWcG8oThw6IJ8QbQAspiJcBzr68dvbkr55eXLwzfv20iGfSJuM23g2C
 2P5z74IGL0S9ZohgjsJfFHZHUCD6LPrpAXGydhFP/xUlOR8u49KJ6O4jvJ7BCXpVppbp
 gtAygfJ/0DCCN3O1Grfp/eE8kb94wPaEc6KUY84ITq9B1qGwIMWQDtKZ0kVZMHSMT2C4
 MCvm/2TmByZIV2D9mRDJAkQqVYf1VPgaKcJwK6CrNq+3ZeLd35RoHgGt9SvxhW/SDGCM
 pbk2n/6ZJhPAOE1ROBMVChBY9oC41n6aGh3z66MI+/AoQZncOvpGwZXzI+lNC68F7pYf
 4l6A==
X-Gm-Message-State: AOJu0YyKiCkjvMxLZ3V0PE4kWpOppHjOtub9D1ZOMWt52h5c0ja2APPj
 C6kAS5ZPQ1fcnYBdxBdcJm498WJA+l8yyt7LQcek0wBPE/AEgtSJeHbfBRHUbW/B6ssHDqi+Jp2
 vt61mvlqW/notrhuyYAIylRh6i18nHK9s+Mbvc/YHotHkEndDBJwWAnTjd4nnEdkoh92kMsBWcS
 54MShdbi1iVkISzh3fMQ9ennyIUAYfIYpkj4eFDA==
X-Gm-Gg: AeBDietBpZ9hz5EtCyFHFfLtsOxPfG9fEkrUPNPY6j6m3pcle3tfKTOMayzHUaMNssd
 0/FBkqVHR8bZ4juWLN47gjtE76HHmCJ36mqsg6kphBMgaWQGFzAw59GTFy4teeBLJtmop/tjat0
 xSQzRU6/6m16jyuEvC3oTZ7MGP7zEO91F18aNdnopaFDOvi5vD1S8HVeMpuaoMx2M9Q6UFliTHT
 RL60IuncJw3tCM1gu5PnSt2ftmoYx4+Ihhdy7JYjF4SRNJIpVikLr7x+wHV8xtqszlqYnOtMc+F
 MfdMaxMqUGQo0FENFWvvH2ncDbzYMKLPgXH09rXw6lI5MYAfdXNhmoiF0Wb4xcENwfZplAGTDng
 1Dq9+NT3vhNQPhTZjGW0yJOO8Uj0PQfkQZLU/FXcyqPlrHKzp23rsVDD6RA==
X-Received: by 2002:a05:6214:4e08:b0:89c:d886:c022 with SMTP id
 6a1803df08f44-8b027ff9304mr273283706d6.1.1776802885368; 
 Tue, 21 Apr 2026 13:21:25 -0700 (PDT)
X-Received: by 2002:a05:6214:4e08:b0:89c:d886:c022 with SMTP id
 6a1803df08f44-8b027ff9304mr273283066d6.1.1776802884724; 
 Tue, 21 Apr 2026 13:21:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 07/16] migration: Introduce stopcopy_bytes in
 save_query_pending()
Date: Tue, 21 Apr 2026 16:21:01 -0400
Message-ID: <20260421202110.306051-8-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Allow modules to report data that can only be migrated after VM is stopped.

When this concept is introduced, we will need to account stopcopy size to
be part of pending_size as before.

However, when there're data only can be migrated in stopcopy phase, it
means the old "pending_size" may not always be able to reach low enough to
kickoff an slow version of query sync.

It used to be almost guaranteed to happen as all prior iterative modules
doesn't have stopcopy only data.  VFIO may change that fact by having some
data that must be copied during stop phase.

So we need to make sure QEMU will kickoff a synchronized version of query
pending when all precopy data is migrated.  This might be important to VFIO
to keep making progress even if the downtime cannot yet be satisfied.

So far, this patch should introduce no functional change, as no module yet
report stopcopy size.

This paves way for VFIO to properly report its pending data sizes, which
will start to include stop-only data.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h |  7 ++++
 migration/migration.c        | 65 ++++++++++++++++++++++++++++++------
 migration/savevm.c           | 10 ++++--
 migration/trace-events       |  2 +-
 4 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index e2117e8dd4..5e5e0ee432 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -21,6 +21,13 @@ typedef struct MigPendingData {
     uint64_t precopy_bytes;
     /* Amount of pending bytes can be transferred in postcopy */
     uint64_t postcopy_bytes;
+    /* Amount of pending bytes can be transferred only in stopcopy */
+    uint64_t stopcopy_bytes;
+    /*
+     * Total pending data, modules do not need to update this field, it
+     * will be automatically calculated by migration core API.
+     */
+    uint64_t total_bytes;
 } MigPendingData;
 
 /**
diff --git a/migration/migration.c b/migration/migration.c
index 68cfe2d3bf..4b54fda4d7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3198,6 +3198,54 @@ typedef enum {
     MIG_ITERATE_BREAK,          /* Break the loop */
 } MigIterateState;
 
+/* Are we ready to move to the next iteration phase? */
+static bool migration_iteration_next_ready(MigrationState *s,
+                                           MigPendingData *pending)
+{
+    /*
+     * If the estimated values already suggest us to switchover, mark this
+     * iteration finished, time to do a slow sync.
+     */
+    if (pending->total_bytes <= s->threshold_size) {
+        return true;
+    }
+
+    /*
+     * Since we may have modules reporting stop-only data, we also want to
+     * re-query with slow mode if all precopy data is moved over.  This
+     * will also mark the current iteration done.
+     *
+     * This could happen when e.g. a module (like, VFIO) reports stopcopy
+     * size too large so it will never yet satisfy the downtime with the
+     * current setup (above check).  Here, slow version of re-query helps
+     * because we keep trying the best to move whatever we have.
+     */
+    if (pending->precopy_bytes == 0) {
+        return true;
+    }
+
+    return false;
+}
+
+static void migration_iteration_go_next(MigPendingData *pending)
+{
+    /*
+     * Do a slow sync will achieve this.  TODO: move RAM iteration code
+     * into the core layer.
+     */
+    qemu_savevm_query_pending(pending, true);
+}
+
+static bool postcopy_should_start(MigrationState *s, MigPendingData *pending)
+{
+    /* If postcopy's switchver will violate user specified downtime, stop */
+    if (pending->precopy_bytes + pending->stopcopy_bytes > s->threshold_size) {
+        return false;
+    }
+
+    return qatomic_read(&s->start_postcopy);
+}
+
 /*
  * Return true if continue to the next iteration directly, false
  * otherwise.
@@ -3209,12 +3257,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
                         s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
     MigPendingData pending = { };
-    uint64_t pending_size;
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
     qemu_savevm_query_pending(&pending, false);
-    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
 
     if (in_postcopy) {
         /*
@@ -3222,7 +3268,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * postcopy completion doesn't rely on can_switchover, because when
          * POSTCOPY_ACTIVE it means switchover already happened.
          */
-        complete_ready = !pending_size;
+        complete_ready = !pending.total_bytes;
         if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
             (s->postcopy_package_loaded || complete_ready)) {
             /*
@@ -3242,14 +3288,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * postcopy started, so ESTIMATE should always match with EXACT
          * during postcopy phase.
          */
-        if (pending_size <= s->threshold_size) {
-            qemu_savevm_query_pending(&pending, true);
-            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
+        if (migration_iteration_next_ready(s, &pending)) {
+            migration_iteration_go_next(&pending);
         }
 
         /* Should we switch to postcopy now? */
-        if (pending.precopy_bytes <= s->threshold_size &&
-            can_switchover && qatomic_read(&s->start_postcopy)) {
+        if (can_switchover && postcopy_should_start(s, &pending)) {
             if (postcopy_start(s, &local_err)) {
                 migrate_error_propagate(s, error_copy(local_err));
                 error_report_err(local_err);
@@ -3264,11 +3308,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * (2) Pending size is no more than the threshold specified
          *     (which was calculated from expected downtime)
          */
-        complete_ready = can_switchover && (pending_size <= s->threshold_size);
+        complete_ready = can_switchover &&
+            (pending.total_bytes <= s->threshold_size);
     }
 
     if (complete_ready) {
-        trace_migration_thread_low_pending(pending_size);
+        trace_migration_thread_low_pending(pending.total_bytes);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 397f602257..d221e2961b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1766,8 +1766,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
 {
     SaveStateEntry *se;
 
-    pending->precopy_bytes = 0;
-    pending->postcopy_bytes = 0;
+    memset(pending, 0, sizeof(*pending));
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || !se->ops->save_query_pending) {
@@ -1779,8 +1778,13 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
         se->ops->save_query_pending(se->opaque, pending, exact);
     }
 
+    pending->total_bytes = pending->precopy_bytes +
+        pending->stopcopy_bytes + pending->postcopy_bytes;
+
     trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
-                                    pending->postcopy_bytes);
+                                    pending->stopcopy_bytes,
+                                    pending->postcopy_bytes,
+                                    pending->total_bytes);
 }
 
 void qemu_savevm_state_cleanup(void)
diff --git a/migration/trace-events b/migration/trace-events
index f8995b8d0d..d2134af862 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", postcopy=%"PRIu64
+qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
-- 
2.53.0


