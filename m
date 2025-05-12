Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF87DC3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETVM-0002FZ-Pw; Mon, 12 May 2025 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETVB-0002CU-3A
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETV5-0002SG-0S
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fFW026121;
 Mon, 12 May 2025 13:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=RUXd8sXm1ExW6dupqzMcTbh3B/3KE7AHCs8DtD9iahQ=; b=
 nRX/qepkKf8hlaTXtqL9HywgnXyPjMuiTtmyyF7BZmAkFMIXBEKJtdIqPQmwmVBf
 OBjw9prhD2GZXe0hdl5/GIc9hxqGVypnNoQpGhcBNUvqaQeS7EvHw1xSEQsxAYi5
 dS1/L7YyON/E7aOcrQymbJxRiE2lD6AIfeAhvctO5ix+BWRqC6q8M8q1AAffvfFE
 cwYI1LinL53r0Fp0ZqzwXf/bwOGW/lQ/LMfrcoDneTJmKJD0XFCP6GTCiDiVNrER
 HnffyWyTX7a2C0yslv438qe/+UOkE1rjcGMdT+ZRtqe8HQznQgwqo1n/7JpAlQ1s
 RnFOYC696pi/6ReydglJfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c2gpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CCM7IB033186; Mon, 12 May 2025 13:47:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46hw8ddfan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CDlHVd001568;
 Mon, 12 May 2025 13:47:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46hw8ddf9k-2; Mon, 12 May 2025 13:47:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/5] qom: qom-tree-get
Date: Mon, 12 May 2025 06:47:11 -0700
Message-Id: <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NCBTYWx0ZWRfX1AxZElKFpXOy
 D62rh30deLldcx3TwHynlr8//2ac9Mc7+B8kHjT5YQUdqVRQpej/khzscYVpra3Ru+Dj1tvOSzg
 bb7SXve/Vat2wXZlfRdxniVEGxjI2Dm8vMEG4bT5o2WT0TnW5JHto+guXifo/M51cXzEeJZqAtt
 XpLHAVFpwKBj/B1/x/MR7YRyV0bfeO8lhplaDjeIPh38xdGMxkuxJM2r03u2TkOrWfU6HCdS0J4
 1IBbziL3kQKz4VNYdIWvZtqvjFiTl3z+JcLsISO++b5Ie339psnZsSMNtR18s/xLP/Yxv3MsVo2
 QHpGYr4MKxMxjeuE6h7GOHyWOVqvjKEgkVfGa2OMoNbL1zIW6hYiRFsMBFkfuQYZPkE28uFjdT3
 jdFtrVxf+hFqQS+DHKsv2v6zA2EyoPAPWUqKBub11Pcv5AD7BR4eyxF5rdonvZzHqb6vz0Dp
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=6821fbe8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=kNkG7qB_sMBJrWmNXDsA:9 cc=ntf
 awl=host:14694
X-Proofpoint-GUID: ZF2zJu7WG9tCBW1k3IAqgIKeDqsDiiTO
X-Proofpoint-ORIG-GUID: ZF2zJu7WG9tCBW1k3IAqgIKeDqsDiiTO
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

Define the qom-tree-get QAPI command, which fetches an entire tree of
properties and values with a single QAPI call.  This is much faster
than using qom-list plus qom-get for every node and property of the
tree.  See qom.json for details.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/qom.json      | 56 ++++++++++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24c..94662ad 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -46,6 +46,38 @@
             '*default-value': 'any' } }
 
 ##
+# @ObjectPropertyValue:
+#
+# @name: the name of the property
+#
+# @type: the type of the property, as described in @ObjectPropertyInfo
+#
+# @value: the value of the property.  Omitted if cannot be read.
+#
+# Since 10.1
+##
+{ 'struct': 'ObjectPropertyValue',
+  'data': { 'name': 'str',
+            'type': 'str',
+            '*value': 'any' } }
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
+# Since 10.1
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
@@ -126,6 +158,30 @@
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
+#     - If a property cannot be read, the value field is omitted in
+#       the corresponding @ObjectPropertyValue.
+#
+# Returns: A tree of @ObjectNode.  Each node contains its name, list
+#     of properties, and list of child nodes.
+#
+# Since 10.1
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
index 293755f..b876681 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -69,6 +69,78 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
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
+        /*
+         * For bulk get, the error message is dropped, but the value field
+         * is omitted so the caller knows this property could not be read.
+         */
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


