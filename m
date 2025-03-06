Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E568C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC3s-0003BY-6j; Thu, 06 Mar 2025 09:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1U-0000lf-9M
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1S-00025e-8V
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tE6LKSxXlL5BjHPli5rp4ZzG1kP0l59yDZWkLvT/qs=;
 b=gEj+rz9rCFkj3nUPh+KSjIycEX6kmt+Zf4BQOHaWmWVAspBgPB4SMQkZVRzTZV+BZqgWB2
 I/XDDPBdjsEvjGBWdv7SVyKVCGOwaRK1qS2ygIlQXgzHIE8nfsgafR3RsrmcRF+s7jq0MH
 GlTpsi1tWboAzxavRE/G7JTGS6zMtUo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-zH1qSnrdPB6958rPOerx6Q-1; Thu,
 06 Mar 2025 09:16:04 -0500
X-MC-Unique: zH1qSnrdPB6958rPOerx6Q-1
X-Mimecast-MFC-AGG-ID: zH1qSnrdPB6958rPOerx6Q_1741270564
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11AA41955EF4; Thu,  6 Mar 2025 14:16:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F17DD18009BC; Thu,  6 Mar 2025 14:16:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/42] vfio/migration: Multifd setup/cleanup functions and
 associated VFIOMultifd
Date: Thu,  6 Mar 2025 15:14:09 +0100
Message-ID: <20250306141419.2015340-34-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Add multifd setup/cleanup functions and an associated VFIOMultifd data
structure that will contain most of the receive-side data together
with its init/cleanup methods.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/c0520523053b1087787152ddf2163257d3030be0.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration-multifd.h   |  4 ++++
 include/hw/vfio/vfio-common.h |  3 +++
 hw/vfio/migration-multifd.c   | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 1b60d5f67a1c76cdac21d71a7fb7335f4e194ffe..2a7a76164f291d182172775524a5b11c0a560c58 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -14,6 +14,10 @@
 
 #include "hw/vfio/vfio-common.h"
 
+bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp);
+void vfio_multifd_cleanup(VFIODevice *vbasedev);
+
 bool vfio_multifd_transfer_supported(void);
+bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 
 #endif
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bf5d5208712925f140e55583a2c0fe216184d046..40382390692dcd772f2ceb6689d9b31dc5e8b8d5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -78,6 +78,8 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+typedef struct VFIOMultifd VFIOMultifd;
+
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
@@ -89,6 +91,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    VFIOMultifd *multifd;
     bool initial_data_sent;
 
     bool event_save_iterate_started;
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 79fae0b6296f9244317ed5215e4950703c45a717..091dc43210ad1459d5114da18336e73f6cb0baf9 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -32,8 +32,52 @@ typedef struct VFIODeviceStatePacket {
     uint8_t data[0];
 } QEMU_PACKED VFIODeviceStatePacket;
 
+typedef struct VFIOMultifd {
+} VFIOMultifd;
+
+static VFIOMultifd *vfio_multifd_new(void)
+{
+    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
+
+    return multifd;
+}
+
+static void vfio_multifd_free(VFIOMultifd *multifd)
+{
+    g_free(multifd);
+}
+
+void vfio_multifd_cleanup(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    g_clear_pointer(&migration->multifd, vfio_multifd_free);
+}
+
 bool vfio_multifd_transfer_supported(void)
 {
     return multifd_device_state_supported() &&
         migrate_send_switchover_start();
 }
+
+bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
+{
+    return false;
+}
+
+bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (!vfio_multifd_transfer_enabled(vbasedev)) {
+        /* Nothing further to check or do */
+        return true;
+    }
+
+    if (alloc_multifd) {
+        assert(!migration->multifd);
+        migration->multifd = vfio_multifd_new();
+    }
+
+    return true;
+}
-- 
2.48.1


