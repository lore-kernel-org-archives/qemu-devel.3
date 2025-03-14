Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F17BC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20N-0006Km-4J; Fri, 14 Mar 2025 06:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20G-0006JQ-HP
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00022z-Vu
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWM1J8OeYn4zhTwTnsdWw/CoR6nDQNvxa69361V/d1A=;
 b=fz0+INCqfcUB9J5QwK/yFo2NrxZVPHTlWVell6yPYtKSbIs1TGXbPTqR48EiBqSCrBAj80
 QR4HnO+qtR/WVRPUea2pxkFAA34u+qzYR+yM/WIkUCe5IKB/diPuQRR9DRJcuufGrLaSSo
 sKNWcA50bLFVsf/wsM2XMEPpJpD//6Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-sGEgBa_8OoaA5EI8toKpHg-1; Fri,
 14 Mar 2025 06:10:50 -0400
X-MC-Unique: sGEgBa_8OoaA5EI8toKpHg-1
X-Mimecast-MFC-AGG-ID: sGEgBa_8OoaA5EI8toKpHg_1741947049
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 413B21956087
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAF361955F2D
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE92E21E65DD; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 06/12] docs/qapi-domain: add qapi:namespace directive
Date: Fri, 14 Mar 2025 11:10:32 +0100
Message-ID: <20250314101038.2408751-7-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Add a new directive that marks the beginning of a QAPI "namespace", for
example; "QMP", "QGA" or "QSD". This directive will associate all
subsequent QAPI directives in a document with the specified
namespace. This does not change the visual display of any of the
definitions or index entries, but does change the "Fully Qualified Name"
inside the QAPI domain's object table. This allows for two different
"namespaces" to define entities with otherwise identical names -- which
will come in handy for documenting both QEMU QMP and the QEMU Storage
Daemon.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-6-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-domain.rst | 20 +++++++++++++++++++-
 docs/sphinx/qapi_domain.py | 13 +++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index 51b283277e..73e13ab45c 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -464,7 +464,8 @@ removed in a future version.
 QAPI standard options
 ---------------------
 
-All QAPI directives -- *except* for module -- support these common options.
+All QAPI directives -- *except* for namespace and module -- support
+these common options.
 
 * ``:namespace: name`` -- This option allows you to override the
   namespace association of a given definition.
@@ -482,6 +483,23 @@ All QAPI directives -- *except* for module -- support these common options.
   production code.
 
 
+qapi:namespace
+--------------
+
+The ``qapi:namespace`` directive marks the start of a QAPI namespace. It
+does not take a content body, nor any options. All subsequent QAPI
+directives are associated with the most recent namespace. This affects
+the definition's "fully qualified name", allowing two different
+namespaces to create an otherwise identically named definition.
+
+Example::
+
+   .. qapi:namespace:: QMP
+
+
+This directive has no visible effect.
+
+
 qapi:module
 -----------
 
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 6485c43206..a204af9b06 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -38,6 +38,7 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
+from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
 
 
@@ -645,6 +646,17 @@ def run(self) -> List[Node]:
         return ret
 
 
+class QAPINamespace(SphinxDirective):
+    has_content = False
+    required_arguments = 1
+
+    def run(self) -> List[Node]:
+        namespace = self.arguments[0].strip()
+        self.env.ref_context["qapi:namespace"] = namespace
+
+        return []
+
+
 class QAPIIndex(Index):
     """
     Index subclass to provide the QAPI definition index.
@@ -726,6 +738,7 @@ class QAPIDomain(Domain):
     # Each of these provides a rST directive,
     # e.g. .. qapi:module:: block-core
     directives = {
+        "namespace": QAPINamespace,
         "module": QAPIModule,
         "command": QAPICommand,
         "event": QAPIEvent,
-- 
2.48.1


