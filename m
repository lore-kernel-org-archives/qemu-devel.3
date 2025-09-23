Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2BECAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zq1-0002jv-BX; Tue, 23 Sep 2025 06:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpt-0002fd-4m
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:25 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpm-0000tU-Ne
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1738980923;
 Tue, 23 Sep 2025 13:01:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-DIKd8hcP; Tue, 23 Sep 2025 13:01:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621676;
 bh=rwWQWDuCrtCAcBZ8GOgOqYHWMhtyjQ7SF8SVhKkg8x8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=T6Y2UVGBjO8EuNTmajVAxze8TK94KNmoJ2utwdXl7t0MeGse3GUJJqn+nRURsulpI
 3d+21RuOhhm0MbBpYeXAxyTuyuMrXu5fSm08hK+4rx5qmLBe8ega+TFlq4pmGAS20z
 R5R+mOKXWWPOpDd1fuAT2m9chw4O5wRrytIvpxmw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 07/19] net/tap: split net_tap_fd_init()
Date: Tue, 23 Sep 2025 13:00:58 +0300
Message-ID: <20250923100110.70862-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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
---
 net/tap.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index a7ae7ab04a..048d130247 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -401,19 +401,19 @@ static NetClientInfo net_tap_info = {
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
-    NetClientState *nc;
-    TAPState *s;
+    NetClientState *nc = qemu_new_net_client(&net_tap_info, peer, model, name);
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
-    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
+    s->fd = -1;
 
-    s = DO_UPCAST(TAPState, nc, nc);
+    return s;
+}
 
+static void net_tap_set_fd(TAPState *s, int fd, int vnet_hdr)
+{
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
     s->using_vnet_hdr = false;
@@ -430,8 +430,6 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     }
     tap_read_poll(s, true);
     s->vhost_net = NULL;
-
-    return s;
 }
 
 static void close_all_fds_after_fork(int excluded_fd)
@@ -648,7 +646,9 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
+
+    s = net_tap_new(peer, "bridge", name);
+    net_tap_set_fd(s, fd, vnet_hdr);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
 
@@ -689,9 +689,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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


