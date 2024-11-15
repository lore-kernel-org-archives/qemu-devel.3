Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553DDD6DDD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 06:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBqCY-0001FA-Ms; Fri, 15 Nov 2024 01:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tBqCW-0001F2-9W
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 01:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tBqCU-0000if-Qn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 01:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731653574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZMy/MlPcdqs4FobINGCbrwEXQd7989XR/iBVF8ItIPk=;
 b=hE8qpa63ocgNqj0/H4PxAjKCMr2y4mNjW7W+Kc+8Wwewm+6SupGtJ1q6lMk3dVeR4rxGqO
 vp1Pmmpp01uqBaMyNu7VhtRDXcfzqr2gwkN4O5zzZKa2f1z1Kx1DMNwnsXt1LwYFW5ENPi
 HBLGh/tvxfJkdJRY5TXsdz67WIqU8FQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-12TeYxmLMiWnk2N3GFSRwg-1; Fri,
 15 Nov 2024 01:52:51 -0500
X-MC-Unique: 12TeYxmLMiWnk2N3GFSRwg-1
X-Mimecast-MFC-AGG-ID: 12TeYxmLMiWnk2N3GFSRwg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8251C18F6C20; Fri, 15 Nov 2024 06:52:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 021563003C9E; Fri, 15 Nov 2024 06:52:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH for-9.2] vfio/container: Fix container object destruction
Date: Fri, 15 Nov 2024 07:52:40 +0100
Message-ID: <20241115065240.2198493-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When commit 96b7af4388b3 intoduced a .instance_finalize() handler,
it did not take into account that the container was not necessarily
inserted into the container list of the address space. Hence, if
the container object is destroyed, by calling object_unref() for
example, before vfio_address_space_insert() is called, QEMU may
crash when removing the container from the list as done in
vfio_container_instance_finalize(). This was seen with an SEV-SNP
guest for which discarding of RAM fails.

To resolve this issue, insert the container object into the address
space's container list earlier, just after it is created.

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: Eric Auger <eric.auger@redhat.com>
Fixes: 96b7af4388b3 ("vfio/container: Move vfio_container_destroy() to an instance_finalize() handler")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ccdb639ac84f885da40eace8a0059f397295619..b42466701bf13818b538483ec4c143ce6f83c598 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -618,6 +618,8 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
     bcontainer = &container->bcontainer;
 
+    vfio_address_space_insert(space, bcontainer);
+
     if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto free_container_exit;
     }
@@ -637,8 +639,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     vfio_kvm_device_add_group(group);
 
-    vfio_address_space_insert(space, bcontainer);
-
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
-- 
2.47.0


