Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF22EC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1jB-0008Oo-VX; Thu, 06 Feb 2025 08:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1ii-0007Cn-GV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:15:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tg1ig-0000E7-VB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738847701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9BDMOcWObuL+KRz9wtCLwcrICiV3rxxZkwnMz/STFH8=;
 b=CKcS9IXVEG3aOycXlmLjxNJdHAmkQ5pMxgSiwmHqJdbliREyf5BSXqKnKeMWUsodxm7ElS
 0QGFtlIC72e057aJ6LrXgIp540eKScjyGrRq01N1L+m8GP71XlL6hjMz8Hnpm4jt980IZp
 VS4kTqnSbs+sN/pVJKTrnU8ID6UiAgI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-3or_iLaBMeCBvc9DJuCIbA-1; Thu,
 06 Feb 2025 08:14:58 -0500
X-MC-Unique: 3or_iLaBMeCBvc9DJuCIbA-1
X-Mimecast-MFC-AGG-ID: 3or_iLaBMeCBvc9DJuCIbA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60233180056F; Thu,  6 Feb 2025 13:14:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A801F30001AB; Thu,  6 Feb 2025 13:14:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: [PATCH v3 7/7] vfio: Remove superfluous error report in
 vfio_listener_region_add()
Date: Thu,  6 Feb 2025 14:14:35 +0100
Message-ID: <20250206131438.1505542-8-clg@redhat.com>
In-Reply-To: <20250206131438.1505542-1-clg@redhat.com>
References: <20250206131438.1505542-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

For pseries machines, commit 567b5b309abe ("vfio/pci: Relax DMA map
errors for MMIO regions") introduced 2 error reports to notify the
user of MMIO mapping errors. Consolidate both code paths under one.

Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4fca4c6166f761acceb7b57b52e379603ea53876..abbdc56b6dbb5eed22e7a2d2d55ee5695279661e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -594,8 +594,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
+    /* PPC64/pseries machine only */
     if (!vfio_container_add_section_window(bcontainer, section, &err)) {
-        goto fail;
+        goto mmio_dma_error;
     }
 
     memory_region_ref(section->mr);
@@ -680,6 +681,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
                    bcontainer, iova, int128_get64(llsize), vaddr, ret,
                    strerror(-ret));
+    mmio_dma_error:
         if (memory_region_is_ram_device(section->mr)) {
             /* Allow unexpected mappings not to be fatal for RAM devices */
             VFIODevice *vbasedev =
@@ -694,11 +696,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
     return;
 
 fail:
-    if (memory_region_is_ram_device(section->mr)) {
-        error_reportf_err(err, "PCI p2p may not work: ");
-        return;
-    }
-
     if (!bcontainer->initialized) {
         /*
          * At machine init time or when the device is attached to the
@@ -806,6 +803,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     memory_region_unref(section->mr);
 
+    /* PPC64/pseries machine only */
     vfio_container_del_section_window(bcontainer, section);
 }
 
-- 
2.48.1


