Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBFBC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20M-0006KZ-CM; Fri, 14 Mar 2025 06:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20E-0006If-CP
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00022q-Lw
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aqwbTO8KT37DTKD835oXBUCkA/jttLd966RrPuvFV0=;
 b=MRW9gt8ZFb0P3ZHFe4/Lb2lhnMZfeTCpnojiGjJJe5CKwyKks2k9MT6AmD9pSNPQEewmnh
 pWbUM6fN7W/+ho7HtwDOfx6wE/IFy6wLYm01t41C6X/JM3HchdgOUx+j6yhTZgURph1Qzu
 I2r9k37NdJnrnIOhK8rZY3a+bl62+n0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-q0MjlDDFOOOgn01-psRswA-1; Fri,
 14 Mar 2025 06:10:49 -0400
X-MC-Unique: q0MjlDDFOOOgn01-psRswA-1
X-Mimecast-MFC-AGG-ID: q0MjlDDFOOOgn01-psRswA_1741947049
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF8BE180035C
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88CAF1828A98
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA94A21E66A7; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 05/12] docs/qapi-domain: add :namespace: override option
Date: Fri, 14 Mar 2025 11:10:31 +0100
Message-ID: <20250314101038.2408751-6-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Akin to the :module: override option, the :namespace: options allows you
to forcibly override the contextual namespace associatied with a
definition.

We don't necessarily actually need this, but I felt compelled to stick
close to how the Python domain works that offers context overrides.

As of this commit, it is possible to add e.g. ":namespace: QMP" to any
QAPI directive to forcibly associate that definition with a given
namespace.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-5-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-domain.rst | 2 ++
 docs/sphinx/qapi_domain.py | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index 1475870ca6..51b283277e 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -466,6 +466,8 @@ QAPI standard options
 
 All QAPI directives -- *except* for module -- support these common options.
 
+* ``:namespace: name`` -- This option allows you to override the
+  namespace association of a given definition.
 * ``:module: modname`` -- Borrowed from the Python domain, this option allows
   you to override the module association of a given definition.
 * ``:since: x.y`` -- Allows the documenting of "Since" information, which is
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 48a082d489..6485c43206 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -294,8 +294,9 @@ class QAPIObject(QAPIDescription):
     )
     option_spec.update(
         {
-            # Borrowed from the Python domain:
-            "module": directives.unchanged,  # Override contextual module name
+            # Context overrides:
+            "namespace": directives.unchanged,
+            "module": directives.unchanged,
             # These are QAPI originals:
             "since": directives.unchanged,
             "ifcond": directives.unchanged,
-- 
2.48.1


