Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC3BC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfiX-0005O4-QL; Tue, 04 Mar 2025 22:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiV-0005NU-1D
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiS-00061v-LQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6TqtdK3QHiRBZKdssAAdRdFK6e5Ug2kJUSKKEhUJck=;
 b=hnCHjsmD3KwMJKygKlpYl74RTQ8wVL1wFlhgrVFm6heslnCRyyc+zPg5sT+deC6GIaz3mf
 oAbrrt9Jx28yqsHarAyBJPEK/O3nzzHSxqBBquaGWWAT3v38nFK87hhXFKJTkwdrrHXL4k
 35gshWXp7XA8GC6q3Pb0cplnC4GRVkk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-EPb44TO7NkiK3dPlDAWejA-1; Tue,
 04 Mar 2025 22:46:33 -0500
X-MC-Unique: EPb44TO7NkiK3dPlDAWejA-1
X-Mimecast-MFC-AGG-ID: EPb44TO7NkiK3dPlDAWejA_1741146390
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2B7519039D0; Wed,  5 Mar 2025 03:46:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D0A01955DDD; Wed,  5 Mar 2025 03:46:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 04/57] docs/sphinx: add compat.py module and nested_parse
 helper
Date: Tue,  4 Mar 2025 22:45:13 -0500
Message-ID: <20250305034610.960147-5-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
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
index 00000000000..792aca10e39
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
+            content_offset=directive.content_offset,
+        )
+    except TypeError:
+        # No content_offset argument. Fall back to SSI method.
+        with switch_source_input(directive.state, directive.content):
+            nested_parse_with_titles(
+                directive.state, directive.content, content_node
+            )
-- 
2.48.1


