Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22447CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL0kk-0006tS-W3; Mon, 17 Nov 2025 10:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vL0kg-0006sH-TZ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:02:48 -0500
Received: from out28-58.mail.aliyun.com ([115.124.28.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vL0kc-0007KS-FW
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:02:46 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.fOYRWAQ_1763391734 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 17 Nov 2025 23:02:22 +0800
From: Jie Song <mail@jiesong.me>
To: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org
Cc: mail@jiesong.me,
	songjie_yewu@cmss.chinamobile.com
Subject: [PATCH v2] monitor/qmp: cleanup SocketChardev listener sources early
 to avoid fd handling race
Date: Mon, 17 Nov 2025 23:01:41 +0800
Message-ID: <20251117150142.131694-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.58; envelope-from=mail@jiesong.me;
 helo=out28-58.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Jie Song <songjie_yewu@cmss.chinamobile.com>

When starting a dummy QEMU process with virsh version, monitor_init_qmp()
enables IOThread monitoring of the QMP fd by default. However, a race
condition exists during the initialization phase: the IOThread only removes
the main thread's fd watch when it reaches qio_net_listener_set_client_func_full(),
which may be delayed under high system load.

This creates a window between monitor_qmp_setup_handlers_bh() and
qio_net_listener_set_client_func_full() where both the main thread and
IOThread are simultaneously monitoring the same fd and processing events.
This race can cause either the main thread or the IOThread to hang and
become unresponsive.

This fix calls qio_net_listener_set_client_func_full to change the
callback to NULL to destroy and unref all existing IO sources on the
socket chardev listener before the IOThread initializes QMP monitoring,
guaranteeing that no concurrent fd monitoring occurs during the transition
to IOThread handling.

Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
---
Changes in v2:
- Add the judgment of chrdev type, suggested by Daniel P . Berrangé
- Use qio_net_listener_set_client_func_full, suggested by Eric Blake
- Link to v1:
  https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg01621.html
---
 monitor/qmp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index cb99a12d94..0f74298ddd 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -25,6 +25,8 @@
 #include "qemu/osdep.h"
 
 #include "chardev/char-io.h"
+#include "chardev/char-socket.h"
+#include "io/net-listener.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
@@ -537,6 +539,16 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          * e.g. the chardev is in client mode, with wait=on.
          */
         remove_fd_in_watch(chr);
+        /*
+         * Clean up SocketChardev listener IO sources early to prevent
+         * racy fd handling between the main thread and the I/O thread.
+         */
+        if (object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_SOCKET)) {
+            SocketChardev *s = SOCKET_CHARDEV(chr);
+            if (s->listener)
+                qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
+                                                      NULL, chr->gcontext);
+        }
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
-- 
2.43.0


