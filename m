Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DEEC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC8v-000115-Kf; Sun, 09 Mar 2025 04:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8n-0000yW-Ft
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8l-00020p-Ll
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44luNu7F9GCwZ4uJBd7DqeH148anqxbJ7YWo9pKmMUY=;
 b=P2KGj0zHzLiorP8IkZ67TPMMqlsARPvFij5Wm/yOpE/bog1IZUYHlsU3dfnrZr3GSX2f4a
 +WwDgh24xMZ740SpSDvZ5qA5fWxxGgGKcbNnhYnhYeFS0k2yrocreo9Ki9yGhB6qqtznx+
 zT8BkbcWoF4H/bJDxoRPTk0PbiAfz+c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-D-krUk26Pveq4uW_6W_jng-1; Sun,
 09 Mar 2025 04:36:03 -0400
X-MC-Unique: D-krUk26Pveq4uW_6W_jng-1
X-Mimecast-MFC-AGG-ID: D-krUk26Pveq4uW_6W_jng_1741509362
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4723180025C; Sun,  9 Mar 2025 08:36:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7DB619560AB; Sun,  9 Mar 2025 08:35:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 04/62] docs/sphinx: add compat.py module and nested_parse
 helper
Date: Sun,  9 Mar 2025 04:34:51 -0400
Message-ID: <20250309083550.5155-5-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Create a compat module that handles sphinx cross-version compatibility
issues. For the inaugural function, add a nested_parse() helper that
handles differences in line number tracking for nested directive body
parsing.

Spoilers: there are more cross-version hacks to come throughout the
series.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 docs/sphinx/compat.py

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
new file mode 100644
index 00000000000..39b859a25e3
--- /dev/null
+++ b/docs/sphinx/compat.py
@@ -0,0 +1,35 @@
+"""
+Sphinx cross-version compatibility goop
+"""
+
+from docutils.nodes import Element
+
+from sphinx.util import nodes
+from sphinx.util.docutils import SphinxDirective, switch_source_input
+
+
+def nested_parse_with_titles(
+    directive: SphinxDirective, content_node: Element
+) -> None:
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
+        nodes.nested_parse_with_titles(
+            directive.state,
+            directive.content,
+            content_node,
+            content_offset=directive.content_offset,
+        )
+    except TypeError:
+        # No content_offset argument. Fall back to SSI method.
+        with switch_source_input(directive.state, directive.content):
+            nodes.nested_parse_with_titles(
+                directive.state, directive.content, content_node
+            )
-- 
2.48.1


