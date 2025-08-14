Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85B8CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umba6-0005Ta-M3; Thu, 14 Aug 2025 13:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba5-0005T1-22
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba1-0002pu-St
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:36 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECgBfL006028;
 Thu, 14 Aug 2025 17:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=XMqwtmpD+QnI/KOlEdK3J9UJbWrXieuuBA8a9T/SZew=; b=
 VCAObz6fWkHpyzNFMklE0xy9gU3NSpbG+6wk96Yo/Hv9ugyyVIMuFJrOTJAh4OQG
 KEu9f0mfFTWNjnWWes0RYwMIq5QrrmiDwMvRqKPhGok4vtMEKj53B3U1Yzk6aDt7
 LlkdPCe6/3A/kwJHsiu5uCjSHZ581p/oGYLVBlYoHOWs9QnKH3VlUTdHZGTdDL6A
 sV5Wm6aW41JQEj0ULwN5RKW9QjLaIkVvjFfH9KYcfD5H0K+Gi92/XiyN9Hisb7w1
 fmiSv2l9ZN/xz6ll0pW8847Wx41URjdR9IhF1jAHudSnsIrz6oebqCLWLpZdPQMh
 2uGTPzxKTo59wtUigF87ng==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8ejfd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EGBgsk010424; Thu, 14 Aug 2025 17:17:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbs0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwuE038225;
 Thu, 14 Aug 2025 17:17:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-5; Thu, 14 Aug 2025 17:17:29 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 4/9] vl: helper to request exec
Date: Thu, 14 Aug 2025 10:17:18 -0700
Message-Id: <1755191843-283480-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Proofpoint-GUID: 4L2T9NXglNaAK5YdovRqq726C7Tdmias
X-Proofpoint-ORIG-GUID: 4L2T9NXglNaAK5YdovRqq726C7Tdmias
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689e1a2c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=osZJ3dnYYTX8la6_xJwA:9 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfXzHT+C40J/gdm
 wmNQwXkSID/5+zf1rEx3Jmdr6SjwqhtDtWHSC99aIg+wP4zttwRbopvREPMQHrIFiwvGLX3bFAi
 lgrfb7rBC1/5TziREZxDJLjwAGzB18JqQfjIeL1Kmp6AjNoI0h5udPtyxzzMNZyXtv+bH7CrMqd
 2Ik7EYnPnzdx3vEXM8ibYaaV3ksD8zoifV27YWcrKOjPVcMgSsWTzheHYeYPXetYUJvBO5CXX6j
 fmX17qzTxe4O+aOi3nSSiKVS6hVHkNd1q3iROW5XlyCIgQEWbg2oJadf0jpjKSUi/Hfq7YLgFhN
 IF6wF/NGILWwpQJDMMI3CHFWW029S+r8WL2MEUJmbluvkb13zD1neHfHW8A31KCvlR9hpizhHAN
 gSn9GHDzqoSjg0LmsnYqySzcQeNL+vd+SkxbDXVGRFSJPDglQCYZCuCGqVrTFi2gk41lo2nW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a qemu_system_exec_request() hook that causes the main loop to exit and
exec a command using the specified arguments.  This will be used during CPR
to exec a new version of QEMU.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/system/runstate.h |  3 +++
 system/runstate.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index 929379a..c005f49 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -128,6 +128,8 @@ typedef enum WakeupReason {
     QEMU_WAKEUP_REASON_OTHER,
 } WakeupReason;
 
+typedef void (*qemu_exec_func)(char **exec_argv);
+
 void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
@@ -139,6 +141,7 @@ void qemu_register_wakeup_support(void);
 void qemu_system_shutdown_request_with_code(ShutdownCause reason,
                                             int exit_code);
 void qemu_system_shutdown_request(ShutdownCause reason);
+void qemu_system_exec_request(qemu_exec_func func, const strList *args);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
 void qemu_register_shutdown_notifier(Notifier *notifier);
diff --git a/system/runstate.c b/system/runstate.c
index 6178b00..b4980ff 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -41,6 +41,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-events-run-state.h"
+#include "qapi/type-helpers.h"
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/job.h"
@@ -422,6 +423,8 @@ static NotifierList wakeup_notifiers =
 static NotifierList shutdown_notifiers =
     NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
 static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
+qemu_exec_func exec_func;
+static char **exec_argv;
 
 ShutdownCause qemu_shutdown_requested_get(void)
 {
@@ -443,6 +446,11 @@ static int qemu_shutdown_requested(void)
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
@@ -803,6 +811,23 @@ void qemu_system_shutdown_request(ShutdownCause reason)
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
@@ -849,6 +874,10 @@ static bool main_loop_should_exit(int *status)
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


