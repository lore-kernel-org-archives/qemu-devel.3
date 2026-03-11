Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70788112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LDw-0005OC-82; Wed, 11 Mar 2026 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LCd-0003I9-GZ; Wed, 11 Mar 2026 11:10:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LCZ-0005qA-BV; Wed, 11 Mar 2026 11:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241483; bh=ILL435L5rWwcT5meFV53UIM7pEhV/Tf1PkXA/GyQVRY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CBnVBzzoyYJeGrKXGWi+AC3crY8QXvqOEfKhQc0Jzg2xR4M2s4qTbMFdHjXG8v4Xe
 Z3QkJ6Pd9OND/BG2a/q00taLf1WrXaLHLB/ovlWVTXvYS5yJKPLhORBxmyrcISFNsX
 V+sK/O9MYHBgvgvuHdPHr6DD5Tv6i0Ot/CFElk9O4vBOV3/myTJQ04f+b25AnvkZLt
 QO+tK17DpiyX6vM+zSd17eomV61a1q1i/Rlm6MpgNbd58f1KBprnxEuUlrUR6GG8ZN
 OmPJyI9IlPtTB4G41pGtc6KpPlv+ykJ1TrmyNGySdHW8eljrA5PcpGY883K7XzNnop
 2XKUKoYTXEhcw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9EF83191EA7;
 Wed, 11 Mar 2026 18:04:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8DD8D37C2E8;
 Wed, 11 Mar 2026 18:05:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 36/46] block: Never drop BLOCK_IO_ERROR with
 action=stop for rate limiting
Date: Wed, 11 Mar 2026 18:03:12 +0300
Message-ID: <20260311150327.1084669-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

Commit 2155d2dd introduced rate limiting for BLOCK_IO_ERROR to emit an
event only once a second. This makes sense for cases in which the guest
keeps running and can submit more requests that would possibly also fail
because there is a problem with the backend.

However, if the error policy is configured so that the VM is stopped on
errors, this is both unnecessary because stopping the VM means that the
guest can't issue more requests and in fact harmful because stopping the
VM is an important state change that management tools need to keep track
of even if it happens more than once in a given second. If an event is
dropped, the management tool would see a VM randomly going to paused
state without an associated error, so it has a hard time deciding how to
handle the situation.

This patch disables rate limiting for action=stop by not relying on the
event type alone any more in monitor_qapi_event_queue_no_reenter(), but
checking action for BLOCK_IO_ERROR, too. If the error is reported to the
guest or ignored, the rate limiting stays in place.

Fixes: 2155d2dd7f73 ('block-backend: per-device throttling of BLOCK_IO_ERROR reports')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260304122800.51923-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 544ddbb6373d61292a0e2dc269809cd6bd5edec6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/monitor/monitor.c b/monitor/monitor.c
index c5a5d30877..ae7cf64de0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -363,14 +363,33 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
 {
     MonitorQAPIEventConf *evconf;
     MonitorQAPIEventState *evstate;
+    bool throttled;
 
     assert(event < QAPI_EVENT__MAX);
     evconf = &monitor_qapi_event_conf[event];
     trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
+    throttled = evconf->rate;
+
+    /*
+     * Rate limit BLOCK_IO_ERROR only for action != "stop".
+     *
+     * If the VM is stopped after an I/O error, this is important information
+     * for the management tool to keep track of the state of QEMU and we can't
+     * merge any events. At the same time, stopping the VM means that the guest
+     * can't send additional requests and the number of events is already
+     * limited, so we can do without rate limiting.
+     */
+    if (event == QAPI_EVENT_BLOCK_IO_ERROR) {
+        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
+        const char *action = qdict_get_str(data, "action");
+        if (!strcmp(action, "stop")) {
+            throttled = false;
+        }
+    }
 
     QEMU_LOCK_GUARD(&monitor_lock);
 
-    if (!evconf->rate) {
+    if (!throttled) {
         /* Unthrottled event */
         monitor_qapi_event_emit(event, qdict);
     } else {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index dc6eb4ae23..c17fd62c2c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5717,7 +5717,7 @@
 # .. note:: If action is "stop", a `STOP` event will eventually follow
 #    the `BLOCK_IO_ERROR` event.
 #
-# .. note:: This event is rate-limited.
+# .. note:: This event is rate-limited, except if action is "stop".
 #
 # Since: 0.13
 #
-- 
2.47.3


