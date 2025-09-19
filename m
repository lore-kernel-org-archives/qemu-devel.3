Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E517CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXqi-0005vo-5H; Fri, 19 Sep 2025 05:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqb-0005gA-0d
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:11 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqS-0004Zr-Co
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4DCE780EE2;
 Fri, 19 Sep 2025 12:55:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-oha60RWq; Fri, 19 Sep 2025 12:55:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275756;
 bh=w1cyWF78HXtHriBMncCUv10Xr+DAGRcqyUlrjqYm39s=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=QqknjA1w9gC+M735UytuhnsyMOOnXyA1uMGekSKGhYtlgEQGWql1+LzmghA810pFR
 rErKwhLj9p+9BTZGgVm8i/mkg6Z0WzwCUhbo7TTTvqbJiJlv6pqVKiGBM51YVpjZyH
 A1pEyUf+Prxwmx0AFOU+WqbQN6O3Ab5XZCVhKNSc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 08/19] net/tap: rework tap_set_sndbuf()
Date: Fri, 19 Sep 2025 12:55:34 +0300
Message-ID: <20250919095545.1912042-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
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

First, follow common recommendations to avoid error propagation:
add return value to tap_set_sndbuf().

Second, keep NetdevTapOptions related logic in tap.c, and make
tap_set_sndbuf a simple system call wrapper, more like other functions
in tap-linux.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap-bsd.c     |  3 ++-
 net/tap-linux.c   | 19 +++++--------------
 net/tap-solaris.c |  3 ++-
 net/tap-stub.c    |  3 ++-
 net/tap.c         |  9 +++++----
 net/tap_int.h     |  4 +---
 6 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index b4c84441ba..3bfc1cc577 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -198,8 +198,9 @@ error:
 }
 #endif /* __FreeBSD__ */
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 22ec2f45d2..c46f488c08 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -138,23 +138,14 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
  * Ethernet NICs generally have txqueuelen=1000, so 1Mb is
  * a good value, given a 1500 byte MTU.
  */
-#define TAP_DEFAULT_SNDBUF 0
-
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
-    int sndbuf;
-
-    sndbuf = !tap->has_sndbuf       ? TAP_DEFAULT_SNDBUF :
-             tap->sndbuf > INT_MAX  ? INT_MAX :
-             tap->sndbuf;
-
-    if (!sndbuf) {
-        sndbuf = INT_MAX;
-    }
-
-    if (ioctl(fd, TUNSETSNDBUF, &sndbuf) == -1 && tap->has_sndbuf) {
+    if (ioctl(fd, TUNSETSNDBUF, &sndbuf) == -1) {
         error_setg_errno(errp, errno, "TUNSETSNDBUF ioctl failed");
+        return false;
     }
+
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 51b7830bef..2932c2de39 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -202,8 +202,9 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     return fd;
 }
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 38673434cb..326e76843e 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -33,8 +33,9 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     return -1;
 }
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap.c b/net/tap.c
index 3050fdea2e..5cb639a71d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -676,15 +676,16 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *downscript, const char *vhostfdname,
                              int vnet_hdr, int fd, Error **errp)
 {
-    Error *err = NULL;
     TAPState *s = net_tap_new(peer, model, name);
     int vhostfd;
+    bool sndbuf_required = tap->has_sndbuf;
+    int sndbuf =
+        (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
     net_tap_set_fd(s, fd, vnet_hdr);
 
-    tap_set_sndbuf(s->fd, tap, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
+        sndbuf_required) {
         goto failed;
     }
 
diff --git a/net/tap_int.h b/net/tap_int.h
index 8857ff299d..08e4a592a0 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -26,14 +26,12 @@
 #ifndef NET_TAP_INT_H
 #define NET_TAP_INT_H
 
-#include "qapi/qapi-types-net.h"
-
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
 
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
-- 
2.48.1


