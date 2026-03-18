Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31789103D924
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nb4-0007VC-Ng; Wed, 18 Mar 2026 05:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2naq-0007Tl-Qx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2nan-0000GY-31
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773827611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvBXdTr4DVin3js9aNW8Atx0nJgqqA/jNtNiPt71jVY=;
 b=IhcCdsQxRQ+taKysYRRLLKhLvJTqNjHvq0Bx8rcPrOebmw/7f73ivFRRepTeidjQnZWHZt
 KHqxnkk4TMgE5VbIV255uckN4chSIPHnAfGpw6yubJKmYJuKkjXkXBUDdA8c9pUa5WUHMG
 2nW7zl2qVhMmXV5noSgjYax+mdldk+E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-Gs3Su6S6PVK1oQMk2Uo-Aw-1; Wed,
 18 Mar 2026 05:53:28 -0400
X-MC-Unique: Gs3Su6S6PVK1oQMk2Uo-Aw-1
X-Mimecast-MFC-AGG-ID: Gs3Su6S6PVK1oQMk2Uo-Aw_1773827607
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67F8119560AA; Wed, 18 Mar 2026 09:53:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E919E1800351; Wed, 18 Mar 2026 09:53:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B43221E675A; Wed, 18 Mar 2026 10:53:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org,
	kwolf@redhat.com
Subject: [PATCH 1/3] monitor: Fix event rate limit tracing
Date: Wed, 18 Mar 2026 10:53:21 +0100
Message-ID: <20260318095323.2705117-2-armbru@redhat.com>
In-Reply-To: <20260318095323.2705117-1-armbru@redhat.com>
References: <20260318095323.2705117-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Trace event monitor_protocol_event_queue argument @rate is the rate
event's limit.  It's 1000000000 for BLOCK_IO_ERROR with
BLOCK_ERROR_ACTION_STOP, but the actual rate limit is 0,
i.e. unlimited.  Fix that.

Fixes: 544ddbb6373d (block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..8277f41a9d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -330,12 +330,11 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
 {
     MonitorQAPIEventConf *evconf;
     MonitorQAPIEventState *evstate;
-    bool throttled;
+    int64_t rate_limit;
 
     assert(event < QAPI_EVENT__MAX);
     evconf = &monitor_qapi_event_conf[event];
-    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
-    throttled = evconf->rate;
+    rate_limit = evconf->rate;
 
     /*
      * Rate limit BLOCK_IO_ERROR only for action != "stop".
@@ -350,13 +349,15 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
         QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
         const char *action = qdict_get_str(data, "action");
         if (!strcmp(action, "stop")) {
-            throttled = false;
+            rate_limit = 0;
         }
     }
 
+    trace_monitor_protocol_event_queue(event, qdict, rate_limit);
+
     QEMU_LOCK_GUARD(&monitor_lock);
 
-    if (!throttled) {
+    if (!rate_limit) {
         /* Unthrottled event */
         monitor_qapi_event_emit(event, qdict);
     } else {
@@ -368,7 +369,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
 
         if (evstate) {
             /*
-             * Timer is pending for (at least) evconf->rate ns after
+             * Timer is pending for (at least) @rate_limit ns after
              * last send.  Store event for sending when timer fires,
              * replacing a prior stored event if any.
              */
@@ -376,9 +377,9 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
             evstate->qdict = qobject_ref(qdict);
         } else {
             /*
-             * Last send was (at least) evconf->rate ns ago.
+             * Last send was (at least) @rate_limit ns ago.
              * Send immediately, and arm the timer to call
-             * monitor_qapi_event_handler() in evconf->rate ns.  Any
+             * monitor_qapi_event_handler() in @rate_limit ns.  Any
              * events arriving before then will be delayed until then.
              */
             int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
@@ -393,7 +394,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
                                           monitor_qapi_event_handler,
                                           evstate);
             g_hash_table_add(monitor_qapi_event_state, evstate);
-            timer_mod_ns(evstate->timer, now + evconf->rate);
+            timer_mod_ns(evstate->timer, now + rate_limit);
         }
     }
 }
-- 
2.53.0


