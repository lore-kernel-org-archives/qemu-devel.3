Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481F0C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8f-0006mn-O0; Tue, 30 Jun 2026 00:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8e-0006m9-EZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8c-0003F9-U6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/BaSE9iED73RydcdKRYU3/Gp7j/oPk8CVubFRkdDiyk=;
 b=UIlRX+1KNgTYTxgdDbXr3w9UJrW90t2Js7dc0eSw9t2pXhyDrrOKv8DELP1goHGsc/cSKA
 2404d60WQlDE/EvIqx4pnj9ni/8IBUNegwbZC1EKkRClSJjJsUIydoM4JCOIM7xJ57xO0S
 IUC1ujpIJEPW8DAMuUwJ36ce8wOaHqs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-dBl4gPVwP_mqVs019gPoxg-1; Tue,
 30 Jun 2026 00:31:53 -0400
X-MC-Unique: dBl4gPVwP_mqVs019gPoxg-1
X-Mimecast-MFC-AGG-ID: dBl4gPVwP_mqVs019gPoxg_1782793912
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4C3A197731D; Tue, 30 Jun 2026 04:31:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CAF01956042; Tue, 30 Jun 2026 04:31:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nathan Chen <nathanc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/23] iommufd: Introduce handler for device ATS support
Date: Tue, 30 Jun 2026 06:31:04 +0200
Message-ID: <20260630043107.1511076-21-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Introduce a support_ats() handler that returns whether ATS is supported
for a device associated with a host IOMMU device, checking if the
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.

Implement this handler in a new function for iommufd.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260623204943.989903-2-nathanc@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/host_iommu_device.h | 9 +++++++++
 backends/iommufd.c                 | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index f0003015832855b7173475559ef411bee31d1c86..2cb53653406ceec30906120ffbfd263a3d0810e8 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -133,6 +133,15 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
+    /**
+     *  @support_ats: Returns true if ATS can be used by the device,
+     *  false if the host IOMMU reports it is unavailable.
+     *
+     *  @hiod: handle to the host IOMMU device
+     *
+     *  Returns: true if ATS is supported, false otherwise
+     */
+    bool (*support_ats)(HostIOMMUDevice *hiod);
 };
 
 /*
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 09624cd6526b4027b82b02dad3e6494231fedc2c..4b40aaebe6cbb9d27b0d0b15f093a79fac9ed3b3 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -638,6 +638,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
+}
+
 static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
                                         PasidInfo *pasid_info)
 {
@@ -660,6 +667,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 
     hiodc->get_cap = hiod_iommufd_get_cap;
     hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
+    hiodc->support_ats = hiod_iommufd_support_ats;
 };
 
 static const TypeInfo types[] = {
-- 
2.54.0


