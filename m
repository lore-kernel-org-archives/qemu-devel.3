Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787F810F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYc1-0004T5-Kj; Wed, 08 Apr 2026 15:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAYA0-0000eP-6E
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCH-00027V-Jm
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0kLvM+Gei19WRwCTbcZcMBvammqKpOVcflr0Var+P0=;
 b=TOxsC97SY+/CqdyxPyWbwwTN2iXkEGi+4+viWa8QvhthtNsuvMpO4CpFqnMNFhiiC4gJoP
 QYB2R/BKQqjocs/EjXRU+hngRvt3xxCB/onLOS8njRgAXI6/pDKZFLhalc6E/Bl9cOjdXr
 0U0MGfuolKzkMi5M9ua7IKgg93vmC5Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-6u8ACfTEOH6qaFTmWXXM1w-1; Wed, 08 Apr 2026 12:56:07 -0400
X-MC-Unique: 6u8ACfTEOH6qaFTmWXXM1w-1
X-Mimecast-MFC-AGG-ID: 6u8ACfTEOH6qaFTmWXXM1w_1775667367
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso3165141cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667366; x=1776272166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0kLvM+Gei19WRwCTbcZcMBvammqKpOVcflr0Var+P0=;
 b=DDZlKDEgEq03sIhsAAWpseF9NY3sC/xZQ+CpfoyUMKyjp379DeuiqfpBIZAY5J1CPJ
 jI1Jf8ugh+QMjxzbHxPRLxA4edDVyFlvlmr+kbMrpvo4im9SvcIi+oN5iAEmsJl0d4kV
 BX6joadC9Zq2ZjIaBWMN19qhVNbasIUOZuTHLaOz54ImQ22z31DaG5synaMBlmKspEpN
 Uzu6qCykXud3whBP5RxOOqSO6SlVQSDPJM8jT2QQIq1ErXEXbe15RPkjhU0RstYfviqs
 lIxW6rHe9E+WFvs/c+6867t8E6VwLMqLeIZFzWxySljmkvLztTPHpK3cUoHTg1hihS9u
 JgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667366; x=1776272166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O0kLvM+Gei19WRwCTbcZcMBvammqKpOVcflr0Var+P0=;
 b=p++CQpcXg2T0FbtX6mztUBvKeax2aORg/9eQKfUzXIp0lh0EimVyQWUfDuA1Ly6g3B
 ZGk9ZnyViZ5zuTsCqxS7NhUb8zW5eORBa1yjVLpfrldVJNkQfHVC+Kx+ynQrGYizbAAG
 w6PrB6sBmfcWBETgKTMKGAK2X2LOOADnLbtDFWWjNk9DXbsAv3k/SOQhniEoIvVzrppc
 gCxD/wATSfZIj8lbhkNDWLPW+JCJUKmelCxY0Bp8IbmxRaSE1r0zZYa6SxfYFWPzczXo
 Xp6jRJuGJ+zAhOzBae5NgcqvT1hweH9ny8z2dHmkIjV7vjUCaDYfVoPag2dtNT6PXwOo
 yzAQ==
X-Gm-Message-State: AOJu0YyNai20Xzv4HNLf2hXzr/IhfdtOsHVwgyGxvAgHHjUKLo7aN0Di
 WO9ByBaeUfQpfB5UnK/lsSZNaumenOT6unmnA4v+ug0EoihtEGeejBdJTGDzHUiYlzEwhrPxbNM
 dT1fuOKEn2lsc2Xkqykf74Fvnr0f7R5YL3uVMV8SMeyd0Abkv/YjFngk9fTtpsrx1H+Ajm03+HU
 O6/o5VWg0Pi5Q0xcNzQmcX8MPiVpKP8NTjAicoZg==
X-Gm-Gg: AeBDiesx48/EEo203r/xVn0J5GoP8hDYCa197BeSS5umjMXhOy0YROW148DW9Y67dpp
 Q6ZIHkaLX3Fwm3aojIrczmC4SIHux7bz8rW3R5l9CVPl7wK7b4h+Fme7B4EiENdUFzTeYMm1qfh
 cdPrUkWJQy7j3q+5LbHgydYajCVXecb7iglkihn0WD5U1J13QCF97xBZR0pRDmnYU9QuKxfehTk
 EtOoYyr15CqcKvVVZEXvlU9IQHXtI5S43NhGz466/nqUfQZQYSPVAy4gg/deuTvkPZd4Q+lSi/k
 /CBbuulgNHlH++aeWN/RnvbRm+AQmbs8G84TltF66wQrodXiqnujPCszTgIh7F/6haV+3ZdsxAt
 E08EZpZLaGe7SnYNcMqQRqulN2GdQK9Ls+oUM9ZPO/C38
X-Received: by 2002:ac8:6f0d:0:b0:50d:9d34:3b3c with SMTP id
 d75a77b69052e-50d9d343ca6mr147835321cf.64.1775667366271; 
 Wed, 08 Apr 2026 09:56:06 -0700 (PDT)
X-Received: by 2002:ac8:6f0d:0:b0:50d:9d34:3b3c with SMTP id
 d75a77b69052e-50d9d343ca6mr147834631cf.64.1775667365576; 
 Wed, 08 Apr 2026 09:56:05 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH 03/14] vfio/migration: Cache stop size in VFIOMigration
Date: Wed,  8 Apr 2026 12:55:47 -0400
Message-ID: <20260408165559.157108-4-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


