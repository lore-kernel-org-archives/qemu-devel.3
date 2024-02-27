Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E487AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4Ku-00060N-1e; Tue, 27 Feb 2024 15:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1oX-0003P4-PS
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:28 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1oR-0001Vm-D8
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tkljs2qJFz4wyf;
 Wed, 28 Feb 2024 05:04:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tkljl6mn1z4wyj;
 Wed, 28 Feb 2024 05:04:11 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 06/21] migration: Add Error** argument to .save_setup()
 handler
Date: Tue, 27 Feb 2024 19:03:30 +0100
Message-ID: <20240227180345.548960-7-clg@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227180345.548960-1-clg@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GitP=KE=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 15:45:32 -0500
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

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

Changes in v2: 

 - dropped qemu_file_set_error_obj(f, ret, local_err); 

include/migration/register.h   | 3 ++-
 hw/ppc/spapr.c                 | 2 +-
 hw/s390x/s390-stattrib.c       | 2 +-
 hw/vfio/migration.c            | 2 +-
 migration/block-dirty-bitmap.c | 2 +-
 migration/block.c              | 2 +-
 migration/ram.c                | 3 ++-
 migration/savevm.c             | 2 +-
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 2cc71ec45f65bf2884c9e7a823d2968752f15c20..96eae9dba2970552c379c732393e3ab6ef578a58 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -60,10 +60,11 @@ typedef struct SaveVMHandlers {
      *
      * @f: QEMUFile where to send the data
      * @opaque: data pointer passed to register_savevm_live()
+     * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error
      */
-    int (*save_setup)(QEMUFile *f, void *opaque);
+    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
 
     /**
      * @save_cleanup
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55263f0815ed7671b32ea20b394ae71c82e616cb..045c024ffa76eacfc496bd486cb6cafbee2df73e 100644
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
index 4649a8120492a03d331d660622e1a0a51adb0a96..745482899e18c86b73261b683c1bec04039a76d2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2930,8 +2930,9 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
  *
  * @f: QEMUFile where to send the data
  * @opaque: RAMState pointer
+ * @errp: pointer to Error*, to store an error if it happens.
  */
-static int ram_save_setup(QEMUFile *f, void *opaque)
+static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
diff --git a/migration/savevm.c b/migration/savevm.c
index bc168371a31acf85f29f2c284be181250db45df4..b5b3b51bad94dc4c04ae22cd687ba111299339aa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1341,7 +1341,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
 
-        ret = se->ops->save_setup(f, se->opaque);
+        ret = se->ops->save_setup(f, se->opaque, errp);
         save_section_footer(f, se);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
-- 
2.43.2


