Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40067103D924
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nb2-0007Uf-6F; Wed, 18 Mar 2026 05:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2nap-0007TU-GD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2nal-0000B8-Cw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773827610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cf3ZlZYJuPivZ4fXOeU11NHa9pyR7htPxznZa5js3xQ=;
 b=OPdVG4PrzXLHb+TYKRpIBQCtp/f9YHwl+uozGVbCJAyuE1pwULDe1ehAv5DiHjVuwW4ARC
 PabtN3MQbTm6VSRAWFTX/nBODEf/bUiwIssxuyhjenKAN/oxgzKCaCZjsEpXp1JaGDT51y
 MyZPy8g1rVwE4nVB9yfI7zzl8enaNnU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-7B11esURPoepzyDHzo29cw-1; Wed,
 18 Mar 2026 05:53:27 -0400
X-MC-Unique: 7B11esURPoepzyDHzo29cw-1
X-Mimecast-MFC-AGG-ID: 7B11esURPoepzyDHzo29cw_1773827606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A28C5195607B; Wed, 18 Mar 2026 09:53:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDDCE30001A1; Wed, 18 Mar 2026 09:53:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63F0E21E66EA; Wed, 18 Mar 2026 10:53:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org,
	kwolf@redhat.com
Subject: [PATCH 3/3] monitor: Dumb down to a single event rate limit
Date: Wed, 18 Mar 2026 10:53:23 +0100
Message-ID: <20260318095323.2705117-4-armbru@redhat.com>
In-Reply-To: <20260318095323.2705117-1-armbru@redhat.com>
References: <20260318095323.2705117-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The code lets us define event-specific rate limits.  In more than a
decade, we've only ever used the same 1s limit for all rate-limited
events.  Drop the ability and simplify.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor.c    | 56 ++++++++++++++++++++------------------------
 monitor/trace-events |  2 +-
 2 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 87f6e4860b..5be2ec02c2 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -46,9 +46,8 @@ typedef struct MonitorQAPIEventState {
     QDict *qdict;       /* Delayed event (if any) */
 } MonitorQAPIEventState;
 
-typedef struct {
-    int64_t rate;       /* Minimum time (in ns) between two events */
-} MonitorQAPIEventConf;
+/* Minimum time (in ns) between events if the event is rate-limited */
+#define EVENT_RATE (1000 * SCALE_MS)
 
 /* Shared monitor I/O thread */
 IOThread *mon_iothread;
@@ -268,19 +267,6 @@ void monitor_printc(Monitor *mon, int c)
     monitor_printf(mon, "'");
 }
 
-static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
-    /* Limit guest-triggerable events to 1 per second */
-    [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
-    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
-    [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
-    [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
-    [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
-    [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
-    [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
-    [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
-    [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
-};
-
 /*
  * Return the clock to use for recording an event's time.
  * It's QEMU_CLOCK_REALTIME, except for qtests it's
@@ -319,14 +305,23 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
     }
 }
 
-static int64_t monitor_event_rate_limit(QAPIEvent event, QDict *data)
+static bool monitor_event_is_rate_limited(QAPIEvent event, QDict *data)
 {
-    MonitorQAPIEventConf *evconf;
-    int64_t rate_limit;
+    static bool event_is_ratelimited[QAPI_EVENT__MAX] = {
+        [QAPI_EVENT_RTC_CHANGE]        = true,
+        [QAPI_EVENT_BLOCK_IO_ERROR]    = true,
+        [QAPI_EVENT_WATCHDOG]          = true,
+        [QAPI_EVENT_BALLOON_CHANGE]    = true,
+        [QAPI_EVENT_QUORUM_REPORT_BAD] = true,
+        [QAPI_EVENT_QUORUM_FAILURE]    = true,
+        [QAPI_EVENT_VSERPORT_CHANGE]   = true,
+        [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = true,
+        [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = true,
+    };
+    bool rate_limited;
 
     assert(event < QAPI_EVENT__MAX);
-    evconf = &monitor_qapi_event_conf[event];
-    rate_limit = evconf->rate;
+    rate_limited = event_is_ratelimited[event];
 
     /*
      * Rate limit BLOCK_IO_ERROR only for action != "stop".
@@ -340,11 +335,11 @@ static int64_t monitor_event_rate_limit(QAPIEvent event, QDict *data)
     if (event == QAPI_EVENT_BLOCK_IO_ERROR) {
         const char *action = qdict_get_str(data, "action");
         if (!strcmp(action, "stop")) {
-            rate_limit = 0;
+            rate_limited = false;
         }
     }
 
-    return rate_limit;
+    return rate_limited;
 }
 
 static void monitor_qapi_event_handler(void *opaque);
@@ -357,14 +352,14 @@ static void
 monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
 {
     QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
-    int64_t rate_limit = monitor_event_rate_limit(event, data);
+    bool rate_limited = monitor_event_is_rate_limited(event, data);
     MonitorQAPIEventState *evstate;
 
-    trace_monitor_protocol_event_queue(event, qdict, rate_limit);
+    trace_monitor_protocol_event_queue(event, qdict, rate_limited);
 
     QEMU_LOCK_GUARD(&monitor_lock);
 
-    if (!rate_limit) {
+    if (!rate_limited) {
         /* Unthrottled event */
         monitor_qapi_event_emit(event, qdict);
     } else {
@@ -375,7 +370,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
 
         if (evstate) {
             /*
-             * Timer is pending for (at least) @rate_limit ns after
+             * Timer is pending for (at least) @EVENT_RATE ns after
              * last send.  Store event for sending when timer fires,
              * replacing a prior stored event if any.
              */
@@ -385,7 +380,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
             /*
              * Last send was (at least) @rate_limit ns ago.
              * Send immediately, and arm the timer to call
-             * monitor_qapi_event_handler() in @rate_limit ns.  Any
+             * monitor_qapi_event_handler() in @EVENT_RATE ns.  Any
              * events arriving before then will be delayed until then.
              */
             int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
@@ -400,7 +395,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
                                           monitor_qapi_event_handler,
                                           evstate);
             g_hash_table_add(monitor_qapi_event_state, evstate);
-            timer_mod_ns(evstate->timer, now + rate_limit);
+            timer_mod_ns(evstate->timer, now + EVENT_RATE);
         }
     }
 }
@@ -454,7 +449,6 @@ void qapi_event_emit(QAPIEvent event, QDict *qdict)
 static void monitor_qapi_event_handler(void *opaque)
 {
     MonitorQAPIEventState *evstate = opaque;
-    MonitorQAPIEventConf *evconf = &monitor_qapi_event_conf[evstate->event];
 
     trace_monitor_protocol_event_handler(evstate->event, evstate->qdict);
     QEMU_LOCK_GUARD(&monitor_lock);
@@ -465,7 +459,7 @@ static void monitor_qapi_event_handler(void *opaque)
         monitor_qapi_event_emit(evstate->event, evstate->qdict);
         qobject_unref(evstate->qdict);
         evstate->qdict = NULL;
-        timer_mod_ns(evstate->timer, now + evconf->rate);
+        timer_mod_ns(evstate->timer, now + EVENT_RATE);
     } else {
         g_hash_table_remove(monitor_qapi_event_state, evstate);
         qobject_unref(evstate->data);
diff --git a/monitor/trace-events b/monitor/trace-events
index 032d1220e1..7f0b4b9dd9 100644
--- a/monitor/trace-events
+++ b/monitor/trace-events
@@ -6,7 +6,7 @@ handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 # monitor.c
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
-monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
+monitor_protocol_event_queue(uint32_t event, void *qdict, bool rate_limited) "event=%d data=%p rate_limited=%d"
 monitor_suspend(void *ptr, int cnt) "mon %p: %d"
 
 # qmp.c
-- 
2.53.0


