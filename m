Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F711C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2LX-0004xK-Sc; Fri, 14 Feb 2025 15:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KU-00049S-RD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KT-00022R-84
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOU0wCWpbF8Ks7g7EwMzl8CZelbsnNtS6EUVGTCCun4=;
 b=BfI0R9sM69FQB2cES1uYnVm/t3ldUoV1d9HSpVgXJaJvjIM+yNbWBhz6gO78iz2toxoiV1
 4kl0N5qsW+Chi0r/nR+P9jNjYaJeElz9Y7d75nPlfKZpeNcAK205ZpY7lWgSETDL2IJKri
 2//bdRjq+4k8cex5/7X+Ylh5NqEp7do=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-X8iRNArFPJa5ArR-eIyVQg-1; Fri,
 14 Feb 2025 15:30:26 -0500
X-MC-Unique: X8iRNArFPJa5ArR-eIyVQg-1
X-Mimecast-MFC-AGG-ID: X8iRNArFPJa5ArR-eIyVQg_1739565025
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62E0019039C8
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:25 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49BD41800352; Fri, 14 Feb 2025 20:30:21 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 10/11] qapi: golang: Generate Command sync/async interfaces
Date: Fri, 14 Feb 2025 21:29:43 +0100
Message-ID: <20250214202944.69897-11-victortoso@redhat.com>
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

The Command interface is an abstraction that can be used by client and
server to the manager the Command types albeit with a different
implementation for sending and receiving.

The proposal for Sync is defined as Command while the Async is named
CommandAsync.

The implementation of client/server is not part of this series.

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/golang.py | 56 +++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index a14970fb1f..0b7dadff41 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -235,6 +235,20 @@
 }}
 """
 
+TEMPLATE_COMMAND = """
+// Synchronous interface of all available commands
+type Commands interface {{
+{methods}
+}}
+
+{callbacks}
+
+// Asynchronous interface of all available commands
+type CommandsAsync interface {{
+{async_methods}
+}}
+"""
+
 
 # Takes the documentation object of a specific type and returns
 # that type's documentation and its member's docs.
@@ -1009,13 +1023,37 @@ def generate_template_alternate(
     return "\n" + content
 
 
-def generate_template_command(commands: dict[str, Tuple[str, str]]) -> str:
+def generate_template_command(
+    commands: dict[str, Tuple[str, str, str]]
+) -> (str, str):
     content = ""
+    methods = ""
+    async_methods = ""
+    callbacks = ""
+
     for name in sorted(commands):
-        type_name, gocode = commands[name]
+        type_name, gocode, retarg = commands[name]
         content += gocode
 
-    return content
+        name = type_name[:-7]
+        cbname = f"{name}Complete"
+        syncret = "error"
+        cbarg = "error"
+        if retarg != "":
+            cbarg = f"{retarg}, error"
+            syncret = f"({retarg}, error)"
+        methods += f"\t{name}({type_name}) {syncret}\n"
+        async_methods += f"\t{name}({type_name}, {cbname}) error\n"
+        callbacks += f"type {cbname} func({cbarg})\n"
+
+    iface = string_to_code(
+        TEMPLATE_COMMAND.format(
+            methods=methods[:-1],
+            callbacks=callbacks[:-1],
+            async_methods=async_methods[:-1],
+        )
+    )
+    return content, iface
 
 
 def generate_template_event(events: dict[str, Tuple[str, str]]) -> (str, str):
@@ -1085,12 +1123,13 @@ def __init__(self, _: str):
             "union": ["encoding/json", "errors", "fmt"],
         }
         interfaces = {
+            "command": [],
             "event": ["time"],
         }
 
         self.schema: QAPISchema
         self.events: dict[str, Tuple[str, str]] = {}
-        self.commands: dict[str, Tuple[str, str]] = {}
+        self.commands: dict[str, Tuple[str, str, str]] = {}
         self.golang_package_name = "qapi"
         self.duplicate = list(gofiles)
         self.enums: dict[str, str] = {}
@@ -1151,7 +1190,9 @@ def visit_end(self) -> None:
         self.types["event"] += evtype
         self.interfaces["event"] += eviface
 
-        self.types["command"] += generate_template_command(self.commands)
+        cmdtype, cmdiface = generate_template_command(self.commands)
+        self.types["command"] += cmdtype
+        self.interfaces["command"] += cmdiface
 
     def visit_object_type(
         self,
@@ -1334,7 +1375,10 @@ def visit_command(
                 )
             )
 
-        self.commands[name] = (type_name, content)
+        retarg = ""
+        if ret_type:
+            retarg = qapi_schema_type_to_go_type(ret_type.name)
+        self.commands[name] = (type_name, content, retarg)
 
     def visit_event(
         self,
-- 
2.48.1


