Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD57C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrRg-0001mc-I3; Wed, 06 Mar 2024 08:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRW-0001Nt-Jj
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:26 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRV-0006Dt-4g
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:22 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYNz0m8Dz4x0q;
 Thu,  7 Mar 2024 00:36:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYNv6WFfz4wbh;
 Thu,  7 Mar 2024 00:36:15 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 21/25] vfio: Reverse test on vfio_get_dirty_bitmap()
Date: Wed,  6 Mar 2024 14:34:36 +0100
Message-ID: <20240306133441.2351700-22-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
index 5b2e6a179cdd5f8ca5be84b7097661e96b391456..6820d2efe4923d5043da7eb8deecb6ff20e1fd16 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1241,16 +1241,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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


