Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D696C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2LR-0004jI-3B; Fri, 14 Feb 2025 15:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KN-00048e-5C
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KL-00021K-8E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAf9GaMvB/OkUbr8TNOAgRbhsmMLbkbbbiRNM5/Hcu8=;
 b=VNvmETYXTIP/3s12Z4eafNr5APM1vYkvM9lrHU+PAmt2Ea0/yYpXuOevkNv1zIM3W3iff6
 mq3ApOiugmt+bfkEVtl36was3S3n4wUrXAuieCpKqwA1iRkrSZ25WekTgmF/76F39HhU4e
 rZSXB9AJbWwT3L8wQrPb+P1O87g5Glg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-O2JL-QDNODOpoqvkTEDLXw-1; Fri,
 14 Feb 2025 15:30:17 -0500
X-MC-Unique: O2JL-QDNODOpoqvkTEDLXw-1
X-Mimecast-MFC-AGG-ID: O2JL-QDNODOpoqvkTEDLXw_1739565015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B18919039C1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:15 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC85D1800358; Fri, 14 Feb 2025 20:30:12 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 07/11] qapi: golang: Generate event type
Date: Fri, 14 Feb 2025 21:29:40 +0100
Message-ID: <20250214202944.69897-8-victortoso@redhat.com>
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch handles QAPI event types and generates data structures in
Go that handles it.

Note that the timestamp is part of the first layer of unmarshal, so it
s a member of protocol.go's Message type.

Example:
qapi:
 | ##
 | # @MEMORY_DEVICE_SIZE_CHANGE:
 | #
 | # Emitted when the size of a memory device changes.  Only emitted for
 | # memory devices that can actually change the size (e.g., virtio-mem
 | # due to guest action).
 | #
 | # @id: device's ID
 | #
 | # @size: the new size of memory that the device provides
 | #
 | # @qom-path: path to the device object in the QOM tree (since 6.2)
 | #
 | # .. note:: This event is rate-limited.
 | #
 | # Since: 5.1
 | #
 | # .. qmp-example::
 | #
 | #     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 | #          "data": { "id": "vm0", "size": 1073741824,
 | #                    "qom-path": "/machine/unattached/device[2]" },
 | #          "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
 | ##
 | { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
 |   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }

go:
 | // Emitted when the size of a memory device changes.  Only emitted for
 | // memory devices that can actually change the size (e.g., virtio-mem
 | // due to guest action).
 | //
 | // .. note:: This event is rate-limited.
 | //
 | // Since: 5.1
 | //
 | // .. qmp-example::    <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 | // "data": { "id": "vm0", "size": 1073741824,           "qom-path":
 | // "/machine/unattached/device[2]" },      "timestamp": { "seconds":
 | // 1588168529, "microseconds": 201316 } }
 | type MemoryDeviceSizeChangeEvent struct {
 | 	// device's ID
 | 	Id *string `json:"id,omitempty"`
 | 	// the new size of memory that the device provides
 | 	Size uint64 `json:"size"`
 | 	// path to the device object in the QOM tree (since 6.2)
 | 	QomPath string `json:"qom-path"`
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/golang.py | 49 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index 59e9b1f644..63d55ca950 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -291,7 +291,7 @@ def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
 
-def qapi_to_go_type_name(name: str) -> str:
+def qapi_to_go_type_name(name: str, meta: Optional[str] = None) -> str:
     # We want to keep CamelCase for Golang types. We want to avoid removing
     # already set CameCase names while fixing uppercase ones, eg:
     # 1) q_obj_SocketAddress_base -> SocketAddressBase
@@ -309,6 +309,12 @@ def qapi_to_go_type_name(name: str) -> str:
 
     name += "".join(word.title() for word in words[1:])
 
+    # Handle specific meta suffix
+    types = ["event"]
+    if meta in types:
+        name = name[:-3] if name.endswith("Arg") else name
+        name += meta.title().replace(" ", "")
+
     return name
 
 
@@ -818,7 +824,8 @@ def qapi_to_golang_struct(
                 fields.append(field)
                 with_nullable = True if nullable else with_nullable
 
-    type_name = qapi_to_go_type_name(name)
+    type_name = qapi_to_go_type_name(name, info.defn_meta)
+
     content = string_to_code(
         generate_struct_type(
             type_name, type_doc=type_doc, args=fields, indent=indent
@@ -996,6 +1003,15 @@ def generate_template_alternate(
     return "\n" + content
 
 
+def generate_template_event(events: dict[str, Tuple[str, str]]) -> str:
+    content = ""
+    for name in sorted(events):
+        type_name, gocode = events[name]
+        content += gocode
+
+    return content
+
+
 def generate_content_from_dict(data: dict[str, str]) -> str:
     content = ""
 
@@ -1045,11 +1061,13 @@ def __init__(self, _: str):
         types = {
             "alternate": ["encoding/json", "errors", "fmt"],
             "enum": [],
+            "event": [],
             "struct": ["encoding/json"],
             "union": ["encoding/json", "errors", "fmt"],
         }
 
         self.schema: QAPISchema
+        self.events: dict[str, Tuple[str, str]] = {}
         self.golang_package_name = "qapi"
         self.duplicate = list(gofiles)
         self.enums: dict[str, str] = {}
@@ -1096,6 +1114,7 @@ def visit_end(self) -> None:
         self.types["alternate"] += generate_content_from_dict(self.alternates)
         self.types["struct"] += generate_content_from_dict(self.structs)
         self.types["union"] += generate_content_from_dict(self.unions)
+        self.types["event"] += generate_template_event(self.events)
 
     def visit_object_type(
         self,
@@ -1254,7 +1273,31 @@ def visit_event(
         arg_type: Optional[QAPISchemaObjectType],
         boxed: bool,
     ) -> None:
-        pass
+        assert name == info.defn_name
+        assert name not in self.events
+        type_name = qapi_to_go_type_name(name, info.defn_meta)
+
+        if isinstance(arg_type, QAPISchemaObjectType):
+            content = string_to_code(
+                qapi_to_golang_struct(
+                    self,
+                    name,
+                    info,
+                    arg_type.ifcond,
+                    arg_type.features,
+                    arg_type.base,
+                    arg_type.members,
+                    arg_type.branches,
+                )
+            )
+        else:
+            doc = self.docmap.get(name, None)
+            type_doc, _ = qapi_to_golang_struct_docs(doc)
+            content = string_to_code(
+                generate_struct_type(type_name, type_doc=type_doc)
+            )
+
+        self.events[name] = (type_name, content)
 
     def write(self, outdir: str) -> None:
         godir = "go"
-- 
2.48.1


