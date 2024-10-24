Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42197D0BB45
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 05:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3qSI-0003Zr-Vt; Thu, 24 Oct 2024 01:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSG-0003Z9-3K
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSE-0004Hx-Ni
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729747933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OELuxVMXMm/yzqHOReJ+hqsGVfprXJOXomn0uDIZuzo=;
 b=Sez+yvz6h/dybYWPHT3uxEeWZmQk7aFwGaFnYqFLm+3ZWTDzJrA4y56lj0+YPL76iAwI4i
 /UB3Gobjw6oAtU7FvKNpNFXMWl6ea64psMvh2IucL71B0zFptFrEzG6PleQM2sGuj59UI5
 uRRviS+fJaD1WIv9nIrh1Y+VRmD6AxU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-rbnvjraOMmGRlzTnP49lcA-1; Thu,
 24 Oct 2024 01:32:10 -0400
X-MC-Unique: rbnvjraOMmGRlzTnP49lcA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAF3C19560A2; Thu, 24 Oct 2024 05:32:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 673721956056; Thu, 24 Oct 2024 05:32:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/4] vfio/migration: Report only stop-copy size in
 vfio_state_pending_exact()
Date: Thu, 24 Oct 2024 07:32:00 +0200
Message-ID: <20241024053203.1559456-2-clg@redhat.com>
In-Reply-To: <20241024053203.1559456-1-clg@redhat.com>
References: <20241024053203.1559456-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

vfio_state_pending_exact() is used to update migration core how much
device data is left for the device migration. Currently, the sum of
pre-copy and stop-copy sizes of the VFIO device are reported.

The pre-copy size is obtained via the VFIO_MIG_GET_PRECOPY_INFO ioctl,
which returns the amount of device data available to be transferred
while the device is in the PRE_COPY states.

The stop-copy size is obtained via the VFIO_DEVICE_FEATURE_MIG_DATA_SIZE
ioctl, which returns the total amount of device data left to be
transferred in order to complete the device migration.

According to the above, current implementation is wrong -- it reports
extra overlapping data because pre-copy size is already contained in
stop-copy size. Fix it by reporting only stop-copy size.

Fixes: eda7362af959 ("vfio/migration: Add VFIO migration pre-copy support")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 17199b73aeea02545338b41b180edade2ec2ddcc..992dc3b1025729877d9fbe6ce9a4dbaf4dbd8a07 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -576,9 +576,6 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 
     if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
-
-        *must_precopy +=
-            migration->precopy_init_size + migration->precopy_dirty_size;
     }
 
     trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-- 
2.47.0


