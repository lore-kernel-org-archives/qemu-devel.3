Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D733C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETVK-0002EG-DB; Mon, 12 May 2025 09:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETVB-0002CV-3s
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETV6-0002ST-T8
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:28 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9eoL029137;
 Mon, 12 May 2025 13:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=4eN4C9eEc9s6E6jZPCtPOrAOeaCHgKWGsoNHkcKgh5I=; b=
 QLv0DV+w9mDYRifG4/8j1AMRLaEDFYbxufBtoqwteGrMA5VTV07/wfJYm3x7+JUs
 xbQnNRWPrXZ6FBqUo6GX8/FWDymPHLBpUOjapvrNkWx9bYAZdyFM1/nIC40RTnHV
 TSMKy/R2qVdLjzx4jLeKmMKBE6tDeUBtJfVh3O3xefWe1tJOAns5cAFY7VuEdr9R
 Akj72sD7icTUbpU7/+MRzUb5Yt0NvFVIwW1uOQwilFrGGFRGslpeO8B2+J2N/cvZ
 LUC5vnSBUR6aS+vrkCTZdvlFFyzCcAnLYnue3lntulyC8L73gBwM+b9SgGViAqP7
 UbWcS8/FAX7NniTGBcFI7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwjken-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CCpe5a033194; Mon, 12 May 2025 13:47:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46hw8ddfba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CDlHVf001568;
 Mon, 12 May 2025 13:47:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46hw8ddf9k-3; Mon, 12 May 2025 13:47:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 2/5] python: use qom-tree-get
Date: Mon, 12 May 2025 06:47:12 -0700
Message-Id: <1747057635-124298-3-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=6821fbe9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=RXQK8gpASe9cUJZfEHoA:9 cc=ntf
 awl=host:14694
X-Proofpoint-GUID: _ErVZj3JYSnuoGiyVZgShdTX2mhXHWpE
X-Proofpoint-ORIG-GUID: _ErVZj3JYSnuoGiyVZgShdTX2mhXHWpE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NCBTYWx0ZWRfX2QaTYCbGW/wr
 a6CQ5ca+PkLqfKqZyLtCaPmIrKYkRkcNUbzZZKLifEYAZ5HQyEjh3Xh8aKmfoj8N08dRSW5AqOO
 Phmk4lvE+ZPDcRIhd5uXFBp/LBfSbNCLHmj3jayCPf0LEAc3VwpKsoAlJBxPuUSgZu4MuHAhupk
 FvIWRMRYTJEqBrOSuDeXGy+oaBVzPFHjQdFMZBv/ElUFpwSmcxz/rrm8tiodpluutJCe1uiOYeY
 f7sAI4kMEyZ21Aby2nrgTfK4MgpPC5VAGGVl19xB3AQJGn5uf9VnGmj8q27nEp9V6FjpZ9OMNIU
 dstyVrbCioDb+O/xupyEjT0gbnsSDOabTLYVMtYAfWIXxfKaKKSxKd3P8M+MsF26SdLTO5ew1yQ
 DyjRF3T4Dqy4LHVhdyrMYNF5UkUEdeRV/puc4L48/X0z7EehXJxL/8EMlkMTJcFuE1Tafv+T
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

Use qom-tree-get to speed up the qom-tree command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 python/qemu/utils/qom.py        | 36 +++++++++++++++----------------
 python/qemu/utils/qom_common.py | 48 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/python/qemu/utils/qom.py b/python/qemu/utils/qom.py
index 426a0f2..33d0a60 100644
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
+    def _list_tree(self, node: ObjectNode, path: str) -> None:
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
+                value = f"<EXCEPTION: property could not be read>"
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
+        self._list_tree(root, self.path)
+
         return 0
 
 
diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index dd2c8b1..8c242cc 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -65,6 +65,47 @@ def link(self) -> bool:
         return self.type.startswith('link<')
 
 
+class ObjectPropertyValue:
+    """
+    Represents a property return from e.g. qom-tree-get
+    """
+    def __init__(self, name: str, type_: str, value: object):
+        self.name = name
+        self.type = type_
+        self.value = value
+
+    @classmethod
+    def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyValue':
+        """
+        Build an ObjectPropertyValue from a Dict with an unknown shape.
+        """
+        assert value.keys() >= {'name', 'type'}
+        assert value.keys() <= {'name', 'type', 'value'}
+        return cls(value['name'], value['type'], value.get('value'))
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
 
 
@@ -145,6 +186,13 @@ def qom_list(self, path: str) -> List[ObjectPropertyInfo]:
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


