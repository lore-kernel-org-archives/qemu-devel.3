Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E09EC3065B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0TE-0007Vb-2Y; Sun, 30 Jun 2024 15:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0T9-0007Tr-Hg
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0T7-0006P8-7f
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:15 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJeY26019514;
 Sun, 30 Jun 2024 19:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=ML9qM6rxVCGfCedMBnF3XKpZc6Rsg+VBcxi7zNFyK94=; b=
 eBSoLi5+26Z4rhWPsUP1ZpDAPLz0+PkzVmZDp8Tft2wbRJ47C7FLCeTSqcPLjaOS
 uHEBTIlZ2RolRHj7mueRanvQEZ6Zo4mUJL514JZNpzqRw8piAwBE/FZGdB7QMWB6
 eD3SAoaB44iKtfHenLlxfkF9Q+RAQXHbyLm/gi5rg1I2J/kRCQzyKcV66YFoYk2P
 H3fR+gDIr4MwI/iEPuNnZ6U6bkGgofdIWn93r58y5CV7iOGXc4ZKIDHrqRfpw1FP
 R3jBxAtSuOuKQ19wXjq11YA1UXZNqVEKCcMMd6Oy0f/JwaOWwuR8bOmD9NYjHA1F
 9FItNoswRM8ljDi8/O59ug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296asgax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UGXkta022842; Sun, 30 Jun 2024 19:44:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4028q5gg4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJg4f8039161;
 Sun, 30 Jun 2024 19:44:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 4028q5gg4e-5; Sun, 30 Jun 2024 19:44:10 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 4/6] migration: cpr-uri parameter
Date: Sun, 30 Jun 2024 12:44:06 -0700
Message-Id: <1719776648-435073-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300157
X-Proofpoint-GUID: 98izb5R0Xgqy5teZWjqMxzEPkSpk1W-X
X-Proofpoint-ORIG-GUID: 98izb5R0Xgqy5teZWjqMxzEPkSpk1W-X
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

Define the cpr-uri migration parameter to specify the URI to which
CPR vmstate is saved for cpr-transfer mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration-hmp-cmds.c | 10 ++++++++++
 migration/options.c            | 29 +++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 12 ++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 16a4b00..4ede831 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -371,6 +371,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                            params->direct_io ? "on" : "off");
         }
 
+        assert(params->cpr_uri);
+        monitor_printf(mon, "%s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_CPR_URI),
+            params->cpr_uri);
+
         assert(params->has_cpr_exec_command);
         monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
     }
@@ -650,6 +655,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
+    case MIGRATION_PARAMETER_CPR_URI:
+        p->cpr_uri = g_new0(StrOrNull, 1);
+        p->cpr_uri->type = QTYPE_QSTRING;
+        visit_type_str(v, param, &p->cpr_uri->u.s, &err);
+        break;
     case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
         g_autofree char **strv = g_strsplit(valuestr ?: "", " ", -1);
         strList **tail = &p->cpr_exec_command;
diff --git a/migration/options.c b/migration/options.c
index b8d5f72..7526f9f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -163,6 +163,8 @@ Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_STRING("cpr-uri", MigrationState,
+                       parameters.cpr_uri),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -848,6 +850,13 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
+const char *migrate_cpr_uri(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.cpr_uri;
+}
+
 /* parameters helpers */
 
 AnnounceParameters *migrate_announce_params(void)
@@ -931,6 +940,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->cpr_uri = g_strdup(s->parameters.cpr_uri);
     params->has_cpr_exec_command = true;
     params->cpr_exec_command = QAPI_CLONE(strList,
                                           s->parameters.cpr_exec_command);
@@ -967,6 +977,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_mode = true;
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
+    params->cpr_uri = g_strdup("");
     params->has_cpr_exec_command = true;
 }
 
@@ -1257,9 +1268,15 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->direct_io = params->direct_io;
     }
 
+    if (params->cpr_uri) {
+        assert(params->cpr_uri->type == QTYPE_QSTRING);
+        dest->cpr_uri = params->cpr_uri->u.s;
+    }
+
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
+
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1390,6 +1407,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.direct_io = params->direct_io;
     }
 
+    if (params->cpr_uri) {
+        g_free(s->parameters.cpr_uri);
+        assert(params->cpr_uri->type == QTYPE_QSTRING);
+        s->parameters.cpr_uri = g_strdup(params->cpr_uri->u.s);
+    }
+
     if (params->has_cpr_exec_command) {
         qapi_free_strList(s->parameters.cpr_exec_command);
         s->parameters.cpr_exec_command =
@@ -1421,6 +1444,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
         params->tls_authz->u.s = strdup("");
     }
 
+    if (params->cpr_uri && params->cpr_uri->type == QTYPE_QNULL) {
+        qobject_unref(params->cpr_uri->u.n);
+        params->cpr_uri->type = QTYPE_QSTRING;
+        params->cpr_uri->u.s = strdup("");
+    }
+
     migrate_params_test_apply(params, &tmp);
 
     if (!migrate_params_check(&tmp, errp)) {
diff --git a/migration/options.h b/migration/options.h
index a239702..7492fcf 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -85,6 +85,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+const char *migrate_cpr_uri(void);
 
 /* parameters helpers */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 4e626df..df62456 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -851,6 +851,9 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-uri: URI for an additional migration channel needed by
+#     @cpr-transfer mode. (Since 9.1)
+#
 # @cpr-exec-command: Command to start the new QEMU process when @mode
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments. (Since 9.1)
@@ -881,6 +884,7 @@
            'mode',
            'zero-page-detection',
            'direct-io',
+           'cpr-uri',
            'cpr-exec-command'] }
 
 ##
@@ -1031,6 +1035,9 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-uri: URI for an additional migration channel needed by
+#     @cpr-transfer mode. (Since 9.1)
+#
 # @cpr-exec-command: Command to start the new QEMU process when @mode
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments. (Since 9.1)
@@ -1076,6 +1083,7 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
+            '*cpr-uri': 'StrOrNull',
             '*cpr-exec-command': [ 'str' ]} }
 
 ##
@@ -1240,6 +1248,9 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-uri: URI for an additional migration channel needed by
+#     @cpr-transfer mode. (Since 9.1)
+#
 # @cpr-exec-command: Command to start the new QEMU process when @mode
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments. (Since 9.1)
@@ -1282,6 +1293,7 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
+            '*cpr-uri': 'str',
             '*cpr-exec-command': [ 'str' ]} }
 
 ##
-- 
1.8.3.1


