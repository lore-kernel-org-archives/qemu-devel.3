Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A50DD7237F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGAz-0005gM-7X; Fri, 23 Jan 2026 07:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAY-00057r-KY
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAW-000559-4B
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769170899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5kj45gtgryG+2GLx8F0xuwiGmEtj2lgp1HS7acdcHk=;
 b=egAMXI2AUDmAO6Zj9+VuHRunaGIYmVlHHiocSznQp5JlA7kSk2m6gICX9R6S1Hs9D6rOnk
 9N3N839/qarHZTc2BFeF63gpbD+DW61NY2wq5rGAD+AS8YZw780zuion7FUXhlXKnXfbHj
 yIWT0q5yX4yp4JTK7BB3IjIEZk5KGpQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-9EVb3PxiOb-Vsh9r49Jpww-1; Fri,
 23 Jan 2026 07:21:38 -0500
X-MC-Unique: 9EVb3PxiOb-Vsh9r49Jpww-1
X-Mimecast-MFC-AGG-ID: 9EVb3PxiOb-Vsh9r49Jpww_1769170897
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A3541955DA2; Fri, 23 Jan 2026 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9773B30002D1; Fri, 23 Jan 2026 12:21:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 08/13] net/tap: rework tap_set_sndbuf()
Date: Fri, 23 Jan 2026 20:20:57 +0800
Message-ID: <20260123122102.51422-9-jasowang@redhat.com>
In-Reply-To: <20260123122102.51422-1-jasowang@redhat.com>
References: <20260123122102.51422-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Keep NetdevTapOptions related logic in tap.c, and make tap_set_sndbuf a
simple system call wrapper, more like other functions in tap-linux.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap-bsd.c     |  2 +-
 net/tap-linux.c   | 16 ++--------------
 net/tap-solaris.c |  2 +-
 net/tap-stub.c    |  2 +-
 net/tap.c         |  6 +++++-
 net/tap_int.h     |  3 +--
 6 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 0e62530aaa..c39daf9385 100644
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
index 2b2d75a823..3cd7d26710 100644
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
index 049b551ae1..8704b1084b 100644
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
index 07a450e68d..8d7ab6ba6f 100644
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
2.42.0


