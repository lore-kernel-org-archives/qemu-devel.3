Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEB1C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 16:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRw3p-0006QM-4o; Wed, 18 Jun 2025 12:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRw3m-0006Pu-M6
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRw3k-0007vS-UD
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750265688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REdMnHdr6nxDp/8NtzGwzQL8DvGgC98ZuuWP3ZBLj8E=;
 b=dZrqDWiLo/g5zY27yrXyt9u7Ls/tPdyzOHJZdP9mFPseJ7CGdzAxau0TdxyWLDVafjSL19
 cxFTFxdvItuJHl2WFnUUu6ce/sdzjkJY7HHODszXxowtHaZUefGOCGClZ8yPRvjLBH9MBH
 ZvJ+zOBbXKejIDSzG+R3L1T5pwdh5SQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-xGtAoRlwPqqZOSl3WA_AoA-1; Wed,
 18 Jun 2025 12:54:46 -0400
X-MC-Unique: xGtAoRlwPqqZOSl3WA_AoA-1
X-Mimecast-MFC-AGG-ID: xGtAoRlwPqqZOSl3WA_AoA_1750265683
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F1D21800284; Wed, 18 Jun 2025 16:54:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEE5D30001BD; Wed, 18 Jun 2025 16:54:35 +0000 (UTC)
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
Subject: [PATCH v3 5/5] qapi: lift restriction on using '=' in doc blocks
Date: Wed, 18 Jun 2025 12:53:53 -0400
Message-ID: <20250618165353.1980365-6-jsnow@redhat.com>
In-Reply-To: <20250618165353.1980365-1-jsnow@redhat.com>
References: <20250618165353.1980365-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py                 |  4 ----
 tests/qapi-schema/doc-bad-section.err  |  1 -
 tests/qapi-schema/doc-bad-section.json | 10 ----------
 tests/qapi-schema/doc-bad-section.out  |  0
 tests/qapi-schema/meson.build          |  1 -
 5 files changed, 16 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-bad-section.err
 delete mode 100644 tests/qapi-schema/doc-bad-section.json
 delete mode 100644 tests/qapi-schema/doc-bad-section.out

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index aad7e249f86..d43a123cd74 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -584,10 +584,6 @@ def get_doc(self) -> 'QAPIDoc':
                         doc.append_line(text)
                     line = self.get_doc_indented(doc)
                     no_more_args = True
-                elif line.startswith('='):
-                    raise QAPIParseError(
-                        self,
-                        "unexpected '=' markup in definition documentation")
                 else:
                     # plain paragraph
                     doc.ensure_untagged_section(self.info)
diff --git a/tests/qapi-schema/doc-bad-section.err b/tests/qapi-schema/doc-bad-section.err
deleted file mode 100644
index 785cacc08c4..00000000000
--- a/tests/qapi-schema/doc-bad-section.err
+++ /dev/null
@@ -1 +0,0 @@
-doc-bad-section.json:5:1: unexpected '=' markup in definition documentation
diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/doc-bad-section.json
deleted file mode 100644
index 8175d95867e..00000000000
--- a/tests/qapi-schema/doc-bad-section.json
+++ /dev/null
@@ -1,10 +0,0 @@
-# = section within an expression comment
-
-##
-# @Enum:
-# == No good here
-# @one: The _one_ {and only}
-#
-# @two is undocumented
-##
-{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
deleted file mode 100644
index e69de29bb2d..00000000000
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 9577178b6ff..c47025d16d8 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -61,7 +61,6 @@ schemas = [
   'doc-bad-event-arg.json',
   'doc-bad-feature.json',
   'doc-bad-indent.json',
-  'doc-bad-section.json',
   'doc-bad-symbol.json',
   'doc-bad-union-member.json',
   'doc-before-include.json',
-- 
2.48.1


