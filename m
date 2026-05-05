Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D44DCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMJ-0004VZ-8w; Tue, 05 May 2026 16:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM9-0004RX-LZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM7-0002cZ-Gn
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1g/dHZLkAZyHMwXIVaTr59DbBEgq11pSkULpZNk7i8=;
 b=fpKLovHGYdv7czmQJGZ7oAVWZilJS16Dt8quR94LjmnkGCwzQMw74BxBlI0iPqpPe4+ZAJ
 6p4GvSITHMoye54/4Al5BocDNejJ8s49N9wqpoz6niQ/JSJcdPl+HoaYqN6H/GplKqUeFE
 yNvJ1NDW3rxQxbOJF7ZapgRsn89hSJ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-3raALB0HMJ-LVSoB2fnW9A-1; Tue, 05 May 2026 16:26:56 -0400
X-MC-Unique: 3raALB0HMJ-LVSoB2fnW9A-1
X-Mimecast-MFC-AGG-ID: 3raALB0HMJ-LVSoB2fnW9A_1778012816
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b1f4478ca7so154658396d6.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012816; x=1778617616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1g/dHZLkAZyHMwXIVaTr59DbBEgq11pSkULpZNk7i8=;
 b=IQ17ETQ48D2MpgiQlu008B5abfz62KjGhuqtUsyWInWCxIsjPEwPGByQABxS7zm8xt
 27h1I29xkZ8h4wOfWCpmo6H0H/UZ1ReiHKhZ6VX8QfjhYjAP/ZMpKQrmzK8/3JKbPHT6
 C88Dyp1ANWdxUtiP/TQ1kHPByr946CCAAUO4Phrar8K+lLqkHN9rb//Qlf5wjEFY4J6u
 y47ishP/q1hZ7oiwgEQFJ8Oe9gpPzm/A06yTbxq5bnsgrYtHJ8W6lmRYEShnqO/L9weW
 NsBqg3LaObIgxIcgtsLydoNTf7ekU7IKJbbfkzvqLqlTKYnNfM7Q8abzZL+ZB2vQ6OKd
 2mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012816; x=1778617616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1g/dHZLkAZyHMwXIVaTr59DbBEgq11pSkULpZNk7i8=;
 b=j4waB996sPLSFMt1rAFMhFpcA3iYlB+poNZ4rlbMF6MFvstaQp4B+nLnms4BUKU3jL
 oRPErsqOtD/lHvLC9sMn0ZDW9qrdr8jEEahBpsa4bWLpH4Hxhqj2dZkYu5ycu1B00IEg
 rzBz+Xc5jLvNKe/SX3hjMXHgRVXHOfLWS2Ptln3lFn0nYvKivweTuMqCgCaLmZ9HD0py
 xZqKMSzFUpXWvl2PSgUOELNEx2doFihdSRBbuobyl399VaQtbMlV+tF2cUk9ceMUKueN
 GsMLc60wsVod+tWUCxX9awyxi767K+BRaupOQqMjVK2iygsT0AgHUq2kkJtdPiPtjkKo
 vxbQ==
X-Gm-Message-State: AOJu0Yy3fhBNqAOlNPoQfZJoKB2RyvVWpSlsIPqX++bxP2gt8LirLdGv
 kNKidnLHb2FuJ4QtrY8tqOdx5kvRKwg3AW9anZyPUdPJXH+M5iXZs5GCzk5duJBrpgUbtQQtdcH
 B/5nwQ7TT3udzMQhaQPq8IWwNuNcwYdl7XlZG3cP6WqjpmH/HSB1/6dSsnZ9PUjOZzntNDkVx2T
 Yqm+MNFGx0FG9X8AjJ5uVG0QCFxfW373GJtbxHjw==
X-Gm-Gg: AeBDievZhCzq78OJMvHq5SKEioVpcs3GCwM+doiMz0ZmlFF+FPyBDOY1GjJRhch0EnC
 wd0Xa1/DDaIqqYQJJPWDqRd5p5m9zI+JBZsYyFg5LDTBvuOpCAp4TeWLzBJCv3tDtdeaGhxMrYR
 qWuatOy63qxSsq0WNGWi4fV2M1tn8aoAA5gMPOXM0aA+iazGGTNR8InftQ4O8XmDMLOJfI0ukwO
 wi8HxelQTH8Vwx70S9b81/EFrUtv2mQyp+F7H+TJoxuNgmyKLVfMekfd9y2xjO8Wu9PL/0XGmA5
 wzqYx67mRqMNanEN7ZlF2+ZW720rslHUJlABbh9BH+UdX+qnzVUZV8IDatXLRlxIbDO29Zu+Kbr
 a5vuWIyhBqZF5Q6hHzdj87FfVf161JeB6YbqrZ7LXArzfeBDbBK++DrM=
X-Received: by 2002:a05:6214:5a06:b0:8a5:e0a7:d9a7 with SMTP id
 6a1803df08f44-8bc42784419mr5048366d6.9.1778012815675; 
 Tue, 05 May 2026 13:26:55 -0700 (PDT)
X-Received: by 2002:a05:6214:5a06:b0:8a5:e0a7:d9a7 with SMTP id
 6a1803df08f44-8bc42784419mr5047506d6.9.1778012814948; 
 Tue, 05 May 2026 13:26:54 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 09/23] migration: Introduce stopcopy_bytes in
 save_query_pending()
Date: Tue,  5 May 2026 16:26:26 -0400
Message-ID: <20260505202640.1011006-10-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-8-peterx@redhat.com
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
index c75ad01b64..049b69fbe7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3202,6 +3202,54 @@ typedef enum {
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
@@ -3213,12 +3261,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
@@ -3226,7 +3272,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * postcopy completion doesn't rely on can_switchover, because when
          * POSTCOPY_ACTIVE it means switchover already happened.
          */
-        complete_ready = !pending_size;
+        complete_ready = !pending.total_bytes;
         if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
             (s->postcopy_package_loaded || complete_ready)) {
             /*
@@ -3258,14 +3304,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
@@ -3280,11 +3324,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
index 72454e15ad..39430470aa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1800,8 +1800,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
 {
     SaveStateEntry *se;
 
-    pending->precopy_bytes = 0;
-    pending->postcopy_bytes = 0;
+    memset(pending, 0, sizeof(*pending));
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || !se->ops->save_query_pending) {
@@ -1813,8 +1812,13 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
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
index ca7dfd4cb7..de99d976ab 100644
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


