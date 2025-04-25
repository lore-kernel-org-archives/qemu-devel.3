Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3A0C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ekq-0007dE-Qd; Fri, 25 Apr 2025 04:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkI-0006tB-T9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkG-0003MV-U4
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWDzgC69mysZy0cadpTCRqedDgSpvxf5w+EQapY63hg=;
 b=bGqi35rU0mF/31rxAFCrs5DSwKth4IlaQjulusoKfQiaGeU5WqI6nCNlKw74MqiSvkMILV
 1WF2F0WjBiDGfZGP63YICE7fg065zXJW88mYkhpv03/ckjE2NEMjISG6/kOKBcVhEN0LMA
 F0aK8VdGXeglRSdZFtBx4DBtAKgx9Wo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-oqI7bhEtM1ya1YyH9cQQUA-1; Fri,
 25 Apr 2025 04:49:12 -0400
X-MC-Unique: oqI7bhEtM1ya1YyH9cQQUA-1
X-Mimecast-MFC-AGG-ID: oqI7bhEtM1ya1YyH9cQQUA_1745570951
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88875195608C; Fri, 25 Apr 2025 08:49:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33BFA30001A2; Fri, 25 Apr 2025 08:49:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Donald Dutile <ddutile@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PULL 44/50] vfio/iommufd: Move realize() after attachment
Date: Fri, 25 Apr 2025 10:46:37 +0200
Message-ID: <20250425084644.102196-45-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Previously device attaching depends on realize() getting host IOMMU
capabilities to check dirty tracking support.

Now we have a separate call to ioctl(IOMMU_GET_HW_INFO) to get host
IOMMU capabilities and check that for dirty tracking support, there
is no dependency any more, move realize() call after attachment
succeed.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Donald Dutile <ddutile@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250423072824.3647952-3-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 2253778b3ae0738f0a48dca77f0b68180b7d1f71..f273dc87127075e4ff2f3781a49757dfb628da27 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -500,17 +500,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     space = vfio_address_space_get(as);
 
-    /*
-     * The HostIOMMUDevice data from legacy backend is static and doesn't need
-     * any information from the (type1-iommu) backend to be initialized. In
-     * contrast however, the IOMMUFD HostIOMMUDevice data requires the iommufd
-     * FD to be connected and having a devid to be able to successfully call
-     * iommufd_backend_get_device_info().
-     */
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        goto err_alloc_ioas;
-    }
-
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
@@ -585,6 +574,10 @@ found_container:
         goto err_listener_register;
     }
 
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        goto err_hiod_realize;
+    }
+
     /*
      * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
      * for discarding incompatibility check as well?
@@ -606,6 +599,8 @@ found_container:
                                    vbasedev->num_regions, vbasedev->flags);
     return true;
 
+err_hiod_realize:
+    vfio_cpr_unregister_container(bcontainer);
 err_listener_register:
     iommufd_cdev_ram_block_discard_disable(false);
 err_discard_disable:
-- 
2.49.0


