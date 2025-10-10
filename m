Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A777CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H6Z-0008FN-Ua; Fri, 10 Oct 2025 13:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6V-0008Ec-Pv
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:31 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6I-0007S6-4p
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4EC8880779;
 Fri, 10 Oct 2025 20:40:08 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xdPFQ30FtmI0-VUhflSaL; Fri, 10 Oct 2025 20:40:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760118007;
 bh=hBBLVUnal74IiYpctK3zPNaVGPEhk/xudXLj3q7/EVs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lOsT0asiaq4LvDxJoeJ2FbujrUqswhvJad8m/iB4AXV5iVoLCAlWBH/myOWeKUqIa
 20RO9O8xRT64WvTRWTHpYl/5zyUHDRsfb7BV73LILPU87fMcZttx2bDnp1JlCX2fLk
 e0smBUbqciIvZJv9VqxgXSp3T75NGyv7f8EF7V0E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v7 07/19] net/tap: split net_tap_fd_init()
Date: Fri, 10 Oct 2025 20:39:45 +0300
Message-ID: <20251010173957.166759-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010173957.166759-1-vsementsov@yandex-team.ru>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 17ad561f9c..7cb694e683 100644
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
 
@@ -702,9 +703,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              int vnet_hdr, int fd, Error **errp)
 {
     Error *err = NULL;
-    TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
+    TAPState *s = net_tap_new(peer, model, name);
     int vhostfd;
 
+    net_tap_set_fd(s, fd, vnet_hdr);
+
     tap_set_sndbuf(s->fd, tap, &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.48.1


