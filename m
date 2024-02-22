Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C78C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsZ-0004lh-Te; Thu, 22 Feb 2024 12:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsT-0004jD-O5
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsS-0003DI-BG
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH95SR014861; Thu, 22 Feb 2024 17:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=OISgfmaC8XJcvMA2hWN919WhOcj2Y49PcJ1f27Elswc=;
 b=DKfoEiC/20fnO89Wq26Sl52MuJ+jEQRaSRIJqok3PAZ8aNpEAiFiGiU5KRkf1KgHcYs6
 6VwDT8U53TVsZyrzQH+GgfNsP+aJ+nU5vQeRVpw8Nfdlldbl8cCp76txbygXx0heBqdD
 7TxoerOq6sFHJ65yRBqE8zzVHNoUqNArh/9Q7FTNjobLtGYyAMqXzdR1NoJKYexjN9iZ
 lDKOFW4BznBoRI3u7Q2mMW4IkzAXXeMdAuJvCDpb6el5GKBC1tT/B6SdnNfU+ixmizFA
 I5an1ilXoNWmDPzipzmx6NPyaehJBpbGLaeQFqSDiC9jj4yFAZw5tSK0fLSscM/Tawwi Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu58e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:55 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MGE5cn024480; Thu, 22 Feb 2024 17:28:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSgA5032453;
 Thu, 22 Feb 2024 17:28:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-9; Thu, 22 Feb 2024 17:28:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 08/14] migration: refactor migrate_fd_connect failures
Date: Thu, 22 Feb 2024 09:28:34 -0800
Message-Id: <1708622920-68779-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: J49Lw5vCIUV0Btx8HMVxy92ScYL1GuEM
X-Proofpoint-ORIG-GUID: J49Lw5vCIUV0Btx8HMVxy92ScYL1GuEM
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

Move common code for the error path in migrate_fd_connect to a shared
fail label.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 migration/migration.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 925103b..6a115d2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3627,11 +3627,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
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
 
@@ -3660,6 +3656,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
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


