Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD181CDD1D6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGb-00078w-8Q; Mon, 30 Sep 2024 15:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGW-0006sB-Rh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGU-00021E-Uc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuYaC012947;
 Mon, 30 Sep 2024 19:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=ndjvLJsdu51DMy7eDCtg/l0CqbKAOQKFVTo1vLFehdM=; b=
 cFjaQSYW42RNIEsUPPxrdGNCQvEeGaZRrLYFPdl+oYW4wFHwZ6JegAzlw/bQOEOc
 BtniwphJvPI8R3kzjGbFjlsj/pIcXNfaN8G1FlSVpCYzY7BetNt6ZmO/S7YEVOj1
 OV/CL4yaF7MhATLLq9pFelq/BQJ69tVK/0i18SiQbklxXfvca494alF+fCI0Mjx6
 8gLUvsfRb0f6aH0Mjb9ZDrxZ/3R4h+vvZ9w8e08DTUY0zM+om1GBgKOA0yb8pE8k
 UnCPaHRkozZ97OJdbeHMbgvIyjG+qPs1ftAJ9uIwB03OpAJdVb5OloepcD8GrsWP
 o2gPkMFCxYTNcNvt8hq8Nw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9mgbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:40:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UJWkVU012531; Mon, 30 Sep 2024 19:40:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868tuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:40:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepUq028204;
 Mon, 30 Sep 2024 19:40:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-5; Mon, 30 Sep 2024 19:40:57 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 04/13] migration: stop vm earlier for cpr
Date: Mon, 30 Sep 2024 12:40:35 -0700
Message-Id: <1727725244-105198-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300142
X-Proofpoint-ORIG-GUID: tShV9qcyZpla2sZqeAaAgbQVPBKXMRp8
X-Proofpoint-GUID: tShV9qcyZpla2sZqeAaAgbQVPBKXMRp8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Stop the vm earlier for cpr, to guarantee consistent device state when
CPR state is saved.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index df00e5c..868bf0e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2082,6 +2082,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
+    bool stopped = false;
 
     /*
      * Having preliminary checks for uri and channel
@@ -2125,6 +2126,15 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
+    if (migrate_mode_is_cpr(s)) {
+        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
+            goto out;
+        }
+        stopped = true;
+    }
+
     if (cpr_state_save(&local_err)) {
         goto out;
     }
@@ -2160,6 +2170,9 @@ out:
         }
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
+        if (stopped) {
+            vm_resume(s->vm_old_state);
+        }
         return;
     }
 }
@@ -3743,7 +3756,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
-    int ret;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -3815,14 +3827,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (migrate_mode_is_cpr(s)) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
-            goto fail;
-        }
-    }
-
     if (migrate_background_snapshot()) {
         qemu_thread_create(&s->thread, "mig/snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
-- 
1.8.3.1


