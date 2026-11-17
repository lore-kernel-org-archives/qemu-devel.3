Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728E606A891
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8qYEgBJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGYR-0002pZ-O4; Tue, 17 Nov 2026 05:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xTGYH-0002n0-8y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:36:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xTGYF-0005dR-Sj
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794911795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lqKb1e92EFFsRgkAy7mzV0T2hcrGkjfq63VTrv29eTw=;
 b=C8qYEgBJXY5OA+AXgb+mSgmy3UScgMeLNeuQMkmzCqm0bq3I0lVsNJH7/wrGmF3JYc6a3d
 ebDFgTEHgZxSJMK4jrYFY7tVCKX/ifXm1qfv+Y0WyRQxHjshpNBzq5B+gVFeRsYgW4nrqW
 2g4kF+QRAGkwonCkfCc59+0yHJjk6W0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-Ua-vzp9UMSC4gLcwCiAJjA-1; Tue,
 17 Nov 2026 05:36:33 -0500
X-MC-Unique: Ua-vzp9UMSC4gLcwCiAJjA-1
X-Mimecast-MFC-AGG-ID: Ua-vzp9UMSC4gLcwCiAJjA_1794911792
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BB9E18002D7
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:36:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D4011801975
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:36:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D977E21E6A04; Tue, 17 Nov 2026 11:36:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH] tests/qmp-cmd-test: Simplify @qapi-type test
Date: Tue, 17 Nov 2026 11:36:29 +0100
Message-ID: <20261117103629.2612744-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

test_qapi_type() checks that if @qapi-type is present, it resolves in
output of query-qmp-schema.  Absent @qapi-type is reported with
g_test_message except for child and link properties.

The exception became useless when we implemented @qapi-type for child
and link properties.  Drop it.

Fixes: 6955264d5821 ("qom: Convert child and link properties to QAPI-aware registration")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/qmp-cmd-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index acb7b0dd6a9..5138582bb3f 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -384,8 +384,7 @@ static void test_qapi_type(void)
 
             if (qapi_type) {
                 g_assert_nonnull(qmp_schema_lookup(&schema, qapi_type));
-            } else if (!g_str_has_prefix(ty, "child<") &&
-                       !g_str_has_prefix(ty, "link<")) {
+            } else {
                 g_test_message("%s.%s %s has no associated qapi-type",
                                name, propname, ty);
             }
-- 
2.55.0


