Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7542C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G5o-0007JW-ME; Tue, 22 Apr 2025 12:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G59-0006hT-BK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G56-0004yi-5w
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDIEsKmP9mFPEjs+M92SCWVMUEYou2w4kL6FSaKnWAI=;
 b=jGW1jJosVqDzH3ahHk39sggUBqnsuatrQHYeQMEe7hsFvXfqXYz/XyQZVi99YR6MOpqjOJ
 pxrgI2pBGxdTvemDrZupdpdKZoUf50eQIIGxkI0CTwTDAZtc2CqCY+i5ZvPM1zrmtkdG1M
 9QxKwK2V3Jcx6Gugo0zupfaj7SaGbg4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-eW05Eq8gNJGh4-sMIeJx7w-1; Tue,
 22 Apr 2025 12:02:36 -0400
X-MC-Unique: eW05Eq8gNJGh4-sMIeJx7w-1
X-Mimecast-MFC-AGG-ID: eW05Eq8gNJGh4-sMIeJx7w_1745337755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D388E1955D86; Tue, 22 Apr 2025 16:02:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D12E18001DD; Tue, 22 Apr 2025 16:02:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 01/37] vfio: Move vfio_mig_active() into migration.c
Date: Tue, 22 Apr 2025 18:01:48 +0200
Message-ID: <20250422160224.199714-2-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

vfio_mig_active() is part of the VFIO migration API. Move the
definitions where VFIO migration is implemented.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-2-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c    | 16 ----------------
 hw/vfio/migration.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a591ce5b97ff41cdc8249e9eeafc8dc347d45fac..e0482a796ff89afae2f017ae4e87f6f4056328fe 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -66,22 +66,6 @@ int vfio_kvm_device_fd = -1;
  * Device state interfaces
  */
 
-bool vfio_mig_active(void)
-{
-    VFIODevice *vbasedev;
-
-    if (QLIST_EMPTY(&vfio_device_list)) {
-        return false;
-    }
-
-    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->migration_blocker) {
-            return false;
-        }
-    }
-    return true;
-}
-
 static Error *multiple_devices_migration_blocker;
 
 /*
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index fbff46cfc35e0ee69e9599c9f8efc7437bbe3370..b5fb0d218808d010d8210612d3182dde8f33514b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1062,6 +1062,22 @@ void vfio_mig_add_bytes_transferred(unsigned long val)
     qatomic_add(&bytes_transferred, val);
 }
 
+bool vfio_mig_active(void)
+{
+    VFIODevice *vbasedev;
+
+    if (QLIST_EMPTY(&vfio_device_list)) {
+        return false;
+    }
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
+        if (vbasedev->migration_blocker) {
+            return false;
+        }
+    }
+    return true;
+}
+
 /*
  * Return true when either migration initialized or blocker registered.
  * Currently only return false when adding blocker fails which will
-- 
2.49.0


