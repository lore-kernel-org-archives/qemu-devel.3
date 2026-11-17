Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C3606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zr8DA6x0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGup-00062U-Fw; Tue, 17 Nov 2026 05:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xTGuo-000620-AU
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:59:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xTGul-0006gu-Pw
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794913190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5puhipFiQLi4MBnetR1Vp4RZQ31wFRB/pPjtJPIeW8=;
 b=Zr8DA6x0b6mkxfKyawDevuDSyuwvdItc97lMMB818gWFGHKQWYSLJhTFLnSDxjic3if+n2
 pYlaPSuaVGjhWBgEYbmIxu2WnFSycb/DgXRcw49Bx+Hv0aWK73CvPwUywSI7YbvIyojqao
 zZJfTlyVjljLvlKIbmtcVDcXn4BTVwo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-1Aphr17dNf-7D0pmTmdSBg-1; Tue,
 17 Nov 2026 05:59:49 -0500
X-MC-Unique: 1Aphr17dNf-7D0pmTmdSBg-1
X-Mimecast-MFC-AGG-ID: 1Aphr17dNf-7D0pmTmdSBg_1794913188
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DA3C180034A
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:59:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59D8C1956047
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:59:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B8B9A21E6882; Tue, 17 Nov 2026 11:59:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 3/3] qapi/qom: Make @qapi-type mandatory in output of
 qom-list etc.
Date: Tue, 17 Nov 2026 11:59:45 +0100
Message-ID: <20261117105945.2802923-4-armbru@redhat.com>
In-Reply-To: <20261117105945.2802923-1-armbru@redhat.com>
References: <20261117105945.2802923-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Commit 0eee31cf108 (qapi/qom: add qapi-type to qom-list,
qom-list-properties, qom-list-get) had to make @qapi-type optional to
enable incremental conversion to QAPI-aware property registration.
This conversion is now complete: @qapi-type is always present.  Make
it mandatory.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/qom.json              | 10 ++++------
 tests/qtest/qmp-cmd-test.c |  9 +--------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 32a59269361..cc642c7ba97 100644
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
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 5138582bb3f..c93120a194c 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -379,15 +379,8 @@ static void test_qapi_type(void)
         QLIST_FOREACH_ENTRY(props, prop_entry) {
             QDict *prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
             const char *qapi_type = qdict_get_try_str(prop, "qapi-type");
-            const char *propname = qdict_get_str(prop, "name");
-            const char *ty = qdict_get_str(prop, "type");
 
-            if (qapi_type) {
-                g_assert_nonnull(qmp_schema_lookup(&schema, qapi_type));
-            } else {
-                g_test_message("%s.%s %s has no associated qapi-type",
-                               name, propname, ty);
-            }
+            g_assert_nonnull(qmp_schema_lookup(&schema, qapi_type));
         }
     }
     qtest_quit(qts);
-- 
2.55.0


