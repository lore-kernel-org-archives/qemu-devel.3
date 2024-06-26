Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7026BC30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 08:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMO0t-0007cT-Do; Wed, 26 Jun 2024 04:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0o-0007Rg-W0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0n-0007Dd-Bo
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719390496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+DGD3fPGv2kOWXJer3oVP7HLhSLO1OZboYmYmKyNY0=;
 b=AiQsN3ztP4+1XaWFDY/P0c5MXkP2dEd4vXyfPJA6C+5PijIWkbjTRmF6jIfgK7KhMQZVsW
 9V43UgUX953HwqAhqkAd1hVqNsuHCcaYvZmiLqs0aPoKaUHJoa38YeE0SbdkgGqcC26tvp
 +AXdsEq7bBcfsjU2hW7n4mDzzCYspLk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-I5ffquUuNPG9d9BrVpB2_g-1; Wed,
 26 Jun 2024 04:28:14 -0400
X-MC-Unique: I5ffquUuNPG9d9BrVpB2_g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27E7A19560AF; Wed, 26 Jun 2024 08:28:12 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CFC21956087; Wed, 26 Jun 2024 08:28:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH 7/7] virtio-iommu: Revert transient enablement of IOMMU MR in
 bypass mode
Date: Wed, 26 Jun 2024 10:26:52 +0200
Message-ID: <20240626082727.1278530-8-eric.auger@redhat.com>
In-Reply-To: <20240626082727.1278530-1-eric.auger@redhat.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

In 94df5b2180d6 ("virtio-iommu: Fix 64kB host page size VFIO device
assignment"), in case of bypass mode, we transiently enabled the
IOMMU MR to allow the set_page_size_mask() to be called and pass
information about the page size mask constraint of cold plugged
VFIO devices. Now we do not use the IOMMU MR callback anymore, we
can just get rid of this hack.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index b24e10de81..f87359b3e7 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1385,18 +1385,6 @@ static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
     VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
     int granule;
 
-    if (likely(s->config.bypass)) {
-        /*
-         * Transient IOMMU MR enable to collect page_size_mask requirements
-         * through memory_region_iommu_set_page_size_mask() called by
-         * VFIO region_add() callback
-         */
-         s->config.bypass = false;
-         virtio_iommu_switch_address_space_all(s);
-         /* restore default */
-         s->config.bypass = true;
-         virtio_iommu_switch_address_space_all(s);
-    }
     s->granule_frozen = true;
     granule = ctz64(s->config.page_size_mask);
     trace_virtio_iommu_freeze_granule(BIT_ULL(granule));
-- 
2.41.0


