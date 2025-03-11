Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC39C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsG-0005rA-8P; Tue, 11 Mar 2025 07:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqN-0003Bm-OC
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq4-0006Vf-12
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLZlz2uI650EPNnAM7UdPDCfQjGsEu2vAEr73jJzngE=;
 b=Z+OsSGmQ5QjLsxzVF3uSDzPkkKFrvS7/PiyYRgHaAVhDYRo8UzfGnv4DG1Z9EkOOGIEyxb
 6tREk67FLd3SRgCBgHs48V9nsCWVXt8oJtd2W/+lbewVlwbUIoCdXJKS2+8tfNIqh4vTfe
 O3kHvJ4+aN5dxYR/TljQuLDY+zmG87Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-pZMCyK4yMRenwaK5X38DGA-1; Tue,
 11 Mar 2025 07:31:54 -0400
X-MC-Unique: pZMCyK4yMRenwaK5X38DGA-1
X-Mimecast-MFC-AGG-ID: pZMCyK4yMRenwaK5X38DGA_1741692713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84F0C1956080; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BF331801758; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0F21F21E64AA; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PULL 21/61] docs/qapi-domain: add :deprecated: directive option
Date: Tue, 11 Mar 2025 12:30:57 +0100
Message-ID: <20250311113137.1277125-22-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Although "deprecated" is a feature (and *will* appear in the features
list), add a special :deprecated: option to generate an eye-catch that
makes this information very hard to miss.

The forthcoming Transmogrifier in qapidoc.py will add this option
whenever it detects that the features list attached to a definition
contains the "deprecated" entry.

P.S., I outsourced the CSS ;)

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-24-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 25 +++++++++++++++++++++++++
 docs/sphinx/qapi_domain.py             | 26 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 965ecac54f..3765cab1b2 100644
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
index b11300bc85..b672ae6c50 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -217,6 +217,7 @@ class QAPIObject(QAPIDescription):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": directives.unchanged,
+            "deprecated": directives.flag,
         }
     )
 
@@ -280,6 +281,31 @@ def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
 
         return sig
 
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
 
 class QAPICommand(QAPIObject):
     """Description of a QAPI Command."""
-- 
2.48.1


