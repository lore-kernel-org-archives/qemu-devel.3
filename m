Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D13BC021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrL4-0006Wv-AX; Tue, 11 Feb 2025 09:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrL2-0006WY-Kj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrL0-0001vU-Mc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PmboF7nJ2QrLfLhXSnLwZkX9n6tQcij2HQMifxLhhnI=;
 b=AzhOeiEpjEwpBl5BcZZr0Uy8Sv6Exs92UfJEfqPw7jLxyci9CmhHH/ZdBl7PzMqj843nvg
 E3qQuC8gxkP3+1cFNeImAm0snCbAKkb6zgnPSDiWOVnR+GNU4vLCKar1QWRRqTJ4iq1KuS
 NZ01ulDydP/awaIRBgDxpKbsqzgAE9I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-YpGBoNJzMSikYDzJSMwq_g-1; Tue,
 11 Feb 2025 09:34:08 -0500
X-MC-Unique: YpGBoNJzMSikYDzJSMwq_g-1
X-Mimecast-MFC-AGG-ID: YpGBoNJzMSikYDzJSMwq_g_1739284448
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C106180087A
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:34:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5138180087F; Tue, 11 Feb 2025 14:34:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/12] vfio: Introduce vfio_get_vfio_device()
Date: Tue, 11 Feb 2025 15:33:37 +0100
Message-ID: <20250211143340.787996-10-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250206131438.1505542-5-clg@redhat.com
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


