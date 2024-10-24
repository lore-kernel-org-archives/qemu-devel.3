Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D229D0BB5E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 05:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3qSe-0003bo-Oe; Thu, 24 Oct 2024 01:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSN-0003aS-Fn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSJ-0004Ic-Ha
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729747936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOSGfh1Uui/5RceMtbyXrhVmegZXFuC2W7IuPh+sr6w=;
 b=D2wBgCEmw3rmZq/0GAXw3MgbNlrDED4CdnZbW8rdoSVKD96KxxuWnWAqLGz16z4HTn4YXE
 ekcB6g+52D+FXfJ9UhUBU8sdaPCBEQFQm+TeqQPE8mNvRIU7hDEItKKkoVUhYl+aMcfObd
 zjS3py9u1lJBHv/IowvVwovaC88xUXk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-pyMS9ORGN-C8ioApMWkA2g-1; Thu,
 24 Oct 2024 01:32:14 -0400
X-MC-Unique: pyMS9ORGN-C8ioApMWkA2g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6C0E19560AB
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:32:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 399A31956056; Thu, 24 Oct 2024 05:32:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/4] vfio/helpers: Refactor vfio_region_mmap() error handling
Date: Thu, 24 Oct 2024 07:32:02 +0200
Message-ID: <20241024053203.1559456-4-clg@redhat.com>
In-Reply-To: <20241024053203.1559456-1-clg@redhat.com>
References: <20241024053203.1559456-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

From: Alex Williamson <alex.williamson@redhat.com>

Move error handling code to the end of the function so that it can more
easily be shared by new mmap failure conditions.  No functional change
intended.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index ea15c79db0a3643f260fc1ce3abfeaa7001ab306..b9e606e364a2dd267bacd63094cdedae5dd7d8b2 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -395,7 +395,7 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
 
 int vfio_region_mmap(VFIORegion *region)
 {
-    int i, prot = 0;
+    int i, ret, prot = 0;
     char *name;
 
     if (!region->mem) {
@@ -411,22 +411,8 @@ int vfio_region_mmap(VFIORegion *region)
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
-            int ret = -errno;
-
-            trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
-                                         region->fd_offset +
-                                         region->mmaps[i].offset,
-                                         region->fd_offset +
-                                         region->mmaps[i].offset +
-                                         region->mmaps[i].size - 1, ret);
-
-            region->mmaps[i].mmap = NULL;
-
-            for (i--; i >= 0; i--) {
-                vfio_subregion_unmap(region, i);
-            }
-
-            return ret;
+            ret = -errno;
+            goto no_mmap;
         }
 
         name = g_strdup_printf("%s mmaps[%d]",
@@ -446,6 +432,20 @@ int vfio_region_mmap(VFIORegion *region)
     }
 
     return 0;
+
+no_mmap:
+    trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
+                                 region->fd_offset + region->mmaps[i].offset,
+                                 region->fd_offset + region->mmaps[i].offset +
+                                 region->mmaps[i].size - 1, ret);
+
+    region->mmaps[i].mmap = NULL;
+
+    for (i--; i >= 0; i--) {
+        vfio_subregion_unmap(region, i);
+    }
+
+    return ret;
 }
 
 void vfio_region_unmap(VFIORegion *region)
-- 
2.47.0


