Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C97E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEbE-000105-8L; Mon, 16 Dec 2024 12:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tNEb6-0000zL-Ki
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tNEb3-0007dT-0O
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734368964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9tHH4zkZzZdjZA04clbr0cib8g9HeN+u6OhAHtHA+2o=;
 b=ZMW2fYvMq58aK6XtRe8ud0iG7yJMpynxQ5Ub+oeZbeehCA/5q+jJD6eb/6kyV+h2udrKPN
 1XyWtv6tPMtRg3DVfzA0XCz3hT8BGknpUt7F054qS/1Fav3iCBJcYu3EKzqw+P2ddE4IP9
 T7gaZAS/f14ApIQ7yNpEGuDkXFSFTvs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-u77pG15HM4OdbvRhYKxNEQ-1; Mon,
 16 Dec 2024 12:09:20 -0500
X-MC-Unique: u77pG15HM4OdbvRhYKxNEQ-1
X-Mimecast-MFC-AGG-ID: u77pG15HM4OdbvRhYKxNEQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BB971955F09; Mon, 16 Dec 2024 17:09:19 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.193.84])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93F1219560A3; Mon, 16 Dec 2024 17:09:16 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, jonah.palmer@oracle.com, qemu-trivial@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, aesteve@redhat.com,
 hreitz@redhat.com
Subject: [PATCH] qmp: update vhost-user protocol feature maps
Date: Mon, 16 Dec 2024 18:09:14 +0100
Message-ID: <20241216170914.1346403-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add VHOST_USER_PROTOCOL_F_SHARED_OBJECT and
VHOST_USER_PROTOCOL_F_DEVICE_STATE protocol feature maps to
the virtio introspection.

Cc: jonah.palmer@oracle.com
Fixes: 160947666276 ("vhost-user: add shared_object msg")
Cc: aesteve@redhat.com
Fixes: cda83adc62b6 ("vhost-user: Interface for migration state transfer")
Cc: hreitz@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-qmp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index cccc6fe76183..8a32a3b1052c 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -121,6 +121,12 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
             "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
             "device status supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHARED_OBJECT, \
+            "VHOST_USER_PROTOCOL_F_SHARED_OBJECT: Backend shared object "
+            "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
+            "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
+            "supported"),
     { -1, "" }
 };
 
-- 
2.47.1


