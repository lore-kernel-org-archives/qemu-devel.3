Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20482CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWuH-0000Rd-PX; Fri, 06 Sep 2024 07:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWuE-0000El-7B; Fri, 06 Sep 2024 07:13:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWuC-0007f6-DD; Fri, 06 Sep 2024 07:13:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 97D968C472;
 Fri,  6 Sep 2024 14:12:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A38F31336DC;
 Fri,  6 Sep 2024 14:13:24 +0300 (MSK)
Received: (nullmailer pid 353545 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 02/69] scsi: fix regression and honor bootindex again
 for legacy drives
Date: Fri,  6 Sep 2024 14:12:11 +0300
Message-Id: <20240906111324.353230-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 3089637461 ("scsi: Don't ignore most usb-storage properties")
removed the call to object_property_set_int() and thus the 'set'
method for the bootindex property was also not called anymore. Here
that method is device_set_bootindex() (as configured by
scsi_dev_instance_init() -> device_add_bootindex_property()) which as
a side effect registers the device via add_boot_device_path().

As reported by a downstream user [0], the bootindex property did not
have the desired effect anymore for legacy drives. Fix the regression
by explicitly calling the add_boot_device_path() function after
checking that the bootindex is not yet used (to avoid
add_boot_device_path() calling exit()).

[0]: https://forum.proxmox.com/threads/149772/post-679433

Cc: qemu-stable@nongnu.org
Fixes: 3089637461 ("scsi: Don't ignore most usb-storage properties")
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Link: https://lore.kernel.org/r/20240710152529.1737407-1-f.ebner@proxmox.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 57a8a80d1a5b28797b21d30bfc60601945820e51)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9e40b0c920..53eff5dd3d 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -384,6 +384,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     DeviceState *dev;
     SCSIDevice *s;
     DriveInfo *dinfo;
+    Error *local_err = NULL;
 
     if (blk_is_sg(blk)) {
         driver = "scsi-generic";
@@ -403,6 +404,14 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     s = SCSI_DEVICE(dev);
     s->conf = *conf;
 
+    check_boot_index(conf->bootindex, &local_err);
+    if (local_err) {
+        object_unparent(OBJECT(dev));
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+    add_boot_device_path(conf->bootindex, dev, NULL);
+
     qdev_prop_set_uint32(dev, "scsi-id", unit);
     if (object_property_find(OBJECT(dev), "removable")) {
         qdev_prop_set_bit(dev, "removable", removable);
-- 
2.39.2


