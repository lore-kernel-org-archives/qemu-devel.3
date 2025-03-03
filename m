Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DFDC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 21:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpD3L-0008UB-2T; Mon, 03 Mar 2025 16:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3I-0008T6-NY
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3G-0008M5-F5
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:16 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Jfhqh024364;
 Mon, 3 Mar 2025 21:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=mVjoSD1a74QPF4osoDZrnFim+5AI3lM1u0kQ95TMG+k=; b=
 e96IhSrxXOxIYL6K7Cxu7pszrP0t/LH0xu/S8chJbgA5XqlV+NeloJHi3QDXVqdx
 Uu1WCJQ+JvoWSdvWB+PJ1pWf4odcziyCg5Aa4BsK5bNj4FgMo2IYlCQNj5OrA1HP
 USJUK76RDctqXFg1d1uJezSumCUGnEXMUfbG0Ep1GqUIo+TRwgQvibvSeMcCic+B
 7PAgh/GBq01FHRa298eszn+ylWv4MhGXuzLDqysqsdTV/hD9aTJP+QpAYVpuaOem
 rNYDWplsFFt3ekF5DGW0JCEgCmlyQ7o7WfWEh/CcSu9Mw19VGYloz/yhwx10gFTZ
 aNThvhS//akNhFyJRXsUkw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81un6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 523K3C97003202; Mon, 3 Mar 2025 21:10:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp82q4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 523LA4Ii022708;
 Mon, 3 Mar 2025 21:10:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rp82pwh-4; Mon, 03 Mar 2025 21:10:09 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 3/6] python: use qom-tree-get
Date: Mon,  3 Mar 2025 13:09:59 -0800
Message-Id: <1741036202-265696-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: upKnyjoLk3AC-OqJM0Z77LQFq_fP2nui
X-Proofpoint-ORIG-GUID: upKnyjoLk3AC-OqJM0Z77LQFq_fP2nui
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

Use qom-tree-get to speed up the qom-tree command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 python/qemu/utils/qom.py        | 36 ++++++++++++++---------------
 python/qemu/utils/qom_common.py | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/python/qemu/utils/qom.py b/python/qemu/utils/qom.py
index 426a0f2..086a592 100644
--- a/python/qemu/utils/qom.py
+++ b/python/qemu/utils/qom.py
@@ -35,6 +35,7 @@
 from qemu.qmp import ExecuteError
 
 from .qom_common import QOMCommand
+from .qom_common import ObjectNode
 
 
 try:
@@ -224,28 +225,27 @@ def __init__(self, args: argparse.Namespace):
         super().__init__(args)
         self.path = args.path
 
-    def _list_node(self, path: str) -> None:
+    def _list_node(self, node: ObjectNode, path: str) -> None:
         print(path)
-        items = self.qom_list(path)
-        for item in items:
-            if item.child:
-                continue
-            try:
-                rsp = self.qmp.cmd('qom-get', path=path,
-                                   property=item.name)
-                print(f"  {item.name}: {rsp} ({item.type})")
-            except ExecuteError as err:
-                print(f"  {item.name}: <EXCEPTION: {err!s}> ({item.type})")
+
+        for item in node.properties:
+            value = item.value
+            if value == None:
+                value = f"<EXCEPTION: {item.error}>"
+            print(f"  {item.name}: {value} ({item.type})")
+
         print('')
-        for item in items:
-            if not item.child:
-                continue
-            if path == '/':
-                path = ''
-            self._list_node(f"{path}/{item.name}")
+        if path == '/':
+            path = ''
+
+        for child in node.children:
+            self._list_tree(child, f"{path}/{child.name}")
+
 
     def run(self) -> int:
-        self._list_node(self.path)
+        root = self.qom_tree_get(self.path)
+        self._list_node(root, self.path)
+
         return 0
 
 
diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index dd2c8b1..0303863 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -65,6 +65,49 @@ def link(self) -> bool:
         return self.type.startswith('link<')
 
 
+class ObjectPropertyValue:
+    """
+    Represents a property return from e.g. qom-tree-get
+    """
+    def __init__(self, name: str, type_: str, value: object, error: str):
+        self.name = name
+        self.type = type_
+        self.value = value
+        self.error = error
+
+    @classmethod
+    def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyValue':
+        """
+        Build an ObjectPropertyValue from a Dict with an unknown shape.
+        """
+        assert value.keys() >= {'name', 'type'}
+        assert value.keys() <= {'name', 'type', 'value', 'error'}
+        return cls(value['name'], value['type'],
+                   value.get('value'), value.get('error'))
+
+
+class ObjectNode:
+    """
+    Represents the return type from e.g. qom-tree-get
+    """
+    def __init__(self, name: str, children: List['ObjectNode'],
+                 properties: List[ObjectPropertyValue]):
+        self.name = name
+        self.children = children
+        self.properties = properties
+
+    @classmethod
+    def make(cls, value: Dict[str, Any]) -> 'ObjectNode':
+        """
+        Build an ObjectNode from a Dict with an unknown shape.
+        """
+        assert value.keys() == {'name', 'children', 'properties'}
+
+        props = [ObjectPropertyValue.make(x) for x in value['properties']]
+        children = [ObjectNode.make(x) for x in value['children']]
+        return cls(value['name'], children, props)
+
+
 CommandT = TypeVar('CommandT', bound='QOMCommand')
 
 
@@ -145,6 +188,13 @@ def qom_list(self, path: str) -> List[ObjectPropertyInfo]:
         assert isinstance(rsp, list)
         return [ObjectPropertyInfo.make(x) for x in rsp]
 
+    def qom_tree_get(self, path: str) -> ObjectNode:
+        """
+        :return: a strongly typed root node from the 'qom-tree-get' command.
+        """
+        rsp = self.qmp.cmd('qom-tree-get', path=path)
+        return ObjectNode.make(rsp)
+
     @classmethod
     def command_runner(
             cls: Type[CommandT],
-- 
1.8.3.1


