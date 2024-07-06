Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04681C38150
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 07:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPzmc-0006wX-Dr; Sat, 06 Jul 2024 03:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzma-0006vd-QY
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmV-0004Z4-S8
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720250664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmqZMdFEKdP70Rpnbs/8ZQGf+j0M3yNoS27MM8SGGzk=;
 b=IkI6YLQEP2sQTBpjQwZ7owkkWm9sYaNdt/1sBCOP1AFoIvGU+OhPsEZEelHhf2skpwdJGA
 IWKeqSmHIlEsyXo0T15y6zEsFJg9xuzB+H9G6zsD+yAd84lgX10n4OjTtYObbqpK42kicc
 smLkvDjbKmUYQ9CAqVNuhUwlJIRI4zU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-hxRyei2bNxuOYf7Q0yMZ0A-1; Sat,
 06 Jul 2024 03:24:22 -0400
X-MC-Unique: hxRyei2bNxuOYf7Q0yMZ0A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C851195608B; Sat,  6 Jul 2024 07:24:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66DB319560AA; Sat,  6 Jul 2024 07:24:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9739821F4B92; Sat,  6 Jul 2024 09:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 06/13] docs/qapidoc: fix nested parsing under untagged sections
Date: Sat,  6 Jul 2024 09:24:09 +0200
Message-ID: <20240706072416.1717485-7-armbru@redhat.com>
In-Reply-To: <20240706072416.1717485-1-armbru@redhat.com>
References: <20240706072416.1717485-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Snow <jsnow@redhat.com>

Sphinx does not like sections without titles, because it wants to
convert every section into a reference. When there is no title, it
struggles to do this and transforms the tree inproperly.

Depending on the rST used, this may result in an assertion error deep in
the docutils HTMLWriter.

(Observed when using ".. admonition:: Notes" under such a section - When
this is transformed with its own <title> element, Sphinx is fooled into
believing this title belongs to the section and incorrect mutates the
docutils tree, leading to errors during rendering time.)

When parsing an untagged section (free paragraphs), skip making a hollow
section and instead append the parse results to the prior section.

Many Bothans died to bring us this information.

The resulting output changes are basically invisible.

Signed-off-by: John Snow <jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240626222128.406106-8-jsnow@redhat.com>
[Mention output changes in commit message]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f9683444b1..efcd84656f 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -272,14 +272,20 @@ def _nodes_for_sections(self, doc):
             if section.tag and section.tag == 'TODO':
                 # Hide TODO: sections
                 continue
+
+            if not section.tag:
+                # Sphinx cannot handle sectionless titles;
+                # Instead, just append the results to the prior section.
+                container = nodes.container()
+                self._parse_text_into_node(section.text, container)
+                nodelist += container.children
+                continue
+
             snode = self._make_section(section.tag)
-            if section.tag and section.tag.startswith('Example'):
+            if section.tag.startswith('Example'):
                 snode += self._nodes_for_example(dedent(section.text))
             else:
-                self._parse_text_into_node(
-                    dedent(section.text) if section.tag else section.text,
-                    snode,
-                )
+                self._parse_text_into_node(dedent(section.text), snode)
             nodelist.append(snode)
         return nodelist
 
-- 
2.45.0


