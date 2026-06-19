Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B4ECD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJC-0006KL-6n; Fri, 19 Jun 2026 06:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ9-0006JE-NM
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:43 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ5-0000f7-JY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=VqKwkk7u2inZp7I1hV1QM8bMKlNwJuV7mZi0Y5eyqBY=; b=YQePrXUTCKoX
 b6xq6GiKWe6OmKGbqPN7/lVsd28NK2P4FysWw4n51xLZ8ZK1GnR/nM5GDA8qRf41l/ucxzTQHOAv1
 5KWA69/232LQxhJutcs/7QOIQzDF+Z2P/2zCenH4aCfoOyi5F8r68YzbG8K6h/MR5843pWNEXnLwe
 HROJ80tyeco3SnebANkroPFtSrerY2Chk6NTT6lgJSUKZYKyBK3Kc0TY2O5zhM79AQz+KtPUS0EZi
 if9YdAClM94xJptuUDo+Z3NAtnttSvyJ7J0NcgQ+2ewu4+dQVPOiiprFz15cogf6dAmhBhlJm2KIa
 cZaWHcJybqoT2C526fUunA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIU-006QLJ-3A;
 Fri, 19 Jun 2026 12:18:34 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 5/7] tests/qtest: add dump-guest-memory test
Date: Fri, 19 Jun 2026 12:18:32 +0200
Message-ID: <20260619101834.228432-6-den@openvz.org>
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
---
 MAINTAINERS             |   1 +
 tests/qtest/dump-test.c | 188 ++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |   1 +
 3 files changed, 190 insertions(+)
 create mode 100644 tests/qtest/dump-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..f82412443c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3291,6 +3291,7 @@ F: scripts/dump-guest-memory.py
 F: stubs/dump.c
 F: docs/specs/vmcoreinfo.rst
 F: tests/qtest/vmcoreinfo-test.c
+F: tests/qtest/dump-test.c
 
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/tests/qtest/dump-test.c b/tests/qtest/dump-test.c
new file mode 100644
index 0000000000..eb188c9ccb
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
index 4897325d84..e5266bc1eb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -59,6 +59,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
+  ['dump-test'] +                                                                          \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
-- 
2.53.0


