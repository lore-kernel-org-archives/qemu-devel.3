Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7137FC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihD-0003h1-Tb; Wed, 22 May 2024 05:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih0-0003Xa-TU
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igy-0001j2-Nm
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3DTNO1j5SMlYNlsYmgdbbnL9vW6hJcpWt869udaP+g=;
 b=I/017pzUrfcBujMPWnfY+3Pdw6v4XSMMgcDFviPGzk603HWGwWWaOokby2lACziZnL/UNF
 GpHuuMXraVoVrJK4ZPGL1zd3Rjz9Ru6pQfZfqMJJqC8cgUh4poHEINjFCJbsUZrcL/k+Ae
 kAG1L+P/dygOqtO/I8xDBkQTTBbTJXY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-ZGwaFJV5PBSeCCJbnEFOdQ-1; Wed,
 22 May 2024 05:55:24 -0400
X-MC-Unique: ZGwaFJV5PBSeCCJbnEFOdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5607129AA3B4;
 Wed, 22 May 2024 09:55:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EEAF7412;
 Wed, 22 May 2024 09:55:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/47] vfio/container: Make vfio_connect_container() return bool
Date: Wed, 22 May 2024 11:54:19 +0200
Message-ID: <20240522095442.195243-25-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index f2e9560a1906c4151535260e3488ee80ca90e78b..802828ddff061fef25b8e4c997a68348d4be9892 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -536,8 +536,8 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
-                                  Error **errp)
+static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
+                                   Error **errp)
 {
     VFIOContainer *container;
     VFIOContainerBase *bcontainer;
@@ -589,19 +589,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                     error_report("vfio: error disconnecting group %d from"
                                  " container", group->groupid);
                 }
-                return ret;
+                return false;
             }
             group->container = container;
             QLIST_INSERT_HEAD(&container->group_list, group, container_next);
             vfio_kvm_device_add_group(group);
-            return 0;
+            return true;
         }
     }
 
     fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
-        ret = -errno;
         goto put_space_exit;
     }
 
@@ -609,7 +608,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     if (ret != VFIO_API_VERSION) {
         error_setg(errp, "supported vfio version: %d, "
                    "reported version: %d", VFIO_API_VERSION, ret);
-        ret = -EINVAL;
         goto close_fd_exit;
     }
 
@@ -636,7 +634,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     assert(bcontainer->ops->setup);
 
     if (!bcontainer->ops->setup(bcontainer, errp)) {
-        ret = -EINVAL;
         goto enable_discards_exit;
     }
 
@@ -652,7 +649,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
     if (bcontainer->error) {
-        ret = -1;
         error_propagate_prepend(errp, bcontainer->error,
             "memory listener initialization failed: ");
         goto listener_release_exit;
@@ -660,7 +656,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     bcontainer->initialized = true;
 
-    return 0;
+    return true;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
     QLIST_REMOVE(bcontainer, next);
@@ -685,7 +681,7 @@ close_fd_exit:
 put_space_exit:
     vfio_put_address_space(space);
 
-    return ret;
+    return false;
 }
 
 static void vfio_disconnect_container(VFIOGroup *group)
@@ -772,7 +768,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group->groupid = groupid;
     QLIST_INIT(&group->device_list);
 
-    if (vfio_connect_container(group, as, errp)) {
+    if (!vfio_connect_container(group, as, errp)) {
         error_prepend(errp, "failed to setup container for group %d: ",
                       groupid);
         goto close_fd_exit;
-- 
2.45.1


