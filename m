Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A2606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E7l2hKVX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOufN-000325-DM; Thu, 05 Nov 2026 05:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf4-0002qO-TU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf3-0004AC-DV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZJgzPDXNp6KmmiAAbhFuvD3REHqo8RS9MhS9UIiUCA=;
 b=E7l2hKVX7GFcQFN2ZZVTpJVp9By3Hpi6gkD1yVbQz2OnCREbOyusu9tEi9u4uOg4Do3LAN
 80NFZkFwq/yZt68DjADQYDdVkP/kB+tnKQzGCqgMNRhCEC4CmLtIxQzJ3EChq5jQmcYX6e
 OYEmrShHGsiiI9pp3rgfrbAoEGQoIY0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-vJGfFc8SNQaPF-HSZTOcdA-1; Thu,
 05 Nov 2026 05:25:34 -0500
X-MC-Unique: vJGfFc8SNQaPF-HSZTOcdA-1
X-Mimecast-MFC-AGG-ID: vJGfFc8SNQaPF-HSZTOcdA_1793874333
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A76A41955DD7
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C8611956047
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A9D521E6882; Thu, 05 Nov 2026 11:25:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 3/3] qapi/qom: Make @qapi-type mandatory in output of
 qom-list etc.
Date: Thu,  5 Nov 2026 11:25:30 +0100
Message-ID: <20261105102530.1848823-4-armbru@redhat.com>
In-Reply-To: <20261105102530.1848823-1-armbru@redhat.com>
References: <20261105102530.1848823-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit 0eee31cf108 (qapi/qom: add qapi-type to qom-list,
qom-list-properties, qom-list-get) had to make @qapi-type optional to
enable incremental conversion to QAPI-aware property registration.
This conversion is now complete: @qapi-type is always present.  Make
it mandatory.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qom.json | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 32a5926936..cc642c7ba9 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -36,8 +36,7 @@
 #        graph.
 #
 # @qapi-type: the name of the property's type as it appears in the
-#     output of ``query-qmp-schema``.  Absent if the type does not
-#     occur there.  (since 11.2)
+#     output of ``query-qmp-schema``.  (since 11.2)
 #
 # @description: if specified, the description of the property.
 #
@@ -52,7 +51,7 @@
 { 'struct': 'ObjectPropertyInfo',
   'data': { 'name': 'str',
             'type': 'str',
-            '*qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
+            'qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
             '*description': 'str',
             '*default-value': 'any' } }
 
@@ -65,8 +64,7 @@
 #     `ObjectPropertyInfo`.
 #
 # @qapi-type: the name of the property's type as it appears in the
-#     output of ``query-qmp-schema``.  Absent if the type does not
-#     occur there.  (since 11.2)
+#     output of ``query-qmp-schema``.  (since 11.2)
 #
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
@@ -80,7 +78,7 @@
 { 'struct': 'ObjectPropertyValue',
   'data': { 'name': 'str',
             'type': 'str',
-            '*qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
+            'qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
             '*value': 'any' } }
 
 ##
-- 
2.55.0


