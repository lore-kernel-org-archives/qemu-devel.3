Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D1EE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoAV-0007HH-Jm; Wed, 18 Feb 2026 15:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA3-00074X-Ui
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:40 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA0-0007rg-KK
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:38 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9D28CC038A;
 Wed, 18 Feb 2026 23:28:33 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VShB144A8iE0-fCZ88J6v; Wed, 18 Feb 2026 23:28:33 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771446513;
 bh=QLIq9qTK9Px46zQ/r9TYIEuLmijBWLAAX7/DLfF+Jdw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=GRkQdGs82gbuWUzk+LWaoqTP/Kx7DlRkW9AyS6Y+jjEO3E4JjxhQZNGD0PVNnOKes
 7+eDEdzKQ25UOaac88AcEl0dN5wRcbAdyZ3iW/2N72dVraJUAOpkKbirTRbkcbabqF
 3gR9qCy0TbQoPwJHHl0cxAVAc+X1zRWCpMlYbFvo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v3 01/12] net/af-xdp: fix type overflow
Date: Wed, 18 Feb 2026 23:28:17 +0300
Message-ID: <20260218202829.1322088-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In for-loop in net_init_af_xdp, we do nc->queue_index = i,
where is is int64_t for 0 to queues-1, and nc->queue_index is
unsigned int.

Also in parse_socket_fds, g_strv_length() returns guint which
is equivalent to unsigned int.

Let's simply use int type for queues, and update the check
appropriately. It could be unsigned int, but in future commits
we'll share with net/tap.c the common function which will return
number of queues or negative error. So, let's simply use int for
queues-related variables, that simplifies things.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/af-xdp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 14f302ea21..ff1cb30a98 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -442,14 +442,14 @@ static NetClientInfo net_af_xdp_info = {
 };
 
 static int *parse_socket_fds(const char *sock_fds_str,
-                             int64_t n_expected, Error **errp)
+                             int n_expected, Error **errp)
 {
     gchar **substrings = g_strsplit(sock_fds_str, ":", -1);
-    int64_t i, n_sock_fds = g_strv_length(substrings);
+    int i, n_sock_fds = g_strv_length(substrings);
     int *sock_fds = NULL;
 
     if (n_sock_fds != n_expected) {
-        error_setg(errp, "expected %"PRIi64" socket fds, got %"PRIi64,
+        error_setg(errp, "expected %d socket fds, got %d",
                    n_expected, n_sock_fds);
         goto exit;
     }
@@ -484,7 +484,7 @@ int net_init_af_xdp(const Netdev *netdev,
     unsigned int ifindex;
     uint32_t prog_id = 0;
     g_autofree int *sock_fds = NULL;
-    int64_t i, queues;
+    int i, queues;
     Error *err = NULL;
     AFXDPState *s;
     bool inhibit;
@@ -496,13 +496,14 @@ int net_init_af_xdp(const Netdev *netdev,
         return -1;
     }
 
-    queues = opts->has_queues ? opts->queues : 1;
-    if (queues < 1) {
+    if (opts->has_queues && (opts->queues < 1 || opts->queues > INT_MAX)) {
         error_setg(errp, "invalid number of queues (%" PRIi64 ") for '%s'",
-                   queues, opts->ifname);
+                   opts->queues, opts->ifname);
         return -1;
     }
 
+    queues = opts->has_queues ? opts->queues : 1;
+
     inhibit = opts->has_inhibit && opts->inhibit;
     if (inhibit && !opts->sock_fds && !opts->map_path) {
         error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
@@ -537,7 +538,7 @@ int net_init_af_xdp(const Netdev *netdev,
 
     for (i = 0; i < queues; i++) {
         nc = qemu_new_net_client(&net_af_xdp_info, peer, "af-xdp", name);
-        qemu_set_info_str(nc, "af-xdp%"PRIi64" to %s", i, opts->ifname);
+        qemu_set_info_str(nc, "af-xdp%d to %s", i, opts->ifname);
         nc->queue_index = i;
 
         if (!nc0) {
-- 
2.52.0


