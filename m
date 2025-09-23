Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E0DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zqh-0003EF-GC; Tue, 23 Sep 2025 06:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zqC-0002qk-Ni
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:44 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpp-0000ts-Mt
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 75EDD809DD;
 Tue, 23 Sep 2025 13:01:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-VMeo8eL5; Tue, 23 Sep 2025 13:01:17 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621677;
 bh=0rkp9X76WiOzr/q2WYArxjfrFUzR5vC9iuDCQ/fVu7w=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iyE4HqxKkLn2d8luJmXgX3xgFBj6cyfa2kSBHsI8J4dkYIxtx8xOAnzXddi6KxYok
 F8VlUxRd/ECjxnnqaF+5MTCa+1AH3/YuF1sGzbSb4hK41t7HZ0178q7fOxu6ikLRAL
 Tu7abXVx0qA0Ryz3Qe+hAFQm6lKw3SrWvaoUwM0E=
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
Subject: [PATCH v6 09/19] net/tap: rework tap_set_sndbuf()
Date: Tue, 23 Sep 2025 13:01:00 +0300
Message-ID: <20250923100110.70862-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Keep NetdevTapOptions related logic in tap.c, and make tap_set_sndbuf a
simple system call wrapper, more like other functions in tap-linux.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap-bsd.c     |  2 +-
 net/tap-linux.c   | 16 ++--------------
 net/tap-solaris.c |  2 +-
 net/tap-stub.c    |  2 +-
 net/tap.c         |  6 +++++-
 net/tap_int.h     |  4 +---
 6 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 501bf9d3eb..7dd9f0aeda 100644
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
index 8cb9dc0787..e3e71b713d 100644
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
index 496c1323fc..79e01a9de3 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -207,7 +207,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     return fd;
 }
 
-bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp)
 {
     return true;
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 8e328c679f..326e76843e 100644
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
index 95cbd75fe4..e6431d0e08 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -690,10 +690,14 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 {
     TAPState *s = net_tap_new(peer, model, name);
     int vhostfd;
+    bool sndbuf_required = tap->has_sndbuf;
+    int sndbuf =
+        (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
     net_tap_set_fd(s, fd, vnet_hdr);
 
-    if (!tap_set_sndbuf(s->fd, tap, errp)) {
+    if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
+        sndbuf_required) {
         goto failed;
     }
 
diff --git a/net/tap_int.h b/net/tap_int.h
index 08c40094b8..08e4a592a0 100644
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
 
-bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
+bool tap_set_sndbuf(int fd, int sndbuf, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
-- 
2.48.1


