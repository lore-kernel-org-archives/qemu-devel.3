Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D155FCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq5B-0007bX-5t; Tue, 10 Mar 2026 01:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq54-0007Ph-Dj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq52-0006Hp-Ox
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzRlD3koEkgv0kcLtoseIS7ngMhyZRhlcGARDho+TsY=;
 b=VOTpHhanCciM5JJnnhv9MRdP5BaV3Ju4XY1jfIF/DcQykIddHfLGGAt2FHOFT22UCPha9S
 m3XDXAsPCa6EXKBbdWoEieVvz0jT5bAeFUaahE5eCCRK/p4QSc4b+bxrayl1pRSzVuLgQP
 AlilfTyxbgmp2Hq7e6gwyTLx5hEbIkw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-A1v8LBoONmqhUHPa1McOZg-1; Tue,
 10 Mar 2026 01:56:25 -0400
X-MC-Unique: A1v8LBoONmqhUHPa1McOZg-1
X-Mimecast-MFC-AGG-ID: A1v8LBoONmqhUHPa1McOZg_1773122184
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD8B0180034E; Tue, 10 Mar 2026 05:56:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B59731955D87; Tue, 10 Mar 2026 05:56:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Farhan Ali <alifm@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 13/25] pc-bios/s390-ccw: Store device type independent of sense
 data
Date: Tue, 10 Mar 2026 06:55:18 +0100
Message-ID: <20260310055530.8893-14-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Store the device type (e.g. block) directly as an attribute of the VDev rather
than assume all devices can be identified by accessing CCW specific sense data.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-6-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio.h        |  1 +
 pc-bios/s390-ccw/main.c          |  2 +-
 pc-bios/s390-ccw/virtio-blkdev.c | 39 +++++++++++++++++++-------------
 pc-bios/s390-ccw/virtio.c        | 11 ++++++---
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 391d6ff2f7f..39b507b2219 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -239,6 +239,7 @@ struct VDev {
     SubChannelId schid;
     SenseId senseid;
     S390IplType ipl_type;
+    VirtioDevType dev_type;
     union {
         VirtioBlkConfig blk;
         VirtioScsiConfig scsi;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 2e9261904fa..64bde497103 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -251,7 +251,7 @@ static int virtio_setup(void)
     vdev->is_cdrom = false;
     int ret;
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_NET:
         puts("Network boot device detected");
         return 0;
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 019c2718b18..9cc40e9108d 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -53,14 +53,14 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return virtio_blk_read_many(vdev, sector, load_addr, sec_num);
     case VIRTIO_ID_SCSI:
         return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);
+    default:
+        return -1;
     }
-
-    return -1;
 }
 
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
@@ -119,7 +119,7 @@ void virtio_assume_iso9660(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
         vdev->config.blk.blk_size = VIRTIO_ISO_BLOCK_SIZE;
@@ -129,6 +129,8 @@ void virtio_assume_iso9660(void)
     case VIRTIO_ID_SCSI:
         vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
         break;
+    default:
+        return;
     }
 }
 
@@ -139,13 +141,15 @@ void virtio_assume_eckd(void)
     vdev->guessed_disk_nature = VIRTIO_GDN_DASD;
     vdev->blk_factor = 1;
     vdev->config.blk.physical_block_exp = 0;
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         vdev->config.blk.blk_size = VIRTIO_DASD_DEFAULT_BLOCK_SIZE;
         break;
     case VIRTIO_ID_SCSI:
         vdev->config.blk.blk_size = vdev->scsi_block_size;
         break;
+    default:
+        break;
     }
     vdev->config.blk.geometry.heads = 15;
     vdev->config.blk.geometry.sectors =
@@ -162,50 +166,52 @@ bool virtio_ipl_disk_is_valid(void)
         return true;
     }
 
-    return (vdev->senseid.cu_model == VIRTIO_ID_BLOCK ||
-            vdev->senseid.cu_model == VIRTIO_ID_SCSI) &&
-           blksize >= 512 && blksize <= 4096;
+    return (vdev->dev_type == VIRTIO_ID_BLOCK || vdev->dev_type == VIRTIO_ID_SCSI)
+            && blksize >= 512 && blksize <= 4096;
 }
 
 int virtio_get_block_size(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.blk_size;
     case VIRTIO_ID_SCSI:
         return vdev->scsi_block_size;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 uint8_t virtio_get_heads(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.geometry.heads;
     case VIRTIO_ID_SCSI:
         return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
                ? vdev->config.blk.geometry.heads : 255;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 uint8_t virtio_get_sectors(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.geometry.sectors;
     case VIRTIO_ID_SCSI:
         return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
                ? vdev->config.blk.geometry.sectors : 63;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 uint64_t virtio_get_blocks(void)
@@ -213,13 +219,14 @@ uint64_t virtio_get_blocks(void)
     VDev *vdev = virtio_get_device();
     const uint64_t factor = virtio_get_block_size() / VIRTIO_SECTOR_SIZE;
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.capacity / factor;
     case VIRTIO_ID_SCSI:
         return vdev->scsi_last_block / factor;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 int virtio_blk_setup_device(SubChannelId schid)
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index f384a990dcc..5dd407d5c9b 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -41,7 +41,7 @@ VDev *virtio_get_device(void)
 
 VirtioDevType virtio_get_device_type(void)
 {
-    return vdev.senseid.cu_model;
+    return vdev.dev_type;
 }
 
 /* virtio spec v1.0 para 4.3.3.2 */
@@ -248,7 +248,7 @@ int virtio_setup_ccw(VDev *vdev)
         return -EIO;
     }
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_NET:
         vdev->nr_vqs = 2;
         vdev->cmd_vr_idx = 0;
@@ -346,12 +346,17 @@ bool virtio_is_supported(SubChannelId schid)
                 true)) {
         return false;
     }
+
+    vdev.dev_type = vdev.senseid.cu_model;
+
     if (vdev.senseid.cu_type == 0x3832) {
-        switch (vdev.senseid.cu_model) {
+        switch (vdev.dev_type) {
         case VIRTIO_ID_BLOCK:
         case VIRTIO_ID_SCSI:
         case VIRTIO_ID_NET:
             return true;
+        default:
+            return false;
         }
     }
     return false;
-- 
2.53.0


