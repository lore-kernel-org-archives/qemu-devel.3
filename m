Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A5DD10F28
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkrE-00057n-Ml; Sun, 17 Nov 2024 14:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkr8-0004ux-67
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:46 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkr6-0005xk-EY
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:45 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkr3-00000002GW1-1duI; Sun, 17 Nov 2024 20:22:41 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 18/24] vfio/migration: Don't run load cleanup if load setup
 didn't run
Date: Sun, 17 Nov 2024 20:20:13 +0100
Message-ID: <72424ece45968b1ae6b39750917a041867c415ab.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

It's possible for load_cleanup SaveVMHandler to get called without
load_setup handler being called first.

Since we'll be soon running cleanup operations there that access objects
that need earlier initialization in load_setup let's make sure these
cleanups only run when load_setup handler had indeed been called
earlier.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 21 +++++++++++++++++++--
 include/hw/vfio/vfio-common.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 01aa11013e42..9e2657073012 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -688,16 +688,33 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
 static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    assert(!migration->load_setup);
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+                                   migration->device_state, errp);
+    if (ret) {
+        return ret;
+    }
 
-    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
-                                    vbasedev->migration->device_state, errp);
+    migration->load_setup = true;
+
+    return 0;
 }
 
 static int vfio_load_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (!migration->load_setup) {
+        return 0;
+    }
 
     vfio_migration_cleanup(vbasedev);
+    migration->load_setup = false;
     trace_vfio_load_cleanup(vbasedev->name);
 
     return 0;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e0ce6ec3a9b3..246250ed8b75 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -66,6 +66,7 @@ typedef struct VFIOMigration {
     VMChangeStateEntry *vm_state;
     NotifierWithReturn migration_state;
     uint32_t device_state;
+    bool load_setup;
     int data_fd;
     void *data_buffer;
     size_t data_buffer_size;

