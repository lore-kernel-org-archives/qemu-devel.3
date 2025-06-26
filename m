Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C44C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 19:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUsg3-0000Vn-9m; Thu, 26 Jun 2025 15:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUsg0-0000VH-Dj
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUsfs-00052M-9t
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750967658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2BU92/JmJpPM23SBk9X2BDMvF9ZFlbDcjsOGhUX+UU=;
 b=I9cTfI9jSRI1cEux0Hmpg8DN0d++gURyCIC7dZspzxx/F128qjSeiWBcct5O2BsMJKwsHE
 +xXCgpOKmbMh81qS17r/4ez0eMWqHbpgK/fGZ2jo8/S6RWWQT77kkWCMkJQsZHPNkZGI0F
 sPYy/m/BrNQ6GGjZgDFJ3USp58Z0uXM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-C1c1paxIPIWXHmjP-Cd0BA-1; Thu,
 26 Jun 2025 15:54:14 -0400
X-MC-Unique: C1c1paxIPIWXHmjP-Cd0BA-1
X-Mimecast-MFC-AGG-ID: C1c1paxIPIWXHmjP-Cd0BA_1750967652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E5851955F3E; Thu, 26 Jun 2025 19:54:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.58])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25A3F30002C0; Thu, 26 Jun 2025 19:54:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Jiri Pirko <jiri@resnulli.us>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Lukas Straub <lukasstraub2@web.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 2/4] docs, qapi: generate undocumented return sections
Date: Thu, 26 Jun 2025 15:53:35 -0400
Message-ID: <20250626195337.2158250-3-jsnow@redhat.com>
In-Reply-To: <20250626195337.2158250-1-jsnow@redhat.com>
References: <20250626195337.2158250-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch changes the qapidoc parser to generate stub Return value
documentation for any command that has a return value but does not have
a "Returns:" doc section.

The stubs include just the type name, which will be rendered with a
cross-reference link in the HTML output.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 14 ++++++++------
 scripts/qapi/parser.py | 34 ++++++++++++++++++++++++++++++++++
 scripts/qapi/schema.py |  3 +++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8011ac9efaf..77e28a65cfc 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -255,16 +255,18 @@ def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
     def visit_returns(self, section: QAPIDoc.Section) -> None:
         assert isinstance(self.entity, QAPISchemaCommand)
         rtype = self.entity.ret_type
-        # q_empty can produce None, but we won't be documenting anything
-        # without an explicit return statement in the doc block, and we
-        # should not have any such explicit statements when there is no
-        # return value.
+        # return statements will not be present (and won't be
+        # autogenerated) for any command that doesn't return
+        # *something*, so rtype will always be defined here.
         assert rtype
 
         typ = self.format_type(rtype)
         assert typ
-        assert section.text
-        self.add_field("return", typ, section.text, section.info)
+
+        if section.text:
+            self.add_field("return", typ, section.text, section.info)
+        else:
+            self.add_lines(f":return-nodesc: {typ}", section.info)
 
     def visit_errors(self, section: QAPIDoc.Section) -> None:
         # FIXME: the formatting for errors may be inconsistent and may
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 949d9e8bff7..fc5174e3357 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -815,6 +815,40 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
                                % feature.name)
         self.features[feature.name].connect(feature)
 
+    def ensure_returns(self, info: QAPISourceInfo) -> None:
+
+        def _insert_after_kind(
+            kind: QAPIDoc.Kind,
+            new_sect: QAPIDoc.Section
+        ) -> bool:
+            for sect in filter(lambda sect: sect.kind == kind, reversed(
+                    self.all_sections)):
+                idx = self.all_sections.index(sect) + 1
+                self.all_sections.insert(idx, new_sect)
+                return True
+            return False
+
+        if any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
+            return
+
+        # Stub "Returns" section for undocumented returns value
+        stub = QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
+
+        if any(_insert_after_kind(kind, stub) for kind in (
+                # 1. If arguments, right after those.
+                QAPIDoc.Kind.MEMBER,
+                # 2. Elif errors, right after those.
+                QAPIDoc.Kind.ERRORS,
+                # 3. Elif features, right after those.
+                QAPIDoc.Kind.FEATURE,
+        )):
+            return
+
+        # Otherwise, it should go right after the intro. The intro
+        # is always the first section and is always present (even
+        # when empty), so we can insert directly at index=1 blindly.
+        self.all_sections.insert(1, stub)
+
     def check_expr(self, expr: QAPIExpression) -> None:
         if 'command' in expr:
             if self.returns and 'returns' not in expr:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cbe3b5aa91e..3abddea3525 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1062,6 +1062,9 @@ def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
 
+            if self.ret_type and self.info:
+                doc.ensure_returns(self.info)
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_command(
-- 
2.48.1


