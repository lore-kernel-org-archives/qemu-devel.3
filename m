Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1231FC71131
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2j-0004y0-Cb; Wed, 11 Jun 2025 11:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2h-0004pk-VK
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2d-00078a-En
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yb4F3Uf4HAsSLHVJtGXLnO0swpN0pMYUu1KLQdQ3a+Q=;
 b=FLw6h/qdE2Yb2ZOR8rQATJ6Uk+oj/IRAfNFz7eca3za8JycVzg0/EMcRoSSEODhWqlDQm9
 5PLHQ/5GqsfN1Gtu9c8zTv15BmgyYhL+BY/UutqKE2VpZjW6B+X3vyWW5Q5c7G+DEauavj
 MFhcloaP3f7Zamf3eGLgk25VILW2NLU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-29cn7PVWNQWXKxpyxxlnfw-1; Wed,
 11 Jun 2025 11:07:01 -0400
X-MC-Unique: 29cn7PVWNQWXKxpyxxlnfw-1
X-Mimecast-MFC-AGG-ID: 29cn7PVWNQWXKxpyxxlnfw_1749654420
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88C611809C8A; Wed, 11 Jun 2025 15:07:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6B61180045C; Wed, 11 Jun 2025 15:06:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/27] vfio/container: discard old DMA vaddr
Date: Wed, 11 Jun 2025 17:06:06 +0200
Message-ID: <20250611150620.701903-15-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

In the container pre_save handler, discard the virtual addresses in DMA
mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest RAM will be
remapped at a different VA after in new QEMU.  DMA to already-mapped
pages continues.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-6-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr-legacy.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index ac4a9ab315eab515607fb2405032ddc1ab980cf0..ef106d0ea865e86e3fdce86928e987e812724a0e 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -15,6 +15,22 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
+static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
+{
+    struct vfio_iommu_type1_dma_unmap unmap = {
+        .argsz = sizeof(unmap),
+        .flags = VFIO_DMA_UNMAP_FLAG_VADDR | VFIO_DMA_UNMAP_FLAG_ALL,
+        .iova = 0,
+        .size = 0,
+    };
+    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
+        return false;
+    }
+    return true;
+}
+
+
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -30,10 +46,23 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
     }
 }
 
+static int vfio_container_pre_save(void *opaque)
+{
+    VFIOContainer *container = opaque;
+    Error *local_err = NULL;
+
+    if (!vfio_dma_unmap_vaddr_all(container, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+    return 0;
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .pre_save = vfio_container_pre_save,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
-- 
2.49.0


