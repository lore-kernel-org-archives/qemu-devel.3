Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8A4C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5t6-0002yN-4a; Wed, 16 Jul 2025 13:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t3-0002s8-4b
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uc5t0-00086t-DP
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752686741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gFio82H82XpXmL0jnSv5xvDWFvNWQ2OVJeSAKSdYbs=;
 b=YTCTOMKQzGVYE2DCnyeLxFGenJ3bxp0EMuQQpSZ6CBIxSPe4Zx5TVZibTGEr4ULPCqKwuV
 PTiRC8oQe+QVN2UaqwR/NoYfVqgji8bihX+l8+2YM+cWcVQ/zyCDxatvImEBd96AoEvi7c
 yaC4zTlJtwLZeThxMjYwJT9VJ4U7LTU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-g4M26thaN-CNtA7uhys6Sw-1; Wed,
 16 Jul 2025 13:25:39 -0400
X-MC-Unique: g4M26thaN-CNtA7uhys6Sw-1
X-Mimecast-MFC-AGG-ID: g4M26thaN-CNtA7uhys6Sw_1752686739
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E07B81956094; Wed, 16 Jul 2025 17:25:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B1411977029; Wed, 16 Jul 2025 17:25:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6484F21E6925; Wed, 16 Jul 2025 19:25:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 2/6] python: use qom-list-get
Date: Wed, 16 Jul 2025 19:25:31 +0200
Message-ID: <20250716172535.3520175-3-armbru@redhat.com>
In-Reply-To: <20250716172535.3520175-1-armbru@redhat.com>
References: <20250716172535.3520175-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Use qom-list-get to speed up the qom-tree command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <1752248703-217318-3-git-send-email-steven.sistare@oracle.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
[Lint picked off to mollify make check-minreqs]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 python/qemu/utils/qom.py        | 45 +++++++++++++++------------
 python/qemu/utils/qom_common.py | 55 +++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/python/qemu/utils/qom.py b/python/qemu/utils/qom.py
index 426a0f245f..05e5f14179 100644
--- a/python/qemu/utils/qom.py
+++ b/python/qemu/utils/qom.py
@@ -31,8 +31,7 @@
 ##
 
 import argparse
-
-from qemu.qmp import ExecuteError
+from typing import List
 
 from .qom_common import QOMCommand
 
@@ -224,28 +223,34 @@ def __init__(self, args: argparse.Namespace):
         super().__init__(args)
         self.path = args.path
 
-    def _list_node(self, path: str) -> None:
-        print(path)
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
-        print('')
-        for item in items:
-            if not item.child:
-                continue
+    def _list_nodes(self, paths: List[str]) -> None:
+        all_paths_props = self.qom_list_get(paths)
+        i = 0
+
+        for props in all_paths_props:
+            path = paths[i]
+            i = i + 1
+            print(path)
             if path == '/':
                 path = ''
-            self._list_node(f"{path}/{item.name}")
+            newpaths = []
+
+            for item in props.properties:
+                if item.child:
+                    newpaths += [f"{path}/{item.name}"]
+                else:
+                    value = item.value
+                    if value is None:
+                        value = "<EXCEPTION: property could not be read>"
+                    print(f"  {item.name}: {value} ({item.type})")
+
+            print('')
+
+            if newpaths:
+                self._list_nodes(newpaths)
 
     def run(self) -> int:
-        self._list_node(self.path)
+        self._list_nodes([self.path])
         return 0
 
 
diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index dd2c8b1908..ab21a4d364 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -65,6 +65,52 @@ def link(self) -> bool:
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
+    @property
+    def child(self) -> bool:
+        """Is this property a child property?"""
+        return self.type.startswith('child<')
+
+
+class ObjectPropertiesValues:
+    """
+    Represents the return type from e.g. qom-list-get
+    """
+    # pylint: disable=too-few-public-methods
+
+    def __init__(self, properties: List[ObjectPropertyValue]) -> None:
+        self.properties = properties
+
+    @classmethod
+    def make(cls, value: Dict[str, Any]) -> 'ObjectPropertiesValues':
+        """
+        Build an ObjectPropertiesValues from a Dict with an unknown shape.
+        """
+        assert value.keys() == {'properties'}
+        props = [ObjectPropertyValue(item['name'],
+                                     item['type'],
+                                     item.get('value'))
+                 for item in value['properties']]
+        return cls(props)
+
+
 CommandT = TypeVar('CommandT', bound='QOMCommand')
 
 
@@ -145,6 +191,15 @@ def qom_list(self, path: str) -> List[ObjectPropertyInfo]:
         assert isinstance(rsp, list)
         return [ObjectPropertyInfo.make(x) for x in rsp]
 
+    def qom_list_get(self, paths: List[str]) -> List[ObjectPropertiesValues]:
+        """
+        :return: a strongly typed list from the 'qom-list-get' command.
+        """
+        rsp = self.qmp.cmd('qom-list-get', paths=paths)
+        # qom-list-get returns List[ObjectPropertiesValues]
+        assert isinstance(rsp, list)
+        return [ObjectPropertiesValues.make(x) for x in rsp]
+
     @classmethod
     def command_runner(
             cls: Type[CommandT],
-- 
2.49.0


