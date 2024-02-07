Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F275C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4D-0006kr-NR; Wed, 07 Feb 2024 08:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi45-0006fh-3B
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:14 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi40-0008O8-03
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgB24H4z4wys;
 Thu,  8 Feb 2024 00:33:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLg83Wfkz4wc6;
 Thu,  8 Feb 2024 00:33:56 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 01/14] migration: Add Error** argument to .save_setup() handler
Date: Wed,  7 Feb 2024 14:33:34 +0100
Message-ID: <20240207133347.1115903-2-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

The purpose is to record a potential error in the migration stream if
qemu_savevm_state_setup() fails. Most of the current .save_setup()
handlers can be modified to use the Error argument instead of managing
their own and calling locally error_report(). The following patches
will introduce such changes for VFIO first.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h   | 2 +-
 hw/ppc/spapr.c                 | 2 +-
 hw/s390x/s390-stattrib.c       | 2 +-
 hw/vfio/migration.c            | 2 +-
 migration/block-dirty-bitmap.c | 2 +-
 migration/block.c              | 2 +-
 migration/ram.c                | 2 +-
 migration/savevm.c             | 4 ++--
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 9ab1f79512c605f0c88a45b560c57486fa054441..831600a00eae4efd0464b60925d65de4d9dbcff8 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -25,7 +25,7 @@ typedef struct SaveVMHandlers {
      * used to perform early checks.
      */
     int (*save_prepare)(void *opaque, Error **errp);
-    int (*save_setup)(QEMUFile *f, void *opaque);
+    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
     void (*save_cleanup)(void *opaque);
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d72d286d80f0435122593555f79fae4d90acf81..a1b0aa02582ad2d68a13476c1859b18143da7bb8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2142,7 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
     }
 };
 
-static int htab_save_setup(QEMUFile *f, void *opaque)
+static int htab_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     SpaprMachineState *spapr = opaque;
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5ddfc0cbe0ea98e9ec 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
-static int cmma_save_setup(QEMUFile *f, void *opaque)
+static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 70e6b1a709f9b67e4c9eb41033d76347275cac42..8bcb4bc73cd5ba5338e3ffa4d907d0e6bfbb9485 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -378,7 +378,7 @@ static int vfio_save_prepare(void *opaque, Error **errp)
     return 0;
 }
 
-static int vfio_save_setup(QEMUFile *f, void *opaque)
+static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 2708abf3d762de774ed294d3fdb8e56690d2974c..16f84e6c57c2403a8c2d6319f4e7b6360dade28c 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1213,7 +1213,7 @@ fail:
     return ret;
 }
 
-static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
+static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms = NULL;
diff --git a/migration/block.c b/migration/block.c
index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..df15319ceab66201b043f15eac1b0a7d6522b60c 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -708,7 +708,7 @@ static void block_migration_cleanup(void *opaque)
     blk_mig_unlock();
 }
 
-static int block_save_setup(QEMUFile *f, void *opaque)
+static int block_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     int ret;
 
diff --git a/migration/ram.c b/migration/ram.c
index d5b7cd5ac2f31aabf4a248b966153401c48912cf..136c237f4079f68d4e578cf1c72eec2efc815bc8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2931,7 +2931,7 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
  * @f: QEMUFile where to send the data
  * @opaque: RAMState pointer
  */
-static int ram_save_setup(QEMUFile *f, void *opaque)
+static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
diff --git a/migration/savevm.c b/migration/savevm.c
index d612c8a9020b204d5d078d5df85f0e6449c27645..f2ae799bad13e631bccf733a34c3a8fd22e8dd48 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1342,10 +1342,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
 
-        ret = se->ops->save_setup(f, se->opaque);
+        ret = se->ops->save_setup(f, se->opaque, &local_err);
         save_section_footer(f, se);
         if (ret < 0) {
-            qemu_file_set_error(f, ret);
+            qemu_file_set_error_obj(f, ret, local_err);
             break;
         }
     }
-- 
2.43.0


