Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D846C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjE-0005yH-62; Tue, 04 Mar 2025 22:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjA-0005wW-St
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfj9-00068l-Fg
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDXyivQbbnao2sqE7jinSEqJyRZAWAJfzIaOFfRSk2o=;
 b=Fha8Yyg7FQ/Q4ZvV72jwRHJRsSiX0IkBgk2zM2itGuE+HHS+TUk6ulU03qr5qV1FRUWYKV
 GYCT5mxn5zHgBMDHLkbzmWQUwwLoTWTJeTdkRAZ0BgMdFckMRWFi/3yr2G1tufVmyLY4Ee
 O1TOa2xEmoWMI4QqP9FrAV5ggdpzkyg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-ZhXVrGepMXSVBjtoXAzl1g-1; Tue,
 04 Mar 2025 22:47:19 -0500
X-MC-Unique: ZhXVrGepMXSVBjtoXAzl1g-1
X-Mimecast-MFC-AGG-ID: ZhXVrGepMXSVBjtoXAzl1g_1741146438
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DDF51954B19; Wed,  5 Mar 2025 03:47:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F20D71956095; Wed,  5 Mar 2025 03:47:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 17/57] docs/qapi-domain: add qapi:enum directive
Date: Tue,  4 Mar 2025 22:45:26 -0500
Message-ID: <20250305034610.960147-18-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add the .. qapi:enum:: directive, object, and :qapi:enum:`name`
cross-reference role.

Add the :value name: field list for documenting Enum values.

Of note, also introduce a new "type" role that is intended to be used by
other QAPI object directives to cross-reference arbitrary QAPI type
names, but will exclude commands, events, and modules from
consideration.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 7531bdfbba7..66fdeec1d37 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -303,6 +303,23 @@ class QAPICommand(QAPIObject):
     )
 
 
+class QAPIEnum(QAPIObject):
+    """Description of a QAPI Enum."""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            # :value name: descr
+            GroupedField(
+                "value",
+                label=_("Values"),
+                names=("value",),
+                can_collapse=False,
+            )
+        ]
+    )
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -458,9 +475,14 @@ class QAPIDomain(Domain):
     # This table associates cross-reference object types (key) with an
     # ObjType instance, which defines the valid cross-reference roles
     # for each object type.
+    #
+    # e.g., the :qapi:type: cross-reference role can refer to enum,
+    # struct, union, or alternate objects; but :qapi:obj: can refer to
+    # anything. Each object also gets its own targeted cross-reference role.
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "any"),
         "command": ObjType(_("command"), "cmd", "any"),
+        "enum": ObjType(_("enum"), "enum", "type", "any"),
     }
 
     # Each of these provides a rST directive,
@@ -468,6 +490,7 @@ class QAPIDomain(Domain):
     directives = {
         "module": QAPIModule,
         "command": QAPICommand,
+        "enum": QAPIEnum,
     }
 
     # These are all cross-reference roles; e.g.
@@ -476,6 +499,9 @@ class QAPIDomain(Domain):
     roles = {
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
+        "enum": QAPIXRefRole(),
+        # reference any data type (excludes modules, commands, events)
+        "type": QAPIXRefRole(),
         "any": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.48.1


