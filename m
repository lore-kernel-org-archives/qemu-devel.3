Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D468C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaBJ-0002jC-Os; Tue, 30 Jun 2026 11:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBH-0002ig-O6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBF-0000CK-Sw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iq+iouowlk69ERX36r4uFBuIwJ10tBY3aCggLDjZMJw=;
 b=KWgrrPlLc9Udu6KEkszcfImnnvJp2YILEXA9fjimXQtxy3yGAya6H7BKrjm8mxkCLyTMGV
 NTf1xW1JeCaTz7eW8bqbeCIb3tQcsPblibunnkOpwkdgJ4bUAwTtGqFIhAY9sy2nclvsrh
 FQqEMejj7OedgPpcWvTk77Ij4yXFWrE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-EGhTTkCRNjekfLa-bYrIvA-1; Tue,
 30 Jun 2026 11:15:18 -0400
X-MC-Unique: EGhTTkCRNjekfLa-bYrIvA-1
X-Mimecast-MFC-AGG-ID: EGhTTkCRNjekfLa-bYrIvA_1782832517
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B17D18001F3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:15:17 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 916B3180067F; Tue, 30 Jun 2026 15:15:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:20 +0400
Subject: [GIT PULL 5/8] tests/qtest: add dump-guest-memory test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-5-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7999;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EnE+NEGBoj+et4ZjVI2j+DnLblFc6z7p9xQ8gWOACRI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91n1LmWhDG5ApISqASn2dHDaKoY+gyJ70Ygq
 Zs71pcbpkiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZwAKCRDa6OEJdZac
 5Sv4D/421VApFtw5akdgXIafltglhW5ZUWoWWRDu97G2egZsN+O1oVY/5EzXy82lay870xuYaAO
 uDtz92SNgvh/2B92yHvrV+Jv5p5iQCLYdg7qlWGzAGZloAVhoXT8dDtfo0E6aFQAfrtBcfvuh2p
 OKH4IksIy3xpUsNyF+prCyrDmPcnL7kLrUqzfx1YaD9s3lvfSz0jybh6CS22HD+wbxjomXjMK18
 oXzRO6hotuTwzbgitkmtuL6QsS0hAwShiYbKXQwEzoorIEdZTdIFZQTSKlzFfQLt04SbQyrez3d
 oigNtilBZozKjyHA9q0ZW+G9kHNMF1VDt4WWI5oX82Vr93QuypWvFxSLLiLsQFn86pMqOXUiNjw
 LogjVNPRe2HtU1J/pHurCBAanPaBtC/2Ys25V7K88hv9eqYzrTYmDSFXJxjz5gWRf7XhiI5vqyr
 nmDKLjG1i7SxSGyd2lc9StGRfPKasOdivp4Yat+rr8DWVu1aT0Pp4KxcOxoBqWvDskWxwlzBOSf
 dNwOzBtW+v8ybagK1YugbNtTHyJgZesc426AL6hwAFuYM2VaiVUAuZz0nMOm9C6GLW87kq/8XVp
 HuKDH6Mw86gNpNWerfcxA5IfpWLqzun+qz0hEKmdiS4VZFpqtHzIdt9g2wo1MSpN4bbgFsXPZM8
 HMUKCDXbjCSvZBQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

There is currently almost no coverage for the dump-guest-memory QMP
command beyond the test-hmp smoke test. Add a qtest that runs on a bare
machine (no guest OS) and checks:

 - query-dump-guest-memory-capability always advertises 'elf';
 - an ELF dump is produced and starts with the ELF magic;
 - a non-raw kdump dump is emitted in makedumpfile flattened format;
 - a raw kdump dump starts with the on-disk KDUMP header;
 - an unknown protocol is rejected without killing the VM, and dumping
   still works afterwards.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260619101834.228432-6-den@openvz.org>
---
 MAINTAINERS             |   1 +
 tests/qtest/dump-test.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |   1 +
 3 files changed, 190 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecfd7159db..7ff0ae09cdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3309,6 +3309,7 @@ F: scripts/dump-guest-memory.py
 F: stubs/dump.c
 F: docs/specs/vmcoreinfo.rst
 F: tests/qtest/vmcoreinfo-test.c
+F: tests/qtest/dump-test.c
 
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/tests/qtest/dump-test.c b/tests/qtest/dump-test.c
new file mode 100644
index 00000000000..eb188c9ccb8
--- /dev/null
+++ b/tests/qtest/dump-test.c
@@ -0,0 +1,188 @@
+/*
+ * QTest testcase for dump-guest-memory
+ *
+ * Generic coverage for the dump-guest-memory QMP command and the
+ * query-dump-guest-memory-capability reporting, exercised on a bare
+ * machine (no guest OS required).
+ *
+ * Copyright (c) 2026 Virtuozzo International GmbH
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
+#include "qemu/bswap.h"
+#include "elf.h"
+
+#define KDUMP_RAW_MAGIC     "KDUMP   "
+#define KDUMP_FLAT_MAGIC    "makedumpfile"
+
+static QTestState *dump_test_start(void)
+{
+    return qtest_initf("-machine q35 -accel qtest -m 16");
+}
+
+static void assert_file_magic(const char *path, const char *magic, size_t len)
+{
+    g_autofree char *buf = g_malloc0(len);
+    FILE *f = fopen(path, "rb");
+
+    g_assert_nonnull(f);
+    g_assert_cmpint(fread(buf, 1, len, f), ==, len);
+    fclose(f);
+    g_assert_cmpint(memcmp(buf, magic, len), ==, 0);
+}
+
+/* validate that the file is a sane x86 ELF core, not just the leading magic */
+static void assert_valid_elf_core(const char *path)
+{
+    unsigned char e[64];
+    FILE *f = fopen(path, "rb");
+    uint16_t e_type, e_machine, e_phnum;
+
+    g_assert_nonnull(f);
+    g_assert_cmpint(fread(e, 1, sizeof(e), f), ==, sizeof(e));
+    fclose(f);
+
+    g_assert_cmpint(memcmp(e, ELFMAG, SELFMAG), ==, 0);
+
+    /* e_type and e_machine sit at the same offset for ELF32 and ELF64 */
+    e_type = lduw_le_p(e + 16);
+    e_machine = lduw_le_p(e + 18);
+    g_assert_cmpint(e_type, ==, ET_CORE);
+    g_assert(e_machine == EM_386 || e_machine == EM_X86_64);
+
+    /* e_phnum lives at a class-dependent offset */
+    if (e[EI_CLASS] == ELFCLASS64) {
+        e_phnum = lduw_le_p(e + 56);
+    } else {
+        e_phnum = lduw_le_p(e + 44);
+    }
+    g_assert_cmpint(e_phnum, >, 0);
+}
+
+/* dump-guest-memory to a fresh temp file; returns the path (caller frees) */
+static char *do_dump(QTestState *qts, const char *format)
+{
+    g_autofree char *tmp = NULL;
+    g_autofree char *proto = NULL;
+    GError *err = NULL;
+    int fd;
+
+    fd = g_file_open_tmp("dump-test-XXXXXX", &tmp, &err);
+    g_assert_no_error(err);
+    close(fd);
+    proto = g_strdup_printf("file:%s", tmp);
+
+    if (format) {
+        qtest_qmp_assert_success(qts,
+            "{ 'execute': 'dump-guest-memory',"
+            "  'arguments': { 'paging': false, 'protocol': %s,"
+            "                 'format': %s } }", proto, format);
+    } else {
+        qtest_qmp_assert_success(qts,
+            "{ 'execute': 'dump-guest-memory',"
+            "  'arguments': { 'paging': false, 'protocol': %s } }", proto);
+    }
+
+    return g_steal_pointer(&tmp);
+}
+
+/* query-dump-guest-memory-capability must always advertise at least 'elf' */
+static void test_query_capability(void)
+{
+    QTestState *qts = dump_test_start();
+    QDict *resp, *ret;
+    QList *formats;
+    QListEntry *e;
+    bool has_elf = false;
+
+    resp = qtest_qmp(qts,
+        "{ 'execute': 'query-dump-guest-memory-capability' }");
+    g_assert(qdict_haskey(resp, "return"));
+    ret = qdict_get_qdict(resp, "return");
+    formats = qdict_get_qlist(ret, "formats");
+    g_assert_nonnull(formats);
+
+    QLIST_FOREACH_ENTRY(formats, e) {
+        QString *qs = qobject_to(QString, qlist_entry_obj(e));
+
+        if (g_str_equal(qstring_get_str(qs), "elf")) {
+            has_elf = true;
+        }
+    }
+    g_assert_true(has_elf);
+
+    qobject_unref(resp);
+    qtest_quit(qts);
+}
+
+static void test_dump_elf(void)
+{
+    QTestState *qts = dump_test_start();
+    g_autofree char *path = do_dump(qts, NULL);
+
+    assert_valid_elf_core(path);
+    unlink(path);
+    qtest_quit(qts);
+}
+
+/* non-raw kdump is emitted in makedumpfile flattened format */
+static void test_dump_kdump_zlib(void)
+{
+    QTestState *qts = dump_test_start();
+    g_autofree char *path = do_dump(qts, "kdump-zlib");
+
+    assert_file_magic(path, KDUMP_FLAT_MAGIC, strlen(KDUMP_FLAT_MAGIC));
+    unlink(path);
+    qtest_quit(qts);
+}
+
+/* raw kdump starts with the on-disk KDUMP header */
+static void test_dump_kdump_raw_zlib(void)
+{
+    QTestState *qts = dump_test_start();
+    g_autofree char *path = do_dump(qts, "kdump-raw-zlib");
+
+    assert_file_magic(path, KDUMP_RAW_MAGIC, strlen(KDUMP_RAW_MAGIC));
+    unlink(path);
+    qtest_quit(qts);
+}
+
+/* an unknown protocol must be rejected, not crash the VM */
+static void test_dump_invalid_protocol(void)
+{
+    QTestState *qts = dump_test_start();
+    g_autofree char *path = NULL;
+    QDict *resp;
+
+    resp = qtest_qmp(qts,
+        "{ 'execute': 'dump-guest-memory',"
+        "  'arguments': { 'paging': false, 'protocol': 'bogus:/x' } }");
+    g_assert(qdict_haskey(resp, "error"));
+    qobject_unref(resp);
+
+    /* VM is still alive and dumping still works afterwards */
+    path = do_dump(qts, NULL);
+    assert_valid_elf_core(path);
+    unlink(path);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/dump/query-capability", test_query_capability);
+    qtest_add_func("/dump/elf", test_dump_elf);
+    qtest_add_func("/dump/kdump-zlib", test_dump_kdump_zlib);
+    qtest_add_func("/dump/kdump-raw-zlib", test_dump_kdump_raw_zlib);
+    qtest_add_func("/dump/invalid-protocol", test_dump_invalid_protocol);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 822e0bd2869..84062028f9c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -59,6 +59,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_Q35') ? ['dump-test'] : []) +                         \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \

-- 
2.54.0


