Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F877C30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrBh-0002jb-3d; Mon, 24 Jun 2024 17:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBf-0002iy-VS
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBe-0006Xj-DG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X49j9nYXgpvwtURhHXwb4lIr08VujYEHl00AiLmOxAg=;
 b=hbJbeOLJUm8aVF6vsMnm6mkF9Z7fvuVBi3xl9hlkyIDoChr3YFwTRoTx7bHsPheXTPax93
 1ZD0k4bjoeIjtAeAclpg6mVG7FKm6vyFf4VNW6hknmqttfKA9hk8VY9WfeC9wZJDs6Vr18
 izP3BX2Cq+KwRjrp3STxzCiVgQPu5Qc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-bAQxU0cVMOCKGzmGJ9bnJw-1; Mon,
 24 Jun 2024 17:25:11 -0400
X-MC-Unique: bAQxU0cVMOCKGzmGJ9bnJw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C23B195609E; Mon, 24 Jun 2024 21:25:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68A281956058; Mon, 24 Jun 2024 21:25:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 03/42] vfio/container: Introduce
 TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
Date: Mon, 24 Jun 2024 23:24:17 +0200
Message-ID: <20240624212456.350919-4-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO represents a host IOMMU device under
VFIO legacy container backend.

It will have its own realize implementation.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/vfio/vfio-common.h | 3 +++
 hw/vfio/container.c           | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4cb1ab8645dcdf604f3c2bb29328668fd5eb7284..75b167979ac221e59b2681b2704c03778823fbb0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "sysemu/host_iommu_device.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -171,6 +172,8 @@ typedef struct VFIOGroup {
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
+#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+
 typedef struct VFIODMABuf {
     QemuDmaBuf *buf;
     uint32_t pos_x, pos_y, pos_updates;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 096cc972586df14a4a68074b7038a9661b1558e2..c4fca2dfcab32781fb301181a1ef67238015a76f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1141,7 +1141,10 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_legacy_class_init,
-    },
+    }, {
+        .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
+        .parent = TYPE_HOST_IOMMU_DEVICE,
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.45.2


