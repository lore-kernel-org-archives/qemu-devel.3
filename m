Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DB7C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQp-0008JZ-2R; Wed, 06 Mar 2024 08:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQm-0008Iq-5K
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:36 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQV-0005Bu-SS
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYMk5Glvz4wxs;
 Thu,  7 Mar 2024 00:35:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYMg3v6tz4wcF;
 Thu,  7 Mar 2024 00:35:11 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 06/25] vfio: Always report an error in vfio_save_setup()
Date: Wed,  6 Mar 2024 14:34:21 +0100
Message-ID: <20240306133441.2351700-7-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
vfio_save_setup() always sets a new error.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:

 - Fixed state name printed out in error returned by vfio_save_setup()
 - Fixed test on error returned by qemu_file_get_error()
 
 hw/vfio/migration.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2050ac8897231ff89cc223f0570d5c7a65dede9e..330b3a28548e32b0b3268072895bb5e4875766a2 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -383,6 +383,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
+    int ret;
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
@@ -397,13 +398,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
     }
 
     if (vfio_precopy_supported(vbasedev)) {
-        int ret;
-
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
                                            VFIO_DEVICE_STATE_RUNNING);
             if (ret) {
+                error_report("%s: Failed to set new PRE_COPY state",
+                             vbasedev->name);
                 return ret;
             }
 
@@ -414,6 +415,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
             /* vfio_save_complete_precopy() will go to STOP_COPY */
             break;
         default:
+            error_report("%s: Invalid device state %d", vbasedev->name,
+                         migration->device_state);
             return -EINVAL;
         }
     }
@@ -422,7 +425,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
-    return qemu_file_get_error(f);
+    ret = qemu_file_get_error(f);
+    if (ret < 0) {
+        error_report("%s: save setup failed : %s", vbasedev->name,
+                     strerror(-ret));
+    }
+
+    return ret;
 }
 
 static void vfio_save_cleanup(void *opaque)
-- 
2.44.0


