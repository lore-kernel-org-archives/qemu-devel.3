Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89424E6B27C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s12-0004IU-AV; Fri, 01 Nov 2024 09:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0z-0004Dk-Nt
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0x-0002Hc-R1
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:37 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1DffEY026685;
 Fri, 1 Nov 2024 13:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=KdYcQra8WuKmwlcs0CeO5clpBnDxsDFsYeuREwqG5RQ=; b=
 cD3+EXJFG/zWZm3kFtIgnOT6fZWh/vM7fC5sPSuHoMA0kBFXX/xzUVRDAN7tT9u7
 nUJmJKAUgRCgzmkQJVQtjxWKfuZOCn1DPFnnKULAygA/KvcVd0LQ4tHwi0FgOtDT
 78K5b1NKhr3On6C8MS1w11vm1wV3mTFxOf1IH9PAAE3vZybxcTWogZvPTLOP3l6M
 /BnHh7m+/DlPG1yFEG+pgXgAguyV59MoTaguBwcUXPzvIbbkTgR4oreJtxi0JTti
 1BDUoVRc29+p4Dmat0paodf7OgRRdc82i/mIiI0+JSWxVVEKSyZjqmtufI8uNT3V
 c4ustvLYeMGm/z21KdThgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmme6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1DWwk7010337; Fri, 1 Nov 2024 13:48:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91ptkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuOG006031;
 Fri, 1 Nov 2024 13:48:31 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-9; Fri, 01 Nov 2024 13:48:31 +0000
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
Subject: [PATCH V3 08/16] migration: cpr-uri parameter
Date: Fri,  1 Nov 2024 06:47:47 -0700
Message-Id: <1730468875-249970-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010100
X-Proofpoint-GUID: aLNMdBH_TF8pXUs2_ErjPb9FVEOa78Hn
X-Proofpoint-ORIG-GUID: aLNMdBH_TF8pXUs2_ErjPb9FVEOa78Hn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define the cpr-uri migration parameter to specify the URI to which
CPR vmstate is saved for cpr-transfer mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 10 ++++++++++
 migration/options.c            | 28 ++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 18 +++++++++++++++---
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 20d1a6e..79d8c66 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -358,6 +358,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                                MIGRATION_PARAMETER_DIRECT_IO),
                            params->direct_io ? "on" : "off");
         }
+
+        assert(params->cpr_uri);
+        monitor_printf(mon, "%s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_CPR_URI),
+            params->cpr_uri);
     }
 
     qapi_free_MigrationParameters(params);
@@ -639,6 +644,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
+    case MIGRATION_PARAMETER_CPR_URI:
+        p->cpr_uri = g_new0(StrOrNull, 1);
+        p->cpr_uri->type = QTYPE_QSTRING;
+        visit_type_str(v, param, &p->cpr_uri->u.s, &err);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/migration/options.c b/migration/options.c
index ad8d698..82de1d8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -172,6 +172,8 @@ Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_STRING("cpr-uri", MigrationState,
+                       parameters.cpr_uri),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -837,6 +839,13 @@ ZeroPageDetection migrate_zero_page_detection(void)
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
@@ -922,6 +931,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->cpr_uri = g_strdup(s->parameters.cpr_uri);
 
     return params;
 }
@@ -956,6 +966,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_mode = true;
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
+    params->cpr_uri = g_strdup("");
 }
 
 /*
@@ -1255,6 +1266,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->cpr_uri) {
+        assert(params->cpr_uri->type == QTYPE_QSTRING);
+        dest->cpr_uri = params->cpr_uri->u.s;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1387,6 +1403,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_direct_io) {
         s->parameters.direct_io = params->direct_io;
     }
+
+    if (params->cpr_uri) {
+        g_free(s->parameters.cpr_uri);
+        assert(params->cpr_uri->type == QTYPE_QSTRING);
+        s->parameters.cpr_uri = g_strdup(params->cpr_uri->u.s);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1413,6 +1435,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
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
index 79084ee..2b4c082 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -84,6 +84,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+const char *migrate_cpr_uri(void);
 
 /* parameters helpers */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 3af6aa1..5bf3e49 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -844,6 +844,9 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-uri: URI for an additional migration channel needed by
+#     @cpr-transfer mode. (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -870,7 +873,8 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io',
+           'cpr-uri'] }
 
 ##
 # @MigrateSetParameters:
@@ -1025,6 +1029,9 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-uri: URI for an additional migration channel needed by
+#     @cpr-transfer mode. (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1066,7 +1073,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-uri': 'StrOrNull' } }
 
 ##
 # @migrate-set-parameters:
@@ -1235,6 +1243,9 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-uri: URI for an additional migration channel needed by
+#     @cpr-transfer mode. (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1273,7 +1284,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-uri': 'str' } }
 
 ##
 # @query-migrate-parameters:
-- 
1.8.3.1


