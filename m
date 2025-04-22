Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9208CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GD7-00028q-AA; Tue, 22 Apr 2025 12:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5Y-00074a-7o
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5U-00051P-Ak
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSKfQQKDdAY9CCgAZ1YXoNG2YTwFpnhc+ONamcKPMDw=;
 b=cPgTF8qrPDmEJtHC0MsOFs3j/UBGtuYxy3hcyYxDDO9Qf6dLKwNKDGpmg0SN47ruRSOS0j
 pmJiCTffK/+WGjjJaBvOKoqSksAJb8ia3NGP8NTOBboIe3XMqFQ1ij2rHbjlx7bqQ1GPpj
 EHjtimNQg7hnq9KucB4+MKFyqY2GgTI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-fh0nK0y0P4mwh0ZHBC_qtQ-1; Tue,
 22 Apr 2025 12:03:04 -0400
X-MC-Unique: fh0nK0y0P4mwh0ZHBC_qtQ-1
X-Mimecast-MFC-AGG-ID: fh0nK0y0P4mwh0ZHBC_qtQ_1745337783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50C461801A24; Tue, 22 Apr 2025 16:03:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A14918001DA; Tue, 22 Apr 2025 16:03:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 09/37] vfio: Move VFIOHostDMAWindow definition into spapr.c
Date: Tue, 22 Apr 2025 18:01:56 +0200
Message-ID: <20250422160224.199714-10-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

VFIOHostDMAWindow is only used in file "spapr.c". Move it there.

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-9-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-10-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 7 -------
 hw/vfio/spapr.c               | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 288c2fb3d0e792427c0e7655002248829b4d189a..3355c2d4e57569d7bb01b4d9378fb49a807335e8 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -69,13 +69,6 @@ typedef struct VFIOContainer {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
 
-typedef struct VFIOHostDMAWindow {
-    hwaddr min_iova;
-    hwaddr max_iova;
-    uint64_t iova_pgsizes;
-    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
-} VFIOHostDMAWindow;
-
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
 typedef struct VFIOIOASHwpt {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 32611096fa29aa5c4679ee589edbe4b53395e582..3ca8ecd81ff3cc8e0f6c458dc292973b2356132e 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -22,6 +22,13 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+typedef struct VFIOHostDMAWindow {
+    hwaddr min_iova;
+    hwaddr max_iova;
+    uint64_t iova_pgsizes;
+    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
+} VFIOHostDMAWindow;
+
 typedef struct VFIOSpaprContainer {
     VFIOContainer container;
     MemoryListener prereg_listener;
-- 
2.49.0


