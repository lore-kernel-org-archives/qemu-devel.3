Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E556AC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0QI-0000Er-3y; Sun, 30 Jun 2024 15:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pw-0008UF-Fy
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pu-0004PE-5I
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJOOO6012862;
 Sun, 30 Jun 2024 19:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=0niKNmTF4WrGuB6zYfEq+bYLo3vZ/K4GncHP23R0cUo=; b=
 TnkizE5xSCefKzkKTzjUW540sd9EViOrK3E6ZWCBEz1O2k6/hTxRzgjTJCxPLJCk
 et1z6/HgtLx/HGMo4pg2Gc8WfHEEPUFPybdQqbQEGjw33SNAouDoBkBpfA7FJUp/
 43ROB9trnt7cjN1PGj6n++uRfIwBCyIJkxP4NdmVwmXbVT5989oISjRU+Ul0rv8h
 h29X3epDhvtfYO9fBB4kV5u+nhxKSA9u9qHMNzgmIPf2i0KIIcjcS7F5uX67B/Gs
 EOvL3NqYzP5f+l3Ak7PV2gsbT+JFU6bBbiFC+3a6rHke6mmjKPp44okq6DGf8gZg
 iQ/y599jwkFNC575OUgprQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a591erf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UG0nJ0019121; Sun, 30 Jun 2024 19:40:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSg014044;
 Sun, 30 Jun 2024 19:40:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-10; Sun, 30 Jun 2024 19:40:47 +0000
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
Subject: [PATCH V2 09/11] migration: cpr-exec-command parameter
Date: Sun, 30 Jun 2024 12:40:32 -0700
Message-Id: <1719776434-435013-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: gnP3ihmOBfFg8Rd5CkNMWkvpBjVzPV0P
X-Proofpoint-ORIG-GUID: gnP3ihmOBfFg8Rd5CkNMWkvpBjVzPV0P
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

Create the cpr-exec-command migration parameter, defined as a list of
strings.  It will be used for cpr-exec migration mode in a subsequent
patch, and contains forward references to cpr-exec mode in the qapi
doc.

No functional change, except that cpr-exec-command is shown by the
'info migrate' command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hmp-commands.hx                |  2 +-
 migration/migration-hmp-cmds.c | 25 +++++++++++++++++++++++++
 migration/options.c            | 14 ++++++++++++++
 qapi/migration.json            | 21 ++++++++++++++++++---
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0..0e04eac 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1009,7 +1009,7 @@ ERST
 
     {
         .name       = "migrate_set_parameter",
-        .args_type  = "parameter:s,value:s",
+        .args_type  = "parameter:s,value:S",
         .params     = "parameter value",
         .help       = "Set the parameter for migration",
         .cmd        = hmp_migrate_set_parameter,
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7d608d2..16a4b00 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -229,6 +229,18 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
     qapi_free_MigrationCapabilityStatusList(caps);
 }
 
+static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
+{
+    monitor_printf(mon, "%s:",
+        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
+
+    while (args) {
+        monitor_printf(mon, " %s", args->value);
+        args = args->next;
+    }
+    monitor_printf(mon, "\n");
+}
+
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
@@ -358,6 +370,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                                MIGRATION_PARAMETER_DIRECT_IO),
                            params->direct_io ? "on" : "off");
         }
+
+        assert(params->has_cpr_exec_command);
+        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
     }
 
     qapi_free_MigrationParameters(params);
@@ -635,6 +650,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
+    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
+        g_autofree char **strv = g_strsplit(valuestr ?: "", " ", -1);
+        strList **tail = &p->cpr_exec_command;
+
+        for (int i = 0; strv[i]; i++) {
+            QAPI_LIST_APPEND(tail, strv[i]);
+        }
+        p->has_cpr_exec_command = true;
+        break;
+    }
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 305397a..b8d5f72 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -931,6 +931,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->has_cpr_exec_command = true;
+    params->cpr_exec_command = QAPI_CLONE(strList,
+                                          s->parameters.cpr_exec_command);
 
     return params;
 }
@@ -964,6 +967,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_mode = true;
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
+    params->has_cpr_exec_command = true;
 }
 
 /*
@@ -1252,6 +1256,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->has_cpr_exec_command) {
+        dest->cpr_exec_command = params->cpr_exec_command;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1381,6 +1389,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_direct_io) {
         s->parameters.direct_io = params->direct_io;
     }
+
+    if (params->has_cpr_exec_command) {
+        qapi_free_strList(s->parameters.cpr_exec_command);
+        s->parameters.cpr_exec_command =
+            QAPI_CLONE(strList, params->cpr_exec_command);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 0f24206..20092d2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -829,6 +829,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments. (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -854,7 +858,8 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io',
+           'cpr-exec-command'] }
 
 ##
 # @MigrateSetParameters:
@@ -1004,6 +1009,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments. (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1044,7 +1053,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-exec-command': [ 'str' ]} }
 
 ##
 # @migrate-set-parameters:
@@ -1208,6 +1218,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments. (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1245,7 +1259,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-exec-command': [ 'str' ]} }
 
 ##
 # @query-migrate-parameters:
-- 
1.8.3.1


