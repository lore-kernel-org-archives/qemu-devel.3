Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F05FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGT-0006Vk-RC; Thu, 12 Dec 2024 20:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGI-00068a-WD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGF-0000fw-KP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uelnq1KNF+xgRsYXr6SFESLtd2hWdEYOYf8k2zY/hTI=;
 b=I7yEmepTLuTYbM/1+Tvh8Ha6eEerMaqla4+D/CyI/6MwiFBXOp/d6Xbtkj2dH5R3DpTR1l
 kOoMl3EsvxEvCqQKhnew5HbpjKxcNGWnUdu18iRP54fUuz1M1O45bFtEmW6MdfX5AVwMOb
 AtPCqjFSJEbiamoQn5SyaxG8Y/hihYw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494--XK2qujlP2CEpHExN2Wr3A-1; Thu,
 12 Dec 2024 20:14:26 -0500
X-MC-Unique: -XK2qujlP2CEpHExN2Wr3A-1
X-Mimecast-MFC-AGG-ID: -XK2qujlP2CEpHExN2Wr3A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E54519560B2; Fri, 13 Dec 2024 01:14:25 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30FE31956086; Fri, 13 Dec 2024 01:14:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 18/35] docs/qapi-domain: add qapi:enum directive
Date: Thu, 12 Dec 2024 20:12:47 -0500
Message-ID: <20241213011307.2942030-19-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 docs/sphinx/qapi-domain.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index c46c87168bd..e37e300e4e6 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -287,6 +287,23 @@ class QAPICommand(QAPIObject):
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
@@ -440,9 +457,14 @@ class QAPIDomain(Domain):
     # This table associates cross-reference object types (key) with an
     # ObjType instance, which defines the valid cross-reference roles
     # for each object type.
+    #
+    # e.g., the :qapi:type: cross-reference role can refer to enum,
+    # struct, union, or alternate objects; but :qapi:obj: can refer to
+    # anything. Each object also gets its own targeted cross-reference role.
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "obj"),
         "command": ObjType(_("command"), "cmd", "obj"),
+        "enum": ObjType(_("enum"), "enum", "obj", "type"),
     }
 
     # Each of these provides a rST directive,
@@ -450,6 +472,7 @@ class QAPIDomain(Domain):
     directives = {
         "module": QAPIModule,
         "command": QAPICommand,
+        "enum": QAPIEnum,
     }
 
     # These are all cross-reference roles; e.g.
@@ -458,6 +481,9 @@ class QAPIDomain(Domain):
     roles = {
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
+        "enum": QAPIXRefRole(),
+        # reference any data type (excludes modules, commands, events)
+        "type": QAPIXRefRole(),
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.47.0


