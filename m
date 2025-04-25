Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFB7C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EiZ-0002nT-GY; Fri, 25 Apr 2025 04:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiM-0002kb-Tt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiK-0003DC-UK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJOF1w1PeJj5YFAydIBR1pLbDHKnDKjgoMMnTkRLmb4=;
 b=DICELZJ+O9MgRUWY+3NHxaYCOGm5USQwaIZvwX38OpcsIElJW9PYg2wFIzPIGHo/H89RhD
 Q8iCn9QCyq+UMhMIS1Cw2QwMCMHIB5Z7PVx/Esn9R2w8cAWV5nX4v0LzKoG8/eAmLx1WG4
 oxJYEWDoTi3hqTwdqhfG2ZflTV6Q/l0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-PFH2Y9BZPfOFD7jogej8bw-1; Fri,
 25 Apr 2025 04:47:10 -0400
X-MC-Unique: PFH2Y9BZPfOFD7jogej8bw-1
X-Mimecast-MFC-AGG-ID: PFH2Y9BZPfOFD7jogej8bw_1745570829
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BB1B1955DC5; Fri, 25 Apr 2025 08:47:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FC8330001A2; Fri, 25 Apr 2025 08:47:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, John Levon <john.levon@nutanix.com>
Subject: [PULL 05/50] vfio: Move vfio_mig_active() into migration.c
Date: Fri, 25 Apr 2025 10:45:58 +0200
Message-ID: <20250425084644.102196-6-clg@redhat.com>
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
index 5ef14931cd2dea6407999e6ef825c7376f212678..2ea4e12c902c05fd707f7cb471ea86a520a93f4f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -65,22 +65,6 @@ int vfio_kvm_device_fd = -1;
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


