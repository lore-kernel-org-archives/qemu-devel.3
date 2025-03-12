Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9423C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 03:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsD2A-0007vd-6Z; Tue, 11 Mar 2025 23:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsD1g-0007kx-8c
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 23:45:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsD1d-000505-I7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 23:45:00 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxHHItA9FnAdSSAA--.53877S3;
 Wed, 12 Mar 2025 11:44:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzMQtA9FntSJFAA--.58869S2;
 Wed, 12 Mar 2025 11:44:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
Date: Wed, 12 Mar 2025 11:44:45 +0800
Message-Id: <20250312034445.3350705-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMQtA9FntSJFAA--.58869S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add cpu hotplug testcase support for LoongArch system, it passes to
run with command "make check-qtest-loongarch64" as following:
  qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 0.38s 1 subtests passed

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Call test function add_loongarch_test_case() directly rather than
     qtest_cb_for_every_machine() since compatible machine is not
     supported on LoongArch system.
  2. Add architecture specified test case in separate line. 
---
 tests/qtest/cpu-plug-test.c | 28 ++++++++++++++++++++++++++++
 tests/qtest/meson.build     |  3 ++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 6633abfc10..6af81330c0 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -156,6 +156,32 @@ static void add_s390x_test_case(const char *mname)
     g_free(path);
 }
 
+static void add_loongarch_test_case(const char *mname)
+{
+    char *path;
+    PlugTestData *data;
+
+    if (!g_str_has_prefix(mname, "virt")) {
+        return;
+    }
+
+    data = g_new(PlugTestData, 1);
+    data->machine = g_strdup(mname);
+    data->cpu_model = "la464";
+    data->device_model = g_strdup("la464-loongarch-cpu");
+    data->sockets = 1;
+    data->cores = 3;
+    data->threads = 1;
+    data->maxcpus = data->sockets * data->cores * data->threads;
+
+    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
+                           mname, data->sockets, data->cores,
+                           data->threads, data->maxcpus);
+    qtest_add_data_func_full(path, data, test_plug_with_device_add,
+                             test_data_free);
+    g_free(path);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -168,6 +194,8 @@ int main(int argc, char **argv)
         qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
     } else if (g_str_equal(arch, "s390x")) {
         qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
+    } else if (g_str_equal(arch, "loongarch64")) {
+        add_loongarch_test_case("virt");
     }
 
     return g_test_run();
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8a6243382a..7e62204dcc 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -149,7 +149,8 @@ qtests_hppa = \
 
 qtests_loongarch64 = qtests_filter + \
   (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
-  ['boot-serial-test']
+  ['boot-serial-test',
+   'cpu-plug-test']
 
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter

base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
-- 
2.39.3


