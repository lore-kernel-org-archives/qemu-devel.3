Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB497C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYC-0004zM-87; Tue, 25 Aug 2026 15:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywY4-0004fP-DY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywY2-0003yh-7u
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuTj5x+fSNUVNN2LMJ3vFG3XqkgK85waEsJYQTSVFbk=;
 b=YCDW2LuZ/ovtyGv7qMTq181S+l5RQyMwnz75f7lA8+tUuENkT9lc3Hlle2ZFZ6svcgEVuB
 su8ALFP/r2YlA4pAKVxgWFR+vgfrYRsGrCUHVxqjoPoqybUXGbcN0BucCcykQbW1FCr55V
 Qtd3YVzM7w3EoVlrAOGexOOfwJUm3bk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-yEhIdn6CPtari-MisAhohA-1; Tue,
 25 Aug 2026 15:10:57 -0400
X-MC-Unique: yEhIdn6CPtari-MisAhohA-1
X-Mimecast-MFC-AGG-ID: yEhIdn6CPtari-MisAhohA_1787685056
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 940EF188FECA; Tue, 25 Aug 2026 19:10:56 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C04A118005BE; Tue, 25 Aug 2026 19:10:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:21 +0400
Subject: [PATCH v4 14/49] tests/qtest/numa-test: replace HMP "info numa"
 with QMP query-cpus-fast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-14-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4041;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+FBAR2ZPq7hb97oLmYP2VfmJ5ZxlMcXNs2ksRVhW/zk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHy5MYCOjiCt5u/tQW/JwoviNOE+jQJfUDX
 e7pRSj7Kv+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5b0qEACzgTH5Uh3dWORJxGtDpTlvVactUkvpNsbq73QQm6P8dmaA0UgI+DA51YUhReNS82JjdRa
 IIU7SkQzkL/a7vEC44oiHVChntDp6J5yWJp9f6EPEkrQffxeKMN8UcxvBfNmwXYTgZyro/cvIvW
 T2+jrYHyDRdNraj5mYTLByN1mbWLWbbLlJqPdI3aysYPdHn8sEt+UwAH9A04trg0Zp85ndzklUg
 otuBKouhLMxOGBfLku8iQYsToVLx8MJA6m7b2xW+PMEMdt1lGVY+T4sWM3q/KLbaP9WTocdN2gK
 9tiiHZSTna8MwEgjAwIsygrFirFAzu2gd5zBvRXUhZPcnbIMC6TYxYl2rHCKW2ZaScT/xTWmrtN
 3X/BZV6LGLg7LhK5u+kDR90elYLE33Ojr1QyWkZb/B44drldPR7RIviyR6qhlj/hFP7cTcHT4kX
 kvzsRGXMa41IDvWAR7/bfH/pIsVcifVcuTSL3gKReqzeSPzp3LG/q0YjkXiFy39UL/ngp7j0Hmp
 IvgTmo0zQHYBqU3ASwXl+Voe65djrioK+8N45dfJqduqiGDMW90yOr7RlHX17XXH0aOivmv6bYC
 QILnyz4kCMPiX0TWUAhCfE9gx3/86mxfwy0qBKCBB+/R1iMvniMhfCQDGHMx4HKlxiTUzuRYBjt
 ZKj/TjC3z25XNqA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


