Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ECF10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVz-0005ff-B4; Wed, 08 Apr 2026 15:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY6o-0007AB-9d
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCL-00028T-Kz
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/so6tADcpAnszGZfb6E8GQmrFKlFQ/pKW4GZKB1ulXc=;
 b=aTfhsN5vidp+EnI1PgGgNloMwRDYe0L7A3/mO9embGFDfP8gAZP2pLTVi2ensfDILaD16v
 aITdW1e7Yk/2l0mXSKbnP0c2STTrvga+m3heOUUpXz3CW5YxxFYJ+NT/A9yS4amf+jZIzu
 QiZ6KvjwvKYVc/jhvl0RBDPTa/gYC3I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-0mmlNPhOPf2omk0CpvAyOA-1; Wed, 08 Apr 2026 12:56:11 -0400
X-MC-Unique: 0mmlNPhOPf2omk0CpvAyOA-1
X-Mimecast-MFC-AGG-ID: 0mmlNPhOPf2omk0CpvAyOA_1775667371
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8c192b3fso3701361cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667371; x=1776272171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/so6tADcpAnszGZfb6E8GQmrFKlFQ/pKW4GZKB1ulXc=;
 b=jnQx1ibA7s9H6Bee7rOSt9NL5mVJydGGB3tZJ50Zi6tCmahyhHmoFeEsjfv9kAX5HT
 l4fadRvM85WBt+MDNfBS3WX4RRujGjIRhtTBp5gwTeDapwpZJBY48aFzd4V3+b48ONMd
 cm+J7VpylzrUGE1gaQEOl/Me7tFz/RhZdIXVzZDOOex5Ztlw3JGbdKgNqBQqNjj4qZLa
 tiZyF7D5KTmLokRF2WNNLGW98IpcNt6gqhJwIcUjxZq0esT9a3Ge2vwcb3u54J+0h8Wp
 FYsNxNlWmxgblOKBiQcoHvPrq6wN1N2FKqHjk32KNQ85LH+W8xTgH8/V7Jk1jdpUbuOQ
 OOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667371; x=1776272171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/so6tADcpAnszGZfb6E8GQmrFKlFQ/pKW4GZKB1ulXc=;
 b=qt5VLKKS/AjKvH35ebrQezWWYtg0Ua53xz8cfDCvvuEbexsLthwBG7kjlPbmUq/Dlr
 erJZh9THIymFYuD8vy/rPQldpgvzuICiobjtjepxfkrquMcJkTFb/H4rkGjpWA7rj99F
 G4KvMKeJvdb/T3OM0OTgUIW9mYegWPtgg/Pis9v0h28xB7wWSvc7eojFEpgKVDdaC2fu
 njjBGmrCn4ttrWmtVlXzfGALYq23C5OQMl/BzRvgg54C0aUPIE4TCcrr3FJ/KagSM7xF
 wmhQLg3KwcUzQNyX1dPKBmztRAiP+64kii+Ujm83M/5Mmq1qQJouDTSr+BQIDtaL5sjC
 sMVw==
X-Gm-Message-State: AOJu0YzIEIGOuc5JCyjTVQz+kGJ4GFattKiqW5GjvY2QNLKK6iqhpG/9
 rhIOPL8hqTKoz1Q4yhxuCzGtJb9uefT1NSlmelRhlK0N/YSehycL8rBQ0TidIkbEp3nhx35k9zJ
 QZmki9CRXyLG/vqmi8daJzQBnnukSZve23MNfg7oRMPkp1OSAh5PSrJLS0yRCDiRoxy5/3E4v5A
 MHC9/AOz6NHaIBpV+Li2ufp4UWSUt/sdDjT2N12g==
X-Gm-Gg: AeBDiev1a3AQETaPW9DkhKb9Y1BNinrqnwdPQp+fMy/CbyBqS36Nip4zSqd7TOYA35+
 PYi+PXFFrGFpCk0s+Im3bu/WrWtNBeZsLDqhweP7J+zlX8PblOocg8Qwo4k6j5yUPvcYZi/LZu2
 C/QZLfzp6dzTzXWir7y+ekibi0xBUgTXAlUAySZnjx9SSdzCsvlyMFpAKhPhy4FGVcNS+Phb4Tc
 //ZevUZfoBoDx2LGm3eIbyi9DdC2Wku9mmLeUtRffN8Bf3CA09Lb5t49pRG9gYeJwKPrntJLury
 4VFsQRyJVOMy/Co1/KDtB3iKmlEIB+muzGBMz/NLxPxl6suzSluLUAjACZjRa7dQyJGlNLb9GOD
 IY60qhWIl/uPkhs3aJL9/D1WJzW+OfujtLzQEfM6yEyQg
X-Received: by 2002:a05:622a:540c:b0:50d:81c4:4c85 with SMTP id
 d75a77b69052e-50dc224d638mr1233171cf.36.1775667370587; 
 Wed, 08 Apr 2026 09:56:10 -0700 (PDT)
X-Received: by 2002:a05:622a:540c:b0:50d:81c4:4c85 with SMTP id
 d75a77b69052e-50dc224d638mr1232261cf.36.1775667369944; 
 Wed, 08 Apr 2026 09:56:09 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH 06/14] migration: Introduce stopcopy_bytes in
 save_query_pending()
Date: Wed,  8 Apr 2026 12:55:50 -0400
Message-ID: <20260408165559.157108-7-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h |  7 +++++
 migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
 migration/savevm.c           |  7 +++--
 migration/trace-events       |  2 +-
 4 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index aba3c9af2f..e822a2a59f 100644
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
index 68cfe2d3bf..bb17bd0e68 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3198,6 +3198,44 @@ typedef enum {
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
 /*
  * Return true if continue to the next iteration directly, false
  * otherwise.
@@ -3209,12 +3247,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
@@ -3222,7 +3258,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * postcopy completion doesn't rely on can_switchover, because when
          * POSTCOPY_ACTIVE it means switchover already happened.
          */
-        complete_ready = !pending_size;
+        complete_ready = !pending.total_bytes;
         if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
             (s->postcopy_package_loaded || complete_ready)) {
             /*
@@ -3242,9 +3278,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
@@ -3264,11 +3299,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
index 397f602257..b75c311a95 100644
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
@@ -1779,7 +1778,11 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
         se->ops->save_query_pending(se->opaque, pending, exact);
     }
 
+    pending->total_bytes = pending->precopy_bytes +
+        pending->stopcopy_bytes + pending->postcopy_bytes;
+
     trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
+                                    pending->stopcopy_bytes,
                                     pending->postcopy_bytes);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index f8995b8d0d..2f86ad448e 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", postcopy=%"PRIu64
+qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
-- 
2.53.0


