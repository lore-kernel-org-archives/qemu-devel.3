Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE8FC05023
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1V-0007ZX-Rq; Fri, 19 Apr 2024 00:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1H-0007TY-RN
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1G-0004DW-0u
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IjAMj3TcxONzH6juApwTygBs9hbOUIr24XnNgh7nRc=;
 b=eM1Zq5v09q8OvCN6ulC/aKe2hvAXy/TIsXuOx6ExvNVA6mPltJvpNRvtN4tFFGTuKd5XaZ
 RJQnzJkRHiaFLAxGnNZPaTHcHV9+7lI9SToH+rQQ7uxVooKf4ju47YXSR+J3mHEGDeHjRE
 x8aQtjRn5hfzJSjTOnIzZb5apt07TBI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-pDANlRLQNfuFMp5rcCVxRg-1; Fri,
 19 Apr 2024 00:38:35 -0400
X-MC-Unique: pDANlRLQNfuFMp5rcCVxRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6E261C0C644;
 Fri, 19 Apr 2024 04:38:34 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A1D84011FF7;
 Fri, 19 Apr 2024 04:38:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH 18/27] docs/qapi-domain: add :deprecated: directive option
Date: Fri, 19 Apr 2024 00:38:06 -0400
Message-ID: <20240419043820.178731-19-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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
 docs/qapi/index.rst                    |  4 ++++
 docs/sphinx-static/theme_overrides.css | 25 +++++++++++++++++++++++++
 docs/sphinx/qapi-domain.py             | 24 ++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index d37ceac497f..b9a69f6bd17 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -95,6 +95,7 @@ Explicit cross-referencing syntax for QAPI modules is available with
 
 .. qapi:command:: fake-command
    :since: 13.37
+   :deprecated:
 
    This is a fake command, it's not real. It can't hurt you.
 
@@ -116,6 +117,9 @@ Explicit cross-referencing syntax for QAPI modules is available with
       :arg int64 zzxyz: And this is another argument belonging to that same branch.
 
    :feat hallucination: This command is a figment of your imagination.
+   :feat deprecated: Although this command is fake, you should know that
+      it's also deprecated. That's great news! Maybe it will go away and
+      stop haunting you someday.
    :error CommandNotFound: When you try to use this command, because it
       isn't real.
    :error GenericError: If the system decides it doesn't like the
diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index c70ef951286..97b8c1c60e6 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -159,3 +159,28 @@ div[class^="highlight"] pre {
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
index f0094300c03..065ad501960 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -150,6 +150,7 @@ class QAPIObject(ObjectDescription[Signature]):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": since_validator,
+            "deprecated": directives.flag,
         }
     )
 
@@ -249,6 +250,28 @@ def add_target_and_index(
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
     def _merge_adjoining_field_lists(self, contentnode: addnodes.desc_content) -> None:
         # Take any adjacent field lists and glue them together into
         # one list for further processing by Sphinx. This is done so
@@ -271,6 +294,7 @@ def _merge_adjoining_field_lists(self, contentnode: addnodes.desc_content) -> No
             contentnode.remove(child)
 
     def transform_content(self, contentnode: addnodes.desc_content) -> None:
+        self._add_infopips(contentnode)
         self._merge_adjoining_field_lists(contentnode)
 
     def _toc_entry_name(self, sig_node: desc_signature) -> str:
-- 
2.44.0


