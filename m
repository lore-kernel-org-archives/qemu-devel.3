Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DEFC30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 22:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMb3U-0007VK-QD; Wed, 26 Jun 2024 18:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb3L-0007Im-Lb
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb3B-0002X0-Sz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719440616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKz3f2EsAMNyOPORvinM7qC80QmtpCrY4YjUe/+sB1k=;
 b=VTwHB+LGTNS9s7n9v0ZOFFr/Z9POuPie/fmPmhasAiGeZw9uidh3Ff1k2mTq+QV8MjsC3v
 bCbaO8givhnmC9G38Qb9wdFxnBWDLHkw9W/+gLSYtX8xpLqkUzV4sufWPt1Y6hRSupJwuE
 BQbUyhD9MNSSOlIoM39MJ6X8DeOyGtQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-RZ3_PjRDN-SmyN2NFFA-Xw-1; Wed,
 26 Jun 2024 18:23:32 -0400
X-MC-Unique: RZ3_PjRDN-SmyN2NFFA-Xw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8157F19560AB; Wed, 26 Jun 2024 22:23:30 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76ECE1955E72; Wed, 26 Jun 2024 22:23:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 13/21] qapi/parser: don't parse rST markup as section
 headers
Date: Wed, 26 Jun 2024 18:21:19 -0400
Message-ID: <20240626222128.406106-14-jsnow@redhat.com>
In-Reply-To: <20240626222128.406106-1-jsnow@redhat.com>
References: <20240626222128.406106-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The double-colon synax is rST formatting that precedes a literal code
block. We do not want to capture these as QAPI-specific sections.

Coerce blocks that start with e.g. "Example::" to be parsed as untagged
paragraphs instead of special tagged sections.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py          | 9 +++++++--
 tests/qapi-schema/doc-good.json | 3 +++
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.txt  | 3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 0a13f0f541a..6ad5663e545 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -544,10 +544,15 @@ def get_doc(self) -> 'QAPIDoc':
                         line = self.get_doc_indented(doc)
                     no_more_args = True
                 elif match := re.match(
-                        r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
-                        line):
+                        r'(Returns|Errors|Since|Notes?|Examples?|TODO)'
+                        r'(?!::): *',
+                        line,
+                ):
                     # tagged section
 
+                    # Note: "sections" with two colons are left alone as
+                    # rST markup and not interpreted as a section heading.
+
                     # TODO: Remove this error sometime in 2025 or so
                     # after we've fully transitioned to the new qapidoc
                     # generator.
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 32ff910b4f8..107123f8a8d 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -181,6 +181,9 @@
 #  - *verbatim*
 #  - {braces}
 #
+# Note::
+#    Ceci n'est pas une note
+#
 # Since: 2.10
 ##
 { 'command': 'cmd',
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 631dc9f8dad..bd876b6542d 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -190,6 +190,9 @@ frobnicate
     section=Examples
  - *verbatim*
  - {braces}
+    section=None
+Note::
+   Ceci n'est pas une note
     section=Since
 2.10
 doc symbol=cmd-boxed
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index d8bfa742c2f..30d457e5488 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -231,6 +231,9 @@ Examples
    - *verbatim*
    - {braces}
 
+Note::
+   Ceci n'est pas une note
+
 
 Since
 ~~~~~
-- 
2.45.0


