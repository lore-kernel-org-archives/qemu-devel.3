Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49293FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXa-0000HD-Oi; Tue, 07 Apr 2026 14:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1wABUI-0003wR-3X
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w9ygb-0003R7-Jt
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 01:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775538552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ta00h+hy/b4+1DYEKhFkp7zFZotzTaGXo1VneuiSH34=;
 b=VPlL8jmFt7VEIhATaSr9d6tj17vho4BLRa9b5czz08EeBQ+VzITg0xvDfQT+vACPDoRLl0
 o6xBNckU7rqHzN2WmmOGwu9NZEEtcz+0sSbyLSMXGEXR4fbvQXd5GMJ/G7cgSXyAyzS+i5
 oYivYHpOVyZSBc/m5CHP2deNoL+liqg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-ad5hLYhuOqWiZ_p9azmfNA-1; Tue,
 07 Apr 2026 01:09:09 -0400
X-MC-Unique: ad5hLYhuOqWiZ_p9azmfNA-1
X-Mimecast-MFC-AGG-ID: ad5hLYhuOqWiZ_p9azmfNA_1775538548
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3468195608B; Tue,  7 Apr 2026 05:09:07 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 754451955F2B; Tue,  7 Apr 2026 05:09:04 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v4 5/5] chardev/socket: add AF_PACKET capture path
Date: Tue,  7 Apr 2026 13:05:52 +0800
Message-ID: <20260407050818.2249570-6-lulu@redhat.com>
In-Reply-To: <20260407050818.2249570-1-lulu@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the AF_PACKET capture read path for socket chardevs. When opened
with af-packet-mode=capture, the read side drains raw frames with
recvfrom(), keeps only PACKET_OUTGOING traffic, and feeds the result
through the normal chardev frontend interface.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 chardev/char-socket.c | 133 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 45d06fda8f..76a51a853d 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -107,9 +107,17 @@ static void tcp_chr_accept(QIONetListener *listener,
 
 static int tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect_locked(Chardev *chr);
+static void tcp_chr_deliver_af_packet(Chardev *chr);
 
 #define TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE 65536
 
+static bool
+tcp_chr_uses_af_packet_capture(SocketChardev *s)
+{
+    return s->is_af_packet && s->af_packet_mode_set &&
+           s->af_packet_mode == CHARDEV_SOCKET_AF_PACKET_MODE_CAPTURE;
+}
+
 static bool tcp_chr_uses_af_packet_inject(SocketChardev *s)
 {
     return s->is_af_packet &&
@@ -300,6 +308,9 @@ static int tcp_chr_read_poll(void *opaque)
         return 0;
     }
     s->max_size = qemu_chr_be_can_write(chr);
+    if (tcp_chr_uses_af_packet_capture(s) && s->af_packet_buf_len) {
+        tcp_chr_deliver_af_packet(chr);
+    }
     return s->max_size;
 }
 
@@ -500,6 +511,98 @@ static void tcp_chr_reset_af_packet_send(SocketChardev *s)
     s->af_packet_send_len_bytes = 0;
 }
 
+/* Push buffered AF_PACKET capture data into the chardev frontend. */
+static void
+tcp_chr_deliver_af_packet(Chardev *chr)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+
+    while (s->max_size > 0 && s->af_packet_buf_offset < s->af_packet_buf_len) {
+        size_t remaining = s->af_packet_buf_len - s->af_packet_buf_offset;
+        size_t chunk = MIN((size_t)s->max_size, remaining);
+
+        qemu_chr_be_write(chr, s->af_packet_buf + s->af_packet_buf_offset,
+                          (int)chunk);
+        s->af_packet_buf_offset += chunk;
+        s->max_size = qemu_chr_be_can_write(chr);
+    }
+
+    if (s->af_packet_buf_offset == s->af_packet_buf_len) {
+        tcp_chr_reset_af_packet_buf(s);
+    }
+}
+
+/* Copy buffered AF_PACKET capture data into a synchronous read buffer. */
+static int tcp_chr_copy_af_packet_buf(SocketChardev *s, uint8_t *buf,
+                                      int len) {
+    size_t remaining = s->af_packet_buf_len - s->af_packet_buf_offset;
+    size_t copied = MIN((size_t)len, remaining);
+
+    memcpy(buf, s->af_packet_buf + s->af_packet_buf_offset, copied);
+    s->af_packet_buf_offset += copied;
+
+    if (s->af_packet_buf_offset == s->af_packet_buf_len) {
+        tcp_chr_reset_af_packet_buf(s);
+    }
+
+    return (int)copied;
+}
+
+static ssize_t
+tcp_chr_capture_af_packet(Chardev *chr)
+{
+#ifdef CONFIG_LINUX
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+    struct sockaddr_ll sll;
+    socklen_t sll_len;
+    ssize_t size;
+    uint32_t len;
+
+    if (!tcp_chr_uses_af_packet_capture(s)) {
+        errno = EIO;
+        return -1;
+    }
+
+    if (s->af_packet_buf_size <
+        sizeof(len) + TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE) {
+        s->af_packet_buf =
+            g_realloc(s->af_packet_buf,
+                      sizeof(len) + TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE);
+        s->af_packet_buf_size =
+            sizeof(len) + TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE;
+    }
+
+    for (;;) {
+        sll_len = sizeof(sll);
+        do {
+            size = recvfrom(s->sioc->fd, s->af_packet_buf + sizeof(len),
+                            TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE, 0,
+                            (struct sockaddr *)&sll, &sll_len);
+        } while (size < 0 && errno == EINTR);
+
+        if (size <= 0) {
+            if (size < 0 && errno != EAGAIN && errno != EWOULDBLOCK) {
+                trace_chr_socket_recv_err(chr, chr->label, g_strerror(errno));
+            }
+            return size;
+        }
+
+        if (sll.sll_pkttype != PACKET_OUTGOING) {
+            continue;
+        }
+
+        len = htonl(size);
+        memcpy(s->af_packet_buf, &len, sizeof(len));
+        s->af_packet_buf_len = sizeof(len) + size;
+        s->af_packet_buf_offset = 0;
+        return (ssize_t)s->af_packet_buf_len;
+    }
+#else
+    errno = EPROTONOSUPPORT;
+    return -1;
+#endif
+}
+
 static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -682,6 +785,22 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     if (len > s->max_size) {
         len = s->max_size;
     }
+    if (tcp_chr_uses_af_packet_capture(s)) {
+        tcp_chr_deliver_af_packet(chr);
+        if (s->max_size <= 0 || s->af_packet_buf_len) {
+            return TRUE;
+        }
+
+        size = tcp_chr_capture_af_packet(chr);
+        if (size == 0 || (size == -1 && errno != EAGAIN)) {
+            tcp_chr_disconnect(chr);
+        } else if (size > 0) {
+            tcp_chr_deliver_af_packet(chr);
+        }
+
+        return TRUE;
+    }
+
     size = tcp_chr_recv(chr, (void *)buf, len);
     if (size == 0 || (size == -1 && errno != EAGAIN)) {
         /* connection closed */
@@ -715,6 +834,10 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
     int saved_errno;
     Error *local_err = NULL;
 
+    if (tcp_chr_uses_af_packet_capture(s) && s->af_packet_buf_len) {
+        return tcp_chr_copy_af_packet_buf(s, (uint8_t *)buf, len);
+    }
+
     if (s->state != TCP_CHARDEV_STATE_CONNECTED) {
         return 0;
     }
@@ -723,7 +846,14 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
         error_report_err(local_err);
         return -1;
     }
-    size = tcp_chr_recv(chr, (void *) buf, len);
+    if (tcp_chr_uses_af_packet_capture(s)) {
+        size = tcp_chr_capture_af_packet(chr);
+        if (size > 0) {
+            size = tcp_chr_copy_af_packet_buf(s, (uint8_t *)buf, len);
+        }
+    } else {
+        size = tcp_chr_recv(chr, (void *)buf, len);
+    }
     saved_errno = errno;
     if (s->state != TCP_CHARDEV_STATE_DISCONNECTED) {
         if (!qio_channel_set_blocking(s->ioc, false, &local_err)) {
@@ -1448,7 +1578,6 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     return false;
 }
 
-
 static int qmp_chardev_open_socket_server(Chardev *chr,
                                           bool is_telnet,
                                           bool is_waitconnect,
-- 
2.52.0


