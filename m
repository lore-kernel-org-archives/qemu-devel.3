Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98995103D924
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nb8-0007Wm-CO; Wed, 18 Mar 2026 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2naq-0007Tj-OO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2nal-0000BR-RL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773827610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLc8TUGCVbI2hNqsv8kPvh67lVtYioZvfSsq0QAiRoE=;
 b=TnokTp5m9TGiVpe3hq6mHLvg2QAFpjzHhDCdc0oMhLcyeBu7995ThvZY9k32FKu39lVdsV
 SV/M69G0PmIOvTqhgRqtc3V0JBBB+lygej6TrgdQshuDXZrKPmYGxpmQmnVvWCAMmNKx/i
 xj8YI8uS7A23aKBD3fH+hL3ZYipEc84=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-dRHuYLGqMmS53YGGLQq1XQ-1; Wed,
 18 Mar 2026 05:53:27 -0400
X-MC-Unique: dRHuYLGqMmS53YGGLQq1XQ-1
X-Mimecast-MFC-AGG-ID: dRHuYLGqMmS53YGGLQq1XQ_1773827606
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63514195605E; Wed, 18 Mar 2026 09:53:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07BCE1955F19; Wed, 18 Mar 2026 09:53:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5FD7F21E66E5; Wed, 18 Mar 2026 10:53:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org,
	kwolf@redhat.com
Subject: [PATCH 2/3] monitor: Factor out monitor_event_rate_limited()
Date: Wed, 18 Mar 2026 10:53:22 +0100
Message-ID: <20260318095323.2705117-3-armbru@redhat.com>
In-Reply-To: <20260318095323.2705117-1-armbru@redhat.com>
References: <20260318095323.2705117-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 8277f41a9d..87f6e4860b 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -319,17 +319,9 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
     }
 }
 
-static void monitor_qapi_event_handler(void *opaque);
-
-/*
- * Queue a new event for emission to Monitor instances,
- * applying any rate limiting if required.
- */
-static void
-monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
+static int64_t monitor_event_rate_limit(QAPIEvent event, QDict *data)
 {
     MonitorQAPIEventConf *evconf;
-    MonitorQAPIEventState *evstate;
     int64_t rate_limit;
 
     assert(event < QAPI_EVENT__MAX);
@@ -346,13 +338,28 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
      * limited, so we can do without rate limiting.
      */
     if (event == QAPI_EVENT_BLOCK_IO_ERROR) {
-        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
         const char *action = qdict_get_str(data, "action");
         if (!strcmp(action, "stop")) {
             rate_limit = 0;
         }
     }
 
+    return rate_limit;
+}
+
+static void monitor_qapi_event_handler(void *opaque);
+
+/*
+ * Queue a new event for emission to Monitor instances,
+ * applying any rate limiting if required.
+ */
+static void
+monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
+{
+    QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
+    int64_t rate_limit = monitor_event_rate_limit(event, data);
+    MonitorQAPIEventState *evstate;
+
     trace_monitor_protocol_event_queue(event, qdict, rate_limit);
 
     QEMU_LOCK_GUARD(&monitor_lock);
@@ -361,7 +368,6 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
         /* Unthrottled event */
         monitor_qapi_event_emit(event, qdict);
     } else {
-        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
         MonitorQAPIEventState key = { .event = event, .data = data };
 
         evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
-- 
2.53.0


