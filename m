Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5695EC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNbv-00037v-Ui; Wed, 12 Jun 2024 09:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNbs-00037T-FU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNbr-0007yL-30
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ruBv5M0blGO19jCA10TbUnAMzMHW8clbxP1/8/PlqA=;
 b=K9aBWjyuNyL+8t91BjE+xPau/zDVvZE9IDLz+SqC9Q5uMcYBcjKi7aik4PGr8vr5MmxzKt
 ajROwZEhOxPx90plqDcekqD8g7jCTgLOgI0ULNMjrVBDRC+p4HGuezbDPW8RCw08ZyT6Ag
 XuPjw8uaWTU8NHJxPwrILu1JisR1XJc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-jjrhaGzKPPqlNsblYkyk0Q-1; Wed,
 12 Jun 2024 09:01:48 -0400
X-MC-Unique: jjrhaGzKPPqlNsblYkyk0Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0200E1954AC8; Wed, 12 Jun 2024 13:01:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5254D1956059; Wed, 12 Jun 2024 13:01:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 09/16] vfio/container: Introduce vfio_create_container()
Date: Wed, 12 Jun 2024 15:01:15 +0200
Message-ID: <20240612130122.813935-10-clg@redhat.com>
In-Reply-To: <20240612130122.813935-1-clg@redhat.com>
References: <20240612130122.813935-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This routine allocates the QEMU struct type representing the VFIO
container. It is minimal currently and future changes will do more
initialization.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c5ddfdda3426fce0e449e60630412875d070b011..8b47d1a13dca793dee1e1b7e06f36e8ea58a81e9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -430,6 +430,16 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
     return true;
 }
 
+static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
+                                            Error **errp)
+{
+    VFIOContainer *container;
+
+    container = g_malloc0(sizeof(*container));
+    container->fd = fd;
+    return container;
+}
+
 static int vfio_get_iommu_info(VFIOContainer *container,
                                struct vfio_iommu_type1_info **info)
 {
@@ -604,13 +614,14 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto close_fd_exit;
     }
 
-    container = g_malloc0(sizeof(*container));
-    container->fd = fd;
-    bcontainer = &container->bcontainer;
-
+    container = vfio_create_container(fd, group, errp);
+    if (!container) {
+        goto close_fd_exit;
+    }
     if (!vfio_set_iommu(container, group->fd, errp)) {
         goto free_container_exit;
     }
+    bcontainer = &container->bcontainer;
 
     if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto free_container_exit;
-- 
2.45.2


