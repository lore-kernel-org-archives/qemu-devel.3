Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96D0C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKpl-0003hM-4A; Mon, 14 Jul 2025 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUa-0000IV-Qm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUT-0003bT-Nb
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHlsciI5BUKZnXRO6gudn8/LPPIWdEJXg6XMzCPsXz8=;
 b=GgHlOUSwP5s7RoBsZPdZYuTyPPeetB6mh9VY6hiSGUJArmlHGSS4J4WLXC4UrzTtHsReVK
 WCvY6x9FMsSQh6W5cXSHF+42IVxyawtZEDh2qKmJD4HTEaRUQsbdNuC1qN8nhr0YWkzFYG
 SMaSytypW5Tw61H4jrSpn3rL3d0D4Xc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-TB51Ze7-Mi69HTHKK5H7rg-1; Mon,
 14 Jul 2025 09:45:06 -0400
X-MC-Unique: TB51Ze7-Mi69HTHKK5H7rg-1
X-Mimecast-MFC-AGG-ID: TB51Ze7-Mi69HTHKK5H7rg_1752500705
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 840691956046
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2062B19560A3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAD8C21E676A; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 05/32] qapi: lift restriction on using '=' in doc blocks
Date: Mon, 14 Jul 2025 15:44:31 +0200
Message-ID: <20250714134458.2991097-6-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We reject lines starting with '=' in definition documentation.  This
made sense when such lines were headings in free-form documentation,
but not in definition documentation.

Before the previous commit, lines starting with '=' were headings in
free-form documentation, and rejected in definition documentation,
where such headings could not work.

The previous commit dropped the headings feature from free-form
documentation, because we can simply use plain rST headings.
Rejecting them in definition documentation no longer makes sense, so
drop that, too.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250618165353.1980365-6-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Amend commit message to explain why]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                 |  4 ----
 tests/qapi-schema/doc-bad-section.err  |  1 -
 tests/qapi-schema/doc-bad-section.json | 10 ----------
 tests/qapi-schema/doc-bad-section.out  |  0
 tests/qapi-schema/meson.build          |  1 -
 5 files changed, 16 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-bad-section.err
 delete mode 100644 tests/qapi-schema/doc-bad-section.json
 delete mode 100644 tests/qapi-schema/doc-bad-section.out

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index aad7e249f8..d43a123cd7 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -584,10 +584,6 @@ def get_doc(self) -> 'QAPIDoc':
                         doc.append_line(text)
                     line = self.get_doc_indented(doc)
                     no_more_args = True
-                elif line.startswith('='):
-                    raise QAPIParseError(
-                        self,
-                        "unexpected '=' markup in definition documentation")
                 else:
                     # plain paragraph
                     doc.ensure_untagged_section(self.info)
diff --git a/tests/qapi-schema/doc-bad-section.err b/tests/qapi-schema/doc-bad-section.err
deleted file mode 100644
index 785cacc08c..0000000000
--- a/tests/qapi-schema/doc-bad-section.err
+++ /dev/null
@@ -1 +0,0 @@
-doc-bad-section.json:5:1: unexpected '=' markup in definition documentation
diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/doc-bad-section.json
deleted file mode 100644
index 8175d95867..0000000000
--- a/tests/qapi-schema/doc-bad-section.json
+++ /dev/null
@@ -1,10 +0,0 @@
-# = section within an expression comment
-
-##
-# @Enum:
-# == No good here
-# @one: The _one_ {and only}
-#
-# @two is undocumented
-##
-{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 9577178b6f..c47025d16d 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -61,7 +61,6 @@ schemas = [
   'doc-bad-event-arg.json',
   'doc-bad-feature.json',
   'doc-bad-indent.json',
-  'doc-bad-section.json',
   'doc-bad-symbol.json',
   'doc-bad-union-member.json',
   'doc-before-include.json',
-- 
2.49.0


