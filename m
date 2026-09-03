Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9AEC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aO-0005fb-UM; Thu, 03 Sep 2026 07:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aM-0005cO-W9; Thu, 03 Sep 2026 07:26:27 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aK-0006gK-Oh; Thu, 03 Sep 2026 07:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM+B59/sr55dpQsXQGx+u0QQFAFD/V4e3yoEnQfiB+u2lRD7wMrQsz/ilwMT4D1hZhswB0wOCI+ic90Pgqbn6KMMbtGFVjWv7RYheHe02pl21FqoCGPDlrWsdFo3Y8aoNNUpos/gkLZF9iQQ/MRg4JRB6BMAIE1L2ZXG0esGzYsJbqDKvYqYEQC/WKqtap3WNNvz6A8OsMGmrnD0tR/I93hG3dJqru3cfM2ih+3V462awGQm6eKWWWdAdNGLG+IcpXnw6Np1C+sg9fpNoL3L/xzXXBaaBQ2Kz1sMAjH5OaQQXQif+gr4tfFXWFxYD8QcKMOcJZZHEfXCasjHbwJHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XOHjco1ZRstk8sH2uMDdaEG1Ll6xxFEyxMp814x/Eg=;
 b=BRofkr5ljIcyy4TwaXxM2OSfiaKc3Yx90WOMMG7U6dVAAOSfEMTz27eD6lNWqFuzEB6BCa2fG8ILRQiNitxvmqyyZKwmOsJS21eXj9/+Af0pwph5R8kp+3EYL/7teH8wzhrv96EFCdxyw1f3gHuags27oyP5BUI143xdwCEebkQ/hW93AxIjeot+v2bd95L5JVZzpmPEbR/VSCEd/eZAjBhjK6Mcy9+o6IG5eS5bYq7FoDzPnKmUc8kK3N/JlGw9Qv1uwsLGwBhKHEb9BDzikh+Q9lQiQ8uaYYcLSpQcNSH5BeX6ScJ5IQB307ADZauyEtwxbAxBoHnYTBbY0MQYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XOHjco1ZRstk8sH2uMDdaEG1Ll6xxFEyxMp814x/Eg=;
 b=RBBCgX/d7UUPtWU2wOS3E63zx6TLDNNEmzAXb1aaPv7EsdlXWGPkZrDeAzPaQUDwG6pXcW4T1Ho/MITSz2UDpe+ydLC1ySKsFE9TpzfTrEoSt9wsthaz1KWKdLEeyRJfC9dynPw7O3/Cx+UWYverLwGd/Cz4FYBslUlLCZTbdWQSWPm3XW53Ez7swj7L63IBPYkVlYMGvZWUniwf/0Yxe67yiWLC2mpDbVrstfTUoRWUxUXIU3n+Fl2/ZX3UdSCzQaJXk8yUdjMuj/vGR+gzmXBqbOOfC9Pb13pBoHIX6YeLlgHePeqEVzdtzxl8QgW/SieKm6SxDQYMovgI0DKEOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:13 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/33] hw/misc: Add Phytium E2000 MHU doorbell
Date: Thu,  3 Sep 2026 19:24:51 +0800
Message-ID: <20260903112532.3276678-12-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: d82e20d8-ce66-424f-5ff6-08df09ae2926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: HwPcVSTHFOy7PB+wi0NjAZpxIbGnzbiR3Hx7Fbul6CD90LJ2+wLQB6fOONMbwqNYbWLjfkOCBZFcmOZUTmQo/cvu4np6OHamfBCdA5RMwiqbIxQoXc42gXEtlhD4fyTvnnwlw24eG/fDumOMQzGJWCtwXt/9iyKvmtiF8NLSmU/69H004KQ42S73SF1j69p90n5vMUllAVkmMs8rDyiF+cUqJRxMjGriBAIJ2fER6QHh63BQHikwAAsZt+xDl6RM5YIIqCPJCZN+r6FjEb0zZsQXISu3TyKrLHlvsB+oR4Av/bccfqPd7VD07GWoS9OuQLNDt0g4vrHig3JxZvVyA132BDUClJEwnBrLUYcy1IihOGWUh9hzt/2EHIRVC/cLx0OdCdW6LjvhnDvFUjyKaGW3VOvRyw+TcvBgzK1oK++Y6hJnWSAXYXSTYrWIWoI3Mdtk5SQghh8+SgCjJHTzctUOVWnHCHT+IyGVcsOfSHlEDckJqx/k9Eu20xygPqtDW9AfTbok8Yd88i+HFgpWkB703WjZW09z1UAnJobxESBVzwB4ncDQBaQ5skvRohhy3W5AgD3w8cyUYA7TDEAZSyHOnbMUoD7gWus7Fqcuq/gaCcwgRPEhHKJtZnCXstdhdJryaj2qdNHemWciK1KE6Nl/RrJ5JTOlfYUJSHHZUhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZUEqIVhzUavbQeIJmhlOTBMU5yp7OMiwV+5hXGmIPfY4YRKo2qUCvdpXCxQJ?=
 =?us-ascii?Q?b3pAifbE57XERrPyrOsRA0jWd5Nf6kSCZxjl1izm8/gjKC9qsBQGm0w80Aq0?=
 =?us-ascii?Q?U0c4npuZQpMZgwU/wz/sgdfXMBYyDtv2dGiJg66KSGu8AIkp+IZXWyNzA9WO?=
 =?us-ascii?Q?vVKb+IuaDLi6ViD3X999jEDabA9jDrwo5OaFw9g75eGQXqRiKfkkxyRHDpCG?=
 =?us-ascii?Q?p+7Nn0okWGVRQbO/p+91d4OJQuHoyjYmIsbMJQcD7glP6Lj61zUAYpJCCMsR?=
 =?us-ascii?Q?hGOn8U3owJ2MN/qdiWFe70YwP1G5HcJdmgdx9ZIfKqe6aeDeqVbr7vqMojFu?=
 =?us-ascii?Q?9cAtzhXdXGLM1KtqNDu5HESbURiWDZIUUceSPNkpR0W4QEq32/rm7IWNeg17?=
 =?us-ascii?Q?LbaayLBLSYstylVclE9KePCBnLttH09nA+cywSJ08fmJZW+tWwYW6vguseBM?=
 =?us-ascii?Q?nxlCfmrV/2I8gafM872AOuPNBAZ+/U9hZJYXVjPf4sDE1z+VJZ+x3lTK3V6J?=
 =?us-ascii?Q?jAPMsSPeS1FbxBjmGC5FHVH+PoGy939L/G5wcF0cWU6HowFn5PoNFN0hma3q?=
 =?us-ascii?Q?CYc3PjKH/WXRHMOa+OyKoePQd6auBYn93QN0DjZX4KMnbkklPcX7QASyvV81?=
 =?us-ascii?Q?z5zm6YlfO7Z4zlEDeKwYShVmLdeEXWX4wISeOUlXv+sUeEmzWh1D6L5uNWYZ?=
 =?us-ascii?Q?R+oKrx1MzFFIjGgAXeb8kSVWy5Q8wcpOs7gBPshhFJkVWgksrg25mGxmyxfq?=
 =?us-ascii?Q?1Im53ciD0aQ9nlEFCrHah4EX3owEWU0g//COIX/nHZPv02WvWXz9y3wcB15F?=
 =?us-ascii?Q?jMHK/CCZXBIa1WhFV6KAYpuM9pBxhkNyhqHRfY80D6TdzPUNTukRjlZoHUMF?=
 =?us-ascii?Q?D0HseiW3QXAium+t7nNgmscjaJn/K3pT/+yFcUfOESsybNF3VaVpYNY7YMLE?=
 =?us-ascii?Q?G19jqzDuxcXYgFKS1+Htg5RFqhbXJ6tA6efJwu2b6qPCfG/9PuJ+h1ZIOMeW?=
 =?us-ascii?Q?g7R9e7CVVKUzwghj98K2K/wNpYYOiJNF0IZtvuMuQBfyA7ZiWCnuj/bCqRRw?=
 =?us-ascii?Q?T4fF5SSkBks2p44p8iPgnAsZ0uEoCoddjqOqUPVSb2PXk0iLZLZjbUHWI0QI?=
 =?us-ascii?Q?hjcc8T+/t1sd9m/5j+EzWbtCpcNgBCrD1C28rX+/WZzK9VybmikfrlIcGZL6?=
 =?us-ascii?Q?pmOCWY9M/B/iBDt4KRgtpqtfk/+LbntvdVB24KWFTLw8PCQgcHA8vDyWyO92?=
 =?us-ascii?Q?QF7VtV0koXaIln44FeHEOshVluxWLQD+wgQGQPRWYOMSB9O7I3FkQwA22yLN?=
 =?us-ascii?Q?mn4GepDPxeTZhHxCUy+WlnqcAxZhYBQ8MneCBrOkGUdZ71b8vpBX9GaSBvCB?=
 =?us-ascii?Q?8DU4x31M0+VfD0iBvKG9efAbAoQEYmX9fgrQYT+M0PRWcmaJCV3t+WE+e607?=
 =?us-ascii?Q?+QxIN0A0e/66l8SC+BTW46gg95K8OEcHIUaDEJp3BdXUm80llcxEi+B//pcP?=
 =?us-ascii?Q?Jxg99M08+sL5rjI3/ZjaRjy5FvjkXS5huzoRCXgE5mIMmo/zq2ohAItPxzM9?=
 =?us-ascii?Q?JinA/prvkIH0FSR8rc8mtW7kSBih7a8TcMeMatTzhMYffotPHaovFPkcK71z?=
 =?us-ascii?Q?Q9bTgzztAbiqblQJ1rn1SxjTgjXM0dg65KSQif3yDjoz9x1Q1kVyS84XWmsd?=
 =?us-ascii?Q?1pNRM63pEBuv0s0Jo2lHcC6icp1tr++beXnxA3ZFF+MzR/YSO4Z9KQ/6kq7i?=
 =?us-ascii?Q?OwBz90t99V8t+yY5jN++PEN6xgmFkfw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82e20d8-ce66-424f-5ff6-08df09ae2926
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:13.0700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LSiAXmA48Yu+9QDHP2nYupU0oegdMyf4ZVfr226qO1HLcSTS3W314NYg35hGWqQsJXQUcU9SSWKP39WmNdhywxGbvWsivydcLcNabWnUas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add a model for the E2000 AP OS MHU channel used by vendor firmware.
Model its status, set and clear registers and complete nonzero
notifications by updating the shared SCMI mailbox.

The device also provides the mailbox seeding helper required by
the later PBR handoff. Board address mapping and SCP SRAM ownership
are intentionally left to a following machine-integration commit.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/misc/meson.build                 |   1 +
 hw/misc/phytium_e2000_mhu.c         | 185 ++++++++++++++++++++++++++++
 include/hw/misc/phytium_e2000_mhu.h |  25 ++++
 3 files changed, 211 insertions(+)
 create mode 100644 hw/misc/phytium_e2000_mhu.c
 create mode 100644 include/hw/misc/phytium_e2000_mhu.h

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 898cf6ea87..a2ea120dd4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -17,6 +17,7 @@ system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_de
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_ddr.c'))
+system_ss.add(when: 'CONFIG_PHYTIUM_E2000', if_true: files('phytium_e2000_mhu.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
diff --git a/hw/misc/phytium_e2000_mhu.c b/hw/misc/phytium_e2000_mhu.c
new file mode 100644
index 0000000000..4ea23af900
--- /dev/null
+++ b/hw/misc/phytium_e2000_mhu.c
@@ -0,0 +1,185 @@
+/*
+ * Phytium E2000 MHU/SCMI doorbell
+ *
+ * This is a boot-oriented SCMI transport proxy. It acknowledges requests in
+ * shared SRAM so PBF can complete clock and platform setup; it is not a full
+ * SCMI protocol server.
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/phytium_e2000_mhu.h"
+
+#include "hw/core/register.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "system/address-spaces.h"
+
+#define PHYTIUM_E2000_PBF_SCMI_MBOX_BASE  0x32a10400
+#define PHYTIUM_E2000_SCMI_STATUS_OFFSET  0x04
+#define PHYTIUM_E2000_SCMI_LEN_OFFSET     0x14
+#define PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET 0x1c
+#define PHYTIUM_E2000_SCMI_STATUS_FREE    BIT(0)
+
+/*
+ * The SDK defines AP OS status/set/clear at 0x100/0x108/0x110 within a
+ * channel. PBF selects the channel at MHU offset 0x200, producing the global
+ * offsets below. Writes to AP_OS_SET are the request notification.
+ */
+REG32(AP_OS_STAT, 0x300)
+REG32(AP_OS_SET, 0x308)
+REG32(AP_OS_CLR, 0x310)
+
+#define PHYTIUM_E2000_MHU_R_MAX \
+    (PHYTIUM_E2000_MHU_MMIO_SIZE / sizeof(uint32_t))
+
+struct PhytiumE2000MHUState {
+    SysBusDevice parent_obj;
+
+    uint32_t regs[PHYTIUM_E2000_MHU_R_MAX];
+    RegisterInfo regs_info[PHYTIUM_E2000_MHU_R_MAX];
+};
+
+static void phytium_e2000_mhu_complete_scmi(void)
+{
+    uint8_t buf[sizeof(uint32_t)];
+    uint32_t len;
+
+    /*
+     * Preserve the caller's message length, but reserve one status word for
+     * the minimal success response returned in the payload.
+     */
+    address_space_read(&address_space_memory,
+                       PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                       PHYTIUM_E2000_SCMI_LEN_OFFSET,
+                       MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    len = MAX(ldl_le_p(buf), (uint32_t)sizeof(uint32_t));
+
+    stl_le_p(buf, 0);
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                        PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
+                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    stl_le_p(buf, len);
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                        PHYTIUM_E2000_SCMI_LEN_OFFSET,
+                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    stl_le_p(buf, PHYTIUM_E2000_SCMI_STATUS_FREE);
+    /*
+     * Publish the free bit last. PBF polls this field as the ownership handoff
+     * and may consume the response immediately after observing it.
+     */
+    address_space_write(&address_space_memory,
+                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE +
+                        PHYTIUM_E2000_SCMI_STATUS_OFFSET,
+                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+}
+
+void phytium_e2000_mhu_seed_mailbox(void)
+{
+    /*
+     * PBR leaves the shared channel available before releasing PBF. Seed the
+     * same ownership and success state even before the first doorbell write.
+     */
+    phytium_e2000_mhu_complete_scmi();
+}
+
+static void phytium_e2000_mhu_doorbell_post_write(RegisterInfo *reg,
+                                                  uint64_t value)
+{
+    /*
+     * Complete requests synchronously because no separate SCP CPU executes in
+     * this model. Zero writes only update doorbell storage.
+     */
+    if (value) {
+        phytium_e2000_mhu_complete_scmi();
+    }
+}
+
+static const RegisterAccessInfo phytium_e2000_mhu_regs_info[] = {
+    /*
+     * The functional transport does not model an SCP interrupt line. STAT is
+     * therefore idle, SET completes the shared-memory transaction, and CLR
+     * remains ordinary register storage for the firmware acknowledge path.
+     */
+    { .name = "AP_OS_STAT", .addr = A_AP_OS_STAT,
+      .ro = UINT32_MAX },
+    { .name = "AP_OS_SET", .addr = A_AP_OS_SET,
+      .post_write = phytium_e2000_mhu_doorbell_post_write },
+    { .name = "AP_OS_CLR", .addr = A_AP_OS_CLR },
+};
+
+static const MemoryRegionOps phytium_e2000_mhu_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void phytium_e2000_mhu_reset(DeviceState *dev)
+{
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(dev);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(phytium_e2000_mhu_regs_info); i++) {
+        register_reset(&s->regs_info[
+            phytium_e2000_mhu_regs_info[i].addr / sizeof(uint32_t)]);
+    }
+}
+
+static void phytium_e2000_mhu_init(Object *obj)
+{
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(obj);
+    RegisterInfoArray *reg_array;
+
+    reg_array = register_init_block32(
+        DEVICE(obj), phytium_e2000_mhu_regs_info,
+        ARRAY_SIZE(phytium_e2000_mhu_regs_info), s->regs_info, s->regs,
+        &phytium_e2000_mhu_ops, false, PHYTIUM_E2000_MHU_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+}
+
+static const VMStateDescription phytium_e2000_mhu_vmsd = {
+    .name = TYPE_PHYTIUM_E2000_MHU,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, PhytiumE2000MHUState,
+                             PHYTIUM_E2000_MHU_R_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void phytium_e2000_mhu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &phytium_e2000_mhu_vmsd;
+    device_class_set_legacy_reset(dc, phytium_e2000_mhu_reset);
+}
+
+static const TypeInfo phytium_e2000_mhu_info = {
+    .name = TYPE_PHYTIUM_E2000_MHU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PhytiumE2000MHUState),
+    .instance_init = phytium_e2000_mhu_init,
+    .class_init = phytium_e2000_mhu_class_init,
+};
+
+static void phytium_e2000_mhu_register_types(void)
+{
+    type_register_static(&phytium_e2000_mhu_info);
+}
+
+type_init(phytium_e2000_mhu_register_types)
diff --git a/include/hw/misc/phytium_e2000_mhu.h b/include/hw/misc/phytium_e2000_mhu.h
new file mode 100644
index 0000000000..0527d6fe8d
--- /dev/null
+++ b/include/hw/misc/phytium_e2000_mhu.h
@@ -0,0 +1,25 @@
+/*
+ * Phytium E2000 MHU/SCMI doorbell
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_PHYTIUM_E2000_MHU_H
+#define HW_MISC_PHYTIUM_E2000_MHU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_PHYTIUM_E2000_MHU "phytium-e2000-mhu"
+OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000MHUState, PHYTIUM_E2000_MHU)
+
+#define PHYTIUM_E2000_MHU_MMIO_SIZE 0x1000
+
+void phytium_e2000_mhu_seed_mailbox(void);
+
+#endif
-- 
2.53.0


