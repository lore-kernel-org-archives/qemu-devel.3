Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3B6CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 04:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGrUx-0006ku-2K; Wed, 05 Nov 2025 23:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUs-0006k0-HO
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:21:18 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUo-0000q1-6k
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762402874; x=1793938874;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A7i/AJqHEJyiDSM7PjscbOebyDU3VW9QraGVFc93DXs=;
 b=Kbl2zzeQEppP4WNA6tPcJ091AB9gI+Zhyd9a/nwMf85QhP/Xbd+awYKX
 uv5cwLeQD7o8CMHVlUKU9Pl+cjEpgbOd4pXXKvmMj1KNA4xPcm5/pzbzu
 RUqU2YT4ynaSboM/wR1mS1KyZoz6YOjG/h6p7vwi6+ZCnk/HWYEhNiD8n
 sM0fKwoRNtl8LGgKDZlAiDbL4aBZlwPcgt4MVIU5jXH9uZ0qLkhsYRuFh
 zPmopQGQOF+3E61ikW/YT74ZChltR4DB3qapvmYEj6fq95TiN77YpUw0k
 2m7X7VBX6F/x2LOUdqnpUhzAEZsqGWHu3wwDpzJT3qRcpGgIuuWUVI5aa g==;
X-CSE-ConnectionGUID: qcoxqqDuTz60fNj99H1EfQ==
X-CSE-MsgGUID: hZ/Q7SlKR4irvENKVIxELQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64412871"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="64412871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:21:13 -0800
X-CSE-ConnectionGUID: 0+Xa7k7pRNGrtwvF8I8a7A==
X-CSE-MsgGUID: XPhaYn1MQOqPbXd05qUJwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="186901300"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:21:10 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 8/9] vfio/migration: Add migration blocker if VM memory is
 too large to cause unmap_bitmap failure
Date: Wed,  5 Nov 2025 23:20:25 -0500
Message-ID: <20251106042027.856594-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106042027.856594-1-zhenzhong.duan@intel.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

With default config, kernel VFIO IOMMU type1 driver limits dirty bitmap to
256MB for unmap_bitmap ioctl so the maximum guest memory region is no more
than 8TB size for the ioctl to succeed.

Be conservative here to limit total guest memory to max value supported
by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD backend
doesn't have such limit, one can use it if there is a need to migrate such
large VM.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/migration.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4c06e3db93..86e5b7ab55 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -16,6 +16,7 @@
 #include <sys/ioctl.h>
 
 #include "system/runstate.h"
+#include "hw/boards.h"
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
2.47.1


