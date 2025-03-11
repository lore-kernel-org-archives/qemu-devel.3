Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C2CC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqXx-0005KU-58; Mon, 10 Mar 2025 23:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqXZ-0004PS-0f
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqXX-0002I0-Hb
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooI77YwcATLRfmlWDT+D58cwnENu7CarMffaPvSfYkQ=;
 b=ZSDP1kPHIi5o8F5Eo33DgBUrMqZ2mVuT7Vq9YQ5HCuguDcpZhmzXwJD39ff/pjG3gkJdAY
 jfMJo8+L0J8C8HWIMDNOz7oSckTE5HNKPM96tHAvUUzzzgCaq9jFGWmWqu1Eq3jlLQ8sA6
 zaR8sPpLJOTkr2LmzFujTYu360vq14M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-r-EPFl_hO-2E2m1r13CjFw-1; Mon,
 10 Mar 2025 23:44:20 -0400
X-MC-Unique: r-EPFl_hO-2E2m1r13CjFw-1
X-Mimecast-MFC-AGG-ID: r-EPFl_hO-2E2m1r13CjFw_1741664659
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71B821956083; Tue, 11 Mar 2025 03:44:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 795351828A81; Tue, 11 Mar 2025 03:44:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 20/63] docs/qapi-domain: add qapi:alternate directive
Date: Mon, 10 Mar 2025 23:42:18 -0400
Message-ID: <20250311034303.75779-21-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Add the .. qapi:alternate:: directive, object, and qapi:alt:`name`
cross-reference role.

Add the "Alternatives:" field list for describing alternate choices. Like
other field lists that reference QAPI types, a forthcoming commit will
add cross-referencing support to this field.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index e399474dc5b..506ed92700d 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -329,6 +329,23 @@ class QAPIEnum(QAPIObject):
     )
 
 
+class QAPIAlternate(QAPIObject):
+    """Description of a QAPI Alternate."""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            # :alt type name: descr
+            TypedField(
+                "alternative",
+                label=_("Alternatives"),
+                names=("alt",),
+                can_collapse=False,
+            ),
+        ]
+    )
+
+
 class QAPIModule(QAPIDescription):
     """
     Directive to mark description of a new module.
@@ -456,6 +473,7 @@ class QAPIDomain(Domain):
         "module": ObjType(_("module"), "mod", "any"),
         "command": ObjType(_("command"), "cmd", "any"),
         "enum": ObjType(_("enum"), "enum", "type", "any"),
+        "alternate": ObjType(_("alternate"), "alt", "type", "any"),
     }
 
     # Each of these provides a rST directive,
@@ -464,6 +482,7 @@ class QAPIDomain(Domain):
         "module": QAPIModule,
         "command": QAPICommand,
         "enum": QAPIEnum,
+        "alternate": QAPIAlternate,
     }
 
     # These are all cross-reference roles; e.g.
@@ -473,6 +492,7 @@ class QAPIDomain(Domain):
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
         "any": QAPIXRefRole(),  # reference *any* type of QAPI object.
-- 
2.48.1


