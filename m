Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AC1C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWtX-0003cd-N0; Wed, 26 Mar 2025 15:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWtW-0003cF-8F
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWtP-0008Jc-7R
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743019105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+avvLviL1lhqFMOkXfK5uP0Mq2C02pzxBoyfJcOSBmo=;
 b=hCu+z5OUMVHDY7Negm21XLjnNH8eZwSR7su2NNpQhRcqVx3FuSbjnr+sU6RH51vakJk4e0
 /JPNoXJ1Y8ubGyS+9D61eZWmCczolWb74ZHxprJIbyTMa6rTceKBop4U1l8Uv8HjyF2Y0A
 OzBzNrrJjUNS6zhwwusAVtkYW/En0zI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-msUdRV8uNmaoT_eHQ-YYXw-1; Wed,
 26 Mar 2025 15:58:22 -0400
X-MC-Unique: msUdRV8uNmaoT_eHQ-YYXw-1
X-Mimecast-MFC-AGG-ID: msUdRV8uNmaoT_eHQ-YYXw_1743019099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 482791800260; Wed, 26 Mar 2025 19:58:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.152])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24A44180175A; Wed, 26 Mar 2025 19:58:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Hanna Reitz <hreitz@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v2 2/4] docs, qapi: generate undocumented return sections
Date: Wed, 26 Mar 2025 15:57:54 -0400
Message-ID: <20250326195756.330817-3-jsnow@redhat.com>
In-Reply-To: <20250326195756.330817-1-jsnow@redhat.com>
References: <20250326195756.330817-1-jsnow@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 0930307bc73..aaf9921c06c 100644
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


