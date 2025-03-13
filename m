Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D46C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQO-0008Ls-Pb; Thu, 13 Mar 2025 00:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQ8-0008Fx-Tj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQ3-0006z0-KJ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07GW8NvUQ2ssXvRlf6ctOFtDO+Gxi0tCFzlZAYcCpcc=;
 b=SlFfpMrHAb9//MRwAvU6WKCF4xNPl3wmJ1T/mMimq/0/aje3xpqO8Mf6tUFETpTyoNVBpa
 1csZoa+Il2Q4uFXCvSouWT0oamxNAG9tMq5hb8QTMKyxBzvsTI+XnQdmlBbMgLHaZGNoT6
 vqNZgWdsXNqYM+H/ctWjLh+y6+RxxU0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-cAIMJ-IGMf-EZg4UuvLg5Q-1; Thu,
 13 Mar 2025 00:43:38 -0400
X-MC-Unique: cAIMJ-IGMf-EZg4UuvLg5Q-1
X-Mimecast-MFC-AGG-ID: cAIMJ-IGMf-EZg4UuvLg5Q_1741841017
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B9851800349; Thu, 13 Mar 2025 04:43:37 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 736DC1955BCB; Thu, 13 Mar 2025 04:43:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 03/11] docs/qapi_domain: add namespace support to FQN
Date: Thu, 13 Mar 2025 00:43:04 -0400
Message-ID: <20250313044312.189276-4-jsnow@redhat.com>
In-Reply-To: <20250313044312.189276-1-jsnow@redhat.com>
References: <20250313044312.189276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This patch adds a namespace component to the "Fully Qualified Name", in
the form of "domain:module.name". As there are no namespace directives
or options yet, this component will simply be empty as of this patch.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 6b23fc73ef2..48a082d489a 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -178,15 +178,18 @@ def get_index_text(self, name: Signature) -> Tuple[str, str]:
         # NB: this is used for the global index, not the QAPI index.
         return ("single", f"{name} (QMP {self.objtype})")
 
-    def _get_context(self) -> str:
+    def _get_context(self) -> Tuple[str, str]:
+        namespace = self.options.get(
+            "namespace", self.env.ref_context.get("qapi:namespace", "")
+        )
         modname = self.options.get(
             "module", self.env.ref_context.get("qapi:module", "")
         )
-        assert isinstance(modname, str)
-        return modname
+
+        return namespace, modname
 
     def _get_fqn(self, name: Signature) -> str:
-        modname = self._get_context()
+        namespace, modname = self._get_context()
 
         # If we're documenting a module, don't include the module as
         # part of the FQN; we ARE the module!
@@ -195,6 +198,8 @@ def _get_fqn(self, name: Signature) -> str:
 
         if modname:
             name = f"{modname}.{name}"
+        if namespace:
+            name = f"{namespace}:{name}"
         return name
 
     def add_target_and_index(
@@ -227,13 +232,18 @@ def add_target_and_index(
                 )
 
     @staticmethod
-    def split_fqn(name: str) -> Tuple[str, str]:
+    def split_fqn(name: str) -> Tuple[str, str, str]:
+        if ":" in name:
+            ns, name = name.split(":")
+        else:
+            ns = ""
+
         if "." in name:
             module, name = name.split(".")
         else:
             module = ""
 
-        return (module, name)
+        return (ns, module, name)
 
     def _object_hierarchy_parts(
         self, sig_node: desc_signature
@@ -251,7 +261,7 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
             return ""
 
         config = self.env.app.config
-        modname, name = toc_parts
+        namespace, modname, name = toc_parts
 
         if config.toc_object_entries_show_parents == "domain":
             ret = name
@@ -259,6 +269,10 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
                 "qapi:module", ""
             ):
                 ret = f"{modname}.{name}"
+            if namespace and namespace != self.env.ref_context.get(
+                "qapi:namespace", ""
+            ):
+                ret = f"{namespace}:{ret}"
             return ret
         if config.toc_object_entries_show_parents == "hide":
             return name
@@ -334,10 +348,15 @@ def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
         As such, the only argument here is "sig", which is just the QAPI
         definition name.
         """
-        modname = self._get_context()
+        # No module or domain info allowed in the signature!
+        assert ":" not in sig
+        assert "." not in sig
 
+        namespace, modname = self._get_context()
         signode["fullname"] = self._get_fqn(sig)
+        signode["namespace"] = namespace
         signode["module"] = modname
+
         sig_prefix = self.get_signature_prefix()
         if sig_prefix:
             signode += addnodes.desc_annotation(
-- 
2.48.1


