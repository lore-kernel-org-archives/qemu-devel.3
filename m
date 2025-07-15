Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CE3C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiy3-0005op-Gt; Tue, 15 Jul 2025 12:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubiep-0006we-H9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubien-0003eq-NJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wes96bumQRuDZW+mPq0Q32pK6AXZIl13N1XQxgXrrwE=;
 b=NiQzGYax4JPMzkbvN5GnWH3Eg4HqWl1IlK8xdLsAYwX825+zwFtD2oMLJkwDrFp3MaCLlc
 JJBJZ4wEj8TulNyrlaxWdTCjiRRcVM+dIFUKe1aXm0PoKSF+8I36M31oxvXePwvViBwHa0
 32H/XDyj3mA5IwiB51rc6HjzygO7SUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-i_9vq3-xO6SiwBR66aWNtg-1; Tue,
 15 Jul 2025 12:37:21 -0400
X-MC-Unique: i_9vq3-xO6SiwBR66aWNtg-1
X-Mimecast-MFC-AGG-ID: i_9vq3-xO6SiwBR66aWNtg_1752597440
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF6C21800BC3; Tue, 15 Jul 2025 16:37:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0ABA3000198; Tue, 15 Jul 2025 16:37:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <markcaveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/7] hw/vfio-user: wait for proxy close correctly
Date: Tue, 15 Jul 2025 18:36:59 +0200
Message-ID: <20250715163703.243975-4-clg@redhat.com>
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
References: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

Coverity reported:

CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)

A wait is performed without a loop. If there is a spurious wakeup, the
condition may not be satisfied.

Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.

Also rename the callback for clarity.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <markcaveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250715115954.515819-4-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c418954440839b92864518cd757c750f0576d0af..2275d3fe395f2ba5915f1244e7e5acae8fecf731 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static void vfio_user_send(void *opaque);
-static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 
@@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
     }
 }
 
-static void vfio_user_cb(void *opaque)
+static void vfio_user_close_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
 
@@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
      * handler to run after the proxy fd handlers were
      * deleted above.
      */
-    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
-    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
+
+    while (proxy->state != VFIO_PROXY_CLOSED) {
+        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    }
 
     /* we now hold the only ref to proxy */
     qemu_mutex_unlock(&proxy->lock);
-- 
2.50.1


