Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41571FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXY-0000Gh-Vo; Tue, 07 Apr 2026 14:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1wABUI-0003Gt-3J
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w9ygX-0003OZ-UQ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 01:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775538548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gg4529iHncAEaCTY/PX+ysrl8jbN0pCBm9+RUtBBRwc=;
 b=i2lgC7UrQgtThApwCXXp6wzUDGPYGkhPc6nkMmPduzhc0/20JvEyEOxzLhn9Wu4yXGIElG
 PPflyC4WyeXx9M89rDo06ao7bDKZ37nWR0X0w/H0/uCcYqh81ZSv0UPezihkc3Mi9PxDwi
 mqT6wZneLkfPHsu2X2URRaM7X9T5hH4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-flpCFxObOweQEstrpIocrA-1; Tue,
 07 Apr 2026 01:09:04 -0400
X-MC-Unique: flpCFxObOweQEstrpIocrA-1
X-Mimecast-MFC-AGG-ID: flpCFxObOweQEstrpIocrA_1775538543
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C374F1956046; Tue,  7 Apr 2026 05:09:03 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 595E519560A6; Tue,  7 Apr 2026 05:09:00 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v4 4/5] chardev/socket: add AF_PACKET inject path
Date: Tue,  7 Apr 2026 13:05:51 +0800
Message-ID: <20260407050818.2249570-5-lulu@redhat.com>
In-Reply-To: <20260407050818.2249570-1-lulu@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add the AF_PACKET inject write path for socket chardevs. When a socket
backend is opened with af-packet-mode=inject, tcp_chr_write() no longer
sends the redirector stream framing through QIOChannel. Instead it
parses the existing 4-byte length header, accumulates one complete
packet, and frame on the AF_PACKET fd.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 chardev/char-socket.c | 148 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index c710fdb497..45d06fda8f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -108,11 +108,159 @@ static void tcp_chr_accept(QIONetListener *listener,
 static int tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect_locked(Chardev *chr);
 
+#define TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE 65536
+
+static bool tcp_chr_uses_af_packet_inject(SocketChardev *s)
+{
+    return s->is_af_packet &&
+           s->af_packet_mode_set &&
+           s->af_packet_mode == CHARDEV_SOCKET_AF_PACKET_MODE_INJECT;
+}
+
+static ssize_t tcp_chr_send_af_packet(SocketChardev *s,
+                                      const uint8_t *buf,
+                                      size_t len)
+{
+#ifdef CONFIG_LINUX
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = len,
+    };
+    struct msghdr msg = {
+        .msg_iov = &iov,
+        .msg_iovlen = 1,
+    };
+    ssize_t ret;
+
+    if (!s->sioc || s->sioc->localAddr.ss_family != AF_PACKET) {
+        errno = ENOTSOCK;
+        return -1;
+    }
+
+    do {
+        ret = sendmsg(s->sioc->fd, &msg, 0);
+    } while (ret < 0 && errno == EINTR);
+
+    return ret;
+#else
+    errno = EPROTONOSUPPORT;
+    return -1;
+#endif
+}
+
+static bool tcp_chr_af_packet_prepare_send(SocketChardev *s, uint32_t frame_len)
+{
+    if (frame_len > TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE) {
+        errno = EMSGSIZE;
+        return false;
+    }
+
+    if (frame_len == 0) {
+        s->af_packet_send_len = 0;
+        s->af_packet_send_offset = 0;
+        s->af_packet_send_len_bytes = 0;
+        return true;
+    }
+
+    if (s->af_packet_send_buf_size < frame_len) {
+        s->af_packet_send_buf = g_realloc(s->af_packet_send_buf, frame_len);
+        s->af_packet_send_buf_size = frame_len;
+    }
+
+    s->af_packet_send_len = frame_len;
+    s->af_packet_send_offset = 0;
+    s->af_packet_send_len_bytes = sizeof(s->af_packet_send_len_buf);
+    return true;
+}
+
+static int tcp_chr_inject_af_packet(Chardev *chr,
+                                    SocketChardev *s,
+                                    const uint8_t *buf,
+                                    int len)
+{
+    size_t offset = 0;
+    uint32_t frame_len_be;
+
+    while (offset < len) {
+        size_t copy;
+
+        if (s->af_packet_send_len_bytes < sizeof(s->af_packet_send_len_buf)) {
+            copy = MIN(sizeof(s->af_packet_send_len_buf) -
+                       s->af_packet_send_len_bytes,
+                       (size_t)len - offset);
+            memcpy(s->af_packet_send_len_buf + s->af_packet_send_len_bytes,
+                   buf + offset, copy);
+            s->af_packet_send_len_bytes += copy;
+            offset += copy;
+
+            if (s->af_packet_send_len_bytes <
+                sizeof(s->af_packet_send_len_buf)) {
+                continue;
+            }
+
+            memcpy(&frame_len_be, s->af_packet_send_len_buf,
+                   sizeof(frame_len_be));
+            if (!tcp_chr_af_packet_prepare_send(s, ntohl(frame_len_be))) {
+                return -1;
+            }
+            if (s->af_packet_send_len == 0) {
+                continue;
+            }
+        }
+
+        copy = MIN(s->af_packet_send_len - s->af_packet_send_offset,
+                   (size_t)len - offset);
+        memcpy(s->af_packet_send_buf + s->af_packet_send_offset,
+               buf + offset, copy);
+        s->af_packet_send_offset += copy;
+        offset += copy;
+
+        if (s->af_packet_send_offset == s->af_packet_send_len) {
+            ssize_t ret;
+
+            ret = tcp_chr_send_af_packet(s, s->af_packet_send_buf,
+                                         s->af_packet_send_len);
+
+            if (ret < 0) {
+                if (errno == EAGAIN || errno == EWOULDBLOCK) {
+                    return -1;
+                }
+                if (tcp_chr_read_poll(chr) <= 0) {
+                    trace_chr_socket_poll_err(chr, chr->label);
+                    tcp_chr_disconnect_locked(chr);
+                }
+                return -1;
+            }
+
+            if (ret != (ssize_t)s->af_packet_send_len) {
+                if (ret >= 0) {
+                    errno = EIO;
+                }
+                if (tcp_chr_read_poll(chr) <= 0) {
+                    trace_chr_socket_poll_err(chr, chr->label);
+                    tcp_chr_disconnect_locked(chr);
+                }
+                return -1;
+            }
+
+            s->af_packet_send_len = 0;
+            s->af_packet_send_offset = 0;
+            s->af_packet_send_len_bytes = 0;
+        }
+    }
+
+    return len;
+}
+
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
+    if (tcp_chr_uses_af_packet_inject(s)) {
+        return tcp_chr_inject_af_packet(chr, s, buf, len);
+    }
+
     if (s->state == TCP_CHARDEV_STATE_CONNECTED) {
         int ret =  io_channel_send_full(s->ioc, buf, len,
                                         s->write_msgfds,
-- 
2.52.0


