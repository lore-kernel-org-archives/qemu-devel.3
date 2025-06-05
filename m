Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02FFC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Bu-0006ZO-Qi; Thu, 05 Jun 2025 04:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bn-0006Xh-Ny
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bl-0008E2-Ny
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75eYZOtT2IDtToXMWICf284M2quf0cvxmtB0Df4lEQA=;
 b=JpZEv3XPxQS6RrTCRk6UGnDE0JlciRKceQHoqSkWcsSFCx4wa0wQ2TY2ZUat4Ao2YuZWk6
 bOklt945bRrdc7S/Rm4FmPyz2Mq7kW4to619UfUxKZ+SYagcBxyuJz4miizGCQCpE0I9gD
 uryyjBK3j2FU4tbDHaqQUOaCHXdpDjk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-M09MaxpaMCunya1DU8xaWw-1; Thu,
 05 Jun 2025 04:42:56 -0400
X-MC-Unique: M09MaxpaMCunya1DU8xaWw-1
X-Mimecast-MFC-AGG-ID: M09MaxpaMCunya1DU8xaWw_1749112975
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E3019560B1; Thu,  5 Jun 2025 08:42:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E18D1954B33; Thu,  5 Jun 2025 08:42:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/16] vfio: add more VFIOIOMMUClass docs
Date: Thu,  5 Jun 2025 10:42:31 +0200
Message-ID: <20250605084245.1520562-3-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Add some additional doc comments for these class methods.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250520162530.2194548-1-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 75 +++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3d392b0fd8bca9de1480d75ccfac8f3625e82121..f9e561cb081b361291e72ffe228845bd6b157f92 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -115,13 +115,56 @@ OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
 
-    /* basic feature */
+    /**
+     * @setup
+     *
+     * Perform basic setup of the container, including configuring IOMMU
+     * capabilities, IOVA ranges, supported page sizes, etc.
+     *
+     * @bcontainer: #VFIOContainerBase
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns true to indicate success and false for error.
+     */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+
+    /**
+     * @listener_begin
+     *
+     * Called at the beginning of an address space update transaction.
+     * See #MemoryListener.
+     *
+     * @bcontainer: #VFIOContainerBase
+     */
     void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    /**
+     * @listener_commit
+     *
+     * Called at the end of an address space update transaction,
+     * See #MemoryListener.
+     *
+     * @bcontainer: #VFIOContainerBase
+     */
     void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    /**
+     * @dma_map
+     *
+     * Map an address range into the container.
+     *
+     * @bcontainer: #VFIOContainerBase to use
+     * @iova: start address to map
+     * @size: size of the range to map
+     * @vaddr: process virtual address of mapping
+     * @readonly: true if mapping should be readonly
+     *
+     * Returns 0 to indicate success and -errno otherwise.
+     */
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
+
     /**
      * @dma_unmap
      *
@@ -132,12 +175,38 @@ struct VFIOIOMMUClass {
      * @size: size of the range to unmap
      * @iotlb: The IOMMU TLB mapping entry (or NULL)
      * @unmap_all: if set, unmap the entire address space
+     *
+     * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
+
+
+    /**
+     * @attach_device
+     *
+     * Associate the given device with a container and do some related
+     * initialization of the device context.
+     *
+     * @name: name of the device
+     * @vbasedev: the device
+     * @as: address space to use
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns true to indicate success and false for error.
+     */
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
+
+    /*
+     * @detach_device
+     *
+     * Detach the given device from its container and clean up any necessary
+     * state.
+     *
+     * @vbasedev: the device to disassociate
+     */
     void (*detach_device)(VFIODevice *vbasedev);
 
     /* migration feature */
@@ -152,7 +221,7 @@ struct VFIOIOMMUClass {
      * @start: indicates whether to start or stop dirty pages tracking
      * @errp: pointer to Error*, to store an error if it happens.
      *
-     * Returns zero to indicate success and negative for error
+     * Returns zero to indicate success and negative for error.
      */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
                                    bool start, Error **errp);
@@ -167,7 +236,7 @@ struct VFIOIOMMUClass {
      * @size: size of iova range
      * @errp: pointer to Error*, to store an error if it happens.
      *
-     * Returns zero to indicate success and negative for error
+     * Returns zero to indicate success and negative for error.
      */
     int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
-- 
2.49.0


