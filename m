Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0FBC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKqo-0007Sr-RS; Mon, 14 Jul 2025 11:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUa-0000IX-Rv
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUU-0003bc-4O
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqyqnGFyQnvq7sX2524kZSsjnQQSwOQe+Q3tvKbYFEQ=;
 b=IolPY4nNTKY5Nr2PKgKKAHdEY9QXCpToSPSFUmdp8r0dtWNrq4P1AVNOksnfmkcMgrpB+f
 47/5DGLDy6yD8+xdQI94O5kB2cLUyrO7MEz7nBEuzotY/IDBjIgzppWp1OK9hjkFS9tqOi
 eZ1VBijLjw1RPo0tIBNgt3bmEfrsNP0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-wPHNHk-zPUqH-Q9tTDojFw-1; Mon,
 14 Jul 2025 09:45:06 -0400
X-MC-Unique: wPHNHk-zPUqH-Q9tTDojFw-1
X-Mimecast-MFC-AGG-ID: wPHNHk-zPUqH-Q9tTDojFw_1752500705
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE7D21809C8A
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 356381800264
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB23A21E6779; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 09/32] qapi: Fix undocumented return values by generating
 something
Date: Mon, 14 Jul 2025 15:44:35 +0200
Message-ID: <20250714134458.2991097-10-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Generated command documentation lacks information on return value in
several cases, e.g. query-tpm.

The obvious fix would be to require a Returns: section when a command
returns something.

However, note that many existing Returns: sections are pretty useless:
the description is basically the return type, which then gets rendered
like "Return: <Type> – <basically the return type>".  This suggests
that a description is often not really necessary, and requiring one
isn't useful.

Instead, generate the obvious minimal thing when Returns: is absent:
"Return: <Type>".

This auto-generated Return documentation is placed is as follows:

1. If we have arguments, return goes right after them.
2. Else if we have errors, return goes right before them.
3. Else if we have features, return goes right before them.
4. Else return goes right after the intro

To facilitate this algorithm, a "TODO:" hack line is used to separate
the intro from the remainder of the documentation block in cases where
there are no other sections to separate the intro from e.g. examples and
additional detail meant to appear below the key sections of interest.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711051045.51110-3-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[_insert_near_kind() code replaced by something simpler, commit
message amended to explain why we're doing this]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 14 ++++++++------
 qapi/machine.json      |  2 ++
 scripts/qapi/parser.py | 37 +++++++++++++++++++++++++++++++++++++
 scripts/qapi/schema.py |  3 +++
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index b794cde697..c2f09bac16 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -258,16 +258,18 @@ def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
     def visit_returns(self, section: QAPIDoc.Section) -> None:
         assert isinstance(self.entity, QAPISchemaCommand)
         rtype = self.entity.ret_type
-        # q_empty can produce None, but we won't be documenting anything
-        # without an explicit return statement in the doc block, and we
-        # should not have any such explicit statements when there is no
-        # return value.
+        # return statements will not be present (and won't be
+        # autogenerated) for any command that doesn't return
+        # *something*, so rtype will always be defined here.
         assert rtype
 
         typ = self.format_type(rtype)
         assert typ
-        assert section.text
-        self.add_field("return", typ, section.text, section.info)
+
+        if section.text:
+            self.add_field("return", typ, section.text, section.info)
+        else:
+            self.add_lines(f":return-nodesc: {typ}", section.info)
 
     def visit_errors(self, section: QAPIDoc.Section) -> None:
         # If the section text does not start with a space, it means text
diff --git a/qapi/machine.json b/qapi/machine.json
index af00a20b1f..2d6a137f21 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1303,6 +1303,8 @@
 # Return the amount of initially allocated and present hotpluggable
 # (if enabled) memory in bytes.
 #
+# TODO: This line is a hack to separate the example from the body
+#
 # .. qmp-example::
 #
 #     -> { "execute": "query-memory-size-summary" }
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index d43a123cd7..2529edf81a 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -804,6 +804,43 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
                                % feature.name)
         self.features[feature.name].connect(feature)
 
+    def ensure_returns(self, info: QAPISourceInfo) -> None:
+
+        def _insert_near_kind(
+            kind: QAPIDoc.Kind,
+            new_sect: QAPIDoc.Section,
+            after: bool = False,
+        ) -> bool:
+            for idx, sect in enumerate(reversed(self.all_sections)):
+                if sect.kind == kind:
+                    pos = len(self.all_sections) - idx - 1
+                    if after:
+                        pos += 1
+                    self.all_sections.insert(pos, new_sect)
+                    return True
+            return False
+
+        if any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
+            return
+
+        # Stub "Returns" section for undocumented returns value
+        stub = QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
+
+        if any(_insert_near_kind(kind, stub, after) for kind, after in (
+                # 1. If arguments, right after those.
+                (QAPIDoc.Kind.MEMBER, True),
+                # 2. Elif errors, right *before* those.
+                (QAPIDoc.Kind.ERRORS, False),
+                # 3. Elif features, right *before* those.
+                (QAPIDoc.Kind.FEATURE, False),
+        )):
+            return
+
+        # Otherwise, it should go right after the intro. The intro
+        # is always the first section and is always present (even
+        # when empty), so we can insert directly at index=1 blindly.
+        self.all_sections.insert(1, stub)
+
     def check_expr(self, expr: QAPIExpression) -> None:
         if 'command' in expr:
             if self.returns and 'returns' not in expr:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cbe3b5aa91..3abddea352 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1062,6 +1062,9 @@ def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
 
+            if self.ret_type and self.info:
+                doc.ensure_returns(self.info)
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_command(
-- 
2.49.0


