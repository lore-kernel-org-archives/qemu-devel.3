Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45026C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrRe-0001hy-J5; Wed, 06 Mar 2024 08:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRT-0001Gs-77
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRR-0006DS-AU
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYNv2PXpz4wyy;
 Thu,  7 Mar 2024 00:36:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYNr12mLz4wbh;
 Thu,  7 Mar 2024 00:36:11 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 20/25] vfio: Add Error** argument to .vfio_save_config()
 handler
Date: Wed,  6 Mar 2024 14:34:35 +0100
Message-ID: <20240306133441.2351700-21-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Use vmstate_save_state_with_err() to improve error reporting in the
callers and store a reported error under the migration stream. Add
documentation while at it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
 hw/vfio/migration.c           | 18 ++++++++++++------
 hw/vfio/pci.c                 |  5 +++--
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -133,7 +133,30 @@ struct VFIODeviceOps {
     int (*vfio_hot_reset_multi)(VFIODevice *vdev);
     void (*vfio_eoi)(VFIODevice *vdev);
     Object *(*vfio_get_object)(VFIODevice *vdev);
-    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
+
+    /**
+     * @vfio_save_config
+     *
+     * Save device config state
+     *
+     * @vdev: #VFIODevice for which to save the config
+     * @f: #QEMUFile where to send the data
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
+
+    /**
+     * @vfio_load_config
+     *
+     * Load device config state
+     *
+     * @vdev: #VFIODevice for which to load the config
+     * @f: #QEMUFile where to get the data
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 71ade14a7942358094371a86c00718f5979113ea..bd48f2ee472a5230c2c84bff829dae1e217db33f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -190,14 +190,19 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
     return ret;
 }
 
-static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
+static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
+                                         Error **errp)
 {
     VFIODevice *vbasedev = opaque;
+    int ret;
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
 
     if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
-        vbasedev->ops->vfio_save_config(vbasedev, f);
+        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
+        if (ret) {
+            return ret;
+        }
     }
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
@@ -587,13 +592,14 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 static void vfio_save_state(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    Error *local_err = NULL;
     int ret;
 
-    ret = vfio_save_device_config_state(f, opaque);
+    ret = vfio_save_device_config_state(f, opaque, &local_err);
     if (ret) {
-        error_report("%s: Failed to save device config space",
-                     vbasedev->name);
-        qemu_file_set_error(f, ret);
+        error_prepend(&local_err, "%s: Failed to save device config space",
+                      vbasedev->name);
+        qemu_file_set_error_obj(f, ret, local_err);
     }
 }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f0430d62ca2ba1b5ae5b7037f8f06b33f9..99d86e1d40ef25133fc76ad6e58294b07bd20843 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2585,11 +2585,12 @@ const VMStateDescription vmstate_vfio_pci_config = {
     }
 };
 
-static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
-    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
+    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
+                                       errp);
 }
 
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
-- 
2.44.0


