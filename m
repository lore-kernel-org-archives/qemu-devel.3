Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13D4C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQF-0008He-8m; Thu, 13 Mar 2025 00:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaPz-0008Cw-Tu
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaPw-0006y0-HG
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9F8tYEPgBenKK4UHliMJ1TA6qt3Cd3tJf64ql/EpTb8=;
 b=jUktCsTYJGdcATmHPyoNwi4BHdC5tvzxZO+qcT1CU6jMvh6BvAmE+FYKMgz4LLGVwR0Rm1
 rvrArTZUyhDZ3I/Yd+7wb/xOb7IBq3gf+tJIYGZwjkQmNkcf96VAdsznYH2U+lpWrax2iw
 6OYTbkhNJ7rNT4fvidKJTgG0Nrjx1o4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-2q7gcZKVOeCT9XHViPyo_A-1; Thu,
 13 Mar 2025 00:43:34 -0400
X-MC-Unique: 2q7gcZKVOeCT9XHViPyo_A-1
X-Mimecast-MFC-AGG-ID: 2q7gcZKVOeCT9XHViPyo_A_1741841013
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6963180034D; Thu, 13 Mar 2025 04:43:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B26B31944E42; Thu, 13 Mar 2025 04:43:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 02/11] docs/qapi-domain: always store fully qualified name in
 signode
Date: Thu, 13 Mar 2025 00:43:03 -0400
Message-ID: <20250313044312.189276-3-jsnow@redhat.com>
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

Currently, only the definition name is stored in the tree metadata; but
the node property is confusingly called "fullname". Rectify this by
always storing the FQN in the tree metadata.

... While we're here, re-organize the code in preparation for namespace
support to make it a bit easier to add additional components of the
FQN. With this change, there is now extremely little code left that's
taken directly from the Python domain :)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 64 +++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index d52e7df7bc7..6b23fc73ef2 100644
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


