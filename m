Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA57BC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjZ-00073e-Lt; Tue, 04 Mar 2025 22:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjM-0006YM-R5
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjL-0006AB-3S
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMoBJtmu8xBZdY3WStP+pjFcDUWJlVucMPHx8TbfcEY=;
 b=iSaJgB2/GZ/wYaGdIG3j1niAVTtS27Ib7A4/LbgNKlBrRfRLDD6BLXlb8//Z0iVEGh/V3+
 AMH3uBs4RZ3NQPXDkgbcbTNmfD4Nvi5Zm5+CGOH8604fJBgJCn0adnAiKmdObuHtADT6E6
 6PVNEuUZGXW/SWnF0lEbTivI9eRj5ik=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-Vu6sZ_aSO4GZgeAIPRl-CA-1; Tue,
 04 Mar 2025 22:47:30 -0500
X-MC-Unique: Vu6sZ_aSO4GZgeAIPRl-CA-1
X-Mimecast-MFC-AGG-ID: Vu6sZ_aSO4GZgeAIPRl-CA_1741146449
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 214721954203; Wed,  5 Mar 2025 03:47:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08D641956095; Wed,  5 Mar 2025 03:47:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 20/57] docs/qapi-domain: add qapi:object directive
Date: Tue,  4 Mar 2025 22:45:29 -0500
Message-ID: <20250305034610.960147-21-jsnow@redhat.com>
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

Adds the .. qapi:object:: directive, object, and :qapi:obj:`name`
cross-referencing role. This directive is meant to document both structs
and unions.

As per usual, QAPI cross-referencing for types in the member field list
will be added in a forthcoming commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index d9c69af229d..fff5cca24cc 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -358,6 +358,10 @@ class QAPIEvent(QAPIObjectWithMembers):
     """Description of a QAPI Event."""
 
 
+class QAPIJSONObject(QAPIObjectWithMembers):
+    """Description of a QAPI Object: structs and unions."""
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -522,6 +526,7 @@ class QAPIDomain(Domain):
         "command": ObjType(_("command"), "cmd", "any"),
         "event": ObjType(_("event"), "event", "any"),
         "enum": ObjType(_("enum"), "enum", "type", "any"),
+        "object": ObjType(_("object"), "obj", "type", "any"),
         "alternate": ObjType(_("alternate"), "alt", "type", "any"),
     }
 
@@ -532,6 +537,7 @@ class QAPIDomain(Domain):
         "command": QAPICommand,
         "event": QAPIEvent,
         "enum": QAPIEnum,
+        "object": QAPIJSONObject,
         "alternate": QAPIAlternate,
     }
 
@@ -543,6 +549,7 @@ class QAPIDomain(Domain):
         "cmd": QAPIXRefRole(),
         "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "obj": QAPIXRefRole(),  # specifically structs and unions.
         "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
-- 
2.48.1


