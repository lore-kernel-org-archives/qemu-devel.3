Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A36CD4F48
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 19:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOhLx-0005Mj-QX; Sun, 17 May 2026 15:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Costas.Argyris@amd.com>)
 id 1wOhBT-0001uO-NE
 for qemu-devel@nongnu.org; Sun, 17 May 2026 15:29:55 -0400
Received: from mail-northcentralusazon11012040.outbound.protection.outlook.com
 ([40.107.200.40] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Costas.Argyris@amd.com>)
 id 1wOhBR-0002LV-LE
 for qemu-devel@nongnu.org; Sun, 17 May 2026 15:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAjqap4sMsroexoN+0yjawHNn2y3gQZevhBf+fBR0M0/HLFOLbysrvIcRulNxp6UPWQzi9QMSUW9AS1TWcwiIffKOF5yl5ivCKGd6GQ5VfWanZTJStORoBDp+9N/V/UngZ8ah3DE5qCcndFjq8iRmYqVx6hvbImBoDrnzH8g//Ihr3clm6emSJAaXHzvA1lGQ/IojWBfzZnSgHdHxc5dyRILLmkoXiVhUMCGvK3EzYWp6maxayxkZ/ca4teD9Hba+KYhHV2WxPvoz3If0YCNv8FQMIWn6gTnmNybjN71JaetR+WW2umctvwKEjM6ws6ymt6Bw3vDUhcz4/17v5W5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WesSBblTGsYz019IcL/ktmViu/7aC/UST+jINlpxAJg=;
 b=HEyg9U3+kt5DeGfXKc56Fh3aP5gbQTYdUmOpmDTs4vzSAsN3Io7EZxcZ3gqNNwgzr9OtmYsHAa+nooVFbwT/o5Z5Io9tIX+y6kBD67vHDSrQMMSvmJhyPSRDvfVfeR8svqNxu5fSLf2u8gnDgRAKvHyQK6PmassPlZFt5ZwDVsz+dsyoiFe5098AnliKEAp/lIPjzs8J/haBi9mqlbzWPY+yHlI3HB/XdlFddPChFJbgTQeVleL2IQC/S7C+aXwRVxj6RNeFf64gouMlCEo7OH2K/z4YpeMRYWfliFL4Y5w/URnlkQ/GtnYCdHGZ5I9NjJwtI3ER+uuv7RmGt2Sm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WesSBblTGsYz019IcL/ktmViu/7aC/UST+jINlpxAJg=;
 b=cIQi7rSBZjovo5z4IJSXVXpCayy5qPAbhnPvFhA4+EkLk6oJne+saiaja51mQiVziHaNDH6ldF9GrNy5+f8PQ+JhIpW0r9KjzMDHE2C+DRODGLdAaU8/37fYn0C7albPHq+iTTsKSvszD+L6HCXD70zc+MHrmTmAMOpmhKoMsu0=
Received: from MN2PR05CA0037.namprd05.prod.outlook.com (2603:10b6:208:236::6)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.16; Sun, 17 May 2026 19:24:46 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:236:cafe::7f) by MN2PR05CA0037.outlook.office365.com
 (2603:10b6:208:236::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.10 via Frontend Transport; Sun, 17
 May 2026 19:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Sun, 17 May 2026 19:24:46 +0000
Received: from MIKCARGYRISD1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 14:24:44 -0500
From: Costas Argyris <costas.argyris@amd.com>
To: <qemu-devel@nongnu.org>
CC: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar
 <sarunkod@amd.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, "Costas
 Argyris" <costas.argyris@amd.com>
Subject: [PATCH] amd-iommu: fix CmdHeadPtr not wrapping to 0 after full
 command buffer pass
Date: Sun, 17 May 2026 20:23:14 +0100
Message-ID: <20260517192314.355499-1-costas.argyris@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 620a45c0-c5c3-4b09-3916-08deb449f49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003|3023799003|11063799003|13003099007;
X-Microsoft-Antispam-Message-Info: hHJnVh+srzp7Zes5tW9wJsk6lwmA1a0VGfSRprfn1CF2+JFUZYUjjOq3HxMpzJ9u6i8b4GtUvSOPbvoW2/fTqXwoxrBO5scFi8TFnXQpm2GelSPzGZr7AjOUCq7LzM/MSiZpZxG9X1Ib2hZQr8vE7FaLj4XAE9PIMcgmTJ57znkzRwHVmQJwyCS3tfhNhO1DX8wiTLpTFgWmkDusR82nMhuegO1Rlu7aSz2bt6IU7J5WYql1NjN+9bJxqckA0y4MWwUh7CxCmL0ZjzITB7my/WnJnvxCfx9GU/2A+VrGmUBXP/+Fd8bLoTDoilsqFjvza2NbSbHg3Q213H+ENGxAx6ooQ15YxfnDe+GBgUSD5YZE0rJW8oUkMmW7U1qpz1XDpz2FGHn+x35roJh+gZ8j27eAjF0gbXgflockGxuFekDj7yhRJ80qvo5ofcK8nriTYm4qOCdc3hPknEh+3kQbu34PIj5NISUfkg/LCyjsW0QVGQE20oFYxUIcR+G+TjuDA68NJcXth4H4+PM+HrM1YKj+LaMOf9REpoIRIuMn04DrJk92nXhqYeSGFeWzKYeHDEcJa3OzmtDTd3GI3xHBsUuoH5TmQq+GOoNE65Jk6JDcBBJxEwk+q6mSY+EL9N5nxTzZa2QTtEo+X++HZdllb+BBXunEu89tUiVAWPuxSf8osq05NnURx43oC9aVgM9kKJUHmAWdQZ+QYlv6K0WrENweJSiRm2q0mUY/iMXgYK4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003)(3023799003)(11063799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qh0qwQ5tt/SifYwW9Qn8deBY3CeBtHhpdRTdqXKbU1NDbv44KQy4g3R7paDqRI5SXmeCGjTUCzpRN/izS2rGmDXlZXLtJR1WSdktpOASzJT99PWknwJBtjZY+rZFyNBMpbngvZRQK9VjKPlGwkUJDRJqRQGEhfMdc6/IsPcAwyhu+Gh2DDlLwBZErML+FJWh80bfzfFN5Y8u5UuBdZkbx+38I9ISIZJvGbo1/QWBNaZZmote4t0jK8/Ri48iJiIhd1ga+ZGshFn8OUfslsFHjjxZPrtyNPjLjSFv3NEDjEshzRD4Ir45VU/MtDMs5SNkFLLSBtuyVPT11p0UAuS/5MZpcpuUUs+jZ4sK5TDWYLLFg0rZPGv8O1wLiKvZM4ktxPxaTlRum945iTEo5kxVpOepqSrC20o2M46ANsOUTrt4Xpc/fzCzilRe6Tp58A92
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 19:24:46.2387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620a45c0-c5c3-4b09-3916-08deb449f49e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
Received-SPF: permerror client-ip=40.107.200.40;
 envelope-from=Costas.Argyris@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 17 May 2026 15:40:43 -0400
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

When processing commands, the internal cmdbuf_head state is correctly
reset to 0 on wrap, but the MMIO CmdHeadPtr register was written before
the wrap check, leaving the guest-visible register stuck at the buffer
length instead of 0 after a full command buffer pass.

Move the register write after the wrap check so the MMIO value stays in
sync with the internal state.

The Linux kernel AMD IOMMU driver is not affected by this bug because
it uses COMPLETION_WAIT with a memory store doorbell to detect command
progress.

Add a test to lock this down.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3338

Signed-off-by: Costas Argyris <costas.argyris@amd.com>
---
 MAINTAINERS                  |  1 +
 hw/i386/amd_iommu.c          |  2 +-
 tests/qtest/amd-iommu-test.c | 71 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |  1 +
 4 files changed, 74 insertions(+), 1 deletion(-)
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
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2..ce18cb453f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1475,12 +1475,12 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
         trace_amdvi_command_exec(s->cmdbuf_head, s->cmdbuf_tail, s->cmdbuf);
         amdvi_cmdbuf_exec(s);
         s->cmdbuf_head += AMDVI_COMMAND_SIZE;
-        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
 
         /* wrap head pointer */
         if (s->cmdbuf_head >= s->cmdbuf_len * AMDVI_COMMAND_SIZE) {
             s->cmdbuf_head = 0;
         }
+        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
     }
 }
 
diff --git a/tests/qtest/amd-iommu-test.c b/tests/qtest/amd-iommu-test.c
new file mode 100644
index 0000000000..0438ee9586
--- /dev/null
+++ b/tests/qtest/amd-iommu-test.c
@@ -0,0 +1,71 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/i386/amd_iommu.h"
+
+#define CMDBUF_ADDR       0x200000
+#define CMDBUF_ENTRIES    256
+#define CMDBUF_LEN_FIELD  8
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
+    s = qtest_init("-M q35 -device amd-iommu");
+
+    /* write 256 COMPLETION_WAIT (no-op) commands to guest RAM */
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
+    /* advance tail to the last entry, consuming entries 0..254 */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL,
+                     (CMDBUF_ENTRIES - 1) * AMDVI_COMMAND_SIZE);
+
+    /* wrap tail to 0, consuming entry 255 and completing the buffer */
+    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL, 0);
+
+    /* after consuming all 256 entries the IOMMU must wrap CmdHeadPtr to 0 */
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


