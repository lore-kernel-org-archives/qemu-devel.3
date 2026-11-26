Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60D606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L42fCZVh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWJ3-0008NS-4G; Thu, 26 Nov 2026 05:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIe-0008BT-IO
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIb-0006iR-ID
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4uXfk4qDq+zTFu8XagmlUY80VJzweXnCNuzSi5EFdc=;
 b=L42fCZVhnHNGxeFShHkdJPOAyT1JrehhJoDtxIjWepmLIax3yk8CyoSILX3T2LYAVqW58L
 2OpnaOBTgKD9S8c3v8b45EUR26zKr6kDYbfJjErZ02be2ZvkOPTTBMIVLRtGtFhcMq6bym
 TzJwc5h1UrAzc3oUfDkX/8K0+txVF7s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-mf3N4OoiNt-vcmfx1e-8yw-1; Thu,
 26 Nov 2026 10:01:49 +0000
X-MC-Unique: mf3N4OoiNt-vcmfx1e-8yw-1
X-Mimecast-MFC-AGG-ID: mf3N4OoiNt-vcmfx1e-8yw_1795687308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E8DC1800665; Thu, 26 Nov 2026 10:01:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3DCE18011DC; Thu, 26 Nov 2026 10:01:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04E4921E6894; Thu, 26 Nov 2026 11:01:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 16/16] qom: Deprecate ObjectPropertyInfo,
 ObjectPropertyValue member @type
Date: Thu, 26 Nov 2026 11:01:39 +0100
Message-ID: <20261126100139.3557890-17-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use members @kind, @qapi-type, and @qom-type instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst |  5 +++++
 qapi/qom.json             | 14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5ab329705b6..bcae9c0afbc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -190,6 +190,11 @@ so the concept of an 'unavailable' trace event no longer exists.
 The ``ignore-unavailable`` parameter in ``trace-event-set-state``
 thus has no effect and should no longer be used.
 
+``qom-list``, ``qom-list-property``, ``qom-list-get`` return value member @type  (since 12.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use members @kind, @qapi-type, and @qom-type instead.
+
 Human Machine Protocol (HMP) commands
 -------------------------------------
 
diff --git a/qapi/qom.json b/qapi/qom.json
index 0b274787b3f..e41add67059 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -66,15 +66,16 @@
 #
 # Features:
 #
-# @unstable: Member @qapi-type is experimental.
+# @deprecated: Member @type is deprecated.  Use @kind, @qapi-type, and
+#     @qom-type instead.
 #
 # Since: 1.2
 ##
 { 'union': 'ObjectPropertyInfo',
   'base': { 'name': 'str',
             'kind': 'ObjectPropertyKind',
-            'type': 'str',
-            'qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
+            'type': { 'type': 'str', 'features': [ 'deprecated' ] },
+            'qapi-type': 'str',
             '*description': 'str',
             '*default-value': 'any' },
   'discriminator': 'kind',
@@ -99,15 +100,16 @@
 #
 # Features:
 #
-# @unstable: Member @qapi-type is experimental.
+# @deprecated: Member @type is deprecated.  Use @kind, @qapi-type, and
+#     @qom-type instead.
 #
 # Since: 10.1
 ##
 { 'union': 'ObjectPropertyValue',
   'base': { 'name': 'str',
             'kind': 'ObjectPropertyKind',
-            'type': 'str',
-            'qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
+            'type': { 'type': 'str', 'features': [ 'deprecated' ] },
+            'qapi-type': 'str',
             '*value': 'any' },
   'discriminator': 'kind',
   'data': { 'child': 'ObjectPropertyQomType',
-- 
2.55.0


