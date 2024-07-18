Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A742C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQ1D-00082i-Bf; Thu, 18 Jul 2024 08:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhrica@redhat.com>) id 1sUQ1A-0007wi-KA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhrica@redhat.com>) id 1sUQ18-00013h-4q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721304828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4S4lHex2sv4HdAai4U1J0JqRHbZAZJuivl1Rp1CucQ=;
 b=YcEMTu0URPs8/6EkksnO9LyW0H7NpMKEa2u9ZVGXasBnkpJaFd2uFHQcASI5G4TggzcyI7
 1gpT9Geqk/iq9Z36kODcyRAJpd9fpuVxBq8wZFW/MF2XLXXQOmhfrbeCSZrGS/Z32Wgrhp
 ALY+5JyXh21JnIi7tSmFigLhwhJrKBQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-IA96ULi6NMS5Igetr_EJsw-1; Thu,
 18 Jul 2024 08:13:47 -0400
X-MC-Unique: IA96ULi6NMS5Igetr_EJsw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68DFA1955D42
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 12:13:46 +0000 (UTC)
Received: from m-rh-lap.brq.redhat.com (unknown [10.43.17.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 548FA19560AA; Thu, 18 Jul 2024 12:13:44 +0000 (UTC)
From: Matej Hrica <mhrica@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, dbassey@redhat.com, aesteve@redhat.com,
 slp@redhat.com, Matej Hrica <mhrica@redhat.com>
Subject: [RFC PATCH 1/2] vhost-user-gpu: Forward RESOURCE_BLOB and
 CONTEXT_INIT flags
Date: Thu, 18 Jul 2024 14:12:46 +0200
Message-ID: <20240718121247.181510-2-mhrica@redhat.com>
In-Reply-To: <20240718121247.181510-1-mhrica@redhat.com>
References: <20240718121247.181510-1-mhrica@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mhrica@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Forward VIRTIO_GPU_F_RESOURCE_BLOB and VIRTIO_GPU_F_CONTEXT_INIT recieved from
a vhost backend to expose it to the guest.

Signed-off-by: Matej Hrica <mhrica@redhat.com>
---
 hw/display/vhost-user-gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 63c64ddde6..0ebc2218b9 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -631,6 +631,12 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
         error_report("EDID requested but the backend doesn't support it.");
         g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLED);
     }
+    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_RESOURCE_BLOB)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_BLOB_ENABLED;
+    }
+    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_CONTEXT_INIT)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
+    }
 
     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
         return;
-- 
2.45.2


