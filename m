Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B31C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjm2-0001z5-Uj; Mon, 11 Mar 2024 13:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm0-0001yL-Nt
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjly-0008Uo-C4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:15 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG40Fp008047; Mon, 11 Mar 2024 17:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=f8GCt+gZn671HVbv/xnXQbZVpwcvOqcAziuggFQOfUk=;
 b=MG2pIIMb+8ahRNuV7qW0kkvB+6HuSryKzhan0Yg1JUXfBsDXbncdBmn7VWmDHbMjcQmD
 ne64zD0NzIxUanjL4y5FuNAT/dd8GgNuoeJZdIemj2w4ouPLHMj9dnxJNe+2/UDGO7PV
 P+uNbBQ+3ZruJPq/7XMAKqoHx6uWJ2wLF90Dg9LawW9+O7NdxEsyaru87ErGSYYgQqKd
 dZ5eCbHB4sD0EZ0Zb+OBOYCv7SCxgcjQ811jzBr5FXLryfZzWQ7Zj7ZHEsXVzBOwpXEx
 qxNDse8Hf/OAPmnEGJfzzUwYG3qSFLNNw2nM7qC8c+YGus3tqFOeNG2VncVEW6BwBKOZ tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdc22s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:07 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHkjb3028544; Mon, 11 Mar 2024 17:49:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre76334n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHck020033;
 Mon, 11 Mar 2024 17:49:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-4; Mon, 11 Mar 2024 17:49:06 +0000
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
Subject: [PATCH V2 03/11] migration: export migration_is_active
Date: Mon, 11 Mar 2024 10:48:50 -0700
Message-Id: <1710179338-294359-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110136
X-Proofpoint-ORIG-GUID: Q2jEYgQLbrNFgRAnVA59tM2moubwSzwA
X-Proofpoint-GUID: Q2jEYgQLbrNFgRAnVA59tM2moubwSzwA
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

Delete the MigrationState parameter from migration_is_active so it
can be exported and used without including migration.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c         |  4 ++--
 include/migration/misc.h |  2 +-
 migration/migration.c    | 10 ++++++----
 system/dirtylimit.c      |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 896eab8..2dbbf62 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -182,7 +182,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
-    if (ms->state != MIGRATION_STATUS_ACTIVE &&
+    if (!migration_is_active() &&
         ms->state != MIGRATION_STATUS_DEVICE) {
         return false;
     }
@@ -225,7 +225,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active(migrate_get_current())) {
+    if (!migration_is_active()) {
         return false;
     }
 
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 79cff62..e1f1bf8 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,7 +60,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
-bool migration_is_active(MigrationState *);
+bool migration_is_active(void);
 bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
 
diff --git a/migration/migration.c b/migration/migration.c
index af21403..17859cb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1406,7 +1406,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
-    assert(!migration_is_active(s));
+    assert(!migration_is_active());
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
@@ -1637,8 +1637,10 @@ bool migration_is_idle(void)
     return false;
 }
 
-bool migration_is_active(MigrationState *s)
+bool migration_is_active(void)
 {
+    MigrationState *s = current_migration;
+
     return (s->state == MIGRATION_STATUS_ACTIVE ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
@@ -3461,7 +3463,7 @@ static void *migration_thread(void *opaque)
 
     trace_migration_thread_setup_complete();
 
-    while (migration_is_active(s)) {
+    while (migration_is_active()) {
         if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
             MigIterateState iter_state = migration_iteration_run(s);
             if (iter_state == MIG_ITERATE_SKIP) {
@@ -3607,7 +3609,7 @@ static void *bg_migration_thread(void *opaque)
     migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
 
-    while (migration_is_active(s)) {
+    while (migration_is_active()) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
         if (iter_state == MIG_ITERATE_SKIP) {
             continue;
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 774ff44..051e031 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -83,7 +83,7 @@ static void vcpu_dirty_rate_stat_collect(void)
     int64_t period = DIRTYLIMIT_CALC_TIME_MS;
 
     if (migrate_dirty_limit() &&
-        migration_is_active(s)) {
+        migration_is_active()) {
         period = s->parameters.x_vcpu_dirty_limit_period;
     }
 
-- 
1.8.3.1


