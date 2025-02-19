Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A542C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkoMf-0000q2-FB; Wed, 19 Feb 2025 13:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkoMd-0000oh-Io
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkoMb-00024T-CS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739987999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jx9HPgOLHkZ3ex1SIoUcLBjqwl7UdkzMnLeunFoWftM=;
 b=d+048kytnJiZRT/W/aQ86A3UMoJLS6HAY58gE5tz/tIsc6LN1QNSeU2UctLs346McNZq+u
 i4govMmyM56KNDN2lkqA/ZqFBnvXYlpN123Jasbh8+RxYEbNi0ZeLKLft8Z1TQyRsDg6Bv
 1MTjJWv2nEiflLebz4BfPEXRRIf1Oqg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-QxdSvGHkPbipzymuEZytjA-1; Wed,
 19 Feb 2025 12:59:57 -0500
X-MC-Unique: QxdSvGHkPbipzymuEZytjA-1
X-Mimecast-MFC-AGG-ID: QxdSvGHkPbipzymuEZytjA_1739987996
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDA7C19783B2; Wed, 19 Feb 2025 17:59:55 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.254])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A7E71800947; Wed, 19 Feb 2025 17:59:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com
Subject: [RFC 1/2] hw/vfio: Introduce vfio_is_dma_map_allowed() callback
Date: Wed, 19 Feb 2025 18:58:59 +0100
Message-ID: <20250219175941.135390-2-eric.auger@redhat.com>
In-Reply-To: <20250219175941.135390-1-eric.auger@redhat.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

It may happen that a VFIO device state prevents its regions
from beeing DMA mapped. Specifically this happens with VFIO PCI
device in D3hot power state whose BARs cannot be dma mapped.
The behavior was introduced by kernel commit:

2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
in D3hot power state")

We introduce a new VFIODeviceOps callback to retrieve whether
DMA MAP is allowed. This callback will be called from the generic
code, in vfio_listener_region_add.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/vfio/vfio-common.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c60be5b15..92c58f14a0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -182,6 +182,17 @@ struct VFIODeviceOps {
      * Returns zero to indicate success and negative for error
      */
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
+
+    /**
+     * @is_dma_map_allowed
+     *
+     * Returns if the device regions can be dma mapped
+     * It may happen that the device state is not compatible
+     * with such operation
+     *
+     * @vdev: #VFIODevice whose power state needs to be tested
+     */
+    bool (*vfio_is_dma_map_allowed)(VFIODevice *vdev);
 };
 
 typedef struct VFIOGroup {
-- 
2.47.1


