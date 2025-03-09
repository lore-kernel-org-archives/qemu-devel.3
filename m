Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2B0C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCB7-0000c5-VN; Sun, 09 Mar 2025 04:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCB0-0008TF-NU
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAy-0002f9-O1
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0U6vbKgStPdz9Sed/bjse/hydvoS43rfuqUfVd/ad8=;
 b=Yv/2/Ye9SENMx8rd2C2ITYInNopycsFQvMbnWWP04tNChrj+hK2LMB17sTXPvKv5iCpQZA
 Mq+vp9AgQm4gYEu4OfC4NWDDbjnduFdDSKjqTk3jHjoD/YYfuoDWV+Sg8/nqfHTxJSox7x
 bwiXhYloapoVHP1PYvD9CnCck/8x0qg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-bUtpYqPbPnu8_Ato5xlRXw-1; Sun,
 09 Mar 2025 04:38:20 -0400
X-MC-Unique: bUtpYqPbPnu8_Ato5xlRXw-1
X-Mimecast-MFC-AGG-ID: bUtpYqPbPnu8_Ato5xlRXw_1741509498
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0B2D1956083; Sun,  9 Mar 2025 08:38:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC65219560AB; Sun,  9 Mar 2025 08:38:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 57/62] docs/qapidoc: Add "the members of" pointers
Date: Sun,  9 Mar 2025 04:35:44 -0400
Message-ID: <20250309083550.5155-58-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Add "the members of ..." pointers to Members and Arguments lists where
appropriate, with clickable cross-references - so it's a slight
improvement over the old system :)

This patch is meant to be a temporary solution until we can review and
merge the inliner.

The implementation of this patch is a little bit of a hack: Sphinx is
not designed to allow you to mix fields of different "type"; i.e. mixing
member descriptions and free-form text under the same heading. To
accomplish this with a minimum of hackery, we technically document a
"dummy field" and then just strip off the documentation for that dummy
field in a post-processing step. We use the "q_dummy" variable for this
purpose, then strip it back out before final processing. If this
processing step should fail, you'll see warnings for a bad
cross-reference. (So if you don't see any, it must be working!)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 22 +++++++++++++--
 docs/sphinx/qapidoc.py     | 58 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index ca5e878c8ad..c2c98a80994 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -428,6 +428,24 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
         return ""
 
 
+class SpecialTypedField(CompatTypedField):
+    def make_field(self, *args: Any, **kwargs: Any) -> nodes.field:
+        ret = super().make_field(*args, **kwargs)
+
+        # Look for the characteristic " -- " text node that Sphinx
+        # inserts for each TypedField entry ...
+        for node in ret.traverse(lambda n: str(n) == " -- "):
+            par = node.parent
+            if par.children[0].astext() != "q_dummy":
+                continue
+
+            # If the first node's text is q_dummy, this is a dummy
+            # field we want to strip down to just its contents.
+            del par.children[:-1]
+
+        return ret
+
+
 class QAPICommand(QAPIObject):
     """Description of a QAPI Command."""
 
@@ -435,7 +453,7 @@ class QAPICommand(QAPIObject):
     doc_field_types.extend(
         [
             # :arg TypeName ArgName: descr
-            CompatTypedField(
+            SpecialTypedField(
                 "argument",
                 label=_("Arguments"),
                 names=("arg",),
@@ -503,7 +521,7 @@ class QAPIObjectWithMembers(QAPIObject):
     doc_field_types.extend(
         [
             # :member type name: descr
-            CompatTypedField(
+            SpecialTypedField(
                 "member",
                 label=_("Members"),
                 names=("memb",),
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index e8719fac4c1..96ac9f8620e 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -47,8 +47,10 @@
     QAPISchemaCommand,
     QAPISchemaDefinition,
     QAPISchemaEnumMember,
+    QAPISchemaEvent,
     QAPISchemaFeature,
     QAPISchemaMember,
+    QAPISchemaObjectType,
     QAPISchemaObjectTypeMember,
     QAPISchemaType,
     QAPISchemaVisitor,
@@ -300,11 +302,61 @@ def preamble(self, ent: QAPISchemaDefinition) -> None:
 
         self.ensure_blank_line()
 
+    def _insert_member_pointer(self, ent: QAPISchemaDefinition) -> None:
+
+        def _get_target(
+            ent: QAPISchemaDefinition,
+        ) -> Optional[QAPISchemaDefinition]:
+            if isinstance(ent, (QAPISchemaCommand, QAPISchemaEvent)):
+                return ent.arg_type
+            if isinstance(ent, QAPISchemaObjectType):
+                return ent.base
+            return None
+
+        target = _get_target(ent)
+        if target is not None and not target.is_implicit():
+            assert ent.info
+            self.add_field(
+                self.member_field_type,
+                "q_dummy",
+                f"The members of :qapi:type:`{target.name}`.",
+                ent.info,
+                "q_dummy",
+            )
+
+        if isinstance(ent, QAPISchemaObjectType) and ent.branches is not None:
+            for variant in ent.branches.variants:
+                if variant.type.name == "q_empty":
+                    continue
+                assert ent.info
+                self.add_field(
+                    self.member_field_type,
+                    "q_dummy",
+                    f" When ``{ent.branches.tag_member.name}`` is "
+                    f"``{variant.name}``: "
+                    f"The members of :qapi:type:`{variant.type.name}`.",
+                    ent.info,
+                    "q_dummy",
+                )
+
     def visit_sections(self, ent: QAPISchemaDefinition) -> None:
         sections = ent.doc.all_sections if ent.doc else []
 
+        # Determine the index location at which we should generate
+        # documentation for "The members of ..." pointers. This should
+        # go at the end of the members section(s) if any. Note that
+        # index 0 is assumed to be a plain intro section, even if it is
+        # empty; and that a members section if present will always
+        # immediately follow the opening PLAIN section.
+        gen_index = 1
+        if len(sections) > 1:
+            while sections[gen_index].kind == QAPIDoc.Kind.MEMBER:
+                gen_index += 1
+                if gen_index >= len(sections):
+                    break
+
         # Add sections *in the order they are documented*:
-        for section in sections:
+        for i, section in enumerate(sections):
             # @var is translated to ``var``:
             section.text = re.sub(r"@([\w-]+)", r"``\1``", section.text)
 
@@ -326,6 +378,10 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
             else:
                 assert False
 
+            # Generate "The members of ..." entries if necessary:
+            if i == gen_index - 1:
+                self._insert_member_pointer(ent)
+
         self.ensure_blank_line()
 
     # Transmogrification core methods
-- 
2.48.1


