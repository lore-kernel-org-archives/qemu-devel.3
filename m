Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMa-00052h-CY; Mon, 29 Apr 2024 11:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMN-0004c0-60
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TML-0005Ig-1C
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmu7n024919; Mon, 29 Apr 2024 15:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=dFAAqcGLASWY0fwkl8wcUig8RTCMMJh3CTyJCKkbWEA=;
 b=YIelEe8WLbHOe2XpwaK3/if7mmGszxLh8Xjk7WViTNxijjHYDSVrTdGzpcPG/ink+3WA
 JPxDweByoRf/2oUh54cGOJHy7+Qn0KMgng7oPKlBJyRgkEbB8twi71dmzcn6UluwXhBz
 aEthyRV46gQrLV3UUY+2/V29jUXaw8AZE1fC/fWypo2m6WYJx9yFp51fBiKahaOehm0y
 WAHuFliypWhamSadAbTLrm7mwEWSqClHiSRECaonx6E8M0t00Dy5Lo4hHjtFKZA5xnqd
 o51I+PwvVZfdEdMNEdw1QE2yHyCKuWF3TFDVxS4qyYTR3BakHreFaqcnQ6e9dgWQU13q Fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetx49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:51 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFgaep011393; Mon, 29 Apr 2024 15:55:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaH4034442;
 Mon, 29 Apr 2024 15:55:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-19; Mon, 29 Apr 2024 15:55:49 +0000
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
Subject: [PATCH V1 18/26] migration: cpr-exec-args parameter
Date: Mon, 29 Apr 2024 08:55:27 -0700
Message-Id: <1714406135-451286-19-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: _rEh2WqBWliGLL0O96WpdRoKN7qOMHQz
X-Proofpoint-GUID: _rEh2WqBWliGLL0O96WpdRoKN7qOMHQz
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

Create the cpr-exec-args migration parameter, defined as a list of
strings.  It will be used for cpr-exec migration mode in a subsequent
patch.

No functional change, except that cpr-exec-args is shown by the
'info migrate' command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hmp-commands.hx                |  2 +-
 migration/migration-hmp-cmds.c | 24 ++++++++++++++++++++++++
 migration/options.c            | 13 +++++++++++++
 qapi/migration.json            | 18 +++++++++++++++---
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2e2a3bc..39954ae 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1012,7 +1012,7 @@ ERST
 
     {
         .name       = "migrate_set_parameter",
-        .args_type  = "parameter:s,value:s",
+        .args_type  = "parameter:s,value:S",
         .params     = "parameter value",
         .help       = "Set the parameter for migration",
         .cmd        = hmp_migrate_set_parameter,
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e96ae6..414c7e8 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -255,6 +255,18 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
     qapi_free_MigrationCapabilityStatusList(caps);
 }
 
+static void monitor_print_cpr_exec_args(Monitor *mon, strList *args)
+{
+    monitor_printf(mon, "%s:",
+        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_ARGS));
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
@@ -397,6 +409,8 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MODE),
             qapi_enum_lookup(&MigMode_lookup, params->mode));
+        assert(params->has_cpr_exec_args);
+        monitor_print_cpr_exec_args(mon, params->cpr_exec_args);
     }
 
     qapi_free_MigrationParameters(params);
@@ -690,6 +704,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_mode = true;
         visit_type_MigMode(v, param, &p->mode, &err);
         break;
+    case MIGRATION_PARAMETER_CPR_EXEC_ARGS: {
+        g_autofree char **strv = g_strsplit(valuestr ?: "", " ", -1);
+        strList **tail = &p->cpr_exec_args;
+
+        for (int i = 0; strv[i]; i++) {
+            QAPI_LIST_APPEND(tail, strv[i]);
+        }
+        p->has_cpr_exec_args = true;
+        break;
+    }
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 239f5ec..89082cc 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1060,6 +1060,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->mode = s->parameters.mode;
     params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
+    params->has_cpr_exec_args = true;
+    params->cpr_exec_args = QAPI_CLONE(strList, s->parameters.cpr_exec_args);
 
     return params;
 }
@@ -1097,6 +1099,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
     params->has_zero_page_detection = true;
+    params->has_cpr_exec_args = true;
 }
 
 /*
@@ -1416,6 +1419,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_zero_page_detection) {
         dest->zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_cpr_exec_args) {
+        dest->cpr_exec_args = params->cpr_exec_args;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1570,6 +1577,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_zero_page_detection) {
         s->parameters.zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_cpr_exec_args) {
+        qapi_free_strList(s->parameters.cpr_exec_args);
+        s->parameters.cpr_exec_args =
+            QAPI_CLONE(strList, params->cpr_exec_args);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90..49710e7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -914,6 +914,9 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
+#    See @cpr-exec for details.  (Since 9.1)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -948,7 +951,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'zero-page-detection'] }
+           'zero-page-detection',
+           'cpr-exec-args'] }
 
 ##
 # @MigrateSetParameters:
@@ -1122,6 +1126,9 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
+#    See @cpr-exec for details.  (Since 9.1)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1176,7 +1183,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*cpr-exec-args': [ 'str' ]} }
 
 ##
 # @migrate-set-parameters:
@@ -1354,6 +1362,9 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
+#    See @cpr-exec for details.  (Since 9.1)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1405,7 +1416,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*cpr-exec-args': [ 'str' ]} }
 
 ##
 # @query-migrate-parameters:
-- 
1.8.3.1


