Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2D7C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjh-0007lq-VE; Tue, 04 Mar 2025 22:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjf-0007Xo-Mu
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfje-0006D7-0P
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWa8GJCduxWshfwUn3fnT7aU0+/ceVS4gTer/ZEqj08=;
 b=YUaxrCI6Cxve2TxdK1/Ers3UOSvNP+sIpoj7W4SwyTRqWDJ4IVQHbDMNWPiv4iez8XuVZl
 h7AQk2tgQTtSuNzOZ/Hm4MS+yIkOktesJtvTqACE9DsJ/XRDOlG9tQOYf0ehW8jB5S3Zip
 V/ewtVpTzCrzOzuRdSUjqlKHm3/7wW0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-wrR_q2RuPKW30UDgkHrR1g-1; Tue,
 04 Mar 2025 22:47:41 -0500
X-MC-Unique: wrR_q2RuPKW30UDgkHrR1g-1
X-Mimecast-MFC-AGG-ID: wrR_q2RuPKW30UDgkHrR1g_1741146460
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E8DE1800258; Wed,  5 Mar 2025 03:47:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DC6D1956095; Wed,  5 Mar 2025 03:47:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH 23/57] docs/qapi-domain: add :ifcond: directive option
Date: Tue,  4 Mar 2025 22:45:32 -0500
Message-ID: <20250305034610.960147-24-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 docs/sphinx/qapi_domain.py             | 39 ++++++++++++++++++++++++--
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
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index ef4fa978a3a..c75b0e6e22d 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -16,6 +16,7 @@
     NamedTuple,
     Optional,
     Tuple,
+    Union,
     cast,
 )
 
@@ -140,6 +141,7 @@ class QAPIObject(ObjectDescription[Signature]):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": since_validator,
+            "ifcond": directives.unchanged,
             "deprecated": directives.flag,
             "unstable": directives.flag,
         }
@@ -167,6 +169,22 @@ def get_signature_suffix(self) -> List[nodes.Node]:
         """Returns a suffix to put after the object name in the signature."""
         ret: List[nodes.Node] = []
 
+        if "ifcond" in self.options:
+            ret += [
+                SpaceNode(" "),
+                nodes.inline(
+                    self.options["ifcond"],
+                    "",
+                    nodes.Text("["),
+                    nodes.literal("", "#if"),
+                    SpaceNode(" "),
+                    nodes.literal(
+                        self.options["ifcond"], self.options["ifcond"]
+                    ),
+                    nodes.Text("]"),
+                ),
+            ]
+
         if "since" in self.options:
             ret += [
                 SpaceNode(" "),
@@ -261,9 +279,14 @@ def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
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
 
@@ -281,6 +304,18 @@ def _add_pip(source: str, content: str, classname: str) -> None:
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
2.48.1


