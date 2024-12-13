Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85807E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGu-0008JL-7P; Thu, 12 Dec 2024 20:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGo-0007yh-KJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGf-0000hy-M3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsM1OIJt181TdMGUiq9c24NHPTZFUCynBtcB5irAS+k=;
 b=hhg0TKnyeq3qL16Jyw0Bx3ULribhLKOnR3fPyy140jAFGR5caAGSCd/BeKGjvzYNJAJew4
 qEIzW6famgTThmpFnV/nCMmINGfxnyKvkLJKY2hjzD28t+hShL3lsor/LF/EQ7vFy/KJjH
 0wG8teZbh+MVukAlDU08WyQOD98UBLU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-Eu7c0v-JNieCNvZcJNfpfA-1; Thu,
 12 Dec 2024 20:14:51 -0500
X-MC-Unique: Eu7c0v-JNieCNvZcJNfpfA-1
X-Mimecast-MFC-AGG-ID: Eu7c0v-JNieCNvZcJNfpfA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1375619560B7; Fri, 13 Dec 2024 01:14:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25CFE1956086; Fri, 13 Dec 2024 01:14:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [RFC PATCH v2 25/35] docs/qapi-domain: add :ifcond: directive option
Date: Thu, 12 Dec 2024 20:12:54 -0500
Message-ID: <20241213011307.2942030-26-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 docs/sphinx-static/theme_overrides.css | 13 +++++++++
 docs/sphinx/qapi-domain.py             | 39 ++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 5f58f1d5246..3fd326613d9 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -237,3 +237,16 @@ div[class^="highlight"] pre {
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
index e522102ab7c..f7c7aaa507f 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -15,6 +15,7 @@
     NamedTuple,
     Optional,
     Tuple,
+    Union,
     cast,
 )
 
@@ -126,6 +127,7 @@ class QAPIObject(ObjectDescription[Signature]):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": since_validator,
+            "ifcond": directives.unchanged,
             "deprecated": directives.flag,
             "unstable": directives.flag,
         }
@@ -153,6 +155,22 @@ def get_signature_suffix(self, sig: str) -> List[nodes.Node]:
         """Returns a suffix to put after the object name in the signature."""
         ret: List[nodes.Node] = []
 
+        if "ifcond" in self.options:
+            ret += [
+                space_node(" "),
+                nodes.inline(
+                    self.options["ifcond"],
+                    "",
+                    nodes.Text("["),
+                    nodes.literal("", "#if"),
+                    space_node(" "),
+                    nodes.literal(
+                        self.options["ifcond"], self.options["ifcond"]
+                    ),
+                    nodes.Text("]"),
+                ),
+            ]
+
         if "since" in self.options:
             ret += [
                 space_node(" "),
@@ -244,9 +262,14 @@ def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
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
 
@@ -264,6 +287,18 @@ def _add_pip(source: str, content: str, classname: str) -> None:
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
2.47.0


