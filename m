Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81703C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNCo-0000um-RQ; Tue, 04 Mar 2025 03:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBk-0000Au-37
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBi-0003ID-8F
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=J63+xeMvDp8oP/T4oQACy9QBFnsjVacP1Jp692/Nx7o=;
 b=Cih/DxIrhgoyJ/z1JKzQfYh0Y4AUZyztomd4VlSoDYvY0s0ExwM5/LnRXYlRHK8wETAm5d
 6Yun/+idVRkee5XrWlyuVUGvdP8uphinAqA+SOKiKNzitXTR+OgVzCQxnE+GcjOI0Hna5w
 +DALhg2g9AHY8G1sDmrvXoTQvfv1h88=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-1nQYJtACNzugwREfrZBhYQ-1; Tue,
 04 Mar 2025 02:59:22 -0500
X-MC-Unique: 1nQYJtACNzugwREfrZBhYQ-1
X-Mimecast-MFC-AGG-ID: 1nQYJtACNzugwREfrZBhYQ_1741075161
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 030201944CD1
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACC1619560B9
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C13321E66BC; Tue, 04 Mar 2025 08:59:17 +0100 (CET)
Resent-To: qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:59:17 +0100
Resent-Message-ID: <87zfi1usyy.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Tue Mar  4 08:43:50 2025
Received: from imap.gmail.com ([2a00:1450:4025:402::6d]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/315752; 04 Mar 2025
 07:43:50 -0000
Received: from blackfin.pond.sub.org
 (p200300d36f33fd00dda5bc774eb05696.dip0.t-ipconnect.de.
 [2003:d3:6f33:fd00:dda5:bc77:4eb0:5696])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba538b9fsm221445785e9.17.2025.03.03.23.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 23:21:18 -0800 (PST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DA2F21E66BC; Tue, 04 Mar 2025 08:21:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL v2 4/5] docs/qapidoc: remove example section support
Date: Tue,  4 Mar 2025 08:21:16 +0100
Message-ID: <20250304072117.894134-5-armbru@redhat.com>
In-Reply-To: <20250304072117.894134-1-armbru@redhat.com>
References: <20250304072117.894134-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1825647235709655260
X-GMAIL-MSGID: 1825647235709655260
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Since commit 3c5f6114 (qapi: remove "Example" doc section), Example
sections no longer exist, so this support in qapidoc is now dead code.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250224033741.222749-7-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5a4d7388b2..61997fd21a 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -254,10 +254,6 @@ def _nodes_for_features(self, doc):
         section += dlnode
         return [section]
 
-    def _nodes_for_example(self, exampletext):
-        """Return list of doctree nodes for a code example snippet"""
-        return [nodes.literal_block(exampletext, exampletext)]
-
     def _nodes_for_sections(self, doc):
         """Return list of doctree nodes for additional sections"""
         nodelist = []
@@ -275,10 +271,7 @@ def _nodes_for_sections(self, doc):
                 continue
 
             snode = self._make_section(section.tag)
-            if section.tag.startswith('Example'):
-                snode += self._nodes_for_example(dedent(section.text))
-            else:
-                self._parse_text_into_node(dedent(section.text), snode)
+            self._parse_text_into_node(dedent(section.text), snode)
             nodelist.append(snode)
         return nodelist
 
-- 
2.48.1



