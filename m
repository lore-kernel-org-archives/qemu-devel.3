Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAE3C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqY1-0005h8-2u; Mon, 10 Mar 2025 23:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqXd-0004XS-QF
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqXc-0002It-7o
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmk2v3NCT/NC+pao/h8qa/vK3x4lxNpRkpl/WC4gJso=;
 b=A/Lv6rFuT9Pd0rT6+18qqOOREZ1Yks3g2UBYbGEW2yVRkMiMZMAWZXEgltzK2n3XH5P8ZD
 8PLyX94zPzrHYq4NJ8mDPZI9Nxp2yr8N3WyQlc+J3z9JlNwY0ygwoqslezLMg0VZeV0H0C
 8q9+jJtcgivp84nI0BKdwUSJU7h53v4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-T08i24O9Nh6b-EhhaSw5ZQ-1; Mon,
 10 Mar 2025 23:44:23 -0400
X-MC-Unique: T08i24O9Nh6b-EhhaSw5ZQ-1
X-Mimecast-MFC-AGG-ID: T08i24O9Nh6b-EhhaSw5ZQ_1741664662
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAB781800258; Tue, 11 Mar 2025 03:44:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B345E1800366; Tue, 11 Mar 2025 03:44:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 21/63] docs/qapi-domain: add qapi:event directive
Date: Mon, 10 Mar 2025 23:42:19 -0400
Message-ID: <20250311034303.75779-22-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Adds the .. qapi:event:: directive, object, and :qapi:event:`name`
cross-referencing role.

Adds the :memb type name: field list syntax for documenting event data
members. As this syntax and phrasing will be shared with Structs and
Unions as well, add the field list definition to a shared abstract
class.

As per usual, QAPI cross-referencing for types in the member field list
will be added in a forthcoming commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 506ed92700d..3ffb3eb72d1 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -346,6 +346,27 @@ class QAPIAlternate(QAPIObject):
     )
 
 
+class QAPIObjectWithMembers(QAPIObject):
+    """Base class for Events/Structs/Unions"""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            # :member type name: descr
+            TypedField(
+                "member",
+                label=_("Members"),
+                names=("memb",),
+                can_collapse=False,
+            ),
+        ]
+    )
+
+
+class QAPIEvent(QAPIObjectWithMembers):
+    """Description of a QAPI Event."""
+
+
 class QAPIModule(QAPIDescription):
     """
     Directive to mark description of a new module.
@@ -472,6 +493,7 @@ class QAPIDomain(Domain):
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "any"),
         "command": ObjType(_("command"), "cmd", "any"),
+        "event": ObjType(_("event"), "event", "any"),
         "enum": ObjType(_("enum"), "enum", "type", "any"),
         "alternate": ObjType(_("alternate"), "alt", "type", "any"),
     }
@@ -481,6 +503,7 @@ class QAPIDomain(Domain):
     directives = {
         "module": QAPIModule,
         "command": QAPICommand,
+        "event": QAPIEvent,
         "enum": QAPIEnum,
         "alternate": QAPIAlternate,
     }
@@ -491,6 +514,7 @@ class QAPIDomain(Domain):
     roles = {
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
+        "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
         "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
-- 
2.48.1


