Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7094BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1Q-0007WV-Op; Fri, 19 Apr 2024 00:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1O-0007VX-Gr
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1M-0004Et-Jx
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKNkbqrEhzyrsBVuLkNEGiD9G/ACMD1JU77CLaAjtAk=;
 b=YjMkSGrwN1LWF070oNnVL+I820iFzE7IsErj3K6r7BvoWNV6C3MtdhDB70a+M7qQMu9ydJ
 grsZcPLbuYLI/QM234qaesAxW8qpl5DMUtYzGbqBkPmKVhSKWVK7Jk/JU23lP1vEEwPgKS
 51jwr4f9y/S49bxdYJwUCGIvv5QE+B8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-fvgFM1IcMFSyO9LcjMBU8Q-1; Fri,
 19 Apr 2024 00:38:40 -0400
X-MC-Unique: fvgFM1IcMFSyO9LcjMBU8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8316F3CBDF6A;
 Fri, 19 Apr 2024 04:38:40 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D201640829C3;
 Fri, 19 Apr 2024 04:38:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 25/27] docs/qapi-domain: implement error context reporting fix
Date: Fri, 19 Apr 2024 00:38:13 -0400
Message-ID: <20240419043820.178731-26-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
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

Sphinx 5.3.0 to Sphinx 6.2.0 has a bug where nested content in an
ObjectDescription content block has its error position reported
incorrectly due to an oversight when they added nested section support
to this directive.

(This bug is present in Sphinx's own Python and C domains; test it
yourself by creating a py:func directive and creating a syntax error in
the directive's content block.)

To avoid overriding and re-implementing the entirety of the run()
method, a workaround is employed where we parse the content block
ourselves in before_content(), then null the content block to make
Sphinx's own parsing a no-op. Then, in transform_content (which occurs
after Sphinx's nested parse), we simply swap our own parsed content tree
back in for Sphinx's.

It appears a little tricky, but it's the nicest solution I can find.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 074453193ce..7d8911c635f 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -21,7 +21,9 @@
 
 from docutils import nodes
 from docutils.parsers.rst import directives
+from docutils.statemachine import StringList
 
+import sphinx
 from sphinx import addnodes
 from sphinx.addnodes import desc_signature, pending_xref
 from sphinx.directives import ObjectDescription
@@ -470,7 +472,27 @@ def _validate_field(self, field: nodes.field) -> None:
             )
             logger.warning(msg, location=field)
 
+    def before_content(self) -> None:
+        # Work around a sphinx bug and parse the content ourselves.
+        self._temp_content = self.content
+        self._temp_offset = self.content_offset
+        self._temp_node = None
+
+        if sphinx.version_info[:3] >= (5, 3, 0) and sphinx.version_info[:3] < (6, 2, 0):
+            self._temp_node = addnodes.desc_content()
+            self.state.nested_parse(self.content, self.content_offset, self._temp_node)
+            # Sphinx will try to parse the content block itself,
+            # Give it nothingness to parse instead.
+            self.content = StringList()
+            self.content_offset = 0
+
     def transform_content(self, contentnode: addnodes.desc_content) -> None:
+        # Sphinx workaround: Inject our parsed content and restore state.
+        if self._temp_node:
+            contentnode += self._temp_node.children
+            self.content = self._temp_content
+            self.content_offset = self._temp_offset
+
         self._add_infopips(contentnode)
         self._merge_adjoining_field_lists(contentnode)
 
-- 
2.44.0


