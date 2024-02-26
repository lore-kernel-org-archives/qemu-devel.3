Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A238BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZH-0002o9-GK; Mon, 26 Feb 2024 05:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYi-0002bv-LV
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYc-0003jl-1V
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NasNtuTWkk84bQqZrMVBAZ4AmcnDthULAoF1YQuHW10=;
 b=A4JknY5KzeuQLX8FbI4nCn241ES6w2AMPiYHSSzSfxXgJpwsyGS/T49WDVam+xI3b9uPcl
 t6yG7ZsAEJq6d+QA+ulP7FPSRcQn6HgrAPfYeYcubFXdQFfdAv87cOd0pneBRaBzQPI0PN
 qAUPtm8ooWR/RWt9gg5CokVcsXqZ/Ec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-1wFyqJDbMpWmOpUziqdT3Q-1; Mon, 26 Feb 2024 05:49:57 -0500
X-MC-Unique: 1wFyqJDbMpWmOpUziqdT3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 082B2185A787;
 Mon, 26 Feb 2024 10:49:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD6F44024857;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9537C21E60F3; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/17] qapi: Improve error position for bogus argument
 descriptions
Date: Mon, 26 Feb 2024 11:49:43 +0100
Message-ID: <20240226104954.3781985-7-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When documented arguments don't exist, the error message points to the
beginning of the definition comment.  Point to the first bogus
argument description instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-6-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/parser.py                          | 4 +++-
 tests/qapi-schema/doc-bad-alternate-member.err  | 2 +-
 tests/qapi-schema/doc-bad-boxed-command-arg.err | 2 +-
 tests/qapi-schema/doc-bad-command-arg.err       | 2 +-
 tests/qapi-schema/doc-bad-enum-member.err       | 2 +-
 tests/qapi-schema/doc-bad-event-arg.err         | 2 +-
 tests/qapi-schema/doc-bad-feature.err           | 2 +-
 tests/qapi-schema/doc-bad-union-member.err      | 2 +-
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 88221b3c64..82db595dcf 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -472,6 +472,8 @@ class Section:
         # pylint: disable=too-few-public-methods
         def __init__(self, parser: QAPISchemaParser,
                      name: Optional[str] = None):
+            # section source info, i.e. where it begins
+            self.info = parser.info
             # parser, for error messages about indentation
             self._parser = parser
             # optional section name (argument/member or section name)
@@ -770,7 +772,7 @@ def check_args_section(
                      if not section.member]
             if bogus:
                 raise QAPISemError(
-                    self.info,
+                    args[bogus[0]].info,
                     "documented %s%s '%s' %s not exist" % (
                         what,
                         "s" if len(bogus) > 1 else "",
diff --git a/tests/qapi-schema/doc-bad-alternate-member.err b/tests/qapi-schema/doc-bad-alternate-member.err
index d7286bb57c..1f6b7d2fe4 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.err
+++ b/tests/qapi-schema/doc-bad-alternate-member.err
@@ -1 +1 @@
-doc-bad-alternate-member.json:3: documented members 'aa', 'bb' do not exist
+doc-bad-alternate-member.json:7: documented members 'aa', 'bb' do not exist
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.err b/tests/qapi-schema/doc-bad-boxed-command-arg.err
index 7137af3ec9..d6793e7fd8 100644
--- a/tests/qapi-schema/doc-bad-boxed-command-arg.err
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.err
@@ -1 +1 @@
-doc-bad-boxed-command-arg.json:9: documented member 'a' does not exist
+doc-bad-boxed-command-arg.json:11: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-command-arg.err b/tests/qapi-schema/doc-bad-command-arg.err
index 18ed076cef..b76167ec60 100644
--- a/tests/qapi-schema/doc-bad-command-arg.err
+++ b/tests/qapi-schema/doc-bad-command-arg.err
@@ -1 +1 @@
-doc-bad-command-arg.json:3: documented member 'b' does not exist
+doc-bad-command-arg.json:6: documented member 'b' does not exist
diff --git a/tests/qapi-schema/doc-bad-enum-member.err b/tests/qapi-schema/doc-bad-enum-member.err
index 7efeb47363..0aa8d8e8e2 100644
--- a/tests/qapi-schema/doc-bad-enum-member.err
+++ b/tests/qapi-schema/doc-bad-enum-member.err
@@ -1 +1 @@
-doc-bad-enum-member.json:3: documented member 'a' does not exist
+doc-bad-enum-member.json:5: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-event-arg.err b/tests/qapi-schema/doc-bad-event-arg.err
index d13cacf21f..90527d5f82 100644
--- a/tests/qapi-schema/doc-bad-event-arg.err
+++ b/tests/qapi-schema/doc-bad-event-arg.err
@@ -1 +1 @@
-doc-bad-event-arg.json:3: documented member 'a' does not exist
+doc-bad-event-arg.json:5: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-feature.err b/tests/qapi-schema/doc-bad-feature.err
index 49d1746c3d..3166c6a305 100644
--- a/tests/qapi-schema/doc-bad-feature.err
+++ b/tests/qapi-schema/doc-bad-feature.err
@@ -1 +1 @@
-doc-bad-feature.json:3: documented feature 'a' does not exist
+doc-bad-feature.json:7: documented feature 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-schema/doc-bad-union-member.err
index 6dd2726a65..cdf1225cab 100644
--- a/tests/qapi-schema/doc-bad-union-member.err
+++ b/tests/qapi-schema/doc-bad-union-member.err
@@ -1 +1 @@
-doc-bad-union-member.json:3: documented members 'a', 'b' do not exist
+doc-bad-union-member.json:5: documented members 'a', 'b' do not exist
-- 
2.43.0


