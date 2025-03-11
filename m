Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D78C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqWj-0003m8-Sm; Mon, 10 Mar 2025 23:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWi-0003lh-UE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWh-0002AQ-D5
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5zzCAWIkGKW0tazmeY1djTKO1+sjcFFugAG566ztEw=;
 b=RBWBqLZ+qH6oPKBIA1A4i0iMsYXzDEuFRqV3pQ3BpIoD7ncHeCGrekvVDWXRavYS2AL9b4
 jkC6wysphFrz5vTfOnOqm0en0xlQPteNqkIJ8QlYguJAG6RQM+xfUodqkipgA/D0kQyRnz
 yRnhFfs2m1Wo+r861T8OBa9pPiOfc1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-p8cQJGfaNzaXuD2ZHYJTkA-1; Mon,
 10 Mar 2025 23:43:25 -0400
X-MC-Unique: p8cQJGfaNzaXuD2ZHYJTkA-1
X-Mimecast-MFC-AGG-ID: p8cQJGfaNzaXuD2ZHYJTkA_1741664604
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D08E71956083; Tue, 11 Mar 2025 03:43:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF8AC1828A81; Tue, 11 Mar 2025 03:43:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 04/63] docs/sphinx: add compat.py module and nested_parse
 helper
Date: Mon, 10 Mar 2025 23:42:02 -0400
Message-ID: <20250311034303.75779-5-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Create a compat module that handles sphinx cross-version compatibility
issues. For the inaugural function, add a nested_parse_with_titles()
helper that handles differences in line number tracking for nested
directive body parsing.

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


