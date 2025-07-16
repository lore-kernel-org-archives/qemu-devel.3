Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA46C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyuY-00025U-MP; Wed, 16 Jul 2025 05:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysG-0002Bs-7Q; Wed, 16 Jul 2025 05:56:34 -0400
Received: from mail-bn8nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62f]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysD-0006m7-7g; Wed, 16 Jul 2025 05:56:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBFIUlUxGe1S/tB82YzeWb17r8npm+7UdhflcTHX+EjdObksDMquxRl4lHqvnl6AsGSMJVyd3E4H8Mv5OxUkD62YONxS9R6JUFOpUB6b/rg9upoYlDDlA3HJcG1x+un5Ltkl0cdmnX/Q0ZE7PlTu/0zieJ0gvTNmycVAxuYezu7faLhQ2TB/BfHe2hPs0bJZ3HfOwnE0fNYe/+DFx82lLTRJxEDrt6gzatwYwwk+EyVge5vBtSIagXX9aCOIGKDh3LqJ4ATpBD8rwsUNnSj2pLMdHL8vtlilNo+MGDbFUPknbskdoH9bhEe+RkM7C31PjgMpP3e/Bo7ZtFzngzYNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOC0UX/IMiLqNquMCxRNMZCUtOoSp1AkUdoRY6AMf1U=;
 b=uLymnmbqilv1jUGQrDrPpDf1tPmtpeT5DBy8oNm1hiSrI+f03SDP2NKS1GFmDAKyhAF+nOuy7r7I1elpTwlB281NXnlHsF2lzqgqXrRDiN6tCDA5FNgYde3U+29PbczqI4nDvHcA7Tc2oAm/vCCLwdoV8PzY8ruwNEe3m5DXABc4E+iXFZvYhbpga4/mM8SxMJeukZONhBa/j0f2dZg5D7mIsKs/0t+jKWvXETmUw3zhfGLCLNhpR9cF8cYsc4zAkOKcGNqYOWLD9kZTGkALJrZgiKfvFekfR8sqc6JNrj3ZYgFB88RJwJhrOHQfGJZHtcFjdXziU+YXfDtmrIIRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOC0UX/IMiLqNquMCxRNMZCUtOoSp1AkUdoRY6AMf1U=;
 b=XKl1rfqcgB0q0OKbV5q4nLYPA2KWO0Wx+ou/5i8TVXNls1+M+E/KLoZyM2XOqwgz6jUtUZPZdWhERK11VySP+Q0qjo/Fhb0vwgz7D9AIi3YwNp0DvWGZgm0Mst4aqdMhWahO2MZOYlqW5rN+anb9sYbUGyfWHsLQD+DnT0tmoyk=
Received: from DM5PR08CA0053.namprd08.prod.outlook.com (2603:10b6:4:60::42) by
 BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:56:19 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::99) by DM5PR08CA0053.outlook.office365.com
 (2603:10b6:4:60::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:17 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:15 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 39/48] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Date: Wed, 16 Jul 2025 11:54:21 +0200
Message-ID: <20250716095432.81923-40-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e74f6d7-9b6d-4276-e438-08ddc44f02fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i3MyS/elt6xTwT7tUAeMWgmjjoBEoMqwDkH9vNEFg/EwkIS+IKcITvYo+1PU?=
 =?us-ascii?Q?rlAOpXOjxcYMdROwi3ly6HsYW0UPbWT/Z0jB7lJfjDNDbju39iN+YDLlesob?=
 =?us-ascii?Q?GNZyQl4wdEuVNZqZD6TMEza/VkdeGoTi/NgEiu4VpbfDHOQg6tp5cl0JEg9R?=
 =?us-ascii?Q?DDmtlF+HRYyDXuXDL7EGqtRsr7959bj9G2VTQ8mBc46jYZNNAMkTyzf5Fcss?=
 =?us-ascii?Q?GN9alKgDAV2hGucvH3ope9t9fHJizFxJ21O/kUfDNEu7aV281o2Z3kJcwZ7V?=
 =?us-ascii?Q?gjHFwJt/wwv83xRdSdMMtokt/UVefvJXuML4TjMWYimG6PCVQraxvOzWadtk?=
 =?us-ascii?Q?11qc9XFMs2rCI+jvjkVHHxmA/ffUNr0y9l5olp3Nd1rqwcOY4Ki5aGiWF3hH?=
 =?us-ascii?Q?5UjixWglshhdTwNbYfDOYMytrXGnm4qDbJiKOzh2kGndP5+z3U1yOwJO8t45?=
 =?us-ascii?Q?FEfah+CZ34O8aC093ONnIvTABz97LGHEoDg2NAACnVpth0zpx0CMeUpwC6Xc?=
 =?us-ascii?Q?EZVvDYZgTs2E4s862tF9euma0SragLLC0p02aC4EwLYfL7aHLpdF3lzksW5j?=
 =?us-ascii?Q?wB8vZRGLkO/dexsQaMt50zbyG5BJUda5JT7XVXjqTRgkiRjeq7Pt4da4XH6C?=
 =?us-ascii?Q?/fbB3vYjZlbagavX3fbeaQn2bJWfibSLvBLUw3JOq0zhKExjrKRS1Ngm+66o?=
 =?us-ascii?Q?g1xK9brPqRUnCYtUrRtJkK/k47iKqMOdlOzSSkevlSoE0vdoyksWP5dnzTk6?=
 =?us-ascii?Q?K4TNXB8XSTLhxxCUlKTLgveEZGViSQXwmuuLmHRq+dN/oHatZdUZ0ask3kZ4?=
 =?us-ascii?Q?PjsqTdJFaQVN7JKHd+uj3vkFF5uI43AVSn4gh9ySteYEP/FLMUgZiDAqyNzZ?=
 =?us-ascii?Q?wVEio7jd7wY7DnXYc0PWz5EhJTrp8vyGHxotkRe6WAUpouvrwwh5/0An+KV+?=
 =?us-ascii?Q?4CAanM+aKOR9ruIe2k1aqsPgX56/6sY/ilR7JCQyJ+BxvTgf2rFHSPu+lepn?=
 =?us-ascii?Q?4/1RUq/LToXAj6RQvJuN6jeso3do7ecaBM6uMBO5Vi+Dv+SAPDkaiywHXMi8?=
 =?us-ascii?Q?IAzTuKAUWSXY5kKKxJfgxYev2cXJhniXfFhqSxrExRbSkx6xh56T17ZDVEmu?=
 =?us-ascii?Q?p8nlJ7EiKCjyDNbALerfGEq6YHvkhVB9q/kJMwqt4R5kje0tFx/5lUPoycAw?=
 =?us-ascii?Q?d9Lt42SwstdztlGBMH8TsQCS91rNvbQyJ7osunWZkTuGM/LKgiMoE3TYNyKL?=
 =?us-ascii?Q?Gojg09tYX6s2GDcbXEUGYmh1uMKprMBCL6maPGIZVU0Sb8KLABio1/1UQpEu?=
 =?us-ascii?Q?QUBYLvMCcGv9uT7iKzE607jaNUMhGncq5ng5UGTOtH4KqDMA5TphagVZKa3C?=
 =?us-ascii?Q?Q2eL9GSoPGduedm5zVw3pBJvR7jqWHA/6YU3nG6K0w4Y+EUYTCa1HLZXvt29?=
 =?us-ascii?Q?9f8P5aDM/vDLB8HkAu8BOTJJVnkRxWOV9Memb8haZi0YoZqDBiINmF3Gu88D?=
 =?us-ascii?Q?6IfKvkpNhNWujIBipVimEHb993RfK7cobyey?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:18.7435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e74f6d7-9b6d-4276-e438-08ddc44f02fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
Received-SPF: permerror client-ip=2a01:111:f403:2414::62f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the target field in the IRQ descriptor. This allows to target an IRQ
to another IRQ controller than the GIC(s). Other supported targets are
the PMC PPU1 CPU interrupt controller and the EAM (Error management)
device. Those two devices are currently not implemented so IRQs
targeting those will be left unconnected. This is in preparation for
versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9d900fe3127..551671af425 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -50,18 +50,30 @@
 #include "hw/cpu/cluster.h"
 #include "hw/arm/bsa.h"
 
 /*
  * IRQ descriptor to catch the following cases:
+ *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
  *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
  */
 FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, TARGET, 16, 2)
 FIELD(VERSAL_IRQ, ORED, 18, 1)
 FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 
+typedef enum VersalIrqTarget {
+    IRQ_TARGET_GIC,
+    IRQ_TARGET_PPU1,
+    IRQ_TARGET_EAM,
+} VersalIrqTarget;
+
+#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
+#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
 #define OR_IRQ(irq, or_idx) \
     (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+#define PPU1_OR_IRQ(irq, or_idx) \
+    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
 
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
@@ -415,19 +427,27 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
  * Or gates are placed under the /soc/irq-or-gates QOM container.
  */
 static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
                                           qemu_irq target_irq)
 {
+    static const char *TARGET_STR[] = {
+        [IRQ_TARGET_GIC] = "gic",
+        [IRQ_TARGET_PPU1] = "ppu1",
+        [IRQ_TARGET_EAM] = "eam",
+    };
+
+    VersalIrqTarget target;
     Object *container = versal_get_child(s, "irq-or-gates");
     DeviceState *dev;
     g_autofree char *name;
     int idx, or_idx;
 
     idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
     or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
 
-    name = g_strdup_printf("irq[%d]", idx);
+    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
     dev = DEVICE(object_resolve_path_at(container, name));
 
     if (dev == NULL) {
         dev = qdev_new(TYPE_OR_IRQ);
         object_property_add_child(container, name, OBJECT(dev));
@@ -439,16 +459,33 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
     return qdev_get_gpio_in(dev, or_idx);
 }
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
+    VersalIrqTarget target;
     qemu_irq irq;
     bool ored;
 
+    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = versal_get_gic_irq(s, irq_idx);
+    switch (target) {
+    case IRQ_TARGET_EAM:
+        /* EAM not implemented */
+        return NULL;
+
+    case IRQ_TARGET_PPU1:
+        /* PPU1 CPU not implemented */
+        return NULL;
+
+    case IRQ_TARGET_GIC:
+        irq = versal_get_gic_irq(s, irq_idx);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
     }
 
-- 
2.50.0


