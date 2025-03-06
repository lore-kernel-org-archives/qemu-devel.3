Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF16C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC4M-0004xH-3l; Thu, 06 Mar 2025 09:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC2A-00014Z-T1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC28-0002B5-V5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9csUtQRcZmArM3bAaUsw3uaSxuokMjwDwmzHM3/r20=;
 b=VBXr1WZgFw0bACXEIl2HdJLcVb7BOM1u0bQcogDxMlsoF7R8AnTFin8+NCreQlFC943Plb
 vJQ4ndktvJvsXwy3ATR3toVw4zzQkMP2aoajP3gi0Ybh1QbRqfPwkZzxofJyDxRdSjVD0g
 Gkgd5DEPD2vFeGaNp+2sw69t4jKkz10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-yohFUGqtPiW0WZntNgfejw-1; Thu,
 06 Mar 2025 09:16:17 -0500
X-MC-Unique: yohFUGqtPiW0WZntNgfejw-1
X-Mimecast-MFC-AGG-ID: yohFUGqtPiW0WZntNgfejw_1741270576
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 976441955DC0; Thu,  6 Mar 2025 14:16:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F338418001D3; Thu,  6 Mar 2025 14:16:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 38/42] vfio/migration: Multifd device state transfer support -
 config loading support
Date: Thu,  6 Mar 2025 15:14:14 +0100
Message-ID: <20250306141419.2015340-39-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Load device config received via multifd using the existing machinery
behind vfio_load_device_config_state().

Also, make sure to process the relevant main migration channel flags.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/5dbd3f3703ec1097da2cf82a7262233452146fee.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/migration-multifd.c   | 49 +++++++++++++++++++++++++++++++++--
 hw/vfio/migration.c           |  9 ++++++-
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 40382390692dcd772f2ceb6689d9b31dc5e8b8d5..9d72ac1eae8a50e06f32d1c46332c9fd3adddce2 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -298,6 +298,8 @@ void vfio_mig_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
+int vfio_load_device_config_state(QEMUFile *f, void *opaque);
+
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 2eef27604e4f8f1f4db74d132a4d4bf2906a4cc1..1d81233c755fec825d94c040ff6cf87eb6551f01 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -17,6 +17,7 @@
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "qemu/thread.h"
+#include "io/channel-buffer.h"
 #include "migration/qemu-file.h"
 #include "migration-multifd.h"
 #include "trace.h"
@@ -193,8 +194,52 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
 static bool vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
                                               Error **errp)
 {
-    error_setg(errp, "not yet there");
-    return false;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    VFIOStateBuffer *lb;
+    g_autoptr(QIOChannelBuffer) bioc = NULL;
+    g_autoptr(QEMUFile) f_out = NULL, f_in = NULL;
+    uint64_t mig_header;
+    int ret;
+
+    assert(multifd->load_buf_idx == multifd->load_buf_idx_last);
+    lb = vfio_state_buffers_at(&multifd->load_bufs, multifd->load_buf_idx);
+    assert(lb->is_present);
+
+    bioc = qio_channel_buffer_new(lb->len);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
+
+    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
+    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
+
+    ret = qemu_fflush(f_out);
+    if (ret) {
+        error_setg(errp, "%s: load config state flush failed: %d",
+                   vbasedev->name, ret);
+        return false;
+    }
+
+    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
+    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
+
+    mig_header = qemu_get_be64(f_in);
+    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
+        error_setg(errp, "%s: expected FLAG_DEV_CONFIG_STATE but got %" PRIx64,
+                   vbasedev->name, mig_header);
+        return false;
+    }
+
+    bql_lock();
+    ret = vfio_load_device_config_state(f_in, vbasedev);
+    bql_unlock();
+
+    if (ret < 0) {
+        error_setg(errp, "%s: vfio_load_device_config_state() failed: %d",
+                   vbasedev->name, ret);
+        return false;
+    }
+
+    return true;
 }
 
 static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 815ad8fc93c7155d831838f9ccfcfd1955e588bc..2ca3fa08d48667e1c338d3e148023afed7251ac4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -264,7 +264,7 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
     return ret;
 }
 
-static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
+int vfio_load_device_config_state(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
     uint64_t data;
@@ -723,6 +723,13 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
         switch (data) {
         case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
         {
+            if (vfio_multifd_transfer_enabled(vbasedev)) {
+                error_report("%s: got DEV_CONFIG_STATE in main migration "
+                             "channel but doing multifd transfer",
+                             vbasedev->name);
+                return -EINVAL;
+            }
+
             return vfio_load_device_config_state(f, opaque);
         }
         case VFIO_MIG_FLAG_DEV_SETUP_STATE:
-- 
2.48.1


