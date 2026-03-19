Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC41091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYM-0001NI-6E; Thu, 19 Mar 2026 19:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYL-0001N8-1R
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYJ-0001Pw-Ar
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773961998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6xO5KlK8X7T9dIvIeNyHDMz8xdJ4Fx4esbGShwNklI=;
 b=ERHvpJO6R8gH/IGU3syxVwIV6V9dXEcQK0nUpahXXZEamHGPud2ZX5C2OgZeobClcuvHzv
 EC27HiZ3FmfXt13imxsPEbstgWHbl8oiUJiUM0ZQmGmEART4zKDtRnPBYfkdkCO/jnbOaD
 bn1uZfcVv4apvddVNuYv24uYC1GM/Xg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Wow8rfqkMNmvIh2ID-IQqg-1; Thu, 19 Mar 2026 19:13:17 -0400
X-MC-Unique: Wow8rfqkMNmvIh2ID-IQqg-1
X-Mimecast-MFC-AGG-ID: Wow8rfqkMNmvIh2ID-IQqg_1773961997
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5091f12ed3bso2799461cf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773961996; x=1774566796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6xO5KlK8X7T9dIvIeNyHDMz8xdJ4Fx4esbGShwNklI=;
 b=T8VWZgPP3Jg2xGqr64pvjvSgRHN8e8SO8d+bvKahPMogsFlAxyQoLp5EVrekLlxate
 z482gGOlMO72tCxu9EzlDYvAExu1vEu+V4KbuC7V4JqxaoYBah2WciyZ1R1ZVJACd4ra
 z3s4fgM4TMdPvEKqnEuj0ibotTBN4fmIKYxuALy6kCL8DQtFKrxJMdQM66gRi1QluuT3
 GTEmXVdnwvZL3sCUbc2RpOui85pXxjKcrHINICPU1Y1LZJeBCTLiSVbW+/Gd6zQaCgfu
 fwiKxQ9rr3FKocqnhrxgnEK9Xi5RXHJrtYDNPK5Z0EAW7KoXtehFcmEZPjnC73wziT0F
 gZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773961996; x=1774566796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V6xO5KlK8X7T9dIvIeNyHDMz8xdJ4Fx4esbGShwNklI=;
 b=AUkWDUukuqidwwsy9pJ+GhLmkn6V2oewQsDBHAsI27ZhCQI2gl+VWGG5nJyXT+2fo+
 BJuy1vPmZqBH3uG+oiyHaLNiqm6+m1oB/jQl8mr5+bSLXI9F6gavnl7wRUNEMbrqh1+5
 Ju8fqgWWxV9HqVio/JM4MeU4iA7bbysIFRYHAPk4L+kkF9yELWnS/7Igh+ipdFhu7WDK
 xNKQXr9ippOqRHejW5vzApDhV8tRA6iVT4HYJIMyjoiYJuCSWcfCXnFk/uoVKc3gTD8F
 be3ZRDJY/LPTV2XverPmfU4zhX3zeIKhlbOWJYHmGFI4vy8QunZ376emAkzMEMHQ/88U
 kc5w==
X-Gm-Message-State: AOJu0YyHd86JmxBwDDhL0a0UJkyPr8T9PTVNNu+Ukbsk/wtLjgdKvKWk
 JQI3OKHfbd7GZYsRi/5D5SwZYnEJMikCFTUkAQ+xRirAkDybEMEwg69L2pE6bqEmyFCa8uOOTbJ
 Y0BGO7B572qIAs5clYJ9ZckX67M83ZldoZep4Y70QLFl8h8ZTGp2w8bGeCVqzBD3Z2k+fT0foJf
 yPt7uqrCXIYCamabYuqVnagzJRKYQgm4+7lvYHxg==
X-Gm-Gg: ATEYQzwl/Od9ZLUZFnNev9UhmkZdIypqrl3nguW4/XeDZzWIp3xsI4U8pvzvtb3ZAPO
 g3TdsbPdUdgKsCZItjWfewYGpnQrle15H4zRZ4qWRKRjVgLkmdDq+tXspQHZolv1jLPLCpTksje
 eVAC0m2mJ19n/UcnR75n+ChaG0JBWw/AOiOkGNyEIHYUo0LIh45n/Ig9xxO6WT/87DBYXNS9OD4
 x1SKJbQDu8+KcRUBXoJDvsMZDt1BUi893VrZnbD//kRwI+VdyWEE32P83hLmgd8V+arIzGS9Czv
 TjgYmI6WYAVBBxfTj8UQ4yRXZM9ujTAiGqjyGZQqZAEVSBvE+z2zUFQ+qiAl3/U3u5jJJV64bri
 xPxe9h4lf9yuH1g==
X-Received: by 2002:a05:622a:178f:b0:509:bdb:1539 with SMTP id
 d75a77b69052e-50b3744891emr17086981cf.23.1773961996385; 
 Thu, 19 Mar 2026 16:13:16 -0700 (PDT)
X-Received: by 2002:a05:622a:178f:b0:509:bdb:1539 with SMTP id
 d75a77b69052e-50b3744891emr17086521cf.23.1773961995839; 
 Thu, 19 Mar 2026 16:13:15 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH RFC 04/12] vfio/migration: Cache stop size in VFIOMigration
Date: Thu, 19 Mar 2026 19:12:54 -0400
Message-ID: <20260319231302.123135-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/vfio-migration-internal.h |  1 +
 hw/vfio/migration.c               | 43 +++++++++++++++++--------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index 814fbd9eba..08df32c055 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -47,6 +47,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    uint64_t stopcopy_size;
     bool multifd_transfer;
     VFIOMultifd *multifd;
     bool initial_data_sent;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 851ea783f3..827d3ded63 100644
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
@@ -415,6 +426,9 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
         return;
     }
 
+    /* The total size remaining requires separate accounting */
+    migration->stopcopy_size -= data_size;
+
     if (migration->precopy_init_size) {
         uint64_t init_size = MIN(migration->precopy_init_size, data_size);
 
@@ -469,7 +483,6 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
-    uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
     int ret;
 
     if (!vfio_multifd_setup(vbasedev, false, errp)) {
@@ -478,9 +491,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
-    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
+    vfio_query_stop_copy_size(vbasedev);
     migration->data_buffer_size = MIN(VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE,
-                                      stop_copy_size);
+                                      migration->stopcopy_size);
     migration->data_buffer = g_try_malloc0(migration->data_buffer_size);
     if (!migration->data_buffer) {
         error_setg(errp, "%s: Failed to allocate migration data buffer",
@@ -576,32 +589,22 @@ static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
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
2.50.1


