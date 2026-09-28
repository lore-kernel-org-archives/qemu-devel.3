Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0519CCA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJzM-0007mD-Vp; Mon, 28 Sep 2026 18:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJzJ-0007bM-93
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJzH-0006HW-GP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILOU/mjmXPUKda3Kx11h8rE+p0k6QaMYhACQPDS2C0w=;
 b=FnXJGGR6Urpihi15g+KNZhsLa7zRTPyu+cTgIt8MSiKOzBboCavWdNVZjlTEc17he6j1U3
 9ITJtldflyS6szrLT39MyUwRArSIs3DiXVfnjD5d6HmV1G/DcPqIcTfiNCTiR1jO2YQax+
 I2Me5n+uggeNP33DExVOw6pGoWu4Jps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-7wpyy1KLO5G-xJTL7l3Btw-1; Mon,
 28 Sep 2026 18:38:15 -0400
X-MC-Unique: 7wpyy1KLO5G-xJTL7l3Btw-1
X-Mimecast-MFC-AGG-ID: 7wpyy1KLO5G-xJTL7l3Btw_1790635093
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A7E21800BE4; Mon, 28 Sep 2026 22:38:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D564019560AB; Mon, 28 Sep 2026 22:38:08 +0000 (UTC)
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
Subject: [PATCH 09/14] qapi/parser: remove _insert_after_intro() helper
Date: Mon, 28 Sep 2026 18:36:52 -0400
Message-ID: <20260928223657.2303684-10-jsnow@redhat.com>
In-Reply-To: <20260928223657.2303684-1-jsnow@redhat.com>
References: <20260928223657.2303684-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I promised I'd remove this.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 49 ++++++------------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c14bff2cbc3..5fc9c18c81d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -862,49 +862,15 @@ def _insert_near_kind(
                 return True
         return False
 
-    def _insert_after_intro(
-        self,
-        section: 'QAPIDoc.Section',
-    ) -> None:
-        """
-        Insert a section immediately after the intro section.
-
-        While we convert DETAILS sections to INTRO sections, all
-        contiguous INTRO/DETAILS sections at the start of a QAPIDoc
-        section list are treated as "the intro".
-
-        Once INTRO conversion is complete, this helper will no longer be
-        needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
-        be sufficient.
-        """
-        first = self.all_sections[0]
-        if first.text and first.kind == QAPIDoc.Kind.INTRO:
-            # First section is introduction and is non-empty: insert here.
-            # Rest assured all of this ugliness will very soon go away.
-            # Pinkie-swear.
-            self.all_sections.insert(1, section)
-            return
-
-        index = 0
-        for index, ref_section in enumerate(self.all_sections):
-            if ref_section.kind.name in ("INTRO", "DETAILS"):
-                continue
-            break
-        else:
-            index += 1
-
-        self.all_sections.insert(index, section)
-
     def append_member_stub(self, stub: 'QAPIDoc.Section') -> None:
-
         """
         Append a stub section after any Member sections.
         """
         if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
             return
 
-        # No MEMBER sections present. Insert after INTRO/DETAILS sections.
-        self._insert_after_intro(stub)
+        # No MEMBER sections present. Insert after INTRO section.
+        self._insert_near_kind(QAPIDoc.Kind.INTRO, stub, after=True)
 
     def connect_member(self, member: 'QAPISchemaMember') -> None:
         if member.name not in self._args:
@@ -932,10 +898,10 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
     def ensure_returns(self, info: QAPISourceInfo) -> None:
         # This is more complicated than it ought to be.  The doc
         # parser should already know where a generated RETURNS section
-        # should go.  It currently doesn't, mostly because it accepts
-        # tagged sections in any order.
+        # should go.  It currently doesn't.
         #
-        # TODO: Tighten doc syntax and simplify.
+        # TODO: Take advantage of the new strict section ordering and
+        # simplify this algorithm.
 
         if any(s.kind == QAPIDoc.Kind.RETURNS for s in self.all_sections):
             return
@@ -950,12 +916,11 @@ def ensure_returns(self, info: QAPISourceInfo) -> None:
                 (QAPIDoc.Kind.ERRORS, False),
                 # 3. Elif features, right *before* those.
                 (QAPIDoc.Kind.FEATURE, False),
+                # 4. Else, right *after* the intro.
+                (QAPIDoc.Kind.INTRO, True),
         )):
             return
 
-        # Otherwise, it should go right after the intro.
-        self._insert_after_intro(stub)
-
     def check_expr(self, expr: QAPIExpression) -> None:
         if 'command' in expr:
             if self._returns and 'returns' not in expr:
-- 
2.55.0


