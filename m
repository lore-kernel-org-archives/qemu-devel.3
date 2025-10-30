Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21DBCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWJp-0001Nk-U5; Thu, 30 Oct 2025 13:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJS-000182-Um
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:51 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJ4-0008MB-Jp
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A1332807E8;
 Thu, 30 Oct 2025 20:19:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GJjc0O0FA0U0-JA72TGSj; Thu, 30 Oct 2025 20:19:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761844760;
 bh=yeWOZPxoQ+RhgwSWm4C33+dN10v4duJePM9Nwnd0SsA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UUHvPIWjX1//IuHbtQ1LEloYBcJPBAeQnjUxCyBfa81OIMWQa3CZBKG7ZWOd8dVf5
 BZlCIc1r6VWb1TAfQekLm1QLLopzPQDkdwG3coZVT5NMGJC48cinp264DHNYZrhW5l
 33JPIKbGOv594n1A1cUrQVrrj1vMZmHjdCCDJY28=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com
Subject: [PATCH v9 3/9] net/tap: split net_tap_fd_init()
Date: Thu, 30 Oct 2025 20:19:08 +0300
Message-ID: <20251030171915.726441-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030171915.726441-1-vsementsov@yandex-team.ru>
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Split the function into separate net_tap_new() and net_tap_set_fd().

We start move to the following picture:

net_tap_new() - take QAPI @tap parameter, but don't have @fd,
initialize the net client, called during initialization.

net_tap_setup() - don't have @tap (QAPI), but have @fd parameter,
may be called at later point.

In this commit we introduce the first function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 05f7480334..f5830f4b00 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -412,19 +412,20 @@ static NetClientInfo net_tap_info = {
     .get_vhost_net = tap_get_vhost_net,
 };
 
-static TAPState *net_tap_fd_init(NetClientState *peer,
-                                 const char *model,
-                                 const char *name,
-                                 int fd,
-                                 int vnet_hdr)
+static TAPState *net_tap_new(NetClientState *peer, const char *model,
+                             const char *name)
 {
-    NetOffloads ol = {};
-    NetClientState *nc;
-    TAPState *s;
+    NetClientState *nc = qemu_new_net_client(&net_tap_info, peer, model, name);
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
-    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
+    s->fd = -1;
 
-    s = DO_UPCAST(TAPState, nc, nc);
+    return s;
+}
+
+static void net_tap_set_fd(TAPState *s, int fd, int vnet_hdr)
+{
+    NetOffloads ol = {};
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -443,8 +444,6 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     }
     tap_read_poll(s, true);
     s->vhost_net = NULL;
-
-    return s;
 }
 
 static void close_all_fds_after_fork(int excluded_fd)
@@ -661,7 +660,9 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
+
+    s = net_tap_new(peer, "bridge", name);
+    net_tap_set_fd(s, fd, vnet_hdr);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
 
@@ -701,12 +702,14 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *downscript, const char *vhostfdname,
                              int vnet_hdr, int fd, Error **errp)
 {
-    TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
+    TAPState *s = net_tap_new(peer, model, name);
     int vhostfd;
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    net_tap_set_fd(s, fd, vnet_hdr);
+
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
-- 
2.48.1


