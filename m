Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D971DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVhf-00081P-N8; Thu, 30 Oct 2025 12:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhd-00080e-RE
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:45 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhR-0003Ga-Ly
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 21B1A80984;
 Thu, 30 Oct 2025 19:40:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OeiSuH0Fn4Y0-rV8b6ttJ; Thu, 30 Oct 2025 19:40:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761842428;
 bh=soshIt7UzNY14fx14ZgoSWzIKXQzxzGA/flYljDxDvo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=CffCQzy510GHAgPOawiUs6nwkL23IAf/IRoWpYSAwlFxoIMEFgV83CT3WeUTkx8AH
 cRR+AmEQ5xgSLxJ2+txwcQKsAkhMpc6ujopCjRMdS8rZiBSsKt42yTAy0BeZbq4h8j
 wRl4esoh58xKCJQ0gJaa/DWUQ7jTeKb3JvwZ2Y58=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v9 5/7] net/tap: setup exit notifier only when needed
Date: Thu, 30 Oct 2025 19:40:21 +0300
Message-ID: <20251030164023.710048-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030164023.710048-1-vsementsov@yandex-team.ru>
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

No reason to setup notifier on each queue of multique tap,
when we actually want to run downscript only once.
As well, let's not setup notifier, when downscript is
not enabled (downsciprt="no").

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 017c184933..5653578ccb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -326,11 +326,9 @@ static void tap_exit_notify(Notifier *notifier, void *data)
     TAPState *s = container_of(notifier, TAPState, exit);
     Error *err = NULL;
 
-    if (s->down_script[0]) {
-        launch_script(s->down_script, s->down_script_arg, s->fd, &err);
-        if (err) {
-            error_report_err(err);
-        }
+    launch_script(s->down_script, s->down_script_arg, s->fd, &err);
+    if (err) {
+        error_report_err(err);
     }
 }
 
@@ -346,8 +344,11 @@ static void tap_cleanup(NetClientState *nc)
 
     qemu_purge_queued_packets(nc);
 
-    tap_exit_notify(&s->exit, NULL);
-    qemu_remove_exit_notifier(&s->exit);
+    if (s->exit.notify) {
+        tap_exit_notify(&s->exit, NULL);
+        qemu_remove_exit_notifier(&s->exit);
+        s->exit.notify = NULL;
+    }
 
     tap_read_poll(s, false);
     tap_write_poll(s, false);
@@ -443,9 +444,6 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     tap_read_poll(s, true);
     s->vhost_net = NULL;
 
-    s->exit.notify = tap_exit_notify;
-    qemu_add_exit_notifier(&s->exit);
-
     return s;
 }
 
@@ -733,6 +731,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
                      "%s", ifname);
+            s->exit.notify = tap_exit_notify;
+            qemu_add_exit_notifier(&s->exit);
         }
     }
 
-- 
2.48.1


