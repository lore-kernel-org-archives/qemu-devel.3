Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37AFC83F10
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGJ-0007h5-OA; Tue, 08 Jul 2025 16:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZDu0-0002Yo-Ju
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:23:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZDtu-00018L-8q
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:22:51 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Gpw1T027313;
 Tue, 8 Jul 2025 17:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=ui1r9QrD+76G9OhlBOkb+Qz7bYMNJsbKdDzzLahSA7E=; b=
 JzhsjC5FvqouRfZxo42la2GF8ConywSd9ifD3k/8pLJL+RQOS1YymRPWkVAoXIF8
 rWmp+DQkrChPG7M8joFPqdXBVbjxr07l/7WxPx0VB9gcMeHH6QY60WKQVMIzb6Le
 dYq3pOLWKjknEgf1UMWhHwKwCXCx6weqmzfvjQnhGmmRaI40qtKgqf6vDmXcpC5j
 sO+ralVGf7I1jDuTSnOHbxZSZI6nNs61eiI6VIxyR7yL9qakU3K48rEftzqlNEUI
 MkPLsHQ9AZclulj0haPGZzq7wtXuX1LoNPEWLVDG96Qxmr16sruLxSc4yO8Vcobw
 cCMKg+PCuCJXzUFXlnPQxg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s77h8234-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 17:24:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 568H9TSp040652; Tue, 8 Jul 2025 17:24:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptga5ad8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 17:24:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 568HOXlh038795;
 Tue, 8 Jul 2025 17:24:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptga5acj-2; Tue, 08 Jul 2025 17:24:34 +0000
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
Subject: [PATCH V3 1/3] qom: qom-list-getv
Date: Tue,  8 Jul 2025 10:24:30 -0700
Message-Id: <1751995472-211897-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: dZNoqVM_vUJYeEfjXW-HY9jxRbvK7xqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0NyBTYWx0ZWRfX2q6fFlmRQaF3
 H1WYMTDKNpccQ135TjbpxN9t9QZVXXfVB+jYYAdLXlbSnfEIUykl27uwG1txMY0miqZP9otAhEo
 bswVIQYH/C9HgbMmpyAZ57XugVM4UZ0tv6VOvSi+cuvcMIQQy86LaEoZNOh8qT4JtBVpIBexfxW
 stGMYqvCePT2GKmJEXaW3m257mMFCqVWOSz2K0fY2W7mMA1E3olHTWYFyO3/AZ71vQp0Cf+Wvjt
 /RUGLXbuE1eX+S+vW6alWMiwOI0e/hGvWIjAiavjGTho1A4eO8ODgQkA7g1llgWaAy9THHuv5Eb
 5FfQt2moniVxNIP+1AeTvBqWFLn6xEmuvCc4ISFi3p1wmLiDILCF1vx236uhEhQYTENl1xrHuZY
 +xdAF96WyVAVt9kaeDcxLEJPUTx3BYRG94v9uRy1b4TRl9YFsINpSRrlF8OQyQtyz8PoGJFm
X-Authority-Analysis: v=2.4 cv=Qepmvtbv c=1 sm=1 tr=0 ts=686d5453 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=t2Pplciw6Ekvz-vbJ3MA:9
X-Proofpoint-ORIG-GUID: dZNoqVM_vUJYeEfjXW-HY9jxRbvK7xqO
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

Define the qom-list-getv command, which fetches all the properties and
values for a list of paths.  This is faster than qom-tree-get when
fetching a subset of the QOM tree.  See qom.json for details.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index b133b06..c16c2dd 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -46,6 +46,34 @@
             '*default-value': 'any' } }
 
 ##
+# @ObjectPropertyValue:
+#
+# @name: the name of the property
+#
+# @type: the type of the property, as described in @ObjectPropertyInfo
+#
+# @value: the value of the property.  Absent when the property cannot
+#     be read.
+#
+# Since 10.1
+##
+{ 'struct': 'ObjectPropertyValue',
+  'data': { 'name': 'str',
+            'type': 'str',
+            '*value': 'any' } }
+
+##
+# @ObjectPropertiesValues:
+#
+# @properties: a list of properties.
+#
+# Since 10.1
+##
+{ 'struct': 'ObjectPropertiesValues',
+  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
+
+
+##
 # @qom-list:
 #
 # This command will list any properties of a object given a path in
@@ -126,6 +154,28 @@
   'allow-preconfig': true }
 
 ##
+# @qom-list-getv:
+#
+# List properties and their values for each object path in the input
+# list.
+#
+# @paths: The absolute or partial path for each object, as described
+#     in @qom-get
+#
+# Errors:
+#     - If any path is not valid or is ambiguous
+#
+# Returns: A list of @ObjectPropertiesValues.  Each element contains
+#     the properties of the corresponding element in @paths.
+#
+# Since 10.1
+##
+{ 'command': 'qom-list-getv',
+  'data': { 'paths': [ 'str' ] },
+  'returns': [ 'ObjectPropertiesValues' ],
+  'allow-preconfig': true }
+
+##
 # @qom-set:
 #
 # This command will set a property from a object model path.
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 293755f..fa44ae7 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -69,6 +69,59 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
     return props;
 }
 
+static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
+                                        ObjectPropertyValueList **props)
+{
+    ObjectPropertyValue *item = g_new0(ObjectPropertyValue, 1);
+
+    QAPI_LIST_PREPEND(*props, item);
+
+    item->name = g_strdup(prop->name);
+    item->type = g_strdup(prop->type);
+    item->value = object_property_get_qobject(obj, prop->name, NULL);
+}
+
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
+    strList *path;
+
+    for (path = paths; path; path = path->next) {
+        ObjectPropertiesValues *item = g_new0(ObjectPropertiesValues, 1);
+
+        QAPI_LIST_APPEND(tail, item);
+
+        item->properties = qom_get_property_value_list(path->value, errp);
+        if (!item->properties) {
+            qapi_free_ObjectPropertiesValuesList(head);
+            return NULL;
+        }
+    }
+
+    return head;
+}
+
 void qmp_qom_set(const char *path, const char *property, QObject *value,
                  Error **errp)
 {
-- 
1.8.3.1


