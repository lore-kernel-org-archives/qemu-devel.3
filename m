Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F08FC28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC9x-0003VO-VU; Sun, 09 Mar 2025 04:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9j-0002bL-49
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9h-0002R4-BG
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8esjTeF+k1c2jlPM70sGxtyoT3CAccDznLIyNNezhU=;
 b=hZN+kyprrVZTyjuU54XhgX1FTDJJz0T8yDq1K9UzFgaPjJ/p3/BJdVGs33LkRINPZYHhu4
 ORMd+Om7h8yOi5MJh5ttijZyEpiu1TofOcSavyMR2gSIBn91disjtV0TJ1tOe/4+UklutW
 PHj9PpKe9y1vjIB4cJVpEjlkZZp5VI0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-5am_4_XqMS6d67gAseI9Rg-1; Sun,
 09 Mar 2025 04:37:03 -0400
X-MC-Unique: 5am_4_XqMS6d67gAseI9Rg-1
X-Mimecast-MFC-AGG-ID: 5am_4_XqMS6d67gAseI9Rg_1741509422
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA35B1809CA3; Sun,  9 Mar 2025 08:37:01 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F9BA19560AB; Sun,  9 Mar 2025 08:36:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 27/62] docs/qapi-domain: add type cross-refs to field lists
Date: Sun,  9 Mar 2025 04:35:14 -0400
Message-ID: <20250309083550.5155-28-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

This commit, finally, adds cross-referencing support to various field
lists; modeled tightly after Sphinx's own Python domain code.

Cross-referencing support is added to type names provided to :arg:,
:memb:, :returns: and :choice:.

:feat:, :error: and :value:, which do not take type names, do not
support this syntax.

The general syntax is simple:

:arg TypeName ArgName: Lorem Ipsum ...

The domain will transform TypeName into :qapi:type:`TypeName` in this
basic case, and also apply the ``literal`` decoration to indicate that
this is a type cross-reference.

For optional arguments, the special "?" suffix is used. Because "*" has
special meaning in rST that would cause parsing errors, we elect to use
"?" instead. The special syntax processing strips this character from
the end of any type name argument and will append ", optional" to the
rendered output, applying the cross-reference only to the actual type
name.

The intent here is that the actual syntax in doc-blocks need not change;
but e.g. qapidoc.py will need to process and transform "@arg foo lorem
ipsum" into ":arg type? foo: lorem ipsum" based on the schema
information. Therefore, nobody should ever actually witness this
intermediate syntax unless they are writing manual documentation or the
doc transmogrifier breaks.

For array arguments, type names can similarly be surrounded by "[]",
which are stripped off and then re-appended outside of the
cross-reference.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 659b57d1b33..4f4bf328cc7 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -2,6 +2,9 @@
 QAPI domain extension.
 """
 
+# The best laid plans of mice and men, ...
+# pylint: disable=too-many-lines
+
 from __future__ import annotations
 
 from typing import (
@@ -116,6 +119,28 @@ def process_link(
 
         return title, target
 
+    def result_nodes(
+        self,
+        document: nodes.document,
+        env: BuildEnvironment,
+        node: Element,
+        is_ref: bool,
+    ) -> Tuple[List[nodes.Node], List[nodes.system_message]]:
+
+        # node here is the pending_xref node (or whatever nodeclass was
+        # configured at XRefRole class instantiation time).
+        results: List[nodes.Node] = [node]
+
+        if node.get("qapi:array"):
+            results.insert(0, nodes.literal("[", "["))
+            results.append(nodes.literal("]", "]"))
+
+        if node.get("qapi:optional"):
+            results.append(nodes.Text(", "))
+            results.append(nodes.emphasis("?", "optional"))
+
+        return results, []
+
 
 # Alias for the return of handle_signature(), which is used in several places.
 # (In the Python domain, this is Tuple[str, str] instead.)
@@ -408,6 +433,7 @@ class QAPICommand(QAPIObject):
                 "argument",
                 label=_("Arguments"),
                 names=("arg",),
+                typerolename="type",
                 can_collapse=False,
             ),
             # :error: descr
@@ -421,6 +447,7 @@ class QAPICommand(QAPIObject):
             GroupedField(
                 "returnvalue",
                 label=_("Return"),
+                rolename="type",
                 names=("return",),
                 can_collapse=True,
             ),
@@ -456,6 +483,7 @@ class QAPIAlternate(QAPIObject):
                 "alternative",
                 label=_("Alternatives"),
                 names=("alt",),
+                typerolename="type",
                 can_collapse=False,
             ),
         ]
@@ -473,6 +501,7 @@ class QAPIObjectWithMembers(QAPIObject):
                 "member",
                 label=_("Members"),
                 names=("memb",),
+                typerolename="type",
                 can_collapse=False,
             ),
         ]
-- 
2.48.1


