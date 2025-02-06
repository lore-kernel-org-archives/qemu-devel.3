Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB1AC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1it-0007Ic-AT; Thu, 06 Feb 2025 08:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1ia-000779-JP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:14:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1iZ-0000CO-3n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738847694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3oJ/f2lYBy+mVYg+gP8Eo/xbAj6TYb489HgxZY98qM=;
 b=ZLAuJemnw1kjDkwSq6tLYQyYOhhIlx8cjTauuo0MngQqr9/ZDE6BjDgIoyBHQos+ZL8jAL
 UvZMV3XxSmNJ5vgyvYr3Vgn4cV0DQgaHzZQz0H5S1kHQvXaPYtlYs5KZBp8APRUNAtrYo6
 e3VY2/xg2/f9xoIA5xTRaBAxDfGiano=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-hCWgVRCWN1mtYXBRUltoRw-1; Thu,
 06 Feb 2025 08:14:52 -0500
X-MC-Unique: hCWgVRCWN1mtYXBRUltoRw-1
X-Mimecast-MFC-AGG-ID: hCWgVRCWN1mtYXBRUltoRw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89F891800876
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2025 13:14:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C58F30001AB; Thu,  6 Feb 2025 13:14:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 4/7] vfio: Introduce vfio_get_vfio_device()
Date: Thu,  6 Feb 2025 14:14:32 +0100
Message-ID: <20250206131438.1505542-5-clg@redhat.com>
In-Reply-To: <20250206131438.1505542-1-clg@redhat.com>
References: <20250206131438.1505542-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This helper will be useful in the listener handlers to extract the
VFIO device from a memory region using memory_region_owner(). At the
moment, we only care for PCI passthrough devices. If the need arises,
we will add more.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/helpers.c             | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c60be5b15c70168f4f94ad7054d9bd750a162d3..ac35136a11051b079cd9d04e6becd344a0e0f7e7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -252,6 +252,7 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
+VFIODevice *vfio_get_vfio_device(Object *obj);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 913796f437f84eece8711cb4b4b654a44040d17c..4b255d4f3a9e81f55df00c68fc71da769fd5bd04 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/pci.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -728,3 +729,12 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
 
     return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
 }
+
+VFIODevice *vfio_get_vfio_device(Object *obj)
+{
+    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
+        return &VFIO_PCI(obj)->vbasedev;
+    } else {
+        return NULL;
+    }
+}
-- 
2.48.1


