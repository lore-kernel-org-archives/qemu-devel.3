Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C6C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqX1-0003s1-90; Mon, 10 Mar 2025 23:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWz-0003rb-8o
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWx-0002D2-Up
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1a5/4wZHQidpPpjyG2c9xx8eYMEhq8brGYPtmbVtwI=;
 b=U+77yKyoMNrOVVw5xizHFctoCUkdgO/+fArCw9M/Fo77Bd++ZTFfVNA5f8IMfa9n1kUnK+
 1QtupbSUEPysye4VAj3aQsG4GnJmiILmhjSBdjAuZhSXpgLqkOLugVb+56NWzV5cpQ8Bjg
 PUYwKfDyd7fuQ0WIanngkIYvg3SSX8Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-ZZ-BU2qYNxmysLJ6BoAdGw-1; Mon,
 10 Mar 2025 23:43:43 -0400
X-MC-Unique: ZZ-BU2qYNxmysLJ6BoAdGw-1
X-Mimecast-MFC-AGG-ID: ZZ-BU2qYNxmysLJ6BoAdGw_1741664622
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B167B1801A00; Tue, 11 Mar 2025 03:43:42 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB3B51828A89; Tue, 11 Mar 2025 03:43:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 09/63] docs/qapi-domain: add compatibility node classes
Date: Mon, 10 Mar 2025 23:42:07 -0400
Message-ID: <20250311034303.75779-10-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Sphinx prior to v4.0 uses different classes for rendering elements of
documentation objects; add some compatibility classes to use the right
node classes conditionally.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 39b859a25e3..6bc698c5ada 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -2,12 +2,27 @@
 Sphinx cross-version compatibility goop
 """
 
-from docutils.nodes import Element
+from typing import Callable
 
+from docutils.nodes import Element, Node, Text
+
+import sphinx
+from sphinx import addnodes
 from sphinx.util import nodes
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 
 
+SpaceNode: Callable[[str], Node]
+KeywordNode: Callable[[str, str], Node]
+
+if sphinx.version_info[:3] >= (4, 0, 0):
+    SpaceNode = addnodes.desc_sig_space
+    KeywordNode = addnodes.desc_sig_keyword
+else:
+    SpaceNode = Text
+    KeywordNode = addnodes.desc_annotation
+
+
 def nested_parse_with_titles(
     directive: SphinxDirective, content_node: Element
 ) -> None:
-- 
2.48.1


