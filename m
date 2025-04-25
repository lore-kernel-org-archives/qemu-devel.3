Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12938C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ElV-0000to-Qd; Fri, 25 Apr 2025 04:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkM-0006zi-Pv
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkK-0003Mu-4g
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFAwmtqUTv3QoXjuA0B+bmPamh40DSZXEv1qN59o1zY=;
 b=Y77BJciigK8EfXFFtwtRgOe7EPon+VFDY6f49ONTSvl0VgTaRna788pKxqguheJ5N1toNM
 UbtkbGHTuARdDGRq9DMkkWmWE5DVpXqxFjRhHNTZ0bY0uDA5jA0BMAWjLIA/XL17ZmsUNe
 2c16KHS932rITC4g3/TYenXwspTa1go=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-F2WYfzbWP1GAyYJIWUh-ig-1; Fri,
 25 Apr 2025 04:49:15 -0400
X-MC-Unique: F2WYfzbWP1GAyYJIWUh-ig-1
X-Mimecast-MFC-AGG-ID: F2WYfzbWP1GAyYJIWUh-ig_1745570954
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 249461956089; Fri, 25 Apr 2025 08:49:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1013330001A2; Fri, 25 Apr 2025 08:49:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Donald Dutile <ddutile@redhat.com>
Subject: [PULL 45/50] vfio/container: Move realize() after attachment
Date: Fri, 25 Apr 2025 10:46:38 +0200
Message-ID: <20250425084644.102196-46-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

To match the change for IOMMUFD backend, move realize() after attachment
for legacy backend too.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Donald Dutile <ddutile@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250423072824.3647952-4-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 717774760393fd01df968cee97dde132936581ad..652a6197ceaff96399f16f4727ea3188eafec4dc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -883,10 +883,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
 
     trace_vfio_device_attach(vbasedev->name, groupid);
 
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        return false;
-    }
-
     group = vfio_group_get(groupid, as, errp);
     if (!group) {
         return false;
@@ -895,13 +891,15 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
             error_setg(errp, "device is already attached");
-            vfio_group_put(group);
-            return false;
+            goto group_put_exit;
         }
     }
     if (!vfio_device_get(group, name, vbasedev, errp)) {
-        vfio_group_put(group);
-        return false;
+        goto group_put_exit;
+    }
+
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        goto device_put_exit;
     }
 
     bcontainer = &group->container->bcontainer;
@@ -910,6 +908,12 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     return true;
+
+device_put_exit:
+    vfio_device_put(vbasedev);
+group_put_exit:
+    vfio_group_put(group);
+    return false;
 }
 
 static void vfio_legacy_detach_device(VFIODevice *vbasedev)
-- 
2.49.0


