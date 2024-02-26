Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B2C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZD-0002km-I1; Mon, 26 Feb 2024 05:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYg-0002bb-DJ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYZ-0003iu-Uj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyTe3JJVicR2YT26xqzTwUPaKmO95AOFbOEBCZXay6s=;
 b=SmL2/1JnuwGDj1ahGDxI1mvDFS5RTugVYWWCpnoUWAvbz/21nRVWAKlxSdIzezxlADbL7P
 1jmW2TupEgwVBrNO4Yoj8+SlPIs6B5aARXKQ0HK/s5I0qd6eBrINPk0dq3q8lF6AO6E2jX
 WOOCzDXgQhucfTbdXIEOWaD+FPVQoIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Uk8jxVzeNcKiPai55bkwBA-1; Mon, 26 Feb 2024 05:49:57 -0500
X-MC-Unique: Uk8jxVzeNcKiPai55bkwBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08EDF85A599;
 Mon, 26 Feb 2024 10:49:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB931C060B1;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9AE4D21E60F5; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/17] qapi: Improve error message for empty doc sections
Date: Mon, 26 Feb 2024 11:49:45 +0100
Message-ID: <20240226104954.3781985-9-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Improve the message for an empty tagged section from

    empty doc section 'Note'

to

    text required after 'Note:'

and the message for an empty argument or feature description from

    empty doc section 'foo'

to

    text required after '@foo:'

Improve the error position to refer to the beginning of the empty
section instead of its end.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-8-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/sphinx/qapidoc.py                  |  4 ++--
 scripts/qapi/parser.py                  | 14 +++++++-------
 tests/qapi-schema/doc-empty-section.err |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 488de23d72..1e8b4a70a1 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -239,8 +239,8 @@ def _nodes_for_features(self, doc):
         seen_item = False
         dlnode = nodes.definition_list()
         for section in doc.features.values():
-            dlnode += self._make_dlitem([nodes.literal('', section.name)],
-                                        section.text)
+            dlnode += self._make_dlitem(
+                [nodes.literal('', section.member.name)], section.text)
             seen_item = True
 
         if not seen_item:
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index a771013959..43daf55860 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -476,9 +476,9 @@ def __init__(self, parser: QAPISchemaParser,
             self.info = parser.info
             # parser, for error messages about indentation
             self._parser = parser
-            # optional section name (argument/member or section name)
+            # section tag, if any ('Returns', '@name', ...)
             self.name = name
-            # section text without section name
+            # section text without tag
             self.text = ''
             # indentation to strip (None means indeterminate)
             self._indent = None if self.name else 0
@@ -700,7 +700,7 @@ def _start_symbol_section(
             raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name)
         assert not self.sections
-        new_section = QAPIDoc.ArgSection(self._parser, name)
+        new_section = QAPIDoc.ArgSection(self._parser, '@' + name)
         self._switch_section(new_section)
         symbols_dict[name] = new_section
 
@@ -727,9 +727,9 @@ def _switch_section(self, new_section: 'QAPIDoc.Section') -> None:
             # We do not create anonymous sections unless there is
             # something to put in them; this is a parser bug.
             assert self._section.name
-            raise QAPIParseError(
-                self._parser,
-                "empty doc section '%s'" % self._section.name)
+            raise QAPISemError(
+                self._section.info,
+                "text required after '%s:'" % self._section.name)
 
         self._section = new_section
 
@@ -748,7 +748,7 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
             self.args[member.name] = QAPIDoc.ArgSection(self._parser,
-                                                        member.name)
+                                                        '@' + member.name)
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/doc-empty-section.err
index ba7ba70125..5f03a6d733 100644
--- a/tests/qapi-schema/doc-empty-section.err
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -1 +1 @@
-doc-empty-section.json:7:1: empty doc section 'Note'
+doc-empty-section.json:6: text required after 'Note:'
-- 
2.43.0


