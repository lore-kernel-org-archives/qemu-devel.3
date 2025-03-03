Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D46C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 21:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpD3N-0008V3-U1; Mon, 03 Mar 2025 16:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3K-0008Tq-5E
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3I-0008NJ-1t
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:17 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523JfiqP026461;
 Mon, 3 Mar 2025 21:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=H3l95ZER4KNR1p4p31JowLss+I5amTgeB3YcwYI1urA=; b=
 NcM11Qs+fkcjEkNRuN0eAdp9mgGzdJz23z+/BrIcF4uxG/8L5tBqWy5Cl/rVq8m3
 7AJk4DU1v1ZsKCaUOMyMf43Wz1paf0i9LCTsRt117RrtCymk7sw9h8Aq0KYM8JuG
 OTOrPHb0zoZcDlX2Tg3sjopDz+eClxgxM+anZwScjT2DR9T1lp+vFSDgXeNxHvpU
 XiuOZHXtbj36SLx8W6mqBCcSnw8Mu+pBi3AD3QgF+O5bMHyMi4ICIXnXNcTwOoWo
 0eWC+adyaha1CBhlvT9vzUK607BNBXAqtWl084UUGQavNHQDA+4N9MycarLGWSIJ
 I5gmin6hYyXlUzfZVvldEg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub73nex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 523KktjX003168; Mon, 3 Mar 2025 21:10:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp82q5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 523LA4Ik022708;
 Mon, 3 Mar 2025 21:10:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rp82pwh-5; Mon, 03 Mar 2025 21:10:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 4/6] tests/qtest/qom-test: unit test for qom-tree-get
Date: Mon,  3 Mar 2025 13:10:00 -0800
Message-Id: <1741036202-265696-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030163
X-Proofpoint-GUID: aq4J2j1rbssGx6qFLvSmk4pd1SFt8Y4d
X-Proofpoint-ORIG-GUID: aq4J2j1rbssGx6qFLvSmk4pd1SFt8Y4d
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
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

Add a unit test for qom-tree-get

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/qom-test.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 27d70bc..c567c4c 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -16,6 +16,55 @@
 
 static int verbosity_level;
 
+static void test_tree_node(QDict *node)
+{
+    QDict *prop, *child;
+    QList *props, *children;
+    QListEntry *entry;
+
+    g_assert(qdict_haskey(node, "name"));
+    g_assert(qdict_haskey(node, "properties"));
+
+    if (verbosity_level >= 3) {
+        g_test_message("%s", qdict_get_str(node, "name"));
+    }
+
+    props = qobject_to(QList, qdict_get(node, "properties"));
+    QLIST_FOREACH_ENTRY(props, entry) {
+        prop = qobject_to(QDict, qlist_entry_obj(entry));
+        g_assert(qdict_haskey(prop, "name"));
+        g_assert(qdict_haskey(prop, "type"));
+        g_assert(qdict_haskey(prop, "value") || qdict_haskey(prop, "error"));
+    }
+
+    if (!qdict_haskey(node, "children")) {
+        return;
+    }
+
+    children = qobject_to(QList, qdict_get(node, "children"));
+    QLIST_FOREACH_ENTRY(children, entry) {
+        child = qobject_to(QDict, qlist_entry_obj(entry));
+        test_tree_node(child);
+    }
+}
+
+static void test_tree(QTestState *qts, const char *path)
+{
+    g_autoptr(QDict) response = NULL;
+    QDict *node;
+
+    if (verbosity_level >= 2) {
+        g_test_message("Obtaining tree at %s", path);
+    }
+    response = qtest_qmp(qts, "{ 'execute': 'qom-tree-get',"
+                              "  'arguments': { 'path': %s } }", path);
+    g_assert(response);
+
+    g_assert(qdict_haskey(response, "return"));
+    node = qobject_to(QDict, qdict_get(response, "return"));
+    test_tree_node(node);
+}
+
 static void test_properties(QTestState *qts, const char *path, bool recurse)
 {
     char *child_path;
@@ -100,6 +149,7 @@ static void test_machine(gconstpointer data)
     }
 
     test_properties(qts, "/machine", true);
+    test_tree(qts, "/machine");
 
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
-- 
1.8.3.1


