Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9E7CDD0E1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LBM-0006N6-VJ; Tue, 22 Oct 2024 16:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3LBK-0006M9-I0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3LBI-00052B-Mu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729627720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cejL+OkeykWVMv/qxY90R1x2b9lU18Sy6vUusx4Pam0=;
 b=aOaMEl/ksrvq8NGJBVlm+gwmVh4IxiBKR3VS1beuHPTLbzStZhG1vTeREf/n9R9sDxbdUo
 matDyZ70FwFX/BZVE411otSsRKEE9QSq/QODoY6mMmoCEeStEw9Yhoy0vX8MAK13x8R+SZ
 NJj87Z7MF7yUtzWZpXrRA/YoauP/19g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-rQbBn9ngMHGnLWgmq-jejA-1; Tue,
 22 Oct 2024 16:08:37 -0400
X-MC-Unique: rQbBn9ngMHGnLWgmq-jejA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B488919560A7
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:08:36 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.64.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F65119560A2; Tue, 22 Oct 2024 20:08:34 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, clg@redhat.com,
 peterx@redhat.com
Subject: [PATCH 1/2] vfio/helpers: Refactor vfio_region_mmap() error handling
Date: Tue, 22 Oct 2024 14:08:28 -0600
Message-ID: <20241022200830.4129598-2-alex.williamson@redhat.com>
In-Reply-To: <20241022200830.4129598-1-alex.williamson@redhat.com>
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Move error handling code to the end of the function so that it can more
easily be shared by new mmap failure conditions.  No functional change
intended.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/helpers.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index ea15c79db0a3..b9e606e364a2 100644
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
2.46.2


