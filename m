Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F3C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjY-0006y6-BA; Tue, 04 Mar 2025 22:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjP-0006lq-V0
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjO-0006Ai-4Y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izzwoRTUjt1It3o5vsHMkCHTQ88Kc5AkVwfiriXCANY=;
 b=UK1r21JQ0GvP4xy79nXx6Vok73yb2irFDisuVnXimR6iKpZRx8im3v42BkP11Hwa7px1f8
 NDjNzIMKAL5YnfCljvpJCzt76dRvV+BaWYpktJL69or+pWzdZzDRIVsxqnpe/RwzHpLCNj
 ch17iDxhfL+v5jWXxtVCFS7pXj8g8kk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-5RensmS4MWCQACtVwFjTDw-1; Tue,
 04 Mar 2025 22:47:34 -0500
X-MC-Unique: 5RensmS4MWCQACtVwFjTDw-1
X-Mimecast-MFC-AGG-ID: 5RensmS4MWCQACtVwFjTDw_1741146452
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB4B118001D4; Wed,  5 Mar 2025 03:47:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B09AF1956095; Wed,  5 Mar 2025 03:47:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH 21/57] docs/qapi-domain: add :deprecated: directive option
Date: Tue,  4 Mar 2025 22:45:30 -0500
Message-ID: <20250305034610.960147-22-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 docs/sphinx/qapi_domain.py             | 26 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

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
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index fff5cca24cc..1be59e36bdf 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -140,6 +140,7 @@ class QAPIObject(ObjectDescription[Signature]):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": since_validator,
+            "deprecated": directives.flag,
         }
     )
 
@@ -253,6 +254,31 @@ def add_target_and_index(
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
+    def transform_content(self, content_node: addnodes.desc_content) -> None:
+        self._add_infopips(content_node)
+
     def _toc_entry_name(self, sig_node: desc_signature) -> str:
         # This controls the name in the TOC and on the sidebar.
 
-- 
2.48.1


