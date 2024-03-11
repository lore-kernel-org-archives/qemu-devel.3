Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC12EC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjnL-0002hi-1v; Mon, 11 Mar 2024 13:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjmQ-0002FS-BE
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjmM-00005N-4U
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG3qIs020992; Mon, 11 Mar 2024 17:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=CXu+I0wD9F3wTOk6O4uWq+bLY8upTF2MH6D/Sc6o/rw=;
 b=kxwHv3y1w/kxP6uVm63ECOtYsS6tOX8LZot353FBYXiESrw74BIkIm9MX6oXZpqRLNTR
 pFPj1pXv6kz69vRzem9fY9JmqzzhyvwkRZNENg+ZHiwYthcuGOZCc/fCZtZp+HosBdDJ
 Ik5d8fMfCeSt7lfiDnDWV9aCsmISRgBTeNK4LNzsvJfYEqtWhkUqRl7//blFs04sAHug
 fCfht66a8QC6zhOfMXzFdSpJb4kTV4XLSo+D6CFPx6Wu/SmDtGYo4Zlva5lNKXN34hxP
 ryax/XDGnoyp5khgosN/JcuRuBCuhl87zavH3+nzJFY9PEWQsJv+8UXVAJprjQ1/IJEw eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcuc11b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:21 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHd01E028530; Mon, 11 Mar 2024 17:49:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7633e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHd2020033;
 Mon, 11 Mar 2024 17:49:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-12; Mon, 11 Mar 2024 17:49:20 +0000
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
Subject: [PATCH V2 11/11] migration: purge MigrationState from public interface
Date: Mon, 11 Mar 2024 10:48:58 -0700
Message-Id: <1710179338-294359-12-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: 9KzciZ2JDcryCQtAKVXmEib3Ro479Esl
X-Proofpoint-GUID: 9KzciZ2JDcryCQtAKVXmEib3Ro479Esl
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

Move remaining MigrationState references from the public file
misc.h to the private file migration.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h | 6 ++----
 migration/migration.h    | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index d563d2c..c9e200f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -64,7 +64,6 @@ bool migration_is_active(void);
 bool migration_is_device(void);
 bool migration_thread_is_self(void);
 bool migration_is_setup_or_active(void);
-bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
@@ -103,16 +102,15 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
-int migration_call_notifiers(MigrationState *s, MigrationEventType type,
-                             Error **errp);
-bool migration_has_failed(MigrationState *);
 bool migration_is_running(void);
 void migration_file_set_error(int err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
+
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
 bool migration_incoming_postcopy_advised(void);
+
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
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


