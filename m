Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94862CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErXP-00076W-MM; Fri, 31 Oct 2025 11:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXH-00074S-41
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:31 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXC-0005zc-K3
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:30 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B9663807E3;
 Fri, 31 Oct 2025 18:59:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Fxip9o0FqiE0-TwTehFjH; Fri, 31 Oct 2025 18:59:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761926359;
 bh=vEFpAi/SJoZ1FyW5/cNP/W5tIquHEsUoHiATdJxF5jc=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=hF1bS4YV5TCTxrccSEq00j59kAqw4+UZf4UOArAIKMLEN8FskyvUKkFoIMoNfFKxI
 pmaZKU8IMkYyTddn0zGLzENxfSP1JCNbxw1aVo38B3zvp+IhIS15ly6jp2HrWX5hYo
 NAurDsZdmcTefr3nysyh+kJmjVkoiHBaSiYHzOuY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v5 1/7] chardev/char-socket: simplify reconnect-ms handling
Date: Fri, 31 Oct 2025 18:59:08 +0300
Message-ID: <20251031155914.189112-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031155914.189112-1-vsementsov@yandex-team.ru>
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We pass it to qmp_chardev_open_socket_client() only to write
to s->reconnect_time_ms. Let's simply set this field earlier,
together with other options.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 62852e3caf..f3bc6290d2 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1274,18 +1274,16 @@ skip_listen:
 
 
 static int qmp_chardev_open_socket_client(Chardev *chr,
-                                          int64_t reconnect_ms,
                                           Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
-    if (reconnect_ms > 0) {
-        s->reconnect_time_ms = reconnect_ms;
+    if (s->reconnect_time_ms > 0) {
         tcp_chr_connect_client_async(chr);
         return 0;
-    } else {
-        return tcp_chr_connect_client_sync(chr, errp);
     }
+
+    return tcp_chr_connect_client_sync(chr, errp);
 }
 
 
@@ -1378,7 +1376,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;
-    int64_t reconnect_ms = sock->has_reconnect_ms ? sock->reconnect_ms : 0;
     SocketAddress *addr;
 
     s->is_listen = is_listen;
@@ -1386,6 +1383,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->is_tn3270 = is_tn3270;
     s->is_websock = is_websock;
     s->do_nodelay = do_nodelay;
+    s->reconnect_time_ms = sock->has_reconnect_ms ? sock->reconnect_ms : 0;
+
     if (sock->tls_creds) {
         Object *creds;
         creds = object_resolve_path_component(
@@ -1450,7 +1449,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
             return;
         }
     } else {
-        if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0) {
+        if (qmp_chardev_open_socket_client(chr, errp) < 0) {
             return;
         }
     }
-- 
2.48.1


