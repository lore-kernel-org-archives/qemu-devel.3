Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0B9C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20N-0006LR-O0; Fri, 14 Mar 2025 06:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20G-0006JC-G5
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00023M-SU
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jBRtbQj34+6ynEpVBu15Qf4PyPm1m8GNkAPco2/M1E=;
 b=JNpHqr/q1VwcabkpCmghRbHEUDQUBSvRml4lrIld5I5TlnsIoyMpEld70oZJa2HszKrXiV
 BJOvhZNVi2rueJTf70OEo4OJLSUmQud/IRFzcFNmwu5B56OhXhLZtAW1h0MeTnB6OdGiEs
 wV4aiMV3Gq9uSkfzgZsjMkPihZAT4Ak=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-CT8lFtk_M4OMcqbnINKjxA-1; Fri,
 14 Mar 2025 06:10:50 -0400
X-MC-Unique: CT8lFtk_M4OMcqbnINKjxA-1
X-Mimecast-MFC-AGG-ID: CT8lFtk_M4OMcqbnINKjxA_1741947049
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 916EC1955D82
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1B561828AA8
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA67721E6561; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 09/12] docs/qapi-domain: add namespaced index support
Date: Fri, 14 Mar 2025 11:10:35 +0100
Message-ID: <20250314101038.2408751-10-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Generate an index-per-namespace for the QAPI domain. Due to a limitation
with Sphinx's architecture, these indices must be defined during setup
time and cannot be dynamically created on-demand when a namespace
directive is encountered.

Owing to that limitation, add a configuration value to conf.py that
specifies which QAPI namespaces we'll generate indices for.

Indices will be named after their namespace, e.g. the "QMP" namespace
will generate to "qapi-qmp-index.html" and can be referenced using
`qapi-qmp-index`.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-9-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/conf.py               |  3 +++
 docs/sphinx/qapi_domain.py | 51 +++++++++++++++++++++++++++-----------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index a3f9fa63d9..175491148c 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -161,6 +161,9 @@
     "see also",
 }
 
+# Due to a limitation in Sphinx, we need to know which indices to
+# generate in advance. Adding a namespace here allows that generation.
+qapi_namespaces = set()
 
 # -- Options for HTML output ----------------------------------------------
 
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index a8a85a2de3..c94af5719c 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -8,11 +8,13 @@
 from __future__ import annotations
 
 import re
+import types
 from typing import (
     TYPE_CHECKING,
     List,
     NamedTuple,
     Tuple,
+    Type,
     cast,
 )
 
@@ -669,6 +671,7 @@ class QAPIIndex(Index):
     name = "index"
     localname = _("QAPI Index")
     shortname = _("QAPI Index")
+    namespace = ""
 
     def generate(
         self,
@@ -678,25 +681,20 @@ def generate(
         content: Dict[str, List[IndexEntry]] = {}
         collapse = False
 
-        # list of all object (name, ObjectEntry) pairs, sorted by name
-        # (ignoring the module)
-        objects = sorted(
-            self.domain.objects.items(),
-            key=lambda x: x[0].split(".")[-1].lower(),
-        )
-
-        for objname, obj in objects:
+        for objname, obj in self.domain.objects.items():
             if docnames and obj.docname not in docnames:
                 continue
 
-            # Strip the module name out:
-            objname = objname.split(".")[-1]
+            ns, _mod, name = QAPIDescription.split_fqn(objname)
+
+            if self.namespace != ns:
+                continue
 
             # Add an alphabetical entry:
-            entries = content.setdefault(objname[0].upper(), [])
+            entries = content.setdefault(name[0].upper(), [])
             entries.append(
                 IndexEntry(
-                    objname, 0, obj.docname, obj.node_id, obj.objtype, "", ""
+                    name, 0, obj.docname, obj.node_id, obj.objtype, "", ""
                 )
             )
 
@@ -704,10 +702,14 @@ def generate(
             category = obj.objtype.title() + "s"
             entries = content.setdefault(category, [])
             entries.append(
-                IndexEntry(objname, 0, obj.docname, obj.node_id, "", "", "")
+                IndexEntry(name, 0, obj.docname, obj.node_id, "", "", "")
             )
 
-        # alphabetically sort categories; type names first, ABC entries last.
+        # Sort entries within each category alphabetically
+        for category in content:
+            content[category] = sorted(content[category])
+
+        # Sort the categories themselves; type names first, ABC entries last.
         sorted_content = sorted(
             content.items(),
             key=lambda x: (len(x[0]) == 1, x[0]),
@@ -780,6 +782,21 @@ def objects(self) -> Dict[str, ObjectEntry]:
         ret = self.data.setdefault("objects", {})
         return ret  # type: ignore[no-any-return]
 
+    def setup(self) -> None:
+        namespaces = set(self.env.app.config.qapi_namespaces)
+        for namespace in namespaces:
+            new_index: Type[QAPIIndex] = types.new_class(
+                f"{namespace}Index", bases=(QAPIIndex,)
+            )
+            new_index.name = f"{namespace.lower()}-index"
+            new_index.localname = _(f"{namespace} Index")
+            new_index.shortname = _(f"{namespace} Index")
+            new_index.namespace = namespace
+
+            self.indices.append(new_index)
+
+        super().setup()
+
     def note_object(
         self,
         name: str,
@@ -1019,6 +1036,12 @@ def setup(app: Sphinx) -> Dict[str, Any]:
         "env",  # Setting impacts parsing phase
         types=set,
     )
+    app.add_config_value(
+        "qapi_namespaces",
+        set(),
+        "env",
+        types=set,
+    )
     app.add_domain(QAPIDomain)
 
     return {
-- 
2.48.1


