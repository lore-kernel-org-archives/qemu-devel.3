Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECE5C27C7B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5ws-0002bi-T5; Mon, 17 Jun 2024 02:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5wp-0002T4-Tl
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5wn-0004Jd-T5
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718606073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vok6+6cbG4CxFr0Iyrkv3BB2FhrRVuirn5S18kj9l1E=;
 b=Sl9jw+YmPHfARe9/Gn6k11JGB8ADixmTECbN5fV8GSOuToTYvB154y10EZ6VN6iS+xYfiE
 4frgRVLHKYytTH+9lalZRCHsnyFl5dm4ZjuNZZdHUlzms11J3RLebWp+eHBpn7kBDvArZh
 1PQ2Jeb5oYBhGTJqgxv5wHvYtoBYzYs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-_FfhDfAXNfCn2uPJV9xWjg-1; Mon,
 17 Jun 2024 02:34:18 -0400
X-MC-Unique: _FfhDfAXNfCn2uPJV9xWjg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5DB419560A0; Mon, 17 Jun 2024 06:34:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB1183000218; Mon, 17 Jun 2024 06:34:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 01/17] vfio: Make vfio_devices_dma_logging_start() return
 bool
Date: Mon, 17 Jun 2024 08:33:53 +0200
Message-ID: <20240617063409.34393-2-clg@redhat.com>
In-Reply-To: <20240617063409.34393-1-clg@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Since vfio_devices_dma_logging_start() takes an 'Error **' argument,
best practices suggest to return a bool. See the api/error.h Rules
section. It will simplify potential changes coming after.

vfio_container_set_dirty_page_tracking() could be modified in the same
way but the errno value can be saved in the migration stream when
called from vfio_listener_log_global_stop().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9e4c0cc95ff90209d3e8184035af0806a2bf890b..d48cd9b9361a92d184e423ffc60aabaff40fb487 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1020,7 +1020,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
+static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
                                           Error **errp)
 {
     struct vfio_device_feature *feature;
@@ -1033,7 +1033,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
                                                            &ranges);
     if (!feature) {
         error_setg_errno(errp, errno, "Failed to prepare DMA logging");
-        return -errno;
+        return false;
     }
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
@@ -1058,7 +1058,7 @@ out:
 
     vfio_device_feature_dma_logging_start_destroy(feature);
 
-    return ret;
+    return ret == 0;
 }
 
 static bool vfio_listener_log_global_start(MemoryListener *listener,
@@ -1067,18 +1067,18 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
     ERRP_GUARD();
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
-    int ret;
+    bool ret;
 
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         ret = vfio_devices_dma_logging_start(bcontainer, errp);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;
     }
 
-    if (ret) {
+    if (!ret) {
         error_prepend(errp, "vfio: Could not start dirty page tracking - ");
     }
-    return !ret;
+    return ret;
 }
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
-- 
2.45.2


