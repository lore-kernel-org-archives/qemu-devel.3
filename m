Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69777C61DC7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJWS-0003wm-1A; Wed, 26 Aug 2026 15:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWL-0003oJ-7o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWJ-0006XS-Hb
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQLl9Fz/e90VKbZH8iPZEXrmE8EWsrDRt4hVfZ8Hrwo=;
 b=MxsgQyqiijOjJhdstPMfVRbuvswei/OZXm88SCHHwKotXDrIn/3yLJwnd+ruUCPmh0lrHo
 eHi6DiRLPzf2zzTABiTZ76MVmyU9DZr7UsLUL7iaeVGWZK/LoEdWTRgFyTWMgWbL6TamEx
 5D52RrA98ki/mGE8Va2FfEn/kL5QnUc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-xjXzKdKiNsqqhXlL2uTMtw-1; Wed,
 26 Aug 2026 15:42:43 -0400
X-MC-Unique: xjXzKdKiNsqqhXlL2uTMtw-1
X-Mimecast-MFC-AGG-ID: xjXzKdKiNsqqhXlL2uTMtw_1787773360
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4F5D19541B5; Wed, 26 Aug 2026 19:42:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCBE31800577; Wed, 26 Aug 2026 19:42:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 26/43] qapi: convert trivial intro sections for
 introspect.json
Date: Wed, 26 Aug 2026 15:38:23 -0400
Message-ID: <20260826193840.2152000-27-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/introspect.json | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index c8432c8ed8e..172ed389997 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -112,8 +112,7 @@
 
 ##
 # @SchemaInfoBuiltin:
-#
-# Additional `SchemaInfo` members for meta-type 'builtin'.
+#     Additional `SchemaInfo` members for meta-type 'builtin'.
 #
 # @json-type: the JSON type used for this type on the wire.
 #
@@ -124,10 +123,9 @@
 
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
@@ -153,8 +151,7 @@
 
 ##
 # @SchemaInfoEnum:
-#
-# Additional `SchemaInfo` members for meta-type 'enum'.
+#     Additional `SchemaInfo` members for meta-type 'enum'.
 #
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
@@ -178,8 +175,7 @@
 
 ##
 # @SchemaInfoEnumMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -193,8 +189,7 @@
 
 ##
 # @SchemaInfoArray:
-#
-# Additional `SchemaInfo` members for meta-type 'array'.
+#     Additional `SchemaInfo` members for meta-type 'array'.
 #
 # @element-type: the array type's element type.
 #
@@ -207,8 +202,7 @@
 
 ##
 # @SchemaInfoObject:
-#
-# Additional `SchemaInfo` members for meta-type 'object'.
+#     Additional `SchemaInfo` members for meta-type 'object'.
 #
 # @members: the object type's (non-variant) members, in no particular
 #     order.
@@ -232,8 +226,7 @@
 
 ##
 # @SchemaInfoObjectMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -257,8 +250,7 @@
 
 ##
 # @SchemaInfoObjectVariant:
-#
-# The variant members for a value of the type tag.
+#     The variant members for a value of the type tag.
 #
 # @case: a value of the type tag.
 #
@@ -272,8 +264,7 @@
 
 ##
 # @SchemaInfoAlternate:
-#
-# Additional `SchemaInfo` members for meta-type 'alternate'.
+#     Additional `SchemaInfo` members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
 #     members' wire encoding is distinct, see
@@ -288,8 +279,7 @@
 
 ##
 # @SchemaInfoAlternateMember:
-#
-# An alternate member.
+#     An alternate member.
 #
 # @type: the name of the member's type.
 #
@@ -300,8 +290,7 @@
 
 ##
 # @SchemaInfoCommand:
-#
-# Additional `SchemaInfo` members for meta-type 'command'.
+#     Additional `SchemaInfo` members for meta-type 'command'.
 #
 # @arg-type: the name of the object type that provides the command's
 #     parameters.
@@ -322,8 +311,7 @@
 
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


