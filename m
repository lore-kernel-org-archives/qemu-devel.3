Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C120C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 21:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpD3P-0008Vz-Nv; Mon, 03 Mar 2025 16:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3L-0008UD-3o
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3J-0008Nf-2x
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:18 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523JfkGW017866;
 Mon, 3 Mar 2025 21:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=ymG9MI8EghEaDX850prhJcUy2cuLgqR7OEveo/GRfb4=; b=
 n1Ct2seLIsiOj+n3ah/Rcv3RzaPqwq5iP0wQd83ae1VK9i0D7hsA2DjCGnLc4+TU
 SYmCVE7mXwLBHYZdk8Ke7hgZM4SFfo56dHZG80nLe1U7iaW0/pyEZ7IU/OmEgf30
 vFbtOczulRdA90A3Fy3aBJtyKzE2tafdkuAvIN6IM7b2P//S3xFRAN1hKvWVc+a7
 FWKok8ssrmPUBBFffnBfdZjrA9AbgmiPBir3f+LBS3tLNOgUG3I7YpLozffzpaj3
 HRT1PxnBKDPAsGs3U9grtw2Ot/9WELjXQBwAc0e12wcibVtBf3KI9tEewIXKB8x1
 YJyXX3wXP3VUyo5fo53qTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qbpcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 523KMPXY003159; Mon, 3 Mar 2025 21:10:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp82q6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:12 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 523LA4Im022708;
 Mon, 3 Mar 2025 21:10:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rp82pwh-6; Mon, 03 Mar 2025 21:10:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 5/6] qom: qom-list-getv
Date: Mon,  3 Mar 2025 13:10:01 -0800
Message-Id: <1741036202-265696-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: qeU7ZfyMylSbLpqwKeMB-ggO373VbWhu
X-Proofpoint-GUID: qeU7ZfyMylSbLpqwKeMB-ggO373VbWhu
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

Define the qom-list-getv command, which fetches all the properties and
values for a list of paths.  This is faster than qom-tree-get when
fetching a subset of the QOM tree.  See qom.json for details.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/qom.json      | 34 ++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 646e3c6..c0c1839 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -65,6 +65,16 @@
             '*error': 'str' } }
 
 ##
+# @ObjectPropertiesValues:
+#
+# @properties: a list of properties.
+#
+# Since 10.0
+##
+{ 'struct': 'ObjectPropertiesValues',
+  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
+
+##
 # @ObjectNode:
 #
 # @name: the name of the node
@@ -161,6 +171,30 @@
   'allow-preconfig': true }
 
 ##
+# @qom-list-getv:
+#
+# This command returns a list of properties and their values for
+# each object path in the input list.
+#
+# @paths: The absolute or partial path for each object, as described
+#     in @qom-get
+#
+# Errors:
+#     - If any path is not valid or is ambiguous, returns an error.
+#     - If a property cannot be read, returns an error message in the
+#       corresponding @ObjectPropertyValue.
+#
+# Returns: A list of @ObjectPropertiesValues.  Each element contains
+#     the properties of the corresponding element in @paths.
+#
+# Since 10.0
+##
+{ 'command': 'qom-list-getv',
+  'data': { 'paths': [ 'str' ] },
+  'returns': [ 'ObjectPropertiesValues' ],
+  'allow-preconfig': true }
+
+##
 # @qom-tree-get:
 #
 # This command returns a tree of objects and their properties,
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 271f62d..b38f0d2 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -87,6 +87,46 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
     }
 }
 
+static ObjectPropertyValueList *qom_get_property_value_list(const char *path,
+                                                            Error **errp)
+{
+    Object *obj;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+    ObjectPropertyValueList *props = NULL;
+
+    obj = qom_resolve_path(path, errp);
+    if (obj == NULL) {
+        return NULL;
+    }
+
+    object_property_iter_init(&iter, obj);
+    while ((prop = object_property_iter_next(&iter))) {
+        qom_list_add_property_value(obj, prop, &props);
+    }
+
+    return props;
+}
+
+ObjectPropertiesValuesList *qmp_qom_list_getv(strList *paths, Error **errp)
+{
+    ObjectPropertiesValuesList *head = NULL, **tail = &head;
+
+    for ( ; paths ; paths = paths->next) {
+        ObjectPropertiesValues *item = g_new0(ObjectPropertiesValues, 1);
+
+        QAPI_LIST_APPEND(tail, item);
+
+        item->properties = qom_get_property_value_list(paths->value, errp);
+        if (!item->properties) {
+            qapi_free_ObjectPropertiesValuesList(head);
+            return NULL;
+        }
+    }
+
+    return head;
+}
+
 static ObjectNode *qom_tree_get(const char *path, Error **errp)
 {
     Object *obj;
-- 
1.8.3.1


