Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC0EC02199
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfocH-0000wQ-8c; Wed, 05 Feb 2025 18:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfocB-0000NB-Sz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoc9-00063H-Nm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pQpG+9Zm4aFqSNny8uokAA9FhDNi6AirSzCVGIFntA=;
 b=De1VAP9IAzAueLk3Pdbj91vtY08MSwDPor6O65PG7LlCx5SWBf9v0/DQAxjZipPm0rdwUe
 +JOx+OJYFjKOiw9jhAF92yxC/gAcUy6QgQvkbaQy+1Ko9Zxa+S5bicKJWFS1qezIgAgVKU
 E6Pa8t7wr7GPXPsNuJOl1MaS6Bs6ZaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-yqUHXDsMM-eTOq7JYAnupQ-1; Wed,
 05 Feb 2025 18:15:21 -0500
X-MC-Unique: yqUHXDsMM-eTOq7JYAnupQ-1
X-Mimecast-MFC-AGG-ID: yqUHXDsMM-eTOq7JYAnupQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47E141956086; Wed,  5 Feb 2025 23:15:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 857CF1800570; Wed,  5 Feb 2025 23:15:13 +0000 (UTC)
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
Subject: [PATCH 30/42] docs/qapidoc: add minimalistic inliner
Date: Wed,  5 Feb 2025 18:11:56 -0500
Message-ID: <20250205231208.1480762-31-jsnow@redhat.com>
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

Add a minimalistic inliner that only gets the basics - leaving branch
inlining for a future patch.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 174 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 154ebc1b4cd..538c26e812d 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -25,13 +25,15 @@
 https://www.sphinx-doc.org/en/master/development/index.html
 """
 
+from collections import defaultdict
 from contextlib import contextmanager
+import enum
 import os
 from pathlib import Path
 import re
 import sys
 import textwrap
-from typing import List, Optional
+from typing import Dict, List, Optional
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
@@ -45,8 +47,10 @@
     QAPISchemaCommand,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
+    QAPISchemaEvent,
     QAPISchemaFeature,
     QAPISchemaMember,
+    QAPISchemaObjectType,
     QAPISchemaObjectTypeMember,
 )
 from qapi.source import QAPISourceInfo
@@ -77,6 +81,172 @@ def dedent(text: str) -> str:
     return lines[0] + textwrap.dedent("".join(lines[1:]))
 
 
+class DocRegion(enum.Enum):
+    # The inliner introduces the concept of doc Regions, which are
+    # groupings of zero or more Sections. These regions are used to know
+    # how to combine two lists of Sections.
+    INTRO = 0
+    MEMBER = 1
+    OTHER = 2
+    FEATURE = 3
+    DETAIL = 4
+
+    @staticmethod
+    def categorize(section: QAPIDoc.Section) -> "Optional[DocRegion]":
+        return MAPPING[section.kind]
+
+
+MAPPING = {
+    QAPIDoc.Kind.INTRO: DocRegion.INTRO,
+    QAPIDoc.Kind.MEMBER: DocRegion.MEMBER,
+    QAPIDoc.Kind.FEATURE: DocRegion.FEATURE,
+    QAPIDoc.Kind.RETURNS: DocRegion.OTHER,
+    QAPIDoc.Kind.ERRORS: DocRegion.OTHER,
+    QAPIDoc.Kind.SINCE: None,
+    QAPIDoc.Kind.TODO: None,
+    QAPIDoc.Kind.DETAIL: DocRegion.DETAIL,
+}
+
+
+class InlinerSections:
+
+    def __init__(self, sections):
+        self._sections: List[QAPIDoc.Section] = list(sections)
+        self.partitions: Dict[DocRegion, List[QAPIDoc.Section]] = defaultdict(
+            list
+        )
+        self._modified = False
+
+        self._partition()
+
+    def _partition(self):
+        for section in self._sections:
+            # suppress empty text sections for the purpose of, later,
+            # being able to determine if a collection of doc sections
+            # "has an intro" or "has a details section" or not, which is
+            # helpful later on for some assertions about the inliner.
+            if section.kind in (QAPIDoc.Kind.INTRO, QAPIDoc.Kind.DETAIL):
+                if not section.text:
+                    continue
+
+            region = DocRegion.categorize(section)
+            if region is None:
+                continue
+
+            self.partitions[region].append(section)
+
+    def absorb(self, other: "InlinerSections"):
+        for category, oval in other.partitions.items():
+            val = self.partitions[category]
+            if category == DocRegion.INTRO:
+                # The intro region is not inlined, it is dropped.
+                continue
+
+            # Everything else is prepended.
+            self.partitions[category] = oval + val
+            if oval:
+                self._modified = True
+
+    def __iter__(self):
+        return iter(self._flatten())
+
+    def _flatten(self):
+        # Serialize back into a normal list.
+
+        # If nothing has changed, we don't need to do anything.
+        if not self._modified:
+            return tuple(self._sections)
+
+        # Otherwise, we need to rebuild the sequence.
+        #
+        # FIXME: This function assumes a stricter ordering of regions
+        # within the source docs (see DocRegion); This order is not
+        # currently enforced in parser.py, so this method may shift some
+        # contents around compared to the source.
+        tmp = []
+        for category in DocRegion:
+            tmp.extend(self.partitions[category])
+        self._sections = tmp
+        self._modified = False
+        return tuple(self._sections)
+
+
+def inline(ent: QAPISchemaEntity) -> List[QAPIDoc.Section]:
+    """
+    Return all of an entity's doc sections with inlined sections stitched in.
+
+    First, a given entity's sections are retrieved in full, in source order.
+
+    Next, if this entity has either an argument type (Commands and
+    Events) or an inherited base (Structs, Unions), this function is
+    called recursively on that type to retrieve its sections. These
+    sections are then stitched into the result.
+
+    Lastly, if this entity has any branches, this function is called
+    recursively on each branch type and those sections are stitched into
+    the result.
+
+    STITCH ORDER:
+
+      - Introduction
+      - [Inlined introduction sections are dropped.]
+      - Recursively inlined Members
+      - Members
+      - Recursively inlined Branch members
+      - Other special sections (Errors, Returns)
+      - [There are no cases where we have these sections to inline.]
+      - Recursively inlined Features
+      - Features
+      - Recursively inlined Details
+      - Details
+
+    Intro paragraphs are never stitched into the documentation section
+    list. Members, Features, and Details paragraphs are stitched in
+    *before* the given entity's equivalent regions. Individual sections
+    otherwise appear in source order as they do in the parent or child.
+
+    Branch members are stitched in *after* the member section.
+
+    In the event that a paragraph cannot be determined to be an intro or
+    details type, a warning is emitted. It will be treated as an intro
+    section and dropped from the output. QEMU usually treats Sphinx
+    warnings as fatal, so this warning is usually fatal.
+    """
+
+    def _sections(ent) -> List[QAPIDoc.Section]:
+        return ent.doc.all_sections if ent.doc else []
+
+    def _get_inline_target(
+        ent: QAPISchemaEntity,
+    ) -> Optional[QAPISchemaEntity]:
+        """Get the entity to inline from for a given entity."""
+        if isinstance(ent, (QAPISchemaCommand, QAPISchemaEvent)):
+            return ent.arg_type
+        if isinstance(ent, QAPISchemaObjectType):
+            return ent.base
+        return None
+
+    # Let's do this thing!
+
+    if ent is None:
+        return []
+
+    # Grab all directly documented sections for the entity in question.
+    sections = InlinerSections(_sections(ent))
+
+    # Get inlined sections: this includes everything from the
+    # inlined entity (and anything it inlines, too).
+    inlined = InlinerSections(inline(_get_inline_target(ent)))
+
+    # Now, stitch the results together!
+    sections.absorb(inlined)
+
+    # FIXME: Branches should be handled about here O:-)
+
+    # Return the combined list of sections.
+    return list(sections)
+
+
 class Transmogrifier:
     # Field names used for different entity types:
     field_types = {
@@ -285,7 +455,7 @@ def preamble(self, ent: QAPISchemaEntity) -> None:
         self.ensure_blank_line()
 
     def visit_sections(self, ent: QAPISchemaEntity) -> None:
-        sections = ent.doc.all_sections if ent.doc else []
+        sections = inline(ent)
 
         # Add sections *in the order they are documented*:
         for section in sections:
-- 
2.48.1


