Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB93C47DD9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 21:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdGvL-0000no-Rt; Thu, 22 Feb 2024 16:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvG-0000mv-HK
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvD-0005QJ-Q4
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:06 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MIRPlC001370; Thu, 22 Feb 2024 21:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=wfjGAw2wdJR6anhf82VrYoogjJNUoXqn0fWWX0qgRx0=;
 b=ObcvK7AANrTfkxklx7hGWaUk/OyFO0RBQ7BxJAqimtHCah7iLcUPkKPvEmHLnpIpKdRG
 KOrDfFjimE2dh0oCaE8JKijuf1lgKDjNWcuO9nv06JmebADGOGhhfWxfN6uqpHZmox3O
 wjB7L+e2lbxDI9fL0RnPycg//R5sGtjcsB83WCYhDnw239dfUcmRDoLW5+k6qpV4tcMV
 vJ1RMsiQbdxyz1oKYn20rjhej54ADXp8eHaqgITO6VjwV7PAqCwbeOwlMy5/qGSXvbWI
 QZ+yTiIZ07YIcTeS/tnx3G1xIj0TBLQiTpKeFwMj9TfwTlTLLYP2nYWkUWdS24lg+tL2 cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud610a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:59 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MKrRoB022240; Thu, 22 Feb 2024 21:47:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8bft75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MLlqUH037274;
 Thu, 22 Feb 2024 21:47:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8bft40-6; Thu, 22 Feb 2024 21:47:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 5/5] migration: simplify exec migration functions
Date: Thu, 22 Feb 2024 13:47:50 -0800
Message-Id: <1708638470-114846-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220169
X-Proofpoint-GUID: TDdBlGcP0R9rqKEUyAAGzTkjC2x-rghH
X-Proofpoint-ORIG-GUID: TDdBlGcP0R9rqKEUyAAGzTkjC2x-rghH
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

Simplify the exec migration code by using list utility functions.

As a side effect, this also fixes a minor memory leak.  On function return,
"g_auto(GStrv) argv" frees argv and each element, which is wrong, because
the function does not own the individual elements.  To compensate, the code
uses g_steal_pointer which NULLs argv and prevents the destructor from
running, but argv is leaked.

Fixes: cbab4face57b ("migration: convert exec backend ...")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/exec.c | 57 ++++++++------------------------------------------------
 1 file changed, 8 insertions(+), 49 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 47d2f3b..1518409 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/strList.h"
 #include "channel.h"
 #include "exec.h"
 #include "migration.h"
@@ -39,51 +40,16 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-/* provides the length of strList */
-static int
-str_list_length(strList *list)
-{
-    int len = 0;
-    strList *elem;
-
-    for (elem = list; elem != NULL; elem = elem->next) {
-        len++;
-    }
-
-    return len;
-}
-
-static void
-init_exec_array(strList *command, char **argv, Error **errp)
-{
-    int i = 0;
-    strList *lst;
-
-    for (lst = command; lst; lst = lst->next) {
-        argv[i++] = lst->value;
-    }
-
-    argv[i] = NULL;
-    return;
-}
-
 void exec_start_outgoing_migration(MigrationState *s, strList *command,
                                    Error **errp)
 {
-    QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    QIOChannel *ioc = NULL;
+    g_auto(GStrv) argv = strv_from_strList(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_outgoing(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
@@ -105,19 +71,12 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    g_auto(GStrv) argv = strv_from_strList(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_incoming(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
-- 
1.8.3.1


