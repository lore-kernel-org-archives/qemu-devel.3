Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EB6C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1j1-0007lZ-Qz; Thu, 06 Feb 2025 08:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1ie-00079S-FG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:15:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1ic-0000Cl-04
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738847697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bih9v7IJmxwW5LaE7GF7MhFGajhMVzFsoEFwX/6t2c=;
 b=O5mxFPbB2qXC4C3odQfiTSJc7fs2M6EcLVifpK8KywdmaaNePYjT0CuMm29infxFPci0TN
 xvw20sQGQdrZBP5Z4Ct/1vXeMbtHECN3hroJUlIvTUzKKc1tvPumqtoeXUFbfN7RosOSOJ
 oNqirQ+ZSIsHU8xt/u/wGVnu1uKcHz8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-tOZ4U0IcN1GEqSVlzMEgoA-1; Thu,
 06 Feb 2025 08:14:56 -0500
X-MC-Unique: tOZ4U0IcN1GEqSVlzMEgoA-1
X-Mimecast-MFC-AGG-ID: tOZ4U0IcN1GEqSVlzMEgoA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D16C180087B
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2025 13:14:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD3730001AB; Thu,  6 Feb 2025 13:14:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 6/7] vfio: Remove reports of DMA mapping errors in backends
Date: Thu,  6 Feb 2025 14:14:34 +0100
Message-ID: <20250206131438.1505542-7-clg@redhat.com>
In-Reply-To: <20250206131438.1505542-1-clg@redhat.com>
References: <20250206131438.1505542-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Currently, the mapping handlers of the IOMMU backends, VFIO IOMMU Type
1 aka. legacy and IOMMUFD, return an errno and also report an error.
This can lead to excessive log messages at runtime for recurring DMA
mapping errors. Since these errors are already reported by the callers
in the vfio_container_dma_un/map() routines, simply remove them and
allow the callers to handle the reporting.

The mapping handler of the IOMMUFD backend has a comment suggesting
MMIO region mapping failures return EFAULT. I am not sure this is
entirely true, so keep the EFAULT case until the conditions are
clarified.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 backends/iommufd.c  | 3 ---
 hw/vfio/container.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 7b4fc8ec460ef635b9ed5ac7b201f124476b512a..d57da44755be3d7fdba74f7dbecfe6d1c89921ba 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -167,8 +167,6 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
         /* TODO: Not support mapping hardware PCI BAR region for now. */
         if (errno == EFAULT) {
             warn_report("IOMMU_IOAS_MAP failed: %m, PCI BAR?");
-        } else {
-            error_report("IOMMU_IOAS_MAP failed: %m");
         }
     }
     return ret;
@@ -203,7 +201,6 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
 
     if (ret) {
         ret = -errno;
-        error_report("IOMMU_IOAS_UNMAP failed: %m");
     }
     return ret;
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4ebb5268088d0a2006e0ed04afec0ee746ed2c1d..7c57bdd27b72731db5cf4f9446d954e143b4747e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -159,7 +159,6 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
             unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
             continue;
         }
-        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
         return -errno;
     }
 
@@ -204,7 +203,6 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
         return 0;
     }
 
-    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
     return -errno;
 }
 
-- 
2.48.1


