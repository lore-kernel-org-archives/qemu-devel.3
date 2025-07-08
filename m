Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE6FC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFL9-0005P7-Fr; Tue, 08 Jul 2025 16:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZEVW-0006yb-Au
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:01:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZEVQ-0003cq-L7
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:01:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568HMYgW009600;
 Tue, 8 Jul 2025 17:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=KRzY4YwpdEDe0jKsVB14eVb8XLiMevfIwj9xjZIJ/Y4=; b=
 sKcxlcPmhcsVrREoIVMXz2oxBFPcRErZQqW0ibX5evYMfKTXzo8zFs4gut1oRMUV
 /KV6HWak7gx+RqcsvjEGPuooEYxhij/BrKki1i5c9bfFeQku61JdhlKzPvXFAvnf
 SE1NP1ZTzzmEoo+DBcbSbQmA0Myh8/qgTTkFZ34zTW/6/MWaXF3rX+U37i5+omR0
 ADa6WAlqpaTuDTg5/4PImLwcflV68cLkHG02kZr3U3B9yEdk6cORsYMWwDhIXCLm
 SzYdof/7OjD5pJNA/bDqvbkuDjV7zZeVBjepTPe1JCJKYqWa9gm34PQrRoaOKyND
 QYkLbjVQcUQ6f3Y6YSxNRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s7nm004d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 17:24:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 568H9sxw040587; Tue, 8 Jul 2025 17:24:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptga5ae4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 17:24:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 568HOXll038795;
 Tue, 8 Jul 2025 17:24:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptga5acj-4; Tue, 08 Jul 2025 17:24:35 +0000
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
Subject: [PATCH V3 3/3] tests/qtest/qom-test: unit test for qom-list-getv
Date: Tue,  8 Jul 2025 10:24:32 -0700
Message-Id: <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080146
X-Authority-Analysis: v=2.4 cv=C9vpyRP+ c=1 sm=1 tr=0 ts=686d5455 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=qcJeRBlVYMpeiZLlq9EA:9
X-Proofpoint-ORIG-GUID: ME-WbvZ4MAKHk34EKWWeWIpY_j2MTEu5
X-Proofpoint-GUID: ME-WbvZ4MAKHk34EKWWeWIpY_j2MTEu5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0NiBTYWx0ZWRfX0rV17ONbM6/3
 PrzoMVcMJLJSAv8+SoOAmV6eK9p8VetDyaxh5UFJnctVXMXxP8r8U2/EMP3A8k6x9w7H83v1t6O
 fWcAKtKLEhYpz0s4nopnA8iRskXCBxR69WTGbXvQysp3R9vYwY5hAc4/SAQVtfmaCgsWPbEvU2A
 NOfiWlrWbKOX+w5Suldk5DZud3TA/X4ohRLpx0yZfiC8yGI4U/iuaOT/rHmewdXv6aDV0vw3tx0
 QQtynJRCtT6NTwhLT/1PSU4aRP2YY5/hlcwFKNeccgZwZzaO8Ozrf3mgWp4nKLTXV2U8oQW53Hj
 ghjIVusRJjw/Gdjvo+RwS3jNVO5ZQ/mUi5SuxhQuNBxPEY1hKAODI2+r1+lwrESzbxH0bkJKNlO
 U4kww474fMnJ5V+cvAJB+vw94KbsdtqmhWpUeTm4kDbvcW/w13WgsdZvPRg3wMUEBj5YzYEf
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

Add a unit test for qom-list-getv.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/qom-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 27d70bc..4defff1 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -11,11 +11,72 @@
 
 #include "qobject/qdict.h"
 #include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
 
 static int verbosity_level;
 
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
@@ -85,6 +146,7 @@ static void test_machine(gconstpointer data)
     const char *machine = data;
     QDict *response;
     QTestState *qts;
+    g_autoptr(QList) paths = qlist_new();
 
     qts = qtest_initf("-machine %s", machine);
 
@@ -100,6 +162,8 @@ static void test_machine(gconstpointer data)
     }
 
     test_properties(qts, "/machine", true);
+    qlist_append_str(paths, "/machine");
+    test_getv(qts, paths);
 
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
-- 
1.8.3.1


