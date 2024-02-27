Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B576C54E41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Vp-0005Pi-FK; Tue, 27 Feb 2024 12:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Vn-0005Lh-5s
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:45:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Vl-0005YC-GI
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:45:02 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFYlJB009938; Tue, 27 Feb 2024 17:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=4W+9X9H6GcLZgCA7Dut/Gniehk9bd4kANbDWpPncF+k=;
 b=Bcd1nkaLH+yazRri0/ACesDdMvqc8tmI6ojYsm4/szRPwh9vc+RrKXQ7BIIDJ4++APup
 fMeDUcV8PB7LVPsVq+pBcIZQdd5EKAUdx3SIf1fsbK6Bm5jy0WyDixeyDQSXDs/snih6
 miaegN/0LG62VY8Sfib6fohzZPICoI4CK/BxY/AKW56DuRTUaakaxidjveNw1TGXDu4Z
 aat4lVehxuCOpe6IuiQhmcNtyj/LwZfa2SKR+y2Ka0LVaH/pMewBl/MRIT95S2brZqCg
 sMVvJ6AvgDf5CW0KxZyhm6VbjTKJrTfriVVZIKhtXqyGfT3xDQyagw/uqiEHR4GzdeJZ Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u7sn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:44:51 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RHKbDW025545; Tue, 27 Feb 2024 17:43:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6we2ved-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RHfGVa000491;
 Tue, 27 Feb 2024 17:43:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6we2v1c-11; Tue, 27 Feb 2024 17:43:49 +0000
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
Subject: [PATCH V1 10/10] migration: purge MigrationState from public interface
Date: Tue, 27 Feb 2024 09:43:27 -0800
Message-Id: <1709055807-315099-11-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: LAzNqv82H0pJ6Qj40QhutTU4ntu-y6J8
X-Proofpoint-ORIG-GUID: LAzNqv82H0pJ6Qj40QhutTU4ntu-y6J8
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

Delete unused accessors and move remaining MigrationState references
from the public file misc.h to the private file migration.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  9 ++-------
 migration/migration.c    | 10 ----------
 migration/migration.h    |  6 ++++++
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e521cd5..c9e200f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -64,7 +64,6 @@ bool migration_is_active(void);
 bool migration_is_device(void);
 bool migration_thread_is_self(void);
 bool migration_is_setup_or_active(void);
-bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
@@ -103,19 +102,15 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
-int migration_call_notifiers(MigrationState *s, MigrationEventType type,
-                             Error **errp);
-bool migration_in_setup(MigrationState *);
-bool migration_has_finished(MigrationState *);
-bool migration_has_failed(MigrationState *);
 bool migration_is_running(void);
 void migration_file_set_error(int err);
 
-/* ...and after the device transmission */
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
+
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
 bool migration_incoming_postcopy_advised(void);
+
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 4f65a98..703a9ee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1515,16 +1515,6 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
     return ret;
 }
 
-bool migration_in_setup(MigrationState *s)
-{
-    return s->state == MIGRATION_STATUS_SETUP;
-}
-
-bool migration_has_finished(MigrationState *s)
-{
-    return s->state == MIGRATION_STATUS_COMPLETED;
-}
-
 bool migration_has_failed(MigrationState *s)
 {
     return (s->state == MIGRATION_STATUS_CANCELLED ||
diff --git a/migration/migration.h b/migration/migration.h
index e4983db..8045e39 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -26,6 +26,7 @@
 #include "qom/object.h"
 #include "postcopy-ram.h"
 #include "sysemu/runstate.h"
+#include "migration/misc.h"
 
 struct PostcopyBlocktimeContext;
 
@@ -479,12 +480,17 @@ bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp);
+
 int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
 bool migration_postcopy_is_alive(int state);
 MigrationState *migrate_get_current(void);
+bool migration_has_failed(MigrationState *);
+bool migrate_mode_is_cpr(MigrationState *);
 
 uint64_t ram_get_total_transferred_pages(void);
 
-- 
1.8.3.1


