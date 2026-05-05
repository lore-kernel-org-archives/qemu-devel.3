Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F15FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMM7-0004Pu-II; Tue, 05 May 2026 16:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM4-0004Op-Bi
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM2-0002be-EE
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEOh3+O8AjgnVMvq76LmGzcXnm5dygpEr/gRt4xF6/U=;
 b=a7u7/W2EQn29/n9zRRkjiJytCJWwW1MKcGc25kBesV2ALJ2wU01f/WQRDhxdpnyLisTrPN
 AShy9b2izg6Jgl3ZuWu1DbH3FjY2CsACwdMCsv/JLcyS+/1VvyfxD5f0KXw806CgZo9WZQ
 lpz4448SuifEYTjZo/bTiJRfRo6cqSM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-wBguDG--P2myM4yXKMogKQ-1; Tue, 05 May 2026 16:26:52 -0400
X-MC-Unique: wBguDG--P2myM4yXKMogKQ-1
X-Mimecast-MFC-AGG-ID: wBguDG--P2myM4yXKMogKQ_1778012812
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b640ede74bso102657056d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012811; x=1778617611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEOh3+O8AjgnVMvq76LmGzcXnm5dygpEr/gRt4xF6/U=;
 b=N/WAZRHj7cWi2uTa48x/mxthBuGhP+bjY10jQYA4C/C2ZLX5n2myWY18U0ZIBVjYHQ
 sXgkQUAm/s1m71f2EEE+BSNTUtK7BDpDFYyX68sjl1y3jNhCw1mYD2L0JDes/8MYODil
 YqYjRUprvD1/XCSXDzdvJXV4gRCKxMlhBvCXVBY95KFIoie3oEoQXYOBjBbkjAYppvao
 d2FVhvmOjYI+x7H+rhyZwaLr2LKh24yR120XFLAd0Tbqiak3vh0hgEVuTn9d6xaxP3QA
 sFu/3tazTBzjRKihmCo8aCKS+g6MgF1BF3QuwrG0H5Sdy823I1jfkXfQ9jeJ7y8ygeMQ
 hjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012811; x=1778617611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TEOh3+O8AjgnVMvq76LmGzcXnm5dygpEr/gRt4xF6/U=;
 b=B7cDPuROJmxD30sSuHPX5B5MNh4J4q/K9mX5pA3zN7MwpB8ZSUnNaRVX0dZu4bvhg4
 USKBzcNQQjtWJxwrB04f39p/8JfQvnZJcf+WMWnkxgdwOI5qKaMxv86JcLqEx776LMDT
 +NuXF4Rs1xoV5GTACdkasURxDYFrQ8Cer31o6XQTJkhYbvdcGOCM/eOpH+40Uad5rl58
 qZbZnlTFPDvV9eJCnDmZQnjHvBzFamMJxtjpA/rSKQMaNYFtP5hjYYvLic3lGu8CCmMR
 rQcivnB5T0sG293i6gEtvs8dSeTMvK6hIRwsXUvJo4NejPTbyhh64Jkk6oSClkR57UVM
 db8w==
X-Gm-Message-State: AOJu0YymWWUF3FTTp+yCdGYJDgHchRqsOBtrqREBkP94MTzD536/mijn
 cx1McBnNvxVTq3++mTTwr6I4zPQhNiYP6I1GXwHK0Inyy1WVOiBPFaT/yuXQU6Mcx7+E0haxtS2
 ko1xOPEPPkq2LtfAk3mWWscykT7j4Sdv7U3QQ0Lhfe+N/Tjm77ODeWI/7WBASiaejzvg8TbK5hU
 ACUDeBNYxXvJUQu5gKZdJ9/MfSW5PEO8T6KTrWDQ==
X-Gm-Gg: AeBDietXUskeCfXWtVgZ6KY+G7wOcMIwfoJPNvNMOPCy8L0U+LWDeYETsRhk4F6Datl
 R3qhr+RTu/O1LQlQEjpiJ1ywoJD5SAQJeU/KD8a22js0UfwmaqI+wrsiqI0Nmq2DFIXECptAMXl
 7ahfq6AYa/Das5elEP09JXrWECuEbVxgVzpGIqEzDLTP6U+sdMWRHI9hG/VYigitWfYyyhBEwN0
 cIuYzFLw+ms4bz9L4xcLXlpUEZrUWmn48qE5BXarYQ7O88qV6/+79HtUsyj4w2tjhMN4qikgEo9
 8EqBRS/Dpa6ZQ66edH8pjWY8LP1sRUpoPL3/iPJ1Y/umwrwgLzQ/xreSg2RQ7ZnCTaqX22C6apU
 ZdCw+T6ZZ//GPXGLKg/Hc9StrnCznKANTMAyKjD0XCTohk4at8k2ymKM=
X-Received: by 2002:ad4:5c8b:0:b0:8b7:f29b:81ee with SMTP id
 6a1803df08f44-8bc45465c5fmr3800846d6.33.1778012811448; 
 Tue, 05 May 2026 13:26:51 -0700 (PDT)
X-Received: by 2002:ad4:5c8b:0:b0:8b7:f29b:81ee with SMTP id
 6a1803df08f44-8bc45465c5fmr3800016d6.33.1778012810759; 
 Tue, 05 May 2026 13:26:50 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 06/23] vfio/migration: Cache stop size in VFIOMigration
Date: Tue,  5 May 2026 16:26:23 -0400
Message-ID: <20260505202640.1011006-7-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/r/20260421202110.306051-5-peterx@redhat.com
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


