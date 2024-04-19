Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33327C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1P-0007Vp-Jm; Fri, 19 Apr 2024 00:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1B-0007Qi-N4
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg19-0004Bk-TC
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeEOPzwkWscQq9TY4wDhSicoLO1pGuzMnN5NiFEv/iQ=;
 b=HjjeNFcSpImehL7mhi7CKmt/yhLMFs1HpYO60X+a2i+p+X7IYW1yMvVEmL9EWNlpCKYi6p
 Kc2fOvoVbh3u2NP2LF8dk41fSSLQHNH/J8vLhpW9gxl9wggQWHgZd2yQLEd3SCsiV93jSy
 n6i04x422dMWwy8n9AwUJDIGdZjCsqw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-MID9YDE6MWGELDINiLZMew-1; Fri, 19 Apr 2024 00:38:27 -0400
X-MC-Unique: MID9YDE6MWGELDINiLZMew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F9CC104B501;
 Fri, 19 Apr 2024 04:38:27 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF95B407F3D4;
 Fri, 19 Apr 2024 04:38:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 08/27] docs/qapi-domain: add :since: directive option
Date: Fri, 19 Apr 2024 00:37:56 -0400
Message-ID: <20240419043820.178731-9-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a little special markup for registering "Since:" information. Adding
it as an option instead of generic content lets us hoist the information
into the Signature bar, optionally put it in the index, etc.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  1 +
 docs/sphinx/qapi-domain.py | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 5516f762a24..33b9349a3ee 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -54,6 +54,7 @@ Explicit cross-referencing syntax for QAPI modules is available with
 
 
 .. qapi:command:: example-command
+   :since: 42.0
 
    This directive creates a QAPI command named `example-command` that
    appears in both the `genindex` and the `qapi-index`. As of this
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 2c1e60290d9..38a50318d08 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -4,6 +4,7 @@
 
 from __future__ import annotations
 
+import re
 from typing import (
     TYPE_CHECKING,
     Any,
@@ -86,6 +87,18 @@ def process_link(
         return title, target
 
 
+def since_validator(param: str) -> str:
+    """
+    Validate the `:since: X.Y` option field.
+    """
+    match = re.match(r"[0-9]+\.[0-9]+", param)
+    if not match:
+        raise ValueError(
+            f":since: requires a version number in X.Y format; not {param!r}"
+        )
+    return param
+
+
 def _nested_parse(directive: SphinxDirective, content_node: Element) -> None:
     """
     This helper preserves error parsing context across sphinx versions.
@@ -127,6 +140,8 @@ class QAPIObject(ObjectDescription[Signature]):
         {
             # Borrowed from the Python domain:
             "module": directives.unchanged,  # Override contextual module name
+            # These are QAPI originals:
+            "since": since_validator,
         }
     )
 
@@ -138,9 +153,17 @@ def get_signature_prefix(self, sig: str) -> List[nodes.Node]:
             addnodes.desc_sig_space(),
         ]
 
-    def get_signature_suffix(self, sig: str) -> list[nodes.Node]:
+    def get_signature_suffix(self, sig: str) -> List[nodes.Node]:
         """Returns a suffix to put after the object name in the signature."""
-        return []
+        ret: List[nodes.Node] = []
+
+        if "since" in self.options:
+            ret += [
+                addnodes.desc_sig_space(),
+                addnodes.desc_sig_element("", f"(Since: {self.options['since']})"),
+            ]
+
+        return ret
 
     def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
         """
-- 
2.44.0


