Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D587CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZe3-0002EF-IV; Fri, 19 Sep 2025 07:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZe2-00027z-8N
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZdw-0000oD-TP
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kVgOQG1mOqMMrShBgYl6HdG7O1jge5gMd4Y6e+CPNqA=;
 b=eOSq/Wn+meKdjJdobgJyw9GPdX08GuFfp3JMvOwCZXMnjyptRi21v5nbjEw8DDw0bHZRQy
 alW6Mx3APs8i3sZjiZLbeKVlbVhFmabwfYN7/5WLCJA7Qjfc5FlJr075YrI7vXcLr9N87f
 fENpMnSihD9z3bDr8N7EdzXTTUMrfTo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-mJWvmZtmPq-bINoxBXqtxw-1; Fri,
 19 Sep 2025 07:51:03 -0400
X-MC-Unique: mJWvmZtmPq-bINoxBXqtxw-1
X-Mimecast-MFC-AGG-ID: mJWvmZtmPq-bINoxBXqtxw_1758282661
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D59180035C; Fri, 19 Sep 2025 11:51:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E1781955F21; Fri, 19 Sep 2025 11:50:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 03/16] io/channel: document how qio_channel_readv_full()
 handles fds
Date: Fri, 19 Sep 2025 12:50:04 +0100
Message-ID: <20250919115017.1536203-4-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The only realization, which may have incoming fds is
qio_channel_socket_readv() (in io/channel-socket.c).
qio_channel_socket_readv() do call (through
qio_channel_socket_copy_fds()) qemu_socket_set_block() and
qemu_set_cloexec() for each fd.

Also, qio_channel_socket_copy_fds() is called at the end of
qio_channel_socket_readv(), on success path.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 12266256a8..c7f64506f7 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -118,6 +118,15 @@ struct QIOChannelClass {
                          size_t nfds,
                          int flags,
                          Error **errp);
+
+    /*
+     * The io_readv handler must guarantee that all
+     * incoming fds are set BLOCKING (unless
+     * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag is set) and
+     * CLOEXEC (if available).
+     * @fds and @nfds are set only on success path, and untouched
+     * in case of errors.
+     */
     ssize_t (*io_readv)(QIOChannel *ioc,
                         const struct iovec *iov,
                         size_t niov,
@@ -125,6 +134,7 @@ struct QIOChannelClass {
                         size_t *nfds,
                         int flags,
                         Error **errp);
+
     int (*io_close)(QIOChannel *ioc,
                     Error **errp);
     GSource * (*io_create_watch)(QIOChannel *ioc,
@@ -235,6 +245,13 @@ void qio_channel_set_name(QIOChannel *ioc,
  * was allocated. It is the callers responsibility
  * to call close() on each file descriptor and to
  * call g_free() on the array pointer in @fds.
+ * @fds allocated and set (and @nfds is set too)
+ * _only_ on success path. These parameters are
+ * untouched in case of errors.
+ * qio_channel_readv_full() guarantees that all
+ * incoming fds are set BLOCKING (unless
+ * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag
+ * is set) and CLOEXEC (if available).
  *
  * It is an error to pass a non-NULL @fds parameter
  * unless qio_channel_has_feature() returns a true
-- 
2.50.1


