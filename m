Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8F9CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIn6P-0000XY-2J; Mon, 19 Oct 2026 09:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xIn6M-0000X8-KE
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xIn6K-0006TS-La
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792415307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T7r0Uvk1yC1V0SjL2slJdvbvnZm7UKHg7xQ/BkdLR+4=;
 b=Hylg5mZ4+iAcMPIg83YxY+Cqy3ENk2IjYHzLxesXrbPIocrkpVzqc1kMIld7AlizS9rvMT
 EiZtikAbe1NoecnmIcuVaOc3QiHBYyHd0j7E+tUk0fjppL+vPsH3gkKZ58nnV4qpiHv8Fy
 lbvMvOXCb6maIX5SMNl+34CxTD5yZe4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-djgeFcnsN1ipygP_DfUXhA-1; Mon,
 19 Oct 2026 13:07:18 +0000
X-MC-Unique: djgeFcnsN1ipygP_DfUXhA-1
X-Mimecast-MFC-AGG-ID: djgeFcnsN1ipygP_DfUXhA_1792415237
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B69251954B34; Mon, 19 Oct 2026 13:07:17 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F01118004D2; Mon, 19 Oct 2026 13:07:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, peter.maydell@linaro.org, eauger@redhat.com,
 leif.lindholm@oss.qualcomm.com
Subject: [PATCH] tests: arm/virt: add GWDT tests
Date: Mon, 19 Oct 2026 15:07:13 +0200
Message-ID: <20261019130713.4127060-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/meson.build      |   1 +
 tests/qtest/sbsa-gwdt-test.c | 227 +++++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 tests/qtest/sbsa-gwdt-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 200abf6f36..5e1160ac0f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -290,6 +290,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_ARM_VIRT') ?
    ['iommu-smmuv3-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_WDT_SBSA') ? ['sbsa-gwdt-test'] : []) + \
   qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
diff --git a/tests/qtest/sbsa-gwdt-test.c b/tests/qtest/sbsa-gwdt-test.c
new file mode 100644
index 0000000000..ae166778f7
--- /dev/null
+++ b/tests/qtest/sbsa-gwdt-test.c
@@ -0,0 +1,227 @@
+/*
+ * SBSA Generic Watchdog Timer (GWDT) testcase
+ *
+ * Copyright (C) 2026 Red Hat
+ *
+ * Authors:
+ *  Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "libqtest-single.h"
+#include "qobject/qdict.h"
+
+#define GWDT_REFRESH_BASE   0x0f000000
+#define GWDT_CONTROL_BASE   0x0f001000
+#define GWDT_WRR            0x000
+#define GWDT_WCS            0x000
+#define GWDT_WORL           0x008
+#define GWDT_WORH           0x00C
+#define GWDT_WCVL           0x010
+#define GWDT_WCVH           0x014
+#define GWDT_W_IIDR         0xFCC
+
+#define GWDT_WCS_EN         BIT(0)
+#define GWDT_WCS_WS0        BIT(1)
+#define GWDT_WCS_WS1        BIT(2)
+
+#define GWDT_ID_VALUE       0x1043B
+
+static uint32_t ctrl_read(uint32_t offset)
+{
+    return readl(GWDT_CONTROL_BASE + offset);
+}
+
+static void ctrl_write(uint32_t offset, uint32_t value)
+{
+    writel(GWDT_CONTROL_BASE + offset, value);
+}
+
+static void refresh_write(uint32_t offset, uint32_t value)
+{
+    writel(GWDT_REFRESH_BASE + offset, value);
+}
+
+static void reset(void)
+{
+    qtest_system_reset(global_qtest);
+}
+
+/* Convert watchdog ticks to nanoseconds */
+static int64_t gwdt_ticks(uint32_t ticks)
+{
+    QDict *resp = qmp("{ 'execute': 'qom-get', 'arguments':"
+                      "{ 'path': '/machine/peripheral/gwdt',"
+                      "'property': 'clock-frequency' }}");
+    uint64_t freq = qdict_get_uint(resp, "return");
+    qobject_unref(resp);
+    return muldiv64(ticks, NANOSECONDS_PER_SECOND, freq);
+}
+
+static void test_identification(void)
+{
+    g_assert_cmphex(ctrl_read(GWDT_W_IIDR), ==, GWDT_ID_VALUE);
+    g_assert_cmphex(readl(GWDT_REFRESH_BASE + GWDT_W_IIDR), ==, GWDT_ID_VALUE);
+}
+
+static void test_enable_disable(void)
+{
+    uint32_t wcs;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, 0);
+    ctrl_write(GWDT_WORH, 0xF0000000);
+
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_EN, ==, GWDT_WCS_EN);
+
+    ctrl_write(GWDT_WCS, 0);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_EN, ==, 0);
+
+    /* make sure no timer is armed after disable */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+}
+
+static void test_refresh(void)
+{
+    uint32_t wcs;
+    const uint32_t wor = 100000;
+    const int64_t timeout = gwdt_ticks(wor);
+
+    reset();
+
+    ctrl_write(GWDT_WORL, wor);
+    ctrl_write(GWDT_WORH, 0);
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+
+    /* advance to before the deadline */
+    clock_step(timeout - 1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* extend deadline and advance now to deadline - 1 */
+    refresh_write(GWDT_WRR, 0);
+    clock_step(timeout - 1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* make sure that gwdt triggers on refresh deadline */
+    clock_step(1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+}
+
+static void test_wcv_load(void)
+{
+    uint32_t wcs;
+    const uint32_t wor = 10000;
+    const int64_t timeout = gwdt_ticks(wor);
+    int64_t now, deadline;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, wor);
+    ctrl_write(GWDT_WORH, 0);
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+
+    /* explicit WCV refresh */
+    now = clock_step(1);
+    deadline = now + 2 * timeout;
+    ctrl_write(GWDT_WCVH, deadline >> 32);
+    ctrl_write(GWDT_WCVL, deadline);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* initial WOR deadline, no WS0 yet as WCV load pushed it further */
+    clock_step(timeout);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* right before WCV deadline, no WS0 */
+    clock_step(timeout - 1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* advance to WCV deadline, WS0 is triggered */
+    clock_step(1);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+}
+
+static void test_ws0_timeout(void)
+{
+    uint32_t wcs;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, 10000);
+    ctrl_write(GWDT_WORH, 0);
+
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, 0);
+
+    /* advance clock to WS0 deadline */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+}
+
+static void test_ws1_timeout(void)
+{
+    uint32_t wcs;
+
+    reset();
+
+    ctrl_write(GWDT_WORL, 10000);
+    ctrl_write(GWDT_WORH, 0);
+    ctrl_write(GWDT_WCS, GWDT_WCS_EN);
+
+    /* WS0 deadline test */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+    g_assert_cmphex(wcs & GWDT_WCS_WS1, ==, 0);
+
+    /* WS1 deadline test */
+    clock_step_next();
+    wcs = ctrl_read(GWDT_WCS);
+    g_assert_cmphex(wcs & GWDT_WCS_WS0, ==, GWDT_WCS_WS0);
+    g_assert_cmphex(wcs & GWDT_WCS_WS1, ==, GWDT_WCS_WS1);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    const char *arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "aarch64") || !qtest_has_machine("virt")) {
+        g_test_skip("'aarch64/virt' machine is not available");
+        return 0;
+    }
+
+    qtest_add_func("/sbsa-gwdt/identification", test_identification);
+    qtest_add_func("/sbsa-gwdt/enable-disable", test_enable_disable);
+    qtest_add_func("/sbsa-gwdt/refresh", test_refresh);
+    qtest_add_func("/sbsa-gwdt/wcv-load", test_wcv_load);
+    qtest_add_func("/sbsa-gwdt/ws0-timeout", test_ws0_timeout);
+    qtest_add_func("/sbsa-gwdt/ws1-timeout", test_ws1_timeout);
+
+    qtest_start("-M virt -cpu max -device sbsa-gwdt,id=gwdt "
+                "-watchdog-action none");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
-- 
2.52.0


