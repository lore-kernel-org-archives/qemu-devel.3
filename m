Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BE2C25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s70AP-0005ji-B1; Tue, 14 May 2024 17:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AN-0005iG-RC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AI-0008Vl-PV
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9rsNEg/0fHHhNyBB2vUXiONXKYYjwjhf809QplAhvk=;
 b=GpvjXvIck7rF3nYA9ymGae3dfiJlz5D/X/ps82s9I/OCD+5JFX2rlE/Lw3KQjEsNYLX6/R
 8zsrIOLib9SrWgqbmpqKGXYEqqSu60fugTzmhN7cQc+bDrtSLG8k/AFxiBMJlBXG3c51Vd
 xL2BIEFdBZgYXzki+3St68MT18g8zv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-IiRXHntDOWWzkw1Q8xLwAg-1; Tue, 14 May 2024 17:58:08 -0400
X-MC-Unique: IiRXHntDOWWzkw1Q8xLwAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A03D1801211;
 Tue, 14 May 2024 21:58:07 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80F316BC5;
 Tue, 14 May 2024 21:58:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 07/20] qapi/parser: add semantic 'kind' parameter to
 QAPIDoc.Section
Date: Tue, 14 May 2024 17:57:26 -0400
Message-ID: <20240514215740.940155-8-jsnow@redhat.com>
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When iterating all_sections, this is helpful to be able to distinguish
"members" from "features"; the only other way to do so is to
cross-reference these sections against QAPIDoc.args or QAPIDoc.features,
but if the desired end goal for QAPIDoc is to remove everything except
all_sections, we need *something* accessible to distinguish them.

To keep types simple, add this semantic parameter to the base Section
and not just ArgSection; we can use this to filter out paragraphs and
tagged sections, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 161768b8b96..cf4cbca1c1f 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -613,21 +613,27 @@ class QAPIDoc:
 
     class Section:
         # pylint: disable=too-few-public-methods
-        def __init__(self, info: QAPISourceInfo,
-                     tag: Optional[str] = None):
+        def __init__(
+            self,
+            info: QAPISourceInfo,
+            tag: Optional[str] = None,
+            kind: str = 'paragraph',
+        ):
             # section source info, i.e. where it begins
             self.info = info
             # section tag, if any ('Returns', '@name', ...)
             self.tag = tag
             # section text without tag
             self.text = ''
+            # section type - {paragraph, feature, member, tagged}
+            self.kind = kind
 
         def append_line(self, line: str) -> None:
             self.text += line + '\n'
 
     class ArgSection(Section):
-        def __init__(self, info: QAPISourceInfo, tag: str):
-            super().__init__(info, tag)
+        def __init__(self, info: QAPISourceInfo, tag: str, kind: str):
+            super().__init__(info, tag, kind)
             self.member: Optional['QAPISchemaMember'] = None
 
         def connect(self, member: 'QAPISchemaMember') -> None:
@@ -676,7 +682,7 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
         self.all_sections.append(section)
 
     def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
-        section = self.Section(info, tag)
+        section = self.Section(info, tag, "tagged")
         if tag == 'Returns':
             if self.returns:
                 raise QAPISemError(
@@ -696,20 +702,21 @@ def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
         self.all_sections.append(section)
 
     def _new_description(self, info: QAPISourceInfo, name: str,
+                         kind: str,
                          desc: Dict[str, ArgSection]) -> None:
         if not name:
             raise QAPISemError(info, "invalid parameter name")
         if name in desc:
             raise QAPISemError(info, "'%s' parameter name duplicated" % name)
-        section = self.ArgSection(info, '@' + name)
+        section = self.ArgSection(info, '@' + name, kind)
         self.all_sections.append(section)
         desc[name] = section
 
     def new_argument(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, self.args)
+        self._new_description(info, name, 'member', self.args)
 
     def new_feature(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, self.features)
+        self._new_description(info, name, 'feature', self.features)
 
     def append_line(self, line: str) -> None:
         self.all_sections[-1].append_line(line)
@@ -722,7 +729,7 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
             self.args[member.name] = QAPIDoc.ArgSection(
-                self.info, '@' + member.name)
+                self.info, '@' + member.name, 'member')
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
-- 
2.44.0


