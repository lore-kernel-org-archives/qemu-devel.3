Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059A1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1V-0007Yv-1I; Fri, 19 Apr 2024 00:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1L-0007UQ-GO
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1J-0004EK-HT
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AF5xLvH/7kUiAUGkLwfvULf0scJbtE7oAdCJfc0wnYA=;
 b=b3qnFF05XfKh8cuvOc52Hi50D1knh/1BEl4WiIOZTYOPcdmEtIXxI54gQmt2KVEb2wtTc7
 AZ1siT4uSHUxcQ6QdCTvrry7Tp4vNm953+2kwj4vHLEstLI2ViFMxNxQmNXgoZmASLNVcq
 mGy9D23NqiBuGl4a/6xPBSHUyfXiZqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-t2rsuqBpMReC0fC-FFKYmg-1; Fri, 19 Apr 2024 00:38:37 -0400
X-MC-Unique: t2rsuqBpMReC0fC-FFKYmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD240830E76;
 Fri, 19 Apr 2024 04:38:36 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D2C14011FF7;
 Fri, 19 Apr 2024 04:38:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH 20/27] docs/qapi-domain: add :ifcond: directive option
Date: Fri, 19 Apr 2024 00:38:08 -0400
Message-ID: <20240419043820.178731-21-jsnow@redhat.com>
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

Add a special :ifcond: option that allows us to annotate the
definition-level conditionals.

RFC: This patch renders IFCOND information in two places, because I'm
undecided about how to style this information. One option is in the
signature bar, and another option is in an eye-catch, like :deprecated:
or :unstable:.

A benefit to having this be a directive option is that we can put it in
the signature bar, the QAPI index, etc. However, if we merely want it in
the content section, a directive would work just as well,
e.g. ".. qapi:ifcond:: CONFIG_LINUX".

(Though, having it be in the same containing box as the unstable/ifcond
boxes might require some extra fiddling/post-processing to
achieve. Generally, the less docutils tree muddling I have to do, the
happier I am.)

The syntax of the argument is currently undefined, but it is possible to
parse it back down into constituent parts to avoid applying literal
formatting to "AND" or "&&" or whichever syntax we formalize. (Or, in
the future, applying cross-reference links to the config values for
additional reading on some of those build options. Not for this series.)

"Vote now on your phones!"

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst                    |  1 +
 docs/sphinx-static/theme_overrides.css | 13 +++++++++
 docs/sphinx/qapi-domain.py             | 37 ++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 6350791a3ed..c68e2044890 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -97,6 +97,7 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :since: 13.37
    :deprecated:
    :unstable:
+   :ifcond: CONFIG_LINUX
 
    This is a fake command, it's not real. It can't hurt you.
 
diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index acdf11675db..b239a762a9e 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -188,3 +188,16 @@ div[class^="highlight"] pre {
 .qapi-deprecated::before {
     content: '⚠️ ';
 }
+
+.qapi-ifcond::before {
+    /* gaze ye into the crystal ball to determine feature availability */
+    content: '🔮 ';
+}
+
+.qapi-ifcond {
+    background-color: #f9f5ff;
+    border: solid #dac2ff 6px;
+    padding: 8px;
+    border-radius: 15px;
+    margin: 5px;
+}
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 76157476e02..e44db10488f 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -15,6 +15,7 @@
     NamedTuple,
     Optional,
     Tuple,
+    Union,
     cast,
 )
 
@@ -150,6 +151,7 @@ class QAPIObject(ObjectDescription[Signature]):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": since_validator,
+            "ifcond": directives.unchanged,
             "deprecated": directives.flag,
             "unstable": directives.flag,
         }
@@ -176,6 +178,20 @@ def get_signature_suffix(self, sig: str) -> List[nodes.Node]:
         """Returns a suffix to put after the object name in the signature."""
         ret: List[nodes.Node] = []
 
+        if "ifcond" in self.options:
+            ret += [
+                addnodes.desc_sig_space(),
+                nodes.inline(
+                    self.options["ifcond"],
+                    "",
+                    nodes.Text("["),
+                    nodes.literal("", "#if"),
+                    addnodes.desc_sig_space(),
+                    nodes.literal(self.options["ifcond"], self.options["ifcond"]),
+                    nodes.Text("]"),
+                ),
+            ]
+
         if "since" in self.options:
             ret += [
                 addnodes.desc_sig_space(),
@@ -257,9 +273,14 @@ def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
         infopips = nodes.container()
         infopips.attributes["classes"].append("qapi-infopips")
 
-        def _add_pip(source: str, content: str, classname: str) -> None:
+        def _add_pip(
+            source: str, content: Union[str, List[nodes.Node]], classname: str
+        ) -> None:
             node = nodes.container(source)
-            node.append(nodes.Text(content))
+            if isinstance(content, str):
+                node.append(nodes.Text(content))
+            else:
+                node.extend(content)
             node.attributes["classes"].extend(["qapi-infopip", classname])
             infopips.append(node)
 
@@ -277,6 +298,18 @@ def _add_pip(source: str, content: str, classname: str) -> None:
                 "qapi-unstable",
             )
 
+        if self.options.get("ifcond", ""):
+            ifcond = self.options["ifcond"]
+            _add_pip(
+                f":ifcond: {ifcond}",
+                [
+                    nodes.emphasis("", "Availability"),
+                    nodes.Text(": "),
+                    nodes.literal(ifcond, ifcond),
+                ],
+                "qapi-ifcond",
+            )
+
         if infopips.children:
             contentnode.insert(0, infopips)
 
-- 
2.44.0


