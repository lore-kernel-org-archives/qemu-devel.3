Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322ECCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFqY-0002qx-4c; Wed, 24 Jun 2026 01:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFpv-0002Wd-1O; Wed, 24 Jun 2026 01:07:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFpo-0005kE-L8; Wed, 24 Jun 2026 01:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277622; bh=qWXL5mRYAbvxI93203RuLrL7Mu57SB9BYiGfhMuCE/k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dZyQ0FIDyAm6J6dSUOXQbwm4hnOZjDaD+mTjFmcsVcHX1CdzggoQvsn7YmdVQfAw1
 JNluPkNKIWEvJ4ioCbKQ4Z5iPHNlDatWxneTDiUFbpkpxx6ntgzPwfAFrWS6HiX/gu
 spyPIwJNneISwOZlgMR1ZY+nQeDRzEsohcQIQgBYHjvrM90gcjzBkjRlm5etfQbd0s
 L+a9hT3zZZmjxbiKjrItHk3340UxUErYTwKxxG8jfx3MQKH15eicjX82fJH8gqYf67
 becSJ8bR/F11tgTwalpo+6PwzDNGzGuEBA1jK9ExZ817tR09x/Tbbny7lQMwhmWrTl
 MYbsgAjt75UeQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 514F11BA660;
 Wed, 24 Jun 2026 08:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3B1AB3DDAFD;
 Wed, 24 Jun 2026 08:07:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Costas Argyris <costas.argyris@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 66/95] tests/qtest: Add amd-iommu command buffer head
 wrap test
Date: Wed, 24 Jun 2026 08:05:01 +0300
Message-ID: <20260624050541.395079-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Costas Argyris <costas.argyris@amd.com>

Add a qtest for AMD IOMMU command buffer head pointer wraparound.
The test programs a command buffer, fills it with COMPLETION_WAIT commands,
advances the tail to consume all but the final entry, then wraps the tail
to zero to force the final command to advance CmdHeadPtr past the end of
the buffer. The guest-visible CmdHeadPtr register must then wrap back to zero.

This covers the case fixed by an earlier CmdHeadPtr wraparound patch.

The Linux kernel AMD IOMMU driver is not affected by this bug because it
uses COMPLETION_WAIT with a memory store doorbell to detect command progress.

Signed-off-by: Costas Argyris <costas.argyris@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260530183458.7778-1-costas.argyris@amd.com>
(cherry picked from commit 8a1c09cbd3fe776a467398700c610cd126ee8a59)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..a759198345 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3939,6 +3939,7 @@ M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
 R: Sairaj Kodilkar <sarunkod@amd.com>
 S: Supported
 F: hw/i386/amd_iommu*
+F: tests/qtest/amd-iommu-test.c
 
 OpenSBI Firmware
 L: qemu-riscv@nongnu.org
diff --git a/tests/qtest/amd-iommu-test.c b/tests/qtest/amd-iommu-test.c
new file mode 100644
index 0000000000..fb28511588
--- /dev/null
+++ b/tests/qtest/amd-iommu-test.c
@@ -0,0 +1,76 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/i386/amd_iommu.h"
+
+#define CMDBUF_ADDR       0x200000
+#define CMDBUF_LEN_FIELD  8
+#define CMDBUF_ENTRIES    (1U << CMDBUF_LEN_FIELD)
+
+static inline uint64_t amdvi_reg_readq(QTestState *s, uint64_t offset)
+{
+    return qtest_readq(s, AMDVI_BASE_ADDR + offset);
+}
+
+static inline void amdvi_reg_writeq(QTestState *s, uint64_t offset,
+                                    uint64_t val)
+{
+    qtest_writeq(s, AMDVI_BASE_ADDR + offset, val);
+}
+
+static void test_cmdbuf_head_wrap(void)
+{
+    QTestState *s;
+    uint64_t head;
+    int i;
+    /* 16 bytes per command */
+    struct {
+        uint64_t qw0;
+        uint64_t qw1;
+    } cmdbuf[CMDBUF_ENTRIES];
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    s = qtest_init("-M q35 -device amd-iommu");
+
+    /* fill the command buffer with COMPLETION_WAIT (no-op) commands */
+    for (i = 0; i < CMDBUF_ENTRIES; i++) {
+        cmdbuf[i].qw0 = (uint64_t)AMDVI_CMD_COMPLETION_WAIT << 60;
+        cmdbuf[i].qw1 = 0;
+    }
+    qtest_memwrite(s, CMDBUF_ADDR, cmdbuf, sizeof(cmdbuf));
+
+    /* point the IOMMU at the command buffer and set its length */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_BASE,
+                     CMDBUF_ADDR | ((uint64_t)CMDBUF_LEN_FIELD << 56));
+
+    /* enable the IOMMU and its command buffer processor */
+    amdvi_reg_writeq(s, AMDVI_MMIO_CONTROL,
+                     AMDVI_MMIO_CONTROL_AMDVIEN | AMDVI_MMIO_CONTROL_CMDBUFLEN);
+
+    /* advance tail to the last entry, consuming all but the final entry */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL,
+                     (CMDBUF_ENTRIES - 1) * AMDVI_COMMAND_SIZE);
+
+    /* wrap tail to 0, consuming the final entry and completing the buffer */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL, 0);
+
+    /* after consuming all entries the IOMMU must wrap CmdHeadPtr to 0 */
+    head = amdvi_reg_readq(s, AMDVI_MMIO_COMMAND_HEAD);
+    g_assert((head & AMDVI_MMIO_CMDBUF_HEAD_MASK) == 0);
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/q35/amd-iommu/cmdbuf-head-wrap", test_cmdbuf_head_wrap);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..cddb08604b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -94,6 +94,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_AMD_IOMMU') ? ['amd-iommu-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
-- 
2.47.3


