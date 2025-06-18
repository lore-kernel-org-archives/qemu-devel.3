Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8091DC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 16:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRw3X-0006LN-It; Wed, 18 Jun 2025 12:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRw3O-0006Hu-TB
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRw3N-0007sU-8r
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750265664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WA2NiORHMUeglBWJeEmDtQ3FRSv9SINoOXQuxQfxgpw=;
 b=c0f09l+GMUJXWox4tiHgcuJGEnr6VFMJgz/hLtShG2fkSODFVJm/ICj3pwsKJIgUZtsVKf
 ScWXmfU6s2GSvbLeq2VXBewVC4xvVjk9emr415xpQLpXQIsrn3KzmiUCtdq4O7HxNNL5Iq
 0Pey4PCLoVXYos0Mrm45QHgCRKBKtLY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-szOZ2FWJNmCC0MP7-XyFjg-1; Wed,
 18 Jun 2025 12:54:21 -0400
X-MC-Unique: szOZ2FWJNmCC0MP7-XyFjg-1
X-Mimecast-MFC-AGG-ID: szOZ2FWJNmCC0MP7-XyFjg_1750265658
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B96419560B3; Wed, 18 Jun 2025 16:54:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EC1530001B7; Wed, 18 Jun 2025 16:54:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Fan Ni <fan.ni@samsung.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fabiano Rosas <farosas@suse.de>, Kashyap Chamarthy <kchamart@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 2/5] docs/sphinx: parse @references in freeform text
Date: Wed, 18 Jun 2025 12:53:50 -0400
Message-ID: <20250618165353.1980365-3-jsnow@redhat.com>
In-Reply-To: <20250618165353.1980365-1-jsnow@redhat.com>
References: <20250618165353.1980365-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Oversight in the new qapidoc transmogrifier: @references in freeform
documentation blocks were not being transformed to literals. This fixes
that, and the next patch ensures that we're testing for this O:-)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5374dee8fad..adc14ade456 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -218,6 +218,11 @@ def generate_field(
         typ = self.format_type(member)
         self.add_field(kind, member.name, body, info, typ)
 
+    @staticmethod
+    def reformat_arobase(text: str) -> str:
+        """ reformats @var to ``var`` """
+        return re.sub(r"@([\w-]+)", r"``\1``", text)
+
     # Transmogrification helpers
 
     def visit_paragraph(self, section: QAPIDoc.Section) -> None:
@@ -361,8 +366,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
 
         # Add sections in source order:
         for i, section in enumerate(sections):
-            # @var is translated to ``var``:
-            section.text = re.sub(r"@([\w-]+)", r"``\1``", section.text)
+            section.text = self.reformat_arobase(section.text)
 
             if section.kind == QAPIDoc.Kind.PLAIN:
                 self.visit_paragraph(section)
@@ -405,7 +409,7 @@ def visit_freeform(self, doc: QAPIDoc) -> None:
 
         assert len(doc.all_sections) == 1, doc.all_sections
         body = doc.all_sections[0]
-        text = body.text
+        text = self.reformat_arobase(body.text)
         info = doc.info
 
         if re.match(r"=+ ", text):
-- 
2.48.1


