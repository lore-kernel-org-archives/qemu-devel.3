Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87149CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoq7-0005yx-AM; Wed, 20 May 2026 17:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoq4-0005oC-RE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoq3-0004mf-3U
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KXrbaP0o204oy3ffVboRa53QerResEIbZt37fxqg80=;
 b=AKEnTBdqQVARdIP/LuvXnGNxPzFQBKY3IIqPfnqU584VpQAiLG3WzskNL7x9BBxgldwPS2
 O3UOb2Bt0BwMoJ9X9dKdYkWzWVe96VCPJBPBn+6oj2I57BRigKF6bhiw+3jP/o4Kg0oUtl
 VDQWGtIg4Y6jDYQI9DAWiCrHH5ddJm8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-5sc75D_1NOG4SQK1_BTpEA-1; Wed,
 20 May 2026 17:52:25 -0400
X-MC-Unique: 5sc75D_1NOG4SQK1_BTpEA-1
X-Mimecast-MFC-AGG-ID: 5sc75D_1NOG4SQK1_BTpEA_1779313944
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43E601956095
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A9BC19560A2; Wed, 20 May 2026 21:52:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:24 +0400
Subject: [PATCH 23/40] tests/qtest/numa-test: replace HMP "info numa" with
 QMP query-cpus-fast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-23-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3965;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OFBar7k9p+yqwjSsR5ORXDxBcPwhkg3T4bV1GvhPOiU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyD5Z/RwFa22qwGaZZtFx9fBX2uyrtWwwYRF
 5G0g9qk20+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5Qs7EACrOrvbQ5m27cp7QKm0dJ+D9HxgAuqFhlgdpviBQush6GXxRw5TFpvt8gIANYZykRaUUX/
 9rGq3KffUcy75KffWrAo9SccylViO5+udDh5khYyF4m1yockhi7N1GLsfdWmZ/TCIOF8QMnUOgm
 2ipO8e6d9fqZep+5hv23uN4rnR7RBwUREVGgrR/Kt1q28b8zY96QzbCTZR3+uTQjR5+SjIw8dSS
 lmELj9lpGOTQSki2UVh9dGHzqWVuU2vwRVjICFyBLAfHa2dB8/zVFfq+ylswY6ENAVpJ7K2PCMB
 K9ZcT81KYLYAEyHVfucLtsK0fpc5F3P3F/nWHZM/7u+1LMyX1y75Aa5NifQwOpx3YW2ZlgIlo+R
 Sf4rlA6+R9ldZNCfTtrCj7/cLtSIISD+msH1y7MAXgwsZl/uCyV6ix+Y1pBquhLEMFWyi840AXE
 LOzB4D2FIVHqcxjKD2WEpUaKZqT7XGlNOFp0vCOwtzEKGzA1BA0nwz3QFsETJtO4WEPyQY52tEx
 07MgbM3TF/W3ELMcv4JouZaB23U5epldB6SwAFC9I9sO2g7hJFJnWPGcDAR5ogOEOleMmG9pQ3D
 GVD9gHZ6S5PRkTQ1k5wsOIcNt8NUEoeq73joJ8pJF35KAf+0s19/6ZRn7g3uco2BP+7eZH4lb5p
 xAIGN54OiCFUAfw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert the three test functions that relied on HMP "info numa" to use
QMP "query-cpus-fast" instead, verifying each CPU's node-id through the
structured response. Add a check_cpu_node() helper for the per-CPU
assertions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/numa-test.c | 63 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index d657f389474..8f563c079f6 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -19,19 +19,50 @@ static char *make_cli(const GString *generic_cli, const char *test_cli)
     return g_strdup_printf("%s %s", generic_cli->str, test_cli);
 }
 
+static void check_cpu_node(QTestState *qts, int cpu_idx, int expected_node)
+{
+    QDict *resp;
+    QList *cpus;
+    QListEntry *e;
+    bool found = false;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'query-cpus-fast' }");
+    g_assert(resp);
+    g_assert(qdict_haskey(resp, "return"));
+    cpus = qdict_get_qlist(resp, "return");
+    g_assert(cpus);
+
+    QLIST_FOREACH_ENTRY(cpus, e) {
+        QDict *cpu = qobject_to(QDict, qlist_entry_obj(e));
+        int64_t idx = qdict_get_int(cpu, "cpu-index");
+        if (idx == cpu_idx) {
+            QDict *props = qdict_get_qdict(cpu, "props");
+            g_assert(qdict_haskey(props, "node-id"));
+            g_assert_cmpint(qdict_get_int(props, "node-id"), ==, expected_node);
+            found = true;
+            break;
+        }
+    }
+    g_assert(found);
+    qobject_unref(resp);
+}
+
 static void test_mon_explicit(const void *data)
 {
     QTestState *qts;
-    g_autofree char *s = NULL;
     g_autofree char *cli = NULL;
+    int i;
 
     cli = make_cli(data, "-machine smp.cpus=8 -numa node,nodeid=0,memdev=ram,cpus=0-3 "
                          "-numa node,nodeid=1,cpus=4-7");
     qts = qtest_init(cli);
 
-    s = qtest_hmp(qts, "info numa");
-    g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
-    g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
+    for (i = 0; i < 4; i++) {
+        check_cpu_node(qts, i, 0);
+    }
+    for (i = 4; i < 8; i++) {
+        check_cpu_node(qts, i, 1);
+    }
 
     qtest_quit(qts);
 }
@@ -39,16 +70,19 @@ static void test_mon_explicit(const void *data)
 static void test_def_cpu_split(const void *data)
 {
     QTestState *qts;
-    g_autofree char *s = NULL;
     g_autofree char *cli = NULL;
+    int even_cpus[] = {0, 2, 4, 6};
+    int odd_cpus[] = {1, 3, 5, 7};
+    int i;
 
     cli = make_cli(data, "-machine smp.cpus=8,smp.sockets=8 "
                          "-numa node,memdev=ram -numa node");
     qts = qtest_init(cli);
 
-    s = qtest_hmp(qts, "info numa");
-    g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
-    g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
+    for (i = 0; i < 4; i++) {
+        check_cpu_node(qts, even_cpus[i], 0);
+        check_cpu_node(qts, odd_cpus[i], 1);
+    }
 
     qtest_quit(qts);
 }
@@ -56,17 +90,22 @@ static void test_def_cpu_split(const void *data)
 static void test_mon_partial(const void *data)
 {
     QTestState *qts;
-    g_autofree char *s = NULL;
     g_autofree char *cli = NULL;
+    int node0_cpus[] = {0, 1, 2, 3, 6, 7};
+    int node1_cpus[] = {4, 5};
+    int i;
 
     cli = make_cli(data, "-machine smp.cpus=8 "
                    "-numa node,nodeid=0,memdev=ram,cpus=0-1 "
                    "-numa node,nodeid=1,cpus=4-5 ");
     qts = qtest_init(cli);
 
-    s = qtest_hmp(qts, "info numa");
-    g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
-    g_assert(strstr(s, "node 1 cpus: 4 5"));
+    for (i = 0; i < 6; i++) {
+        check_cpu_node(qts, node0_cpus[i], 0);
+    }
+    for (i = 0; i < 2; i++) {
+        check_cpu_node(qts, node1_cpus[i], 1);
+    }
 
     qtest_quit(qts);
 }

-- 
2.54.0


