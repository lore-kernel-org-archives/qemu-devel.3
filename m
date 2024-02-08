Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF44CC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9XU-0001Y8-Op; Thu, 08 Feb 2024 13:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XQ-0001U1-LM
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XO-0005nW-Uh
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:20 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418IjxcG009889; Thu, 8 Feb 2024 18:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=wuPyGOkKic+L90smhppp+iJseBpBIFQF2XB7aAHz2Ok=;
 b=cP/QQVxxduTgKmPDiwIPN/8su8Xcv5a7AmN7D8KtuBQdWJRJvwX9KZPr4EpxhI2Ypq+C
 7rK+GM0vVjAOFvy7YTVU0XjdZ/fuTrcKxWfxwrOcV492Jno6CErYqbFSwkST9hNg6IDI
 2neETSy4M1XJkFG+dGu9Lr1cDpXwvIl47KbjHD95GVYVK4IrJTG5ztuiXkNXfnjc2hr8
 E+GGjipz8DCJ59l5KPFeVkW8wE+cDrqJncs4mtG3rDQs0kJeEHcYsVT3UR53D1e1TyON
 ZpnjVDmwtoFeVf9X1olRo2bzp3yZW30ebLwIY8xqSSRu/6gtEMkli49SEuoeHQQ/BSe0 AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c945qaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:16 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418IkLW8038437; Thu, 8 Feb 2024 18:54:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawn53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:16 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq367013534;
 Thu, 8 Feb 2024 18:54:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-6; Thu, 08 Feb 2024 18:54:15 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 05/13] migration: remove postcopy_after_devices
Date: Thu,  8 Feb 2024 10:53:58 -0800
Message-Id: <1707418446-134863-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080099
X-Proofpoint-ORIG-GUID: t1j5jBi89qi06TgTgdhmHjoJKme73tU8
X-Proofpoint-GUID: t1j5jBi89qi06TgTgdhmHjoJKme73tU8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

postcopy_after_devices and migration_in_postcopy_after_devices are no
longer used, so delete them.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h | 1 -
 migration/migration.c    | 7 -------
 migration/migration.h    | 2 --
 3 files changed, 10 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index ff8cc57..7a51b45 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -80,7 +80,6 @@ bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
-bool migration_in_postcopy_after_devices(MigrationState *);
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
diff --git a/migration/migration.c b/migration/migration.c
index 82098ad..9a72680 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1519,11 +1519,6 @@ bool migration_postcopy_is_alive(int state)
     }
 }
 
-bool migration_in_postcopy_after_devices(MigrationState *s)
-{
-    return migration_in_postcopy() && s->postcopy_after_devices;
-}
-
 bool migration_in_incoming_postcopy(void)
 {
     PostcopyState ps = postcopy_state_get();
@@ -1605,7 +1600,6 @@ int migrate_init(MigrationState *s, Error **errp)
     s->expected_downtime = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
-    s->postcopy_after_devices = false;
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
@@ -2529,7 +2523,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    ms->postcopy_after_devices = true;
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
 
     migration_downtime_end(ms);
diff --git a/migration/migration.h b/migration/migration.h
index f2c8b8f..aef8afb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -348,8 +348,6 @@ struct MigrationState {
 
     /* Flag set once the migration has been asked to enter postcopy */
     bool start_postcopy;
-    /* Flag set after postcopy has sent the device state */
-    bool postcopy_after_devices;
 
     /* Flag set once the migration thread is running (and needs joining) */
     bool migration_thread_running;
-- 
1.8.3.1


