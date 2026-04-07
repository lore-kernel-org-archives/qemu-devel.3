Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3963FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXa-0000H0-2j; Tue, 07 Apr 2026 14:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1wABUI-0003JL-C3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w9yg6-0003Hr-MB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 01:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775538522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqH93DCOuaDxrfFcJBWlQQkrhR6XKCODDJxRQl2Naqw=;
 b=ZWeuc3CM3tIFU4/hfSGgS6aytbiETW/AIMqBidulnhyj+DmkKVCCoKfe4q+ZKgLQnOUtmR
 VjPgU4pp+648B/BO6qbc2JoGN1XHwklABBwF0RbpZpywDljlWvQqL5yToJkgS+xnE4/NnA
 ZK45cZf+xNekH3+1SmscJnM16dNB7zE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-lbPaI0P7OJyJCrRmcsPWGQ-1; Tue,
 07 Apr 2026 01:08:38 -0400
X-MC-Unique: lbPaI0P7OJyJCrRmcsPWGQ-1
X-Mimecast-MFC-AGG-ID: lbPaI0P7OJyJCrRmcsPWGQ_1775538518
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFF4B1800365; Tue,  7 Apr 2026 05:08:37 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD8F91800361; Tue,  7 Apr 2026 05:08:34 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v4 3/5] io/channel-socket: tolerate AF_PACKET getpeername
Date: Tue,  7 Apr 2026 13:05:50 +0800
Message-ID: <20260407050818.2249570-4-lulu@redhat.com>
In-Reply-To: <20260407050818.2249570-1-lulu@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

When -chardev socket,fd=... is handed an AF_PACKET socket,
getpeername() can fail with EOPNOTSUPP instead of ENOTCONN because
packet sockets are not connection-oriented. qio_channel_socket_set_fd()
currently treats that as fatal and refuses to wrap the fd, even though
getsockname() and the local address are still valid.

Treat EOPNOTSUPP the same way as ENOTCONN and leave remoteAddr empty.
That keeps existing stream-socket behavior unchanged while allowing
AF_PACKET fds to be adopted by QIOChannelSocket.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 io/channel-socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..2ed26aefa3 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -115,7 +115,11 @@ qio_channel_socket_set_fd(QIOChannelSocket *sioc,
 
     if (getpeername(fd, (struct sockaddr *)&sioc->remoteAddr,
                     &sioc->remoteAddrLen) < 0) {
-        if (errno == ENOTCONN) {
+        if (errno == ENOTCONN
+#ifdef EOPNOTSUPP
+            || errno == EOPNOTSUPP
+#endif
+            ) {
             memset(&sioc->remoteAddr, 0, sizeof(sioc->remoteAddr));
             sioc->remoteAddrLen = sizeof(sioc->remoteAddr);
         } else {
-- 
2.52.0


