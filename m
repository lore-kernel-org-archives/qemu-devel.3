Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1057C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjthY-0007S0-JC; Wed, 15 Jul 2026 03:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wjthU-0007RU-M2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 03:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wjthS-0005kY-Gv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 03:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784099192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m0/Q/YYevEPHvKzDPJRAOvl85iWJCAk5Q7iHC3eSAQk=;
 b=KhOAhwEdBReGmhj+sM4OuHu5MeE4objjEeX3StdYsQKrUNtTffFzTmwtTJRSFEiK7h1EdQ
 Q0tv5P31GUDdNLTcuZAvj1S9nc2flnf/4aNWAbm6QnK4/2T/pwwmQKDeQBdFDL39Qf4Jv0
 NsQEUC5/EYo3J82qOJ7ymp3zWKl47FI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-mECovYS_OwizZe0su7UWJA-1; Wed,
 15 Jul 2026 03:06:28 -0400
X-MC-Unique: mECovYS_OwizZe0su7UWJA-1
X-Mimecast-MFC-AGG-ID: mECovYS_OwizZe0su7UWJA_1784099187
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D94F4195608E; Wed, 15 Jul 2026 07:06:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.79])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36F47195419A; Wed, 15 Jul 2026 07:06:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH] vfio/region: Clarify dma-buf failure messages
Date: Wed, 15 Jul 2026 09:06:22 +0200
Message-ID: <20260715070622.198400-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The dma-buf failure messages in vfio_region_create_dma_buf() say "PCI
BAR IOMMU mappings may fail", which suggests the BAR is broken. In
practice, only P2P DMA is affected -- normal passthrough uses the mmap
fallback.

Reword both messages to mention P2P DMA explicitly and clarify that
the mmap fallback is in use. Use warn_report_err_once() at the call
site so per-BAR repetition on mdev devices is suppressed.

Fixes: dcf1b77e834d ("hw/vfio/region: Create dmabuf for PCI BAR per region")
Cc: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/region.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index dbde3391802691888ca31d5e329aba5ba680feb4..54ad11a6c8ed8e04fa365262ccb8bd694bdb45f7 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -321,13 +321,12 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
     ret = vfio_device_get_feature(vbasedev, feature);
     if (ret < 0) {
         if (ret == -ENOTTY) {
-            warn_report_once("VFIO dma-buf not supported in kernel: "
-                             "PCI BAR IOMMU mappings may fail");
+            warn_report_once("VFIO dma-buf not supported in kernel, "
+                             "using mmap fallback, P2P DMA will not work");
             return true;
         }
-        /* P2P DMA or exposing device memory use cases are not supported. */
-        error_setg_errno(errp, -ret, "%s: failed to create dma-buf: "
-                         "PCI BAR IOMMU mappings may fail",
+        error_setg_errno(errp, -ret, "%s: dma-buf unavailable, "
+                         "using mmap fallback, P2P DMA will not work",
                          memory_region_name(region->mem));
         return false;
     }
@@ -448,7 +447,7 @@ int vfio_region_mmap(VFIORegion *region)
     }
 
     if (!vfio_region_create_dma_buf(region, &local_err)) {
-        error_report_err(local_err);
+        warn_report_err_once(local_err);
     }
 
     return 0;
-- 
2.55.0


