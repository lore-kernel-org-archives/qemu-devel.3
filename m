Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FE4C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uXD-0005Mz-9k; Mon, 06 May 2024 05:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uXA-0005Iu-30
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uX7-0007Ch-0K
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714987270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4i21RsmQ+OamtTnJmpcR98aaPRS7QqAsiwK6v5Z46Vo=;
 b=YecSfCdLfX9Z5pEVXx+bDB+6jxUxMDCoYhRmJLSMPryEtoR8d025dBeJPoN+0zPaHqGb0Y
 G3ATDfrpS/8KGR0VrYNx5o9yLjacRFdyJozBQtGbgCBQYgKUA/kq+F+feq0gD/cMfLUfXy
 2h2YtJDlDSSivofH/GH6QhrbkJ4HBps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-lVrHuE5GOgOyy7sdL_JsLw-1; Mon, 06 May 2024 05:21:08 -0400
X-MC-Unique: lVrHuE5GOgOyy7sdL_JsLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D07C80591B;
 Mon,  6 May 2024 09:21:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A248A6958;
 Mon,  6 May 2024 09:21:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 05/10] vfio: Add Error** argument to .vfio_save_config()
 handler
Date: Mon,  6 May 2024 11:20:48 +0200
Message-ID: <20240506092053.388578-6-clg@redhat.com>
In-Reply-To: <20240506092053.388578-1-clg@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index 9b6375c949f7a8dca857ead2506855f63fa051e4..87437490bd50321b3eb27770c932078597053746 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -189,14 +189,19 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
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
@@ -588,13 +593,14 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
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
index 64780d1b793345c8e8996fe6b7987059ce831c11..fc6e54e871508bb0e2a3ac9079a195c086531f21 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2586,11 +2586,12 @@ static const VMStateDescription vmstate_vfio_pci_config = {
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
2.45.0


