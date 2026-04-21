Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E633F94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbC-0000yE-QX; Tue, 21 Apr 2026 16:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb3-0000wR-Fd
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb1-0008M3-3l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbQkWYzWJZ1O2pLi9yPiyFUNUWcVz6fI8AXsfo7wY1s=;
 b=AGZv7/xvKsSGsMKKvV3wgfPJj6ALuqXRMIKbGlqCn2tA6n0E0orHKsq0n2H/Fyz/IiU7mJ
 do9ooaLEHDmCnRYvIyU30cKwSjZdprmb5+IyFETIoY0l1doxxbTF/mXibpDjKFxJTHq4Be
 P/9dL24DDP4czrpUNKnYDzAY6jAP9zc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-qgbagd24OwCFHrYoiY79lQ-1; Tue, 21 Apr 2026 16:21:21 -0400
X-MC-Unique: qgbagd24OwCFHrYoiY79lQ-1
X-Mimecast-MFC-AGG-ID: qgbagd24OwCFHrYoiY79lQ_1776802881
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ac9609d3d6so123117436d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802880; x=1777407680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbQkWYzWJZ1O2pLi9yPiyFUNUWcVz6fI8AXsfo7wY1s=;
 b=NcjKn/ITK6k1XdFp+U/VdSl9W7IwwmjJKCYGSvTCdfT+tpe1B3GRVM+3+LtbuADgEw
 AtHvIPBaceU+Nffau9orxVjgb5HseNjymryaEjLrUgAr7nut3PHkLxBkJFlvm6CFyhNv
 x90iLiMtgaqowmXTblq3DDBSxccHNxU4HCgQPTsrzJhkwnzA4tBNPfVbxwK5dQXltOye
 rnvcQh5bUZUiJ1PpMFjk3joTLNKX4KIMvL+vn4at2nB8MQZLeHtpuXDcdkTVQbnYS0qn
 8gmix8cwkQhS9KJxhwC3q2szSw7ZPLlx2gFk4MOoW3r2Xy8KRkE5xUA765ANZQsOeWgs
 szDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802880; x=1777407680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TbQkWYzWJZ1O2pLi9yPiyFUNUWcVz6fI8AXsfo7wY1s=;
 b=bGPvRmW02NyD1/jJnmPS0BRLh3tvyZpd+8Hzy7iDx9uNoKmDNwBbjMo+/nkjTelG/9
 PetrqoMwLkOjkNT6TgAyrSX8WaSriLPCvFidSfJWFaVwfTVOyDLcLhapTdk/moj+2Kof
 8dAED5Wgc5DhAQmAwq5xZBIOoNljBW05fuqIT7+A35r7M0YEg2TMOJrdY0ZZYha6yf0G
 DIxg2XCjm1vmPMfbpHY9e6ygG9UQXnS7k0P9ZwMHcsefL/LKALJDPAo24IEKmwLcIMr6
 iyQwDjH7o+besi1GRyhw8FobhczWhAc7ck/REV1MBA/Ywk0mrRlje/JGFFhyDp0yGnvf
 K0Yw==
X-Gm-Message-State: AOJu0YyMyn9SK3NrARsrQgiFPfHgU2wNCFtcedRKOYnvlWDTgurj28Pn
 e/FePyOH73WYJVIK3geW0gHWdu2C6h5NZg5beaZl6G+NpZ9D7wClVtgk9/jewmH5gGBKMff2LMi
 YHrQMUoulj5/ARWd+SdGJJ017uPEs3sSPjDZWO5/sATQK4edPtKe23o48NUggIAbGfN0t8X2W+v
 dyb3w806d237S+vH0P3A2r48z0K9DUipaqKEICvA==
X-Gm-Gg: AeBDieuYfGSRvmwNCRIedepyDfF48Eg0cteQ6evtyAm2Upg98lsOt2YNfPYydcEB7HP
 bToIHgEFtPSyYipmwcPywz+rVVqaPNXRAglBHiyPiEqWzSM9tWvNZUWCReuxuKBtNKVCDY2h7TU
 k5NGEAm1DaU2NgoFkGcYhftSSPq7Yf7nj3zTiemUdDye2qFQjLyno5w/CpgIHM0cGcO25dBi1OO
 wpuFcy29kCikmmivKJGuUsEQdBRnf5ao5j8O71hIxF4O3sBmsicMKCaOwIwqx275oD7rdu/Ij34
 qIeQIIXK6l5tZmmB8C8CVi0sttFVAhnv0wA0dGyMjhW6wx4nPctLOaYYg70fE2gM+qDkVwbdIgj
 cd1+3gJibdBwS9C1MVRQsd4DfmKlvZbKIeIG4rLMQNVrBEzmwxfS98U1doA==
X-Received: by 2002:a05:6214:cc1:b0:8ac:af40:53d5 with SMTP id
 6a1803df08f44-8b02810fc05mr298319026d6.34.1776802879974; 
 Tue, 21 Apr 2026 13:21:19 -0700 (PDT)
X-Received: by 2002:a05:6214:cc1:b0:8ac:af40:53d5 with SMTP id
 6a1803df08f44-8b02810fc05mr298318086d6.34.1776802879194; 
 Tue, 21 Apr 2026 13:21:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 04/16] vfio/migration: Cache stop size in VFIOMigration
Date: Tue, 21 Apr 2026 16:20:58 -0400
Message-ID: <20260421202110.306051-5-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a field to cache stop size.  Note that there's an initial value change
in vfio_save_setup for the stop size default, but it shouldn't matter if it
is followed with a math of MIN() against VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE.

Document that all the three sizes we read from VFIO's uAPI on dirty or stop
sizes are estimates, so QEMU needs to always remember they can be anything.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/vfio-migration-internal.h |  8 +++++
 hw/vfio/migration.c               | 50 ++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index 814fbd9eba..a15fc74703 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -45,8 +45,16 @@ typedef struct VFIOMigration {
     void *data_buffer;
     size_t data_buffer_size;
     uint64_t mig_flags;
+    /*
+     * NOTE: all three sizes cached are reported from VFIO's uAPI, which
+     * are defined as estimate only.  QEMU should not trust these values
+     * but only use them to do best-effort estimates.  Always be prepared
+     * that these sizes may either grow or even shrink in reality while
+     * read()ing from the VFIO fds.
+     */
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    uint64_t stopcopy_size;
     bool multifd_transfer;
     VFIOMultifd *multifd;
     bool initial_data_sent;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 83327b6573..5d5fca09bd 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -41,6 +41,12 @@
  */
 #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
 
+/*
+ * Migration size of VFIO devices can be as little as a few KBs or as big as
+ * many GBs. This value should be big enough to cover the worst case.
+ */
+#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
+
 static unsigned long bytes_transferred;
 
 static const char *mig_state_to_str(enum vfio_device_mig_state state)
@@ -314,8 +320,7 @@ static void vfio_migration_cleanup(VFIODevice *vbasedev)
     migration->data_fd = -1;
 }
 
-static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
-                                     uint64_t *stop_copy_size)
+static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
                               sizeof(struct vfio_device_feature_mig_data_size),
@@ -323,16 +328,22 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
     struct vfio_device_feature_mig_data_size *mig_data_size =
         (struct vfio_device_feature_mig_data_size *)feature->data;
+    VFIOMigration *migration = vbasedev->migration;
 
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIG_DATA_SIZE;
 
     if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        /*
+         * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE
+         * is reported so downtime limit won't be violated.
+         */
+        migration->stopcopy_size = VFIO_MIG_STOP_COPY_SIZE;
         return -errno;
     }
 
-    *stop_copy_size = mig_data_size->stop_copy_length;
+    migration->stopcopy_size = mig_data_size->stop_copy_length;
 
     return 0;
 }
@@ -409,6 +420,16 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
         return;
     }
 
+    /*
+     * The total size remaining requires separate accounting.  Do not trust
+     * the counter, so what we have read() may be more than what reported.
+     */
+    if (migration->stopcopy_size > data_size) {
+        migration->stopcopy_size -= data_size;
+    } else {
+        migration->stopcopy_size = 0;
+    }
+
     if (migration->precopy_init_size) {
         uint64_t init_size = MIN(migration->precopy_init_size, data_size);
 
@@ -463,7 +484,6 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
-    uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
     int ret;
 
     if (!vfio_multifd_setup(vbasedev, false, errp)) {
@@ -472,9 +492,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
-    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
+    vfio_query_stop_copy_size(vbasedev);
     migration->data_buffer_size = MIN(VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE,
-                                      stop_copy_size);
+                                      migration->stopcopy_size);
     migration->data_buffer = g_try_malloc0(migration->data_buffer_size);
     if (!migration->data_buffer) {
         error_setg(errp, "%s: Failed to allocate migration data buffer",
@@ -570,32 +590,22 @@ static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
                                       migration->precopy_dirty_size);
 }
 
-/*
- * Migration size of VFIO devices can be as little as a few KBs or as big as
- * many GBs. This value should be big enough to cover the worst case.
- */
-#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
-
 static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
                                      uint64_t *can_postcopy)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
-    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
 
-    /*
-     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
-     * reported so downtime limit won't be violated.
-     */
-    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
-    *must_precopy += stop_copy_size;
+    vfio_query_stop_copy_size(vbasedev);
+    *must_precopy += migration->stopcopy_size;
 
     if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
     }
 
     trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-                                   stop_copy_size, migration->precopy_init_size,
+                                   migration->stopcopy_size,
+                                   migration->precopy_init_size,
                                    migration->precopy_dirty_size);
 }
 
-- 
2.53.0


