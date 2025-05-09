Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D377CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNa2-0003fm-In; Fri, 09 May 2025 09:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNZ7-0002YK-SZ
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNZ3-0007FK-KU
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9dp+vGAaJR3Tzwj/axTWOM7V9O2RntbetImxPSb22Q=;
 b=QpKnh7YbPNuRPW0NGeX10W/d8ySRBym9DyxU84Lo2Y2rAO6L5tGy0FZHwl64e57fUgtZNd
 sTSCaFSgnMjrQgl6sqPPvQo42NV8nETg2W6yaF0iS6soexz/kw2T1kNGvxOYHZn+s3qy3v
 O5LJjO72lPuVtPSa6Ip1kfQ+F/XAHBA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-cp4_BzozNOib7UdRcSIOXw-1; Fri,
 09 May 2025 09:14:55 -0400
X-MC-Unique: cp4_BzozNOib7UdRcSIOXw-1
X-Mimecast-MFC-AGG-ID: cp4_BzozNOib7UdRcSIOXw_1746796494
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BB431955DCD; Fri,  9 May 2025 13:14:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3069518003FD; Fri,  9 May 2025 13:14:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/28] vfio/container: pass listener_begin/commit callbacks
Date: Fri,  9 May 2025 15:13:17 +0200
Message-ID: <20250509131317.164235-29-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

From: John Levon <john.levon@nutanix.com>

The vfio-user container will later need to hook into these callbacks;
set up vfio to use them, and optionally pass them through to the
container.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-15-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  2 ++
 hw/vfio/listener.c                    | 28 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 59f07d26e8226916c9c58eac07cb494552097138..3d392b0fd8bca9de1480d75ccfac8f3625e82121 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -117,6 +117,8 @@ struct VFIOIOMMUClass {
 
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2b93ca55b6d47e4ef3e89bea681d6e345f8d3abe..bfacb3d8d9cd5b7764a1678142eedf6d553cc07a 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -411,6 +411,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_listener_begin(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_begin) {
+        listener_begin(bcontainer);
+    }
+}
+
+static void vfio_listener_commit(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_commit) {
+        listener_commit(bcontainer);
+    }
+}
+
 static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 {
     /*
@@ -1161,6 +1187,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
 
 static const MemoryListener vfio_memory_listener = {
     .name = "vfio",
+    .begin = vfio_listener_begin,
+    .commit = vfio_listener_commit,
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
     .log_global_start = vfio_listener_log_global_start,
-- 
2.49.0


