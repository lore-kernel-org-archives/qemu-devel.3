Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2248AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4d5N-0002Gy-8l; Wed, 08 May 2024 04:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s4d5D-0002Ek-MS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:55:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s4d5A-0008Pk-ES
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:55:27 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bxc+rzPTtmlEsJAA--.12687S3;
 Wed, 08 May 2024 16:55:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxXN7yPTtmamwVAA--.41658S2; 
 Wed, 08 May 2024 16:55:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Thomas Huth <thuth@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/boot-serial-test: Add support on LoongArch system
Date: Wed,  8 May 2024 16:55:14 +0800
Message-Id: <20240508085514.2510592-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxXN7yPTtmamwVAA--.41658S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add boot-serial-test test case support on LoongArch system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/qtest/boot-serial-test.c | 10 ++++++++++
 tests/qtest/meson.build        |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index e3b7d65fe5..631015e8c8 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -129,6 +129,14 @@ static const uint8_t kernel_stm32vldiscovery[] = {
     0x04, 0x38, 0x01, 0x40                  /* 0x40013804 = USART1 TXD */
 };
 
+static const uint8_t bios_loongarch64[] = {
+    0x0c, 0xc0, 0x3f, 0x14,                 /* lu12i.w $t0, 0x1fe00    */
+    0x8c, 0x81, 0x87, 0x03,                 /* ori     $t0, $t0, 0x1e0 */
+    0x0d, 0x50, 0x81, 0x03,                 /* li.w    $t1, 'T'        */
+    0x8d, 0x01, 0x00, 0x29,                 /* st.b    $t1, $t0, 0     */
+    0xff, 0xf3, 0xff, 0x53,                 /*  b      -16  # loop     */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -181,6 +189,8 @@ static const testdef_t tests[] = {
     { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
     { "arm", "stm32vldiscovery", "", "T",
       sizeof(kernel_stm32vldiscovery), kernel_stm32vldiscovery },
+    { "loongarch64", "virt", "-cpu max", "TT", sizeof(bios_loongarch64),
+      NULL, bios_loongarch64 },
 
     { NULL }
 };
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6f2f594ace..6619b630e6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -256,6 +256,10 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
+ qtests_loongarch64 = \
+  qtests_filter + \
+  ['boot-serial-test']
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',

base-commit: 4e66a08546a2588a4667766a1edab9caccf24ce3
-- 
2.39.3


