Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977FEC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjm6-00020O-78; Mon, 11 Mar 2024 13:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm4-0001zc-94
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm2-0008Vo-Jx
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:20 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG40Ao008065; Mon, 11 Mar 2024 17:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=zkKxsXar5+UvJQxlj+egXI79LphE/bIcj+yssMuzZok=;
 b=YLCbgwXCVX/Yo/R0yNk4hn0/K+kuLTiGHPKgHSmbNBRJA0+Yae6IvF0vKjXi7y65w4I7
 AnMbnHOZyTk4SaV8Mz+efw5oTZqH1WsD81sLB4cxSPJcP7uYA8Rkj/2bomSu8V0tSfUF
 GdmJC7Ys8R/eItZNp2jJFuAyZKrlh94XrwdGTRzkpHPe/VA8Ye81HsUOBCfqjfwWYHTf
 Hkw3oNQi5Bi7l1FcLd/6RilbOT42byVtwFeaDUnEsVzkwc7+ISab5Ji/Prz0JlwzOFCi
 5pgLydLZf1EBFJUVF/0x8Oyfr+ChxWsNJiMnZ49hflw5BpXEDw+XHaLALUeMdcEXv9XB XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdc234-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:12 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHVj70028519; Mon, 11 Mar 2024 17:49:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre76337j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHcq020033;
 Mon, 11 Mar 2024 17:49:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-7; Mon, 11 Mar 2024 17:49:11 +0000
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
Subject: [PATCH V2 06/11] migration: migration_thread_is_self
Date: Mon, 11 Mar 2024 10:48:53 -0700
Message-Id: <1710179338-294359-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: Bbtgc4ejMVfV18yiwEUswp4hp5d7FyXU
X-Proofpoint-GUID: Bbtgc4ejMVfV18yiwEUswp4hp5d7FyXU
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
index 546ba86..afe72af 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1647,6 +1647,13 @@ bool migration_is_active(void)
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


