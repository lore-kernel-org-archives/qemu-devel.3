Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309E0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNXz-0001k3-1h; Fri, 09 May 2025 09:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXh-0001hX-PL
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXf-0006v8-TG
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXb16+SWDtGTMqOFx7cd7siZrZEqo7VNKvbo7fCKcSs=;
 b=Lt2b7tRXm+DEfVBye0kTIa9OrR394h1G8k4cT+0kgEOiybrIZszYFN0H2KCDLZHDywCWil
 nloZ5GEEeUTcaoyvDRXkD4rGTxDGl/AF7iEd4wnINlNqFg9E7K+Q2zWReJGIqwgyCG64l5
 +IpSSjdWvvlS7+tVw3+DR8XTNXty65E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-GwMFvgVhNNKJwJFq-WEGcQ-1; Fri,
 09 May 2025 09:13:29 -0400
X-MC-Unique: GwMFvgVhNNKJwJFq-WEGcQ-1
X-Mimecast-MFC-AGG-ID: GwMFvgVhNNKJwJFq-WEGcQ_1746796409
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C183B1800264; Fri,  9 May 2025 13:13:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B49A818003FD; Fri,  9 May 2025 13:13:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Cedric Le Goater <clg@redhat.com>
Subject: [PULL 02/28] vfio/container: reform vfio_container_connect cleanup
Date: Fri,  9 May 2025 15:12:51 +0200
Message-ID: <20250509131317.164235-3-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

From: Steve Sistare <steven.sistare@oracle.com>

Replace the proliferation of exit labels in vfio_container_connect with
conditionals for cleaning each piece of state.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cedric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1746195760-101443-3-git-send-email-steven.sistare@oracle.com
[ clg: vfio_attach_discard_disable() -> vfio_container_attach_discard_disable() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 60 +++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2ea137fb024fedd2b8d578f2fb5a7eea2b11e4fa..4b2864cfa85d815fb67f2465b7544eb9de1664d3 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -563,9 +563,12 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 {
     VFIOContainer *container;
     VFIOContainerBase *bcontainer;
-    int ret, fd;
+    int ret, fd = -1;
     VFIOAddressSpace *space;
-    VFIOIOMMUClass *vioc;
+    VFIOIOMMUClass *vioc = NULL;
+    bool new_container = false;
+    bool group_was_added = false;
+    bool discard_disabled = false;
 
     space = vfio_address_space_get(as);
 
@@ -584,35 +587,37 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 
     fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     if (fd < 0) {
-        goto put_space_exit;
+        goto fail;
     }
 
     ret = ioctl(fd, VFIO_GET_API_VERSION);
     if (ret != VFIO_API_VERSION) {
         error_setg(errp, "supported vfio version: %d, "
                    "reported version: %d", VFIO_API_VERSION, ret);
-        goto close_fd_exit;
+        goto fail;
     }
 
     container = vfio_create_container(fd, group, errp);
     if (!container) {
-        goto close_fd_exit;
+        goto fail;
     }
+    new_container = true;
     bcontainer = &container->bcontainer;
 
     if (!vfio_cpr_register_container(bcontainer, errp)) {
-        goto free_container_exit;
+        goto fail;
     }
 
     if (!vfio_container_attach_discard_disable(container, group, errp)) {
-        goto unregister_container_exit;
+        goto fail;
     }
+    discard_disabled = true;
 
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto enable_discards_exit;
+        goto fail;
     }
 
     vfio_group_add_kvm_device(group);
@@ -621,35 +626,36 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    group_was_added = true;
 
     if (!vfio_listener_register(bcontainer, errp)) {
-        goto listener_release_exit;
+        goto fail;
     }
 
     bcontainer->initialized = true;
 
     return true;
-listener_release_exit:
-    QLIST_REMOVE(group, container_next);
-    vfio_group_del_kvm_device(group);
+
+fail:
     vfio_listener_unregister(bcontainer);
-    if (vioc->release) {
+
+    if (group_was_added) {
+        QLIST_REMOVE(group, container_next);
+        vfio_group_del_kvm_device(group);
+    }
+    if (vioc && vioc->release) {
         vioc->release(bcontainer);
     }
-
-enable_discards_exit:
-    vfio_ram_block_discard_disable(container, false);
-
-unregister_container_exit:
-    vfio_cpr_unregister_container(bcontainer);
-
-free_container_exit:
-    object_unref(container);
-
-close_fd_exit:
-    close(fd);
-
-put_space_exit:
+    if (discard_disabled) {
+        vfio_ram_block_discard_disable(container, false);
+    }
+    if (new_container) {
+        vfio_cpr_unregister_container(bcontainer);
+        object_unref(container);
+    }
+    if (fd >= 0) {
+        close(fd);
+    }
     vfio_address_space_put(space);
 
     return false;
-- 
2.49.0


