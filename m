Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2DFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrY-0005YD-PM; Wed, 01 Oct 2025 11:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yrO-0005PH-F4
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqq-0006T9-Pg
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:17 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMuKw011249;
 Wed, 1 Oct 2025 15:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=/4bP+ryAhXXRxYY1+19b3HaooGvBOw0iFgyZHOI6rVU=; b=
 o0FHjGM2NWxPzQ9qLl5gq8fX/IxcyRJ7ASzsndFCERwL2V7o2ved3UEFk9VZ57i9
 a75k1pyGIqcSEWC2/bTm4wQCV86QaBHQv07kLQVEbV47SgMcS492z5+DgmWGfc6e
 6yGRS4GmG/Xd/joJMlb1hd43Si4IeGHYWNJu+wz0YgQbV8exSTU6ZxhG74XXCCgy
 AufcZAbRWAzj6yEdE25Ib7IhDV2e6BT/AaOhfZaT1Q/LvULBpnk2Pk+vqHAY7LsN
 lfXfscq/dQWoFWufmauliJz0FuBvBE/1wBAQBHw+Zj6pWYKsjw6reEj2Hc1Krx7j
 AUZtZbJgVnaVju9GsJy+Xg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacspwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EmP86023287; Wed, 1 Oct 2025 15:34:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCrA014790;
 Wed, 1 Oct 2025 15:34:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-17; Wed, 01 Oct 2025 15:34:23 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 16/19] migration-test: misc exports
Date: Wed,  1 Oct 2025 08:34:08 -0700
Message-Id: <1759332851-370353-17-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dd4a02 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=2nCFX4KoIgSfmLCypf8A:9
X-Proofpoint-ORIG-GUID: qernGPT4tMjKWdw8MNbaJqxUlNw4Y45u
X-Proofpoint-GUID: qernGPT4tMjKWdw8MNbaJqxUlNw4Y45u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX5grmA2huSQ1Y
 IHStdgNy2xhOCv0NGz9/UR47mnj4t+QkY2b2cdazzV2TqQEfPKMPlrzjHIie7uMCQJsw8hz39/S
 IGQTyreFKNFJnlDHY6uTqr5i1N1GlSzCq/yy9WWGvz9D7pykfKY2nEtRbYZALPaABUtilXoKq2l
 mbHdZgzaSblSt8rGhpjYSJ+LQXj06wXerVRBdYl3xvdWsp5l4xUKaMU9SJW0f62kkuOE5nUgT10
 PC2joq9BTfmqoPrIMTaSwbE3xweahIjWP5LdrdrcuqovLvb5lyng9w/OG97S8Z59GxpDo2G+ovK
 aLVQwlrfnOOZQGlii21EkC8+DnwYjaPadFZKCUKgaGI7LflNafKGzsNoT+xgk1+1QjLyaxJZ/vT
 4Ml6lPdCq1SBiIYkoP5wyfrKPpBkig==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Export misc definitions needed by the cpr-exec test.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/bootfile.h  | 1 +
 tests/qtest/migration/framework.h | 1 +
 tests/qtest/migration/bootfile.c  | 5 +++++
 tests/qtest/migration/framework.c | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index 6d6a673..96e784b 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -35,5 +35,6 @@
 
 void bootfile_delete(void);
 char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
+char *bootfile_get(void);
 
 #endif /* BOOTFILE_H */
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index f1bb9d4..ba7145a 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -237,6 +237,7 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
 
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
+QTestMigrationState *get_dst(void);
 
 #ifdef CONFIG_GNUTLS
 void migration_test_add_tls(MigrationTestEnv *env);
diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index fac059d..479c432 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -68,3 +68,8 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
 
     return bootpath;
 }
+
+char *bootfile_get(void)
+{
+    return bootpath;
+}
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 9d04f36..ca13477 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1005,6 +1005,11 @@ QTestMigrationState *get_src(void)
     return &src_state;
 }
 
+QTestMigrationState *get_dst(void)
+{
+    return &dst_state;
+}
+
 MigrationTestEnv *migration_get_env(void)
 {
     static MigrationTestEnv *env;
-- 
1.8.3.1


