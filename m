Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9313C3ABD4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETVM-0002FM-GI; Mon, 12 May 2025 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETVD-0002D1-Bj
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETV8-0002TL-Si
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:30 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9dwY024078;
 Mon, 12 May 2025 13:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=NjcWIxXy3pf1aYy/RVlURxuEWTkCVZH35kG6ZRSKIDs=; b=
 mumH8HqpN4bFT/l5hPrBDKlDJjQbJt4M4ge2jyrl2ZCmzgaJGqIxmJSYfrC7cmbL
 NFp64nzBpcREG810o1MZs3f4s12lpLsYEL3cMJSBTuMQQlk5p6kPmeTe3ZZIFjao
 7rQYjSIUkMj4s+G/YRWazgfQnYfe+/Ou/7xblLah0/hmMfGuns1J5tBh4b0CpK5h
 Ky7TwyDEwz1UPoYbJzOlMQYaM9sU6oT8ghJ0W8Daun1Hlx2+azRaTsX7BYFpKmqa
 S49Uwnp22qHukIkvr1Wv+8hJzis1uUWasHxGbR+oV/+HHLCcImMfVhPLvcDbW4O2
 ee5yqJDJhBPzbgvnFIY+vQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2afy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CC9oCn033163; Mon, 12 May 2025 13:47:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46hw8ddfd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CDlHVl001568;
 Mon, 12 May 2025 13:47:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46hw8ddf9k-6; Mon, 12 May 2025 13:47:24 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 5/5] tests/qtest/qom-test: unit test for qom-list-getv
Date: Mon, 12 May 2025 06:47:15 -0700
Message-Id: <1747057635-124298-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120143
X-Proofpoint-ORIG-GUID: OHh2Ff2tGVidNp-eV2aaM2lC9BSDxbI5
X-Proofpoint-GUID: OHh2Ff2tGVidNp-eV2aaM2lC9BSDxbI5
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=6821fbed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=qcJeRBlVYMpeiZLlq9EA:9 cc=ntf
 awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NCBTYWx0ZWRfXySmVNAIzzrMv
 XWR/9s9uTinbaksbKn6E2n7Ehnqqab0iVOBdy1RUdmWzoAjBWGRBLnsSuvMV+4G07+xNYPSrdo3
 AwxF3aHGWEd8yUtaTYH/Nx0nP7a6J2BybNtD6lsNTC9jmAASR8sGQcxLGYWHNGS5Yv7BY1qLtC0
 utKip8JQAxPO49+8s7CcJoSiatDC/pcaLHMQhyG24DStzV5L/vQ4RkHsT9jKoWTEkzyzvaiDy8F
 OkTwibveMfwuVUFInPkAsGQzaWFaR24icSMY7u3O1GQ29jlwH/wSx24anW6YJfVWuSVEmylaonJ
 4vVlZ/8fdvEwZj6PEsTm6G0FRlHkU6fSD69LCRAI9NFP4ZJukkC6L5rZQOy6nsFTl0tpc0aVKXz
 lSok5eDyI9WeCeaCt8XENYAY1GVw+Fpa89CsIIrl9WXPOQ3YXQaRt9UL/MwNhN5Ni5y8ShUG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a unit test for qom-list-getv.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/qom-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index d8792bd..671b757 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -11,6 +11,7 @@
 
 #include "qobject/qdict.h"
 #include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
 
@@ -64,6 +65,66 @@ static void test_tree(QTestState *qts, const char *path)
     test_tree_node(node);
 }
 
+static void test_getv(QTestState *qts, QList *paths)
+{
+    QListEntry *entry, *prop_entry, *path_entry;
+    g_autoptr(QDict) response = NULL;
+    QDict *args = qdict_new();
+    QDict *prop;
+    QList *return_list;
+
+    if (verbosity_level >= 2) {
+        g_test_message("Obtaining properties for paths:");
+        QLIST_FOREACH_ENTRY(paths, path_entry) {
+            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
+            g_test_message("  %s", qstring_get_str(qstr));
+        }
+    }
+
+    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
+    response = qtest_qmp(qts, "{ 'execute': 'qom-list-getv',"
+                              "  'arguments': %p }", args);
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    return_list = qobject_to(QList, qdict_get(response, "return"));
+
+    path_entry = QTAILQ_FIRST(&paths->head);
+    QLIST_FOREACH_ENTRY(return_list, entry) {
+        QDict *obj = qobject_to(QDict, qlist_entry_obj(entry));
+        g_assert(qdict_haskey(obj, "properties"));
+        QList *properties = qobject_to(QList, qdict_get(obj, "properties"));
+        bool has_child = false;
+
+        QLIST_FOREACH_ENTRY(properties, prop_entry) {
+            prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
+            g_assert(qdict_haskey(prop, "name"));
+            g_assert(qdict_haskey(prop, "type"));
+            has_child |= strstart(qdict_get_str(prop, "type"), "child<", NULL);
+        }
+
+        if (has_child) {
+            /* build a list of child paths */
+            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
+            const char *path = qstring_get_str(qstr);
+            g_autoptr(QList) child_paths = qlist_new();
+
+            QLIST_FOREACH_ENTRY(properties, prop_entry) {
+                prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
+                if (strstart(qdict_get_str(prop, "type"), "child<", NULL)) {
+                    g_autofree char *child_path = g_strdup_printf(
+                        "%s/%s", path, qdict_get_str(prop, "name"));
+                    qlist_append_str(child_paths, child_path);
+                }
+            }
+
+            /* fetch props for all children with one qom-list-getv call */
+            test_getv(qts, child_paths);
+        }
+
+        path_entry = QTAILQ_NEXT(path_entry, next);
+    }
+}
+
 static void test_properties(QTestState *qts, const char *path, bool recurse)
 {
     char *child_path;
@@ -133,6 +194,7 @@ static void test_machine(gconstpointer data)
     const char *machine = data;
     QDict *response;
     QTestState *qts;
+    g_autoptr(QList) paths = qlist_new();
 
     qts = qtest_initf("-machine %s", machine);
 
@@ -149,6 +211,8 @@ static void test_machine(gconstpointer data)
 
     test_properties(qts, "/machine", true);
     test_tree(qts, "/machine");
+    qlist_append_str(paths, "/machine");
+    test_getv(qts, paths);
 
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
-- 
1.8.3.1


