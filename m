Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A1EE95363
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 09:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnZLM-0007bJ-QA; Wed, 04 Feb 2026 04:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vnZLL-0007b3-0i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vnZLJ-0006AM-Nn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770197917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyVUlr96lyflj2tq4vVPK9UjthiNXKRXd3/BU7iC+Pg=;
 b=RRqtcuyTM9lNhTGZSAnTQxO1GxmEetS8HicQofmHs8HtaVMxLIlcuRD0UfIIK5rHbcBmK2
 VTnSyWSwKPQohcmKipW4t+7VcBgrpUwHWqyOGYQ8fQGuq/MHD4isV7fRtqq0yQIqH1oaMS
 g2PzAFvx0ElkhdfstF5n4t+jUN6PDs0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-Dm9ZRyYFNpKcvUmyXV7esQ-1; Wed,
 04 Feb 2026 04:38:34 -0500
X-MC-Unique: Dm9ZRyYFNpKcvUmyXV7esQ-1
X-Mimecast-MFC-AGG-ID: Dm9ZRyYFNpKcvUmyXV7esQ_1770197912
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93D5F180025A; Wed,  4 Feb 2026 09:38:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.78])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24DB01955D88; Wed,  4 Feb 2026 09:38:26 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, slp@redhat.com, hi@alyssa.is,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, manos.pitsidianakis@linaro.org,
 stevensd@chromium.org, dbassey@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, mst@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 6/7] qmp: add shmem feature map
Date: Wed,  4 Feb 2026 10:37:57 +0100
Message-ID: <20260204093758.1250167-5-aesteve@redhat.com>
In-Reply-To: <20260204093758.1250167-1-aesteve@redhat.com>
References: <20260204093758.1250167-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add new vhost-user protocol
VHOST_USER_PROTOCOL_F_SHMEM feature to
feature map.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/virtio-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 968299fda0..e3d0a10a59 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -127,6 +127,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
             "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
             "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHMEM, \
+                "VHOST_USER_PROTOCOL_F_SHMEM: Backend shared memory mapping "
+                "supported"),
     { -1, "" }
 };
 
-- 
2.52.0


