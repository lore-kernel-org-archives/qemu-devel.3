Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2FBCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 09:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN6A1-0003vg-E8; Wed, 13 May 2026 05:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wN69r-0003vH-KM
 for qemu-devel@nongnu.org; Wed, 13 May 2026 05:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wN69l-0006XQ-Bj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 05:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778665531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Px2dUMgeLu/5YimIXfBtjkKBUI/HSeRLcRmhywoNfS8=;
 b=Cu+v6Ox5trQNJbmqXQ+XUu8KnToC1WP5nlzSyIQ3QFPGV6dromOkE2Ww4MPCkdzsK0vhyN
 AcL1mDGLWdij4zRD0yRxyRVNVcWksiMys9S+HNy7ZaJolCmRAgaLUizli22ezXeuIal9Rs
 8fXdrJgapCx4bKhkaLxSK8Ow+47Qn6w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-XJ9XErwOOviqwXA5n-mSGw-1; Wed,
 13 May 2026 05:45:28 -0400
X-MC-Unique: XJ9XErwOOviqwXA5n-mSGw-1
X-Mimecast-MFC-AGG-ID: XJ9XErwOOviqwXA5n-mSGw_1778665527
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3DC8180059D; Wed, 13 May 2026 09:45:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85B3B180058F; Wed, 13 May 2026 09:45:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH] vfio/migration: Detect and report overflow in migration size
 queries
Date: Wed, 13 May 2026 11:45:22 +0200
Message-ID: <20260513094522.346314-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEXHASH_WORD=2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

VFIO migration ioctls (VFIO_DEVICE_FEATURE_MIG_DATA_SIZE and
VFIO_MIG_GET_PRECOPY_INFO) return device-estimated migration sizes as
uint64_t values. A misbehaving kernel driver could return values that
are unreasonably large, which would corrupt the size accounting used
to decide migration convergence.

This misbehavior occurred a few times when testing migration of a VM
with an assigned NVIDIA vGPU and an MLX5 VF. In some of the save
iterations, the reported precopy and stopcopy sizes were unreasonably
large (close to UINT64_MAX):

  vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073708667040 precopy dirty size 0
  vfio_save_iterate   (4fbce62c-8ce2-4cc9-b429-41635bc94f24) precopy initial size 18446744073707618464 precopy dirty size 0
  vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 18446744073708503040 precopy initial size 18446744073707618464 precopy dirty size 0
  vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073707618464 precopy dirty size 0
  vfio_state_pending  (0000:b1:01.0) stopcopy size 18446744073709543408 precopy initial size 0 precopy dirty size 1008

This had the effect of corrupting migration convergence, as reported
by the HMP migrate command:

  (qemu) info migrate
  Status:                 active
  Time (ms):              total=21140, setup=86, exp_down=152455434886355
  Remaining:              16 EiB
  RAM info:
    Throughput (Mbps):    967.98
    Sizes:                pagesize=4 KiB, total=4 GiB
    Transfers:            transferred=2.29 GiB, remain=4.7 MiB
      Channels:           precopy=1.91 GiB, multifd=0 B, postcopy=0 B, vfio=387 MiB
      Page Types:         normal=499427, zero=559708
    Page Rates (pps):     transfer=0, dirty=1892
    Others:               dirty_syncs=3

Add a helper to detect values that exceed INT64_MAX, which is far
beyond any realistic device state size, and report them with an error
message. Return -ERANGE from the query functions so callers can abort
the migration rather than proceeding with corrupted estimates.
However, the callers don't yet check the return value to actually stop
the migration.

Cc: Avihai Horon <avihaih@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 150e28656e97c5e8198541e5b6dfc4ed4102d143..fb12b9717f773fdde657911517de9d74c1eb3931 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -320,6 +320,18 @@ static void vfio_migration_cleanup(VFIODevice *vbasedev)
     migration->data_fd = -1;
 }
 
+static bool vfio_migration_check_overflow(VFIODevice *vbasedev, uint64_t size,
+                                          const char *name)
+{
+    if (size > INT64_MAX) {
+        error_report("%s: Estimated %s size overflow: 0x%"PRIx64,
+                     vbasedev->name, name, size);
+        return true;
+    }
+
+    return false;
+}
+
 static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
@@ -329,7 +341,7 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
     struct vfio_device_feature_mig_data_size *mig_data_size =
         (struct vfio_device_feature_mig_data_size *)feature->data;
     VFIOMigration *migration = vbasedev->migration;
-    int ret;
+    int ret = 0;
 
     feature->argsz = sizeof(buf);
     feature->flags =
@@ -347,7 +359,10 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
                          vbasedev->name, ret);
     } else {
         migration->stopcopy_size = mig_data_size->stop_copy_length;
-        ret = 0;
+        if (vfio_migration_check_overflow(vbasedev, migration->stopcopy_size,
+                                          "stop copy size")) {
+            ret = -ERANGE;
+        }
     }
 
     trace_vfio_query_stop_copy_size(vbasedev->name,
@@ -361,7 +376,7 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
     struct vfio_precopy_info precopy = {
         .argsz = sizeof(precopy),
     };
-    int ret;
+    int ret = 0;
 
     if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
         migration->precopy_init_size = 0;
@@ -370,9 +385,18 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
         warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
                          "failed (%d)", migration->vbasedev->name, ret);
     } else {
+        bool overflow;
+
         migration->precopy_init_size = precopy.initial_bytes;
         migration->precopy_dirty_size = precopy.dirty_bytes;
-        ret = 0;
+
+        overflow  = vfio_migration_check_overflow(migration->vbasedev,
+                         migration->precopy_init_size,  "precopy init size");
+        overflow |= vfio_migration_check_overflow(migration->vbasedev,
+                         migration->precopy_dirty_size, "precopy dirty size");
+        if (overflow) {
+            ret = -ERANGE;
+        }
     }
 
     trace_vfio_query_precopy_size(migration->vbasedev->name,
-- 
2.54.0


