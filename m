Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0A8CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 18:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTOWn-000890-HX; Sat, 30 May 2026 14:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Costas.Argyris@amd.com>)
 id 1wTOWm-00088g-8L
 for qemu-devel@nongnu.org; Sat, 30 May 2026 14:35:20 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Costas.Argyris@amd.com>)
 id 1wTOWk-0007HN-62
 for qemu-devel@nongnu.org; Sat, 30 May 2026 14:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXiWBUgoUbicInVdPKfJmxKN0nx0OFUpaerXAupGZjlXYkONVd147rBuJlQeJLh+D3bR0EvnAO8RcEEgbMpfM9iR1Va5pADfp5is/zBUAoFDfrE+/ZYJlD5jlKZ7k27dSDVD+BdaulHJ9IuzCuqHNeQs8Osk+ITMWJcv9aUHt0UaT1nH2VrEODV2dGEzoK7bTWthqRd8ueVM8dX2W7Xdr4V8POYw86blzWvUIdHGdxckSe57jbljObtJc10Pgp0MNOz/Ua16leCh2UXeFUIbBqXjQnIIr7p1SMBuFnOo1ym1A/cObC0nj6h0DMTAtH0ZN185nUoK7gpxqmUDI38tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E484lBTnfpvIIDkjEaYZXyKS10sKLB3+XbW0GGaOTMo=;
 b=cgAiMg0RBo63bWcI5Re++3cprOT1V3kXUE5MGQI9vys84+TTtObs+6p8z5qyOnsKcXwq+g0RrpzlUf6TnMSK0+6qGG2UzAyl/BDUEcBINgqLdH1dqgB8XKqfBaBev3FH/hxMxmjPzO6GvxBqi6/upcnOQPljv9mb8z2dc6hM2WKAk+vw4piJBXN/g64R1M5J5aQezB8U1eDpv33jEbuL08Ua22j4dTvQengPKiOc9ygdUTujt1ZaNEY4fS2qKmZYmxF/sNDkpI/44qWAu+eE548NPl+qhzJfrA7xQTZRLrECJQITHQM8FqgafbpsKx8cbu3/XHRPLzzWgYH7QvKOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E484lBTnfpvIIDkjEaYZXyKS10sKLB3+XbW0GGaOTMo=;
 b=dLlLedrI2V0zRS1gXcXgUlG3w3ibNuWvd6zfrKM4xeDuJ2MaMHt0wfuc6gLdPt7R74pj9CT8TPNBVX2GYArPQsa2GUaldPU97irHr+1EDUvJfsegPjV0dRmV+ACZFraumo7G3s+qEIxui8tk1nkCRY7436cEa4Y3vimYTowzzPA=
Received: from CH0PR03CA0424.namprd03.prod.outlook.com (2603:10b6:610:10e::21)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Sat, 30 May
 2026 18:35:12 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::7d) by CH0PR03CA0424.outlook.office365.com
 (2603:10b6:610:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sat, 30
 May 2026 18:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 30 May 2026 18:35:11 +0000
Received: from MIKCARGYRISD1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 30 May
 2026 13:35:10 -0500
From: Costas Argyris <costas.argyris@amd.com>
To: <qemu-devel@nongnu.org>
CC: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar
 <sarunkod@amd.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2] tests/qtest: Add amd-iommu command buffer head wrap test
Date: Sat, 30 May 2026 19:34:51 +0100
Message-ID: <20260530183458.7778-1-costas.argyris@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0094f356-36c9-4f8c-84ff-5d98b0108f14@oracle.com>
References: <20260517192314.355499-1-costas.argyris@amd.com>
 <0094f356-36c9-4f8c-84ff-5d98b0108f14@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e5e1b4-564e-49e7-d00f-08debe7a2f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: h1Jy3i2Rr+LBxwklaUMD0qaB2Chb5k5uODm/V1hM/gf2KxExhf9H0cpl2XJjKTTy2intB3gC0S9VX9yrIlLMM4J2q4xywP4fr5UlloXLV6UaLJ8Zys/FBpZchWvG6PnYglYlHsFQtHiMSK+tUGunN1NolhEc9TEVhDZ+y9zn9lWIjUYhMf4kvuG4XGvbwhQPJHOQDfSt05nvlQ2fdrdOoj9C0pmdwPXdM2aSpfiFFwibJDX+WhCr+euPy3PGwVVyno/Y4HX/gpfC5s18gQV5/0SX6nqc3RvxlnsHBDOSQ5g7AQ6RmOFX+lmTgePUsm7jXJ+/9w1PKdRUG9k4e5vdjCXJWTo4xaKJN2EyFGhs7LKJFzOUCqgtb9Nd/uhZC7tnJDNK4kWnCyT5S5QOWxMTXizc7rjmUnx8fOrJpbcVZLkvyotCZrr5GllGTwc7Y01aap4Q4Nc27QKkAG7kIywYO6MtZ0Kx+gUL9EW2JMBith45guqD0O7/ItqTAa9RMPp7b/XTlK1t0w+odjSfta4QrdBvmnrtEv8gn9Wn+iCSalbakRdvz4/mtNU5qV/2Qon+C44zGBk63KHFOEfmeUCvpsq2vpnqLOZ8tRTwBscirDeEUtQIqhtphOibcyC3XZNrLSHmLv/RYkgEPL6zg8Z9ifjhEj+EpfEcAHkRzGhrKcD1Me/QVch2YB7lUQl57UcW31ZIEi5Uy+KZwKwkDAZJqc5idiMSeh2tTmogBbpw0l4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q+gBuCT5LmIcOLHzxHTZeLJr60MZfOwdiVlYpMgLUrJ+JKqsuiZ8ge8Mk6eKjqr2lbH88HzHYpLSjgLV89pyAeOzlDrkzZexmD9sieAy92QoSveW53RdIzeOeARKvfPQG1CyJbhicWAK/UW6ocim/ZxMiq5bvJhbblymYKiaHICyINnH4J6SmLCLQiP/0kK/9Er+zzupRDyQWumSAhuwKT+Ejoq5irC+VMzwotIOLCSD0jxV7482Rb9T7cl6UTHkTj7Wxb5wkr2Xu0BsE9i7KuBvHJm+zLvXgdfFcX2pAEHZr5k+FXMsv75K4DjGIjnrjaErVfftdBTlGMchJ6K43JlaftKmff+ApVEkJad8tAERnkMNF7b1khDjEZRCqwp/hDR0kTMKaJT0f/MkF63pX1Y4hjpcVUNtU7gvxu/WL2wH/7S5dLdgZ1xX+sPvqDeC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 18:35:11.9593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e5e1b4-564e-49e7-d00f-08debe7a2f32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Costas.Argyris@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a qtest for AMD IOMMU command buffer head pointer wraparound.
The test programs a command buffer, fills it with COMPLETION_WAIT commands,
advances the tail to consume all but the final entry, then wraps the tail
to zero to force the final command to advance CmdHeadPtr past the end of
the buffer. The guest-visible CmdHeadPtr register must then wrap back to zero.

This covers the case fixed by an earlier CmdHeadPtr wraparound patch.

The Linux kernel AMD IOMMU driver is not affected by this bug because it
uses COMPLETION_WAIT with a memory store doorbell to detect command progress.

Signed-off-by: Costas Argyris <costas.argyris@amd.com>
---
Changes since v1:
 - Drop the amd_iommu.c fix.
 - Reframe as a test-only patch.
 - Derive CMDBUF_ENTRIES from CMDBUF_LEN_FIELD.
 - Skip the test when the q35 machine is not built.

 MAINTAINERS                  |  1 +
 tests/qtest/amd-iommu-test.c | 76 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |  1 +
 3 files changed, 78 insertions(+)
 create mode 100644 tests/qtest/amd-iommu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80d28e618d..750d415389 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4052,6 +4052,7 @@ M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
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
index 728dde54b3..67eea5c71a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -95,6 +95,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_AMD_IOMMU') ? ['amd-iommu-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_VTD') and
    config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
-- 
2.43.0


