Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93430D5E364
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9iaI-0004Sv-2p; Sat, 09 Nov 2024 05:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iWW-0006M9-PF; Sat, 09 Nov 2024 05:16:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iWV-00086n-4G; Sat, 09 Nov 2024 05:16:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0690A1400;
 Sat,  9 Nov 2024 13:13:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5CBB0167EEB;
 Sat,  9 Nov 2024 13:14:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 27/49] vfio/migration: Report only stop-copy size in
 vfio_state_pending_exact()
Date: Sat,  9 Nov 2024 13:14:18 +0300
Message-Id: <20241109101443.312701-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Avihai Horon <avihaih@nvidia.com>

vfio_state_pending_exact() is used to update migration core how much
device data is left for the device migration. Currently, the sum of
pre-copy and stop-copy sizes of the VFIO device are reported.

The pre-copy size is obtained via the VFIO_MIG_GET_PRECOPY_INFO ioctl,
which returns the amount of device data available to be transferred
while the device is in the PRE_COPY states.

The stop-copy size is obtained via the VFIO_DEVICE_FEATURE_MIG_DATA_SIZE
ioctl, which returns the total amount of device data left to be
transferred in order to complete the device migration.

According to the above, current implementation is wrong -- it reports
extra overlapping data because pre-copy size is already contained in
stop-copy size. Fix it by reporting only stop-copy size.

Fixes: eda7362af959 ("vfio/migration: Add VFIO migration pre-copy support")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 3b5948f808e3b99aedfa0aff45cffbe8b7ec07ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 28d422b39f..28240c42ce 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -480,9 +480,6 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 
     if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
-
-        *must_precopy +=
-            migration->precopy_init_size + migration->precopy_dirty_size;
     }
 
     trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-- 
2.39.5


