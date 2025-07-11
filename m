Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3627CC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaG5G-0006iR-F1; Fri, 11 Jul 2025 11:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFw2-0000qJ-5r
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:45:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFvz-0000hi-1n
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:45:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEMkp6012025;
 Fri, 11 Jul 2025 15:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=JXpIR4bUlKclfrp5ikFy6kgfAmZSmw9iQOamSHyHcCg=; b=
 ZBBTlCmVi1RvgoEL04tSg7lnj8K6JTGzI6YQrTBg9STjMHlrnhuOCCq8R55U69rR
 OzFMI1sIjv9jmWxXXMsqVpmg/ei1DW0M/wZShEGCSHOYYGZWAWmkGEDPk9db8Go/
 /oO6JssVGw18onZ64jnU4f7/wiZTFAx3LIT6xo7jXJ6uJ4gDkg1l0hI8XQJj9dSD
 dfGgzjfdIprH/26l5xkBF0/uD/moV1NiuPjIzkHn04+60lAs2nl/I2kkgyAe97vX
 T4588UEpaPy1quT3qzyjFRvA2CtCAF5NbjQMSrCa1vPiocFMt7YYN/xPRl5fcZoC
 6u5O9miUurFrHYibTbtbEg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u4akg5ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:45:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BE0wX3040623; Fri, 11 Jul 2025 15:45:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgdxyrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:45:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56BFj4Y4029028;
 Fri, 11 Jul 2025 15:45:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptgdxyn4-4; Fri, 11 Jul 2025 15:45:06 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 3/3] tests/qtest/qom-test: unit test for qom-list-get
Date: Fri, 11 Jul 2025 08:45:03 -0700
Message-Id: <1752248703-217318-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752248703-217318-1-git-send-email-steven.sistare@oracle.com>
References: <1752248703-217318-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMyBTYWx0ZWRfXyM3gsS1hsX6c
 ZbA/Z0dbwOHHXxfDko7P/EnO+IvWnJaqNpkbTrygywQMW9pVWAIP0mS6qKowWGRT4P+cVJoJaXL
 tKZuvDV/1mP2nzdHOlh2hr7mBYgGUIQ7W40zPWMpy6todiL2E440nnepi56INZb9cOd5VMO7+me
 TnTtmhaLXoT2SRRP5aXLfI3tx7YhhMUhtLi3+BHL6ULeXkbJiKY76EkSpLnQZmHALBOcH5xJX3b
 dGpZHalCJuDXUFhHAmn8M8dHChhwa1fRHXZuttr8eorawvsq072M6OF4X3ahgALzQozYASOVQOg
 3n06M6Donr7yM9XbjDYGw+rP73YnPHQZOggFxWcTRR+VXjfYpd3qz+aWRJmuctJNCyu62mhPx3s
 0wehPgOBjdJp7IHhn18YvE/+5HofjZrJwCtw+ValMdTHWSRYIFF0fjo2QWJNnL1UT2JpmJLo
X-Proofpoint-GUID: 0Cnkbo0il8T4YuwYMw8YY9ggQ7Wlu6R6
X-Authority-Analysis: v=2.4 cv=KrNN2XWN c=1 sm=1 tr=0 ts=68713183 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=WINDFw4_gsHOHzS5P5AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0Cnkbo0il8T4YuwYMw8YY9ggQ7Wlu6R6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Add a unit test for qom-list-get.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/qom-test.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 27d70bc..4ade1c7 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -11,11 +11,119 @@
 
 #include "qobject/qdict.h"
 #include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
 
+#define RAM_NAME "node0"
+#define RAM_SIZE 65536
+
 static int verbosity_level;
 
+/*
+ * Verify that the /object/RAM_NAME 'size' property is RAM_SIZE.
+ */
+static void test_list_get_value(QTestState *qts)
+{
+    QDict *args = qdict_new();
+    g_autoptr(QDict) response = NULL;
+    g_autoptr(QList) paths = qlist_new();
+    QListEntry *entry, *prop_entry;
+    const char *prop_name;
+    QList *properties, *return_list;
+    QDict *obj;
+
+    qlist_append_str(paths, "/objects/" RAM_NAME);
+    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
+    response = qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
+                              "  'arguments': %p }", args);
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    return_list = qobject_to(QList, qdict_get(response, "return"));
+
+    entry = QTAILQ_FIRST(&return_list->head);
+    obj = qobject_to(QDict, qlist_entry_obj(entry));
+    g_assert(qdict_haskey(obj, "properties"));
+    properties = qobject_to(QList, qdict_get(obj, "properties"));
+
+    QLIST_FOREACH_ENTRY(properties, prop_entry) {
+        QDict *prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
+
+        g_assert(qdict_haskey(prop, "name"));
+        g_assert(qdict_haskey(prop, "value"));
+
+        prop_name = qdict_get_str(prop, "name");
+        if (!strcmp(prop_name, "type")) {
+            g_assert_cmpstr(qdict_get_str(prop, "value"), ==,
+                            "memory-backend-ram");
+
+        } else if (!strcmp(prop_name, "size")) {
+            g_assert_cmpint(qdict_get_int(prop, "value"), ==, RAM_SIZE);
+        }
+    }
+}
+
+static void test_list_get(QTestState *qts, QList *paths)
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
+    response = qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
+                              "  'arguments': %p }", args);
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    return_list = qobject_to(QList, qdict_get(response, "return"));
+    g_assert(!qlist_empty(return_list));
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
+            /* fetch props for all children with one qom-list-get call */
+            test_list_get(qts, child_paths);
+        }
+
+        path_entry = QTAILQ_NEXT(path_entry, next);
+    }
+}
+
 static void test_properties(QTestState *qts, const char *path, bool recurse)
 {
     char *child_path;
@@ -85,8 +193,10 @@ static void test_machine(gconstpointer data)
     const char *machine = data;
     QDict *response;
     QTestState *qts;
+    g_autoptr(QList) paths = qlist_new();
 
-    qts = qtest_initf("-machine %s", machine);
+    qts = qtest_initf("-machine %s -object memory-backend-ram,id=%s,size=%d",
+                      machine, RAM_NAME, RAM_SIZE);
 
     if (g_test_slow()) {
         /* Make sure we can get the machine class properties: */
@@ -101,6 +211,10 @@ static void test_machine(gconstpointer data)
 
     test_properties(qts, "/machine", true);
 
+    qlist_append_str(paths, "/machine");
+    test_list_get(qts, paths);
+    test_list_get_value(qts);
+
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
-- 
1.8.3.1


