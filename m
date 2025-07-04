Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E53C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc4R-0000b1-Fj; Fri, 04 Jul 2025 04:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc4F-0000QX-OS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc4D-0001OF-QP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/QQHxzSBwOZry8dpMse9+bQu7EIO9GAsfRgmGz5QH8=;
 b=QskD0r/MbpGNa3/CAmVOH8Q8u1GNA+8xHuLdzEcCirBhYsRTGaaj7K0R+yg6UXKlwHvPwL
 OJEPNEURrtr+Tlr0VaX28GB8HpM2ls0OEVCekI66bo+CqTgTzt2baq2BkJ+gz1FZfpKkPh
 jOLttlTdFGZPpvMKRK3i/meuT//w+9s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-m3YTmIjENKOznhQTtCof_A-1; Fri,
 04 Jul 2025 04:46:40 -0400
X-MC-Unique: m3YTmIjENKOznhQTtCof_A-1
X-Mimecast-MFC-AGG-ID: m3YTmIjENKOznhQTtCof_A_1751618799
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CC141944AA6; Fri,  4 Jul 2025 08:46:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98F5219560A7; Fri,  4 Jul 2025 08:46:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/27] vfio/iommufd: change process
Date: Fri,  4 Jul 2025 10:45:25 +0200
Message-ID: <20250704084528.1412959-25-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Finish CPR by change the owning process of the iommufd device in
post load.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-19-git-send-email-steven.sistare@oracle.com
[ clg: Fixed missing "qemu/error-report.h" include ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr-iommufd.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index a72b68daa8e4da19b9cbf3ab50631211965cdf37..148a06d552ff3d8e8420366c6b71437e81a1f877 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -5,6 +5,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
@@ -112,10 +113,40 @@ static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
     return true;
 }
 
+static int iommufd_cpr_pre_save(void *opaque)
+{
+    IOMMUFDBackend *be = opaque;
+
+    /*
+     * The process has not changed yet, but proactively try the ioctl,
+     * and it will fail if any DMA mappings are not supported.
+     */
+    if (!iommufd_change_process_capable(be)) {
+        error_report("some memory regions do not support "
+                     "IOMMU_IOAS_CHANGE_PROCESS");
+        return -1;
+    }
+    return 0;
+}
+
+static int iommufd_cpr_post_load(void *opaque, int version_id)
+{
+     IOMMUFDBackend *be = opaque;
+     Error *local_err = NULL;
+
+     if (!iommufd_change_process(be, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+     }
+     return 0;
+}
+
 static const VMStateDescription iommufd_cpr_vmstate = {
     .name = "iommufd",
     .version_id = 0,
     .minimum_version_id = 0,
+    .pre_save = iommufd_cpr_pre_save,
+    .post_load = iommufd_cpr_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
-- 
2.50.0


