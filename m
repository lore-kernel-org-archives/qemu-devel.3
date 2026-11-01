Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7B606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HkFlJBO8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbzl-0004uP-Dq; Sun, 01 Nov 2026 15:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzd-0004qg-T7
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbza-00079a-3s
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDePUlGiqQJYKW1u+5YkrThS4X9aa0oHrGzsSWKzJJM=;
 b=HkFlJBO89cpmnE+RDXRIh+nhReU+92V7SR9TXLgX35K4XahLeFw9W2b+201dD3ufv6mktC
 RvopSqs/6VHr0Don+PIstuDEDt3htqMmVLwMSBxvhAoQXtF0TRGIUUpUDkhMB8nlQs4GZh
 twj9wWGHRZJDVaoRy/A0PNevCbd+zn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-oFkMw6ZSPwCa-xDHHulzPg-1; Sun,
 01 Nov 2026 15:17:24 -0500
X-MC-Unique: oFkMw6ZSPwCa-xDHHulzPg-1
X-Mimecast-MFC-AGG-ID: oFkMw6ZSPwCa-xDHHulzPg_1793564243
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E753180061E
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2883F18005B0
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C133721E688B; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 11/56] qapi/qom: add qapi-type to qom-list,
 qom-list-properties, qom-list-get
Date: Sun,  1 Nov 2026 21:16:32 +0100
Message-ID: <20261101201717.3911097-12-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

QOM introspection is flawed: the type information is just a
string (ObjectPropertyInfo and ObjectPropertyValue field 'type').
Management applications need to know these strings. Their
documentation is of little help.

QAPI introspection is more powerful, and management applications
already know how to use it. Let's put it to use for QOM introspection.

Add an optional 'qapi-type' field to ObjectPropertyInfo and
ObjectPropertyValue. When present, it contains the masked type name that
can be looked up in query-qmp-schema output. Absent for properties
without a QAPI type association. Always absent for now, populated
in the following changes.

This cannot fully replace 'type', yet: it doesn't cover child and link
properties.  Mark 'unstable' for now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qom.json | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4810d53e58..df523c08c7 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -35,15 +35,24 @@
 #        qdev device type name.  Link properties form the device model
 #        graph.
 #
+# @qapi-type: the name of the property's type as it appears in the
+#     output of ``query-qmp-schema``.  Absent if the type does not
+#     occur there.  (since 11.2)
+#
 # @description: if specified, the description of the property.
 #
 # @default-value: the default value, if any (since 5.0)
 #
+# Features:
+#
+# @unstable: Member @qapi-type is experimental.
+#
 # Since: 1.2
 ##
 { 'struct': 'ObjectPropertyInfo',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
             '*description': 'str',
             '*default-value': 'any' } }
 
@@ -55,14 +64,23 @@
 # @type: the type of the property, as described in
 #     `ObjectPropertyInfo`.
 #
+# @qapi-type: the name of the property's type as it appears in the
+#     output of ``query-qmp-schema``.  Absent if the type does not
+#     occur there.  (since 11.2)
+#
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
 #
+# Features:
+#
+# @unstable: Member @qapi-type is experimental.
+#
 # Since: 10.1
 ##
 { 'struct': 'ObjectPropertyValue',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
             '*value': 'any' } }
 
 ##
-- 
2.55.0


