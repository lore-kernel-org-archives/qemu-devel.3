Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C75FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhwh-0005IN-UN; Tue, 30 Jul 2024 04:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwg-0005Dj-VC
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwZ-0001GT-VZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722327051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEwsuofZJeT4kfZWCKBhwsE5dAZCLtZDseQ9yWUtp3Y=;
 b=JWPawbBcVZJUqxgTKpahHkRHz9PBiEHybGB+f2w6BnXqiEp27m+3LmSCpVQUL2HeJ3uVx8
 S7RoFkr3U1m2Y5TCGJq59ss+eAWhx8oiUU6nta3HJh7QCG79wCrOSBq7ZALr9YEjBh5B+1
 p/DdNEX/2nv+MbQZ13TMsQVAOzl+F38=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-Fg3UXDOzMNSw8UvqBuk3yw-1; Tue,
 30 Jul 2024 04:10:46 -0400
X-MC-Unique: Fg3UXDOzMNSw8UvqBuk3yw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDFB01955D59; Tue, 30 Jul 2024 08:10:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E686B3000193; Tue, 30 Jul 2024 08:10:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CCF8221F4B8C; Tue, 30 Jul 2024 10:10:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH 02/18] tests/qapi-schema: Drop temporary 'prefix'
Date: Tue, 30 Jul 2024 10:10:16 +0200
Message-ID: <20240730081032.1246748-3-armbru@redhat.com>
In-Reply-To: <20240730081032.1246748-1-armbru@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.45.0


