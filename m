Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0863C0219C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfodG-0003j9-Jr; Wed, 05 Feb 2025 18:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfodA-00032R-AE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfod7-0006Zk-2S
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgAoyiNttGPvLvdaSWO3C5jznH7saF5lZMYoMJ8yOy4=;
 b=UNdsoSIRAxUKV2SWr3k604JOLUHKIAQfGPr8MZpZXo+71UAxxwAmU6pWhVEkNze8FOB5LV
 Oe9PMTHXGDsuOfC+CSIzKFb0boLBXUBgh4s9ECtMqzApgCERw88jnRwynwCmQ+GCP98n+M
 VZYm7thiNphM6h9S2ncNpBgzIqQB5Hw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-ZOjw777cMLWMlDqXAr5Epg-1; Wed,
 05 Feb 2025 18:16:18 -0500
X-MC-Unique: ZOjw777cMLWMlDqXAr5Epg-1
X-Mimecast-MFC-AGG-ID: ZOjw777cMLWMlDqXAr5Epg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E40D1800268; Wed,  5 Feb 2025 23:16:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 446541800570; Wed,  5 Feb 2025 23:16:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 39/42] qapi/schema: add doc_visible property to
 QAPISchemaDefinition
Date: Wed,  5 Feb 2025 18:12:05 -0500
Message-ID: <20250205231208.1480762-40-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This patch adds a boolean flag to mark definitions as "visible" in the
end-user HTML docs. The intent is that definitions that are not marked
as visible will not be rendered.

What gets marked visible?

The short version: all commands and events are inherently visible. All
other definitions are visible if and only if they are the target of a
cross-reference in the generated output.

The long version:

- All commands:
  - All arg_type members, excluding arg_type itself
    (because it's inlined)
  - All ret_type members, *including* ret_type itself
    (because we cross-reference the return type)

- All events:
  - All arg_type members, excluding arg_type itself
    (because it's inlined)

- For any object marked visible by the above;
  - All members (which includes inherited members)
  - All branch objects, excluding the branch object itself
    (because the branches are inlined)

- For any array marked visible by the above;
  - The array itself, and
  - The contained element_type

- For any alternate marked visible by the above;
  - The alternate itself, and
  - All of its branch types.
    (because we don't currently inline anything for alternates.)

All other definitions are not doc_visible; those exclusions are:

- Any definition not recursively referenced by any command or event;
  i.e. definitions used internally by QEMU but not actually used by the
  QMP protocol.

- Any definition used only as an arg_type for events or
  commands; because the doc generator inlines arguments, there is no
  need to generate documentation for the arguments/members by
  themselves.

- Any definition used only as a base_type for objects. The new
  doc generator will inline inheritance, so there is no need to generate
  standalone documentation for factored/common objects.

- Any definition used only as a branch type for a union. The new doc
  generator also inlines branch members as it does for local and
  inherited members, so there's no need to document each branch as a
  standalone entity.

Note that if a type is used both in an "inlined" context and a
"referenced" context, documentation *will* be generated for that
type; e.g. a struct type used both as a base_type *and* as a member
argument.

This does not necessarily match the data revealed by the runtime
introspection feature: in the generated documentation case, we want
anything that we are cross-referencing in generated documentation to be
available to target with cross-reference syntax.

Some built-in types may be marked visible with this approach, but if
they do not have a documentation block, they'll be skipped by the
generator anyway. This includes array types and built-in primitives
which do not get their own documentation objects.

i.e., for documentation to be generated for a given QAPISchemaDefinition
in the new generator, it must have non-empty documentation AND be
doc_visible. This differs from the current qapidoc generator which only
requires non-empty documentation. This means some items marked
doc_visible *still* will not be rendered because they lack documentation
to render.

This information is not yet used by the current generator, which
continues to render documentation exactly as it has. This information
will be used by the new qapidoc (the "transmogrifier") in the next
commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 4c55f7640b6..32c9a8f4cd2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -131,6 +131,7 @@ def __init__(
         self.doc = doc
         self._ifcond = ifcond or QAPISchemaIfCond()
         self.features = features or []
+        self.doc_visible = False
 
     def __repr__(self) -> str:
         return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
@@ -146,6 +147,10 @@ def check(self, schema: QAPISchema) -> None:
         for f in self.features:
             f.check_clash(self.info, seen)
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        if mark_self:
+            self.doc_visible = True
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -483,6 +488,10 @@ def check(self, schema: QAPISchema) -> None:
             self.info.defn_meta if self.info else None)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        self.element_type.mark_visible()
+
     def set_module(self, schema: QAPISchema) -> None:
         self._set_module(schema, self.element_type.info)
 
@@ -607,6 +616,17 @@ def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         for m in self.local_members:
             m.connect_doc(doc)
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        # Mark this object and its members as visible in the user-facing docs.
+        if self.doc_visible:
+            return
+
+        super().mark_visible(mark_self)
+        for m in self.members:
+            m.type.mark_visible()
+        for var in self.branches or []:
+            var.type.mark_visible(False)
+
     def is_implicit(self) -> bool:
         # See QAPISchema._make_implicit_object_type(), as well as
         # _def_predefineds()
@@ -698,6 +718,11 @@ def check(self, schema: QAPISchema) -> None:
                         % (v.describe(self.info), types_seen[qt]))
                 types_seen[qt] = v.name
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        for var in self.alternatives:
+            var.type.mark_visible()
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -1056,6 +1081,13 @@ def check(self, schema: QAPISchema) -> None:
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        if self.arg_type:
+            self.arg_type.mark_visible(False)
+        if self.ret_type:
+            self.ret_type.mark_visible()
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -1112,6 +1144,11 @@ def check(self, schema: QAPISchema) -> None:
                     self.info,
                     "conditional event arguments require 'boxed': true")
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        if self.arg_type:
+            self.arg_type.mark_visible(False)
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -1488,6 +1525,9 @@ def check(self) -> None:
             ent.set_module(self)
         for doc in self.docs:
             doc.check()
+        for ent in self._entity_list:
+            if isinstance(ent, (QAPISchemaCommand, QAPISchemaEvent)):
+                ent.mark_visible()
 
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_begin(self)
-- 
2.48.1


