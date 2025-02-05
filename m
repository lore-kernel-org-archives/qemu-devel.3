Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB4C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfodH-0003oS-Jr; Wed, 05 Feb 2025 18:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfod8-00031d-Vq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfod2-0006YT-3D
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OG1OMNHyw6wL72+on5pGRFR4/JQLepCqy5ztn8vdu08=;
 b=gDUqFW9nCznvtH3pAGpPxUJQogWItclU9XMMe/k/Hd74Y72xZZIWCIjaNxSGVWFYweNUSY
 a2O7dzxvgPhqsGfRIaw0FpA7wXBxQCNGmc+3vnbzP3VsTlJwPMZtwa9UsQLTN8kRMGyqK5
 aFWmaUhLh5iarvz8UVgJtIKhX65P8B0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-O5dzuOe0MomKpZp09rTSxA-1; Wed,
 05 Feb 2025 18:16:11 -0500
X-MC-Unique: O5dzuOe0MomKpZp09rTSxA-1
X-Mimecast-MFC-AGG-ID: O5dzuOe0MomKpZp09rTSxA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00803195608C; Wed,  5 Feb 2025 23:16:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 640A81800570; Wed,  5 Feb 2025 23:16:04 +0000 (UTC)
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
Subject: [PATCH 38/42] docs/qapi: add branch support to inliner
Date: Wed,  5 Feb 2025 18:12:04 -0500
Message-ID: <20250205231208.1480762-39-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Well, kind of. Anything beyond simple member definitions aren't
included; including ifcond, details sections, features, etc. Definitely
the most "WIP" part of this entire patch series.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 57 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 755eb0fa0ec..86c13520d94 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -44,6 +44,7 @@
 from qapi.schema import (
     QAPISchema,
     QAPISchemaArrayType,
+    QAPISchemaBranches,
     QAPISchemaCommand,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
@@ -68,6 +69,20 @@
 logger = logging.getLogger(__name__)
 
 
+# These classes serve as pseudo-sections that this generator uses to
+# flatten and inline arg sections from multiple entities.
+class BranchStart(QAPIDoc.Section):
+    def __init__(self, key: str, value: str, info: QAPISourceInfo):
+        super().__init__(info, QAPIDoc.Kind.META)
+        self.key = key
+        self.value = value
+
+
+class BranchEnd(QAPIDoc.Section):
+    def __init__(self, info: QAPISourceInfo):
+        super().__init__(info, QAPIDoc.Kind.META)
+
+
 def dedent(text: str) -> str:
     # Adjust indentation to make description text parse as paragraph.
 
@@ -105,6 +120,7 @@ def categorize(section: QAPIDoc.Section) -> "Optional[DocRegion]":
     QAPIDoc.Kind.SINCE: None,
     QAPIDoc.Kind.TODO: None,
     QAPIDoc.Kind.DETAIL: DocRegion.DETAIL,
+    QAPIDoc.Kind.META: DocRegion.MEMBER,
 }
 
 
@@ -226,6 +242,15 @@ def _get_inline_target(
             return ent.base
         return None
 
+    def _variants(ent) -> Optional[QAPISchemaBranches]:
+        if isinstance(ent, QAPISchemaObjectType):
+            return ent.branches
+        return None
+
+    def _memb_filter(sec: QAPIDoc.Section) -> bool:
+        # meta grabs branch start/end markers, too.
+        return sec.kind in (QAPIDoc.Kind.MEMBER, QAPIDoc.Kind.META)
+
     # Let's do this thing!
 
     if ent is None:
@@ -241,7 +266,22 @@ def _get_inline_target(
     # Now, stitch the results together!
     sections.absorb(inlined)
 
-    # FIXME: Branches should be handled about here O:-)
+    # Now, pick up member sections from branches, if any.
+    # FIXME: Anything other than members are unhandled/ignored here...!
+    branch_sections = []
+    if variants := _variants(ent):
+        for variant in variants.variants:
+            branch_sections.append(
+                BranchStart(
+                    variants.tag_member.name, variant.name, variants.info
+                )
+            )
+            var_sections = inline(variant.type)
+            branch_sections.extend(filter(_memb_filter, var_sections))
+            branch_sections.append(BranchEnd(variants.info))
+
+    # Inject branches *after* the member section.
+    sections.partitions[DocRegion.MEMBER].extend(branch_sections)
 
     # Pseudo-feature: document the OOB property.
     if isinstance(ent, QAPISchemaCommand) and ent.allow_oob:
@@ -485,6 +525,21 @@ def visit_sections(self, ent: QAPISchemaEntity) -> None:
 
         # Add sections *in the order they are documented*:
         for section in sections:
+            if isinstance(section, BranchStart):
+                self.ensure_blank_line()
+                self.add_line(
+                    f".. qapi:branch:: {section.key} {section.value}",
+                    section.info,
+                )
+                self.ensure_blank_line()
+                self.indent += 1
+                continue
+
+            if isinstance(section, BranchEnd):
+                self.ensure_blank_line()
+                self.indent -= 1
+                continue
+
             if section.kind.name in ("INTRO", "DETAIL"):
                 self.visit_paragraph(section)
             elif section.kind == QAPIDoc.Kind.MEMBER:
-- 
2.48.1


