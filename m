Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB49EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETVL-0002FB-Mm; Mon, 12 May 2025 09:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETVD-0002Cm-6x
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETV8-0002TD-SG
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:29 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9dxQ027138;
 Mon, 12 May 2025 13:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=AS0mjd/WHO7b8BuOkIN1vTjhxVZ0MwywGHg+4PLzdPc=; b=
 WUQk6H2jEIGFbGUSJ5wPX+bAuWtMMQfumpdK7XBu9megaOJx7mlWwcnxyp1ZVVD4
 dsZSthS/jDGfZyuHhKv2ax2UOntOzKy/XZn2TK7gmdgmQ6xuBjreCsL7mkvQfWqR
 tjBd9drspExT+3AW+a0SUpErSe+jnwkrgZYgZs1kkMbO2j/R66b9Kn6ZNcV4ziTV
 lTk3KQySBcCjsJADJWS6uTIqBuXwiVnSOMsHrGcCDazl2LDxlQHBzLXAyO7W2vPv
 1dZHPOzHtd1iTU2fhSG5OJbGYqKBks/x/znQjxLLcuNVVkloTD+c5r8MYMLpPzVf
 fWDNJrSD2qpetX2s0UvGNQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnjjax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CCtiVs033245; Mon, 12 May 2025 13:47:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46hw8ddfck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CDlHVj001568;
 Mon, 12 May 2025 13:47:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46hw8ddf9k-5; Mon, 12 May 2025 13:47:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 4/5] qom: qom-list-getv
Date: Mon, 12 May 2025 06:47:14 -0700
Message-Id: <1747057635-124298-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: LobwhYbD1KFkBCUWHpKYFANEYr_vpxxO
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=6821fbec b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=YZ2zgiMlwQMHeJ-iOZUA:9 cc=ntf
 awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NCBTYWx0ZWRfX22qQJCV1SQKS
 maeg8LpO3/W+tMSFBHuuKZblW/2Fue0b1okCzdhLtaEr1dROn50gatLlszBrFQgIoHR+qjQZlhd
 2+oB+dZpsO2oZZ7T/OS/beA2B/qNRYfZ8Wipto1Y7WKXkzW9Eg+hzKNz+CwYpB3bQrTK6HtCHn8
 nmg6wtFrww6MDH7bCYpSeX+6RP6waIxwVGifNTpouDRp/eZsu2B/VOezq1eEv1vMx30PP14JZ8q
 jWN9OQxFgyDWCd4oByeoD8RtvbQODUu8C+0RPgz9bIemNjEJDrSpdGLazoAQ8FOdkT/GCfZwXA6
 eRmhnUa8LFlhe5GKjjeVKs6l/pVIJZnBVscqq40S3fEf5dHVuOLQg05vuJSCa0Vc6+lrtmav4nr
 24rGb1oviI8ElDIzEiWMLErw1dop4XVt7ZVoXxSsCP0nC+z5JO7/HOZFHWGxkTF/lOTECw+M
X-Proofpoint-ORIG-GUID: LobwhYbD1KFkBCUWHpKYFANEYr_vpxxO
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

Define the qom-list-getv command, which fetches all the properties and
values for a list of paths.  This is faster than qom-tree-get when
fetching a subset of the QOM tree.  See qom.json for details.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/qom.json      | 34 ++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 94662ad..dc710d6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -62,6 +62,16 @@
             '*value': 'any' } }
 
 ##
+# @ObjectPropertiesValues:
+#
+# @properties: a list of properties.
+#
+# Since 10.1
+##
+{ 'struct': 'ObjectPropertiesValues',
+  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
+
+##
 # @ObjectNode:
 #
 # @name: the name of the node
@@ -158,6 +168,30 @@
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
+#     - If a property cannot be read, the value field is omitted in
+#       the corresponding @ObjectPropertyValue.
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
 # @qom-tree-get:
 #
 # This command returns a tree of objects and their properties,
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index b876681..1f05956 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -90,6 +90,46 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
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


