Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10883CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVEOx-0002AM-Ok; Thu, 04 Jun 2026 16:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOq-00023Y-Uz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOo-0006Lo-Gx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780603841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePVVFhkYD8+HulndPgvP6eAiy10i4SRM0NiVpgFSZTg=;
 b=PAo/hCaBY322VIx7p03sA7UmRqqEinuzWSGtZ4xpU1NePxq9vreXhN4smxXlS6Y4P+2wna
 whA4lQUT89Q0UTs2oiyqghhiz00AyiR9NbZTP8jTljdKk1Z/Ee2Dck/JkgcG0cqZrbJrld
 1/hLTC6gwmcOhveAMOuc/dcGxxLkWwI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-j4pQ7VSqNlynWtfLYW8klQ-1; Thu,
 04 Jun 2026 16:10:38 -0400
X-MC-Unique: j4pQ7VSqNlynWtfLYW8klQ-1
X-Mimecast-MFC-AGG-ID: j4pQ7VSqNlynWtfLYW8klQ_1780603837
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FF321956059; Thu,  4 Jun 2026 20:10:37 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21169180049F; Thu,  4 Jun 2026 20:10:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, gmaglione@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, hreitz@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 3/3] vhost-user: inject kick after SET_VRING_KICK
Date: Thu,  4 Jun 2026 16:10:29 -0400
Message-ID: <20260604201029.250450-4-stefanha@redhat.com>
In-Reply-To: <20260604201029.250450-1-stefanha@redhat.com>
References: <20260604201029.250450-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The vhost-user specification was updated to say that front-ends should
inject a kick after SET_VRING_KICK in case the back-end implements the
old spec wording which said vrings start when a kick is received. Do
this in QEMU's front-end.

An example scenario where this behavior helps: the back-end fails to
check if the vring has available buffers when SET_VRING_KICK is received
and the front-end stopped and then restarted the vring. In the case the
back-end may not notice the available buffers unless the front-end
injects a kick.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-user.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a8907cca74..7ef4105473 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1365,7 +1365,29 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
 static int vhost_user_set_vring_kick(struct vhost_dev *dev,
                                      struct vhost_vring_file *file)
 {
-    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
+    int ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * Inject a kick in case the back-end only starts vring processing upon
+     * receiving a kick. The spec suggests this to improve compatibility.
+     */
+    if (file->fd != -1) {
+        uint64_t val = 1;
+        ssize_t nwritten;
+
+        do {
+            nwritten = write(file->fd, &val, sizeof(val));
+        } while (nwritten < 0 && errno == EINTR);
+
+        if (nwritten < 0 && errno != EAGAIN /* back-end can already read */) {
+            return -errno;
+        }
+    }
+
+    return 0;
 }
 
 static int vhost_user_set_vring_call(struct vhost_dev *dev,
-- 
2.54.0


