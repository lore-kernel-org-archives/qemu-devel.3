Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41EDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1R-0007Wg-8i; Fri, 19 Apr 2024 00:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1G-0007TL-7q
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1E-0004DD-5Q
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MF2waKTg6GHDYisWOktBmLflMpQrWVB3DdDEnaS+uUA=;
 b=YvOBUZ7N2u7UK22fqzM9UVoLdIpEFc5KBuTNuhjsVv2V+BWhJGF9hD4cV4u6Lz+R08YMWL
 5VD8XfBuFMFkVJyLDuOeiUp+yX1hsbBo63RdG93uUcyZ3QpJ7iqGr7huKmzh9klJkTuLZk
 oBJqjg6xElKn7OkzbBSzC3AiqQgYPEs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Dz6E4P27OmOn9qr2uhvaRg-1; Fri,
 19 Apr 2024 00:38:33 -0400
X-MC-Unique: Dz6E4P27OmOn9qr2uhvaRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E3981C0C651;
 Fri, 19 Apr 2024 04:38:33 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB90C40829C3;
 Fri, 19 Apr 2024 04:38:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 16/27] docs/qapi-domain: add qapi:struct directive
Date: Fri, 19 Apr 2024 00:38:04 -0400
Message-ID: <20240419043820.178731-17-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Adds the .. qapi:struct:: directive, object, and :qapi:struct:`name`
cross-referencing role.

As per usual, QAPI cross-referencing for types in the member field list
will be added in a forthcoming commit.

RFC Note: The "?" syntax sneaks into the example document again. Please
ignore that for now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        | 16 ++++++++++++++++
 docs/sphinx/qapi-domain.py |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index d81bccfb06a..b07e6e9e2e3 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -174,3 +174,19 @@ Explicit cross-referencing syntax for QAPI modules is available with
          "microseconds": 959568
        }
      }
+
+.. qapi:struct:: BackupPerf
+   :since: 6.0
+
+   Optional parameters for backup.  These parameters don't affect
+   functionality, but may significantly affect performance.
+
+   :memb bool? use-copy-range: Use copy offloading.  Default false.
+   :memb int? max-workers: Maximum number of parallel requests for the
+      sustained background copying process.  Doesn't influence
+      copy-before-write operations.  Default 64.
+   :memb int64? max-chunk: Maximum request length for the sustained
+     background copying process.  Doesn't influence copy-before-write
+     operations.  0 means unlimited.  If max-chunk is non-zero then it
+     should not be less than job cluster size which is calculated as
+     maximum of target image cluster size and 64k.  Default 0.
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 74dc578b3c7..b46faeaceef 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -343,6 +343,12 @@ class QAPIEvent(QAPIObjectWithMembers):
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
@@ -497,6 +503,7 @@ class QAPIDomain(Domain):
         "command": ObjType(_("command"), "cmd", "obj"),
         "event": ObjType(_("event"), "event", "obj"),
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
+        "struct": ObjType(_("struct"), "struct", "obj", "type"),
         "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
     }
 
@@ -507,6 +514,7 @@ class QAPIDomain(Domain):
         "command": QAPICommand,
         "event": QAPIEvent,
         "enum": QAPIEnum,
+        "struct": QAPIStruct,
         "alternate": QAPIAlternate,
     }
 
@@ -518,6 +526,7 @@ class QAPIDomain(Domain):
         "cmd": QAPIXRefRole(),
         "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "struct": QAPIXRefRole(),
         "alt": QAPIXRefRole(),
         "type": QAPIXRefRole(),  # reference any data type (excludes modules, commands, events)
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
-- 
2.44.0


