Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE28CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWxy-0005WD-Mo; Thu, 11 Jun 2026 00:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxw-0005GD-Sj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxv-0005Yo-B5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781151866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQ9gxAk0ZVxirQ/nsQerUhE6EQtniOZuya0ID+1Nzys=;
 b=RZAFSzbR2653vtSpdnuoyb5T2cs+gU1cWJukFNTFqTQR87pWM8MYgfkzlZ7QLNcRtmOoKM
 tZqD1TQ123TvZoW+DB0UPbMyQ/wEdqe3JFGCVwHHqGM491QPCvHUn+RRbgBCb8svGm8Kni
 JZ6OaIyiIFCgwvuOVbeWMaIDFV8S0R4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-wtsbMfa3Pia9K_iAYM5lJQ-1; Thu,
 11 Jun 2026 00:24:24 -0400
X-MC-Unique: wtsbMfa3Pia9K_iAYM5lJQ-1
X-Mimecast-MFC-AGG-ID: wtsbMfa3Pia9K_iAYM5lJQ_1781151862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6488E1955EAA; Thu, 11 Jun 2026 04:24:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57C211800583; Thu, 11 Jun 2026 04:24:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, linux-edac@vger.kernel.org,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 08/13] qapi/parser: move _insert_near_kind() method
Date: Thu, 11 Jun 2026 00:23:27 -0400
Message-ID: <20260611042332.482979-9-jsnow@redhat.com>
In-Reply-To: <20260611042332.482979-1-jsnow@redhat.com>
References: <20260611042332.482979-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Move this function out from underneath `ensure_returns` and make it
available for general purpose use as an object method instead. This is
purely a scope-level patch with no functional changes.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 97e7dacb0fd..261f8ba9f8b 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -816,6 +816,22 @@ def new_feature(self, info: QAPISourceInfo, name: str) -> None:
     def append_line(self, line: str) -> None:
         self.all_sections[-1].append_line(line)
 
+    def _insert_near_kind(
+        self,
+        kind: 'QAPIDoc.Kind',
+        new_sect: 'QAPIDoc.Section',
+        after: bool = False,
+    ) -> bool:
+        """Insert or append a new doc section at a specific point."""
+        for idx, sect in enumerate(reversed(self.all_sections)):
+            if sect.kind == kind:
+                pos = len(self.all_sections) - idx - 1
+                if after:
+                    pos += 1
+                self.all_sections.insert(pos, new_sect)
+                return True
+        return False
+
     def connect_member(self, member: 'QAPISchemaMember') -> None:
         if member.name not in self._args:
             assert member.info
@@ -850,28 +866,13 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
         self._features[feature.name].connect(feature)
 
     def ensure_returns(self, info: QAPISourceInfo) -> None:
-
-        def _insert_near_kind(
-            kind: QAPIDoc.Kind,
-            new_sect: QAPIDoc.Section,
-            after: bool = False,
-        ) -> bool:
-            for idx, sect in enumerate(reversed(self.all_sections)):
-                if sect.kind == kind:
-                    pos = len(self.all_sections) - idx - 1
-                    if after:
-                        pos += 1
-                    self.all_sections.insert(pos, new_sect)
-                    return True
-            return False
-
         if any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
             return
 
         # Stub "Returns" section for undocumented returns value
         stub = QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)
 
-        if any(_insert_near_kind(kind, stub, after) for kind, after in (
+        if any(self._insert_near_kind(kind, stub, after) for kind, after in (
                 # 1. If arguments, right after those.
                 (QAPIDoc.Kind.MEMBER, True),
                 # 2. Elif errors, right *before* those.
-- 
2.54.0


