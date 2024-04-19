Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CFCC05023
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1V-0007ZU-L7; Fri, 19 Apr 2024 00:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1K-0007UJ-3M
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1I-0004E5-El
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYQSZakUdyxax3fEvSg4ELSQbAzBJgzgMMYPGKLJpy4=;
 b=T1m/3L/tVpPx13TZpqCD0z2ADtlFPYCM01Dbx3CKfQgatzTkLE2lwXxThDRks0r4mqk8eR
 Pv6SXGJqyB2p3ROu4vcmXr8JqssaWyLnV9wVTUmWs3zNVhX6dk4AwPL/vhZ97BU3zP+OWq
 oMASlOHe5GlmkPjXe7NLeABM3k0xdEI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-cai7qDqoMhuJfyVEgPBCjQ-1; Fri,
 19 Apr 2024 00:38:36 -0400
X-MC-Unique: cai7qDqoMhuJfyVEgPBCjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F4B21C0C652;
 Fri, 19 Apr 2024 04:38:36 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01F8C40829C3;
 Fri, 19 Apr 2024 04:38:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH 19/27] docs/qapi-domain: add :unstable: directive option
Date: Fri, 19 Apr 2024 00:38:07 -0400
Message-ID: <20240419043820.178731-20-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Although "unstable" is a feature (and *will* appear in the features
list), add a special :unstable: option to generate an eye-catch that
makes this information very hard to miss.

(The intent is to modify qapidoc.py to add this option whenever it
detects that the features list attached to a definition contains the
"unstable" entry.)

RFC: Same comments as last patch.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst                    | 4 +++-
 docs/sphinx-static/theme_overrides.css | 6 +++++-
 docs/sphinx/qapi-domain.py             | 8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index b9a69f6bd17..6350791a3ed 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -96,13 +96,13 @@ Explicit cross-referencing syntax for QAPI modules is available with
 .. qapi:command:: fake-command
    :since: 13.37
    :deprecated:
+   :unstable:
 
    This is a fake command, it's not real. It can't hurt you.
 
    :arg int foo: normal parameter documentation.
    :arg str bar: Another normal parameter description.
    :arg baz: Missing a type.
-   :feat unstable: More than unstable, this command doesn't even exist!
    :arg no-descr:
    :arg BitmapSyncMode discrim: How about branches in commands?
 
@@ -120,6 +120,8 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :feat deprecated: Although this command is fake, you should know that
       it's also deprecated. That's great news! Maybe it will go away and
       stop haunting you someday.
+   :feat unstable: This command, as a figment of your imagination, is
+      highly unstable and should not be relied upon.
    :error CommandNotFound: When you try to use this command, because it
       isn't real.
    :error GenericError: If the system decides it doesn't like the
diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 97b8c1c60e6..acdf11675db 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -172,7 +172,7 @@ div[class^="highlight"] pre {
     margin: 0.25em;
 }
 
-.qapi-deprecated {
+.qapi-deprecated,.qapi-unstable {
     background-color: #fffef5;
     border: solid #fff176 6px;
     font-weight: bold;
@@ -181,6 +181,10 @@ div[class^="highlight"] pre {
     margin: 5px;
 }
 
+.qapi-unstable::before {
+    content: '🚧 ';
+}
+
 .qapi-deprecated::before {
     content: '⚠️ ';
 }
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 065ad501960..76157476e02 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -151,6 +151,7 @@ class QAPIObject(ObjectDescription[Signature]):
             # These are QAPI originals:
             "since": since_validator,
             "deprecated": directives.flag,
+            "unstable": directives.flag,
         }
     )
 
@@ -269,6 +270,13 @@ def _add_pip(source: str, content: str, classname: str) -> None:
                 "qapi-deprecated",
             )
 
+        if "unstable" in self.options:
+            _add_pip(
+                ":unstable:",
+                f"This {self.objtype} is unstable/experimental.",
+                "qapi-unstable",
+            )
+
         if infopips.children:
             contentnode.insert(0, infopips)
 
-- 
2.44.0


