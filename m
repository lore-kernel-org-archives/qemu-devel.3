Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437C1C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKzH-0002Ge-9A; Sat, 15 Mar 2025 02:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKv2-00034g-K4; Sat, 15 Mar 2025 02:22:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKus-0003pM-E1; Sat, 15 Mar 2025 02:22:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24CFAFF9F9;
 Sat, 15 Mar 2025 09:17:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EFB601CAC62;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9755455909; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 45/51] ppc/pnv/occ: Fix common area sensor offsets
Date: Sat, 15 Mar 2025 09:17:51 +0300
Message-Id: <20250315061801.622606-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Nicholas Piggin <npiggin@gmail.com>

The commit to fix the OCC common area sensor mappings didn't update the
register offsets to match.

Before this change, skiboot reports:

[    0.347100086,3] OCC: Chip 0 sensor data invalid

Afterward, there is no error and the sensor_groups directory appears
under /sys/firmware/opal/.

The SLW_IMAGE_BASE address looks like a workaround to intercept firmware
memory accesses, but that does not seem to be required now (and would
have been broken by the OCC common area region mapping change anyway).
So it can be removed.

Fixes: 3a1b70b66b5cb4 ("ppc/pnv: Fix OCC common area region mapping")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 29c041ca7f8d6910c894788482efff892789dcd2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 48123ceae1..c6681a035a 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -32,22 +32,21 @@
 #define OCB_OCI_OCCMISC_OR      0x4022
 
 /* OCC sensors */
-#define OCC_SENSOR_DATA_BLOCK_OFFSET          0x580000
-#define OCC_SENSOR_DATA_VALID                 0x580001
-#define OCC_SENSOR_DATA_VERSION               0x580002
-#define OCC_SENSOR_DATA_READING_VERSION       0x580004
-#define OCC_SENSOR_DATA_NR_SENSORS            0x580008
-#define OCC_SENSOR_DATA_NAMES_OFFSET          0x580010
-#define OCC_SENSOR_DATA_READING_PING_OFFSET   0x580014
-#define OCC_SENSOR_DATA_READING_PONG_OFFSET   0x58000c
-#define OCC_SENSOR_DATA_NAME_LENGTH           0x58000d
-#define OCC_SENSOR_NAME_STRUCTURE_TYPE        0x580023
-#define OCC_SENSOR_LOC_CORE                   0x580022
-#define OCC_SENSOR_LOC_GPU                    0x580020
-#define OCC_SENSOR_TYPE_POWER                 0x580003
-#define OCC_SENSOR_NAME                       0x580005
-#define HWMON_SENSORS_MASK                    0x58001e
-#define SLW_IMAGE_BASE                        0x0
+#define OCC_SENSOR_DATA_BLOCK_OFFSET          0x0000
+#define OCC_SENSOR_DATA_VALID                 0x0001
+#define OCC_SENSOR_DATA_VERSION               0x0002
+#define OCC_SENSOR_DATA_READING_VERSION       0x0004
+#define OCC_SENSOR_DATA_NR_SENSORS            0x0008
+#define OCC_SENSOR_DATA_NAMES_OFFSET          0x0010
+#define OCC_SENSOR_DATA_READING_PING_OFFSET   0x0014
+#define OCC_SENSOR_DATA_READING_PONG_OFFSET   0x000c
+#define OCC_SENSOR_DATA_NAME_LENGTH           0x000d
+#define OCC_SENSOR_NAME_STRUCTURE_TYPE        0x0023
+#define OCC_SENSOR_LOC_CORE                   0x0022
+#define OCC_SENSOR_LOC_GPU                    0x0020
+#define OCC_SENSOR_TYPE_POWER                 0x0003
+#define OCC_SENSOR_NAME                       0x0005
+#define HWMON_SENSORS_MASK                    0x001e
 
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
@@ -129,8 +128,6 @@ static uint64_t pnv_occ_common_area_read(void *opaque, hwaddr addr,
     case HWMON_SENSORS_MASK:
     case OCC_SENSOR_LOC_GPU:
         return 0x8e00;
-    case SLW_IMAGE_BASE:
-        return 0x1000000000000000;
     }
     return 0;
 }
-- 
2.39.5


