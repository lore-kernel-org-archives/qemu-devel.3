Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6366C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETVJ-0002EE-Vs; Mon, 12 May 2025 09:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETVB-0002CT-36
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETV6-0002Sk-TA
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9etB024086;
 Mon, 12 May 2025 13:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=T2hzi8iEVL34CA8o3O1EbEuB4mKyIX2uch2o7TJcJ20=; b=
 DbaKIL0EiowoCxM2dCkm+Thm81he/mFfA3vr9O0Cs2uuKmZxB7tieK8PPk86IfiR
 NmwXip/iU4/4dLsh80e+dghwsa/CApbY9eUHVnD/YrK6nOijUUxJHv0dUeWmOiU2
 AkoA46HuLzN7Wx5o7zjZboxz0plSyEaBKvDneAu99A2wOQ/2GOutkmfDvqlafbcL
 k8AFXXjP4nPrtY5M0axKdu902di1b3Vl3FIPu7W2HkIpDxZE9/xGRMzUXjVy86vZ
 anhvytLQf09pDdb/7ww/XTM8gJeDCMtGJiMGEgJ7MKqdAqHfd/3OBd28kn8KZN6s
 whPhjZTIbi4VCW5RZIipTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2afy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CCea5T033277; Mon, 12 May 2025 13:47:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46hw8ddfby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CDlHVh001568;
 Mon, 12 May 2025 13:47:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46hw8ddf9k-4; Mon, 12 May 2025 13:47:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 3/5] tests/qtest/qom-test: unit test for qom-tree-get
Date: Mon, 12 May 2025 06:47:13 -0700
Message-Id: <1747057635-124298-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: aNQwkARuhBwnD9mjMCiU92x74PzYwnoK
X-Proofpoint-GUID: aNQwkARuhBwnD9mjMCiU92x74PzYwnoK
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=6821fbea b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=EXJkLREwFe9pvE9t1A4A:9 cc=ntf
 awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NCBTYWx0ZWRfX9UysMMC0tzJ6
 lMe9QAlKoQMC5Mwm0jgMuWwPCQbD3r30ruwFtP7PW1RsiF8HJECjpGIVJ6uRCCf+OeRUoh2BfIS
 mmNxPJUsV0Qd3hsCIRrQpcSQjHN7QnikyS1NQs11mEzWHGjEONLkhZqFY/mm5EWlxtXqGTNGk1n
 gU6Ywdp3+7bm+LDd8K7/zzaVPql9NTwKQz7TcOtkLYyRA/TzgHsr2oY4YhoXmPvbeeTiNgZKqZd
 IOKBPdyUs6Q+9Vj+0C/mir7IuQGZnxYRfxEl2bBOQ3sEclvNUtQSuMIgoGpx5sybTn70E9DhE5z
 ZQq0FKxvr8bgfVY8vbvU7DUqF0wODFsQutC4oepoo76gWdi34JOJWyz/1UpRgO9zIkDkc3ZVxSn
 F+3xVmjRgFz1AtrOkgaccz6o2wOXBJ6z8U19lkvKH2LotbiHwBfmA6yX3Pq/ZLTByofzXKPJ
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

Add a unit test for qom-tree-get

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/qom-test.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 27d70bc..d8792bd 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -16,6 +16,54 @@
 
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
@@ -100,6 +148,7 @@ static void test_machine(gconstpointer data)
     }
 
     test_properties(qts, "/machine", true);
+    test_tree(qts, "/machine");
 
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
-- 
1.8.3.1


