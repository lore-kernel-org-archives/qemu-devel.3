Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B1EC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaG5F-0006eT-GH; Fri, 11 Jul 2025 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFw2-0000q1-32
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:45:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFvx-0000hQ-VX
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:45:13 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDRCsh004563;
 Fri, 11 Jul 2025 15:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=RPkHsKac4ssr6xYi+ju77ULlhoaPZ/ujPaO8llcWYbQ=; b=
 BC1EA1+IlvCgkTkhfcQiHmRr4ZUn3yjUPnRNBkA6xIuW0cnMcH90ivgZVtxLVOJ8
 3uw2LMmJVAuwCj5XenTBHNiIGP1kvjZO+mTGxBUkCZsK3yzlGI/F5uzI8GRRmtwq
 7wtEMqjB9eC8hLyH7jjJV2CUNZGYDHZ3/MrfAgLr3fm5BlWzCnAnDSOcAWGXa5wy
 sbbEg86oiYAembrKVxNZex6VZ8cDkceUMAdNZt/Pkge8FjavhV96eO8+H+FC6uVv
 5h+xw2wmcC52MFkSC5qDMIQYuZdI47Us1mO4driHjq8QtCNve4RF13JCGdZVq41o
 pyy+dcniiPIIbhgP9cMheg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u3gk894s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:45:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BEL95d040441; Fri, 11 Jul 2025 15:45:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgdxypu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:45:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56BFj4Y0029028;
 Fri, 11 Jul 2025 15:45:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptgdxyn4-2; Fri, 11 Jul 2025 15:45:04 +0000
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
Subject: [PATCH V5 1/3] qom: qom-list-get
Date: Fri, 11 Jul 2025 08:45:01 -0700
Message-Id: <1752248703-217318-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752248703-217318-1-git-send-email-steven.sistare@oracle.com>
References: <1752248703-217318-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110113
X-Proofpoint-ORIG-GUID: p8seV4KV2MFXVftjKHC3WTI8y48KQOAz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMyBTYWx0ZWRfX9bJTR4rdJxO8
 b5YnkxMlumKmixAJDZfSs4FvpV9eHjcvvcsBFZooPqJJY/BukKZ9QhbMwGAruTC9YE8LLI1hIfo
 ZG/88LvtfVuz9hGqkTOcQ3S9vIZshJoDqOhU3yWhRek8DzJI72KMukgFZyjmaAedzSQHZ+9pB6O
 yTInPcOelCxoZTQfBvGCTncUfZD8jj02wlxs2eBq3JPDX8mjqMnVkC50nS7fXEUHeIGfl3pyw0H
 x8gSbFsDPd4Yi148CicePdQbjt9Im1r1mJR20T5hibIXxch7ly3eUluLDrAPLdW956Tc87VaHjB
 wK4dyPi0F4dTkP4w0ktg9a9v4vKw3SaY1+9SrK5jEE2xx2MnQd7NgJa6mHq9s6sLz6Cdo9hT/IN
 SPY2NNwVO6LOG//rX634TuQdMHAslvVfLNWIjBkFMGJJ2wiu047+wJgJRf5y57gfaVWz+Guh
X-Authority-Analysis: v=2.4 cv=eK0TjGp1 c=1 sm=1 tr=0 ts=68713182 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=RI4lvY2tQeSJgSjKVgsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: p8seV4KV2MFXVftjKHC3WTI8y48KQOAz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Using qom-list and qom-get to get all the nodes and property values in
a QOM tree can take multiple seconds because it requires 1000's of
individual QOM requests.  Some managers fetch the entire tree or a
large subset of it when starting a new VM, and this cost is a
substantial fraction of start up time.

Define the qom-list-get command, which fetches all the properties and
values for a list of paths.  This can be much faster than qom-list
plus qom-get.  When getting an entire QOM tree, I measured a 10x
speedup in elapsed time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index b133b06..510ae93 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -46,6 +46,34 @@
             '*default-value': 'any' } }
 
 ##
+# @ObjectPropertyValue:
+#
+# @name: the name of the property.
+#
+# @type: the type of the property, as described in `ObjectPropertyInfo`.
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


