Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E13DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1Q-0007W7-2S; Fri, 19 Apr 2024 00:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1G-0007TO-MZ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1E-0004DM-V7
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aT7Zt+MnqDBeB3Aa1m9yjVj+44B/I2Lh5VoQCq7rSj8=;
 b=gmnTtJkNLUCOUBl5JdFTECCgtxW2hes5fceUHYbcIx20Et3P+1Qf/FcAcCuwxAYKIsfeQ2
 jnpZhbrR2Q0NS9/ysRtfVjdMaFBqzMjLxXTm43TESwpobLJxvJ+g5dfUfj/fARR+shM1kW
 LNjQkQyj4b//snts9DjOTJMB+Ozxjos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-mNEPjwTxN4-f2B3iwoVt8g-1; Fri, 19 Apr 2024 00:38:32 -0400
X-MC-Unique: mNEPjwTxN4-f2B3iwoVt8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF6A8810602;
 Fri, 19 Apr 2024 04:38:31 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC424011FF7;
 Fri, 19 Apr 2024 04:38:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 14/27] docs/qapi-domain: add qapi:alternate directive
Date: Fri, 19 Apr 2024 00:38:02 -0400
Message-ID: <20240419043820.178731-15-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

Add the .. qapi:alternate:: directive, object, and qapi:alt:`name`
cross-reference role.

Add the "Choices:" field list for describing alternate choices. Like
other field lists that reference QAPI types, a forthcoming commit will
add cross-referencing support to this field.

RFC: In the future, it would be nice to directly inline Alternates as
part of the type information in the containing object (i.e. directly in
arguments/members) - but that's a task for another series. For now, the
branch "names" are documented just like qapidoc.py does, even though
this information is superfluous for user documentation. Room for future
improvement, but not now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  7 +++++++
 docs/sphinx/qapi-domain.py | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index cf794e6e739..9bfe4d9f454 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -127,3 +127,10 @@ Explicit cross-referencing syntax for QAPI modules is available with
       is treated solely as a read-only manifest of blocks to copy.
    :value always: The bitmap is always synchronized with the operation,
       regardless of whether or not the operation was successful.
+
+.. qapi:alternate:: BlockDirtyBitmapOrStr
+   :since: 4.1
+
+   :choice str local: name of the bitmap, attached to the same node as
+      target bitmap.
+   :choice BlockDirtyBitmap external: bitmap with specified node
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 6759c39290d..c6eb6324594 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -305,6 +305,22 @@ class QAPIEnum(QAPIObject):
     )
 
 
+class QAPIAlternate(QAPIObject):
+    """Description of a QAPI Alternate."""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            TypedField(
+                "choice",
+                label=_("Choices"),
+                names=("choice",),
+                can_collapse=True,
+            ),
+        ]
+    )
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -458,6 +474,7 @@ class QAPIDomain(Domain):
         "module": ObjType(_("module"), "mod", "obj"),
         "command": ObjType(_("command"), "cmd", "obj"),
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
+        "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
     }
 
     # Each of these provides a ReST directive,
@@ -466,6 +483,7 @@ class QAPIDomain(Domain):
         "module": QAPIModule,
         "command": QAPICommand,
         "enum": QAPIEnum,
+        "alternate": QAPIAlternate,
     }
 
     # These are all cross-reference roles; e.g.
@@ -475,6 +493,7 @@ class QAPIDomain(Domain):
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "alt": QAPIXRefRole(),
         "type": QAPIXRefRole(),  # reference any data type (excludes modules, commands, events)
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
-- 
2.44.0


