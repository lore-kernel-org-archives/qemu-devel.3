Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB09CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIAL-0002vR-1J; Wed, 10 Jun 2026 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIAI-0002lO-I1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIAG-0004GT-Es
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sn74qOoT3A6vXh88DecTPnRQL5OF0zycVkWhpU2MxuI=;
 b=XImRfHVP+IMeJKE0Ip1/F0uKfcP0BBj/Gf7Y5j5jw0Q1MRCbXyYXC+m8Vts2d/ANwUF1to
 TWkVMVgszsbFMNR8dhTbB/tTgtCaN+Brv0dNv9eqjeTgI9PHu/KWFvurCMl2vPXTbN2/s4
 Fv1f9f98BFHiRosu6XqeuDEL7+tcgic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-Srylg7HIP4yBVpEUuuhAmA-1; Wed,
 10 Jun 2026 08:36:10 -0400
X-MC-Unique: Srylg7HIP4yBVpEUuuhAmA-1
X-Mimecast-MFC-AGG-ID: Srylg7HIP4yBVpEUuuhAmA_1781094969
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CB15184EB7B; Wed, 10 Jun 2026 12:36:09 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1FF736535; Wed, 10 Jun 2026 12:36:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 27/35] monitor: implement support for deleting QMP objects
Date: Wed, 10 Jun 2026 13:34:07 +0100
Message-ID: <20260610123415.2883603-28-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

From: Christian Brauner <brauner@kernel.org>

The removal sequence is:

 1. Mark dead and remove from mon_list under monitor_lock.  This
    must happen before disconnecting chardev handlers to prevent
    event broadcast from calling monitor_flush_locked() after the
    gcontext reset, which would create an out_watch on the wrong
    GMainContext (see monitor_cancel_out_watch()).
 2. Cancel any pending out_watch while gcontext still points to the
    correct context.
 3. Disconnect chardev handlers, passing context=NULL and close
    the connection.
 4. Drain pending requests from any in-flight monitor_qmp_read().
 5. Destroy the monitor object

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[DB: extracted from a larger commit and refactored to apply
     to the new monitor class structure. Remove 'self delete'
     feature which requires complex special-case code]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 22 ++++++++++++++++
 monitor/qmp.c              | 53 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index a82e1aacb6..2e8e5ec721 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -134,6 +134,7 @@ struct Monitor {
     char *chardev_id;
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
+    bool dead;                  /* awaiting drain after monitor-remove */
     QEMUBH *accept_input_bh;    /* persistent BH for monitor_accept_input */
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
@@ -178,6 +179,7 @@ struct MonitorQMP {
     Monitor parent_obj;
     JSONMessageParser parser;
     bool pretty;
+    bool setup_pending; /* iothread BH has not yet set up chardev handlers */
     /*
      * When a client connects, we're in capabilities negotiation mode.
      * @commands is &qmp_cap_negotiation_commands then.  When command
@@ -206,6 +208,7 @@ extern MonitorList mon_list;
 
 bool monitor_requires_iothread(const Monitor *mon);
 int monitor_can_read(void *opaque);
+void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
 int monitor_set_cpu(Monitor *mon, int cpu_index);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 909f4f6052..6017d486af 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -176,6 +176,28 @@ static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
     return G_SOURCE_REMOVE;
 }
 
+/* Cancel a pending out_watch GSource.  Caller must hold mon_lock. */
+void monitor_cancel_out_watch(Monitor *mon)
+{
+    if (mon->out_watch) {
+        GMainContext *ctx = NULL;
+        GSource *src;
+
+        if (monitor_requires_iothread(mon)) {
+            ctx = iothread_get_g_main_context(mon_iothread);
+        }
+        src = g_main_context_find_source_by_id(ctx, mon->out_watch);
+        if (!src && ctx) {
+            /* Handler disconnect may have reset gcontext to NULL. */
+            src = g_main_context_find_source_by_id(NULL, mon->out_watch);
+        }
+        if (src) {
+            g_source_destroy(src);
+        }
+        mon->out_watch = 0;
+    }
+}
+
 /* Caller must hold mon->mon_lock */
 void monitor_flush_locked(Monitor *mon)
 {
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 3f3d5b9d1c..d471428488 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -184,6 +184,12 @@ static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
     }
 }
 
+static void monitor_qmp_drain_queue(MonitorQMP *mon)
+{
+    QEMU_LOCK_GUARD(&mon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+}
+
 static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
 {
     QEMU_LOCK_GUARD(&mon->qmp_queue_lock);
@@ -655,8 +661,14 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
     }
 }
 
+static void monitor_qmp_iothread_quiesce(void *opaque)
+{
+    /* No-op: synchronization point only */
+}
+
 static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 {
+    Monitor *mon = MONITOR(uc);
     MonitorQMP *qmp = MONITOR_QMP(uc);
 
     if (monitor_qmp_dispatcher_is_servicing(qmp)) {
@@ -664,8 +676,45 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
         return false;
     }
 
-    error_setg(errp, "Deleting QMP monitors is not supported");
-    return false;
+    if (qatomic_read(&qmp->setup_pending)) {
+        error_setg(errp, "monitor is still initializing");
+        return false;
+    }
+
+    /* Remove from mon_list before chardev disconnect. */
+    WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+        mon->dead = true;
+        QTAILQ_REMOVE(&mon_list, mon, entry);
+    }
+
+    /* Cancel out_watch while gcontext still points to the right ctx. */
+    WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
+        monitor_cancel_out_watch(mon);
+    }
+
+    qemu_chr_fe_set_handlers(&mon->chr, NULL, NULL, NULL, NULL,
+                             NULL, NULL, true);
+
+    /* Drain requests from any in-flight monitor_qmp_read(). */
+    monitor_qmp_drain_queue(qmp);
+
+    WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
+        /* Disable flushes before cancel -- gcontext is already wrong. */
+        qemu_chr_fe_set_open(&mon->chr, false);
+        monitor_cancel_out_watch(mon);
+    }
+
+    /* Synchronize with in-flight iothread callbacks. */
+    if (monitor_requires_iothread(mon)) {
+        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+                            monitor_qmp_iothread_quiesce, NULL);
+    }
+
+    /* Catch requests from a racing monitor_qmp_read(). */
+    monitor_qmp_drain_queue(qmp);
+    monitor_fdsets_cleanup();
+
+    return true;
 }
 
 static void monitor_qmp_accept_input(Monitor *mon)
-- 
2.54.0


