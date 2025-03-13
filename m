Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C65C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQI-0008JI-Ni; Thu, 13 Mar 2025 00:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQF-0008I2-73
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQC-000706-T3
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJF81P3sS7VNs7EOEp1xqNZSIqLT2s2Jdum8U2/tUt8=;
 b=WGjM8cE2/i7cM8i8Q1y346ZwwBrEGjGK6+4wtro/mDCa9eBe0pUL/4ZA1i4RncwqT+HJtw
 UW359S8/lTR+4Cqr94Xx4QnzX/2q5h/Lrcc446Dm3AG/WeGzKt2F467TT9vmTBJJkpvXBC
 hARIUC1dTFg7lHAn4gBrncjr68sqBas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167--ox0CbCRMteLQ1VD_BIDDA-1; Thu,
 13 Mar 2025 00:43:46 -0400
X-MC-Unique: -ox0CbCRMteLQ1VD_BIDDA-1
X-Mimecast-MFC-AGG-ID: -ox0CbCRMteLQ1VD_BIDDA_1741841025
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCF631800257; Thu, 13 Mar 2025 04:43:45 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A287F1955BCB; Thu, 13 Mar 2025 04:43:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 06/11] docs/qapidoc: add :namespace: option to qapi-doc
 directive
Date: Thu, 13 Mar 2025 00:43:07 -0400
Message-ID: <20250313044312.189276-7-jsnow@redhat.com>
In-Reply-To: <20250313044312.189276-1-jsnow@redhat.com>
References: <20250313044312.189276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a :namespace: option to the qapi-doc directive, which inserts a
qapi:namespace directive into the start of the generated document. This,
in turn, associates all auto-generated definitions by this directive
with the specified namespace.

The source info for these generated lines are credited to the start of
the qapi-doc directive, which isn't precisely correct, but I wasn't sure
how to get it more accurate without some re-parsing shenanigans.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 604ab109a19..cc7d9c1df9c 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -451,6 +451,12 @@ def visit_entity(self, ent: QAPISchemaDefinition) -> None:
         finally:
             self._curr_ent = None
 
+    def set_namespace(self, namespace: str, source: str, lineno: int) -> None:
+        self.add_line_raw(
+            f".. qapi:namespace:: {namespace}", source, lineno + 1
+        )
+        self.ensure_blank_line()
+
 
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
@@ -496,6 +502,7 @@ class QAPIDocDirective(NestedDirective):
     optional_arguments = 1
     option_spec = {
         "qapifile": directives.unchanged_required,
+        "namespace": directives.unchanged,
         "transmogrify": directives.flag,
     }
     has_content = False
@@ -510,6 +517,11 @@ def transmogrify(self, schema: QAPISchema) -> nodes.Element:
         vis = Transmogrifier()
         modules = set()
 
+        if "namespace" in self.options:
+            vis.set_namespace(
+                self.options["namespace"], *self.get_source_info()
+            )
+
         for doc in schema.docs:
             module_source = doc.info.fname
             if module_source not in modules:
-- 
2.48.1


