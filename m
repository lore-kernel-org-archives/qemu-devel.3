Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639F4C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjb-0007B6-03; Tue, 04 Mar 2025 22:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjX-0006y8-6g
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjV-0006BY-3P
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAp2bFFAa9kq9B6wvgXdolIRvENLUMiUD/N5oF6tkdM=;
 b=hxTfdd7fuMG/mfuAyNL7GbEpj73V7CWomyVlD4IBpP1B+0N/DBkOs6Gn8JWWWVZJJ3cGyb
 Qn7cAPDtgwtJUMwBfejTjchSJl5MnaM/fpYJhb8l1morgfqTes2RmPAeh1uzTGUdwA+RIk
 jbqTftOYDeLhBCc8i465qpznhTOD+v8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-9kx_7q8bNdCL5nV3QNW9_A-1; Tue,
 04 Mar 2025 22:47:37 -0500
X-MC-Unique: 9kx_7q8bNdCL5nV3QNW9_A-1
X-Mimecast-MFC-AGG-ID: 9kx_7q8bNdCL5nV3QNW9_A_1741146456
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0590B193585F; Wed,  5 Mar 2025 03:47:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C47881956095; Wed,  5 Mar 2025 03:47:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH 22/57] docs/qapi-domain: add :unstable: directive option
Date: Tue,  4 Mar 2025 22:45:31 -0500
Message-ID: <20250305034610.960147-23-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

Although "unstable" is a feature (and *will* appear in the features
list), add a special :unstable: option to generate an eye-catch that
makes this information very hard to miss.

(The intent is to modify qapidoc.py to add this option whenever it
detects that the features list attached to a definition contains the
"unstable" entry.)

RFC: Same comments as last patch.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 6 +++++-
 docs/sphinx/qapi_domain.py             | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 3765cab1b20..5f58f1d5246 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -221,7 +221,7 @@ div[class^="highlight"] pre {
     margin: 0.25em;
 }
 
-.qapi-deprecated {
+.qapi-deprecated,.qapi-unstable {
     background-color: #fffef5;
     border: solid #fff176 6px;
     font-weight: bold;
@@ -230,6 +230,10 @@ div[class^="highlight"] pre {
     margin: 5px;
 }
 
+.qapi-unstable::before {
+    content: '🚧 ';
+}
+
 .qapi-deprecated::before {
     content: '⚠️ ';
 }
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 1be59e36bdf..ef4fa978a3a 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -141,6 +141,7 @@ class QAPIObject(ObjectDescription[Signature]):
             # These are QAPI originals:
             "since": since_validator,
             "deprecated": directives.flag,
+            "unstable": directives.flag,
         }
     )
 
@@ -273,6 +274,13 @@ def _add_pip(source: str, content: str, classname: str) -> None:
                 "qapi-deprecated",
             )
 
+        if "unstable" in self.options:
+            _add_pip(
+                ":unstable:",
+                f"This {self.objtype} is unstable/experimental.",
+                "qapi-unstable",
+            )
+
         if infopips.children:
             contentnode.insert(0, infopips)
 
-- 
2.48.1


