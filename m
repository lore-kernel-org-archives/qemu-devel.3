Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61A9F94CA7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbI-00010z-Uh; Tue, 21 Apr 2026 16:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb7-0000x8-2U
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb5-0008Qg-5M
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aXWd2xheC1/z+v9Law34/KvsAvj1ejFluJIlYRzmNs4=;
 b=Slh5Exd59MHcJXu6QD3NqbJTHhbrsITtF6zcVd9M2CxeSv9elrUZTfHdgjaQsERc1xc4Ng
 BUAGbOL64rHn/V+tHuRmbF/onTYBb1Kqobtw8y+1Zyzva5kcUG+0k9R1LuqC88Ad+n8uw2
 sZsRjgu1nYku93fqrq41wCQTumUnz2s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-z636bWEuPiegWh0oc0GkHA-1; Tue, 21 Apr 2026 16:21:24 -0400
X-MC-Unique: z636bWEuPiegWh0oc0GkHA-1
X-Mimecast-MFC-AGG-ID: z636bWEuPiegWh0oc0GkHA_1776802884
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8aca154e2b5so18598166d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802883; x=1777407683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXWd2xheC1/z+v9Law34/KvsAvj1ejFluJIlYRzmNs4=;
 b=DMK/LoR5qNDm5T3yDxBTHsvTCQzl3FZVHmn1zAs8M7KzJOpQiht11EPXdHPJVMhBO6
 FO5WmDq3jVdaUhz0L7gOeQw6qRuWT/J+K5OoBdTXnElmj4+Va8Is+B56TdXYB4AfPgIm
 eyLftYcZwRUp4FQBvWF7ZUQTHHQTlBb7nbg5RRtbzNlpgZjI0xUy9UuWOrpzSR5GCH9z
 2OClUMQcn/JrPfopOaCojauQwIAjA93HPr7gh2CW/QIXwUeF7mhtNWo6IzmRMqNjSBsB
 9/qE9KVMwcu5aWwitdyp+j/V7PY+z98PHRTN34ngGzde6dTaJ+MAjkmLycdwmACg8Crz
 lZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802883; x=1777407683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aXWd2xheC1/z+v9Law34/KvsAvj1ejFluJIlYRzmNs4=;
 b=tPJc78gO+JbWFSBV6UBAp/tsI4DYmzIb4Ouii24e+/Elc8AHv9+bRKJxtd4T7MSZ2P
 4WYquCrpZ736tw8saPOsn2ct7OE/gYrLb7z+p7yOwqEhVM9Ebk5OXPaTz6ISpnMgUkTR
 2EvUW7W3sKt8jy6hJfMzH6R7jDWQGfaocj5f9yRHeNBRBDfSpLch26ZU+i+JBRE85kJS
 n1GgSCpD1DcD40zM/vz/tihuJypZSOYaB6fYyVwbNzN94aXH9gSsNQfO3vp0w8RQm8GQ
 kMkBULLpWe1KeHpJ+3hu10HeOYDqg4tF/tbftbCAoyEgCsu3P9W/anchFW69VC3l7e2E
 8XVg==
X-Gm-Message-State: AOJu0Yzt7tgFwFCSUft8v5C/220GtymJ5JRXgGF/lDU+02gcj2gXbrc4
 YG2LL41o7F5cTKpOo8WZ66+boJ6MO+U20gcWznzU5Q6J5hebuxa9zltQFJeQxPB0qFPt2k+QfVI
 IoFJkqftGdgVuj36D7lu68+Q63mha7CdD8Twhpzf4hTiIFssdF04s1C1LScqMFgLU1oqSLbm0bZ
 L/AnE2ZHK9qG7LkDXwY5QGiF050LfIrjtMZST0LQ==
X-Gm-Gg: AeBDiev4Qx6N2f8KVpwgAmwmuLKx9d1hOpy/wLnLTCR838MvrylQ7tYvRe4sr2UYjG3
 dCyI7hVe94Y9EUQzwMjph/K7T4gYf4aSFFfhSc5cHdMFxH5mCph7S59LnZewEW/5ut0zbPa6+LL
 m+6phDfTFG4Y6CxbpaRMDRfUYJWV5A1IwcAafcQPNE9hIL4zx7DfPhZS8Dtg/WtR0+GJZX2h2+N
 H8txGmJlBZp0hPk7lSkRytSuDtJOl2VU9iWZlEZz17v7vljTtgm7ZC5qJvtnH1Zmh4dTCf5YpMy
 3E7Tge7gviplaxEKtNbOAYG+PIQ7M2apifAey9b0kUbloW5COsD02diaH/uDyzT2a2vS/0loCb3
 5lipbBWt/eTeovrZbx/jrsWwbxa1qIqTKj/o9gmHdn/B8XFhbLGURYVXjFA==
X-Received: by 2002:a05:6214:598c:b0:8ac:b6d7:e60e with SMTP id
 6a1803df08f44-8b027fd9d4amr316352556d6.7.1776802883390; 
 Tue, 21 Apr 2026 13:21:23 -0700 (PDT)
X-Received: by 2002:a05:6214:598c:b0:8ac:b6d7:e60e with SMTP id
 6a1803df08f44-8b027fd9d4amr316351876d6.7.1776802882837; 
 Tue, 21 Apr 2026 13:21:22 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:22 -0700 (PDT)
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
Subject: [PATCH v2 06/16] migration: Use the new save_query_pending() API
 directly
Date: Tue, 21 Apr 2026 16:21:00 -0400
Message-ID: <20260421202110.306051-7-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index dfc60372cf..68cfe2d3bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3204,17 +3204,17 @@ typedef enum {
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
@@ -3243,14 +3243,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
index 392d840955..397f602257 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1778,28 +1778,9 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
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
index 60e5087e38..f8995b8d0d 100644
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
@@ -159,8 +160,6 @@ migration_cleanup(void) ""
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


