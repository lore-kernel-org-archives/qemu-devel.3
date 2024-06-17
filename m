Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9299C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5xR-0003pS-HU; Mon, 17 Jun 2024 02:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5xD-00030B-TT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5xB-0004Qj-FP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718606096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xaw3HaZRkfAZwir3xOelvorwksL9vPSgFnrYprPUuis=;
 b=PcgJDsDSjhqk4bHsDcEPXbyIyGh6hQve1OYXmmiCvv13Mw/R2RpUrAxtUgqbnXhjYf09H+
 Ot3RnpVFv7lG6f4ijoEWzU2b+8eSoOuLnjvZTBVbUsqKbSPLDhyndSLRSBuJZKOUhCwPY3
 rJocF/8GndVRGR12+1ifq6iCkdCPneE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-NUcjKopHMeOyKPHKmTss_A-1; Mon,
 17 Jun 2024 02:34:54 -0400
X-MC-Unique: NUcjKopHMeOyKPHKmTss_A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9CD919560A2; Mon, 17 Jun 2024 06:34:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEF413000222; Mon, 17 Jun 2024 06:34:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 16/17] vfio/container: Introduce
 vfio_iommu_legacy_instance_init()
Date: Mon, 17 Jun 2024 08:34:08 +0200
Message-ID: <20240617063409.34393-17-clg@redhat.com>
In-Reply-To: <20240617063409.34393-1-clg@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Just as we did for the VFIOContainerBase object, introduce an
instance_init() handler for the legacy VFIOContainer object and do the
specific initialization there.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3f2032d5c496de078c277ebacc49d7db89f4cc65..45123acbdd6a681f4ce7cae7aa2509100ea225ab 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -639,7 +639,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     vfio_kvm_device_add_group(group);
 
-    QLIST_INIT(&container->group_list);
     vfio_address_space_insert(space, bcontainer);
 
     group->container = container;
@@ -1183,6 +1182,13 @@ hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
     return l;
 }
 
+static void vfio_iommu_legacy_instance_init(Object *obj)
+{
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
+
+    QLIST_INIT(&container->group_list);
+}
+
 static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
@@ -1196,6 +1202,7 @@ static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
+        .instance_init = vfio_iommu_legacy_instance_init,
         .instance_size = sizeof(VFIOContainer),
         .class_init = vfio_iommu_legacy_class_init,
     }, {
-- 
2.45.2


