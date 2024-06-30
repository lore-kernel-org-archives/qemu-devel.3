Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC92C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0Q5-00008R-7Y; Sun, 30 Jun 2024 15:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pw-0008UA-Fa
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pu-0004Oq-5L
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UIwcCx022697;
 Sun, 30 Jun 2024 19:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=4uKXgAn4d6hJh3JzwucC45gtPiookX4h8suJNmSSDmA=; b=
 AwV3ZTBLF7NOyDdrwxzRUONH+cwp7tO2g/DpZV1KW686YsfmGsHfFHfGmFzOEjSU
 aQJE2tmp6/ZqLJ7T9TKbBwlTQb8XGxKPpykWueZ1OuSJqAGAtDXjQwAUHgw8KVqM
 rJciOGYJyUOEFSeTo86EEy6vat0k0aymvwOxXAS90GQNgAnCcgm9S0S6BYd6vDd0
 GlLBNlko90mGWppRpmhv5Ofb1cUgIHzLTOiquHD37Je//66N1PeLw4PfqCyyx7Sr
 Y1lCh/v0+tsxv4OtwsVxZMwvF7blNwpwVeKwABns3imTm1BWELQc1O1X+BhAa9DI
 4GkOcSDOGOapIoTCye3PNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0hgjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UEQnGX018357; Sun, 30 Jun 2024 19:40:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSe014044;
 Sun, 30 Jun 2024 19:40:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-9; Sun, 30 Jun 2024 19:40:46 +0000
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
Subject: [PATCH V2 08/11] vl: helper to request exec
Date: Sun, 30 Jun 2024 12:40:31 -0700
Message-Id: <1719776434-435013-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300157
X-Proofpoint-ORIG-GUID: JLC7LN32UQinUQ8IaB4vS5uDV9YeJhZc
X-Proofpoint-GUID: JLC7LN32UQinUQ8IaB4vS5uDV9YeJhZc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Add a qemu_system_exec_request() hook that causes the main loop to exit and
exec a command using the specified arguments.  This will be used during CPR
to exec a new version of QEMU.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/runstate.h |  3 +++
 system/runstate.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d24..cb669cf 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -80,6 +80,8 @@ typedef enum WakeupReason {
     QEMU_WAKEUP_REASON_OTHER,
 } WakeupReason;
 
+typedef void (*qemu_exec_func)(char **exec_argv);
+
 void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
@@ -91,6 +93,7 @@ void qemu_register_wakeup_support(void);
 void qemu_system_shutdown_request_with_code(ShutdownCause reason,
                                             int exit_code);
 void qemu_system_shutdown_request(ShutdownCause reason);
+void qemu_system_exec_request(qemu_exec_func func, const strList *args);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
 void qemu_register_shutdown_notifier(Notifier *notifier);
diff --git a/system/runstate.c b/system/runstate.c
index ec32e27..afc56e4 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -40,6 +40,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-events-run-state.h"
+#include "qapi/type-helpers.h"
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/job.h"
@@ -400,6 +401,8 @@ static NotifierList wakeup_notifiers =
 static NotifierList shutdown_notifiers =
     NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
 static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
+qemu_exec_func exec_func;
+static char **exec_argv;
 
 ShutdownCause qemu_shutdown_requested_get(void)
 {
@@ -416,6 +419,11 @@ static int qemu_shutdown_requested(void)
     return qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
 }
 
+static int qemu_exec_requested(void)
+{
+    return exec_argv != NULL;
+}
+
 static void qemu_kill_report(void)
 {
     if (!qtest_driver() && shutdown_signal) {
@@ -693,6 +701,23 @@ void qemu_system_shutdown_request(ShutdownCause reason)
     qemu_notify_event();
 }
 
+static void qemu_system_exec(void)
+{
+    exec_func(exec_argv);
+
+    /* exec failed */
+    g_strfreev(exec_argv);
+    exec_argv = NULL;
+    exec_func = NULL;
+}
+
+void qemu_system_exec_request(qemu_exec_func func, const strList *args)
+{
+    exec_func = func;
+    exec_argv = strv_from_str_list(args);
+    qemu_notify_event();
+}
+
 static void qemu_system_powerdown(void)
 {
     qapi_event_send_powerdown();
@@ -739,6 +764,10 @@ static bool main_loop_should_exit(int *status)
     if (qemu_suspend_requested()) {
         qemu_system_suspend();
     }
+    if (qemu_exec_requested()) {
+        qemu_system_exec();
+        return false;
+    }
     request = qemu_shutdown_requested();
     if (request) {
         qemu_kill_report();
-- 
1.8.3.1


