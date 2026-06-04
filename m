Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3809CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVEOx-0002Ap-UY; Thu, 04 Jun 2026 16:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOm-00022D-DX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOk-0006KW-Kz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780603838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8mnVozSEd48w7MhwSCFQ2rPIgSu70ABgHTMrQP/zQY=;
 b=Q6vCBealIekqd/lv4a9h5BLA5LTEeLd5GaUy9zxkgg3r/1L0Q+EKKPEWBn5hT1995KvUFh
 1rcY1fixHfAIAOiwuIr26T+8fgNEiOhChBAj2BbW0HJbSdCfWWNIwLRc/OohgxIKmdNJPY
 2ZjTE9wLzncGHKW26xrYkwmk2gb6BDM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-WF3WYCn8Pji5veX5wWIOEA-1; Thu,
 04 Jun 2026 16:10:36 -0400
X-MC-Unique: WF3WYCn8Pji5veX5wWIOEA-1
X-Mimecast-MFC-AGG-ID: WF3WYCn8Pji5veX5wWIOEA_1780603835
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCD131956094; Thu,  4 Jun 2026 20:10:35 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB640763; Thu,  4 Jun 2026 20:10:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, gmaglione@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, hreitz@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 2/3] libvhost-user: look for available vq buffers upon
 SET_VRING_KICK
Date: Thu,  4 Jun 2026 16:10:28 -0400
Message-ID: <20260604201029.250450-3-stefanha@redhat.com>
In-Reply-To: <20260604201029.250450-1-stefanha@redhat.com>
References: <20260604201029.250450-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a vring is started the back-end must look for available vq buffers
and process them. This scenario can happen if the back-end is stopped
with unprocessed available buffers and then started again.

The inflight I/O tracking code already did this, but it should also be
done when inflight I/O tracking is not enabled.

Move the code and make it robust in case of EINTR or EAGAIN.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 9c630c2170..1dbb774a76 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1390,11 +1390,6 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
         vq->counter = vq->resubmit_list[0].counter + 1;
     }
 
-    /* in case of I/O hang after reconnecting */
-    if (eventfd_write(vq->kick_fd, 1)) {
-        return -1;
-    }
-
     return 0;
 }
 
@@ -1436,6 +1431,20 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
         vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
     }
 
+    /* Inject a kick to look for available vq buffers */
+    if (dev->vq[index].kick_fd != -1) {
+        int ret;
+
+        do {
+            ret = eventfd_write(dev->vq[index].kick_fd, 1);
+        } while (ret != 0 && errno == EINTR);
+
+        if (ret != 0 && errno != EAGAIN /* already readable */) {
+            vu_panic(dev, "Failed to inject kick during SET_VRING_KICK "
+                     "on vq: %d with error: %m\n", index);
+        }
+    }
+
     return false;
 }
 
-- 
2.54.0


