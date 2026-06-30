Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AF7C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaBV-0002jl-Uw; Tue, 30 Jun 2026 11:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBL-0002jQ-Sm
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBK-0000Cx-2N
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XBdA8E+oC6SGIZRfUZzMeVpOzgRV0QL0Mkw7GQR5r0=;
 b=Cqhd3aQ1u6heRQxleDUp0wGIOQzHr8DuKIivJmEyEs4T/Vt7SVZYDQimQCosdGWvKIrEBv
 3wlMWXiekKnx3Dly9FY1T1Vj0mQJhPjROs1afdSXf1B1PKL/zNxatGkI9P/es1MAVL951D
 w84XmXm0MDIDynZ2k3Urcn5hyleLMWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-ZXwARUQUPu6Youc28rntfQ-1; Tue,
 30 Jun 2026 11:15:23 -0400
X-MC-Unique: ZXwARUQUPu6Youc28rntfQ-1
X-Mimecast-MFC-AGG-ID: ZXwARUQUPu6Youc28rntfQ_1782832522
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F1261954B20
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:15:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C11218005B1; Tue, 30 Jun 2026 15:15:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:21 +0400
Subject: [GIT PULL 6/8] tests/qtest/dump: reject win-dmp without vmcoreinfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-6-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VI+6CoAms05KFZFcT8i7jS80mzlwXt2S2GqbneLkrZo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91nz1cY92vnlTVJhbhP6V44QobuLX3rqliyA
 ljFV1QEtjKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZwAKCRDa6OEJdZac
 5U0JD/9EG104ybe81dOl95SoFfF3EPqm4FN6CCE4h8DzeoFg2tYHX1w68lBYgxEOW8/vQyFZkg5
 j2WAnQ8mnHseIWfkTNnciUfHZE6CoYvFe1Wmm6OSVXev29sk99+rmKchBkNlFqJZhpKLKpcHiEr
 gDJvL7BDvfGqBvYg4ES+yGKf5SSdxim6xV0Xg7hWXyzhmlCr3A0G3czPUPg3uQ+bHq5HUTlXGEk
 5BJ4oWrP/oa7XX+rA2Mi9d4gZ22X2SYZInqfYpAd3RQ5jL7xhlZwUzJWReMdTw0sV+FR7ZLF7kQ
 Ef8s15HIj0LUfZ4Nw2TU1zzbwQHvklkw3AOQWQbF7NhosckgmcN8x2yAeo+WiIxoJ9YPAgMYvY7
 svzPcM8HEVg8ATu6EN7FuSlYeuFYy40mEQZdadEzo8Ew1mZoMTl2OwyZnjGEwmFf8nBe304+Vpo
 RhqnBNuGl8ldGHPmV113sbYwUs0vKwDtNWkdCffPe7SnLCJTNt2nr/y2G9LWcI0o4Q/exEj87eq
 DxgmU7OPpvSvG8y0rowrT8DmAguSEtI204rQVr+lkt1UV02CM6UZ+kuT6LL3E5gV/KIOrv85ZlL
 CCtUxLWkwrQ4zkWzZ14WZLZ3w0/ww/4FJ+qlQ+IpY6XuZ1Mo099QvKMZj9OpIJc5mLhJ+8VmDoq
 go0NLOjlDlbZWNA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

Requesting the Windows crashdump format (win-dmp) on a guest that does not
expose a Windows dump header through vmcoreinfo must be rejected, not
silently turned into a bogus dump. Add a test that asks for win-dmp on a
plain VM and checks the request fails with "invalid vmcoreinfo note size"
and that the VM stays usable afterwards (a subsequent ELF dump succeeds).

The test is x86_64 only, where win_dump_available() performs this check.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260619101834.228432-7-den@openvz.org>
---
 tests/qtest/dump-test.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/qtest/dump-test.c b/tests/qtest/dump-test.c
index eb188c9ccb8..6afaa2c2ea4 100644
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
2.54.0


