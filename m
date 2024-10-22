Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CD7D2CE01
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4k-0000aX-Lp; Tue, 22 Oct 2024 12:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4f-0000VP-Kr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4e-00068h-3G
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coP4cMorzzuJPcHDWFKzvM8HkyCGleUbY6fulomVjoI=;
 b=eepO61JYahkoC75BgQ226K6FN3GPg7IT6d09nm5ChTrFOh3634/t5yPU2pZ0+814iUDAMm
 MQGeov5ti3K/hgSJU5NwdbzwI878G8/vIINKE+G0bYT7zKOd/fYNZwr/2PK/V1ghP0UWt9
 DkoVTeDBWpeDwP/LqmXt02bGZwmADIY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-t70UviaAO6eUjgRy_pLZnA-1; Tue,
 22 Oct 2024 12:49:34 -0400
X-MC-Unique: t70UviaAO6eUjgRy_pLZnA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5038A1955F57; Tue, 22 Oct 2024 16:49:33 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DBA11955EA3; Tue, 22 Oct 2024 16:49:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 8/9] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
Date: Tue, 22 Oct 2024 18:49:02 +0200
Message-ID: <20241022164903.282174-9-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Leonid Kaplan <xeor@yandex-team.ru>

BLOCK_IO_ERROR events comes from guest, so we must throttle them.
We still want per-device throttling, so let's use device id as a key.

Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20241002151806.592469-3-vsementsov@yandex-team.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 2 ++
 monitor/monitor.c    | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index fe63ba6cbf..fd3bcc1c17 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5611,6 +5611,8 @@
 # .. note:: If action is "stop", a STOP event will eventually follow
 #    the BLOCK_IO_ERROR event.
 #
+# .. note:: This event is rate-limited.
+#
 # Since: 0.13
 #
 # .. qmp-example::
diff --git a/monitor/monitor.c b/monitor/monitor.c
index db52a9c7ef..56786c0ccc 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -308,6 +308,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
+    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
     [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
@@ -493,7 +494,8 @@ static unsigned int qapi_event_throttle_hash(const void *key)
         hash += g_str_hash(qdict_get_str(evstate->data, "node-name"));
     }
 
-    if (evstate->event == QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE) {
+    if (evstate->event == QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE ||
+        evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
         hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
     }
 
@@ -519,7 +521,8 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
                        qdict_get_str(evb->data, "node-name"));
     }
 
-    if (eva->event == QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE) {
+    if (eva->event == QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE ||
+        eva->event == QAPI_EVENT_BLOCK_IO_ERROR) {
         return !strcmp(qdict_get_str(eva->data, "qom-path"),
                        qdict_get_str(evb->data, "qom-path"));
     }
-- 
2.47.0


