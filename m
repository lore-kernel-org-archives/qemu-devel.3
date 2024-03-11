Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F261C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjm0-0001yN-Uz; Mon, 11 Mar 2024 13:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjlz-0001xs-Te
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjlx-0008Ub-QK
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG3pdt020981; Mon, 11 Mar 2024 17:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=gxgLnnp934i6FDmq9Wme3lEwAj4uQvZ6UCowlpA+g+g=;
 b=RRsWT9RZ5011ziiTukroXzHu6R2ctC2PkdqSwWlKgyO77GY6Yl3YQ1NDMwxNUamiPItK
 Q0tyX8ChxN9NvZV5NSgSTGvS7XHQkuXY71LbRn7yohqd0IIVEVx/RPQE6TEvBhtgFwKW
 kfaEQuehKrc2N4MlZ4T6E2kNHUlDN2bC7BMJ4AEhnv0nHx57cXXq1WjB/1SE6gv5li3V
 h8vD5muXTp0NqMnfXJRz2h5ctiv2TO9FcafhiSaRToyGWRz1cb6+PCRy/S96HFfpZrE6
 IquMVCfotohDscluY4K7dVH1tsh9VEqoYFLNqjST9yJKpByoaK93le2bOYcgCouy8qzX Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcuc0yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:05 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHexvJ028568; Mon, 11 Mar 2024 17:49:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre763339-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHci020033;
 Mon, 11 Mar 2024 17:49:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-3; Mon, 11 Mar 2024 17:49:04 +0000
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
Subject: [PATCH V2 02/11] migration: export migration_is_setup_or_active
Date: Mon, 11 Mar 2024 10:48:49 -0700
Message-Id: <1710179338-294359-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110136
X-Proofpoint-ORIG-GUID: o2O7xd7zDaSiYlxho-6rYlDt6kyJNJll
X-Proofpoint-GUID: o2O7xd7zDaSiYlxho-6rYlDt6kyJNJll
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

Delete the MigrationState parameter from migration_is_setup_or_active
and move it to the public API in misc.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/common.c         |  2 +-
 include/migration/misc.h |  1 +
 migration/migration.c    | 12 ++++++------
 migration/migration.h    |  1 -
 migration/ram.c          |  5 ++---
 net/vhost-vdpa.c         |  3 +--
 6 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc..896eab8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -152,7 +152,7 @@ static void vfio_set_migration_error(int err)
 {
     MigrationState *ms = migrate_get_current();
 
-    if (migration_is_setup_or_active(ms->state)) {
+    if (migration_is_setup_or_active()) {
         WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
             if (ms->to_dst_file) {
                 qemu_file_set_error(ms->to_dst_file, err);
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4c226a4..79cff62 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
diff --git a/migration/migration.c b/migration/migration.c
index a49fcd5..af21403 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1081,9 +1081,11 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
  * Return true if we're already in the middle of a migration
  * (i.e. any of the active or setup states)
  */
-bool migration_is_setup_or_active(int state)
+bool migration_is_setup_or_active(void)
 {
-    switch (state) {
+    MigrationState *s = current_migration;
+
+    switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
@@ -1601,10 +1603,8 @@ bool migration_incoming_postcopy_advised(void)
 
 bool migration_in_bg_snapshot(void)
 {
-    MigrationState *s = migrate_get_current();
-
     return migrate_background_snapshot() &&
-            migration_is_setup_or_active(s->state);
+           migration_is_setup_or_active();
 }
 
 bool migration_is_idle(void)
@@ -2297,7 +2297,7 @@ static void *source_return_path_thread(void *opaque)
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
-    while (migration_is_setup_or_active(ms->state)) {
+    while (migration_is_setup_or_active()) {
         trace_source_return_path_thread_loop_top();
 
         header_type = qemu_get_be16(rp);
diff --git a/migration/migration.h b/migration/migration.h
index 65c0b61..736460a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -479,7 +479,6 @@ bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
-bool migration_is_setup_or_active(int state);
 bool migration_is_running(int state);
 
 int migrate_init(MigrationState *s, Error **errp);
diff --git a/migration/ram.c b/migration/ram.c
index c79e3de..b8a5b67 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2909,10 +2909,9 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
     RAMBlock *block;
     ram_addr_t offset;
     size_t used_len, start, npages;
-    MigrationState *s = migrate_get_current();
 
     /* This function is currently expected to be used during live migration */
-    if (!migration_is_setup_or_active(s->state)) {
+    if (!migration_is_setup_or_active()) {
         return;
     }
 
@@ -3257,7 +3256,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
 out:
     if (ret >= 0
-        && migration_is_setup_or_active(migrate_get_current()->state)) {
+        && migration_is_setup_or_active()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
             ret = multifd_send_sync_main();
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e6bdb45..8564817 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -26,7 +26,6 @@
 #include <err.h>
 #include "standard-headers/linux/virtio_net.h"
 #include "monitor/monitor.h"
-#include "migration/migration.h"
 #include "migration/misc.h"
 #include "hw/virtio/vhost.h"
 
@@ -355,7 +354,7 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->always_svq ||
-        migration_is_setup_or_active(migrate_get_current()->state)) {
+        migration_is_setup_or_active()) {
         v->shadow_vqs_enabled = true;
     } else {
         v->shadow_vqs_enabled = false;
-- 
1.8.3.1


