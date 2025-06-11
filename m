Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7821DC678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2I-0004Mm-J8; Wed, 11 Jun 2025 11:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2D-0004MB-8G
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2B-00072t-Dk
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGUijn8OwNTfwcOPRbjli+qIh22n9IlcqzOHh08EtHM=;
 b=iXHGSx6P+JbhoYYH/PU5adQxOZSrUN1JJeM1lDz7wgwEd004Z7f8uawfJFPqkX8+EzBiGC
 AG5YvoxcL/py+NHUHo0Km+/2JsBq5ehEY2r+yUxPfAbQgTmT7iP6Nf3SD53rRSp7viFZxa
 WjQ5zv4UqKS/qvmQ5QuTk2S5Aku3mN0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Z3gH8SuvMpaECHxrW8CRUw-1; Wed,
 11 Jun 2025 11:06:31 -0400
X-MC-Unique: Z3gH8SuvMpaECHxrW8CRUw-1
X-Mimecast-MFC-AGG-ID: Z3gH8SuvMpaECHxrW8CRUw_1749654390
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1072C19560B2; Wed, 11 Jun 2025 15:06:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C7CC180045B; Wed, 11 Jun 2025 15:06:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PULL 02/27] vfio/pci: Fix instance_size of VFIO_PCI_BASE
Date: Wed, 11 Jun 2025 17:05:54 +0200
Message-ID: <20250611150620.701903-3-clg@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Currently the final instance_size of VFIO_PCI_BASE is sizeof(PCIDevice).
It should be sizeof(VFIOPCIDevice), VFIO_PCI uses same structure as
base class VFIO_PCI_BASE, so no need to set its instance_size explicitly.

This isn't catastrophic only because VFIO_PCI_BASE is an abstract class.

Fixes: d4e392d0a99b ("vfio: add vfio-pci-base class")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250611024228.423666-1-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b1250d85bf0124a22e3ba3859a47d2b176ade648..6748f4e876942f89138f9d8fedfb99dab95b865e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3425,7 +3425,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo vfio_pci_base_dev_info = {
     .name = TYPE_VFIO_PCI_BASE,
     .parent = TYPE_PCI_DEVICE,
-    .instance_size = 0,
+    .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
     .class_init = vfio_pci_base_dev_class_init,
     .interfaces = (const InterfaceInfo[]) {
@@ -3647,7 +3647,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
-    .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-- 
2.49.0


