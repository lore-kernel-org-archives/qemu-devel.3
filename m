Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8142AC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4zRk-0007v4-Bo; Thu, 09 May 2024 04:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s4zRg-0007uh-DN
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:48:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s4zRS-0003yc-Rz
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:47:59 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxqemyjTxm7OcJAA--.13887S3;
 Thu, 09 May 2024 16:47:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx8VWxjTxmR+wWAA--.26979S2; 
 Thu, 09 May 2024 16:47:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Thomas Huth <thuth@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 maobibo@loongson.cn
Subject: [PATCH v2] tests/qtest: Add some test cases support on LoongArch
Date: Thu,  9 May 2024 16:47:45 +0800
Message-Id: <20240509084745.2514607-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx8VWxjTxmR+wWAA--.26979S2
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

Add boot-serial-test and filter test cases support on LoongArch system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
 1. Refresh the changelog, adding filter test case support also.
 2. Adjust order of loongarch qtest in alphabetical order.
---
 tests/qtest/boot-serial-test.c | 10 ++++++++++
 tests/qtest/meson.build        |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index e3b7d65fe5..df389adeeb 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -26,6 +26,14 @@ static const uint8_t bios_avr[] = {
     0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
 };
 
+static const uint8_t bios_loongarch64[] = {
+    0x0c, 0xc0, 0x3f, 0x14,                 /* lu12i.w $t0, 0x1fe00    */
+    0x8c, 0x81, 0x87, 0x03,                 /* ori     $t0, $t0, 0x1e0 */
+    0x0d, 0x50, 0x81, 0x03,                 /* li.w    $t1, 'T'        */
+    0x8d, 0x01, 0x00, 0x29,                 /* st.b    $t1, $t0, 0     */
+    0xff, 0xf3, 0xff, 0x53,                 /*  b      -16  # loop     */
+};
+
 static const uint8_t kernel_mcf5208[] = {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
     0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
@@ -167,6 +175,8 @@ static const testdef_t tests[] = {
     { "sparc", "SS-600MP", "", "TMS390Z55" },
     { "sparc64", "sun4u", "", "UltraSPARC" },
     { "s390x", "s390-ccw-virtio", "", "device" },
+    { "loongarch64", "virt", "-cpu max", "TT", sizeof(bios_loongarch64),
+      NULL, bios_loongarch64 },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
     { "m68k", "next-cube", "", "TT", sizeof(bios_nextcube), 0, bios_nextcube },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6f2f594ace..86293051dc 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -139,6 +139,9 @@ qtests_hppa = ['boot-serial-test'] + \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
+qtests_loongarch64 = qtests_filter + \
+  ['boot-serial-test']
+
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
 

base-commit: 4e66a08546a2588a4667766a1edab9caccf24ce3
-- 
2.39.3


