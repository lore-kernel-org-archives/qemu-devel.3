Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1F6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMO-0004cT-5Z; Mon, 29 Apr 2024 11:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMI-0004Y4-2S
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMF-0005KS-D8
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFnaSJ028140; Mon, 29 Apr 2024 15:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=fw5vl/gUrGf8tdC1SZLnUmsT4rLdaGW9sQv+fRKn54c=;
 b=Xm601FTQxdGx5a1MU96jZyMrjHsSJOr2BmCwl42Vscvn5khy98rCS6hEDnjP2Uo27liJ
 AedR8f0SmOH8aAMGMDx6Q9Ww0HreoV+dykYweGi9ElhLac2mrg7r1CFydmJzfgxR7tRt
 GyvdlAe0q7XUDhh2QJkb6ObUaPYlcsRqDuW9X4yTs81S0b87qE232Bn7eH8gEYOpmUYh
 D/k5QMDZvHCWu3/bWkb4/UKjwPqSTttv1T6httpt5zfXGWD/YswD3ZPlZs/17y3TdpWj
 8C0j0dtmMAISFxe5oiH0X4b1NP7rPRcSODWlMT9OJUd6arPctKTAETKlMwE255Po1wVK 8Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvjxsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:55 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFtTbm011394; Mon, 29 Apr 2024 15:55:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:54 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaHG034442;
 Mon, 29 Apr 2024 15:55:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-25; Mon, 29 Apr 2024 15:55:54 +0000
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
Subject: [PATCH V1 24/26] seccomp: cpr-exec blocker
Date: Mon, 29 Apr 2024 08:55:33 -0700
Message-Id: <1714406135-451286-25-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Eyz1nINE8TlboDT8f6RUbRVTAFCt2zH7
X-Proofpoint-ORIG-GUID: Eyz1nINE8TlboDT8f6RUbRVTAFCt2zH7
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpr-exec mode needs permission to exec.  Block it if permission is denied.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/seccomp.h |  1 +
 system/qemu-seccomp.c    | 10 ++++++++--
 system/vl.c              |  6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index fe85989..023c0a1 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -22,5 +22,6 @@
 #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
 
 int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp);
+uint32_t qemu_seccomp_get_opts(void);
 
 #endif
diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index 5c20ac0..0d2a561 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -360,12 +360,18 @@ static int seccomp_start(uint32_t seccomp_opts, Error **errp)
     return rc < 0 ? -1 : 0;
 }
 
+static uint32_t seccomp_opts;
+
+uint32_t qemu_seccomp_get_opts(void)
+{
+    return seccomp_opts;
+}
+
 int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
 {
     if (qemu_opt_get_bool(opts, "enable", false)) {
-        uint32_t seccomp_opts = QEMU_SECCOMP_SET_DEFAULT
-                | QEMU_SECCOMP_SET_OBSOLETE;
         const char *value = NULL;
+        seccomp_opts = QEMU_SECCOMP_SET_DEFAULT | QEMU_SECCOMP_SET_OBSOLETE;
 
         value = qemu_opt_get(opts, "obsolete");
         if (value) {
diff --git a/system/vl.c b/system/vl.c
index 7252100..b76881e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -76,6 +76,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
@@ -2493,6 +2494,11 @@ static void qemu_process_early_options(void)
     QemuOptsList *olist = qemu_find_opts_err("sandbox", NULL);
     if (olist) {
         qemu_opts_foreach(olist, parse_sandbox, NULL, &error_fatal);
+        if (qemu_seccomp_get_opts() & QEMU_SECCOMP_SET_SPAWN) {
+            Error *blocker = NULL;
+            error_setg(&blocker, "-sandbox denies exec for cpr-exec");
+            migrate_add_blocker_mode(&blocker, MIG_MODE_CPR_EXEC, &error_fatal);
+        }
     }
 #endif
 
-- 
1.8.3.1


