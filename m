Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3170AC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejh-0004VP-Pg; Fri, 25 Apr 2025 04:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjU-0003ha-8J
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjR-0003IE-S5
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQ6Iko316aU9dgLUgWTvTp05t9T/xV/1GFOCXAOahLw=;
 b=eOI7tYA76vIbOUXVUcEKOXHo7EdhEAzZcuAbtkq9/9PSanzZawFt+hOv9yueHLUPhE+arQ
 l4S7WXuBBsLV7X6eGahoV2wJnGCxjow+sJNFwDMcRV+ezCy5usTQashUUXKMDvgSREkz3P
 kGh3K28orj+PMFIC/x5Rth7ku+gV5Pk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-Y3gwWnsEPjyZr-ZhRMhOPA-1; Fri,
 25 Apr 2025 04:48:22 -0400
X-MC-Unique: Y3gwWnsEPjyZr-ZhRMhOPA-1
X-Mimecast-MFC-AGG-ID: Y3gwWnsEPjyZr-ZhRMhOPA_1745570901
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3866219560A2; Fri, 25 Apr 2025 08:48:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3450E30001A2; Fri, 25 Apr 2025 08:48:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 27/50] vfio: Move vfio_device_list into device.c
Date: Fri, 25 Apr 2025 10:46:20 +0200
Message-ID: <20250425084644.102196-28-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

'vfio_device_list' is VFIODevice related. Move its definitions into
"device.c".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-23-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-24-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 3 ---
 hw/vfio/device.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 84a9a37d9d26cf24b7ea9e07ac040c0dc283a5ba..4e7d8e83ac72050f874e56143a9a4bc4527b0bda 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -46,9 +46,6 @@
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
 
-VFIODeviceList vfio_device_list =
-    QLIST_HEAD_INITIALIZER(vfio_device_list);
-
 /*
  * Device state interfaces
  */
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 21c6824430c49170b8d1b9a69ff51272f48096a4..25fdba10a882e35392f26a107509f80e4b1c880a 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -31,6 +31,9 @@
 #include "monitor/monitor.h"
 #include "vfio-helpers.h"
 
+VFIODeviceList vfio_device_list =
+    QLIST_HEAD_INITIALIZER(vfio_device_list);
+
 /*
  * Common VFIO interrupt disable
  */
-- 
2.49.0


