Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1ADC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 22:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKlKm-0005WS-Nk; Thu, 29 May 2025 18:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKj-0005VY-N5
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKg-0002Yp-Fh
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748556156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKXtOIjLZ2HpnXimfT4KSht7b6TlRbU7mhUuvrVt6xE=;
 b=iMQzfN/HHy4ID98qKAdg9yxoWiX95/6R/SloGaE0iLXOv13zpRa2iEvD3GqRHoWQgmHwy+
 F0PhGZL8Rnc+e54lBP4ylkMVv+usCm31LZakXC8vSXRRmwkc4jNo4YeO2J+p7L2GPvDMAl
 857JEV5t/5lmtcTRP/43r9rFBF7ihkk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-WLODX7WRMROAkqHDlA4iPg-1; Thu,
 29 May 2025 18:02:34 -0400
X-MC-Unique: WLODX7WRMROAkqHDlA4iPg-1
X-Mimecast-MFC-AGG-ID: WLODX7WRMROAkqHDlA4iPg_1748556153
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD5701956046; Thu, 29 May 2025 22:02:33 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2C3619560A7; Thu, 29 May 2025 22:02:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nirsof@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/6] io: Add helper for setting socket send buffer size
Date: Thu, 29 May 2025 17:02:08 -0500
Message-ID: <20250529220228.1187563-9-eblake@redhat.com>
In-Reply-To: <20250529220228.1187563-8-eblake@redhat.com>
References: <20250529220228.1187563-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nir Soffer <nirsof@gmail.com>

Testing reading and writing from qemu-nbd using a unix domain socket
shows that the platform default send buffer size is too low, leading to
poor performance and hight cpu usage.

Add a helper for setting socket send buffer size to be used in NBD code.
It can also be used in other contexts.

We don't need a helper for receive buffer size since it is not used with
unix domain sockets. This is documented for Linux, and not documented
for macOS.

Failing to set the socket buffer size is not a fatal error, but the
caller may want to warn about the failure.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Message-ID: <20250517201154.88456-2-nirsof@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/io/channel-socket.h | 13 +++++++++++++
 io/channel-socket.c         | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index ab15577d384..a88cf8b3a9f 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -261,5 +261,18 @@ QIOChannelSocket *
 qio_channel_socket_accept(QIOChannelSocket *ioc,
                           Error **errp);

+/**
+ * qio_channel_socket_set_send_buffer:
+ * @ioc: the socket channel object
+ * @size: buffer size
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Set the underlying socket send buffer size.
+ *
+ * Retruns: 0 on success, or -1 on error.
+ */
+int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
+                                       size_t size,
+                                       Error **errp);

 #endif /* QIO_CHANNEL_SOCKET_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 088b49ffdb0..3b7ca924ff3 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -78,6 +78,17 @@ qio_channel_socket_new(void)
     return sioc;
 }

+int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
+                                       size_t size,
+                                       Error **errp)
+{
+    if (setsockopt(ioc->fd, SOL_SOCKET, SO_SNDBUF, &size, sizeof(size)) < 0) {
+        error_setg_errno(errp, errno, "Unable to set socket send buffer size");
+        return -1;
+    }
+
+    return 0;
+}

 static int
 qio_channel_socket_set_fd(QIOChannelSocket *sioc,
-- 
2.49.0


