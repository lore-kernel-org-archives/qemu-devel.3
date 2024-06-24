Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805ACC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCV-00040c-QR; Mon, 24 Jun 2024 17:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCU-0003xU-Pr
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCT-0006i3-62
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcBS4uUUsykGTPzNjN4nP/WY4vqExAExkoOnhQzWaA4=;
 b=PPhXqqtTSHU4ea5b+U6x+C1y91Du48Y1PEdhtquMKrBhE7rC0cjnOd8d+qyIltLY3/2YDd
 Zsfknr8Nx/40isLKpf/2/NnTVkeQliNmBn9YYwsGxDZS7lqztCg2bLJtsIlK8nJ/VoRIPj
 mS/LOtgeMCXs0cu4bUZS04DeSYnuVKA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-PfdFAzFWOGCqdcYzFWgozQ-1; Mon,
 24 Jun 2024 17:26:04 -0400
X-MC-Unique: PfdFAzFWOGCqdcYzFWgozQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7567A1956094; Mon, 24 Jun 2024 21:26:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8168D1956051; Mon, 24 Jun 2024 21:26:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 24/42] hw/vfio: Remove memory_region_iommu_set_iova_ranges()
 call
Date: Mon, 24 Jun 2024 23:24:38 +0200
Message-ID: <20240624212456.350919-25-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

As we have just removed the only implementation of
iommu_set_iova_ranges IOMMU MR callback in the virtio-iommu,
let's remove the call to the memory wrapper. Usable IOVA ranges
are now conveyed through the PCIIOMMUOps in VFIO-PCI.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/common.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f20a7b5bba6b44ea4b181eab12a7ddd5175e8366..9e4c0cc95ff90209d3e8184035af0806a2bf890b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -630,16 +630,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
-        if (bcontainer->iova_ranges) {
-            ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
-                                                      bcontainer->iova_ranges,
-                                                      &err);
-            if (ret) {
-                g_free(giommu);
-                goto fail;
-            }
-        }
-
         ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
                                                     &err);
         if (ret) {
-- 
2.45.2


