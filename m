Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07720C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJjEX-0006eD-TA; Tue, 18 Jun 2024 20:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjEW-0006as-8f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjEU-0001Qi-RV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718757086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKn8SIxGob2pKMM70MaK6Zu4lcrmGDuuPfEZ9b3S+uQ=;
 b=SpJWRUGht3tE81yX0TJpPKN0zmw8AySpTbAzHFY/zEHpoCvRREdtO2GxVlMz6yFMYZ/ujf
 wlhnEzYfsivsNoYLb2KjlfFhW5GzRf6D14wGqexJjHqCaAdMGLxN9cpAZXd1wu6FMSTMRs
 RTikvAPY8EgPtVqDbLrpaRxqLH6eX3s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-4OkzGxRBOvGFq_PlNjrGvQ-1; Tue,
 18 Jun 2024 20:31:23 -0400
X-MC-Unique: 4OkzGxRBOvGFq_PlNjrGvQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E40319560B2; Wed, 19 Jun 2024 00:31:20 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.16.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F122A1955E80; Wed, 19 Jun 2024 00:31:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 06/13] docs/qapidoc: fix nested parsing under untagged sections
Date: Tue, 18 Jun 2024 20:30:05 -0400
Message-ID: <20240619003012.1753577-7-jsnow@redhat.com>
In-Reply-To: <20240619003012.1753577-1-jsnow@redhat.com>
References: <20240619003012.1753577-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f2f2005dd5f..66cf254a624 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -286,14 +286,20 @@ def _nodes_for_sections(self, doc):
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
2.44.0


