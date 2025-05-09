Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66486C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNY0-0001kq-6p; Fri, 09 May 2025 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXo-0001hw-Mc
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXk-0006x3-U0
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMnZaqscNTKV+8L0HlcgKdjLzi6vxS856e3Tmw05Uv8=;
 b=WY+GCmutpurQL1nx+T2NBIyKNs/8sX/w6mhITV9CleOJoCRul3sSEFUr+q6mIaCEy1HEe9
 4AXVylW3LHTk0jzoVIVe3lteTDGKRG1xh0sm0hfo59Y1RrQ5R2ds6z4y4RZLTDgGphS7Tx
 zeiP5KZlqHWxlQgaRNHcRjIbza1xw5s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-gSywlvffPd20ncnU1qbnVA-1; Fri,
 09 May 2025 09:13:32 -0400
X-MC-Unique: gSywlvffPd20ncnU1qbnVA-1
X-Mimecast-MFC-AGG-ID: gSywlvffPd20ncnU1qbnVA_1746796411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D441195608B; Fri,  9 May 2025 13:13:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D2FE180045B; Fri,  9 May 2025 13:13:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Cedric Le Goater <clg@redhat.com>
Subject: [PULL 03/28] vfio/container: vfio_container_group_add
Date: Fri,  9 May 2025 15:12:52 +0200
Message-ID: <20250509131317.164235-4-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Add vfio_container_group_add to de-dup some code.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cedric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1746195760-101443-4-git-send-email-steven.sistare@oracle.com
[ clg: vfio_attach_discard_disable() -> vfio_container_attach_discard_disable() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 47 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4b2864cfa85d815fb67f2465b7544eb9de1664d3..a761f0958b71de39093d8849b49c55e3662e096f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -558,6 +558,26 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
     return !ret;
 }
 
+static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
+                                     Error **errp)
+{
+    if (!vfio_container_attach_discard_disable(container, group, errp)) {
+        return false;
+    }
+    group->container = container;
+    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    vfio_group_add_kvm_device(group);
+    return true;
+}
+
+static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
+{
+    QLIST_REMOVE(group, container_next);
+    group->container = NULL;
+    vfio_group_del_kvm_device(group);
+    vfio_ram_block_discard_disable(container, false);
+}
+
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
@@ -568,20 +588,13 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     VFIOIOMMUClass *vioc = NULL;
     bool new_container = false;
     bool group_was_added = false;
-    bool discard_disabled = false;
 
     space = vfio_address_space_get(as);
 
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            if (!vfio_container_attach_discard_disable(container, group, errp)) {
-                return false;
-            }
-            group->container = container;
-            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
-            vfio_group_add_kvm_device(group);
-            return true;
+            return vfio_container_group_add(container, group, errp);
         }
     }
 
@@ -608,11 +621,6 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
 
-    if (!vfio_container_attach_discard_disable(container, group, errp)) {
-        goto fail;
-    }
-    discard_disabled = true;
-
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
@@ -620,12 +628,11 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
 
-    vfio_group_add_kvm_device(group);
-
     vfio_address_space_insert(space, bcontainer);
 
-    group->container = container;
-    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    if (!vfio_container_group_add(container, group, errp)) {
+        goto fail;
+    }
     group_was_added = true;
 
     if (!vfio_listener_register(bcontainer, errp)) {
@@ -640,15 +647,11 @@ fail:
     vfio_listener_unregister(bcontainer);
 
     if (group_was_added) {
-        QLIST_REMOVE(group, container_next);
-        vfio_group_del_kvm_device(group);
+        vfio_container_group_del(container, group);
     }
     if (vioc && vioc->release) {
         vioc->release(bcontainer);
     }
-    if (discard_disabled) {
-        vfio_ram_block_discard_disable(container, false);
-    }
     if (new_container) {
         vfio_cpr_unregister_container(bcontainer);
         object_unref(container);
-- 
2.49.0


