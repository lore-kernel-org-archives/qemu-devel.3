Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D096CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4U1-0001IG-Fi; Sun, 10 May 2026 09:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4T1-0000c6-0p
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Sz-0004lU-3w
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcXfLzNY8fSZYo9PLVA3EmHZ0GPkDr4koAHbu3BXWIg=;
 b=OpzirniKAMag+lM/JsIc0Jc7ZZ/XlcpF6j6I7x+yVB0BqGFJfEHAXj+XwzX4HUeojMRpfv
 bsFCmxa6gZ8V6oFI1TPC3YE67H2tQ/UlFVu+PmbVVA7JchgC5BWBachHGBlPM4X7JIQhko
 cEU4q2sfoj8Sa8ReMvJto5q5R+G34l0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-ouaLQO3BP7mNG6Nkb1QhOA-1; Sun,
 10 May 2026 09:45:06 -0400
X-MC-Unique: ouaLQO3BP7mNG6Nkb1QhOA-1
X-Mimecast-MFC-AGG-ID: ouaLQO3BP7mNG6Nkb1QhOA_1778420705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 896C3180034E
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:45:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53E9219560A7; Sun, 10 May 2026 13:45:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:05 +0400
Subject: [PATCH 08/54] qapi/qom: add qapi-type field to ObjectPropertyInfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-8-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=l98NcHIYxcIgRoI9lT+AEGU4cey8Hr4xwKBBC+to5GQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItuHAYzltGcdqubEA5XlgSxkpr2aiKaRVLy/
 WNTH1zgZTGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5fMTEACt2AGvjc4zTcN67lYHel5D8sT5gzgMSiwqeqlbfWxOzlZC9sNFYmKhfmogdbZ8e4mgFEU
 yb0ERDt9gQYS6lwIBSWg5oUyJEKZgmOGbdK9ui1AM4gsLeZ7etcghQm6ZqBfBV+dN9v8OGfJMwX
 Jaxui/cwqYbRMvrHjK42FwwpU9Hpjs/e/ryCmnMWCeNQSxXnuw8q462IiYJowrU0rTcBT3EdloX
 Y52OgUbF/UbaK4G00M/KG15vilzLYmhTGhYAv+UQtH2jyXKANbDAKPDBtk0lYUMkV3El0cNJO8n
 Qv6LxwsBYXb+qBoL5EIcQx1T91lsrI9EbL7uJoo8JeGSE7832nmZ+JCqIWWPo6JhJ2gc0hAeaRC
 B3lTqyyDG0noZGEVKa66iU/541n2V+1bJnW4sd+LIVpaVNKVY4i6cUzQ6tJMIKSJHo1P2z90+H3
 XYdHwv0sa3SYlJQurekSuYvXrydEoXxJ5GyFsbcgNm0IbYM2Ej7aU1GeVv/sCnvC3+FnrXnoY9+
 nylhcixYUU8KobUaKfhxJSu/Cx9X4C0XDRT9xvqsU7bN9uQAedyl48i9rZ1U1YLZ/Ja/mCu+r0N
 XKDmgxHPh+l8iqO8tRaORfEiqCu/S2rd6YRne0hNs5y889J0LyBGSoeStp6YlfT0Q0N+WKybiI+
 erMwQ42wk2RC8tQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an optional 'qapi-type' field to ObjectPropertyInfo and
ObjectPropertyValue. When present, it contains the masked type name that
can be looked up in query-qmp-schema output. Absent for properties
without a QAPI type association.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/qom.json | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087c..a655be0beaa 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -35,6 +35,11 @@
 #        qdev device type name.  Link properties form the device model
 #        graph.
 #
+# @qapi-type: if the property was registered with a QAPI type
+#     association, the type name as it appears in the output of
+#     ``query-qmp-schema``.  Absent for properties without a QAPI
+#     type association.  (since 11.1)
+#
 # @description: if specified, the description of the property.
 #
 # @default-value: the default value, if any (since 5.0)
@@ -44,6 +49,7 @@
 { 'struct': 'ObjectPropertyInfo',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*description': 'str',
             '*default-value': 'any' } }
 
@@ -55,6 +61,11 @@
 # @type: the type of the property, as described in
 #     `ObjectPropertyInfo`.
 #
+# @qapi-type: if the property was registered with a QAPI type
+#     association, the type name as it appears in the output of
+#     ``query-qmp-schema``.  Absent for properties without a QAPI
+#     type association.  (since 11.1)
+#
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
 #
@@ -63,6 +74,7 @@
 { 'struct': 'ObjectPropertyValue',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*value': 'any' } }
 
 ##

-- 
2.54.0


