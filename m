Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07AFC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 21:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdGvO-0000oK-Th; Thu, 22 Feb 2024 16:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvF-0000mi-Cl
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvC-0005Py-CR
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:05 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MIRQmR001400; Thu, 22 Feb 2024 21:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=RnPc4eYUt0g0xAZDD5FUqWBAvFTUt2l2aFTg/OWv1i0=;
 b=MQdFtkKzgFtCnqv2j0Y2MWg/4briExUQAjfh4YnZxJvHMAnsVFzRGh8gP+4gqpm36wZZ
 /u22UH4gvI5dU6qGta/WH/bP4OARrgWn6gF3ZXPF7lKl90lRizqxhBdwtTnIkEkg3p9H
 4qrNBkvxyAHK2XLmsipIXVgQ2rA2jEdJbZ5UOvdD7iDKa/326byyfJC5yfOO0TomCVTn
 Z637AiMo6jZzz3Ra0/EBOTSXkSnPGmY2vWcCIWG47WyGLIu4YXQrq+owy0vxQUYlUTh8
 IBAQIPUjdjRWkhguC7Xvqe15MSb7uA4LP/rcySdcio4euBe90/pDrR7TwjRrrsPaFVuI /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud6106-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:58 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MKxcK4022224; Thu, 22 Feb 2024 21:47:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8bft6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:57 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MLlqUF037274;
 Thu, 22 Feb 2024 21:47:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8bft40-5; Thu, 22 Feb 2024 21:47:57 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 4/5] util: strList unit tests
Date: Thu, 22 Feb 2024 13:47:49 -0800
Message-Id: <1708638470-114846-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220169
X-Proofpoint-GUID: jOfdfrmH6h244bNZ9eT0EP9HAHb8XHQB
X-Proofpoint-ORIG-GUID: jOfdfrmH6h244bNZ9eT0EP9HAHb8XHQB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/unit/meson.build    |  1 +
 tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 tests/unit/test-strList.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index cae925c..9984860 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -35,6 +35,7 @@ tests = {
   'test-rcu-simpleq': [],
   'test-rcu-tailq': [],
   'test-rcu-slist': [],
+  'test-strList': [],
   'test-qdist': [],
   'test-qht': [],
   'test-qtree': [],
diff --git a/tests/unit/test-strList.c b/tests/unit/test-strList.c
new file mode 100644
index 0000000..40af6b2
--- /dev/null
+++ b/tests/unit/test-strList.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/strList.h"
+
+static strList *make_list(int length)
+{
+    strList *head = 0, *list, **prev = &head;
+
+    while (length--) {
+        list = *prev = g_new0(strList, 1);
+        list->value = g_strdup("aaa");
+        prev = &list->next;
+    }
+    return head;
+}
+
+static void test_length(void)
+{
+    strList *list;
+    int i;
+
+    for (i = 0; i < 5; i++) {
+        list = make_list(i);
+        g_assert_cmpint(i, ==, QAPI_LIST_LENGTH(list));
+        qapi_free_strList(list);
+    }
+}
+
+struct {
+    const char *string;
+    const char *delim;
+    const char *argv[5];
+} list_data[] = {
+    { NULL, ",", { NULL } },
+    { "", ",", { NULL } },
+    { "a", ",", { "a", NULL } },
+    { "a,b", ",", { "a", "b", NULL } },
+    { "a,b,c", ",", { "a", "b", "c", NULL } },
+    { "first last", " ", { "first", "last", NULL } },
+    { "a:", ":", { "a", "", NULL } },
+    { "a::b", ":", { "a", "", "b", NULL } },
+    { ":", ":", { "", "", NULL } },
+    { ":a", ":", { "", "a", NULL } },
+    { "::a", ":", { "", "", "a", NULL } },
+};
+
+static void test_strv(void)
+{
+    int i, j;
+    const char **expect;
+    strList *list;
+    char **argv;
+
+    for (i = 0; i < ARRAY_SIZE(list_data); i++) {
+        expect = list_data[i].argv;
+        list = str_split(list_data[i].string, list_data[i].delim);
+        argv = strv_from_strList(list);
+        qapi_free_strList(list);
+        for (j = 0; expect[j] && argv[j]; j++) {
+            g_assert_cmpstr(expect[j], ==, argv[j]);
+        }
+        g_assert_null(expect[j]);
+        g_assert_null(argv[j]);
+        g_strfreev(argv);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/test-string/length", test_length);
+    g_test_add_func("/test-string/strv", test_strv);
+    return g_test_run();
+}
-- 
1.8.3.1


