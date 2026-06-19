Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30926CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJB-0006K6-6o; Fri, 19 Jun 2026 06:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ9-0006J2-Bb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:43 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ6-0000fH-6V
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=dZVtOxE/JVhOT97T/jzFqUWxYYdVhLADxvY1qb5kBMg=; b=g3Xb2rV2l5LR
 FqRkQu3wR3pN+gL3EZzWdrhdrH3NQ5UAuX1h5I0vl+KhmmXfX22+F1pX5cbB1cWhCONqXjq69NmaU
 xaB4nF7qdAOQLXPrj/tvq+whvxf7tWYsKnITRlMIMpRU/SBOrwh6aLtjNcA2qT1R3Z1Sa8bs7RLXk
 b1KYFgqQtLsD4ScFmM92lCt7iovoos58sL4h2SxER5sUumZP3ea3kVAj5yWJsTvOyvMbFVHBneXU5
 DuDU987wfQHKeWVQZJUw11xlug/Cfyq/J61Yq9Tv1l0MvVg9VHZmi1RRF6hS4umWqybPE29PHvWLa
 wEUzelkXFPmCOWTaTJx1gQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIV-006QLJ-1W;
 Fri, 19 Jun 2026 12:18:35 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 6/7] tests/qtest/dump: reject win-dmp without vmcoreinfo
Date: Fri, 19 Jun 2026 12:18:33 +0200
Message-ID: <20260619101834.228432-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619101834.228432-1-den@openvz.org>
References: <20260619101834.228432-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Requesting the Windows crashdump format (win-dmp) on a guest that does not
expose a Windows dump header through vmcoreinfo must be rejected, not
silently turned into a bogus dump. Add a test that asks for win-dmp on a
plain VM and checks the request fails with "invalid vmcoreinfo note size"
and that the VM stays usable afterwards (a subsequent ELF dump succeeds).

The test is x86_64 only, where win_dump_available() performs this check.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/dump-test.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/qtest/dump-test.c b/tests/qtest/dump-test.c
index eb188c9ccb..6afaa2c2ea 100644
--- a/tests/qtest/dump-test.c
+++ b/tests/qtest/dump-test.c
@@ -174,8 +174,51 @@ static void test_dump_invalid_protocol(void)
     qtest_quit(qts);
 }
 
+/*
+ * Requesting win-dmp without a Windows dump header in vmcoreinfo must be
+ * rejected with a clear error -- and must leave the VM usable, rather than
+ * produce a bogus dump.
+ */
+static void test_dump_win_dmp_unavailable(void)
+{
+    QTestState *qts = dump_test_start();
+    g_autofree char *tmp = NULL;
+    g_autofree char *proto = NULL;
+    g_autofree char *path = NULL;
+    GError *err = NULL;
+    QDict *resp, *error;
+    const char *desc;
+    int fd;
+
+    fd = g_file_open_tmp("dump-test-XXXXXX", &tmp, &err);
+    g_assert_no_error(err);
+    close(fd);
+    proto = g_strdup_printf("file:%s", tmp);
+
+    resp = qtest_qmp(qts,
+        "{ 'execute': 'dump-guest-memory',"
+        "  'arguments': { 'paging': false, 'protocol': %s,"
+        "                 'format': 'win-dmp' } }", proto);
+    error = qdict_get_qdict(resp, "error");
+    g_assert_nonnull(error);
+    desc = qdict_get_try_str(error, "desc");
+    g_assert_nonnull(desc);
+    g_assert_nonnull(strstr(desc, "vmcoreinfo"));
+    qobject_unref(resp);
+    unlink(tmp);
+
+    /* the failed request must not wedge the VM: a plain dump still works */
+    path = do_dump(qts, NULL);
+    assert_valid_elf_core(path);
+    unlink(path);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
+    const char *arch = qtest_get_arch();
+
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/dump/query-capability", test_query_capability);
@@ -184,5 +227,11 @@ int main(int argc, char **argv)
     qtest_add_func("/dump/kdump-raw-zlib", test_dump_kdump_raw_zlib);
     qtest_add_func("/dump/invalid-protocol", test_dump_invalid_protocol);
 
+    /* win-dmp is an x86_64-only format */
+    if (g_str_equal(arch, "x86_64")) {
+        qtest_add_func("/dump/win-dmp-unavailable",
+                       test_dump_win_dmp_unavailable);
+    }
+
     return g_test_run();
 }
-- 
2.53.0


