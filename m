Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6527DC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2Ls-0005Z7-79; Fri, 14 Feb 2025 15:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KT-00049H-Ez
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KP-000225-59
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3SVrTqLq8tuMrJJ7lHZyUbVQuh8koYYjB5pQtXNihI=;
 b=alvB0Xohjj9M+/Q8tmvz+cq4D+UvetVULyws+shWYO/+CuEb4mWJh8fLr0GXRq7Aklg6DE
 FKv7Wq2lP/E+S8J3Fd2QrpeFQa2Q2CUdrvB2XtHQNVDXYNBSLpcqZzgCIKdvzby3gwBu7p
 F1avZ/S5tqXmS8wmpWJqMMOs9cz0+CI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-rePO_smrPnONYfBgBjPnWA-1; Fri,
 14 Feb 2025 15:30:22 -0500
X-MC-Unique: rePO_smrPnONYfBgBjPnWA-1
X-Mimecast-MFC-AGG-ID: rePO_smrPnONYfBgBjPnWA_1739565021
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9879118EB2C6
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:21 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 513D91800358; Fri, 14 Feb 2025 20:30:18 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 09/11] qapi: golang: Generate command type
Date: Fri, 14 Feb 2025 21:29:42 +0100
Message-ID: <20250214202944.69897-10-victortoso@redhat.com>
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

This patch handles QAPI command types and generates data structures in
Go that handles it.

Note that command's id is part of the first layer of unmarshal, so it
is a member of protocol.go's Message type.

qapi:
 | ##
 | # @add-fd:
 | #
 | # Add a file descriptor, that was passed via SCM rights, to an fd set.
 | #
 | # @fdset-id: The ID of the fd set to add the file descriptor to.
 | #
 | # @opaque: A free-form string that can be used to describe the fd.
 | #
 | # Returns:
 | #     @AddfdInfo
 | #
 | # Errors:
 | #     - If file descriptor was not received, GenericError
 | #     - If @fdset-id is a negative value, GenericError
 | #
 | # .. note:: The list of fd sets is shared by all monitor connections.
 | #
 | # .. note:: If @fdset-id is not specified, a new fd set will be
 | #    created.
 | #
 | # Since: 1.2
 | #
 | # .. qmp-example::
 | #
 | #     -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
 | #     <- { "return": { "fdset-id": 1, "fd": 3 } }
 | ##
 | { 'command': 'add-fd',
 |   'data': { '*fdset-id': 'int',
 |             '*opaque': 'str' },
 |   'returns': 'AddfdInfo' }

go:
 | // Add a file descriptor, that was passed via SCM rights, to an fd
 | // set.
 | //
 | // Returns:   @AddfdInfo
 | //
 | // Errors:   - If file descriptor was not received, GenericError   -
 | // If @fdset-id is a negative value, GenericError
 | //
 | // .. note:: The list of fd sets is shared by all monitor connections.
 | // .. note:: If @fdset-id is not specified, a new fd set will be
 | // created.
 | //
 | // Since: 1.2
 | //
 | // .. qmp-example::    -> { "execute": "add-fd", "arguments": {
 | // "fdset-id": 1 } }   <- { "return": { "fdset-id": 1, "fd": 3 } }
 | type AddFdCommand struct {
 | 	// The ID of the fd set to add the file descriptor to.
 | 	FdsetId *int64 `json:"fdset-id,omitempty"`
 | 	// A free-form string that can be used to describe the fd.
 | 	Opaque *string `json:"opaque,omitempty"`
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/golang.py | 52 +++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index b9a2c47137..a14970fb1f 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -316,7 +316,7 @@ def qapi_to_go_type_name(name: str, meta: Optional[str] = None) -> str:
     name += "".join(word.title() for word in words[1:])
 
     # Handle specific meta suffix
-    types = ["event"]
+    types = ["event", "command"]
     if meta in types:
         name = name[:-3] if name.endswith("Arg") else name
         name += meta.title().replace(" ", "")
@@ -1009,6 +1009,15 @@ def generate_template_alternate(
     return "\n" + content
 
 
+def generate_template_command(commands: dict[str, Tuple[str, str]]) -> str:
+    content = ""
+    for name in sorted(commands):
+        type_name, gocode = commands[name]
+        content += gocode
+
+    return content
+
+
 def generate_template_event(events: dict[str, Tuple[str, str]]) -> (str, str):
     content = ""
     methods = ""
@@ -1069,6 +1078,7 @@ def __init__(self, _: str):
         # Map each qapi type to the necessary Go imports
         types = {
             "alternate": ["encoding/json", "errors", "fmt"],
+            "command": [],
             "enum": [],
             "event": [],
             "struct": ["encoding/json"],
@@ -1080,6 +1090,7 @@ def __init__(self, _: str):
 
         self.schema: QAPISchema
         self.events: dict[str, Tuple[str, str]] = {}
+        self.commands: dict[str, Tuple[str, str]] = {}
         self.golang_package_name = "qapi"
         self.duplicate = list(gofiles)
         self.enums: dict[str, str] = {}
@@ -1140,6 +1151,8 @@ def visit_end(self) -> None:
         self.types["event"] += evtype
         self.interfaces["event"] += eviface
 
+        self.types["command"] += generate_template_command(self.commands)
+
     def visit_object_type(
         self,
         name: str,
@@ -1286,7 +1299,42 @@ def visit_command(
         allow_preconfig: bool,
         coroutine: bool,
     ) -> None:
-        pass
+        assert name == info.defn_name
+        assert name not in self.commands
+
+        type_name = qapi_to_go_type_name(name, info.defn_meta)
+
+        doc = self.docmap.get(name, None)
+        type_doc, _ = qapi_to_golang_struct_docs(doc)
+
+        content = ""
+        if boxed or not arg_type or not qapi_name_is_object(arg_type.name):
+            args: List[dict[str:str]] = []
+            if arg_type:
+                args.append(
+                    {
+                        "name": f"{arg_type.name}",
+                    }
+                )
+            content += string_to_code(
+                generate_struct_type(type_name, type_doc=type_doc, args=args)
+            )
+        else:
+            assert isinstance(arg_type, QAPISchemaObjectType)
+            content += string_to_code(
+                qapi_to_golang_struct(
+                    self,
+                    name,
+                    arg_type.info,
+                    arg_type.ifcond,
+                    arg_type.features,
+                    arg_type.base,
+                    arg_type.members,
+                    arg_type.branches,
+                )
+            )
+
+        self.commands[name] = (type_name, content)
 
     def visit_event(
         self,
-- 
2.48.1


