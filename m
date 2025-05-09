Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440B1C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNXx-0001j9-IV; Fri, 09 May 2025 09:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXg-0001hJ-RG
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXf-0006uL-5y
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2pHcWRzgK7CfAVlWHGCaEKN81lEH/YxskuMde7uZqg=;
 b=ZwrmTCEWfPRfKY14gHJBrURRmtwtbAVO9QApH5wn8CRUZSqHA/24Lbp6hsKdwNayKJy/mK
 qYJu9RLRZxKZ/b9BRljDEws72pqqACPgYKBezyimMJ4TLbTUfSvfuKBTjW1+kh1xCLkoTR
 mpF24qubx90w7W/7fog5r4lRfTToe+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Acf_IxVpPuebjhtLHM2kIA-1; Fri,
 09 May 2025 09:13:26 -0400
X-MC-Unique: Acf_IxVpPuebjhtLHM2kIA-1
X-Mimecast-MFC-AGG-ID: Acf_IxVpPuebjhtLHM2kIA_1746796406
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEE1B19560BB; Fri,  9 May 2025 13:13:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D17C51800EC9; Fri,  9 May 2025 13:13:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Cedric Le Goater <clg@redhat.com>
Subject: [PULL 01/28] vfio/container: ram discard disable helper
Date: Fri,  9 May 2025 15:12:50 +0200
Message-ID: <20250509131317.164235-2-clg@redhat.com>
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

Define a helper to set ram discard disable, generate error messages,
and cleanup on failure.  The second vfio_ram_block_discard_disable
call site now performs VFIO_GROUP_UNSET_CONTAINER immediately on failure,
instead of relying on the close of the container fd to do so in the kernel,
but this is equivalent.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cedric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1746195760-101443-2-git-send-email-steven.sistare@oracle.com
[ clg: vfio_attach_discard_disable() -> vfio_container_attach_discard_disable() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 48 +++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77ff56b43f0a906167a3c7c8d8ae6376552762f7..2ea137fb024fedd2b8d578f2fb5a7eea2b11e4fa 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -511,16 +511,10 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
-                                   Error **errp)
+static bool vfio_container_attach_discard_disable(VFIOContainer *container,
+                                            VFIOGroup *group, Error **errp)
 {
-    VFIOContainer *container;
-    VFIOContainerBase *bcontainer;
-    int ret, fd;
-    VFIOAddressSpace *space;
-    VFIOIOMMUClass *vioc;
-
-    space = vfio_address_space_get(as);
+    int ret;
 
     /*
      * VFIO is currently incompatible with discarding of RAM insofar as the
@@ -553,18 +547,32 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
      * details once we know which type of IOMMU we are using.
      */
 
+    ret = vfio_ram_block_discard_disable(container, true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER, &container->fd)) {
+            error_report("vfio: error disconnecting group %d from"
+                         " container", group->groupid);
+        }
+    }
+    return !ret;
+}
+
+static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
+                                   Error **errp)
+{
+    VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
+    int ret, fd;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            ret = vfio_ram_block_discard_disable(container, true);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "Cannot set discarding of RAM broken");
-                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
-                          &container->fd)) {
-                    error_report("vfio: error disconnecting group %d from"
-                                 " container", group->groupid);
-                }
+            if (!vfio_container_attach_discard_disable(container, group, errp)) {
                 return false;
             }
             group->container = container;
@@ -596,9 +604,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
-    ret = vfio_ram_block_discard_disable(container, true);
-    if (ret) {
-        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+    if (!vfio_container_attach_discard_disable(container, group, errp)) {
         goto unregister_container_exit;
     }
 
-- 
2.49.0


