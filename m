Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02D1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFulh-0005P7-2j; Mon, 03 Nov 2025 08:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFulU-0005Lo-VN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFulM-0004Ou-Dz
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DCgQHRQ4LgqiDT0bOp7WC3tHOQInQec8YIMF3ANCBE=;
 b=EhJgah4ROBL81pKvhj4qg2Rh7NckWackEaLKlBps2/+lV3J6/1Z6UcKH0Xvamw7gcjSSdL
 rGE31buGvmyXudcRX9xBhhZfALK2d0LjKhX/EA4D8Vyg/OAcF5IuFuJDKgnbA/p/KLtiNV
 QipOthkF0wn9a4WIJqpXG1ibdWt957Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-mjR5QrdhNmyO8Km646FqJQ-1; Mon,
 03 Nov 2025 08:38:16 -0500
X-MC-Unique: mjR5QrdhNmyO8Km646FqJQ-1
X-Mimecast-MFC-AGG-ID: mjR5QrdhNmyO8Km646FqJQ_1762177095
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39D4118001DA; Mon,  3 Nov 2025 13:38:15 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 803541800576; Mon,  3 Nov 2025 13:38:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [PULL 05/32] io: add a "blocking" field to QIOChannelSocket
Date: Mon,  3 Nov 2025 13:36:59 +0000
Message-ID: <20251103133727.423041-6-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tejus GK <tejus.gk@nutanix.com>

Add a 'blocking' boolean field to QIOChannelSocket to track whether the
underlying socket is in blocking or non-blocking mode.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel-socket.h | 1 +
 io/channel-socket.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a88cf8b3a9..26319fa98b 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    bool blocking;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 712b793eaf..8b30d5b7f7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -65,6 +65,7 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->blocking = false;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -859,6 +860,7 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
                                 Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    sioc->blocking = enabled;
 
     if (!qemu_set_blocking(sioc->fd, enabled, errp)) {
         return -1;
-- 
2.51.1


