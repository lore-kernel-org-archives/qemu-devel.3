Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA07C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Vj-000599-5S; Tue, 27 Feb 2024 12:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Vh-0004ub-PN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:44:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Vg-0005Xe-8c
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:44:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFYlhA009942; Tue, 27 Feb 2024 17:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=6Y1uHgkezRM1sw8qKzgdmDiay3ONQK/YHE7lFgyAY2M=;
 b=KayDhQzJNbH9PTAATeNOi9tqyDQz8tnQfvpbx2kM0TvK3QSipm3eh1fKM6HRmVIJriRI
 /NFKDrPGR6YvNEIyFzbfcwXP28fWp+AZBqH7n3T+dJfeuS2HxYy6xLRfEzHkoq5LqGzn
 m6+8EdPwf9tuR2L6qFmyPC+p6/UT84gLspF2gu/zJZMkG+uT2MkRoxu1jHl3G/g3RNjx
 vuCNDQ/1n+bPJSAt+nQX2/yBt+wLusD5BQLnNyKz7iQWmTDcmzQTkQSDijYX6KuqVjNE
 fdTCrDgBN8FfT4PYILJ8Tr9tUFowk2leiqfCmfsdnKG+lBcfqvoUmPNHjR5QHIe3Yz8V 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u7smm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:44:48 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RHXWKt025495; Tue, 27 Feb 2024 17:43:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6we2vb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RHfGVU000491;
 Tue, 27 Feb 2024 17:43:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6we2v1c-8; Tue, 27 Feb 2024 17:43:44 +0000
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
Subject: [PATCH V1 07/10] migration: migration_is_device
Date: Tue, 27 Feb 2024 09:43:24 -0800
Message-Id: <1709055807-315099-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: AoHyoVs5ARlc1qdR1y1dVzOHZ4dxJlcj
X-Proofpoint-ORIG-GUID: AoHyoVs5ARlc1qdR1y1dVzOHZ4dxJlcj
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

Define and export migration_is_device to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c         | 4 +---
 include/migration/misc.h | 1 +
 migration/migration.c    | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2dbbf62..de01068 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -180,10 +180,8 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
-    MigrationState *ms = migrate_get_current();
 
-    if (!migration_is_active() &&
-        ms->state != MIGRATION_STATUS_DEVICE) {
+    if (!migration_is_active() && !migration_is_device()) {
         return false;
     }
 
diff --git a/include/migration/misc.h b/include/migration/misc.h
index c4b5416..28cfaed 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(void);
+bool migration_is_device(void);
 bool migration_thread_is_self(void);
 bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 27af48c..6b386af 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1614,6 +1614,13 @@ bool migration_is_active(void)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
+bool migration_is_device(void)
+{
+    MigrationState *s = current_migration;
+
+    return s->state == MIGRATION_STATUS_DEVICE;
+}
+
 bool migration_thread_is_self(void)
 {
     MigrationState *s = current_migration;
-- 
1.8.3.1


