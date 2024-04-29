Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE35C19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMW-0004ra-0p; Mon, 29 Apr 2024 11:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMO-0004cz-NW
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMN-0005Jt-3K
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmsuG024847; Mon, 29 Apr 2024 15:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=AI42jKlapaNWs243JK/hObQrllWrnyUcajeE/W738TA=;
 b=FcJS/OuKbUH3kfJcEpWklLhtGQ6m3F1aWB+Fjr2vFGR/kfGL4WF64BH8W1PJo+IIiZS/
 wB9JnBCnkSlaCGCLg3eeL4e2C7aNiZ5m8MUc7+ZOS1t7etRtkuNEMdw1VK2BJbT2AwEI
 ZPEGQbbmJDUD5YH2BAjLmDX7MPT/zSU33FiweNH4pk3UMhdKck+48B8OQxwmU4IqYoaZ
 zxKX+3aSN3VlQ2FM2YcydPAUjBgyAhVcNRhrUNoosaWKj5pG1vuOXAhUDxd5hYaP4coa
 hhNfwF/PHEXUaN7JEF50zMVoUOb1hgRWL8ThQ27u6v/tporiV24YPss5uBemxUzrQ/5c vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetx4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:53 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TF0EUY011367; Mon, 29 Apr 2024 15:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaHA034442;
 Mon, 29 Apr 2024 15:55:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-22; Mon, 29 Apr 2024 15:55:51 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 21/26] migration: migrate_add_blocker_mode
Date: Mon, 29 Apr 2024 08:55:30 -0700
Message-Id: <1714406135-451286-22-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-ORIG-GUID: EIKLcuWjtaMHIii8TcXTb450Qi-Ljg7-
X-Proofpoint-GUID: EIKLcuWjtaMHIii8TcXTb450Qi-Ljg7-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Define a convenience function to add a migration blocker for a single mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/blocker.h | 7 +++++++
 migration/migration.c       | 5 +++++
 stubs/migr-blocker.c        | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/include/migration/blocker.h b/include/migration/blocker.h
index a687ac0..5c2e5d4 100644
--- a/include/migration/blocker.h
+++ b/include/migration/blocker.h
@@ -94,4 +94,11 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp);
  */
 int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...);
 
+/**
+ * @migrate_add_blocker_mode - prevent a mode of migration from proceeding
+ *
+ * Like migrate_add_blocker_modes, but for a single mode.
+ */
+int migrate_add_blocker_mode(Error **reasonp, MigMode mode, Error **errp);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 0d91531..4984dee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1769,6 +1769,11 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp)
     return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_NORMAL, -1);
 }
 
+int migrate_add_blocker_mode(Error **reasonp, MigMode mode, Error **errp)
+{
+    return migrate_add_blocker_modes(reasonp, errp, mode, -1);
+}
+
 int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
 {
     int modes;
diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index 11cbff2..150eb62 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -16,6 +16,11 @@ int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
     return 0;
 }
 
+int migrate_add_blocker_mode(Error **reasonp, MigMode mode, Error **errp)
+{
+    return 0;
+}
+
 void migrate_del_blocker(Error **reasonp)
 {
 }
-- 
1.8.3.1


