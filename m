Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAE21091932
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYT-0001P3-Sp; Thu, 19 Mar 2026 19:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYS-0001Oa-2w
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYQ-0001WX-8m
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipcYTYg6wXP+u/zbMbL8eRUnK01vI0ajbEJw8rwturY=;
 b=GXnl8733qKHNGfvqr2LzNIv0rKIic4f9mjHzcbobZPU8tGURTH/N7tDcpkiF1Os/7BAy7c
 IIQC8iaBP0HlmS7TNGlqDGMc1JHq857Wgcl5fgRxgNlVQXHmnhyCf4iFMkGKC/CX8pLXbg
 kJXdoaRKe9iyRlVaMtNlt0nczdcJTKQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-a9MLxu8QMryATVTzCYvz6Q-1; Thu, 19 Mar 2026 19:13:24 -0400
X-MC-Unique: a9MLxu8QMryATVTzCYvz6Q-1
X-Mimecast-MFC-AGG-ID: a9MLxu8QMryATVTzCYvz6Q_1773962004
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b389f2560so11103951cf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962003; x=1774566803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipcYTYg6wXP+u/zbMbL8eRUnK01vI0ajbEJw8rwturY=;
 b=Mx5O8P83jLTIYuRaUcCICdcwgG6FmNiric3ilzWjPvhI61AoIP5uHLMcB6QeNVsuiU
 ypNivFrSlR5cm8+w6l28FswuG69x60lFs9W1e+njq51RLPXdlOpcyF1RpPEmy56Yqk5u
 qBzMl37QpTsBgdtKbg4vnc96c9j6sSB2a7AK13d8HkA6m/I5knWPlALC1CL5eveRozaM
 Xxb+JZxveVEq/xhnlMkC6kPERZsfRFrkTQQluZM7zdGjPIvq0miDHCJFlRy13cPq1jb4
 4MQoc/qGZZ0lqurjcjEYrQDAP0XBj/QVh8ezq28kAAi3udpyOG3GQKhlEiimnDxqQ3hh
 mhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962003; x=1774566803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ipcYTYg6wXP+u/zbMbL8eRUnK01vI0ajbEJw8rwturY=;
 b=hmjhg5Ylgu9cOqh9koBFwDvqfxQ4Ul2x9Ef4ItDWq0qcbypdDQKXk93GYKRJQeIHE8
 atn/d4Jx0igrXN6rb7Hj/6MjfJ93rcynAd9us4KXKyOtrRKpoN7P+eJHQVgKHTJ5imLR
 fnaSvang1c4xA2OW0QNr/tUyhGDm7ExH2gEkidL8Y5Vi0EnYm6XUX3hYff9+X2lOdUoR
 9XT9agP8h5b42kvSQlQvPGP06uHqhh5ZOAuGBVJbZWp31jQskIN8XUE4NWbbVnakJxnH
 pttX1ekiOEjPnz7+E/uMCNRNMi3gsvV1HKRrx1aUMs4gYB+UlY4I4r/FebgFUiLIObAT
 fAKQ==
X-Gm-Message-State: AOJu0YzMafcBFcD3mRHjV4g+xRbKaERaklj7KR0W2gVSoIlyIGV7chZb
 6/dZjr6R3rC4HYUSVWHYRDFuAIddQ20cwReaZhlMiWcZlvVBwTPsQ8wZfeEQzicqvNWnLUvoyw9
 POavSdosNLoVlbKhgYihMwSCVkxKPabevxWoD+lmeMeIGUNvirqduMa+Se4gv/hFAbr3kT6Hut9
 IFcmlm9wxFGoRguYYrj3EhyERcYCRJgq5xT3uyEw==
X-Gm-Gg: ATEYQzynfVnQRWRTbvyafYdx+ChntHJNLiLKBb10vy6hA7NCEzRovCNQOFdzdoWR6QI
 AT2/gZa9Z5EfL81Pr+R0o6R/yBG46TCJIaZlDgfOONqJm4H7EpiMSfT36V/VppJlVJR1f1W2PGI
 RJqwK+fmNB4ODCBgBJqtgXcFGILkKcpuaPkj4XnnSrvLfsOa5pKaq6GJkWvypw7DUSb1wIso8eH
 lpS05qpJ4aKfH+J9LNc3kEnAlGTqa+DIG04/VNR2OV2APjyRVJCY4J9bmZTagn+VhyjO2eeWhn4
 h6rHg0a6uml0OHvTpbRmAwal4TaI9Ma9G751REwkn8syLBYl3pxzVCSt9lDKr1ApjP7aPS1B2z5
 5rAp8b59FwloN1g==
X-Received: by 2002:a05:622a:607:b0:509:aa4:49fa with SMTP id
 d75a77b69052e-50b374b17f9mr16611061cf.34.1773962003302; 
 Thu, 19 Mar 2026 16:13:23 -0700 (PDT)
X-Received: by 2002:a05:622a:607:b0:509:aa4:49fa with SMTP id
 d75a77b69052e-50b374b17f9mr16610341cf.34.1773962002705; 
 Thu, 19 Mar 2026 16:13:22 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
Date: Thu, 19 Mar 2026 19:12:57 -0400
Message-ID: <20260319231302.123135-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Allow modules to report data that can only be migrated after VM is stopped.

When this concept is introduced, we will need to account stopcopy size to
be part of pending_size as before.

One thing to mention is, when there can be stopcopy size, it means the old
"pending_size" may not always be able to reach low enough to kickoff an
slow version of query sync.  While it used to be almost guaranteed to
happen because if we keep iterating, normally pending_size can go to zero
for precopy-only because we assume everything reported can be migrated in
precopy phase.

So we need to make sure QEMU will kickoff a synchronized version of query
pending when all precopy data is migrated too.  This might be important to
VFIO to keep making progress even if the downtime cannot yet be satisfied.

So far, this patch should introduce no functional change, as no module yet
report stopcopy size.

This will pave way for VFIO to properly report its pending data sizes,
which was actually buggy today.  Will be done in follow up patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h | 12 +++++++++
 migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
 migration/savevm.c           |  7 +++--
 migration/trace-events       |  2 +-
 4 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 2320c3a981..3824958ba5 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -17,12 +17,24 @@
 #include "hw/core/vmstate-if.h"
 
 typedef struct MigPendingData {
+    /*
+     * Modules can only update these fields in a query request via its
+     * save_query_pending() API.
+     */
     /* How many bytes are pending for precopy / stopcopy? */
     uint64_t precopy_bytes;
     /* How many bytes are pending that can be transferred in postcopy? */
     uint64_t postcopy_bytes;
+    /* How many bytes that can only be transferred when VM stopped? */
+    uint64_t stopcopy_bytes;
+
+    /*
+     * Modules should never update these fields.
+     */
     /* Is this a fastpath query (which can be inaccurate)? */
     bool fastpath;
+    /* Total pending data */
+    uint64_t total_bytes;
 } MigPendingData ;
 
 /**
diff --git a/migration/migration.c b/migration/migration.c
index 99c4d09000..42facb16d1 100644
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
+    qemu_savevm_query_pending(pending, false);
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
     qemu_savevm_query_pending(&pending, true);
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
-            qemu_savevm_query_pending(&pending, false);
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
index b3285d480f..812c72b3e5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1766,8 +1766,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
 {
     SaveStateEntry *se;
 
-    pending->precopy_bytes = 0;
-    pending->postcopy_bytes = 0;
+    memset(pending, 0, sizeof(*pending));
     pending->fastpath = fastpath;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1780,7 +1779,11 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
         se->ops->save_query_pending(se->opaque, pending);
     }
 
+    pending->total_bytes = pending->precopy_bytes +
+        pending->stopcopy_bytes + pending->postcopy_bytes;
+
     trace_qemu_savevm_query_pending(fastpath, pending->precopy_bytes,
+                                    pending->stopcopy_bytes,
                                     pending->postcopy_bytes);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 5f836a8652..175f09f8ad 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", postcopy=%"PRIu64
+qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
-- 
2.50.1


