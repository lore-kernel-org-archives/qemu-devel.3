Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D7FCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYN-0000xi-AL; Wed, 20 May 2026 17:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYM-0000xG-9j
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYK-00078d-1d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Av+kt2qGFE219m05KfncIX215HPEdoJL5n4U5TvcwDk=;
 b=gOV8oTZAil0j6eukrcqZiyiFcMO8NRBKy51Yf5gBeDtSYKEuXF+x1NRB4gMLPN7eQ8AFGY
 aSp7arPoM0dxSIErN8U6B+UkiF6Y6Th+EfrRaqs2dpQ3kDQtDydeHXy9Xl97TruNC4Om1O
 OF/M4Pebo75V0X1pJoYr7A2HVBwAouA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-CKZnYt-fPvKEmd9wiwUtzA-1; Wed, 20 May 2026 17:34:05 -0400
X-MC-Unique: CKZnYt-fPvKEmd9wiwUtzA-1
X-Mimecast-MFC-AGG-ID: CKZnYt-fPvKEmd9wiwUtzA_1779312845
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8aca29dcd69so155636726d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312845; x=1779917645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Av+kt2qGFE219m05KfncIX215HPEdoJL5n4U5TvcwDk=;
 b=Kejsqi1aC0EJTCkBG7SjmoFcijfGZJGxhuKWi+C/FJCyn4FScq80U6sBwfGfdSkTkI
 IasJYP3btZBgv+8TwUyZRQnQwv59Q9dr7N6ug1ZrwbElMZUCd8mwfFh13HaOyFRmvjCg
 7GuJJp254nsQQmLK/xgnVX94ew7cmCxtrlrJMjRJPb3ECxEulz9TKi4z6P1kVnXt5MHZ
 GItMPr1Y1pGi56G6zMChmz3xwIV93Ismu4TnQqmH/qJ8jYzT1EOBIKe7qbk3Dpu7O6PQ
 qFXxYT0tTg+2vwP78WtoHij5Sahqb3s80G2RkjR4WCiOYjhQYu3FqPp80WRxphbUv5u9
 fscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312845; x=1779917645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Av+kt2qGFE219m05KfncIX215HPEdoJL5n4U5TvcwDk=;
 b=ZOOT5STV4vRoZUcfPsrDqHbN3QpIEOe7901ntAlMyhWMBiIC5W017mpZXJew2hRHTt
 CIMTXQWHv1O8954AwOHImmAdNMXzK12Fg6v6eyO9YTFSgKNHuj1ZLtRJgg5yD2cmM/Rt
 UaRR0jxQCEDyAzZpNgsK0efCRDReA+++YS4mbdF3TJCDUBn3CS0HGl7XmxbVkih2/jL5
 c1DhMXZP6+mB0iwB0QrIqLA2alX7SHxzPk2GBlgpDzXF6hZupQ7/13oKm+XUvzgXgc87
 0LHazvnM4lLFiBiLEH2b1vaV+JFjSH3LOPmv3BIdDavghIfmbmpxiSvWtYCfzhtdHqMy
 LuQQ==
X-Gm-Message-State: AOJu0Ywq9pV4nGgImTRvFVJjGXlpafnCj/rBDs/0QjYxvbVNvW+43Tic
 glIpLK49HDlnKvujEBU0xJhrvMLK/E8vkn5v5gpJAZHAEdlCvON5Ip7WPf8+CnWtIlxddVKvXWY
 WFPeiwjsezooulDmlSjFRVuO+dp9JIL+pqfYsAB+uQf/eFteCtRE7O6dA1cFw9P9JrTdf2ycYEb
 Zwj0+D80wG3DlptzE4SUbndKZggC/lMsoAfA56yw==
X-Gm-Gg: Acq92OH2Mhg//jiu6z3a58qJhtPcximpjBE+cXHuMaHYF7Z89O5P+YfMpJlORorcPvu
 M62zf/bG8QrxZ8rISnAVu59fw2Q+C4pDhPVtGqe58tgkftg+S0bMPO8H4HcOfmBhs/IKBqu70Fx
 L4lwuHQx8Cspxyr0xVpB8iIY5nTmlmC+hzRtvK6QxFl6vkVSFA9rtB5WkAm6JuY/sYe+m5io7vA
 z9O1pHtJj6V+qE1V9cfJ5A9YiiwOedQLV+5AxsR/W5LrfUKJbVGhNKuqTKynfYGbIFDP2+nDh6r
 H65Yjle7r0kFMbJYoJcXEaOuuFNEH2PaOUHnSxudUv3tn1RxIt0EH7YvP99m5ezob/kSuEDW7Qh
 I2Ao1a8xYKs2tSQQ1jEeC2xd1uAcqPAG/eE/Kea2Pys7n9wsU+njcaxM=
X-Received: by 2002:a05:6214:4884:b0:8ca:105f:91d6 with SMTP id
 6a1803df08f44-8cc6e347507mr4567186d6.21.1779312844961; 
 Wed, 20 May 2026 14:34:04 -0700 (PDT)
X-Received: by 2002:a05:6214:4884:b0:8ca:105f:91d6 with SMTP id
 6a1803df08f44-8cc6e347507mr4566366d6.21.1779312844390; 
 Wed, 20 May 2026 14:34:04 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 01/29] migration: Fix crash on second migration when cancel
 early
Date: Wed, 20 May 2026 17:33:29 -0400
Message-ID: <20260520213357.40646-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Marc-André reported an issue on QEMU crash when retrying a cancelled
migration during early setup phase, see "Link:" for more information, and
also easy way to reproduce.

This patch is a replacement of the prior fix proposed by not only switching
to migration_cleanup(), but also fixing it from CPR side, so that we track
hup_source properly to know if src QEMU is waiting or the HUP signal.

To put it simple: this chunk of special casing in migration_cancel() should
not affect normal migration, but only cpr-transfer migration to cover the
small window when the src QEMU is waiting for a HUP signal on cpr
channel (so that src QEMU can continue the migration on the main channel).

To achieve that, we'll also need to remember to detach the hup_source
whenenver invoked: after that point, we should always be able to cleanup
the migration.

It's not a generic operation to explicitly detach a gsource from its
context while in its dispatch() function.  But it should be safe, because
gsource disptch() will only happen with a boosted refcount for the
dispatcher so that the gsource will not be freed until the callback
completes. It's also safe to return G_SOURCE_REMOVE after the gsource is
detached, as glib will simply ignore the G_SOURCE_REMOVE.

One can refer to latest 2.86.5 glib code in g_main_dispatch() for that:

https://github.com/GNOME/glib/blob/2.86.5/glib/gmain.c#L3592

When at this, add a bunch of assertions to make sure nothing surprises us.

After this patch applied, the 2nd migration will not crash QEMU, instead
it'll be in CANCELLING until the socket connection times out (it will take
~2min on my Fedora default kernel).  During this process no 2nd migration
will be allowed, and after it timed out migration can be restarted.

It's because so far we don't have control over socket_connect_outgoing(),
or anything yet managed by a task executed in qio_task_run_in_thread().
Speeding up the cancellation to be left for future.

I also tested cpr-transfer by only providing cpr channel not the main
channel (with -incoming defer), kickoff migration on source, then cancel it
on source directly without providing the main channel.  It keeps working.

I wanted to add an unit test for that but it'll need to refactor current
cpr-transfer tests first; let's leave it for later.

Link: https://lore.kernel.org/r/20260417184742.293061-1-marcandre.lureau@redhat.com
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260421175820.302795-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h  |  1 +
 migration/migration.h    |  5 +++++
 migration/cpr-transfer.c | 10 ++++++++++
 migration/migration.c    | 31 +++++++++++++++++++++++--------
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 96ce26e711..56fb67e6b4 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -57,6 +57,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
                                 void *opaque);
 void cpr_transfer_source_destroy(MigrationState *s);
+bool cpr_transfer_source_active(MigrationState *s);
 
 void cpr_exec_init(void);
 QEMUFile *cpr_exec_output(Error **errp);
diff --git a/migration/migration.h b/migration/migration.h
index a5e064a1ac..841f49b215 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -512,6 +512,11 @@ struct MigrationState {
 
     bool postcopy_package_loaded;
 
+    /*
+     * When set, it means cpr-transfer is waiting for the HUP signal from
+     * destination to continue the 2nd step of migration via the main
+     * channel.
+     */
     GSource *hup_source;
 
     /*
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index 61d5c9dce2..9defe7bad7 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-migration.h"
@@ -79,6 +80,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
 void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
                                 void *opaque)
 {
+    assert(bql_locked());
     s->hup_source = qio_channel_create_watch(cpr_state_ioc(), G_IO_HUP);
     g_source_set_callback(s->hup_source,
                           (GSourceFunc)func,
@@ -89,9 +91,17 @@ void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
 
 void cpr_transfer_source_destroy(MigrationState *s)
 {
+    assert(bql_locked());
     if (s->hup_source) {
         g_source_destroy(s->hup_source);
         g_source_unref(s->hup_source);
         s->hup_source = NULL;
     }
 }
+
+bool cpr_transfer_source_active(MigrationState *s)
+{
+    /* Whenever the HUP gsource is available, it's active. */
+    assert(bql_locked());
+    return s->hup_source;
+}
diff --git a/migration/migration.c b/migration/migration.c
index ecc69dc4d2..b6f78eb3ac 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1502,14 +1502,19 @@ void migration_cancel(void)
     }
 
     /*
-     * If migration_connect_outgoing has not been called, then there
-     * is no path that will complete the cancellation. Do it now.
-     */
-    if (setup && !s->to_dst_file) {
-        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
-                          MIGRATION_STATUS_CANCELLED);
-        cpr_state_close();
-        cpr_transfer_source_destroy(s);
+     * This is cpr-transfer specific processing.
+     *
+     * If this is true, it means cpr-transfer migration is waiting for the
+     * destination to send HUP event on CPR channel to continue the next
+     * phase.  If so, do the cleanup proactively to avoid get stuck in
+     * CANCELLING state.
+     */
+    if (cpr_transfer_source_active(s)) {
+        assert(migrate_mode() == MIG_MODE_CPR_TRANSFER);
+        assert(setup && !s->to_dst_file);
+        migration_cleanup(s);
+        /* Now all things should have been released */
+        assert(!cpr_transfer_source_active(s));
     }
 }
 
@@ -2045,12 +2050,22 @@ static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
 
+    /*
+     * Detach and release the GSource right after use.  We rely on this to
+     * detect this small cpr-transfer window of "waiting for HUP event".
+     */
+    cpr_transfer_source_destroy(s);
+
     migration_connect_outgoing(s, opaque, &local_err);
 
     if (local_err) {
         migration_connect_error_propagate(s, local_err);
     }
 
+    /*
+     * This is redundant as we do cpr_transfer_source_destroy() at the
+     * entry, but it's benign; glib will just skip the detach.
+     */
     return G_SOURCE_REMOVE;
 }
 
-- 
2.53.0


