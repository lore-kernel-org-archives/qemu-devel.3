Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD05CAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvc-0000Qz-8p; Mon, 22 Sep 2025 09:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvX-0000Pr-Ou
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:49:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvU-0001uR-Uj
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:49:59 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NQno030914;
 Mon, 22 Sep 2025 13:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=VggucWXHRsV9x5Cmy/z6Zo3PNEb1fQUeyB+8KnvYUxE=; b=
 Oi4/mxzdMibzaOIowfZs0ci4XzmNgqKtFcm6ZawuW+hkt2Gp7oSvmX6YoTfEpxm/
 7/wpm08dUHTUeJOMVY9C9Bs0QEDbpUTcz95D3yUPFItPJU310DZyMoL99nF2fQT2
 K41J/K2xUgYq9iWBgsLifNG5ux7E16GnmamamwjMSuSbwclESngvYDDjrK5itrZ1
 82qxCkhQ2X/UCfm1TjYjCh8uk1AKAEzj1RQXJoTF6guC5y6Nmt5OGDVACFBi5jhx
 Nfp3Wrmf1GtLxp4tMiIhiE0Y0KsokfX591MhoR3jTYGZMoee/UsGXoHWzd8Vyr7f
 VyPpMkIUtystlHmjtI/XEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad2gmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MC1BOG034255; Mon, 22 Sep 2025 13:49:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhanaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWJ004351;
 Mon, 22 Sep 2025 13:49:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-5; Mon, 22 Sep 2025 13:49:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 4/8] migration: cpr-exec-command parameter
Date: Mon, 22 Sep 2025 06:49:41 -0700
Message-Id: <1758548985-354793-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220135
X-Proofpoint-ORIG-GUID: zL0R1A33i_tGuJdUCy1Bss5LsGgPE9UD
X-Proofpoint-GUID: zL0R1A33i_tGuJdUCy1Bss5LsGgPE9UD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX+2+yURKcC+F6
 PvlMxts1r2/o+Q4PbFGZZE3O9BRg5Vd9PQMrFio7bp0j/YH8XKLtwqMCWAjF+hbFk/fOBcfPYHu
 9X3bijt4h06zdvuAB3+COmhI/E0NN4ngRE6qh6BxOnE/YJvVMOUJyJoxzpJZ2PYmd9yiSxM1Kt1
 cdOYlSKXu4PgUfEPvV0ZgIQwi3WFpDWKBWdU5Ko302+1LwdPLmfqesmtxVuZdzJ3YhzSxDTIG2w
 dnMPUmbeJVL218z1moso0PI6Eto9AzcWdfhTEQcn3i2yHUz/hEy2NmaVnExJte7TcdCD5xkm96f
 j/k29SMbkMR3QEPfOts7Gyvhsl2uYbcjY1yheGz8K+EYMkV69epJPm3eugqEqFXJoODaESy4lx6
 hTBv6+KOtdcRMsiGAj3Riz7w5PzJaA==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d15402 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=MKfdV2AELyQW9RJxCdwA:9
 cc=ntf awl=host:13614
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Create the cpr-exec-command migration parameter, defined as a list of
strings.  It will be used for cpr-exec migration mode in a subsequent
patch, and contains forward references to cpr-exec mode in the qapi
doc.

No functional change, except that cpr-exec-command is shown by the
'info migrate' command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json            | 21 ++++++++++++++++++---
 migration/migration-hmp-cmds.c | 30 ++++++++++++++++++++++++++++++
 migration/options.c            | 14 ++++++++++++++
 hmp-commands.hx                |  2 +-
 4 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21..2be8fa1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -924,6 +924,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments.  (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -950,7 +954,8 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io',
+           'cpr-exec-command'] }
 
 ##
 # @MigrateSetParameters:
@@ -1105,6 +1110,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments.  (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1146,7 +1155,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-exec-command': [ 'str' ]} }
 
 ##
 # @migrate-set-parameters:
@@ -1315,6 +1325,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments.  (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1353,7 +1367,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-exec-command': [ 'str' ]} }
 
 ##
 # @query-migrate-parameters:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0fc21f0..54df615 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -306,6 +306,18 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
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
@@ -435,6 +447,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                                MIGRATION_PARAMETER_DIRECT_IO),
                            params->direct_io ? "on" : "off");
         }
+
+        assert(params->has_cpr_exec_command);
+        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
     }
 
     qapi_free_MigrationParameters(params);
@@ -716,6 +731,21 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
+    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
+        g_autofree char **strv = NULL;
+        g_autoptr(GError) gerr = NULL;
+        strList **tail = &p->cpr_exec_command;
+
+        if (!g_shell_parse_argv(valuestr, NULL, &strv, &gerr)) {
+            error_setg(&err, "%s", gerr->message);
+            break;
+        }
+        for (int i = 0; strv[i]; i++) {
+            QAPI_LIST_APPEND(tail, strv[i]);
+        }
+        p->has_cpr_exec_command = true;
+        break;
+    }
     default:
         g_assert_not_reached();
     }
diff --git a/migration/options.c b/migration/options.c
index 4e923a2..5183112 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -959,6 +959,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->has_cpr_exec_command = true;
+    params->cpr_exec_command = QAPI_CLONE(strList,
+                                          s->parameters.cpr_exec_command);
 
     return params;
 }
@@ -993,6 +996,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_mode = true;
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
+    params->has_cpr_exec_command = true;
 }
 
 /*
@@ -1297,6 +1301,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->has_cpr_exec_command) {
+        dest->cpr_exec_command = params->cpr_exec_command;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1429,6 +1437,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
diff --git a/hmp-commands.hx b/hmp-commands.hx
index d0e4f35..3cace8f 100644
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
-- 
1.8.3.1


