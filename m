Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726DAC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjm4-0001zy-Gx; Mon, 11 Mar 2024 13:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm3-0001z6-1A
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm0-0008VJ-Nc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG46gw011922; Mon, 11 Mar 2024 17:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=kPPyuXR3TbfdMvzDMiVFYZPVWKrI1P7MQXcb2jd/PGA=;
 b=h83aJwBKCWg+z2/t5GR79gJhVB6BmnUzpfFsAy6J6fxwRKb3rxaqaqU4AS7cHk0AOqSu
 3Nw52L8Y01MONK5DxkStj0FqdsyuwpBPtEsh3gRPbycSvtbsNEgO9hPCaoSFlAEFQCy4
 B7rmGG49CT3YVS4bXr4W04qrqjlHtU2Yt9X/gu52PkfDptJRlIrFwp+XiNB4QFTQVf5y
 8P1chAp42eUDfxZhwoXZkYsJFCRK8d3y1ehmkpYMVvDQed5W9PEhoVKFCoOLQXocNmoV
 2EC/DgcIGcNCtqE9NipNznJ8LXkHI4kEWQG3PDkv3ob7Zryd+5LIvIMwqkqy42L1M9wB yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ec108-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:10 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHhxF0028547; Mon, 11 Mar 2024 17:49:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre76336g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHco020033;
 Mon, 11 Mar 2024 17:49:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-6; Mon, 11 Mar 2024 17:49:09 +0000
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
Subject: [PATCH V2 05/11] migration: export vcpu_dirty_limit_period
Date: Mon, 11 Mar 2024 10:48:52 -0700
Message-Id: <1710179338-294359-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: ovxtNXj30D8fbF3Pgmcz7GCtug6p1XtE
X-Proofpoint-ORIG-GUID: ovxtNXj30D8fbF3Pgmcz7GCtug6p1XtE
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

Define and export vcpu_dirty_limit_period to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/client-options.h | 1 +
 migration/options.c                | 7 +++++++
 system/dirtylimit.c                | 3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 887fea1..59f4b55 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -20,5 +20,6 @@ bool migrate_switchover_ack(void);
 /* parameters */
 
 MigMode migrate_mode(void);
+uint64_t migrate_vcpu_dirty_limit_period(void);
 
 #endif
diff --git a/migration/options.c b/migration/options.c
index 642cfb0..09178c6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -924,6 +924,13 @@ const char *migrate_tls_hostname(void)
     return s->parameters.tls_hostname;
 }
 
+uint64_t migrate_vcpu_dirty_limit_period(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.x_vcpu_dirty_limit_period;
+}
+
 uint64_t migrate_xbzrle_cache_size(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 1622bb7..b0afaa0 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -77,14 +77,13 @@ static bool dirtylimit_quit;
 
 static void vcpu_dirty_rate_stat_collect(void)
 {
-    MigrationState *s = migrate_get_current();
     VcpuStat stat;
     int i = 0;
     int64_t period = DIRTYLIMIT_CALC_TIME_MS;
 
     if (migrate_dirty_limit() &&
         migration_is_active()) {
-        period = s->parameters.x_vcpu_dirty_limit_period;
+        period = migrate_vcpu_dirty_limit_period();
     }
 
     /* calculate vcpu dirtyrate */
-- 
1.8.3.1


