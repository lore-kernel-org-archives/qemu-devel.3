Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA782CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVhv-0000D0-VS; Thu, 30 Oct 2025 12:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhp-0008Eu-GO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:57 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhW-0003Gy-1N
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 31C9D80B38;
 Thu, 30 Oct 2025 19:40:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OeiSuH0Fn4Y0-fmnN09SF; Thu, 30 Oct 2025 19:40:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761842429;
 bh=LGkbs3h02szBvvteV5V6gUdc2a4VCa3Q9sfv9PJwrLg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZudjyC+gFfXj6K9H2x4wJ0BOJ2+7T4+jb3oz14hHj4Ujqc2o2o/mxlBzWeflcKz+B
 b/pb331sTwMMgQbZhBMhpYVFV6h/x3JkfLXz8dbzeiJHYwjtyrn1KVM5aMOOyrjCCG
 Mwmk+XkzyUDqBxqgureHLlVUAN29uFT2Iy2y5r2Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v9 7/7] net/tap: rework tap_set_sndbuf()
Date: Thu, 30 Oct 2025 19:40:23 +0300
Message-ID: <20251030164023.710048-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030164023.710048-1-vsementsov@yandex-team.ru>
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
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

Keep NetdevTapOptions related logic in tap.c, and make tap_set_sndbuf a
simple system call wrapper, more like other functions in tap-linux.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap-bsd.c     |  2 +-
 net/tap-linux.c   | 16 ++--------------
 net/tap-solaris.c |  2 +-
 net/tap-stub.c    |  2 +-
 net/tap.c         |  6 +++++-
 net/tap_int.h     |  3 +--
 6 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 9bd282b69c..4cea60664e 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -206,7 +206,7 @@ error:
 }
 #endif /* __FreeBSD__ */
 
-bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
     return true;
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index db68693bbf..bb73fa4b13 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -143,21 +143,9 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
  * Ethernet NICs generally have txqueuelen=1000, so 1Mb is
  * a good value, given a 1500 byte MTU.
  */
-#define TAP_DEFAULT_SNDBUF 0
-
-bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
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
         return false;
     }
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index e5ba89d926..e925ca8ae9 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -208,7 +208,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     return fd;
 }
 
-bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
     return true;
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 86d7d38e0f..6aa60d96ad 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -33,7 +33,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     return -1;
 }
 
-bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
     return true;
 }
diff --git a/net/tap.c b/net/tap.c
index ed20155b11..3bd81883fd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -711,8 +711,12 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 {
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
+    bool sndbuf_required = tap->has_sndbuf;
+    int sndbuf =
+        (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
-    if (!tap_set_sndbuf(s->fd, tap, errp)) {
+    if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
+        sndbuf_required) {
         goto failed;
     }
 
diff --git a/net/tap_int.h b/net/tap_int.h
index 7963dd6aae..dc4f484006 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -26,7 +26,6 @@
 #ifndef NET_TAP_INT_H
 #define NET_TAP_INT_H
 
-#include "qapi/qapi-types-net.h"
 #include "net/net.h"
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
@@ -34,7 +33,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
 
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
-bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
-- 
2.48.1


