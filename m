Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAB4CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcC0-0000lb-BX; Tue, 02 Jun 2026 23:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcBy-0000e3-7L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcBv-0002SU-Pm
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780456971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hD1Dsfeq3wbpu+XarOy5/xB10detZhBbaziffW8q5I=;
 b=dQROwjKcI30OwQSBG5mjrzJk+DBsH0LSz/Yh1GCbTTM9OR8xYBEUM0+uHqWIIXh34alFUB
 jK5KPon4EK77M1JVmYOqnLoQtnWiC/L0zr3NeRQQeDyJJ9oMxXvaxiVDKxDgM2yKnyJTby
 Sb+jIrnpTTy7m2GO2/oz72dSj791h/Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-NqggjbLmMyiLB_On5y6-qA-1; Tue,
 02 Jun 2026 23:22:47 -0400
X-MC-Unique: NqggjbLmMyiLB_On5y6-qA-1
X-Mimecast-MFC-AGG-ID: NqggjbLmMyiLB_On5y6-qA_1780456966
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C6C8180044D; Wed,  3 Jun 2026 03:22:46 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C227D3000203; Wed,  3 Jun 2026 03:22:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 09/16] qapi/docs: adjust stub member insertion algorithm
Date: Tue,  2 Jun 2026 23:21:54 -0400
Message-ID: <20260603032201.993015-10-jsnow@redhat.com>
In-Reply-To: <20260603032201.993015-1-jsnow@redhat.com>
References: <20260603032201.993015-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
"PLAIN" sections to "INTRO" sections. To accommodate this, the
insertion algorithm that places stub and dummy members must be
adjusted to cope with not only the finished state, but temporary
intermediate states while the series is merged.

This algorithm can handle zero-or-more PLAIN *or* INTRO sections at
the beginning of a QAPIDoc object, in contrast to the previous
algorithm which assumed and relied upon there being always one PLAIN
section at the beginning of every QAPIDoc section list.

In other words: (PLAIN | INTRO)* <EverythingElse>

This does not impact what the parser itself will actually produce. As
of this patch, the parser will still always generate QAPIDoc section
lists that start with precisely one PLAIN section (whether or not it
is empty), followed by the remaining sections. Those remaining
sections may or may not include additional PLAIN sections, but never
two such sections contiguously as the parser will always treat that
layout as one PLAIN section consisting of multiple paragraph(s).

In other other words: This insertion algorithm is more lenient than
the parser, but this is on purpose for flexibility mid-stream as we
convert QAPI to using explicit introductory sections. The allowed
order of sections will eventually become strictly enforced in the
parser, which will in turn allow dramatic simplifications to the
insertion algorithm. This only exists as transitory code until we are
able to enforce that order.

Fear not: the intermediate rest output before and after this patch
are byte identical, so failing all else, we at least know it doesn't
make anything worse.

Lastly, because we have three places in the code that need to insert
stub/dummy sections, we take the opportunity to consolidate this code
to handle all three cases with one function. This winds up
necessitating the qapidoc.py generator actually modify the section
list to insert a "dummy" member that acts as a placeholder for "The
members of ..." text. While it looks like a code smell to modify the
caller's argument, it is ultimately safe because the QAPI Schema
object is re-parsed and re-constructed in memory for each individual
process that needs to operate on it. In other words, the Sphinx
document generator already does have "its own copy" of the section
lists, so it is "safe" to modify here without regards to other
consumers of the QAPIDoc objects. It only *looks* like it smells
bad. Ultimately, this code will also be removed once the inliner is
merged, so it is only a temporary aesthetic issue regardless.

That's my story and I'm sticking to it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 42 ++++++++++++++++--------------
 scripts/qapi/parser.py | 58 +++++++++++++++++++++++++++++-------------
 2 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 1f7c15b7075..16ad15fe94f 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -349,30 +349,38 @@ def _get_target(
                 )
 
     def visit_sections(self, ent: QAPISchemaDefinition) -> None:
+        # Generate a placeholder right after the member section(s) which
+        # may be used to generate documentation for "The members of..."
+        # pointers in the rendered document.
+        #
+        # This is a temporary hack until the inliner is merged. Note
+        # that although we modify the caller's section list, the
+        # Sphinx document generator has its own copy of the parsed
+        # schema in memory, so this action does not interfere with
+        # other users of the QAPISchema or QAPIDoc objects outside of
+        # the document generator. Fishy, but not harmful.
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
@@ -386,10 +394,6 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
             else:
                 assert False
 
-            # Generate "The members of ..." entries if necessary:
-            if i == gen_index - 1:
-                self._insert_member_pointer(ent)
-
         self.ensure_blank_line()
 
     # Transmogrification core methods
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 261f8ba9f8b..406edf6aa9d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -832,6 +832,42 @@ def _insert_near_kind(
                 return True
         return False
 
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
@@ -841,20 +877,10 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
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
 
@@ -882,10 +908,8 @@ def ensure_returns(self, info: QAPISourceInfo) -> None:
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


