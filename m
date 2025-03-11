Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE04C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqb-0003GR-2d; Tue, 11 Mar 2025 07:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqL-0003B1-4h
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq2-0006Uq-Nv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMCCV60TbkWT6eOjqy0/DKgYc2iniJRfLzqDSQLP1mc=;
 b=ghRycBgLxKviz9V1SR6DwOrgP9ZUqlabGS5KiHW7S+OoaB34pa3Nt66YUp5YTWVDH21ma1
 zy2jdvLpUUmowS8j1MkWwAB9tzmCQgR5gLEuAJl6NUK+hZDnLCAGYpSYIYjnFxRB+NYSDT
 2DOUvW8AcFzeQRvNHYSDVltpqQW95zY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-yjjUQTchO6CX3Z0XLG0mzw-1; Tue,
 11 Mar 2025 07:31:54 -0400
X-MC-Unique: yjjUQTchO6CX3Z0XLG0mzw-1
X-Mimecast-MFC-AGG-ID: yjjUQTchO6CX3Z0XLG0mzw_1741692713
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE3F4195608B
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 595DB1956094
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B36821E64A8; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 20/61] docs/qapi-domain: add qapi:object directive
Date: Tue, 11 Mar 2025 12:30:56 +0100
Message-ID: <20250311113137.1277125-21-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Adds the .. qapi:object:: directive, object, and :qapi:obj:`name`
cross-referencing role. This directive is meant to document both structs
and unions.

As per usual, QAPI cross-referencing for types in the member field list
will be added in a forthcoming commit.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-23-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 3ffb3eb72d..b11300bc85 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -367,6 +367,10 @@ class QAPIEvent(QAPIObjectWithMembers):
     """Description of a QAPI Event."""
 
 
+class QAPIJSONObject(QAPIObjectWithMembers):
+    """Description of a QAPI Object: structs and unions."""
+
+
 class QAPIModule(QAPIDescription):
     """
     Directive to mark description of a new module.
@@ -495,6 +499,7 @@ class QAPIDomain(Domain):
         "command": ObjType(_("command"), "cmd", "any"),
         "event": ObjType(_("event"), "event", "any"),
         "enum": ObjType(_("enum"), "enum", "type", "any"),
+        "object": ObjType(_("object"), "obj", "type", "any"),
         "alternate": ObjType(_("alternate"), "alt", "type", "any"),
     }
 
@@ -505,6 +510,7 @@ class QAPIDomain(Domain):
         "command": QAPICommand,
         "event": QAPIEvent,
         "enum": QAPIEnum,
+        "object": QAPIJSONObject,
         "alternate": QAPIAlternate,
     }
 
@@ -516,6 +522,7 @@ class QAPIDomain(Domain):
         "cmd": QAPIXRefRole(),
         "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "obj": QAPIXRefRole(),  # specifically structs and unions.
         "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
-- 
2.48.1


