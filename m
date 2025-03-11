Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF5FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxry-0004wY-3h; Tue, 11 Mar 2025 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqB-00035N-54
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxpy-0006So-JR
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ci9++44Vu0AyVzxeH73rqBxxH/kB2g9E3U8CcJkrGx4=;
 b=Pl1tjy2epqEftidRxbB44gAdotWSoRuYNtO+9JyLr/BykBWZZOAbz6EwTybJBtOiNiRTv3
 cR/wSKmK9OGIdtgYZF4PdqCFSMgw6BNCFF6EDgYXnq6UfBU1ExbkVluYVIkcx2+M+LAYm6
 sRE3oT6gSxNWoZgr4CVoRNMMD9FcyZ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-Tf2x5mRnPB6nTPzY3Icd9w-1; Tue,
 11 Mar 2025 07:31:49 -0400
X-MC-Unique: Tf2x5mRnPB6nTPzY3Icd9w-1
X-Mimecast-MFC-AGG-ID: Tf2x5mRnPB6nTPzY3Icd9w_1741692708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C76AB18001E3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 619EE1801752
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD0E721E64C0; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 11/61] docs/qapi-domain: add qapi:command directive
Date: Tue, 11 Mar 2025 12:30:47 +0100
Message-ID: <20250311113137.1277125-12-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This commit adds a stubbed version of QAPICommand that utilizes the
QAPIObject class, the qapi:command directive, the :qapi:cmd:
cross-reference role, and the "command" object type in the QAPI object
registry.

They don't do anything *particularly* interesting yet, but that will
come in forthcoming commits.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-14-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 3109c0cb90..547040f75a 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -258,6 +258,12 @@ def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
         return sig
 
 
+class QAPICommand(QAPIObject):
+    """Description of a QAPI Command."""
+
+    # Nothing unique for now! Changed in later commits O:-)
+
+
 class QAPIModule(QAPIDescription):
     """
     Directive to mark description of a new module.
@@ -379,12 +385,14 @@ class QAPIDomain(Domain):
     # for each object type.
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "any"),
+        "command": ObjType(_("command"), "cmd", "any"),
     }
 
     # Each of these provides a rST directive,
     # e.g. .. qapi:module:: block-core
     directives = {
         "module": QAPIModule,
+        "command": QAPICommand,
     }
 
     # These are all cross-reference roles; e.g.
@@ -392,6 +400,7 @@ class QAPIDomain(Domain):
     # the object_types table values above.
     roles = {
         "mod": QAPIXRefRole(),
+        "cmd": QAPIXRefRole(),
         "any": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.48.1


