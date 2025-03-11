Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817D1C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqY5-00065y-5o; Mon, 10 Mar 2025 23:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqXm-0004ql-UI
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqXl-0002KN-9W
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpG2pQT39ow30jF2z/a6Gu94ThGZE+Q/VZNP8o23r8U=;
 b=UgHs9vSr82mDP1VCQFd3dtHHwiI8hcYx1DbE2ZIQargwpYQSStxSRagAtotSmoQwVkjaeh
 DYs/vV1VxMCN8bQMQghiycDwoeVBee6zr/2zjbqIzFw7Z3PsxYxT4wKNerTCm37brEPJK3
 JP8RwDXAotlNrlj9gd/LIx/hOYvW4eM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-KZqHeEY_Nim_cen5KaAZvw-1; Mon,
 10 Mar 2025 23:44:33 -0400
X-MC-Unique: KZqHeEY_Nim_cen5KaAZvw-1
X-Mimecast-MFC-AGG-ID: KZqHeEY_Nim_cen5KaAZvw_1741664672
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51E6218007E1; Tue, 11 Mar 2025 03:44:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BFB81800366; Tue, 11 Mar 2025 03:44:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH v3 24/63] docs/qapi-domain: add :unstable: directive option
Date: Mon, 10 Mar 2025 23:42:22 -0400
Message-ID: <20250311034303.75779-25-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Although "unstable" is a feature (and *will* appear in the features
list), add a special :unstable: option to generate an eye-catch that
makes this information very hard to miss.

The forthcoming Transmogrifier in qapidoc.py will add this option
whenever it detects that the features list attached to a definition
contains the "unstable" entry.

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
index b672ae6c504..00fd11ebf79 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -218,6 +218,7 @@ class QAPIObject(QAPIDescription):
             # These are QAPI originals:
             "since": directives.unchanged,
             "deprecated": directives.flag,
+            "unstable": directives.flag,
         }
     )
 
@@ -300,6 +301,13 @@ def _add_pip(source: str, content: str, classname: str) -> None:
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


