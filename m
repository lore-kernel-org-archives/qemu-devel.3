Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA530CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMA-0004S7-SP; Tue, 05 May 2026 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM7-0004QT-Nq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM5-0002cT-PH
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dC1qfNQleJy8e4gs+qK727UJ4brhGZIIHFtrIFxT4w=;
 b=MNRmERA1aHtcusIT+86n56x9HpdOBIS7+jYAVUrNJzG1NtSjM4QWRcSauaRksWd6rGJF5U
 6JrYm0Iy4Q6DAbz2b/z4Wh4kq3K/mpjgREKURERoo1DPQ1815GermpulzfpHSxvT0q3Rc8
 p27SK/a9d9olwuiVuNnJ5OCgg7GB5jE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-WrEcZGZaOpucLwz0sWOx0Q-1; Tue, 05 May 2026 16:26:55 -0400
X-MC-Unique: WrEcZGZaOpucLwz0sWOx0Q-1
X-Mimecast-MFC-AGG-ID: WrEcZGZaOpucLwz0sWOx0Q_1778012815
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b5f089a5c3so124372356d6.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012815; x=1778617615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dC1qfNQleJy8e4gs+qK727UJ4brhGZIIHFtrIFxT4w=;
 b=tHCq57IGFdngi8zGcMAamTyCtQ4YDmEnb3eN56RFaF13R3+SfrymAT+2Zn0auyvTRw
 H98J5bkAobHn49w5TltKlkC8MrFNFhhTmhON/qHeHjCBT+zoL09YDIm5gEHUSZvPC+uf
 iHyMSl5FhulbtMEo0boTJUO08or481jneeau+KDPCfKmHDzjC+oNfNoV5MBo47BQa8Fc
 QYJ8D9eemJlbLv6I5I2uWB9L1vFk5yRs3nsBcKhJIvrDEGlumPvfHbnuHtR4vSLi8+A6
 1Ib8iuoV0gb+ZisULhuupA7HUWRCXO9OdOCHXtFd3Z9/ZJGaGHbTW9iHmfIf0V/483fQ
 1pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012815; x=1778617615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3dC1qfNQleJy8e4gs+qK727UJ4brhGZIIHFtrIFxT4w=;
 b=lIQggvhujEeyH1yp6CU5+6hR8myZ70RAYagAZSQRpW9GI4MOYiawgKdaeH0LrAhV2h
 Omodza1K3XgOrW8CImhgpqzN/WCh8y5cPlMVdS7Ddmehmn9gDqlXJtqNPmRNAWH3ZwkQ
 hrosXwTuMMVmBxfCR62inUcEUP57Jo8XQqmO39jjlClpkM1qW3c37w4soUy0ZByjUq2i
 kORG8y0z3dnyZzAYVNq1kL1BsNTy860fjV01jxAhbAf7bROnHCn+WBhhNaHE1/eTD/+X
 4PUiyzWihMc8EVC3ccgc1a96fQlk8TcRhV9zEj43MRTEmIhtJm7Rx1JBrpKORe5vt2QF
 HLYA==
X-Gm-Message-State: AOJu0YwQ9NuGnP4Vo6L9lpkpWdsiECgNmI2e0lqTYjiaBnZvm5Z2vJSX
 AVq3bkCWD0J9RYB8myzgeeXcECV8EseNWqESaUNzegsMUIvIS/pmr5kFkRfVr6dHC36/QBaa71P
 aH/TPvuFodNL8k4pemFOps6iMwOWTZ+hDWyDQN0jey/MVS2VLwtDFFavbcbV/JhIkRNWw52VyV3
 zpbw7+FrXiP/Y0wbAGDZWbw6TYfBaJmhT2Hr01Sw==
X-Gm-Gg: AeBDieu9llyLVA6rRSr7ITxfccqTuURlaT/pn4gCCJTXVaFHL6KJtgL7VHUIPdgxrRk
 kJSlwv97PrmObNgzXhL8dV3T+bUvpW6X6BwnUD2AFsE14G/vFcoTrZSGwkpKErsJzEACinKtjd3
 xlfONc1u/CGP0fJEtACfkBzRX70dlLeAZUGv/6wl0DIvzg9n+O7xmW5xDiWllRgmlMWkjE96/az
 WPegDNcztEhuF0QVl6a99jgxzydSAtSCgTzRr6HclRq4p0DuQsL3byYpeD8VyhCsihryfEDrHPe
 c1pcPYaIDZEgOq/Fm8goTHFMvOUpWMdEUYKmnHT6xrvYAZPQyTbTZzmFS6nFMMuZUkVcs6Npr/B
 OYq4sRVZ8GwUUjquhxz4YtCQFzzu5WWotMqNScNtZFohJWPbnYen77Eg=
X-Received: by 2002:a05:6214:2245:b0:8b9:428a:e640 with SMTP id
 6a1803df08f44-8bc41bcab79mr5615216d6.2.1778012814605; 
 Tue, 05 May 2026 13:26:54 -0700 (PDT)
X-Received: by 2002:a05:6214:2245:b0:8b9:428a:e640 with SMTP id
 6a1803df08f44-8bc41bcab79mr5614276d6.2.1778012813861; 
 Tue, 05 May 2026 13:26:53 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 08/23] migration: Use the new save_query_pending() API directly
Date: Tue,  5 May 2026 16:26:25 -0400
Message-ID: <20260505202640.1011006-9-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It's easier to use the new API directly in the migration iterations.  This
also paves way for follow up patches to add new data to report directly to
the iterator function.

When at it, merge the tracepoints too into one.

No functional change intended.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/r/20260421202110.306051-7-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h     |  4 ----
 migration/migration.c  | 16 +++++++---------
 migration/savevm.c     | 23 ++---------------------
 migration/trace-events |  3 +--
 4 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index e4efd243f3..96fdf96d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -46,10 +46,6 @@ void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s);
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
-void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
-                                     uint64_t *can_postcopy);
-void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-                                        uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index 5f4efb1fe5..c75ad01b64 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3208,17 +3208,17 @@ typedef enum {
  */
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
-    uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
     bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
                         s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
+    MigPendingData pending = { };
+    uint64_t pending_size;
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
-    pending_size = must_precopy + can_postcopy;
-    trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
+    qemu_savevm_query_pending(&pending, false);
+    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
 
     if (in_postcopy) {
         /*
@@ -3259,14 +3259,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * during postcopy phase.
          */
         if (pending_size <= s->threshold_size) {
-            qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
-            pending_size = must_precopy + can_postcopy;
-            trace_migrate_pending_exact(pending_size, must_precopy,
-                                        can_postcopy);
+            qemu_savevm_query_pending(&pending, true);
+            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
         }
 
         /* Should we switch to postcopy now? */
-        if (must_precopy <= s->threshold_size &&
+        if (pending.precopy_bytes <= s->threshold_size &&
             can_switchover && qatomic_read(&s->start_postcopy)) {
             if (postcopy_start(s, &local_err)) {
                 migrate_error_propagate(s, error_copy(local_err));
diff --git a/migration/savevm.c b/migration/savevm.c
index 41f1906598..72454e15ad 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1812,28 +1812,9 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
         }
         se->ops->save_query_pending(se->opaque, pending, exact);
     }
-}
-
-void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-                                        uint64_t *can_postcopy)
-{
-    MigPendingData pending;
-
-    qemu_savevm_query_pending(&pending, false);
-
-    *must_precopy = pending.precopy_bytes;
-    *can_postcopy = pending.postcopy_bytes;
-}
-
-void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
-                                     uint64_t *can_postcopy)
-{
-    MigPendingData pending;
-
-    qemu_savevm_query_pending(&pending, true);
 
-    *must_precopy = pending.precopy_bytes;
-    *can_postcopy = pending.postcopy_bytes;
+    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
+                                    pending->postcopy_bytes);
 }
 
 void qemu_savevm_state_cleanup(void)
diff --git a/migration/trace-events b/migration/trace-events
index 34143b14b4..ca7dfd4cb7 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
+qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", postcopy=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
@@ -161,8 +162,6 @@ migration_cleanup(void) ""
 migrate_error(const char *error_desc) "error=%s"
 migration_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
-migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
-migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
 migration_completion_file_err(void) ""
-- 
2.53.0


