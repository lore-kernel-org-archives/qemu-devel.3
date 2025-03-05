Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FEFC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfk2-00014G-RY; Tue, 04 Mar 2025 22:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjz-0000oL-2z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjx-0006Fp-7h
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RxCjFYPvrEydD2D4WJ3pep23Kg6DeegEtOUm7zlMIk=;
 b=B356igV3tXqBob/AsDqqPZVjtzR4DnHpua54pdgiWMPQEcfR86ITnSAgKhLhcpSLv4n5jF
 ZCLrfn2m8ENlVUOPz1O9Ov2AJ6fQvAI7SvzeF6TkgtYAxZ5YesOQ19wgywpSH3MMtIpymp
 Pl+XfeIM7VOT8CwzxyIM1UxEINtQ8jE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-PtLRJPgENVC4lt3XQHCfIw-1; Tue,
 04 Mar 2025 22:47:01 -0500
X-MC-Unique: PtLRJPgENVC4lt3XQHCfIw-1
X-Mimecast-MFC-AGG-ID: PtLRJPgENVC4lt3XQHCfIw_1741146420
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 586AE1955BFC; Wed,  5 Mar 2025 03:47:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E37501956095; Wed,  5 Mar 2025 03:46:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 12/57] docs/qapi-domain: add :since: directive option
Date: Tue,  4 Mar 2025 22:45:21 -0500
Message-ID: <20250305034610.960147-13-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

Add a little special markup for registering "Since:" information. Adding
it as an option instead of generic content lets us hoist the information
into the Signature bar, optionally put it in the index, etc.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 6168c23936f..9919dacd4e6 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -4,6 +4,7 @@
 
 from __future__ import annotations
 
+import re
 from typing import (
     TYPE_CHECKING,
     AbstractSet,
@@ -104,6 +105,18 @@ def process_link(
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
 # Alias for the return of handle_signature(), which is used in several places.
 # (In the Python domain, this is Tuple[str, str] instead.)
 Signature = str
@@ -124,6 +137,8 @@ class QAPIObject(ObjectDescription[Signature]):
         {
             # Borrowed from the Python domain:
             "module": directives.unchanged,  # Override contextual module name
+            # These are QAPI originals:
+            "since": since_validator,
         }
     )
 
@@ -135,9 +150,19 @@ def get_signature_prefix(self) -> List[nodes.Node]:
             SpaceNode(" "),
         ]
 
-    def get_signature_suffix(self) -> list[nodes.Node]:
+    def get_signature_suffix(self) -> List[nodes.Node]:
         """Returns a suffix to put after the object name in the signature."""
-        return []
+        ret: List[nodes.Node] = []
+
+        if "since" in self.options:
+            ret += [
+                SpaceNode(" "),
+                addnodes.desc_sig_element(
+                    "", f"(Since: {self.options['since']})"
+                ),
+            ]
+
+        return ret
 
     def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
         """
-- 
2.48.1


