Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C079C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9Xb-0001ai-Ch; Thu, 08 Feb 2024 13:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XW-0001YL-4v
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XU-0005ob-Li
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418IkIrU009749; Thu, 8 Feb 2024 18:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=iSIfqSBMc39ZjucLn8EacCTbQQWpPMUX085KAVl1IGM=;
 b=IL1JbLelLUeso9PLL7MacPOediwnKpy/VtqBaLLnM+WuPuyTdaLYDZM1Jzk3kbAlzdmE
 HopwsK1kBbRKmuWRDryulHko4cy5FRqUZKrANIG3LXZBHbp/eldoafeoP2xJv1G6sYbQ
 s8zxljC2qOrPDa4xYw9cAJ8sMQAfbiFUbCRZMu4B14keYo+77T4sQa1uafLNP3WE2Xbg
 hgDPt3lV36OTDlijckMjjoCg4kp/Q1+iZ2ymjT1Sua5qlw3IdtD/2x8Oy7V2SY/CNodW
 o15bANMM3ZGsv3x0R/PUYQAycwDrYgqT/9dY2iuSRwVSOQe1Y2LZDiywQtgTxiKCoF/e 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3unk2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:22 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418IKM3j038388; Thu, 8 Feb 2024 18:54:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawnay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq36D013534;
 Thu, 8 Feb 2024 18:54:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-9; Thu, 08 Feb 2024 18:54:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 08/13] migration: refactor migrate_fd_connect failures
Date: Thu,  8 Feb 2024 10:54:01 -0800
Message-Id: <1707418446-134863-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: rhJ4gMNuKswg2sT0ZgQ9UURrhVakP2Lm
X-Proofpoint-GUID: rhJ4gMNuKswg2sT0ZgQ9UURrhVakP2Lm
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

Move common code for the error path in migrate_fd_connect to a shared
fail label.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1601a03..01d8867 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3608,11 +3608,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     if (migrate_postcopy_ram() || migrate_return_path()) {
         if (open_return_path_on_source(s)) {
             error_setg(&local_err, "Unable to open return-path for postcopy");
-            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
-            migrate_set_error(s, local_err);
-            error_report_err(local_err);
-            migrate_fd_cleanup(s);
-            return;
+            goto fail;
         }
     }
 
@@ -3634,12 +3630,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (multifd_save_setup(&local_err) != 0) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
-        migrate_fd_cleanup(s);
-        return;
+        goto fail;
     }
 
     if (migrate_background_snapshot()) {
@@ -3650,6 +3641,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
                 migration_thread, s, QEMU_THREAD_JOINABLE);
     }
     s->migration_thread_running = true;
+    return;
+
+fail:
+    migrate_set_error(s, local_err);
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    error_report_err(local_err);
+    migrate_fd_cleanup(s);
 }
 
 static void migration_class_init(ObjectClass *klass, void *data)
-- 
1.8.3.1


