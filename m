Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DFDC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsw-0005bO-3K; Thu, 22 Feb 2024 12:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsu-0005U2-2F
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsr-0003KF-To
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH9aGn031377; Thu, 22 Feb 2024 17:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=wVz1B2cs/KV7XZxdXZrfE7CvTr69TpbqwHL6XmEN+qU=;
 b=ku8yryDrKE3red+r8gwv4RZML4qGZA/vLKAXOaQ799xwFJE9VQyOH52k37Evk+/jquTW
 3pXeasRt0yyZo+cUrc0h1hSNWNhXmj34+PYbLmqxmPx4Z3TQ1pqavf9KUejrE/sguAUz
 DUfqzFQibDSLsPUvrxKfKGZgG1afbpWIEv8T1lpMfCpmFmhKH4Z/au2Tw4rv7W7db6bc
 GvyKYbtmUthCkkEwXUU9mdGZTNWTyKDew5JjLZKW7uauZEJoF6gX2qVUgqnanKrrkOft
 RQ99jaZLHIHNZzOpCMQKo2SQBFEnvdShuay0QkmKFG4sMVvR/jUW6FlSrKcBFLcYl6uY Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2dfyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:29:20 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MHSVQp024791; Thu, 22 Feb 2024 17:29:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ays03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:29:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSgAH032453;
 Thu, 22 Feb 2024 17:29:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-15; Thu, 22 Feb 2024 17:29:02 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 14/14] migration: options incompatible with cpr
Date: Thu, 22 Feb 2024 09:28:40 -0800
Message-Id: <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: GD-xtRYXNFAjQWLWt2k1e94V9rvhjn2J
X-Proofpoint-ORIG-GUID: GD-xtRYXNFAjQWLWt2k1e94V9rvhjn2J
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fail the migration request if options are set that are incompatible
with cpr.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 17 +++++++++++++++++
 qapi/migration.json   |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 90a9094..7652fd4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1953,6 +1953,23 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (migrate_mode_is_cpr(s)) {
+        const char *conflict = NULL;
+
+        if (migrate_postcopy()) {
+            conflict = "postcopy";
+        } else if (migrate_background_snapshot()) {
+            conflict = "background snapshot";
+        } else if (migrate_colo()) {
+            conflict = "COLO";
+        }
+
+        if (conflict) {
+            error_setg(errp, "Cannot use %s with CPR", conflict);
+            return false;
+        }
+    }
+
     if (blk || blk_inc) {
         if (migrate_colo()) {
             error_setg(errp, "No disk migration is required in COLO mode");
diff --git a/qapi/migration.json b/qapi/migration.json
index 0990297..c6bfe2e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -657,6 +657,8 @@
 #     shared backend must be be non-volatile across reboot, such as by backing
 #     it with a dax device.
 #
+#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
+#
 #     (since 8.2)
 ##
 { 'enum': 'MigMode',
-- 
1.8.3.1


