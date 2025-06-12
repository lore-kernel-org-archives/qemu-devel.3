Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E623AC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 21:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPphI-0001lh-Fw; Thu, 12 Jun 2025 17:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPph5-0001ba-FX
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPph3-0007RC-Qt
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749764561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fA8iNN1LwEHSlpRiWf75slmpOQWaEBgpIFanj9juOH8=;
 b=FJs23e4uAJqsJrFlVS3IwCgc1S8Dmbvd9HcJH/9cF8/tQnL0CCvgY7OJOtBTfxvpmb9pLA
 PNpH3QvCmBCwP9h+eQJTO0PTqOmRxP8JLtLnqB/+1XoWhgdvWPPCQ5+yZ+twUVgVl08yRv
 P81/Z4wbzLkeTUbPBbn+7AyODFO/oag=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-Ms2Q4TkVNGarV5WGLcyDZQ-1; Thu,
 12 Jun 2025 17:42:37 -0400
X-MC-Unique: Ms2Q4TkVNGarV5WGLcyDZQ-1
X-Mimecast-MFC-AGG-ID: Ms2Q4TkVNGarV5WGLcyDZQ_1749764555
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE7F119560AA; Thu, 12 Jun 2025 21:42:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.54])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A7EE18003FC; Thu, 12 Jun 2025 21:42:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Mads Ynddal <mads@ynddal.dk>,
 Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v4 2/4] docs, qapi: generate undocumented return sections
Date: Thu, 12 Jun 2025 17:41:58 -0400
Message-ID: <20250612214200.1208340-3-jsnow@redhat.com>
In-Reply-To: <20250612214200.1208340-1-jsnow@redhat.com>
References: <20250612214200.1208340-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

This patch changes the qapidoc transmogrifier to generate Return value
documentation for any command that has a return value but hasn't
explicitly documented that return value.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 14 ++++++++------
 scripts/qapi/parser.py | 15 +++++++++++++++
 scripts/qapi/schema.py |  3 +++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8011ac9efaf..627d0b5ff1a 100644
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
+        # *something*, so ret_type will always be defined here.
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
index 949d9e8bff7..6db08f82409 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -815,6 +815,21 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
                                % feature.name)
         self.features[feature.name].connect(feature)
 
+    def ensure_returns(self, info: QAPISourceInfo) -> None:
+        if not any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
+
+            stub = QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
+
+            # Stub "Returns" section for undocumented returns value.
+            # Insert stub after the last non-PLAIN section.
+            for sect in reversed(self.all_sections):
+                if sect.kind != QAPIDoc.Kind.PLAIN:
+                    idx = self.all_sections.index(sect) + 1
+                    self.all_sections.insert(idx, stub)
+                    break
+            else:
+                self.all_sections.append(stub)
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


