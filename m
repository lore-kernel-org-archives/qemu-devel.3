Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C5BC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucMGT-0007Uh-F7; Thu, 17 Jul 2025 06:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGR-0007RM-8o; Thu, 17 Jul 2025 06:54:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGP-0003AB-Ef; Thu, 17 Jul 2025 06:54:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 27977137E21;
 Thu, 17 Jul 2025 13:54:35 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2220B24926B;
 Thu, 17 Jul 2025 13:54:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Vasant Hegde <vasant.hegde@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 21/26] amd_iommu: Fix masks for various IOMMU MMIO
 Registers
Date: Thu, 17 Jul 2025 13:54:35 +0300
Message-ID: <20250717105442.735202-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250717135416@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250717135416@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Address various issues with definitions of the MMIO registers e.g. for the
Device Table Address Register, the size mask currently encompasses reserved
bits [11:9], so change it to only extract the bits [8:0] encoding size.

Convert masks to use GENMASK64 for consistency, and make unrelated
definitions independent.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-5-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 108e10ff69099c3ebe147f505246be7c2ad2a499)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index ba9508fe5d..bc3a6eaa6d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -68,34 +68,34 @@
 
 #define AMDVI_MMIO_SIZE               0x4000
 
-#define AMDVI_MMIO_DEVTAB_SIZE_MASK   ((1ULL << 12) - 1)
-#define AMDVI_MMIO_DEVTAB_BASE_MASK   (((1ULL << 52) - 1) & ~ \
-                                       AMDVI_MMIO_DEVTAB_SIZE_MASK)
+#define AMDVI_MMIO_DEVTAB_SIZE_MASK     GENMASK64(8, 0)
+#define AMDVI_MMIO_DEVTAB_BASE_MASK     GENMASK64(51, 12)
+
 #define AMDVI_MMIO_DEVTAB_ENTRY_SIZE  32
 #define AMDVI_MMIO_DEVTAB_SIZE_UNIT   4096
 
 /* some of this are similar but just for readability */
 #define AMDVI_MMIO_CMDBUF_SIZE_BYTE       (AMDVI_MMIO_COMMAND_BASE + 7)
 #define AMDVI_MMIO_CMDBUF_SIZE_MASK       0x0f
-#define AMDVI_MMIO_CMDBUF_BASE_MASK       AMDVI_MMIO_DEVTAB_BASE_MASK
-#define AMDVI_MMIO_CMDBUF_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_CMDBUF_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_CMDBUF_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_CMDBUF_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_CMDBUF_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EVTLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_EVTLOG_SIZE_MASK       AMDVI_MMIO_CMDBUF_SIZE_MASK
-#define AMDVI_MMIO_EVTLOG_BASE_MASK       AMDVI_MMIO_CMDBUF_BASE_MASK
-#define AMDVI_MMIO_EVTLOG_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_EVTLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_EVTLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_EVTLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_EVTLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_EVTLOG_TAIL_MASK       GENMASK64(18, 4)
 
-#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_PPRLOG_HEAD_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_BASE_MASK       AMDVI_MMIO_EVTLOG_BASE_MASK
-#define AMDVI_MMIO_PPRLOG_SIZE_MASK       AMDVI_MMIO_EVTLOG_SIZE_MASK
+#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_PPR_BASE + 7)
+#define AMDVI_MMIO_PPRLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_PPRLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_PPRLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_PPRLOG_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EXCL_ENABLED_MASK      (1ULL << 0)
 #define AMDVI_MMIO_EXCL_ALLOW_MASK        (1ULL << 1)
-#define AMDVI_MMIO_EXCL_LIMIT_MASK        AMDVI_MMIO_DEVTAB_BASE_MASK
+#define AMDVI_MMIO_EXCL_LIMIT_MASK        GENMASK64(51, 12)
 #define AMDVI_MMIO_EXCL_LIMIT_LOW         0xfff
 
 /* mmio control register flags */
@@ -132,14 +132,14 @@
 #define AMDVI_DEV_TRANSLATION_VALID       (1ULL << 1)
 #define AMDVI_DEV_MODE_MASK               0x7
 #define AMDVI_DEV_MODE_RSHIFT             9
-#define AMDVI_DEV_PT_ROOT_MASK            0xffffffffff000
+#define AMDVI_DEV_PT_ROOT_MASK            GENMASK64(51, 12)
 #define AMDVI_DEV_PT_ROOT_RSHIFT          12
 #define AMDVI_DEV_PERM_SHIFT              61
 #define AMDVI_DEV_PERM_READ               (1ULL << 61)
 #define AMDVI_DEV_PERM_WRITE              (1ULL << 62)
 
 /* Device table entry bits 64:127 */
-#define AMDVI_DEV_DOMID_ID_MASK          ((1ULL << 16) - 1)
+#define AMDVI_DEV_DOMID_ID_MASK             GENMASK64(15, 0)
 
 /* Event codes and flags, as stored in the info field */
 #define AMDVI_EVENT_ILLEGAL_DEVTAB_ENTRY  (0x1U << 12)
@@ -195,7 +195,7 @@
 #define AMDVI_PAGE_SIZE  (1ULL << AMDVI_PAGE_SHIFT)
 
 #define AMDVI_PAGE_SHIFT_4K 12
-#define AMDVI_PAGE_MASK_4K  (~((1ULL << AMDVI_PAGE_SHIFT_4K) - 1))
+#define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
 #define AMDVI_MAX_GVA_ADDR      (2UL << 5)
 #define AMDVI_MAX_PH_ADDR       (40UL << 8)
-- 
2.47.2


