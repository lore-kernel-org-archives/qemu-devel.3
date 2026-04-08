Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA0F10F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSo-0004PM-MK; Wed, 08 Apr 2026 15:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY3p-00066S-0S
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCO-00028r-VA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pBpMxP6DqkQFj1pPDgFhUWgDgyZXFHvFl5cTHTGA8Q=;
 b=R/iGrigDDM3J1SigIXBea7EeZNP6Ik0+r7VoswR0FJY0uKPKHKEaPYOSLTl7MlWYeSTTrk
 1Mpynh3faTmVbpX3p17AVyqNjaALdZJNzTklNJOjmvteceFXr1dckOidd+0AJm+CY497At
 BE3uJHNWtFGWejVAk/FQvC1k0VSryyI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-nH0Zvgx6MlmtCQkut6TcMg-1; Wed, 08 Apr 2026 12:56:15 -0400
X-MC-Unique: nH0Zvgx6MlmtCQkut6TcMg-1
X-Mimecast-MFC-AGG-ID: nH0Zvgx6MlmtCQkut6TcMg_1775667375
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d411d0c1faso32841385a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667375; x=1776272175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pBpMxP6DqkQFj1pPDgFhUWgDgyZXFHvFl5cTHTGA8Q=;
 b=ltUE37aQsL1XvzZCFtWckJwIhBDufxfbVSRYplcOeiq/MxHQwrBJlwUwYH5PL5CYrI
 MWJslWRnkhl33mii6TdW1a4juuM7E6HWLUPUwDtt8g+2PtO5N3pFK3++xHEUfKeJUfXE
 3uHeTvcdcmlcZeUa3F2mkOk5Hax9xTq9LoJ9xCNWnB2H2RZZsCq9qoC0g/wBUmDUDuXk
 LAop7sy/x1ND3fIFoigpjGg2wqUEmOJt0mII8wuDFIQB1L/Q0xWBpKxRFfyhvmyze6mc
 V/dSXJ8qi+PpoVuJ0GrllWl0Ef1jf5yr1lVHxFwUAR6di5yyrynGZUD0NVxNwJr8Isx2
 /Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667375; x=1776272175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9pBpMxP6DqkQFj1pPDgFhUWgDgyZXFHvFl5cTHTGA8Q=;
 b=Ovzbg631aolq/t8bFqgbRNRa0CuIO4PCOG88JIy46CumI1yQG0mh1OnCvCdNgHhn5t
 OiF2I3fimwHM8LRT134fK00O8jIGo+eUl6YL3tFTJh0yPDTvkiLDi/PP1yN0HpvVLbnJ
 0aIAB3klf81LJCaaS6xu0lQnElvWsX6WpZEiT1+EuENhdBAiO8kqy11+97zt5zloCQHJ
 LiB2Fs0zbGCr7gN9eQRHnOpNl2R8eafbxRyK64Quj/tCp3z0Jt0MaDsxc+NiuSma0kKR
 LYEaJ3mPcx+BBs6C8uL/PLFUvZb0FsYBpeXdToORRVunwTeybMhwrZs8u0WcgD3HVxge
 3FkQ==
X-Gm-Message-State: AOJu0YzryOYzoqCkIrDTlDIaeewVnxa2KFWURFnDYpgxqkwHk/c5gaZl
 9d7D2U2qXgP+K45yjo0bqcj6fTNjh6Crx5T4qgVPNWZ6ItEyl9kb6pFKoPU/ZBzdkoqIU39xMjQ
 DQwSD1PXoszdXTmOqPj9NdDO4Ea7cIBNFHRYijxEL9gj3l3zBOJSAvc3Htl58Bk+NNYWlVzAVlD
 W9vwh6aNN0+iiymFuC0S8EgfdbPzbgnjJlfwe/AA==
X-Gm-Gg: AeBDiesOPtoQAoRlY1qPOeqjJAtVgB7L9ljDan0MBARxMRxSdAqANzENnKQxjAMmwme
 9EZn1XGGRty1U0YbAaAoEXiRwf+JS93EeHU5r+/zPDrmnzo2dixkwyLqluGWBIAANWZzHrwtVzK
 p1WgGzm6TBsGOzRgPUqiAwts0Pz9nbLtFg4xavrt5H9HESudBV9ghSCu7AZ+E4dgwrBmLIG+Zjr
 kXUCbEx6zhrtgSat4SVLRt+Dj4iUtjXzTONW5sX0qBvBhXJix96huOj1rabLCfyqlgDTqtv1Q1W
 NfD/GJZgAoPok1fEEf0aB4MAxSOIONCGiRQkKUZFMEp9uNquFpt5YtX0Xm4CXPR+7w7WIxFoeMK
 0JrHriXdSCDOGmdhMy7N+CTXxfBJyxJmsxka8y8TiC0Pc
X-Received: by 2002:a05:622a:288:b0:50d:ab9d:33bc with SMTP id
 d75a77b69052e-50dc20d670fmr1801491cf.8.1775667374285; 
 Wed, 08 Apr 2026 09:56:14 -0700 (PDT)
X-Received: by 2002:a05:622a:288:b0:50d:ab9d:33bc with SMTP id
 d75a77b69052e-50dc20d670fmr1800691cf.8.1775667373506; 
 Wed, 08 Apr 2026 09:56:13 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:12 -0700 (PDT)
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
Subject: [PATCH 08/14] migration: Make qemu_savevm_query_pending() available
 anytime
Date: Wed,  8 Apr 2026 12:55:52 -0400
Message-ID: <20260408165559.157108-9-peterx@redhat.com>
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

After qemu_savevm_query_pending() be exposed to more code paths, it can be
used at very early stage when migration started and this may expose some
race conditions that we don't use to have.  This patch make it prepared
for such use cases so this API is fine to be used almost anytime.

What matters here is, querying pending for each module normally depends on
save_setup() being run first, otherwise modules may not be ready for the
query request.

Consider an early cancellation of migration after SETUP status but before
invocations of save_setup() hooks, source QEMU may fall into CANCELLING
stage directly from SETUP (not ACTIVE, which is the normal use case), in
which case save_setup() may not have been invoked and modules are not
ready.  However qemu_savevm_query_pending() may still be used in QMP
commands like query-migrate and causing crashes.

Guard such use case by introducing a boolean reflecting the availability of
vmstate save handlers on correct completions of save_setup()s.  So far,
only protect qemu_savevm_query_pending() with it.  Logically other hooks
face similar concern, but most of them shouldn't be reachable from random
code path except migration thread so it should be fine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  8 ++++++++
 migration/savevm.h    |  2 +-
 migration/migration.c |  2 +-
 migration/savevm.c    | 37 +++++++++++++++++++++++++++++++++----
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..e504df6915 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -522,6 +522,14 @@ struct MigrationState {
      * anything as input.
      */
     bool has_block_bitmap_mapping;
+
+    /*
+     * This boolean reflects if the vmstate handlers have been properly
+     * setup on source side.  It is set after vmstate save_setup() hooks
+     * are successfully invoked, and cleared after save_cleanup()s.  It
+     * reflects a general availability of vmstate hooks on the source side.
+     */
+    bool save_setup_ready;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/savevm.h b/migration/savevm.h
index 96fdf96d4e..04ed09cec2 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -42,7 +42,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_send_header(QEMUFile *f);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
-void qemu_savevm_state_cleanup(void);
+void qemu_savevm_state_cleanup(MigrationState *s);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s);
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
diff --git a/migration/migration.c b/migration/migration.c
index bb17bd0e68..a9ee3360e1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1283,7 +1283,7 @@ static void migration_cleanup(MigrationState *s)
     g_free(s->hostname);
     s->hostname = NULL;
 
-    qemu_savevm_state_cleanup();
+    qemu_savevm_state_cleanup(s);
     cpr_state_close();
     cpr_transfer_source_destroy(s);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index b75c311a95..1d3fce45b9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1387,7 +1387,8 @@ int qemu_savevm_state_non_iterable_early(QEMUFile *f,
     return 0;
 }
 
-static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
+static int qemu_savevm_state_setup(MigrationState *s, QEMUFile *f,
+                                   Error **errp)
 {
     SaveStateEntry *se;
     int ret;
@@ -1409,6 +1410,13 @@ static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         }
     }
 
+    /*
+     * Logically, it should be paired with any hook being used who needs to
+     * load_acquire() the flag first.  So far, only save_query_pending()
+     * uses it.
+     */
+    qatomic_store_release(&s->save_setup_ready, true);
+
     return 0;
 }
 
@@ -1429,7 +1437,7 @@ int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp)
         return ret;
     }
 
-    ret = qemu_savevm_state_setup(f, errp);
+    ret = qemu_savevm_state_setup(ms, f, errp);
     if (ret) {
         return ret;
     }
@@ -1764,10 +1772,23 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
 
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
 {
+    MigrationState *s = migrate_get_current();
     SaveStateEntry *se;
 
     memset(pending, 0, sizeof(*pending));
 
+    /*
+     * This API can be invoked very early before SETUP is properly done, in
+     * that case don't invoke module queries because they're not ready.
+     * Just report all zeros.
+     *
+     * This is paired with save_setup_ready updates on save_setup() and
+     * save_cleanup().
+     */
+    if (!s || !qatomic_load_acquire(&s->save_setup_ready)) {
+        return;
+    }
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || !se->ops->save_query_pending) {
             continue;
@@ -1786,7 +1807,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
                                     pending->postcopy_bytes);
 }
 
-void qemu_savevm_state_cleanup(void)
+void qemu_savevm_state_cleanup(MigrationState *s)
 {
     SaveStateEntry *se;
     Error *local_err = NULL;
@@ -1795,6 +1816,14 @@ void qemu_savevm_state_cleanup(void)
         error_report_err(local_err);
     }
 
+    s->save_setup_ready = false;
+    /*
+     * Make sure we clear the flag before invoking save_cleanup(), so any
+     * racy QMP query-migrate won't try to invoke any save hooks.  Just use
+     * an explicit barrier to be simple.
+     */
+    smp_mb();
+
     trace_savevm_state_cleanup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->ops && se->ops->save_cleanup) {
@@ -1841,7 +1870,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         error_setg_errno(errp, -ret, "Error while writing VM state");
     }
 cleanup:
-    qemu_savevm_state_cleanup();
+    qemu_savevm_state_cleanup(ms);
 
     if (ret != 0) {
         status = MIGRATION_STATUS_FAILED;
-- 
2.53.0


