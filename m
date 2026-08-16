Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55368C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJ8-0000Pg-7H; Sun, 16 Aug 2026 15:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIt-0008VC-Ng
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIs-0007Sj-8A
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuTj5x+fSNUVNN2LMJ3vFG3XqkgK85waEsJYQTSVFbk=;
 b=d8sdZb3UX6CbMR4odjnhFKeXMKQHMXbmsODBD9MBSdpW1UgAEqnVkW0CtZGH1X0tMLopOP
 b9wlp5AhcGGGyOVoe3QvXC4ZEhptVDFuro3Djm5v/FhlDQAeSAdOZfHfvM//mjEVCwjzKS
 +I84EOCrVf9WfEFSKcpiPRNMDoUYpSE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-3ViPWouGPsGHQX9jhKG51w-1; Sun,
 16 Aug 2026 15:13:49 -0400
X-MC-Unique: 3ViPWouGPsGHQX9jhKG51w-1
X-Mimecast-MFC-AGG-ID: 3ViPWouGPsGHQX9jhKG51w_1786907628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B25C7195608E; Sun, 16 Aug 2026 19:13:48 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93FC518005BB; Sun, 16 Aug 2026 19:13:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:41 +0400
Subject: [PATCH v3 14/49] tests/qtest/numa-test: replace HMP "info numa"
 with QMP query-cpus-fast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-14-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4041;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+FBAR2ZPq7hb97oLmYP2VfmJ5ZxlMcXNs2ksRVhW/zk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqggux9kYy2x5ZsB5IkhvhiwGJZCd9BPSsfFwai
 rBA4Xyz6gWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsQAKCRDa6OEJdZac
 5U0eEACuKFgzKf3GeiHr2gTYpb0q+1cchZi08okjpYoJ79QvbXKf7h5inzxYkSbhlVTSz6m4Bw3
 Uesd1VJcWJz31UaMvioQSc/LQJzRJIyQHJW0VbQeYFdj2ulX2FS74qk/OYM0Eiw0bMhRVZs2/ad
 WtyiR17kAQ81qiK4vwaa0trqEmqChy+Fw3UmbMfmNkY9DUJZpmPGpcJ7skzhfqt3z+ulIDdl0hK
 DV2o8aNWxsNV54tknludbc2lsmvlvwxiQQTOFBMBYXc/VLHb9+EvgYhZ30rP0ox6Vrnkt9xDtfs
 c3HfJupuLgQbjksXDOehJFe6mRQg47i3U/e1KvE9x1qZJiRmaidLvSARxrJ77kTzHMgI2qmanxX
 WZyyDo7eAWfDINpReY1FttQ24XsQvt+kQj1C5mNoYUjiwhkypBTkx6ohO9WVGmCsiJJZSs3oH6o
 j7afl2q4Z6zObWzHx14H6666ED13XpGSX2GutAEkTSRZ0Rvr891jAIhTzQAwe5bsHSz7sVP7jrx
 BWT2BMPkzg1Wn7vCBmz3egmy2HNh9HG3NjmAm7ALFTvLRPBrBOwytbQoaTVCWTGg6VgLLURtqW7
 EpJf0JX8YdnZkeiodcBJxuL8gJuKVTUoWNeRkixBtbDvCASN1PTZM0lOfw2AOmobrUDcwC+VadA
 0IouH5GOsDIgwuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/numa-test.c | 63 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index d657f3894743..8f563c079f62 100644
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
2.55.0.543.g5ebe2ebe4ea8


