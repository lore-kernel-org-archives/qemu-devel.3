Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF5AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiGkZ-0000pR-Ny; Fri, 10 Jul 2026 15:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wiGkJ-0000j8-L4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:18:50 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wiGkI-00057d-29
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:18:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id CD8DF807BA;
 Fri, 10 Jul 2026 22:18:44 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c7d::1:20])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id AIRXsO0a8eA0-rMEDC6Ws; Fri, 10 Jul 2026 22:18:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783711124;
 bh=hbYiRyekA3Dmh3vtzBsAip8Kg3UYaird5OyQROLYaS0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=y5lDmJqjXzzWdpiK+tSSdBTEAMnXhQ7VHeY8IHInlbQDpqsvIK6/7gmZpynqF9z5T
 UkONJBiJKX4f6aTxLFDqYz8THBMKQFHyYVhk8rguNjcRcdh+DSKlCgKM/gSBXO0BDz
 3NGKmpgw7dDb6mQJlINz4jyW3tuW+vel7Ap6iHDY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v18 11/14] net/tap: disable read polling for stopped VM
Date: Fri, 10 Jul 2026 22:18:00 +0300
Message-ID: <20260710191809.721154-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710191809.721154-1-vsementsov@yandex-team.ru>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Polling when VM is stopped doesn't make real sense, as stopped VM can't
handle incoming traffic anyway.

And it's critical for introduction of local TAP migration
feature in the next commit: the TAP device will be transferred
to the target (open fd will be passed through migration channel),
and if we continue polling on source, we may get a package, which
we'll never handle on source (already stopped), it will be lost.
Better is save this package for target VM to handle.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index b5be456936d..605e5867b01 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -36,6 +36,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "monitor/monitor.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
@@ -92,6 +93,8 @@ struct TAPState {
     Notifier exit;
 
     int queue_index;
+    bool read_poll_detached;
+    VMChangeStateEntry *vmstate;
 };
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -146,6 +149,23 @@ static void tap_read_poll(TAPState *s, bool enable)
     tap_update_fd_handler(s);
 }
 
+static void tap_vm_state_change(void *opaque, bool running, RunState state)
+{
+    TAPState *s = opaque;
+
+    if (running) {
+        if (s->read_poll_detached) {
+            tap_read_poll(s, true);
+            s->read_poll_detached = false;
+        }
+    } else if (state == RUN_STATE_FINISH_MIGRATE) {
+        if (s->read_poll) {
+            s->read_poll_detached = true;
+            tap_read_poll(s, false);
+        }
+    }
+}
+
 static void tap_write_poll(TAPState *s, bool enable)
 {
     s->write_poll = enable;
@@ -376,6 +396,11 @@ static void tap_cleanup(NetClientState *nc)
         s->exit.notify = NULL;
     }
 
+    if (s->vmstate) {
+        qemu_del_vm_change_state_handler(s->vmstate);
+        s->vmstate = NULL;
+    }
+
     tap_read_poll(s, false);
     tap_write_poll(s, false);
     close(s->fd);
@@ -815,6 +840,9 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    s->read_poll_detached = false;
+    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
+
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
-- 
2.43.0


