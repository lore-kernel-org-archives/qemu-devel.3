Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C669C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7WL-0005Oj-Rf; Mon, 04 Mar 2024 07:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7TJ-0001bV-DB
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:31:13 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7Sw-0005Ck-B5
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:31:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ1h2ypcz4x0q;
 Mon,  4 Mar 2024 23:30:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ1d3BsYz4x1s;
 Mon,  4 Mar 2024 23:30:13 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 22/26] vfio: Reverse test on vfio_get_dirty_bitmap()
Date: Mon,  4 Mar 2024 13:28:40 +0100
Message-ID: <20240304122844.1888308-23-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It will simplify the changes coming after.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8fa232538d482f094643e0f1601b8ebe25fe077f..3c01b4c78ac73665d3c9f2322291a19ef8f71e76 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1239,16 +1239,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
-        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
-                                    translated_addr);
-        if (ret) {
-            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
-                         "0x%"HWADDR_PRIx") = %d (%s)",
-                         bcontainer, iova, iotlb->addr_mask + 1, ret,
-                         strerror(-ret));
-        }
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
+        goto out_lock;
     }
+
+    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
+                                translated_addr);
+    if (ret) {
+        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
+                     "0x%"HWADDR_PRIx") = %d (%s)",
+                     bcontainer, iova, iotlb->addr_mask + 1, ret,
+                     strerror(-ret));
+    }
+
+out_lock:
     rcu_read_unlock();
 
 out:
-- 
2.44.0


