Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B1BC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20L-0006KM-Tc; Fri, 14 Mar 2025 06:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20G-0006Iv-1F
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00023R-SH
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJOvE7bX3CbiaJXP+Wn72i13qtqWhY5+bX0nNEwCku8=;
 b=Z0DcZ6gO0g0YtkaqCZ25zLBJ2ApKS26yGLFGB5usSPtGNIcEJimXW47iS9Buluo0JX2k2b
 npUztyyq9mqskFxZFrJLfjFSaYz/xTS3vgIruCVE/zkIFEEheNxV5Mr7w2uuv+7xzoO67J
 IzYjEOlU/Drun0rnusflIMxnRPZeh90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-Gi5cm--mNlmrsg8fDDYeLA-1; Fri,
 14 Mar 2025 06:10:45 -0400
X-MC-Unique: Gi5cm--mNlmrsg8fDDYeLA-1
X-Mimecast-MFC-AGG-ID: Gi5cm--mNlmrsg8fDDYeLA_1741947045
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E935B19560B8
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0EF2300376F
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C257B21E66A3; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 03/12] docs/qapi-domain: always store fully qualified name in
 signode
Date: Fri, 14 Mar 2025 11:10:29 +0100
Message-ID: <20250314101038.2408751-4-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Currently, only the definition name is stored in the tree metadata; but
the node property is confusingly called "fullname". Rectify this by
always storing the FQN in the tree metadata.

... While we're here, re-organize the code in preparation for namespace
support to make it a bit easier to add additional components of the
FQN. With this change, there is now extremely little code left that's
taken directly from the Python domain :)

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-3-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 64 +++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index d52e7df7bc..6b23fc73ef 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -178,6 +178,25 @@ def get_index_text(self, name: Signature) -> Tuple[str, str]:
         # NB: this is used for the global index, not the QAPI index.
         return ("single", f"{name} (QMP {self.objtype})")
 
+    def _get_context(self) -> str:
+        modname = self.options.get(
+            "module", self.env.ref_context.get("qapi:module", "")
+        )
+        assert isinstance(modname, str)
+        return modname
+
+    def _get_fqn(self, name: Signature) -> str:
+        modname = self._get_context()
+
+        # If we're documenting a module, don't include the module as
+        # part of the FQN; we ARE the module!
+        if self.objtype == "module":
+            modname = ""
+
+        if modname:
+            name = f"{modname}.{name}"
+        return name
+
     def add_target_and_index(
         self, name: Signature, sig: str, signode: desc_signature
     ) -> None:
@@ -187,14 +206,8 @@ def add_target_and_index(
 
         assert self.objtype
 
-        # If we're documenting a module, don't include the module as
-        # part of the FQN.
-        modname = ""
-        if self.objtype != "module":
-            modname = self.options.get(
-                "module", self.env.ref_context.get("qapi:module")
-            )
-        fullname = (modname + "." if modname else "") + name
+        if not (fullname := signode.get("fullname", "")):
+            fullname = self._get_fqn(name)
 
         node_id = make_id(
             self.env, self.state.document, self.objtype, fullname
@@ -213,18 +226,21 @@ def add_target_and_index(
                     (arity, indextext, node_id, "", None)
                 )
 
+    @staticmethod
+    def split_fqn(name: str) -> Tuple[str, str]:
+        if "." in name:
+            module, name = name.split(".")
+        else:
+            module = ""
+
+        return (module, name)
+
     def _object_hierarchy_parts(
         self, sig_node: desc_signature
     ) -> Tuple[str, ...]:
         if "fullname" not in sig_node:
             return ()
-        modname = sig_node.get("module")
-        fullname = sig_node["fullname"]
-
-        if modname:
-            return (modname, *fullname.split("."))
-
-        return tuple(fullname.split("."))
+        return self.split_fqn(sig_node["fullname"])
 
     def _toc_entry_name(self, sig_node: desc_signature) -> str:
         # This controls the name in the TOC and on the sidebar.
@@ -235,13 +251,19 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
             return ""
 
         config = self.env.app.config
-        *parents, name = toc_parts
+        modname, name = toc_parts
+
         if config.toc_object_entries_show_parents == "domain":
-            return sig_node.get("fullname", name)
+            ret = name
+            if modname and modname != self.env.ref_context.get(
+                "qapi:module", ""
+            ):
+                ret = f"{modname}.{name}"
+            return ret
         if config.toc_object_entries_show_parents == "hide":
             return name
         if config.toc_object_entries_show_parents == "all":
-            return ".".join(parents + [name])
+            return sig_node.get("fullname", name)
         return ""
 
 
@@ -312,11 +334,9 @@ def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
         As such, the only argument here is "sig", which is just the QAPI
         definition name.
         """
-        modname = self.options.get(
-            "module", self.env.ref_context.get("qapi:module")
-        )
+        modname = self._get_context()
 
-        signode["fullname"] = sig
+        signode["fullname"] = self._get_fqn(sig)
         signode["module"] = modname
         sig_prefix = self.get_signature_prefix()
         if sig_prefix:
-- 
2.48.1


