Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E341C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2LX-0004w4-3p; Fri, 14 Feb 2025 15:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KN-00048g-Bd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KL-00021Q-M3
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7J/rt19u5i7ccmeMEi0N5tDk0udDVxbxjxL2xbH3Lg=;
 b=Uz3WJI5AG7qhqSxMD9TDHH1kwtHBdt7Sbxmif1atok+NnG1P8Cz4+rtC712WA9D5pUX1oN
 0vnxMe+UEBeVR/WM0EIvk2kaB3w7afxLa79nTOi97LHBQvl1xoqaFwCHhjzVi6wDxL3fZO
 XL0JvhXjU5TkU3N8AcK0gejx24+c1K4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-Gbdm0egUOEmEN3C0IURRuQ-1; Fri,
 14 Feb 2025 15:30:19 -0500
X-MC-Unique: Gbdm0egUOEmEN3C0IURRuQ-1
X-Mimecast-MFC-AGG-ID: Gbdm0egUOEmEN3C0IURRuQ_1739565018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84EAF19373DC
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:18 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DA561800940; Fri, 14 Feb 2025 20:30:15 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 08/11] qapi: golang: Generate Event interface
Date: Fri, 14 Feb 2025 21:29:41 +0100
Message-ID: <20250214202944.69897-9-victortoso@redhat.com>
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

The Event interface is an abstraction that can be used by client and
server to the manager the Event types albeit with a different
implementation for sending and receiving.

The implementation of client/server is not part of this series.

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/golang.py | 38 ++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index 63d55ca950..b9a2c47137 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -229,6 +229,12 @@
 }}
 """
 
+TEMPLATE_EVENT = """
+type Event interface {{
+{methods}
+}}
+"""
+
 
 # Takes the documentation object of a specific type and returns
 # that type's documentation and its member's docs.
@@ -1003,13 +1009,16 @@ def generate_template_alternate(
     return "\n" + content
 
 
-def generate_template_event(events: dict[str, Tuple[str, str]]) -> str:
+def generate_template_event(events: dict[str, Tuple[str, str]]) -> (str, str):
     content = ""
+    methods = ""
     for name in sorted(events):
         type_name, gocode = events[name]
+        methods += f"\t{type_name}({type_name}, time.Time) error\n"
         content += gocode
 
-    return content
+    iface = string_to_code(TEMPLATE_EVENT.format(methods=methods[:-1]))
+    return content, iface
 
 
 def generate_content_from_dict(data: dict[str, str]) -> str:
@@ -1065,6 +1074,9 @@ def __init__(self, _: str):
             "struct": ["encoding/json"],
             "union": ["encoding/json", "errors", "fmt"],
         }
+        interfaces = {
+            "event": ["time"],
+        }
 
         self.schema: QAPISchema
         self.events: dict[str, Tuple[str, str]] = {}
@@ -1080,6 +1092,9 @@ def __init__(self, _: str):
         self.types = dict.fromkeys(types, "")
         self.types_import = types
 
+        self.interfaces = dict.fromkeys(interfaces, "")
+        self.interface_imports = interfaces
+
     def visit_begin(self, schema: QAPISchema) -> None:
         self.schema = schema
 
@@ -1100,6 +1115,12 @@ def visit_begin(self, schema: QAPISchema) -> None:
                 continue
             self.docmap[doc.symbol] = doc
 
+        for qapitype, imports in self.interface_imports.items():
+            self.interfaces[qapitype] = TEMPLATE_GENERATED_HEADER[1:].format(
+                package_name=self.golang_package_name
+            )
+            self.interfaces[qapitype] += generate_template_imports(imports)
+
         for qapitype, imports in self.types_import.items():
             self.types[qapitype] = TEMPLATE_GENERATED_HEADER[1:].format(
                 package_name=self.golang_package_name
@@ -1114,7 +1135,10 @@ def visit_end(self) -> None:
         self.types["alternate"] += generate_content_from_dict(self.alternates)
         self.types["struct"] += generate_content_from_dict(self.structs)
         self.types["union"] += generate_content_from_dict(self.unions)
-        self.types["event"] += generate_template_event(self.events)
+
+        evtype, eviface = generate_template_event(self.events)
+        self.types["event"] += evtype
+        self.interfaces["event"] += eviface
 
     def visit_object_type(
         self,
@@ -1318,3 +1342,11 @@ def write(self, outdir: str) -> None:
 
             with open(pathname, "w", encoding="utf8") as outfile:
                 outfile.write(content)
+
+        # Interfaces to be generated
+        for qapitype, content in self.interfaces.items():
+            gofile = f"gen_iface_{qapitype}.go"
+            pathname = os.path.join(targetpath, gofile)
+
+            with open(pathname, "w", encoding="utf8") as outfile:
+                outfile.write(content)
-- 
2.48.1


