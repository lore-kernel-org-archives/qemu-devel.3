Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85790C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G9k-00045X-Rp; Tue, 22 Apr 2025 12:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5o-0007KF-9W
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5l-00052p-Ns
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Afpsl/uyNqo8ZNTriBR5AdklXaX0mqx92jDWX4wCyxc=;
 b=fJwBuR/RF98tU2Oi+9mzheRlWtAj0hbx2LKxV0TJQfuwfHAu8enRC66FWDgP8OBxsZ2NwQ
 Yk2/KGidQJNauojLD0g4Yfi/rd1g528MdNwp2/+rn18L5D9ie8v19qhzbswIsp+WbeNluF
 ajnPT2uDwvgN91igS3HHkIoL12EsxXo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-SxVa_zI8O_yKsYZaGY-ARw-1; Tue,
 22 Apr 2025 12:03:18 -0400
X-MC-Unique: SxVa_zI8O_yKsYZaGY-ARw-1
X-Mimecast-MFC-AGG-ID: SxVa_zI8O_yKsYZaGY-ARw_1745337797
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5848F1956088; Tue, 22 Apr 2025 16:03:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B34B118001DA; Tue, 22 Apr 2025 16:03:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 13/37] vfio: Make vfio_group_list static
Date: Tue, 22 Apr 2025 18:02:00 +0200
Message-ID: <20250422160224.199714-14-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

vfio_group_list is only used in file "container.c".

Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-13-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-14-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 --
 hw/vfio/container.c           | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index aebce091088f5027c31c7782a1683e763bd766ec..e23626856e6ff96939a4660f059833f166aa88e9 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -146,9 +146,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
-typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
-extern VFIOGroupList vfio_group_list;
 extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 75b5ebf4716c55d8c32a845c875981cef8fb5610..8badeb98ec052ad1fa7b5d45bb1733b1184bc6fb 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,7 +34,8 @@
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
 
-VFIOGroupList vfio_group_list =
+typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
+static VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 
 static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
-- 
2.49.0


