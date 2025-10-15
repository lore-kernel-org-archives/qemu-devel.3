Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E142DCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xgW-0004D2-JV; Wed, 15 Oct 2025 05:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xgT-00049E-TH
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8xg8-0007tr-M1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760520008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=37RHUcEAG6umQd9fGbe3X3p5XRjtgf1f2iFAxJSPW+Y=;
 b=btjfy8Qwam9X3wIZ6+xLo5y7wwCd/HuZZTHx8Ez7KTZG+AlzJM8a+pdCHScshP970zULzF
 cjPup5hpjWicxEf1x+szdMPYtxKgCMY7qz8ohZf0Gxxp12n6hDaxFV6CFfrSNGC0ZqfM5D
 tzvqVMLntJd0TGOBJJwu7hRHqx5+ieI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-ddP9GtA5OtGqdTfrb4uaNQ-1; Wed,
 15 Oct 2025 05:20:07 -0400
X-MC-Unique: ddP9GtA5OtGqdTfrb4uaNQ-1
X-Mimecast-MFC-AGG-ID: ddP9GtA5OtGqdTfrb4uaNQ_1760520006
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 934B81800345
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.32.123])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4D6918004D4; Wed, 15 Oct 2025 09:20:04 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH] vhost-user: fix shared object lookup handler logic
Date: Wed, 15 Oct 2025 11:19:55 +0200
Message-ID: <20251015091955.1524800-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fix vhost_user_backend_handle_shared_object_lookup() logic to handle
the error path the same way as other handlers do. The main
difference between them is that shared_object_lookup handler
sends the reply from within the handler itself.

What vhost_user_backend_handle_shared_object_lookup() returns, depends
on whether vhost_user_backend_send_dmabuf_fd() succeded or not to send
a reply. Any check that results in an error before that only
determines the return value in the response. However, when an error
in sending the response within the handler occurs, we want to jump
to err and close the backend channel to be consistent with other message
types. On the other hand, when the response succeds then the
VHOST_USER_NEED_REPLY_MASK flag is unset and the reply in backend_read
is skipped, going directly to the fdcleanup.

Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 36c9c2e04d..163c3d8ca5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1833,8 +1833,11 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
                                                              &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-                                                             &hdr, &payload);
+        /* Handler manages its own response, check error and close connection */
+        if (vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
+                                                           &hdr, &payload) < 0) {
+            goto err;
+        }
         break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
-- 
2.49.0


