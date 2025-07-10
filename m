Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A833C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuLu-0005nz-OG; Thu, 10 Jul 2025 12:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZu52-0008I5-5n
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:25:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZu4z-0002Yp-8K
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:25:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF73Rn007434;
 Thu, 10 Jul 2025 16:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=cE//pfudcTODs6Bpblx0fPAlgILfSOvak/md9xdgUz4=; b=
 ht08okJh07bxsaxrNFzNNpWDBvJ3zFvsE5tkIGG/UUB6CrXDC0KR2w09GKubLYm6
 JrCCwG9XhTFZ+RMdLCVnKbZHPepP5CcWH5MZnLa5gNJBUywLZKmNhL7xxQ4t1ijP
 iWmWxfjPWnk1+xJTHiuCDhWIqRHAFJ6p3oanxUj9nBC6KOXRQTsZRW7AFjNcdsst
 8cEAQBzVzhwv89qOiNiCg4CwJPcbsGYThBn+1n5Z0vbYTOSEjc5zZM0zdK6D2EG7
 MRCBpF2+QOkoaNYEI4bpkMR76KNLiYp6NyRnirWpT9RQKDXPSWq686tfiYyDKj23
 ubDcmZ59vFCUHNEPstqb3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfvd05bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 16:24:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56AF7GHd014236; Thu, 10 Jul 2025 16:24:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgd9brp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 16:24:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AGOtoo005343;
 Thu, 10 Jul 2025 16:24:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptgd9bq1-2; Thu, 10 Jul 2025 16:24:57 +0000
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
Subject: [PATCH V4 1/3] qom: qom-list-get
Date: Thu, 10 Jul 2025 09:24:52 -0700
Message-Id: <1752164694-215567-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100139
X-Authority-Analysis: v=2.4 cv=Ydi95xRf c=1 sm=1 tr=0 ts=686fe95a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=ZtL2jQY2KNOz_38zUf8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX5FE3tqTC5+un
 EgeXLP2UwJ/7AU2J5lp/8ptCCYJDd9dOosxsPPBjrbvA5Wzv1gEE6y9dsV79w6SFxzU2JkjHQor
 mVikeawvjDw6qxwJabkfy6PUwaAgZOVga6lLbVrLckygEYYhxGw9WncfA20AFGeiaXadN3yxMnY
 x3ukng8vKrnsu7VUYQlDX/SS2jdGoglRteUHiIpvjCyqf9qVZFR6ihoiOIjRBXpYyirUw8ZdGib
 alKlTVRwNukT6RUy3+QhIYFDqlvb4pmCglQYzV28ptv+T28OFHP3WklJT1f1/ptnOa1RNkVrnCH
 8Y6VKdHhCU7T/1WV0KLdMyVGypRkx1yCOiDKT2tcI8Q9x+/FevqG0QfHrT05yOqWabgsiqg0zJs
 6Jnw4W/JRQbvvy2jiBt6hOSIHLMpp1mSsQ6LqEl/KIWTH7Rwr3M/fQFOZGeWDNVtvNj4jiYB
X-Proofpoint-ORIG-GUID: Amd2Jj_RiK7gPraZGxzSujqtVDwcAH03
X-Proofpoint-GUID: Amd2Jj_RiK7gPraZGxzSujqtVDwcAH03
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Define the qom-list-get command, which fetches all the properties and
values for a list of paths.  This is faster than qom-list plus qom-get,
especially when fetching a large subset of the QOM tree.  Some managers
do so when starting a new VM, and this cost can be a substantial fraction
of start-up time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index b133b06..49214d2 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -46,6 +46,34 @@
             '*default-value': 'any' } }
 
 ##
+# @ObjectPropertyValue:
+#
+# @name: the name of the property.
+#
+# @type: the type of the property, as described in @ObjectPropertyInfo.
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
+# @qom-list-get:
+#
+# List properties and their values for each object path in the input
+# list.
+#
+# @paths: The absolute or partial path for each object, as described
+#     in `qom-get`.
+#
+# Errors:
+#     - If any path is not valid or is ambiguous
+#
+# Returns: A list where each element is the result for the
+#     corresponding element of @paths.
+#
+# Since 10.1
+##
+{ 'command': 'qom-list-get',
+  'data': { 'paths': [ 'str' ] },
+  'returns': [ 'ObjectPropertiesValues' ],
+  'allow-preconfig': true }
+
+##
 # @qom-set:
 #
 # This command will set a property from a object model path.
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 293755f..57f1898 100644
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
+ObjectPropertiesValuesList *qmp_qom_list_get(strList *paths, Error **errp)
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


