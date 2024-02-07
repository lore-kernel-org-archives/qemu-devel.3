Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45461C4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpu8-0007AC-Bn; Wed, 07 Feb 2024 16:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu6-00077J-4W
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu4-0007dz-Cw
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mQJ5DC1wsfQgh7/jquzUVLwaHKif1MulGs6+1cbpeY=;
 b=DqL84J9/oZ0X2HHLixEi/ncRed60C99wUIcP3Kp/YChQeoGxehWfLaW28qY5S051hOGftH
 KJqlCcsHbkQkF5taNuse8QEWfrHiTDrBNlKiUJ8fopDFUGRq/ebx8IJAhqzKcgoITSLVh0
 MrXNwxnl0AeHnmB6iGnAaJSjJj8IDQg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-PZvfr3LeM_SaAJOu33T6UA-1; Wed,
 07 Feb 2024 16:56:20 -0500
X-MC-Unique: PZvfr3LeM_SaAJOu33T6UA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70FEF2825BA6;
 Wed,  7 Feb 2024 21:56:20 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D875B492BC6;
 Wed,  7 Feb 2024 21:56:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/16] scsi: Don't ignore most usb-storage properties
Date: Wed,  7 Feb 2024 22:56:01 +0100
Message-ID: <20240207215606.206038-12-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
References: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

usb-storage is for the most part just a wrapper around an internally
created scsi-disk device. It uses DEFINE_BLOCK_PROPERTIES() to offer all
of the usual block device properties to the user, but then only forwards
a few select properties to the internal device while the rest is
silently ignored.

This changes scsi_bus_legacy_add_drive() to accept a whole BlockConf
instead of some individual values inside of it so that usb-storage can
now pass the whole configuration to the internal scsi-disk. This enables
the remaining block device properties, e.g. logical/physical_block_size
or discard_granularity.

Buglink: https://issues.redhat.com/browse/RHEL-22375
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240131130607.24117-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/scsi/scsi.h       |  5 +----
 hw/scsi/scsi-bus.c           | 33 +++++++++++++--------------------
 hw/usb/dev-storage-classic.c |  5 +----
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 10c4e8288d..c3d5e17e38 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -199,10 +199,7 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
 }
 
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
-                                      int unit, bool removable, int bootindex,
-                                      bool share_rw,
-                                      BlockdevOnError rerror,
-                                      BlockdevOnError werror,
+                                      int unit, bool removable, BlockConf *conf,
                                       const char *serial, Error **errp);
 void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 230313022c..9e40b0c920 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -376,15 +376,13 @@ static void scsi_qdev_unrealize(DeviceState *qdev)
 
 /* handle legacy '-drive if=scsi,...' cmd line args */
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
-                                      int unit, bool removable, int bootindex,
-                                      bool share_rw,
-                                      BlockdevOnError rerror,
-                                      BlockdevOnError werror,
+                                      int unit, bool removable, BlockConf *conf,
                                       const char *serial, Error **errp)
 {
     const char *driver;
     char *name;
     DeviceState *dev;
+    SCSIDevice *s;
     DriveInfo *dinfo;
 
     if (blk_is_sg(blk)) {
@@ -402,11 +400,10 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     object_property_add_child(OBJECT(bus), name, OBJECT(dev));
     g_free(name);
 
+    s = SCSI_DEVICE(dev);
+    s->conf = *conf;
+
     qdev_prop_set_uint32(dev, "scsi-id", unit);
-    if (bootindex >= 0) {
-        object_property_set_int(OBJECT(dev), "bootindex", bootindex,
-                                &error_abort);
-    }
     if (object_property_find(OBJECT(dev), "removable")) {
         qdev_prop_set_bit(dev, "removable", removable);
     }
@@ -417,19 +414,12 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
         object_unparent(OBJECT(dev));
         return NULL;
     }
-    if (!object_property_set_bool(OBJECT(dev), "share-rw", share_rw, errp)) {
-        object_unparent(OBJECT(dev));
-        return NULL;
-    }
-
-    qdev_prop_set_enum(dev, "rerror", rerror);
-    qdev_prop_set_enum(dev, "werror", werror);
 
     if (!qdev_realize_and_unref(dev, &bus->qbus, errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
-    return SCSI_DEVICE(dev);
+    return s;
 }
 
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
@@ -437,6 +427,12 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
     Location loc;
     DriveInfo *dinfo;
     int unit;
+    BlockConf conf = {
+        .bootindex = -1,
+        .share_rw = false,
+        .rerror = BLOCKDEV_ON_ERROR_AUTO,
+        .werror = BLOCKDEV_ON_ERROR_AUTO,
+    };
 
     loc_push_none(&loc);
     for (unit = 0; unit <= bus->info->max_target; unit++) {
@@ -446,10 +442,7 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
         }
         qemu_opts_loc_restore(dinfo->opts);
         scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
-                                  unit, false, -1, false,
-                                  BLOCKDEV_ON_ERROR_AUTO,
-                                  BLOCKDEV_ON_ERROR_AUTO,
-                                  NULL, &error_fatal);
+                                  unit, false, &conf, NULL, &error_fatal);
     }
     loc_pop(&loc);
 }
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 84d19752b5..50a3ad6285 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -67,10 +67,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
                  &usb_msd_scsi_info_storage);
     scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
-                                         s->conf.bootindex, s->conf.share_rw,
-                                         s->conf.rerror, s->conf.werror,
-                                         dev->serial,
-                                         errp);
+                                         &s->conf, dev->serial, errp);
     blk_unref(blk);
     if (!scsi_dev) {
         return;
-- 
2.43.0


