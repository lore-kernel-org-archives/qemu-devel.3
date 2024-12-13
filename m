Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BB3E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGa-000702-UF; Thu, 12 Dec 2024 20:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGY-0006rY-1e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGW-0000hM-1E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tf5xaSO0EkHds5mMKncBH7RfG7ylI74BQWD6+y1RW8=;
 b=aels56WYJFC1fW5FNA1aNEEGX9AVPkAULbr28rDAj65xa4Dzk7XCJBbNFpy86dH3+OVA/u
 sa3LhUKUF5xZ6H93AdYzJ+xrsuvD8CVahXSI+OGvUjBxk1TvYiTEHqMwVI5L+Sz6wcEOax
 xHCGwsNt6siEiYwFptcKWlErKe76dfs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-xaMJMyntOI67NvZQovKM_g-1; Thu,
 12 Dec 2024 20:14:44 -0500
X-MC-Unique: xaMJMyntOI67NvZQovKM_g-1
X-Mimecast-MFC-AGG-ID: xaMJMyntOI67NvZQovKM_g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8B319560B3; Fri, 13 Dec 2024 01:14:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60C851956086; Fri, 13 Dec 2024 01:14:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [RFC PATCH v2 23/35] docs/qapi-domain: add :deprecated: directive
 option
Date: Thu, 12 Dec 2024 20:12:52 -0500
Message-ID: <20241213011307.2942030-24-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Although "deprecated" is a feature (and *will* appear in the features
list), add a special :deprecated: option to generate an eye-catch that
makes this information very hard to miss.

(The intent is to modify qapidoc.py to add this option whenever it
detects that the features list attached to a definition contains the
"deprecated" entry.)

-

RFC: Technically, this object-level option is un-needed and could be
replaced with a standard content-level directive that e.g. qapidoc.py
could insert at the beginning of the content block. I've done it here as
an option to demonstrate how it would be possible to do.

It's a matter of taste for "where" we feel like implementing it.

One benefit of doing it this way is that we can create a single
containing box to set CSS style options controlling the flow of multiple
infoboxes. The other way to achieve that would be to create a directive
that allows us to set multiple options instead, e.g.:

.. qapi:infoboxes:: deprecated unstable

or possibly:

.. qapi:infoboxes::
   :deprecated:
   :unstable:

For now, I've left these as top-level QAPI object options. "Hey, it works."

P.S., I outsourced the CSS ;)

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 25 +++++++++++++++++++++++++
 docs/sphinx/qapi-domain.py             | 24 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 965ecac54fd..3765cab1b20 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -208,3 +208,28 @@ div[class^="highlight"] pre {
         color: inherit;
     }
 }
+
+/* QAPI domain theming */
+
+.qapi-infopips {
+    margin-bottom: 1em;
+}
+
+.qapi-infopip {
+    display: inline-block;
+    padding: 0em 0.5em 0em 0.5em;
+    margin: 0.25em;
+}
+
+.qapi-deprecated {
+    background-color: #fffef5;
+    border: solid #fff176 6px;
+    font-weight: bold;
+    padding: 8px;
+    border-radius: 15px;
+    margin: 5px;
+}
+
+.qapi-deprecated::before {
+    content: '⚠️ ';
+}
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 6120515bdc8..b33d9927f4d 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -126,6 +126,7 @@ class QAPIObject(ObjectDescription[Signature]):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": since_validator,
+            "deprecated": directives.flag,
         }
     )
 
@@ -236,6 +237,28 @@ def add_target_and_index(
                     ("single", indextext, node_id, "", None)
                 )
 
+    def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
+        # Add various eye-catches and things that go below the signature
+        # bar, but precede the user-defined content.
+        infopips = nodes.container()
+        infopips.attributes["classes"].append("qapi-infopips")
+
+        def _add_pip(source: str, content: str, classname: str) -> None:
+            node = nodes.container(source)
+            node.append(nodes.Text(content))
+            node.attributes["classes"].extend(["qapi-infopip", classname])
+            infopips.append(node)
+
+        if "deprecated" in self.options:
+            _add_pip(
+                ":deprecated:",
+                f"This {self.objtype} is deprecated.",
+                "qapi-deprecated",
+            )
+
+        if infopips.children:
+            contentnode.insert(0, infopips)
+
     def _merge_adjoining_field_lists(
         self, contentnode: addnodes.desc_content
     ) -> None:
@@ -263,6 +286,7 @@ def _merge_adjoining_field_lists(
             contentnode.remove(child)
 
     def transform_content(self, contentnode: addnodes.desc_content) -> None:
+        self._add_infopips(contentnode)
         self._merge_adjoining_field_lists(contentnode)
 
     def _toc_entry_name(self, sig_node: desc_signature) -> str:
-- 
2.47.0


