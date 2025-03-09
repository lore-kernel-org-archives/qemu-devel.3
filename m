Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FB0C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC9j-0002aC-7T; Sun, 09 Mar 2025 04:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9c-0002EB-7T
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9a-0002Pw-Pk
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUfEKi5B+8rzq7NctWViXP4FOQxHy6UF6ervu+N0nWE=;
 b=iS2IXyDNRnJo89ey5ub76m2LiXV665VwwlKoxmTL9LKetHop/DuHLnikafVoCvBdKicTfT
 6DuuvimGDp8i+zkHx9GLLUgP95CKYiRKXbXOYVQdA22WChvpEeFXR/8UrX0xv52Km4muQt
 Ie9BzZeyob4ntXDAAlNxQiyXNddWZds=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-gGwCUUKWMomIs3QLNUOOnw-1; Sun,
 09 Mar 2025 04:36:50 -0400
X-MC-Unique: gGwCUUKWMomIs3QLNUOOnw-1
X-Mimecast-MFC-AGG-ID: gGwCUUKWMomIs3QLNUOOnw_1741509409
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6B8C18004A9; Sun,  9 Mar 2025 08:36:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5878419560AB; Sun,  9 Mar 2025 08:36:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 22/62] docs/qapi-domain: add qapi:object directive
Date: Sun,  9 Mar 2025 04:35:09 -0400
Message-ID: <20250309083550.5155-23-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
index e5beae1a528..e84affaaec2 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -362,6 +362,10 @@ class QAPIEvent(QAPIObjectWithMembers):
     """Description of a QAPI Event."""
 
 
+class QAPIJSONObject(QAPIObjectWithMembers):
+    """Description of a QAPI Object: structs and unions."""
+
+
 class QAPIModule(QAPIDescription):
     """
     Directive to mark description of a new module.
@@ -490,6 +494,7 @@ class QAPIDomain(Domain):
         "command": ObjType(_("command"), "cmd", "any"),
         "event": ObjType(_("event"), "event", "any"),
         "enum": ObjType(_("enum"), "enum", "type", "any"),
+        "object": ObjType(_("object"), "obj", "type", "any"),
         "alternate": ObjType(_("alternate"), "alt", "type", "any"),
     }
 
@@ -500,6 +505,7 @@ class QAPIDomain(Domain):
         "command": QAPICommand,
         "event": QAPIEvent,
         "enum": QAPIEnum,
+        "object": QAPIJSONObject,
         "alternate": QAPIAlternate,
     }
 
@@ -511,6 +517,7 @@ class QAPIDomain(Domain):
         "cmd": QAPIXRefRole(),
         "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "obj": QAPIXRefRole(),  # specifically structs and unions.
         "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
-- 
2.48.1


