Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2907C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDuc-0004oh-QP; Tue, 21 Jul 2026 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDua-0004nt-Sq
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuZ-00074p-EC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEJwEoGhO12AmbhN6O3Bb2G+2hsVAlx3B1Qba5SOvGY=;
 b=Ys4+NuDyaHiwuY11vAaz2+X/n5by2fKiN9CCvRM9OdhNTKI8sA3rhABbrhOxHqjE1mYiRQ
 U9TUDNSTN/iWnLI6bS5pieFJjB2sqwdb6phnR/aJbDTbMNOeGDZfSSVvIm4IZnxjm0vPc2
 7KiTdZ9rU6BV+wLZHv/ib8Nj4Gzx4u0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-x3C2vHO0Pyu__YctxsBDRQ-1; Tue,
 21 Jul 2026 13:05:39 -0400
X-MC-Unique: x3C2vHO0Pyu__YctxsBDRQ-1
X-Mimecast-MFC-AGG-ID: x3C2vHO0Pyu__YctxsBDRQ_1784653538
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 097221809CB6; Tue, 21 Jul 2026 17:05:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F0241598; Tue, 21 Jul 2026 17:05:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/13] vfio-user: vfio_user_get_region_info: prevent excessive
 malloc
Date: Tue, 21 Jul 2026 19:05:13 +0200
Message-ID: <20260721170518.4160785-9-clg@redhat.com>
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Thanos Makatos <thanos.makatos@nutanix.com>

If the vfio-user server responds with a value larger than max_xfer_size
vfio_device_get_region_info() blindly uses it in the next loop in
g_realloc. An value larger than max_xfer_size is anyway rejected by the
check at the beginning of vfio_user_get_region_info(), however that only
happens _after_ the g_realloc, and if that value is excessively large it
can cause g_realloc to fail, so check it here.

Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-5-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 3d12e8b2a20eb96fb1a8a944070d13bf0e049b67..008e5cf6877c84c3d0cf33f25a6ac9a4cf231e06 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -170,6 +170,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
         return -EINVAL;
     }
 
+    /*
+     * The server can respond with a larger argsz in the reply to request a
+     * larger buffer on the next iteration via vfio_device_get_region_info().
+     * Reject values that would trigger an oversized realloc.
+     */
+    if (msgp->argsz > proxy->max_xfer_size) {
+        error_printf("vfio_user_get_region_info reply argsz too large\n");
+        return -E2BIG;
+    }
+
     memcpy(info, &msgp->argsz, info->argsz);
 
     /*
-- 
2.55.0


