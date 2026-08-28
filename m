Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D8C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Pi-0006Yf-C7; Fri, 28 Aug 2026 16:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pe-00065C-6G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pc-0008FJ-1d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sBb5wKXIMM15ZG8HrtOTQGP++QueaQ7m+mrQd1vMSA=;
 b=HBCQ2FGL+uXegcdZP/7sRInmpfpuW0UjdQPtUolZdz/3zNNQi52AGxN9Y3dbiT5+HgvBMA
 UXcyUxwW0/CLWZUwJrI6fHkxl1teXUiSSciO8BTJhu95HUlPJPwc48FTYrP1TOGN3ZFRps
 gaqxHSCHv/VrxZrpJMUNwlPmR4JPfX4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-iirwSKgJO52CDvhblqWv7g-1; Fri,
 28 Aug 2026 16:42:51 -0400
X-MC-Unique: iirwSKgJO52CDvhblqWv7g-1
X-Mimecast-MFC-AGG-ID: iirwSKgJO52CDvhblqWv7g_1787949770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A04918C0FA5; Fri, 28 Aug 2026 20:42:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AA0A18005AC; Fri, 28 Aug 2026 20:42:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:53 +0400
Subject: [GIT PULL 14/50] tests/qtest/numa-test: replace HMP "info numa"
 with QMP query-cpus-fast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-14-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=T05QOCjWGcUCJjKa4FdLIFwcZrDf2hmNVYzR42TH3wM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUiQ1JumHY1QT3F8UPJCIb8TO3NfNIGGOm7
 ABMu3+g3zaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5Q3lEACPQGmuQbC0mepdL11/CFU6rtJzo6BsJlxGLQi5TrSZoKbbmzrXsC/LOENnbAtTx5fLNFx
 yN2VNq7kmF1XVMElsDYY+xrUa/jKkMPDXpvj4dHYip3CEjCgIvzN+uO4Nnwf6OZzg4W5c7ZGTk+
 g88PALcL5b6RxNqjuTis95MSBy8M6F80EyxAm7Pwqb7QQiVo6IhX0Ha+eP1gnFcMvY/qIjz9EN0
 olnnfb+XExK0cAvpentahPD1HVH4IL+g5cSy4iPYAJitWgZhL3wDI32p4FRc6UxsSoG5b6P708/
 cQEdLuEEdHgkkSM2sBpXIQO42pNguzVQ4DUVFp73wXID9JVYsfdOei0V58HVOSohnwUAujzLByH
 tz9m03/FqG8+YGDoOAatiUUwAVHAnWInCmQhA8HJqKtb71DD6BGy5hccQS4XT/EN2+9bkj7mHfo
 t3HcUQ6nZqweq7mdzJG5q0OBdS41WjE4h6LbHuHPTHXqlIGXZYR7f6ek1KisyyMHapF5IYl2MpM
 S3o7oi1IbgAhkkOv/y5pyA0y496JQuOL++jXS7GENjQlR5GIXA+jHFuq6sITj+t+MAlifB/gH1J
 UpqwPLWrUB2Tm7OaSJ+S45GaUhN92NmDvTA1goHuxG803zDTKrJEoQaCmukzB5Lu5AwOYSRxEPm
 c0Gk1DRSMs0aVgg==
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
Message-ID: <20260828-qemu-no-hmp-v5-14-9227de146347@redhat.com>
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


