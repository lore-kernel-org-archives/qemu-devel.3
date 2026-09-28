Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3279CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJzW-0008Nt-SA; Mon, 28 Sep 2026 18:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJzS-0008Dr-Nj
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJzQ-0006Ic-Gh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YqI6aRChkBWarji7FCb1tybf+1n8Ov8rZHJjZGAUqs=;
 b=DIIpTxDv5MdRIn27C1ZXAFLRwazTPwFvE1rP7ikeNxmocNp71PGsptE+lAeVG7UU2TRS5x
 9c0ub2jrYE32LBFlPKMHAZKVVRSOh3hErz9cawoNxR/oEokrr+nL96agjB2KY8HisXo8/Z
 W6/T1Ad7bH6c1NTeQLyp49WCXW1A3dg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-UR25jgwEPAe8PGzhf14i9Q-1; Mon,
 28 Sep 2026 18:38:24 -0400
X-MC-Unique: UR25jgwEPAe8PGzhf14i9Q-1
X-Mimecast-MFC-AGG-ID: UR25jgwEPAe8PGzhf14i9Q_1790635102
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A4201800BE4; Mon, 28 Sep 2026 22:38:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DC1C19560AB; Mon, 28 Sep 2026 22:38:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, Alex Williamson <alex@shazbot.org>,
 Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 11/14] qapi/parser: privatize "all_sections" field as
 "_sections"
Date: Mon, 28 Sep 2026 18:36:54 -0400
Message-ID: <20260928223657.2303684-12-jsnow@redhat.com>
In-Reply-To: <20260928223657.2303684-1-jsnow@redhat.com>
References: <20260928223657.2303684-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

In preparation for switching QAPIDoc to a more complex data structure
for keeping track of sections, convert the "all_sections" property to
a private property.

Rename it "_sections" to emphasize that there is not* some alternative
property that is somehow not all sections. This is what you get and
you're going to love it.

Implement the len() and iter() features for QAPIDoc as a replacement
for direct, public access to the all_sections property.

(*OK, currently there are some, but spoilers, they're going away in
the next commits.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py         |  7 ++++---
 scripts/qapi/parser.py         | 27 +++++++++++++++++----------
 tests/qapi-schema/test-qapi.py |  2 +-
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index ae57056a393..fd666be131f 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -377,7 +377,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
                 )
             )
 
-        sections = ent.doc.all_sections if ent.doc else []
+        sections = list(ent.doc) if ent.doc else []
 
         # Add sections in source order:
         for section in sections:
@@ -416,8 +416,9 @@ def visit_module(self, path: str) -> None:
         self.ensure_blank_line()
 
     def visit_freeform(self, doc: QAPIDoc) -> None:
-        assert len(doc.all_sections) == 1, doc.all_sections
-        body = doc.all_sections[0]
+        sections = list(doc)
+        assert len(sections) == 1, sections
+        body = sections[0]
         self.add_lines(self.reformat_arobase(body.text), doc.info)
         self.ensure_blank_line()
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 0dca1acba4c..bdd0f1ec3ff 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -19,6 +19,7 @@
     TYPE_CHECKING,
     Any,
     Dict,
+    Iterator,
     List,
     Mapping,
     Match,
@@ -758,7 +759,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # definition doc's symbol, None for free-form doc
         self.symbol: Optional[str] = symbol
         # the sections in textual order
-        self.all_sections: List[QAPIDoc.Section] = []
+        self._sections: List[QAPIDoc.Section] = []
         # dicts mapping parameter/feature names to their description
         self._args: Dict[str, QAPIDoc.ArgSection] = {}
         self._features: Dict[str, QAPIDoc.ArgSection] = {}
@@ -797,10 +798,16 @@ def _append(self, section: 'QAPIDoc.Section') -> None:
                 raise QAPISemError(
                     section.info, "duplicated '%s' section" % section.kind)
             self.since = section
-        self.all_sections.append(section)
+        self._sections.append(section)
+
+    def __iter__(self) -> Iterator['QAPIDoc.Section']:
+        return iter(self._sections)
+
+    def __len__(self) -> int:
+        return len(self._sections)
 
     def end(self) -> None:
-        for section in self.all_sections:
+        for section in self:
             section.text = section.text.strip('\n')
             if (
                     section.kind not in (
@@ -813,9 +820,9 @@ def end(self) -> None:
     def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
         kind = QAPIDoc.Kind.DETAILS
 
-        if self.all_sections and self.all_sections[-1].kind == kind:
+        if self._sections and self._sections[-1].kind == kind:
             # extend current section
-            section = self.all_sections[-1]
+            section = self._sections[-1]
             if not section.text:
                 # Section is empty so far; update info to start *here*.
                 section.info = info
@@ -856,7 +863,7 @@ def new_feature(self, info: QAPISourceInfo, name: str) -> None:
         self._new_description(info, name, QAPIDoc.Kind.FEATURE, self._features)
 
     def append_line(self, line: str) -> None:
-        self.all_sections[-1].append_line(line)
+        self._sections[-1].append_line(line)
 
     def _insert_near_kind(
         self,
@@ -865,12 +872,12 @@ def _insert_near_kind(
         after: bool = False,
     ) -> bool:
         """Insert or append a new doc section at a specific point."""
-        for idx, sect in enumerate(reversed(self.all_sections)):
+        for idx, sect in enumerate(reversed(list(self))):
             if sect.kind == kind:
-                pos = len(self.all_sections) - idx - 1
+                pos = len(self) - idx - 1
                 if after:
                     pos += 1
-                self.all_sections.insert(pos, new_sect)
+                self._sections.insert(pos, new_sect)
                 return True
         return False
 
@@ -915,7 +922,7 @@ def ensure_returns(self, info: QAPISourceInfo) -> None:
         # TODO: Take advantage of the new strict section ordering and
         # simplify this algorithm.
 
-        if any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
+        if self._returns:
             return
 
         # Stub "Returns" section for undocumented returns value
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 5beb96e894f..d5b4ac3a682 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -117,7 +117,7 @@ def test_frontend(fname):
             print('doc symbol=%s' % doc.symbol)
         else:
             print('doc freeform')
-        for section in doc.all_sections:
+        for section in doc:
             if isinstance(section, QAPIDoc.ArgSection):
                 print('    %s=%s' % (section.kind, section.name))
             else:
-- 
2.55.0


