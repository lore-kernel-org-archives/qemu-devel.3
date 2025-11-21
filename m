Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38115CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdEK-0003zZ-JG; Fri, 21 Nov 2025 21:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdEH-0003xk-Gp; Fri, 21 Nov 2025 21:20:01 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdDQ-0003rw-Qh; Fri, 21 Nov 2025 21:19:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E7A2C16C6DD;
 Fri, 21 Nov 2025 16:51:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4B610321954;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 05/76] vfio: only check region info cache for initial
 regions
Date: Fri, 21 Nov 2025 16:50:43 +0300
Message-ID: <20251121135201.1114964-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

It is semantically valid for a VFIO device to increase the number of
regions after initialization. In this case, we'd attempt to check for
cached region info past the size of the ->reginfo array. Check for the
region index and skip the cache in these cases.

This also works around some VGPU use cases which appear to be a bug,
where VFIO_DEVICE_QUERY_GFX_PLANE returns a region index beyond the
reported ->num_regions.

Fixes: 95cdb024 ("vfio: add region info cache")
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Link: https://lore.kernel.org/qemu-devel/20251014151227.2298892-3-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit ecbe424a63c9f860a901d6a4a75724b046abd796)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 0b459c0f7c..7ebf41c95e 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -205,10 +205,19 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
     int fd = -1;
     int ret;
 
-    /* check cache */
-    if (vbasedev->reginfo[index] != NULL) {
-        *info = vbasedev->reginfo[index];
-        return 0;
+    /*
+     * We only set up the region info cache for the initial number of regions.
+     *
+     * Since a VFIO device may later increase the number of regions then use
+     * such regions with an index past ->num_initial_regions, don't attempt to
+     * use the info cache in those cases.
+     */
+    if (index < vbasedev->num_initial_regions) {
+        /* check cache */
+        if (vbasedev->reginfo[index] != NULL) {
+            *info = vbasedev->reginfo[index];
+            return 0;
+        }
     }
 
     *info = g_malloc0(argsz);
@@ -236,10 +245,12 @@ retry:
         goto retry;
     }
 
-    /* fill cache */
-    vbasedev->reginfo[index] = *info;
-    if (vbasedev->region_fds != NULL) {
-        vbasedev->region_fds[index] = fd;
+    if (index < vbasedev->num_initial_regions) {
+        /* fill cache */
+        vbasedev->reginfo[index] = *info;
+        if (vbasedev->region_fds != NULL) {
+            vbasedev->region_fds[index] = fd;
+        }
     }
 
     return 0;
-- 
2.47.3


