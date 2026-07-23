Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD24C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlQi-0003Nj-Gv; Thu, 23 Jul 2026 00:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlQW-0002zW-3p
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlQU-0004mX-Ib
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784782374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94ztoHJSekPaBu9gQO06nFEY6BVwCOp3ZmuxtD8vWVs=;
 b=ZebUIa4HBqrHwgySKQ6LICxR7hQLUo43pTBiQYivbX49KFP2Z3yte2gP9cmF3iKa1kGu2b
 q6+dVBqz3UCGeJxvGP6eyENKtKUh3s78zNgxUe37PSbP3AQA5gMseFT9nA7z++l9eP4Um0
 L7zKc4DIaJnhVxFHVqbZ7ksWgU9FuXI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-eyNaZrN6Oli8Es0NTKYNFQ-1; Thu,
 23 Jul 2026 00:52:50 -0400
X-MC-Unique: eyNaZrN6Oli8Es0NTKYNFQ-1
X-Mimecast-MFC-AGG-ID: eyNaZrN6Oli8Es0NTKYNFQ_1784782367
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D7A21977517; Thu, 23 Jul 2026 04:52:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 528D3180029D; Thu, 23 Jul 2026 04:52:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 27/44] qapi: convert trivial intro sections for
 introspect.json
Date: Thu, 23 Jul 2026 00:47:48 -0400
Message-ID: <20260723044805.527643-28-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/introspect.json | 45 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index c8432c8ed8e..bd42aac3358 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -55,9 +55,8 @@
 
 ##
 # @SchemaMetaType:
-#
-# This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
-# describes.
+#     This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
+#     describes.
 #
 # @builtin: a predefined type such as 'int' or 'bool'.
 #
@@ -112,8 +111,7 @@
 
 ##
 # @SchemaInfoBuiltin:
-#
-# Additional `SchemaInfo` members for meta-type 'builtin'.
+#     Additional `SchemaInfo` members for meta-type 'builtin'.
 #
 # @json-type: the JSON type used for this type on the wire.
 #
@@ -124,10 +122,9 @@
 
 ##
 # @JSONType:
-#
-# The four primitive and two structured types according to RFC 8259
-# section 1, plus 'int' (split off 'number'), plus the obvious top
-# type 'value'.
+#     The four primitive and two structured types according to RFC
+#     8259 section 1, plus 'int' (split off 'number'), plus the
+#     obvious top type 'value'.
 #
 # @string: JSON string
 #
@@ -153,8 +150,7 @@
 
 ##
 # @SchemaInfoEnum:
-#
-# Additional `SchemaInfo` members for meta-type 'enum'.
+#     Additional `SchemaInfo` members for meta-type 'enum'.
 #
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
@@ -178,8 +174,7 @@
 
 ##
 # @SchemaInfoEnumMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -193,8 +188,7 @@
 
 ##
 # @SchemaInfoArray:
-#
-# Additional `SchemaInfo` members for meta-type 'array'.
+#     Additional `SchemaInfo` members for meta-type 'array'.
 #
 # @element-type: the array type's element type.
 #
@@ -207,8 +201,7 @@
 
 ##
 # @SchemaInfoObject:
-#
-# Additional `SchemaInfo` members for meta-type 'object'.
+#     Additional `SchemaInfo` members for meta-type 'object'.
 #
 # @members: the object type's (non-variant) members, in no particular
 #     order.
@@ -232,8 +225,7 @@
 
 ##
 # @SchemaInfoObjectMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -257,8 +249,7 @@
 
 ##
 # @SchemaInfoObjectVariant:
-#
-# The variant members for a value of the type tag.
+#     The variant members for a value of the type tag.
 #
 # @case: a value of the type tag.
 #
@@ -272,8 +263,7 @@
 
 ##
 # @SchemaInfoAlternate:
-#
-# Additional `SchemaInfo` members for meta-type 'alternate'.
+#     Additional `SchemaInfo` members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
 #     members' wire encoding is distinct, see
@@ -288,8 +278,7 @@
 
 ##
 # @SchemaInfoAlternateMember:
-#
-# An alternate member.
+#     An alternate member.
 #
 # @type: the name of the member's type.
 #
@@ -300,8 +289,7 @@
 
 ##
 # @SchemaInfoCommand:
-#
-# Additional `SchemaInfo` members for meta-type 'command'.
+#     Additional `SchemaInfo` members for meta-type 'command'.
 #
 # @arg-type: the name of the object type that provides the command's
 #     parameters.
@@ -322,8 +310,7 @@
 
 ##
 # @SchemaInfoEvent:
-#
-# Additional `SchemaInfo` members for meta-type 'event'.
+#     Additional `SchemaInfo` members for meta-type 'event'.
 #
 # @arg-type: the name of the object type that provides the event's
 #     parameters.
-- 
2.55.0


