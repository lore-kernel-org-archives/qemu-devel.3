Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3741ECA5FAB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJzS-0008By-K0; Mon, 28 Sep 2026 18:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJzN-0007ul-W2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJzM-0006I4-1S
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLHJm8TXcyeIk6tiCEQAhsRwOUnRyEQUxRThN5sFETI=;
 b=K4PLQdbgNUOOHiKqr/c+fqr4GE0dJ7jNBgekPM19KVThau/jMaMvnSqTiPKWrKDijNJ4ps
 Xpj7C+GEebvepgfv9Ghdqnrw+NC48oA+0NCxT+uYDYPcaEzwHa2J0a2jQKUIW3m+w63mC1
 vLrPaG4+j3E5vYnwfxgmtFaoe0e1pX0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-Bi4dlrVgPqOurGcUS5AZ8Q-1; Mon,
 28 Sep 2026 18:38:19 -0400
X-MC-Unique: Bi4dlrVgPqOurGcUS5AZ8Q-1
X-Mimecast-MFC-AGG-ID: Bi4dlrVgPqOurGcUS5AZ8Q_1790635098
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB9A4180057C; Mon, 28 Sep 2026 22:38:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 612D619560AB; Mon, 28 Sep 2026 22:38:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, Alex Williamson <alex@shazbot.org>,
 Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 10/14] qapi/parser: add _append() method
Date: Mon, 28 Sep 2026 18:36:53 -0400
Message-ID: <20260928223657.2303684-11-jsnow@redhat.com>
In-Reply-To: <20260928223657.2303684-1-jsnow@redhat.com>
References: <20260928223657.2303684-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This method is intended to become the sole point of appending new
sections to the section list, prohibiting outside callers from
accessing the list of sections directly.

A forthcoming commit will actually convert the "all_sections" field to
be a private field to begin enforcing that no outside callers are
manipulating the section list from outside of this class.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 5fc9c18c81d..0dca1acba4c 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -542,7 +542,7 @@ def get_doc(self) -> 'QAPIDoc':
             if not symbol:
                 raise QAPIParseError(self, "name required after '@'")
             doc = QAPIDoc(info, symbol)
-            doc.all_sections.append(QAPIDoc.Section(info, QAPIDoc.Kind.INTRO))
+            doc.new_tagged_section(info, QAPIDoc.Kind.INTRO)
             line = self.get_doc_indented(doc)
             no_more_args = False
             last_ordered_section = QAPIDoc.Kind.INTRO
@@ -772,6 +772,33 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
     def has_features(self) -> bool:
         return bool(self._features)
 
+    def _append(self, section: 'QAPIDoc.Section') -> None:
+        """
+        Primary internal interface for adding a new section.
+
+        It is intended to become the sole access point for adding new
+        sections to the QAPIDoc section list, but we are currently in
+        a transitional phase where other methods access the section
+        list directly to do insertions of generated sections at
+        targeted points.
+        """
+        if section.kind == QAPIDoc.Kind.RETURNS:
+            if self._returns:
+                raise QAPISemError(
+                    section.info, "duplicated '%s' section" % section.kind)
+            self._returns = section
+        elif section.kind == QAPIDoc.Kind.ERRORS:
+            if self._errors:
+                raise QAPISemError(
+                    section.info, "duplicated '%s' section" % section.kind)
+            self._errors = section
+        elif section.kind == QAPIDoc.Kind.SINCE:
+            if self.since:
+                raise QAPISemError(
+                    section.info, "duplicated '%s' section" % section.kind)
+            self.since = section
+        self.all_sections.append(section)
+
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
@@ -797,7 +824,7 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
 
         # start new section
         section = self.Section(info, kind)
-        self.all_sections.append(section)
+        self._append(section)
 
     def new_tagged_section(
         self,
@@ -805,22 +832,7 @@ def new_tagged_section(
         kind: 'QAPIDoc.Kind',
     ) -> None:
         section = self.Section(info, kind)
-        if kind == QAPIDoc.Kind.RETURNS:
-            if self._returns:
-                raise QAPISemError(
-                    info, "duplicated '%s' section" % kind)
-            self._returns = section
-        elif kind == QAPIDoc.Kind.ERRORS:
-            if self._errors:
-                raise QAPISemError(
-                    info, "duplicated '%s' section" % kind)
-            self._errors = section
-        elif kind == QAPIDoc.Kind.SINCE:
-            if self.since:
-                raise QAPISemError(
-                    info, "duplicated '%s' section" % kind)
-            self.since = section
-        self.all_sections.append(section)
+        self._append(section)
 
     def _new_description(
         self,
@@ -834,7 +846,7 @@ def _new_description(
         if name in desc:
             raise QAPISemError(info, "'%s' parameter name duplicated" % name)
         section = self.ArgSection(info, kind, name)
-        self.all_sections.append(section)
+        self._append(section)
         desc[name] = section
 
     def new_argument(self, info: QAPISourceInfo, name: str) -> None:
-- 
2.55.0


