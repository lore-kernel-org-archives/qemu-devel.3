Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B5C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6u8G-0001Mp-6n; Tue, 14 May 2024 11:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6u8A-0001J9-SY
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6u87-0000YO-Bc
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715700708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBscjC0rcNJY8obaoxNAUQuYtuw+I02aGW012sVdNHs=;
 b=SCIBLM4RcDfIIZ+ITUme39uCmWwhYMrAN64aYWvf9LGAirop4Ic38NLPdTY3x57crpR+mV
 kTR9Zgg7hqg6DJ0GwQV/XqecXb8POMtUo7q23ptscFT8FK50heSAUcUkJnbHWFmyQbguhN
 K07HdQS+XeGvhCf5XbvE4DjQKtrrPV4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-Nf8RPR8sN0-enaFjxrbJJA-1; Tue,
 14 May 2024 11:31:47 -0400
X-MC-Unique: Nf8RPR8sN0-enaFjxrbJJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B17B1C3F0E4;
 Tue, 14 May 2024 15:31:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79D6C200BAB1;
 Tue, 14 May 2024 15:31:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 6/9] vfio: Reverse test on vfio_get_xlat_addr()
Date: Tue, 14 May 2024 17:31:27 +0200
Message-ID: <20240514153130.394307-7-clg@redhat.com>
In-Reply-To: <20240514153130.394307-1-clg@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It will simplify the changes coming after.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v6:

 - Modified title  (Avihai)
 - vfio_iommu_map_dirty_notify() : Modified goto label  (Avihai)
 
 hw/vfio/common.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c..4e2ef3d3034e72aa6a546bcb9ea1f31a0bbd5b1b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1224,16 +1224,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
+        goto out_unlock;
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
+out_unlock:
     rcu_read_unlock();
 
 out:
-- 
2.45.0


