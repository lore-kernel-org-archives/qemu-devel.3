Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB9ACD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDMP-0002eG-4Q; Wed, 27 May 2026 08:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDM4-0002bq-Sn
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDLy-0001Gm-CZ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779884837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pm9BRKBqNO5P09ER+h91MygXItxHLqk5IiUi5NXPFuI=;
 b=GGwGsRil5CE4Pp+G+pjjApT829WYjBYvXNHCj/07UX9PnjuhpozPfSOQ+3j7HxQVIPph3n
 j5dDLsTAkDs6Z2re9IZ9Rbm8lO1YZy4jzgl8aQve+L3IsfQZ+2Cq5c/LhZHI7LwRFHzVYW
 qjKPSUN6WDJEvhbx+X1iokljYakiZ+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-cwaprBLuOiGwL7gaDQiopw-1; Wed,
 27 May 2026 08:27:13 -0400
X-MC-Unique: cwaprBLuOiGwL7gaDQiopw-1
X-Mimecast-MFC-AGG-ID: cwaprBLuOiGwL7gaDQiopw_1779884832
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F10618005B4; Wed, 27 May 2026 12:27:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FB8930001BE; Wed, 27 May 2026 12:27:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/7] vfio: Clean up vfio_region_unmap()
Date: Wed, 27 May 2026 14:26:56 +0200
Message-ID: <20260527122700.1589764-4-clg@redhat.com>
In-Reply-To: <20260527122700.1589764-1-clg@redhat.com>
References: <20260527122700.1589764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Since commit 7429aebe1cff ("vfio/migration: Remove VFIO migration
protocol v1"), vfio_region_unmap() lost all its callers.

Remove unused vfio_region_unmap().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260519063540.1117808-1-xiaoyao.li@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-region.h |  1 -
 hw/vfio/region.c      | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 9b21d4ee5ba16f8c05be83c75d1c7a6ad4cf8370..58b236f1133e7e7f6c99b440d9125e96e6529085 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -41,7 +41,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
-void vfio_region_unmap(VFIORegion *region);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 0342ca712acd0ad846685115c29432c15aa966a0..dbde3391802691888ca31d5e329aba5ba680feb4 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -468,21 +468,6 @@ no_mmap:
     return ret;
 }
 
-void vfio_region_unmap(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            vfio_subregion_unmap(region, i);
-        }
-    }
-}
-
 void vfio_region_exit(VFIORegion *region)
 {
     int i;
-- 
2.54.0


