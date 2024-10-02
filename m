Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D5CF6D36
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw17k-0005lY-J2; Wed, 02 Oct 2024 11:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw17b-0005im-Gh; Wed, 02 Oct 2024 11:18:36 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw17Y-0004px-Ta; Wed, 02 Oct 2024 11:18:35 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1301:0:640:a2b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AB03360D4F;
 Wed,  2 Oct 2024 18:18:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7IdRVm1IaeA0-1YgGQtpV; Wed, 02 Oct 2024 18:18:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727882308;
 bh=QoBSQBwzTsqhFyxMo8qE6QO6e5IVO+nGcgo0RDbBEiE=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0Gkwnh0GhT9gFWZFCUclO9X2pAiG8656m/or9MMSf1P++k6yLDeEsnaxzCgaaCJu3
 JZ0gjtysWzJINLHytOyi5jAfV9Z20eVRQWbGW89ONF+Qnlk2+J68nzXTTalp/EP3w2
 ecPxaZmTRF6bj4oQuxqWDTPEUPFpMSOgKjK+JMOo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 dave@treblig.org, hreitz@redhat.com, kwolf@redhat.com,
 Leonid Kaplan <xeor@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v3 2/2] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
Date: Wed,  2 Oct 2024 18:18:06 +0300
Message-Id: <20241002151806.592469-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002151806.592469-1-vsementsov@yandex-team.ru>
References: <20241002151806.592469-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 monitor/monitor.c    | 7 +++++--
 qapi/block-core.json | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

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
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b3743022be..835f90b118 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5607,6 +5607,8 @@
 # .. note:: If action is "stop", a STOP event will eventually follow
 #    the BLOCK_IO_ERROR event.
 #
+# .. note:: This event is rate-limited.
+#
 # Since: 0.13
 #
 # .. qmp-example::
-- 
2.34.1


