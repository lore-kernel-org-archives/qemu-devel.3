Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA6EC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNCs-0001Fn-Qs; Tue, 04 Mar 2025 03:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBZ-00008M-OT
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBX-0003HU-J4
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=+sEz+qKlhBfhwTwh2XVESCntzWnD9G5DdJ/8arWYldE=;
 b=ahqmqvgRrqOn6UYmkvPkysA1SZ8R+TXH4qM1/ipfa/P3ka95pJIZpvr+wPeKPaa78R7E61
 X0C96HASS8FR03YOgiVpQPigUX7dK4gix18uXTtHyZ3aEpS3Q7KrdvSGXJ3xqwY0RSffNx
 HGsDAhfimm10ko/DT7wWqTIunZcTSU4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-AR8dOX0kPfygZbQJzxmBYg-1; Tue,
 04 Mar 2025 02:59:20 -0500
X-MC-Unique: AR8dOX0kPfygZbQJzxmBYg-1
X-Mimecast-MFC-AGG-ID: AR8dOX0kPfygZbQJzxmBYg_1741075160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 107571801A15
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE86B180035F
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 44B3E21E66BB; Tue, 04 Mar 2025 08:59:17 +0100 (CET)
Resent-To: qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:59:17 +0100
Resent-Message-ID: <874j09w7je.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Tue Mar  4 08:43:48 2025
Received: from imap.gmail.com ([2a00:1450:4025:402::6d]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/315750; 04 Mar 2025
 07:43:48 -0000
Received: from blackfin.pond.sub.org
 (p200300d36f33fd00dda5bc774eb05696.dip0.t-ipconnect.de.
 [2003:d3:6f33:fd00:dda5:bc77:4eb0:5696])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485df5asm16957765f8f.96.2025.03.03.23.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 23:21:17 -0800 (PST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 59E2F21E66BB; Tue, 04 Mar 2025 08:21:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL v2 3/5] docs/qapidoc: support header-less freeform sections
Date: Tue,  4 Mar 2025 08:21:15 +0100
Message-ID: <20250304072117.894134-4-armbru@redhat.com>
In-Reply-To: <20250304072117.894134-1-armbru@redhat.com>
References: <20250304072117.894134-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1825647234406137062
X-GMAIL-MSGID: 1825647234406137062
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

The code as written crashes when a free-form documentation block doesn't
start with a heading or subheading, for example:

| ##
| # Just text, no heading.
| ##

The code will attempt to use the `node` variable uninitialized. To fix,
create a generic block to insert the doc text into.

(This patch also removes a lingering pylint warning in the QAPIDoc
implementation that prevents getting a clean baseline to use for
forthcoming additions.)

Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freeform QMP sections)
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250224033741.222749-5-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Test updated to cover this]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py          | 2 ++
 tests/qapi-schema/doc-good.json | 4 ++++
 tests/qapi-schema/doc-good.out  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5f96b46270..5a4d7388b2 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -421,6 +421,8 @@ def freeform(self, doc):
             node = self._start_new_heading(heading, len(leader))
             if text == '':
                 return
+        else:
+            node = nodes.container()
 
         self._parse_text_into_node(text, node)
         self._cur_doc = None
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index f64bf38d85..0a4f139f83 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -11,6 +11,10 @@
 # = Section
 ##
 
+##
+# Just text, no heading.
+##
+
 ##
 # == Subsection
 #
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index ec277be91e..0a9da3efde 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -56,6 +56,9 @@ event EVT_BOXED Object
 doc freeform
     body=
 = Section
+doc freeform
+    body=
+Just text, no heading.
 doc freeform
     body=
 == Subsection
-- 
2.48.1



