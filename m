Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88B9C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEea-0000Mt-II; Tue, 08 Jul 2025 16:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZDXn-0005XY-QF
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:59:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZDXY-0001yA-B3
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:59:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568FCNZF001766;
 Tue, 8 Jul 2025 17:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=ODlnkDVqYrwFRf3xs1XGpAmQypuyZzJb+ZfuFfImNBk=; b=
 CV3BlyNrgbrA2pqJGw82WsdbVZ2E+INSd8BgFz3Woz+TEkJDS7pkwzctLu9/BAIW
 hrqdWJlBRJb6w5NQUkZS6oJvDjfA7HxCBLhYBKvgvP6s+21+2A+WI2Od00QKmJgl
 w81luzYkvT9eSJuJYPpBHwEpnVfQQ97Ih/tYKz0FLxreB00P4XsptLrsFFP7nrXb
 BlFm1I8SlvhxsJWy420Tr+3nli6BBAE5C/ZeT5pMqrNz3lpbTPUY8v7KVtG57wPm
 gPHQ5JT/gfxqpmt/qGIH1/vnkUn7ve8bDfUIMrPDv/uOmpdyresE1FlOiJnYeFqU
 POQsFGxQij3FO2Gd7q7Oow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s5rtg9te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 17:24:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 568H23An040464; Tue, 8 Jul 2025 17:24:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptga5adt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 17:24:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 568HOXlj038795;
 Tue, 8 Jul 2025 17:24:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptga5acj-3; Tue, 08 Jul 2025 17:24:34 +0000
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
Subject: [PATCH V3 2/3] python: use qom-list-getv
Date: Tue,  8 Jul 2025 10:24:31 -0700
Message-Id: <1751995472-211897-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0NiBTYWx0ZWRfX1T8QiXFnw0Rt
 3SABzOy295tgKDm4rX8OFx4+AK7G/srvtM83+7LiGzyB22TcxiBJ7dj6bQ8Lv+kCAOQ4+Y8MYN1
 pggV24khZyMT/VjHluj+q8ZwwYCbROK7zxxcNFQabBpttJrPBI6sOjV174tm9eZEbUSfwt8Ep4T
 BZ5/bA5P58eATf3+hhrTDVntt0QWXH8Zbrl8eL1+T9M26D5w66QGAqhsDKudwEAwUFpUi8YW0bo
 vt5S4PcATZTFPULTRp7CtDeMa2duNy77oK7+0tUrfCDwm9K6B4koCh2dKLcDG6KQeFTuudjfn4X
 BkSpifwNtY3B29wPKVypwLW8Mpw1Ga4GUqxs8gAAE+P7jGLFrzLOWCYuJYASPGp3+VOgAvTwsEi
 VxpzG8uD98JJSbXPNgdq3htoYAQSUcMBswJ0YphAzF/oSCyR64bmThRHvKdysW9QWzEezk5O
X-Authority-Analysis: v=2.4 cv=ScT3duRu c=1 sm=1 tr=0 ts=686d5454 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=RXQK8gpASe9cUJZfEHoA:9
X-Proofpoint-GUID: FIPk0zJQQdO1lPZzLucPUBfQgjx1MQ0o
X-Proofpoint-ORIG-GUID: FIPk0zJQQdO1lPZzLucPUBfQgjx1MQ0o
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

Use qom-list-getv to speed up the qom-tree command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 python/qemu/utils/qom.py        | 43 +++++++++++++++++++--------------
 python/qemu/utils/qom_common.py | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/python/qemu/utils/qom.py b/python/qemu/utils/qom.py
index 426a0f2..6b2f1ab 100644
--- a/python/qemu/utils/qom.py
+++ b/python/qemu/utils/qom.py
@@ -224,28 +224,35 @@ def __init__(self, args: argparse.Namespace):
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
+    def _list_nodes(self, paths: [str]) -> None:
+        all_paths_props = self.qom_list_getv(paths)
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
+                    newpaths += [ f"{path}/{item.name}" ]
+                else:
+                    value = item.value
+                    if value == None:
+                        value = f"<EXCEPTION: property could not be read>"
+                    print(f"  {item.name}: {value} ({item.type})")
+
+            print('')
+
+            if newpaths:
+                self._list_nodes(newpaths)
+
 
     def run(self) -> int:
-        self._list_node(self.path)
+        self._list_nodes([self.path])
         return 0
 
 
diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index dd2c8b1..4db97ba 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -65,6 +65,50 @@ def link(self) -> bool:
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
+    Represents the return type from e.g. qom-list-getv
+    """
+    def __init__(self, properties):
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
 
 
@@ -145,6 +189,15 @@ def qom_list(self, path: str) -> List[ObjectPropertyInfo]:
         assert isinstance(rsp, list)
         return [ObjectPropertyInfo.make(x) for x in rsp]
 
+    def qom_list_getv(self, paths) -> List[ObjectPropertiesValues]:
+        """
+        :return: a strongly typed list from the 'qom-list-getv' command.
+        """
+        rsp = self.qmp.cmd('qom-list-getv', paths=paths)
+        # qom-list-getv returns List[ObjectPropertiesValues]
+        assert isinstance(rsp, list)
+        return [ObjectPropertiesValues.make(x) for x in rsp]
+
     @classmethod
     def command_runner(
             cls: Type[CommandT],
-- 
1.8.3.1


