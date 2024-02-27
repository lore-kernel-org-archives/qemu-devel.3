Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75340C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Ub-0001fb-GB; Tue, 27 Feb 2024 12:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Ua-0001fH-1F
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:43:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1UY-0005N1-9c
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:43:47 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFXsPH019501; Tue, 27 Feb 2024 17:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=0VSA3E9F7P+/AxxuMUTQ7opQWkg/Lu4D2OqFC1M9wuE=;
 b=WA9BJJJyO72qQxQA3xPHDpVXHdXkcoBgGC8p5lsTkzDi05KJ4wy1jIiw7BmWPBi0Fnj1
 CC/PsWgqum61PynZ+SkGbbMrySE8Lr7OjGTOCs3Tpu/ufnp8LscJ65m8xVVYVdtOFg4z
 AwQbrfF7KW0nEDEPU7gfNWnfH1HYTyyaIZuYOF1yp9byXbxo3FHGxA8fpFVp1IL04e8v
 iUqvCAKzT6Lz2x94aYg1fDopXQYj05j1/sHLankdK7y0LoXFmeoE8k+QhutUAOUIc+Fc
 kzJXbZusqnpahOgVO9Cpm2z6RsRfj8M5i2jZsGuH5Mla2lOUQhDgj/MHKO/rqdd9CuY7 qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdg3f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:40 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RHbIdq025534; Tue, 27 Feb 2024 17:43:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6we2v6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RHfGVO000491;
 Tue, 27 Feb 2024 17:43:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6we2v1c-5; Tue, 27 Feb 2024 17:43:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 04/10] migration: export migration_is_running
Date: Tue, 27 Feb 2024 09:43:21 -0800
Message-Id: <1709055807-315099-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1709055807-315099-1-git-send-email-steven.sistare@oracle.com>
References: <1709055807-315099-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270137
X-Proofpoint-ORIG-GUID: tcYvQkWnAkvSE3WETTMaBnjcGdK7Bqvc
X-Proofpoint-GUID: tcYvQkWnAkvSE3WETTMaBnjcGdK7Bqvc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Delete the MigrationState parameter from migration_is_running and move
it to the public API in misc.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h   |  1 +
 migration/migration.c      | 10 ++++++----
 migration/migration.h      |  2 --
 migration/options.c        |  4 ++--
 migration/savevm.c         |  2 +-
 system/dirtylimit.c        |  2 +-
 target/riscv/kvm/kvm-cpu.c |  4 ++--
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e1f1bf8..7526977 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -106,6 +106,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
+bool migration_is_running(void);
 /* ...and after the device transmission */
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
diff --git a/migration/migration.c b/migration/migration.c
index 4fb5b75..98bfc90 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1066,9 +1066,11 @@ bool migration_is_setup_or_active(void)
     }
 }
 
-bool migration_is_running(int state)
+bool migration_is_running(void)
 {
-    switch (state) {
+    MigrationState *s = current_migration;
+
+    switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
@@ -1444,7 +1446,7 @@ static void migrate_fd_cancel(MigrationState *s)
 
     do {
         old_state = s->state;
-        if (!migration_is_running(old_state)) {
+        if (!migration_is_running()) {
             break;
         }
         /* If the migration is paused, kick it out of the pause */
@@ -1929,7 +1931,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return true;
     }
 
-    if (migration_is_running(s->state)) {
+    if (migration_is_running()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return false;
     }
diff --git a/migration/migration.h b/migration/migration.h
index 736460a..e4983db 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -479,8 +479,6 @@ bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
-bool migration_is_running(int state);
-
 int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
diff --git a/migration/options.c b/migration/options.c
index 3e3e0b9..6e11d60 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -653,7 +653,7 @@ bool migrate_cap_set(int cap, bool value, Error **errp)
     MigrationState *s = migrate_get_current();
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
-    if (migration_is_running(s->state)) {
+    if (migration_is_running()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return false;
     }
@@ -697,7 +697,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     MigrationCapabilityStatusList *cap;
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
-    if (migration_is_running(s->state) || migration_in_colo_state()) {
+    if (migration_is_running() || migration_in_colo_state()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index d612c8a..44cf436 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1704,7 +1704,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     MigrationState *ms = migrate_get_current();
     MigrationStatus status;
 
-    if (migration_is_running(ms->state)) {
+    if (migration_is_running()) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return -EINVAL;
     }
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 051e031..1622bb7 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -451,7 +451,7 @@ static bool dirtylimit_is_allowed(void)
 {
     MigrationState *ms = migrate_get_current();
 
-    if (migration_is_running(ms->state) &&
+    if (migration_is_running() &&
         (!qemu_thread_is_self(&ms->thread)) &&
         migrate_dirty_limit() &&
         dirtylimit_in_service()) {
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 422e4f1..cf046db 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -44,7 +44,7 @@
 #include "kvm_riscv.h"
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "sysemu/runstate.h"
 #include "hw/riscv/numa.h"
 
@@ -700,7 +700,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
      * frequency. Therefore, we should check whether they are the same here
      * during the migration.
      */
-    if (migration_is_running(migrate_get_current()->state)) {
+    if (migration_is_running()) {
         KVM_RISCV_GET_TIMER(cs, frequency, reg);
         if (reg != env->kvm_timer_frequency) {
             error_report("Dst Hosts timer frequency != Src Hosts");
-- 
1.8.3.1


