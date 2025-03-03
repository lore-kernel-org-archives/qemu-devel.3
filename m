Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4311C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 21:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpD3L-0008UC-4m; Mon, 03 Mar 2025 16:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3I-0008Sz-GE
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3F-0008LM-Kr
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:16 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Jfj7o001862;
 Mon, 3 Mar 2025 21:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=XWn/yl+IYSyCxLcwU+QNkD8Plx1teZJqFh96mmzQUcY=; b=
 O9puZOvXozIFE3SPjqLPkopUgcZcb2lMs8x/M2mozXCUAuFwATPm3+i71vKDevMS
 vh9Bi0TpA7WBhuyM6IwvJgqEUO7yGyIRh6jwb8Mv4AUVbpiowdoozrrhyr8rdwoD
 vy8N0MZ93q26IMNeWKi+mdsZ5BPADhHDAXqT+ivm6pXdY860lj+1dLurnN/9qK2U
 LNVQA8oRbow37FjnSNcPyacl9cT4GhrwxPQrUZ0XRMnN0zj0k0tElcqtAD9XX+KS
 cRYGflYpOoNSWoxHLaveywJaOhyqL9PBmTaIlQA2NrtWY3A6K/nC69CCRN8F0Y1j
 XkJkuYkk3lB2yrrWo4DIVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavumag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 523JsFwZ003199; Mon, 3 Mar 2025 21:10:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp82q35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 523LA4Ig022708;
 Mon, 3 Mar 2025 21:10:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rp82pwh-3; Mon, 03 Mar 2025 21:10:08 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/6] qom: qom-tree-get
Date: Mon,  3 Mar 2025 13:09:58 -0800
Message-Id: <1741036202-265696-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: nu9-l-LA__8pGOCRWUA_qN-grRdzGocd
X-Proofpoint-ORIG-GUID: nu9-l-LA__8pGOCRWUA_qN-grRdzGocd
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

Define the qom-tree-get QAPI command, which fetches an entire tree of
properties and values with a single QAPI call.  This is much faster
than using qom-list plus qom-get for every node and property of the
tree.  See qom.json for details.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/qom.json      | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24c..646e3c6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -46,6 +46,41 @@
             '*default-value': 'any' } }
 
 ##
+# @ObjectPropertyValue:
+#
+# @name: the name of the property
+#
+# @type: the type of the property, as described in @ObjectPropertyInfo
+#
+# @value: the value of the property
+#
+# @error: error message if value cannot be fetched
+#
+# Since 10.0
+##
+{ 'struct': 'ObjectPropertyValue',
+  'data': { 'name': 'str',
+            'type': 'str',
+            '*value': 'any',
+            '*error': 'str' } }
+
+##
+# @ObjectNode:
+#
+# @name: the name of the node
+#
+# @children: child nodes
+#
+# @properties: properties of the node
+#
+# Since 10.0
+##
+{ 'struct': 'ObjectNode',
+  'data': { 'name': 'str',
+            'children': [ 'ObjectNode' ],
+            'properties': [ 'ObjectPropertyValue' ] }}
+
+##
 # @qom-list:
 #
 # This command will list any properties of a object given a path in
@@ -126,6 +161,30 @@
   'allow-preconfig': true }
 
 ##
+# @qom-tree-get:
+#
+# This command returns a tree of objects and their properties,
+# rooted at the specified path.
+#
+# @path: The absolute or partial path within the object model, as
+#     described in @qom-get
+#
+# Errors:
+#     - If path is not valid or is ambiguous, returns an error.
+#     - If a property cannot be read, returns an error message in the
+#       corresponding @ObjectPropertyValue.
+#
+# Returns: A tree of @ObjectNode.  Each node contains its name, list
+#     of properties, and list of child nodes.
+#
+# Since 10.0
+##
+{ 'command': 'qom-tree-get',
+  'data': { 'path': 'str' },
+  'returns': 'ObjectNode',
+  'allow-preconfig': true }
+
+##
 # @qom-set:
 #
 # This command will set a property from a object model path.
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 293755f..271f62d 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -69,6 +69,75 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
     return props;
 }
 
+static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
+                                        ObjectPropertyValueList **props)
+{
+    ObjectPropertyValue *item = g_new0(ObjectPropertyValue, 1);
+    Error *err = NULL;
+
+    QAPI_LIST_PREPEND(*props, item);
+
+    item->name = g_strdup(prop->name);
+    item->type = g_strdup(prop->type);
+    item->value = object_property_get_qobject(obj, prop->name, &err);
+
+    if (!item->value) {
+        item->error = g_strdup(error_get_pretty(err));
+        error_free(err);
+    }
+}
+
+static ObjectNode *qom_tree_get(const char *path, Error **errp)
+{
+    Object *obj;
+    ObjectProperty *prop;
+    ObjectNode *result, *child;
+    ObjectPropertyIterator iter;
+
+    obj = qom_resolve_path(path, errp);
+    if (obj == NULL) {
+        return NULL;
+    }
+
+    result = g_new0(ObjectNode, 1);
+
+    object_property_iter_init(&iter, obj);
+    while ((prop = object_property_iter_next(&iter))) {
+        if (strstart(prop->type, "child<", NULL)) {
+            g_autofree char *child_path = g_strdup_printf("%s/%s",
+                                                          path, prop->name);
+            child = qom_tree_get(child_path, errp);
+            if (!child) {
+                qapi_free_ObjectNode(result);
+                return NULL;
+            }
+            child->name = g_strdup(prop->name);
+            QAPI_LIST_PREPEND(result->children, child);
+        } else {
+            qom_list_add_property_value(obj, prop, &result->properties);
+        }
+    }
+
+    return result;
+}
+
+ObjectNode *qmp_qom_tree_get(const char *path, Error **errp)
+{
+    ObjectNode *result = qom_tree_get(path, errp);
+
+    if (result) {
+        /* Strip the path prefix if any */
+        const char *basename = strrchr(path, '/');
+
+        if (!basename || !basename[1]) {
+            result->name = g_strdup(path);
+        } else {
+            result->name = g_strdup(basename + 1);
+        }
+    }
+    return result;
+}
+
 void qmp_qom_set(const char *path, const char *property, QObject *value,
                  Error **errp)
 {
-- 
1.8.3.1


