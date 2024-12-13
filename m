Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8EFE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuI5-0002Lq-5c; Thu, 12 Dec 2024 20:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuHY-0001TF-TH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuHS-0001BC-Jc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBgNkaG4dv2YJJtgU9QuV3617bD/FTejS/XKs7tm4ow=;
 b=iHw81wsGBfqxuWSWLfj7yiWXzJJoAqMw58lG0y+Exf/7V+9WLazAXQOo+I7+50y+s7HgDj
 UX95wpZ3s3Od/h+RgoUrsDVHNmcnF2qUaqADEMukPVXV1nyRPx5Xq91tpsQpTAEXDUT60r
 ciMrL/BLUGXoq1gkU89/1K1knReYIKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-EI1vaC3QNq-Cus2o4mtwTw-1; Thu,
 12 Dec 2024 20:14:35 -0500
X-MC-Unique: EI1vaC3QNq-Cus2o4mtwTw-1
X-Mimecast-MFC-AGG-ID: EI1vaC3QNq-Cus2o4mtwTw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FA4B195609F; Fri, 13 Dec 2024 01:14:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0310F1956086; Fri, 13 Dec 2024 01:14:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 21/35] docs/qapi-domain: add qapi:struct directive
Date: Thu, 12 Dec 2024 20:12:50 -0500
Message-ID: <20241213011307.2942030-22-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Adds the .. qapi:struct:: directive, object, and :qapi:struct:`name`
cross-referencing role.

As per usual, QAPI cross-referencing for types in the member field list
will be added in a forthcoming commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index e042421016f..d94d84bc186 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -344,6 +344,12 @@ class QAPIEvent(QAPIObjectWithMembers):
     pass
 
 
+class QAPIStruct(QAPIObjectWithMembers):
+    """Description of a QAPI Struct."""
+
+    pass
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -506,6 +512,7 @@ class QAPIDomain(Domain):
         "command": ObjType(_("command"), "cmd", "obj"),
         "event": ObjType(_("event"), "event", "obj"),
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
+        "struct": ObjType(_("struct"), "struct", "obj", "type"),
         "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
     }
 
@@ -516,6 +523,7 @@ class QAPIDomain(Domain):
         "command": QAPICommand,
         "event": QAPIEvent,
         "enum": QAPIEnum,
+        "struct": QAPIStruct,
         "alternate": QAPIAlternate,
     }
 
@@ -527,6 +535,7 @@ class QAPIDomain(Domain):
         "cmd": QAPIXRefRole(),
         "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "struct": QAPIXRefRole(),
         "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
-- 
2.47.0


