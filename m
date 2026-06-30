Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64112C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaBY-0002mv-4c; Tue, 30 Jun 2026 11:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBS-0002k5-5H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaBQ-0000DG-CK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BavUBLAK3VDuyAhs4ypu9Db+kGmiyaIDIJzxHE6lCAY=;
 b=YVnXa9eM1pRTbzis6OLeAGqBjjZ82zqhinNp1LhH5QJNbsytN5l51193g1hnJLMCwvXrSn
 HZcQoHmO2FC3S4TOghnO/kYKmxGgMwT3HKkJyKQfZkvWzIIJ7e7G2VmP+7yIH4JPIr3GZn
 3FgZ97um/+KEcYRM2D5r3TgK0V35Hg0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-VC_ytAY1PzamBrYU5T2S1Q-1; Tue,
 30 Jun 2026 11:15:28 -0400
X-MC-Unique: VC_ytAY1PzamBrYU5T2S1Q-1
X-Mimecast-MFC-AGG-ID: VC_ytAY1PzamBrYU5T2S1Q_1782832527
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4DC21955DA1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:15:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0E533000C02; Tue, 30 Jun 2026 15:15:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:22 +0400
Subject: [GIT PULL 7/8] tests/qtest/dump: cover win-dmp availability via
 vmcoreinfo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-7-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5453;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yKRH52D4g5dKsLWLush0OYxS7DZ9LzNtIlGYCyxwP+s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91nuZw1S+iH1iipK/aW8XeWEIOIpuIQ+rYng
 dC9ggivQ4OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZwAKCRDa6OEJdZac
 5cZzD/9n7LFSlk7WVv2I+S3C7VcJJijAWhhRZD4GLh50ycU1lTYCAoKCz0FSa3shVOjW+8X7fom
 n18NuiUFMt0bynXGkx0cKfP3HYnxCAlkBaTQIX7MiaQPkuBLl4IsWajV0L7uJahJM7SJcnjOqCB
 MRPmCbtkGEJDVGHfXY0mZYwwigLh0CFhPf7RKC0HhT+1fuUiC4qvz1C7TGDljGfPQnyy6YhzVzP
 p+hwvqu645OhD5DM4gUP4/MYdXJJh/OEEYM9qEDx/P6PfQtuffr38x+flbts1GvJeQmmuIRa2S9
 9CDPHAI7z2nWbxyPWMrLIWdDc6w5HAHxMs2ilD7VvyTw0VUfozHJOZqIP5rSQPKJX8qMLC6Sc78
 7SrdE9HuNHEhYYWQrkbg6LUz8q18MhIIV58ZhInfmouFUx7UpBsx90oqiq0XpSabdJpUnBhH3/z
 l5Yoe8BDIhSisFucdSo1sQVbGwlEvLFDg5FgecUqW47ZoWjyVL0UE7ZMSqY97UQOJ/doL1dHeZN
 X1PbuGnZrJLopQi53AeY/vpKsh2AwqvPGaReQtgJT6IQi9n7QzoxRpztz2ZFblu8lD3Q/O8/EpW
 su6/32ud1lIkpEGfGc5itLeKGftpZ/x49Cy3zAGVzywx4xY7aliSrQhlm8aCaq3jUntpm4tYvT1
 LlznlxuaoAMryIA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260619101834.228432-8-den@openvz.org>
---
 tests/qtest/dump-test.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tests/qtest/dump-test.c b/tests/qtest/dump-test.c
index 6afaa2c2ea4..30c95a35285 100644
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
2.54.0


