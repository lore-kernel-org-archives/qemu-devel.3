Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31CFFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAYr-0006hg-EF; Wed, 29 Apr 2026 15:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYi-0006bv-TP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYg-0007ru-Do
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777490804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6KxGZvJ/nle8ZjgDAoRf5v3codJAXqzHMYcdxnKGaY=;
 b=W/d/OUz2Gk+38qgxAJwm2LrwnJsy8fnhjEJgwuMMi7x8wb5nMEyfsp/jw9FCuGnPIiC9mC
 e8kagJyoahU74JHBdN2OgPoDutHDsXccNH7ueWRxt+fADXMLOK6MhUCG4WdeopjQEqZ6vk
 H7knFpcrZWzrpU8ZyOlkA62PDrcBo9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-OsAr4w-AOcePxqkRthDz4Q-1; Wed,
 29 Apr 2026 15:26:41 -0400
X-MC-Unique: OsAr4w-AOcePxqkRthDz4Q-1
X-Mimecast-MFC-AGG-ID: OsAr4w-AOcePxqkRthDz4Q_1777490799
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74F38180034C; Wed, 29 Apr 2026 19:26:39 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 313251800446; Wed, 29 Apr 2026 19:26:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 05/13] qapi/docs: adjust stub member insertion algorithm
Date: Wed, 29 Apr 2026 15:26:03 -0400
Message-ID: <20260429192611.1581223-6-jsnow@redhat.com>
In-Reply-To: <20260429192611.1581223-1-jsnow@redhat.com>
References: <20260429192611.1581223-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A forthcoming patch removes the implicit PLAIN section that always
starts a QAPIDoc section list. Further future changes begin converting
"PLAIN" sections to "INTRO" sections. To accommodate this, the insertion
algorithm that places stub and dummy members must be adjusted to cope.

This algorithm can handle zero-or-more PLAIN *or* INTRO sections at the
beginning of a QAPIDoc object.

Since we have three places that need to insert stub members, take the
opportunity to unify and deduplicate this code.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 36 ++++++++---------
 scripts/qapi/parser.py | 90 +++++++++++++++++++++++++++---------------
 2 files changed, 75 insertions(+), 51 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 1f7c15b7075..70ab9cdc214 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -349,30 +349,32 @@ def _get_target(
                 )
 
     def visit_sections(self, ent: QAPISchemaDefinition) -> None:
+        # Generate a placeholder right after the member section(s) which
+        # will be used to generate documentation for "The members of..."
+        # pointers in the rendered document.
+        # This is a temporary hack until the inliner is merged.
+        if ent.doc:
+            ent.doc.append_member_stub(
+                QAPIDoc.ArgSection(
+                    ent.doc.info, QAPIDoc.Kind.MEMBER, "q_dummy"
+                )
+            )
+
         sections = ent.doc.all_sections if ent.doc else []
 
-        # Determine the index location at which we should generate
-        # documentation for "The members of ..." pointers. This should
-        # go at the end of the members section(s) if any. Note that
-        # index 0 is assumed to be a plain intro section, even if it is
-        # empty; and that a members section if present will always
-        # immediately follow the opening PLAIN section.
-        gen_index = 1
-        if len(sections) > 1:
-            while sections[gen_index].kind == QAPIDoc.Kind.MEMBER:
-                gen_index += 1
-                if gen_index >= len(sections):
-                    break
-
         # Add sections in source order:
-        for i, section in enumerate(sections):
+        for section in sections:
             section.text = self.reformat_arobase(section.text)
 
             if section.kind.name in ("PLAIN", "INTRO"):
                 self.visit_paragraph(section)
             elif section.kind == QAPIDoc.Kind.MEMBER:
                 assert isinstance(section, QAPIDoc.ArgSection)
-                self.visit_member(section)
+                if section.name == "q_dummy":
+                    # Generate "The members of ..." entries if necessary
+                    self._insert_member_pointer(ent)
+                else:
+                    self.visit_member(section)
             elif section.kind == QAPIDoc.Kind.FEATURE:
                 assert isinstance(section, QAPIDoc.ArgSection)
                 self.visit_feature(section)
@@ -386,10 +388,6 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
             else:
                 assert False
 
-            # Generate "The members of ..." entries if necessary:
-            if i == gen_index - 1:
-                self._insert_member_pointer(ent)
-
         self.ensure_blank_line()
 
     # Transmogrification core methods
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 97e7dacb0fd..b21796b3e80 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -816,6 +816,58 @@ def new_feature(self, info: QAPISourceInfo, name: str) -> None:
     def append_line(self, line: str) -> None:
         self.all_sections[-1].append_line(line)
 
+    def _insert_near_kind(
+        self,
+        kind: 'QAPIDoc.Kind',
+        new_sect: 'QAPIDoc.Section',
+        after: bool = False,
+    ) -> bool:
+        """Insert or append a new doc section at a specific point."""
+        for idx, sect in enumerate(reversed(self.all_sections)):
+            if sect.kind == kind:
+                pos = len(self.all_sections) - idx - 1
+                if after:
+                    pos += 1
+                self.all_sections.insert(pos, new_sect)
+                return True
+        return False
+
+    def _insert_after_intro(
+        self,
+        section: 'QAPIDoc.Section',
+    ) -> None:
+        """
+        Insert a section immediately after the intro section.
+
+        While we convert PLAIN sections to INTRO sections, all
+        contiguous INTRO/PLAIN sections at the start of a QAPIDoc
+        section list are treated as "the intro".
+
+        Once INTRO conversion is complete, this helper will no longer be
+        needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
+        be sufficient.
+        """
+        index = 0
+        for index, ref_section in enumerate(self.all_sections):
+            if ref_section.kind.name in ("PLAIN", "INTRO"):
+                continue
+            break
+        else:
+            index += 1
+
+        self.all_sections.insert(index, section)
+
+    def append_member_stub(self, stub: 'QAPIDoc.Section') -> None:
+
+        """
+        Append a stub section after any Member sections.
+        """
+        if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
+            return
+
+        # No MEMBER sections present. Insert after INTRO/PLAIN sections.
+        self._insert_after_intro(stub)
+
     def connect_member(self, member: 'QAPISchemaMember') -> None:
         if member.name not in self._args:
             assert member.info
@@ -825,20 +877,10 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                                    % (member.role, member.name))
             # Insert stub documentation section for missing member docs.
             # TODO: drop when undocumented members are outlawed
-
-            section = QAPIDoc.ArgSection(
+            stub_section = QAPIDoc.ArgSection(
                 self.info, QAPIDoc.Kind.MEMBER, member.name)
-            self._args[member.name] = section
-
-            # Determine where to insert stub doc - it should go at the
-            # end of the members section(s), if any. Note that index 0
-            # is assumed to be an untagged intro section, even if it is
-            # empty.
-            index = 1
-            if len(self.all_sections) > 1:
-                while self.all_sections[index].kind == QAPIDoc.Kind.MEMBER:
-                    index += 1
-            self.all_sections.insert(index, section)
+            self._args[member.name] = stub_section
+            self.append_member_stub(stub_section)
 
         self._args[member.name].connect(member)
 
@@ -851,27 +893,13 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
 
     def ensure_returns(self, info: QAPISourceInfo) -> None:
 
-        def _insert_near_kind(
-            kind: QAPIDoc.Kind,
-            new_sect: QAPIDoc.Section,
-            after: bool = False,
-        ) -> bool:
-            for idx, sect in enumerate(reversed(self.all_sections)):
-                if sect.kind == kind:
-                    pos = len(self.all_sections) - idx - 1
-                    if after:
-                        pos += 1
-                    self.all_sections.insert(pos, new_sect)
-                    return True
-            return False
-
         if any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
             return
 
         # Stub "Returns" section for undocumented returns value
         stub = QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
 
-        if any(_insert_near_kind(kind, stub, after) for kind, after in (
+        if any(self._insert_near_kind(kind, stub, after) for kind, after in (
                 # 1. If arguments, right after those.
                 (QAPIDoc.Kind.MEMBER, True),
                 # 2. Elif errors, right *before* those.
@@ -881,10 +909,8 @@ def _insert_near_kind(
         )):
             return
 
-        # Otherwise, it should go right after the intro. The intro
-        # is always the first section and is always present (even
-        # when empty), so we can insert directly at index=1 blindly.
-        self.all_sections.insert(1, stub)
+        # Otherwise, it should go right after the intro.
+        self._insert_after_intro(stub)
 
     def check_expr(self, expr: QAPIExpression) -> None:
         if 'command' in expr:
-- 
2.54.0


