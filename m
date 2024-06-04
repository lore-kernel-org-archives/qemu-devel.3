Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8380C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOkI-0008Hy-W0; Tue, 04 Jun 2024 03:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkH-0008HK-BV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkF-0006Iw-O1
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o46pYk0Rw9qkFji6WQPlc1KLze6u+AQMxjRmZxGygIM=;
 b=cSq+B5h2NsWxKZRgFS65lnZE+Gqy01KxKOmH9ufPuBmGOoQTlCrYZXfwGuK1zGm0xV0CX/
 EMYgD+ylEVs8z0ECg3kbOuEsu99i3vxlZpG+Jp+rKtTuSf3XSv5g21FEUF0HtUX+Jhdqir
 yqeUTZzEFKV63oIhfZbvs85KbWDOlCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-6SLO9J5NOXKcV2HAXjD8nQ-1; Tue, 04 Jun 2024 03:38:06 -0400
X-MC-Unique: 6SLO9J5NOXKcV2HAXjD8nQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BC9080027F;
 Tue,  4 Jun 2024 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B151F492BD2;
 Tue,  4 Jun 2024 07:38:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/20] tap: Remove tap_probe_vnet_hdr_len()
Date: Tue,  4 Jun 2024 15:37:36 +0800
Message-ID: <20240604073755.1859-2-jasowang@redhat.com>
In-Reply-To: <20240604073755.1859-1-jasowang@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It was necessary since an Linux older than 2.6.35 may implement the
virtio-net header but may not allow to change its length. Remove it
since such an old Linux is no longer supported.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap-bsd.c     |  5 -----
 net/tap-linux.c   | 20 --------------------
 net/tap-solaris.c |  5 -----
 net/tap-stub.c    |  5 -----
 net/tap.c         |  8 ++------
 net/tap_int.h     |  1 -
 6 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 274ea7bd2c..b4c84441ba 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,11 +217,6 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index c7e514ecb0..1226d5fda2 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -185,26 +185,6 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
-/* Verify that we can assign given length */
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    int orig;
-    if (ioctl(fd, TUNGETVNETHDRSZ, &orig) == -1) {
-        return 0;
-    }
-    if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
-        return 0;
-    }
-    /* Restore original length: we can't handle failure. */
-    if (ioctl(fd, TUNSETVNETHDRSZ, &orig) == -1) {
-        fprintf(stderr, "TUNGETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
-                strerror(errno));
-        abort();
-        return -errno;
-    }
-    return 1;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 08b13af512..51b7830bef 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -221,11 +221,6 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 4b24f61e3a..38673434cb 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,11 +52,6 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index baaa2f7a9a..72ae95894f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -259,11 +259,7 @@ static bool tap_has_vnet_hdr(NetClientState *nc)
 
 static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-
-    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-
-    return !!tap_probe_vnet_hdr_len(s->fd, len);
+    return tap_has_vnet_hdr(nc);
 }
 
 static int tap_get_vnet_hdr_len(NetClientState *nc)
@@ -432,7 +428,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
      * Make sure host header length is set correctly in tap:
      * it might have been modified by another instance of qemu.
      */
-    if (tap_probe_vnet_hdr_len(s->fd, s->host_vnet_hdr_len)) {
+    if (vnet_hdr) {
         tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     }
     tap_read_poll(s, true);
diff --git a/net/tap_int.h b/net/tap_int.h
index 9a2175655b..8857ff299d 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -35,7 +35,6 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
-int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
-- 
2.42.0


