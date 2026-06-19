Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB862CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJC-0006KK-39; Fri, 19 Jun 2026 06:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ9-0006J7-Is
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:43 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ6-0000fL-Jr
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=54rkZq3cOprcVyaQqOh5pL1E1/jpIGYTKwNBB9XxI7A=; b=mcH/0Ah7hJnz
 l5EkW7CX/Hkl8NAMXW6CPLPFrpJQXXC8aq4hGkV4bHslaAFn6DGknje/PKaaSCz0HRSGkAqW9/m61
 mn9bZm/WPEerL99fi0DxkiN1m3N2Qdpct+ZajasQTJ9RSCG4BaEFc0q27YWKh4fPwdhAqUdQ9UZoY
 h21fg0x3O5FhyrlsGDmcPzbpkpx8fpFx5MT22xqdKpK5FDlmJ8j2ydzYi4tKKgw04n+s96fcOAkm3
 k/PcBAVUfKzfshOjSZIXzfmXdnuXMFKdrd27LB09xB8XkvGZDDR8AA/u2FHM2tZvSTmyB45xzhywe
 YNpCVzD4tLCLaEl1I3ueXg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIV-006QLJ-34;
 Fri, 19 Jun 2026 12:18:35 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 7/7] tests/qtest/dump: cover win-dmp availability via
 vmcoreinfo
Date: Fri, 19 Jun 2026 12:18:34 +0200
Message-ID: <20260619101834.228432-8-den@openvz.org>
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

win-dmp becomes available only once the guest exposes a Windows dump
header through vmcoreinfo. Forge exactly such a note (an ELF note
header followed by a WinDumpHeader64 carrying the PAGE/DU64
signatures, the layout a Windows guest with the QEMU vmcoreinfo writer
produces), place it in guest RAM, point the vmcoreinfo device at it via
fw_cfg, and check that win-dmp flips from unavailable to available.

This exercises win_dump_available()'s positive path without a real
Windows guest. It only covers availability reporting; the actual
win-dmp generation (create_win_dump()) needs real Windows kernel
structures and is not exercised here.

The test is registered only on x86_64 with a vmcoreinfo device present.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/dump-test.c | 94 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tests/qtest/dump-test.c b/tests/qtest/dump-test.c
index 6afaa2c2ea..30c95a3528 100644
--- a/tests/qtest/dump-test.c
+++ b/tests/qtest/dump-test.c
@@ -12,10 +12,15 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "libqos/libqos-pc.h"
+#include "libqos/fw_cfg.h"
 #include "qobject/qdict.h"
 #include "qobject/qlist.h"
 #include "qobject/qstring.h"
 #include "qemu/bswap.h"
+#include "qemu/win_dump_defs.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
+#include "hw/misc/vmcoreinfo.h"
 #include "elf.h"
 
 #define KDUMP_RAW_MAGIC     "KDUMP   "
@@ -215,6 +220,90 @@ static void test_dump_win_dmp_unavailable(void)
     qtest_quit(qts);
 }
 
+static bool capability_has_format(QTestState *qts, const char *want)
+{
+    QDict *resp, *ret;
+    QList *formats;
+    QListEntry *e;
+    bool found = false;
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
+        if (g_str_equal(qstring_get_str(qs), want)) {
+            found = true;
+        }
+    }
+    qobject_unref(resp);
+    return found;
+}
+
+/*
+ * win-dmp becomes available only once the guest exposes a Windows dump
+ * header through vmcoreinfo. Forge exactly such a note -- the layout a
+ * Windows guest with the QEMU vmcoreinfo writer produces: a fixed-size ELF
+ * note header followed by a WinDumpHeader64 carrying the PAGE/DU64
+ * signatures -- place it in guest RAM, point the vmcoreinfo device at it
+ * via fw_cfg, and check that win-dmp flips from unavailable to available.
+ *
+ * This only covers availability *reporting*; the actual win-dmp generation
+ * (create_win_dump()) needs real Windows kernel structures and is not
+ * exercised here.
+ */
+static void test_dump_win_dmp_available(void)
+{
+    const uint64_t paddr = 0x800000; /* 8 MiB, inside guest RAM */
+    size_t notesz = VMCOREINFO_WIN_DUMP_NOTE_SIZE64;
+    g_autofree uint8_t *note = g_malloc0(notesz);
+    Elf64_Nhdr *nhdr = (Elf64_Nhdr *)note;
+    WinDumpHeader64 *hdr;
+    FWCfgVMCoreInfo info;
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+
+    /* the WinDumpHeader64 must sit right after the fixed ELF note header */
+    g_assert_cmpint(sizeof(WinDumpHeader64) % 4, ==, 0);
+
+    nhdr->n_namesz = cpu_to_le32(sizeof("VMCOREINFO")); /* 11 -> padded 12 */
+    nhdr->n_descsz = cpu_to_le32(sizeof(WinDumpHeader64));
+    nhdr->n_type = 0;
+    memcpy(note + sizeof(Elf64_Nhdr), "VMCOREINFO", sizeof("VMCOREINFO") - 1);
+
+    hdr = (WinDumpHeader64 *)(note + VMCOREINFO_ELF_NOTE_HDR_SIZE);
+    memcpy(hdr->Signature, "PAGE", sizeof(hdr->Signature));
+    memcpy(hdr->ValidDump, "DU64", sizeof(hdr->ValidDump));
+
+    qs = qtest_pc_boot("-device vmcoreinfo -m 16");
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    /* with no guest note yet, win-dmp must not be advertised */
+    g_assert_false(capability_has_format(qs->qts, "win-dmp"));
+
+    /* place the forged note in guest RAM and point vmcoreinfo at it */
+    qtest_memwrite(qs->qts, paddr, note, notesz);
+
+    memset(&info, 0, sizeof(info));
+    info.host_format = cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF);
+    info.guest_format = cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF);
+    info.size = cpu_to_le32(notesz);
+    info.paddr = cpu_to_le64(paddr);
+    qfw_cfg_write_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAME,
+                       &info, sizeof(info));
+
+    /* now win-dmp must be reported as available */
+    g_assert_true(capability_has_format(qs->qts, "win-dmp"));
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_shutdown(qs);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -231,6 +320,11 @@ int main(int argc, char **argv)
     if (g_str_equal(arch, "x86_64")) {
         qtest_add_func("/dump/win-dmp-unavailable",
                        test_dump_win_dmp_unavailable);
+
+        if (qtest_has_device("vmcoreinfo")) {
+            qtest_add_func("/dump/win-dmp-available",
+                           test_dump_win_dmp_available);
+        }
     }
 
     return g_test_run();
-- 
2.53.0


