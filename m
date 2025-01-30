Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0C1C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRlC-0007Qs-F8; Thu, 30 Jan 2025 05:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdRlA-0007Qc-Md; Thu, 30 Jan 2025 05:26:56 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdRl8-0000rY-Hv; Thu, 30 Jan 2025 05:26:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3DA5FE2F20;
 Thu, 30 Jan 2025 13:26:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EC0921A7DF9;
 Thu, 30 Jan 2025 13:26:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DC4EE5238A; Thu, 30 Jan 2025 13:26:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Samuel Thibault <samuel.thibault@gnu.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] net/slirp: libslirp 4.8.0 compatibility
Date: Thu, 30 Jan 2025 13:26:43 +0300
Message-Id: <20250130102643.844806-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

This updates the code in net/slirp.c to be compatible with
libslirp 4.8.0, which deprecated slirp_pollfds_fill()
and started using slirp_os_socket type for sockets
(which is a 64-bit integer on win64).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
I don't remember if this change has already been proposed.

 net/slirp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index eb9a456ed4..5d6d059a95 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -314,7 +314,12 @@ static int slirp_poll_to_gio(int events)
     return ret;
 }
 
-static int net_slirp_add_poll(int fd, int events, void *opaque)
+#if SLIRP_CONFIG_VERSION_MAX < 6 /* < 4.8.0 compatibility */
+# define slirp_os_socket int
+# define slirp_pollfds_fill_socket slirp_pollfds_fill
+#endif
+
+static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
 {
     GArray *pollfds = opaque;
     GPollFD pfd = {
@@ -363,8 +368,8 @@ static void net_slirp_poll_notify(Notifier *notifier, void *data)
 
     switch (poll->state) {
     case MAIN_LOOP_POLL_FILL:
-        slirp_pollfds_fill(s->slirp, &poll->timeout,
-                           net_slirp_add_poll, poll->pollfds);
+        slirp_pollfds_fill_socket(s->slirp, &poll->timeout,
+                                  net_slirp_add_poll, poll->pollfds);
         break;
     case MAIN_LOOP_POLL_OK:
     case MAIN_LOOP_POLL_ERR:
-- 
2.39.5


