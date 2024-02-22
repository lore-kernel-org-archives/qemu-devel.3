Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168A9C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsW-0004k1-4I; Thu, 22 Feb 2024 12:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsS-0004im-G6
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsQ-0003Cz-Rc
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:56 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH93lc014694; Thu, 22 Feb 2024 17:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=KlJLh/6RU9GLdY8NyeX3J6nBDN5nwI4L14aZ20jhEbc=;
 b=Ti62egYAtZB8gEtBIkRZ+MKAerwK5f8rfnOmXFg8gnH6N3jaSK0PHj/X5iHd/kO84bRa
 B2RSMatTS2sBcxmtKHW/EfwcWgbgOJyUYD/a14zKp4locxaRYEl1QGXv4H1PrmB9h0v9
 2IAqRezxRCY+rEsY+4aWkua36XCnPoFeULXmd7RZndHMVITS/GFpEsviGXvhK6U+OWMO
 0OtdyzWpLRCBGvqSH/dLtTfuhrxpuNS69BxjQm848XoT7Ku5PP44pNctKO3GXFINFpK6
 paC94ash0IVe09NV0Q+yrCHGJfGhWaA/6lxkgGENUkhQ3thFlbQ8BzL+B1oqA7fSAv7G 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu58ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:53 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MG9MZh024755; Thu, 22 Feb 2024 17:28:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSg9x032453;
 Thu, 22 Feb 2024 17:28:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-6; Thu, 22 Feb 2024 17:28:49 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 05/14] migration: remove postcopy_after_devices
Date: Thu, 22 Feb 2024 09:28:31 -0800
Message-Id: <1708622920-68779-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220138
X-Proofpoint-GUID: rSiiiyi-nNn1Y4_VZDHmHx6moZj8XFEo
X-Proofpoint-ORIG-GUID: rSiiiyi-nNn1Y4_VZDHmHx6moZj8XFEo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/migration.c    | 7 -------
 migration/migration.h    | 2 --
 3 files changed, 10 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 9e4abae..e615000 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -89,7 +89,6 @@ bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
-bool migration_in_postcopy_after_devices(MigrationState *);
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
diff --git a/migration/migration.c b/migration/migration.c
index 4650c21..8f7f2d9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1527,11 +1527,6 @@ bool migration_postcopy_is_alive(int state)
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
@@ -1613,7 +1608,6 @@ int migrate_init(MigrationState *s, Error **errp)
     s->expected_downtime = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
-    s->postcopy_after_devices = false;
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
@@ -2543,7 +2537,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
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


