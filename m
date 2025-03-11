Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA55CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqa-0003Ev-2Z; Tue, 11 Mar 2025 07:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqE-000383-Ok
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq2-0006Uo-MG
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4iJVEy0u5pRD5/0vJ1dDhEmEleaG+zk/XWDcWBWEVs=;
 b=OTuF0e4rmbEcYjKjVKQQyY1ubYHJ6A0SPMNoqrxu6+ft1Txgqx/aAPmYN6UwT1ySBa0qQ2
 6TVLAmaWtIxlfJXtK0syYAvc0qVVooSo867PPyaKgB2LRD2KEO+0/LteIc9B4kSky0yMAr
 lqneM1qsu7fr6fJNZbdvncTReguHrH0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-RzjEHD0ZOcC1oT51AHYetQ-1; Tue,
 11 Mar 2025 07:31:54 -0400
X-MC-Unique: RzjEHD0ZOcC1oT51AHYetQ-1
X-Mimecast-MFC-AGG-ID: RzjEHD0ZOcC1oT51AHYetQ_1741692713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FECF1955F67
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 032491800945
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04FD921E6497; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 18/61] docs/qapi-domain: add qapi:alternate directive
Date: Tue, 11 Mar 2025 12:30:54 +0100
Message-ID: <20250311113137.1277125-19-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Add the .. qapi:alternate:: directive, object, and qapi:alt:`name`
cross-reference role.

Add the "Alternatives:" field list for describing alternate choices. Like
other field lists that reference QAPI types, a forthcoming commit will
add cross-referencing support to this field.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-21-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index e399474dc5..506ed92700 100644
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


