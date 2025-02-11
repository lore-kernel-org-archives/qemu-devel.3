Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64414C021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrLA-0006aW-GR; Tue, 11 Feb 2025 09:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrL7-0006Yd-K4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrL5-0001x0-Tu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/qip6V6Wg6fxOg2z6s4rllHZNBS+ehlABt5FVsoTaM=;
 b=CJXdnBDmHXnCx6BF0oHhtWOFkER3XKx9sbEYn/+tNGr6/DIJoVN+ybaRHIBrn6xeGsaVGy
 6omZynp2dc2euzvGP3JyZ55XGxzqaU+VNaHtZrr1b4Y9DzAiw4bf+iqmrBtstN/fo2K2gC
 lqQDxV5LBvWXEtfmAlUO1/UxtmgOBIM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-0T1PgzZNOlOha1XzPxxxog-1; Tue,
 11 Feb 2025 09:34:13 -0500
X-MC-Unique: 0T1PgzZNOlOha1XzPxxxog-1
X-Mimecast-MFC-AGG-ID: 0T1PgzZNOlOha1XzPxxxog
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D15C11955DDD; Tue, 11 Feb 2025 14:34:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E66E1800570; Tue, 11 Feb 2025 14:34:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: [PULL 12/12] vfio: Remove superfluous error report in
 vfio_listener_region_add()
Date: Tue, 11 Feb 2025 15:33:40 +0100
Message-ID: <20250211143340.787996-13-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250206131438.1505542-8-clg@redhat.com
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


