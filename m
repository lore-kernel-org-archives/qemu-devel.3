Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3369E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuFc-0005XX-DC; Thu, 12 Dec 2024 20:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFZ-0005Wt-RX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFY-00005n-9t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aaoavp9ghysemEH6EpP4j7s+yMYaBfsbVbrjE+Krvhk=;
 b=ZaDQ2rWtokaHtC4BwUZYJv/EZasnFonEtb8UpPrxwjuvnKK/iMCh9Tzli4lZXf3Rfrfskh
 7lPv+zD+WrKskof+6n4deBrYddQR0hBX5b8bOfH3hh4EY5ITGamuGS+2T4lsLbDHkGTSUs
 bTJt3Tc8Rn1fJdSMVifCeE9XZhj5xIA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-Iv4NDcg-MPO5vpxTcj2Odw-1; Thu,
 12 Dec 2024 20:13:43 -0500
X-MC-Unique: Iv4NDcg-MPO5vpxTcj2Odw-1
X-Mimecast-MFC-AGG-ID: Iv4NDcg-MPO5vpxTcj2Odw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2D3F19560AF; Fri, 13 Dec 2024 01:13:42 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35DC21956086; Fri, 13 Dec 2024 01:13:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 04/35] docs/sphinx: add compat.py module and
 nested_parse helper
Date: Thu, 12 Dec 2024 20:12:33 -0500
Message-ID: <20241213011307.2942030-5-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
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

Create a compat module that handles sphinx cross-version compatibility
issues. For the inaugural function, add a nested_parse() helper that
handles differences in line number tracking for nested directive body
parsing.

Spoilers: there are more cross-version hacks to come throughout the
series.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 docs/sphinx/compat.py

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
new file mode 100644
index 00000000000..4c8d1e94530
--- /dev/null
+++ b/docs/sphinx/compat.py
@@ -0,0 +1,33 @@
+"""
+Sphinx cross-version compatibility goop
+"""
+
+from docutils.nodes import Element
+
+from sphinx.util.docutils import SphinxDirective, switch_source_input
+from sphinx.util.nodes import nested_parse_with_titles
+
+
+def nested_parse(directive: SphinxDirective, content_node: Element) -> None:
+    """
+    This helper preserves error parsing context across sphinx versions.
+    """
+
+    # necessary so that the child nodes get the right source/line set
+    content_node.document = directive.state.document
+
+    try:
+        # Modern sphinx (6.2.0+) supports proper offsetting for
+        # nested parse error context management
+        nested_parse_with_titles(
+            directive.state,
+            directive.content,
+            content_node,
+            content_offset=directive.content_offset,  # type: ignore[call-arg]
+        )
+    except TypeError:
+        # No content_offset argument. Fall back to SSI method.
+        with switch_source_input(directive.state, directive.content):
+            nested_parse_with_titles(
+                directive.state, directive.content, content_node
+            )
-- 
2.47.0


