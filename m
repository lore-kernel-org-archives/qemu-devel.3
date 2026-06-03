Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E975CD6E68
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcBc-0000BZ-Mt; Tue, 02 Jun 2026 23:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcBb-0000Ay-Gm
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcBa-0002Ov-6D
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780456949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eD93VbLNcb0i8xKYOQN6HBmq0xjc5UHNJ/CSbLRm+fI=;
 b=XZl8j05ghuARzEYwpX2jW+4ulfo47M8reB4t41DsRt1WPaFFBmpmfuscR5z2HrmFCGA9Am
 enm4YyxrN21VDj6/4ZFh4Lxw999sSr0BsSkbPrhDCWKlf2bRyGz8EJKxt2M8hW739gTzY8
 rt7dZBaxXJdtzc8qN5hexPuf2D2n3I4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-rd_0QzmwMoObrbOlYuTP6Q-1; Tue,
 02 Jun 2026 23:22:26 -0400
X-MC-Unique: rd_0QzmwMoObrbOlYuTP6Q-1
X-Mimecast-MFC-AGG-ID: rd_0QzmwMoObrbOlYuTP6Q_1780456944
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F58F1801238; Wed,  3 Jun 2026 03:22:24 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 572BC3000203; Wed,  3 Jun 2026 03:22:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 04/16] qapi/docs: add has_features property
Date: Tue,  2 Jun 2026 23:21:49 -0400
Message-ID: <20260603032201.993015-5-jsnow@redhat.com>
In-Reply-To: <20260603032201.993015-1-jsnow@redhat.com>
References: <20260603032201.993015-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Begin preparing to remove public access to the .features member by
introducing a semantic "has features" property instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index b33edbba74f..dcc58170bd5 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -555,7 +555,7 @@ def get_doc(self) -> 'QAPIDoc':
                     break
                 # Non-blank line, first of a section
                 if line == 'Features:':
-                    if doc.features:
+                    if doc.has_features:
                         raise QAPIParseError(
                             self, "duplicated 'Features:' line")
                     self.accept(False)
@@ -570,7 +570,7 @@ def get_doc(self) -> 'QAPIDoc':
                         if text:
                             doc.append_line(text)
                         line = self.get_doc_indented(doc)
-                    if not doc.features:
+                    if not doc.has_features:
                         raise QAPIParseError(
                             self, 'feature descriptions expected')
                     no_more_args = True
@@ -741,6 +741,10 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # "Since" section
         self.since: Optional[QAPIDoc.Section] = None
 
+    @property
+    def has_features(self) -> bool:
+        return bool(self.features)
+
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
-- 
2.54.0


