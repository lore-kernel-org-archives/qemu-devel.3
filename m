Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70633E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 14:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsi71-00041e-GI; Wed, 18 Feb 2026 09:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6N-0003xZ-To
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6K-0007Ar-N4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771423223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOee9YxXmCfpONqwsL6eQDaAixD1oOSK0bCHKeQK5ns=;
 b=S/2u4Q/k75VGun/cABkey/iHXN4SUtZn+loI/rgOEBvkpqkJgySEUD5etK2BLUeOtIIwoX
 jzAl9IpW11Qm3Bkjt4i/17yBsNKtBu39fsueoLjBts5DZKOlxFaA7ZEaqdc+ypfpwNzH8O
 8RrDK8KIqzLxqimJCyWaRxppyPE+AkI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-3KjA8bAoN4q3BA40uk5cBA-1; Wed,
 18 Feb 2026 09:00:20 -0500
X-MC-Unique: 3KjA8bAoN4q3BA40uk5cBA-1
X-Mimecast-MFC-AGG-ID: 3KjA8bAoN4q3BA40uk5cBA_1771423219
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18B791955E85; Wed, 18 Feb 2026 14:00:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FAB5195410D; Wed, 18 Feb 2026 14:00:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/5] vfio: Document vfio_device_get_region_info()
Date: Wed, 18 Feb 2026 15:00:03 +0100
Message-ID: <20260218140003.1554502-6-clg@redhat.com>
In-Reply-To: <20260218140003.1554502-1-clg@redhat.com>
References: <20260218140003.1554502-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

Add documentation for vfio_device_get_region_info() and clarify the
expectations around its usage.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260210070155.1176081-8-vivek.kasireddy@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 35a5ec6d9224df515c354fe50fcf7c80c1241c8c..828a31c006ec9fc372760fee023da31b0e7acc4b 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -275,6 +275,19 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
 int vfio_device_get_feature(VFIODevice *vbasedev,
                             struct vfio_device_feature *feature);
 
+/**
+ * Return the region info for a given region index. The region info includes
+ * details such as size, offset, and capabilities. Note that the returned
+ * info pointer is either a cached copy or newly allocated by
+ * vfio_device_get_region_info(), so the caller is not expected to allocate
+ * or free it.
+ *
+ * @vbasedev: #VFIODevice to use
+ * @index: region index
+ * @info: pointer to store the region info
+ *
+ * Returns 0 on success or a negative value on error.
+ */
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
-- 
2.53.0


