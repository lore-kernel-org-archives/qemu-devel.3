Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B618C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3M-0007fB-Dx; Fri, 04 Jul 2025 04:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3H-0007eO-Da
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3E-0008Lj-JP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sHbHQj6VRcttbej+ZZ4LEoCSLkr2QRA4FGJU96qKoVM=;
 b=HqPjCFh10uY5be/RxjBlwk8JI8WTYV+7+WaAO5VL3xzAov5hKBBg831BJO466Y0awaUlIq
 BN6K4f8gKlTTKSc0XreOZbhxVnyduTyw+Afoj14Oo9Rjkhxs8QOUSEE2pCxM3hPNMNzuT8
 kgEeqg80gRv2pyL7aGy0FQWH9d8PwGc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-mJxEhRAkMzSoFOuPjCh-BA-1; Fri,
 04 Jul 2025 04:45:41 -0400
X-MC-Unique: mJxEhRAkMzSoFOuPjCh-BA-1
X-Mimecast-MFC-AGG-ID: mJxEhRAkMzSoFOuPjCh-BA_1751618740
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DF611944A8D; Fri,  4 Jul 2025 08:45:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAC0719560A7; Fri,  4 Jul 2025 08:45:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/27] vfio-user: do not register vfio-user container with cpr
Date: Fri,  4 Jul 2025 10:45:04 +0200
Message-ID: <20250704084528.1412959-4-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

As the full cpr implementation is yet to be merged upstream, do not register
the vfio-user container with cpr. Full vfio-user support for cpr can be
merged later as a follow-up series.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250702120043.267634-1-mark.caveayland@nutanix.com>
[ clg: Removed now useless "hw/vfio/vfio-cpr.h" include ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 3133fef17738e14fc512ad5272bc349d928c980a..d318e6a3395e8d48e3a6da69ed4bef454e70ba82 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -13,7 +13,6 @@
 #include "hw/vfio-user/container.h"
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
-#include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
 #include "qapi/error.h"
@@ -225,14 +224,10 @@ vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
 
     bcontainer = &container->bcontainer;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
-        goto free_container_exit;
-    }
-
     ret = ram_block_uncoordinated_discard_disable(true);
     if (ret) {
         error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
-        goto unregister_container_exit;
+        goto free_container_exit;
     }
 
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -261,9 +256,6 @@ listener_release_exit:
 enable_discards_exit:
     ram_block_uncoordinated_discard_disable(false);
 
-unregister_container_exit:
-    vfio_cpr_unregister_container(bcontainer);
-
 free_container_exit:
     object_unref(container);
 
@@ -286,7 +278,6 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
         vioc->release(bcontainer);
     }
 
-    vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
     vfio_address_space_put(space);
-- 
2.50.0


