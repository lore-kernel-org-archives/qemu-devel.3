Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBFBC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQU-0008PQ-Oo; Thu, 13 Mar 2025 00:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQK-0008KY-E1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQH-000710-Uq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTlDyjuppXQQeBToAKJuwFwm46Lxj7QUImME8qxcNHQ=;
 b=EVn4S4uTUqh+9wSgfu8j0OK9Ft8CRxv3uxOgnEBpsryyjD+1Wep8td3pd4jvZ4aBFfG/Vj
 VnKphbbQwir/lP9kfr0DKSr4XC7qyWiYIO34QxKURZWa3mxYL/9IzCxfky8PxWI14/q9Oj
 ZkPwBJnMgpKoEx0+tXaK1Zv2RsgD324=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-RXm6Fm41OjyUUsc8tY0p_Q-1; Thu,
 13 Mar 2025 00:43:49 -0400
X-MC-Unique: RXm6Fm41OjyUUsc8tY0p_Q-1
X-Mimecast-MFC-AGG-ID: RXm6Fm41OjyUUsc8tY0p_Q_1741841028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CA2D1956089; Thu, 13 Mar 2025 04:43:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27B241955BCB; Thu, 13 Mar 2025 04:43:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
Date: Thu, 13 Mar 2025 00:43:08 -0400
Message-ID: <20250313044312.189276-8-jsnow@redhat.com>
In-Reply-To: <20250313044312.189276-1-jsnow@redhat.com>
References: <20250313044312.189276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch does three things:

1. Record the current namespace context in pending_xrefs so it can be
   used for link resolution later,
2. Pass that recorded namespace context to find_obj() when resolving a
   reference, and
3. Wildly and completely rewrite find_obj().

cross-reference support is expanded to tolerate the presence or absence
of either namespace or module, and to cope with the presence or absence
of contextual information for either.

References now work like this:

1. If the explicit reference target is recorded in the domain's object
   registry, we link to that target and stop looking. We do this lookup
   regardless of how fully qualified the target is, which allows direct
   references to modules (which don't have a module component to their
   names) or direct references to definitions that may or may not belong
   to a namespace or module.

2. If contextual information is available from qapi:namespace or
   qapi:module directives, try using those components to find a direct
   match to the implied target name.

3. If both prior lookups fail, generate a series of regular expressions
   looking for wildcard matches in order from most to least
   specific. Any explicitly provided components (namespace, module)
   *must* match exactly, but both contextual and entirely omitted
   components are allowed to differ from the search result. Note that if
   more than one result is found, Sphinx will emit a warning (a build
   error for QEMU) and list all of the candidate references.

The practical upshot is that in the large majority of cases, namespace
and module information is not required when creating simple `references`
to definitions from within the same context -- even when identical
definitions exist in other contexts.

Even when using simple `references` from elsewhere in the QEMU
documentation manual, explicit namespace info is not required if there
is only one definition by that name.

Disambiguation *will* be required from outside of the QAPI documentation
when referencing e.g. block-core definitions, which are shared between
QEMU QMP and the QEMU Storage Daemon. In that case, there are two
options:

A: References can be made partially or fully explicit,
   e.g. `QMP:block-dirty-bitmap-add` will link to the QEMU version of
   the definition, while `QGA:block-dirty-bitmap-add` would link to the
   QGA version.

B: If all of the references in a document are intended to go to the same
   place, you can insert a "qapi:namespace:: QMP" directive to influence
   the fuzzy-searching for later references.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-domain.rst |  34 ++++++++--
 docs/sphinx/qapi_domain.py | 127 ++++++++++++++++++++++++-------------
 2 files changed, 114 insertions(+), 47 deletions(-)

diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index 73e13ab45ca..4705ba255e0 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -400,11 +400,10 @@ Namespaces
 Mimicking the `Python domain target specification syntax
 <https://www.sphinx-doc.org/en/master/usage/domains/python.html#target-specification>`_,
 QAPI allows you to specify the fully qualified path for a data
-type. QAPI enforces globally unique names, so it's unlikely you'll need
-this specific feature, but it may be extended in the near future to
-allow referencing identically named commands and data types from
-different utilities; i.e. QEMU Storage Daemon vs QMP.
+type.
 
+* A namespace can be explicitly provided;
+  e.g. ``:qapi:type:`QMP:BitmapSyncMode``
 * A module can be explicitly provided;
   ``:qapi:type:`block-core.BitmapSyncMode``` will render to:
   :qapi:type:`block-core.BitmapSyncMode`
@@ -413,6 +412,28 @@ different utilities; i.e. QEMU Storage Daemon vs QMP.
   will render to: :qapi:type:`~block-core.BitmapSyncMode`
 
 
+Target resolution
+-----------------
+
+Any cross-reference to a QAPI type, whether using the ```any``` style of
+reference or the more explicit ```:qapi:any:`target``` syntax, allows
+for the presence or absence of either the namespace or module
+information.
+
+When absent, their value will be inferred from context by the presence
+of any ``qapi:namespace`` or ``qapi:module`` directives preceding the
+cross-reference.
+
+If no results are found when using the inferred values, other
+namespaces/modules will be searched as a last resort; but any explicitly
+provided values must always match in order to succeed.
+
+This allows for efficient cross-referencing with a minimum of syntax in
+the large majority of cases, but additional context or namespace markup
+may be required outside of the QAPI reference documents when linking to
+items that share a name across multiple documented QAPI schema.
+
+
 Custom link text
 ----------------
 
@@ -492,6 +513,11 @@ directives are associated with the most recent namespace. This affects
 the definition's "fully qualified name", allowing two different
 namespaces to create an otherwise identically named definition.
 
+This directive also influences how reference resolution works for any
+references that do not explicity specify a namespace, so this directive
+can be used to nudge references into preferring targets from within that
+namespace.
+
 Example::
 
    .. qapi:namespace:: QMP
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index a204af9b062..a8a85a2de36 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -7,6 +7,7 @@
 
 from __future__ import annotations
 
+import re
 from typing import (
     TYPE_CHECKING,
     List,
@@ -94,6 +95,7 @@ def process_link(
         title: str,
         target: str,
     ) -> tuple[str, str]:
+        refnode["qapi:namespace"] = env.ref_context.get("qapi:namespace")
         refnode["qapi:module"] = env.ref_context.get("qapi:module")
 
         # Cross-references that begin with a tilde adjust the title to
@@ -830,40 +832,44 @@ def merge_domaindata(
                 self.objects[fullname] = obj
 
     def find_obj(
-        self, modname: str, name: str, typ: Optional[str]
-    ) -> list[tuple[str, ObjectEntry]]:
+        self, namespace: str, modname: str, name: str, typ: Optional[str]
+    ) -> List[Tuple[str, ObjectEntry]]:
         """
-        Find a QAPI object for "name", perhaps using the given module.
+        Find a QAPI object for "name", maybe using contextual information.
 
         Returns a list of (name, object entry) tuples.
 
-        :param modname: The current module context (if any!)
-                        under which we are searching.
-        :param name: The name of the x-ref to resolve;
-                     may or may not include a leading module.
-        :param type: The role name of the x-ref we're resolving, if provided.
-                     (This is absent for "any" lookups.)
+        :param namespace: The current namespace context (if any!) under
+            which we are searching.
+        :param modname: The current module context (if any!) under
+            which we are searching.
+        :param name: The name of the x-ref to resolve; may or may not
+            include leading context.
+        :param type: The role name of the x-ref we're resolving, if
+            provided. This is absent for "any" role lookups.
         """
         if not name:
             return []
 
-        names: list[str] = []
-        matches: list[tuple[str, ObjectEntry]] = []
+        # ##
+        # what to search for
+        # ##
 
-        fullname = name
-        if "." in fullname:
-            # We're searching for a fully qualified reference;
-            # ignore the contextual module.
-            pass
-        elif modname:
-            # We're searching for something from somewhere;
-            # try searching the current module first.
-            # e.g. :qapi:cmd:`query-block` or `query-block` is being searched.
-            fullname = f"{modname}.{name}"
+        parts = list(QAPIDescription.split_fqn(name))
+        explicit = tuple(bool(x) for x in parts)
+
+        # Fill in the blanks where possible:
+        if namespace and not parts[0]:
+            parts[0] = namespace
+        if modname and not parts[1]:
+            parts[1] = modname
+
+        implicit_fqn = ""
+        if all(parts):
+            implicit_fqn = f"{parts[0]}:{parts[1]}.{parts[2]}"
 
         if typ is None:
-            # type isn't specified, this is a generic xref.
-            # search *all* qapi-specific object types.
+            # :any: lookup, search everything:
             objtypes: List[str] = list(self.object_types)
         else:
             # type is specified and will be a role (e.g. obj, mod, cmd)
@@ -871,25 +877,57 @@ def find_obj(
             # using the QAPIDomain.object_types table.
             objtypes = self.objtypes_for_role(typ, [])
 
-        if name in self.objects and self.objects[name].objtype in objtypes:
-            names = [name]
-        elif (
-            fullname in self.objects
-            and self.objects[fullname].objtype in objtypes
-        ):
-            names = [fullname]
+        # ##
+        # search!
+        # ##
+
+        def _search(needle: str) -> List[str]:
+            if (
+                needle
+                and needle in self.objects
+                and self.objects[needle].objtype in objtypes
+            ):
+                return [needle]
+            return []
+
+        if found := _search(name):
+            # Exact match!
+            pass
+        elif found := _search(implicit_fqn):
+            # Exact match using contextual information to fill in the gaps.
+            pass
         else:
-            # exact match wasn't found; e.g. we are searching for
-            # `query-block` from a different (or no) module.
-            searchname = "." + name
-            names = [
-                oname
-                for oname in self.objects
-                if oname.endswith(searchname)
-                and self.objects[oname].objtype in objtypes
-            ]
-
-        matches = [(oname, self.objects[oname]) for oname in names]
+            # No exact hits, perform applicable fuzzy searches.
+            searches = []
+
+            esc = tuple(re.escape(s) for s in parts)
+
+            # Try searching for ns:*.name or ns:name
+            if explicit[0] and not explicit[1]:
+                searches.append(f"^{esc[0]}:([^\\.]+\\.)?{esc[2]}$")
+            # Try searching for *:module.name or module.name
+            if explicit[1] and not explicit[0]:
+                searches.append(f"(^|:){esc[1]}\\.{esc[2]}$")
+            # Try searching for context-ns:*.name or context-ns:name
+            if parts[0] and not (explicit[0] or explicit[1]):
+                searches.append(f"^{esc[0]}:([^\\.]+\\.)?{esc[2]}$")
+            # Try searching for *:context-mod.name or context-mod.name
+            if parts[1] and not (explicit[0] or explicit[1]):
+                searches.append(f"(^|:){esc[1]}\\.{esc[2]}$")
+            # Try searching for *:name, *.name, or name
+            if not (explicit[0] or explicit[1]):
+                searches.append(f"(^|:|\\.){esc[2]}$")
+
+            for search in searches:
+                if found := [
+                    oname
+                    for oname in self.objects
+                    if re.search(search, oname)
+                    and self.objects[oname].objtype in objtypes
+                ]:
+                    break
+
+        matches = [(oname, self.objects[oname]) for oname in found]
         if len(matches) > 1:
             matches = [m for m in matches if not m[1].aliased]
         return matches
@@ -904,8 +942,9 @@ def resolve_xref(
         node: pending_xref,
         contnode: Element,
     ) -> nodes.reference | None:
+        namespace = node.get("qapi:namespace")
         modname = node.get("qapi:module")
-        matches = self.find_obj(modname, target, typ)
+        matches = self.find_obj(namespace, modname, target, typ)
 
         if not matches:
             # Normally, we could pass warn_dangling=True to QAPIXRefRole(),
@@ -958,7 +997,9 @@ def resolve_any_xref(
         contnode: Element,
     ) -> List[Tuple[str, nodes.reference]]:
         results: List[Tuple[str, nodes.reference]] = []
-        matches = self.find_obj(node.get("qapi:module"), target, None)
+        matches = self.find_obj(
+            node.get("qapi:namespace"), node.get("qapi:module"), target, None
+        )
         for name, obj in matches:
             rolename = self.role_for_objtype(obj.objtype)
             assert rolename is not None
-- 
2.48.1


