Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3B4C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC9t-00036v-CQ; Sun, 09 Mar 2025 04:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9j-0002dH-MJ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9h-0002RE-Qj
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tjFF/ym8NRe3BTciRbB7rmmWPy+1jhJqybyCgkHB84=;
 b=dDX4PmUFosuDkwD2kx/BUvt5jyUdqjdjKdug7LTk5P6bOaaiUyVZP3XPl4D41VZm17CEv0
 D5oc7z6DqK+0kCRxXOjGVL0rgppBvoIrjNgdwH+F/LoItAEszl3nwqa/YC5PaslYC5wwWl
 V2XS1cmlkrYhYS97vYaT6zqQGGV20qM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-u0OHiWLEO3yohwG57B7-3Q-1; Sun,
 09 Mar 2025 04:36:59 -0400
X-MC-Unique: u0OHiWLEO3yohwG57B7-3Q-1
X-Mimecast-MFC-AGG-ID: u0OHiWLEO3yohwG57B7-3Q_1741509417
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA944195608A; Sun,  9 Mar 2025 08:36:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6729119560AB; Sun,  9 Mar 2025 08:36:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH v2 25/62] docs/qapi-domain: add :ifcond: directive option
Date: Sun,  9 Mar 2025 04:35:12 -0400
Message-ID: <20250309083550.5155-26-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

The syntax of the argument is currently undefined, but it's possible we
can apply better formatting in the future. Currently, we just display
the ifcond string as preformatted text.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 13 +++++++++++++
 docs/sphinx/qapi_domain.py             | 23 +++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

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
index 4fc9608e170..6f599495e45 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -14,6 +14,7 @@
     NamedTuple,
     Optional,
     Tuple,
+    Union,
     cast,
 )
 
@@ -181,6 +182,7 @@ class QAPIObject(QAPIDescription):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": directives.unchanged,
+            "ifcond": directives.unchanged,
             "deprecated": directives.flag,
             "unstable": directives.flag,
         }
@@ -265,9 +267,14 @@ def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
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
 
@@ -285,6 +292,18 @@ def _add_pip(source: str, content: str, classname: str) -> None:
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


