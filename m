Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01EDC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqX-0003Dz-JU; Tue, 11 Mar 2025 07:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqA-00035K-Fv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxpz-0006Sz-GT
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tv9oT81kD/IduAh4UJa5O71G9TAdSfSYd+QSG2v3UHI=;
 b=ZkEaT01WlkjH0QmYaG4PhzgXDEdCnfOycGBldYBhnPM12amZJoJXThvReIrHWCyC7ariam
 1oYWptqfRnKrc9DWSAetKiF2htgf3AIRVCJPszUQGFd8RKd984GwqTV8pV5U0SgP9GYh9H
 ljU79SqwDhphL+0o2xcnSp4lzLHOT58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-R5okrZLZPs-RhCdrpN38YA-1; Tue,
 11 Mar 2025 07:31:50 -0400
X-MC-Unique: R5okrZLZPs-RhCdrpN38YA-1
X-Mimecast-MFC-AGG-ID: R5okrZLZPs-RhCdrpN38YA_1741692709
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBD621955BC5
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 611F21956094
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D914A21E6562; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 10/61] docs/qapi-domain: add QAPIObject class
Date: Tue, 11 Mar 2025 12:30:46 +0100
Message-ID: <20250311113137.1277125-11-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

This patch adds another abstract class that describes "a QAPI
thingie". The main difference here is that this class will be generating
visible documentation, unlike the QAPIDescription class.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-13-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 64 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index e623d1f867..3109c0cb90 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -18,7 +18,9 @@
 )
 
 from docutils import nodes
+from docutils.parsers.rst import directives
 
+from compat import KeywordNode, SpaceNode
 from sphinx import addnodes
 from sphinx.addnodes import desc_signature, pending_xref
 from sphinx.directives import ObjectDescription
@@ -40,6 +42,7 @@
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
     from sphinx.environment import BuildEnvironment
+    from sphinx.util.typing import OptionSpec
 
 logger = logging.getLogger(__name__)
 
@@ -99,6 +102,8 @@ def process_link(
         return title, target
 
 
+# Alias for the return of handle_signature(), which is used in several places.
+# (In the Python domain, this is Tuple[str, str] instead.)
 Signature = str
 
 
@@ -194,6 +199,65 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
         return ""
 
 
+class QAPIObject(QAPIDescription):
+    """
+    Description of a generic QAPI object.
+
+    It's not used directly, but is instead subclassed by specific directives.
+    """
+
+    # Inherit some standard options from Sphinx's ObjectDescription
+    option_spec: OptionSpec = (  # type:ignore[misc]
+        ObjectDescription.option_spec.copy()
+    )
+    option_spec.update(
+        {
+            # Borrowed from the Python domain:
+            "module": directives.unchanged,  # Override contextual module name
+        }
+    )
+
+    def get_signature_prefix(self) -> List[nodes.Node]:
+        """Return a prefix to put before the object name in the signature."""
+        assert self.objtype
+        return [
+            KeywordNode("", self.objtype.title()),
+            SpaceNode(" "),
+        ]
+
+    def get_signature_suffix(self) -> List[nodes.Node]:
+        """Return a suffix to put after the object name in the signature."""
+        return []
+
+    def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
+        """
+        Transform a QAPI definition name into RST nodes.
+
+        This method was originally intended for handling function
+        signatures. In the QAPI domain, however, we only pass the
+        definition name as the directive argument and handle everything
+        else in the content body with field lists.
+
+        As such, the only argument here is "sig", which is just the QAPI
+        definition name.
+        """
+        modname = self.options.get(
+            "module", self.env.ref_context.get("qapi:module")
+        )
+
+        signode["fullname"] = sig
+        signode["module"] = modname
+        sig_prefix = self.get_signature_prefix()
+        if sig_prefix:
+            signode += addnodes.desc_annotation(
+                str(sig_prefix), "", *sig_prefix
+            )
+        signode += addnodes.desc_name(sig, sig)
+        signode += self.get_signature_suffix()
+
+        return sig
+
+
 class QAPIModule(QAPIDescription):
     """
     Directive to mark description of a new module.
-- 
2.48.1


