Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82936C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubixm-0005N7-Hr; Tue, 15 Jul 2025 12:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubieh-0006gu-US
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubieg-0003Yw-6e
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xt2S0+xHW7NhGnqmYKqDMv8+0n5cOBqFu33T0qJRTZs=;
 b=Hs4Wn3/IA27YHeTg8yB2Ic0O1bWBbjN5ZUYM9ph2UeNa9+6QdlUuHsk9bge+8ijPi6WCm6
 +iZetG0jw/1UTtlQCxmxI5VTNUOLBfC0VY2UuNkFNURCABGDGvVTkCTdTDmzFbs7ikYCBR
 q8itxaXrM9bYxH99X8/Xcej3wTwxKTg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-qsbTqvtUMomEXF_7ZmzbSw-1; Tue,
 15 Jul 2025 12:37:19 -0400
X-MC-Unique: qsbTqvtUMomEXF_7ZmzbSw-1
X-Mimecast-MFC-AGG-ID: qsbTqvtUMomEXF_7ZmzbSw_1752597438
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 354E4195608C; Tue, 15 Jul 2025 16:37:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 109F130001A1; Tue, 15 Jul 2025 16:37:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/7] hw/vfio: fix region fd initialization
Date: Tue, 15 Jul 2025 18:36:58 +0200
Message-ID: <20250715163703.243975-3-clg@redhat.com>
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
References: <20250715163703.243975-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We were not initializing the region fd array to -1, so we would
accidentally try to close(0) on cleanup for any region that is not
referenced.

Fixes: 95cdb024 ("vfio: add region info cache")
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250715115954.515819-3-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 96cf21462cb10f9ebaf1bda54fed13a95b79f223..52a1996dc4e122499a978cc8a5ce7e01620a9639 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -463,6 +463,8 @@ void vfio_device_detach(VFIODevice *vbasedev)
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info)
 {
+    int i;
+
     vbasedev->num_irqs = info->num_irqs;
     vbasedev->num_regions = info->num_regions;
     vbasedev->flags = info->flags;
@@ -477,6 +479,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                                vbasedev->num_regions);
     if (vbasedev->use_region_fds) {
         vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
+        for (i = 0; i < vbasedev->num_regions; i++) {
+            vbasedev->region_fds[i] = -1;
+        }
     }
 }
 
@@ -489,7 +494,6 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
         if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
             close(vbasedev->region_fds[i]);
         }
-
     }
 
     g_clear_pointer(&vbasedev->reginfo, g_free);
-- 
2.50.1


