Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47ED29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfar3-0003AE-Cm; Tue, 13 Jan 2026 04:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqr-0002xD-6Y
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqp-0003T6-MO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4h/CV9zsXjBGgjswpDw6usjHBVIQlnAhYiqTOwI6vPA=;
 b=SISdBCsrOiTOzIPEjaqHLTXZlsE57DrIHhcRkCiWyFfj9nL4w3DHkmwLcQvp8GcJRtHPBH
 Yw44ZBZ+S3Oh5ffeQbW/1PJAYfMK9lx//sGQI+Zf3e85FMT3SO68r2ODDCadBwgJYxuCb1
 3vcUOpamsF1gJYXjGIY5GJbB/nSfOsc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-JA5Ti87pNR6qai04Pqm-Ng-1; Tue,
 13 Jan 2026 04:38:07 -0500
X-MC-Unique: JA5Ti87pNR6qai04Pqm-Ng-1
X-Mimecast-MFC-AGG-ID: JA5Ti87pNR6qai04Pqm-Ng_1768297086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB0D81954231; Tue, 13 Jan 2026 09:38:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFCF03000218; Tue, 13 Jan 2026 09:38:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/41] vfio/migration: Add migration blocker if VM memory is
 too large to cause unmap_bitmap failure
Date: Tue, 13 Jan 2026 10:36:25 +0100
Message-ID: <20260113093637.1549214-30-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

With default config, kernel VFIO IOMMU type1 driver limits dirty bitmap to
256MB for unmap_bitmap ioctl so the maximum guest memory region is no more
than 8TB size for the ioctl to succeed.

Be conservative here to limit total guest memory to max value supported
by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD backend
doesn't have such limit, one can use it if there is a need to migrate such
large VM.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-9-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 58a4940b00eb0a070a5a48dc773fe56c42f377cd..e1c25ba90703e9574fdd69275ae2705684396697 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -16,6 +16,7 @@
 #include <sys/ioctl.h>
 
 #include "system/runstate.h"
+#include "hw/core/boards.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
@@ -1152,6 +1153,32 @@ static bool vfio_viommu_preset(VFIODevice *vbasedev)
     return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
+static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
+{
+    VFIOContainer *bcontainer = vbasedev->bcontainer;
+    uint64_t max_size, page_size;
+
+    if (!bcontainer->dirty_pages_supported) {
+        return false;
+    }
+
+    /*
+     * VFIO IOMMU type1 driver has limitation of bitmap size on unmap_bitmap
+     * ioctl(), calculate the limit and compare with guest memory size to
+     * catch dirty tracking failure early.
+     *
+     * This limit is 8TB with default kernel and QEMU config, we are a bit
+     * conservative here as VM memory layout may be nonconsecutive or VM
+     * can run with vIOMMU enabled so the limitation could be relaxed. One
+     * can also switch to use IOMMUFD backend if there is a need to migrate
+     * large VM.
+     */
+    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
+    max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
+
+    return current_machine->ram_size > max_size;
+}
+
 /*
  * Return true when either migration initialized or blocker registered.
  * Currently only return false when adding blocker fails which will
@@ -1193,6 +1220,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
             goto add_blocker;
         }
 
+        if (vfio_dirty_tracking_exceed_limit(vbasedev)) {
+            error_setg(&err, "%s: Migration is currently not supported with "
+                       "large memory VM due to dirty tracking limitation in "
+                       "backend", vbasedev->name);
+            goto add_blocker;
+        }
+
         warn_report("%s: VFIO device doesn't support device and "
                     "IOMMU dirty tracking", vbasedev->name);
     }
-- 
2.52.0


