Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56A4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1T-0007Xt-Sx; Fri, 19 Apr 2024 00:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1G-0007TM-At
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1E-0004DF-AF
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8sVACIrRr62XXP78wsALvQJ+r6VO2WQThyIRVJL9Fw=;
 b=YIiqmS1g/xHOv3qNR0wy4TPWHt2RnPGMkPS9Ik9TYPxsjsBT8IUPLrJY3fdDnvvX44KbkY
 cMN9Ojm+6twhVWdMSk3ZkDF8zVGZjZoRkzUyfjoaPtTcy/L3Bsxv4XQl4eNRLkjm6epG9q
 gnihoXye9Jv49UF0X9vwYNSLhqoA2Q0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-7G7w6msjNDCoqcoaiODsEQ-1; Fri, 19 Apr 2024 00:38:33 -0400
X-MC-Unique: 7G7w6msjNDCoqcoaiODsEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD12280021A;
 Fri, 19 Apr 2024 04:38:32 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0729040357A7;
 Fri, 19 Apr 2024 04:38:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 15/27] docs/qapi-domain: add qapi:event directive
Date: Fri, 19 Apr 2024 00:38:03 -0400
Message-ID: <20240419043820.178731-16-jsnow@redhat.com>
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

Adds the .. qapi:event:: directive, object, and :qapi:event:`name`
cross-referencing role.

Adds the :memb type name: field list syntax for documenting event data
members. As this syntax and phrasing will be shared with Structs and
Unions as well, add the field list definition to a shared abstract
class.

As per usual, QAPI cross-referencing for types in the member field list
will be added in a forthcoming commit.

NOTE 1: The "str?" type annotation syntax sneaks into this commit in the
demonstration doc. It isn't processed yet, so just ignore it for
now. The non-RFC version of this series won't include the sandbox doc,
so that inconsistency will sort itself out later. (Skip ahead to the
commit that adds XRef support for TypedField and GroupedField lists to
learn what the deal is there and leave feedback on that syntax.)

NOTE 2: We already have a QMP lexer, turn it on for example blocks in this
sample demo.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        | 40 ++++++++++++++++++++++++++++++++++++++
 docs/sphinx/qapi-domain.py | 25 ++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 9bfe4d9f454..d81bccfb06a 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -2,6 +2,12 @@
 QAPI Domain Test
 ----------------
 
+.. this sets the code-highlighting language to QMP for this *document*.
+   I wonder if I can set a domain default...?
+
+.. highlight:: QMP
+
+
 .. qapi:module:: foo-module
    :no-index:
 
@@ -134,3 +140,37 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :choice str local: name of the bitmap, attached to the same node as
       target bitmap.
    :choice BlockDirtyBitmap external: bitmap with specified node
+
+.. qapi:event:: BLOCK_JOB_COMPLETED
+   :since: 1.1
+
+   Emitted when a block job has completed.
+
+   :memb JobType type: job type
+   :memb str device: The job identifier. Originally the device name but
+      other values are allowed since QEMU 2.7
+   :memb int len: maximum progress value
+   :memb int offset: current progress value. On success this is equal to
+      len. On failure this is less than len
+   :memb int speed: rate limit, bytes per second
+   :memb str? error: error message. Only present on failure. This field
+      contains a human-readable error message. There are no semantics
+      other than that streaming has failed and clients should not try to
+      interpret the error string
+
+   Example::
+
+     <- {
+       "event": "BLOCK_JOB_COMPLETED",
+       "data": {
+         "type": "stream",
+         "device": "virtio-disk0",
+         "len": 10737418240,
+         "offset": 10737418240,
+         "speed": 0
+       },
+       "timestamp": {
+         "seconds": 1267061043,
+         "microseconds": 959568
+       }
+     }
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index c6eb6324594..74dc578b3c7 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -321,6 +321,28 @@ class QAPIAlternate(QAPIObject):
     )
 
 
+class QAPIObjectWithMembers(QAPIObject):
+    """Base class for Events/Structs/Unions"""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            TypedField(
+                "member",
+                label=_("Members"),
+                names=("memb",),
+                can_collapse=True,
+            ),
+        ]
+    )
+
+
+class QAPIEvent(QAPIObjectWithMembers):
+    """Description of a QAPI Event."""
+
+    pass
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -473,6 +495,7 @@ class QAPIDomain(Domain):
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "obj"),
         "command": ObjType(_("command"), "cmd", "obj"),
+        "event": ObjType(_("event"), "event", "obj"),
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
         "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
     }
@@ -482,6 +505,7 @@ class QAPIDomain(Domain):
     directives = {
         "module": QAPIModule,
         "command": QAPICommand,
+        "event": QAPIEvent,
         "enum": QAPIEnum,
         "alternate": QAPIAlternate,
     }
@@ -492,6 +516,7 @@ class QAPIDomain(Domain):
     roles = {
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
+        "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
         "alt": QAPIXRefRole(),
         "type": QAPIXRefRole(),  # reference any data type (excludes modules, commands, events)
-- 
2.44.0


