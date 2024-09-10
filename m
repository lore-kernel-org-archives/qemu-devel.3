Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5455FEDE9A6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41n-0007Jv-KS; Tue, 10 Sep 2024 12:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41V-0006ji-N3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41T-0007YR-3Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvJ3I/LFPv/AoNzC4WsomuASlFhsZEcwMqPZXb4j8i8=;
 b=get+OCmnFOMl8ki983dvAWxuRoON0onvdZUDiY368xtsxWaAgTQpeqWtihyewPHSol0b6O
 XrUf4Wv01KN5VZPis9tUqIbm9A6sv13Q5orDB3BKgGpNw+aNN3Z6iu2br1R4BTP+GOKUIH
 wA/HNYGxblLWl9vkD6vhV4f5FZ7XAvA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-P_mH9M-iPL2jwDYi34h3Rw-1; Tue,
 10 Sep 2024 12:47:18 -0400
X-MC-Unique: P_mH9M-iPL2jwDYi34h3Rw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 557031955DCE; Tue, 10 Sep 2024 16:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B36019560AD; Tue, 10 Sep 2024 16:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 796AE21E692E; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/19] tests/qapi-schema: Drop temporary 'prefix'
Date: Tue, 10 Sep 2024 18:46:57 +0200
Message-ID: <20240910164714.1993531-3-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Recent commit "qapi: Smarter camel_to_upper() to reduce need for
'prefix'" added a temporary 'prefix' to delay changing the generated
code.

Revert it.  This changes TestUnionEnumA's generated enumeration
constant prefix from TEST_UNION_ENUMA to TEST_UNION_ENUM_A.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240904111836.3273842-3-armbru@redhat.com>
---
 tests/unit/test-qobject-input-visitor.c  | 4 ++--
 tests/unit/test-qobject-output-visitor.c | 4 ++--
 tests/qapi-schema/qapi-schema-test.json  | 1 -
 tests/qapi-schema/qapi-schema-test.out   | 1 -
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 024e26c49e..5479e68237 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -720,7 +720,7 @@ static void test_visitor_in_union_in_union(TestInputVisitorData *data,
 
     visit_type_TestUnionInUnion(v, NULL, &tmp, &error_abort);
     g_assert_cmpint(tmp->type, ==, TEST_UNION_ENUM_VALUE_A);
-    g_assert_cmpint(tmp->u.value_a.type_a, ==, TEST_UNION_ENUMA_VALUE_A1);
+    g_assert_cmpint(tmp->u.value_a.type_a, ==, TEST_UNION_ENUM_A_VALUE_A1);
     g_assert_cmpint(tmp->u.value_a.u.value_a1.integer, ==, 2);
     g_assert_cmpint(strcmp(tmp->u.value_a.u.value_a1.name, "fish"), ==, 0);
 
@@ -734,7 +734,7 @@ static void test_visitor_in_union_in_union(TestInputVisitorData *data,
 
     visit_type_TestUnionInUnion(v, NULL, &tmp, &error_abort);
     g_assert_cmpint(tmp->type, ==, TEST_UNION_ENUM_VALUE_A);
-    g_assert_cmpint(tmp->u.value_a.type_a, ==, TEST_UNION_ENUMA_VALUE_A2);
+    g_assert_cmpint(tmp->u.value_a.type_a, ==, TEST_UNION_ENUM_A_VALUE_A2);
     g_assert_cmpint(tmp->u.value_a.u.value_a2.integer, ==, 1729);
     g_assert_cmpint(tmp->u.value_a.u.value_a2.size, ==, 87539319);
 
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 1535b3ad17..3455f3b107 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -359,7 +359,7 @@ static void test_visitor_out_union_in_union(TestOutputVisitorData *data,
 
     TestUnionInUnion *tmp = g_new0(TestUnionInUnion, 1);
     tmp->type = TEST_UNION_ENUM_VALUE_A;
-    tmp->u.value_a.type_a = TEST_UNION_ENUMA_VALUE_A1;
+    tmp->u.value_a.type_a = TEST_UNION_ENUM_A_VALUE_A1;
     tmp->u.value_a.u.value_a1.integer = 42;
     tmp->u.value_a.u.value_a1.name = g_strdup("fish");
 
@@ -377,7 +377,7 @@ static void test_visitor_out_union_in_union(TestOutputVisitorData *data,
     visitor_reset(data);
     tmp = g_new0(TestUnionInUnion, 1);
     tmp->type = TEST_UNION_ENUM_VALUE_A;
-    tmp->u.value_a.type_a = TEST_UNION_ENUMA_VALUE_A2;
+    tmp->u.value_a.type_a = TEST_UNION_ENUM_A_VALUE_A2;
     tmp->u.value_a.u.value_a2.integer = 1729;
     tmp->u.value_a.u.value_a2.size = 87539319;
 
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 0f5f54e621..8ca977c49d 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -119,7 +119,6 @@
   'data': [ 'value-a', 'value-b' ] }
 
 { 'enum': 'TestUnionEnumA',
-  'prefix': 'TEST_UNION_ENUMA', # TODO drop
   'data': [ 'value-a1', 'value-a2' ] }
 
 { 'struct': 'TestUnionTypeA1',
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index add7346f49..4617eb4e98 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -108,7 +108,6 @@ enum TestUnionEnum
     member value-a
     member value-b
 enum TestUnionEnumA
-    prefix TEST_UNION_ENUMA
     member value-a1
     member value-a2
 object TestUnionTypeA1
-- 
2.46.0


