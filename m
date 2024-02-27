Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845AEC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Uf-0001iV-FO; Tue, 27 Feb 2024 12:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Ud-0001hd-8v
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:43:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Ub-0005Oo-Mi
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:43:51 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFY1Vl004798; Tue, 27 Feb 2024 17:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Us0ElZSbKhEozZPQ2Yq0/b2jdX4iAW9aGGOU48+UA5s=;
 b=gGsbFC2CtyftxqdnP0lJYQX8bKY0Q5VvGMt2z8zSgKV6Tro1lm/qePKWgUiqk2XoW9d0
 Hu3JmF0mnj2yX8Tcix6RfA12etq14qm8l2LOxHbJgQwzbFd4dJjy69vbOQbng2WO03+B
 sBSeA/sf3a46nZ45/bFZQnTY4jKYVChpLgZIflqlsXPNUcjDTYxr12kV1R0LviEsEYtS
 8xxZZLf/HhohztetfeDw8niM4dlfOJGujlCafkp27aWcof9xD58IztxdZ7cwM0t96uAp
 ishKDmqfNoWW+qckT7mJi8C90cMzH10Pi97yjvGcxI8hh3L31ojFOifEuC1nW8sg37WX MA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6vdyydq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:43 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RHNXRV025575; Tue, 27 Feb 2024 17:43:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6we2v9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:43 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RHfGVS000491;
 Tue, 27 Feb 2024 17:43:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6we2v1c-7; Tue, 27 Feb 2024 17:43:42 +0000
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
Subject: [PATCH V1 06/10] migration: migration_thread_is_self
Date: Tue, 27 Feb 2024 09:43:23 -0800
Message-Id: <1709055807-315099-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: cP-4sSm6C0ah8eIXVxyHdaU8j26Vw1C2
X-Proofpoint-GUID: cP-4sSm6C0ah8eIXVxyHdaU8j26Vw1C2
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

Define and export migration_thread_is_self to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h | 1 +
 migration/migration.c    | 7 +++++++
 system/dirtylimit.c      | 5 +----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 7526977..c4b5416 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(void);
+bool migration_thread_is_self(void);
 bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
 
diff --git a/migration/migration.c b/migration/migration.c
index 98bfc90..27af48c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1614,6 +1614,13 @@ bool migration_is_active(void)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
+bool migration_thread_is_self(void)
+{
+    MigrationState *s = current_migration;
+
+    return qemu_thread_is_self(&s->thread);
+}
+
 bool migrate_mode_is_cpr(MigrationState *s)
 {
     return s->parameters.mode == MIG_MODE_CPR_REBOOT;
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index b0afaa0..ab20da3 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -25,7 +25,6 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -448,10 +447,8 @@ static void dirtylimit_cleanup(void)
  */
 static bool dirtylimit_is_allowed(void)
 {
-    MigrationState *ms = migrate_get_current();
-
     if (migration_is_running() &&
-        (!qemu_thread_is_self(&ms->thread)) &&
+        !migration_thread_is_self() &&
         migrate_dirty_limit() &&
         dirtylimit_in_service()) {
         return false;
-- 
1.8.3.1


