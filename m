Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DB0C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 07:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSu5R-0003SV-0a; Thu, 25 Jan 2024 02:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rSu5P-0003SJ-BG
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:23:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rSu5K-0005b9-M0
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706167416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTI+nDTYQTPJLwM7JL2s7diVHZaZWwtsPS+7Z3/UlLU=;
 b=HKEjxjKG7SCdRmpr85pQtoYmtpwO6ztUeHQU/QZaliO4LcC8xwEh+HYKAxbxnOhyIookc3
 w697iEOr4H1F/jNY3DA7uVvPhpPPIguc41wNAbdxemT7FrMd1hwxe3u0gjQnFK+Syeuqeo
 WDjvTj42eESzN6en+pzE1IrmYWTabaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ILKDbpiDNxmw_bZza8EVKA-1; Thu, 25 Jan 2024 02:22:30 -0500
X-MC-Unique: ILKDbpiDNxmw_bZza8EVKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC7C48493E8
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 07:22:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79A131121306;
 Thu, 25 Jan 2024 07:22:28 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	mtosatti@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org, vchundur@redhat.com,
 Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH v3 1/3] qio: add support for SO_PEERCRED for socket channel
Date: Thu, 25 Jan 2024 08:22:12 +0100
Message-ID: <20240125072214.318382-2-aharivel@redhat.com>
In-Reply-To: <20240125072214.318382-1-aharivel@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

The function qio_channel_get_peercred() returns a pointer to the
credentials of the peer process connected to this socket.

This credentials structure is defined in <sys/socket.h> as follows:

struct ucred {
	pid_t pid;    /* Process ID of the sending process */
	uid_t uid;    /* User ID of the sending process */
	gid_t gid;    /* Group ID of the sending process */
};

The use of this function is possible only for connected AF_UNIX stream
sockets and for AF_UNIX stream and datagram socket pairs.

On platform other than Linux, the function return 0.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 include/io/channel.h | 21 +++++++++++++++++++++
 io/channel-socket.c  | 23 +++++++++++++++++++++++
 io/channel.c         | 12 ++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 5f9dbaab65b0..0413435ce011 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -149,6 +149,9 @@ struct QIOChannelClass {
                                   void *opaque);
     int (*io_flush)(QIOChannel *ioc,
                     Error **errp);
+    void (*io_peerpid)(QIOChannel *ioc,
+                        unsigned int *pid,
+                        Error **errp);
 };
 
 /* General I/O handling functions */
@@ -898,4 +901,22 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
 int qio_channel_flush(QIOChannel *ioc,
                       Error **errp);
 
+/**
+ * qio_channel_get_peercred:
+ * @ioc: the channel object
+ * @pid: pointer to pid
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Returns the pid of the peer process connected to this socket.
+ *
+ * The use of this function is possible only for connected
+ * AF_UNIX stream sockets and for AF_UNIX stream and datagram
+ * socket pairs on Linux.
+ * Return 0 for the non-Linux OS.
+ *
+ */
+void qio_channel_get_peerpid(QIOChannel *ioc,
+                              unsigned int *pid,
+                              Error **errp);
+
 #endif /* QIO_CHANNEL_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3a899b060858..e6a73592650c 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -841,6 +841,28 @@ qio_channel_socket_set_cork(QIOChannel *ioc,
     socket_set_cork(sioc->fd, v);
 }
 
+static void
+qio_channel_socket_get_peerpid(QIOChannel *ioc,
+                               unsigned int *pid,
+                               Error **errp)
+{
+#ifdef CONFIG_LINUX
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    Error *err = NULL;
+    socklen_t len = sizeof(struct ucred);
+
+    struct ucred cred;
+    if (getsockopt(sioc->fd,
+               SOL_SOCKET, SO_PEERCRED,
+               &cred, &len) == -1) {
+        error_setg_errno(&err, errno, "Unable to get peer credentials");
+        error_propagate(errp, err);
+    }
+    *pid = (unsigned int)cred.pid;
+#else
+    *pid = 0;
+#endif
+}
 
 static int
 qio_channel_socket_close(QIOChannel *ioc,
@@ -938,6 +960,7 @@ static void qio_channel_socket_class_init(ObjectClass *klass,
 #ifdef QEMU_MSG_ZEROCOPY
     ioc_klass->io_flush = qio_channel_socket_flush;
 #endif
+    ioc_klass->io_peerpid = qio_channel_socket_get_peerpid;
 }
 
 static const TypeInfo qio_channel_socket_info = {
diff --git a/io/channel.c b/io/channel.c
index 86c5834510ff..a5646650cf72 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -490,6 +490,18 @@ void qio_channel_set_cork(QIOChannel *ioc,
     }
 }
 
+void qio_channel_get_peerpid(QIOChannel *ioc,
+                             unsigned int *pid,
+                             Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_peerpid) {
+        error_setg(errp, "Channel does not support peer pid");
+        return;
+    }
+    klass->io_peerpid(ioc, pid, errp);
+}
 
 off_t qio_channel_io_seek(QIOChannel *ioc,
                           off_t offset,
-- 
2.43.0


