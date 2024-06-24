Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9A1C3065A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCv-0005pg-3H; Mon, 24 Jun 2024 17:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCr-0005Lo-7W
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCp-0006rD-DU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+d15cpRUQTlejQZ4KZf89F6osecaDusFBmuvLsdTY0=;
 b=eCkF9BcoEjUIi+wjHKjhApXHlYayKHt4r/29cZgbALBnPJOJ+bwpRjlqDcc+aeUlnTbs9n
 5G5x13Jh2Vod47dAd6nTRtgCOubMIGEUrXBhDm4ZUAEWKOEv9myri0zNVncSjdeTTWqNHs
 hmyjtbb4RaBJqMBft1fyyVqMR7yq8ZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-FprIDazLNJahekobtNPN7w-1; Mon,
 24 Jun 2024 17:26:27 -0400
X-MC-Unique: FprIDazLNJahekobtNPN7w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F9BD19560AB; Mon, 24 Jun 2024 21:26:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FA161956053; Mon, 24 Jun 2024 21:26:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 34/42] vfio/container: Introduce vfio_create_container()
Date: Mon, 24 Jun 2024 23:24:48 +0200
Message-ID: <20240624212456.350919-35-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bb6abe60ee29d5b69b494523c9002f53e1b2a3c8..a8691942791006f44f7a3c34b32c67ca51766182 100644
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


