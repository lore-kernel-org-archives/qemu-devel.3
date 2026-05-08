Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39B0CD37AC
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5O-0006fy-Kx; Fri, 08 May 2026 14:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5G-0006er-GH; Fri, 08 May 2026 14:37:58 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5E-0002Yg-Qd; Fri, 08 May 2026 14:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/FiBKmMAjIn5yztW+zyDoF93kKLjiP6DAzoZFUtbz2f3Uy5L0SHtwId4ACWHfQeD9WGj4efIFRFCwQMiQw48DYdBiuWCrF5KX6RyrkIrSquX5LiyGHfuJbo6lPZDR9Xygm9rhGXOhRi7y77yIw6UkXsMuQ+lG1hfMKb+SaZOdWxlVmbJf8c/haapWf58S2o8oivgFhztjucWqGpOFsgz1FBtcjZOFrHQmGYJjxzP/ZEA66nFtpvV0Gnad8Vk98hjGmuEsXvo5pIZnJQVegtnhj5CMEDEyBtQRoi8hjXCT6rvA5m0MS5Fly+6Dni3Gf11Csu2ko27/56vtvOxuN4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjsk54Bj0Tn0vx32otBq+7newk94c9VNDoiW2FCunpU=;
 b=Vxz3iYhQ7yAdiwT/UTk0rrc9LwhDjrtJpnVLQFi4R/mjsKshvr0S7/tNDuNj9njfjcgAeoXIlyJywf1Ktnd1XN2AjTtaCnB2v4/MybKbGRfDkSbc9oyW8VKPxg0vISPFGnyaYpKep6AVgTKxMG65dpnYMgcXWuE4/0tVi4QlgXliIn7CAgdQxfx1NX7PZVHTFhQCuTmShNi55DKbNw2sQakzOs1JmCRKYwiP3c2QrrNFuqUrUwn41eMBbQE18wmUjEgQNZ7p8KHOxTkfsmETIri8kDt7UVxoGlxG5pGt7V4TS10pTyM5QFWueoh5TxloY1vm29AvR4+9/VHoBCz9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjsk54Bj0Tn0vx32otBq+7newk94c9VNDoiW2FCunpU=;
 b=CDlF19tL1Zn8alZT2tRQj8dqw33oCFNieJ/IGws1NrjTvET+hZxBkpjqzRGcucaqelUx7gpOVhIo2alwCuiKdtZi/F4QeKpNAuHGBLCrdWXjZie8AoAc8FVv8xKQ4g2y57WW7jRS+/95QZmYzEvQn8GM2zVMmQA2fIubz328xlGPhCQw/LEZSYiRl48gGTEDRSaG6KPACFIea1VkU4y2dqHGg4bGlAHsFpyvakdR8cERV4anSVZ672NiZXqeP6YAEYdI6CAqXil4mR2mBnWdba9lhwTFFyTP9uUsPYuv9C2TvTQn8oP/EkdwGUeKTVEwc12Ccil6uLYdsTtk7bnaCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:37:44 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:44 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 2/8] hw/pci: enumerate PCI bus and program bridge bus
 numbers
Date: Fri,  8 May 2026 13:37:11 -0500
Message-Id: <20260508183717.193630-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0948.namprd03.prod.outlook.com
 (2603:10b6:408:108::23) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efcef15-8cf5-437e-a4c2-08dead30e4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: +0Siqv6Q70OETSdoUC0w0Qme3tzBt5d7G/0vTEvfIarNsheGLO4Z2rUTnwL069RE/zOUjz3gT/yIBiOEZsp+BNz9Kx2c22VXc8YLc2C/BMxVQc8wmHR9iEAupvuucl1tNEnsXo7mXwBiflaFCchHsSMTwG1MVPv876rMgqJWsrU1nheeheNdZ0pnmh00dKEU6FEWf3X7zmlpM1i3lhRhZDoxPQYR76ObirafHDaGTs71o1PhDv3Zu9D5RfbRgxcMHPerJSY7wPOL5MxtUYyimmu3DIaBPCmDFZVKcce3FiiLEraJwTkqxcyZKqTf50qjG07zOKhlt7wIq50BDXag6f5GMzRFtr3h0PeNj5BVnhDTcOnpAnb6L8S9qKWPP7aIEp7ZjKw+G9vNXbMzxxpcjQS8WuYEwJ6czRerAimWAiiiq1BhSYXixNiIZeXnDofWvlNrZmYtb4eZAu7pxukNsDyUgL+Yr3jxcJ9gqy1mI6e7FtmCPk5IDXQf0fPiX38+v6RIWfDjOMiXvScHemFSlXIeZvaq+og5xKSc6RKYWAWmx+fCYEh3MQrmFtmjGsqv/yJPxfUKKiAODxIM9mgVSTpVu9FhJ2ocSpNbuAW19HQbF6yx4BE6NqT+Vm80w8UMw7BWdFKNcyWqGRCb78Kx/gECYzRwUAN2JF8Mw+1PSj5Yz7rlEEOYU6687BZDhbIv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SU17shNrWdGVFL/Mvc3KsvkDgvFkM8lEyfkaYpUltbgTiQhFfC4K3nVO4Sq?=
 =?us-ascii?Q?hXy4m5CG44niWE8oXJeRkB0V4Q8bUHpx2oE3wthl72JzRPKW6ZQW284qd29e?=
 =?us-ascii?Q?AfoJwOqmTf2siNPt2uzs0jDZhjYHCb+ogYti2x3wCBQXqqnTLn7vm8fpzPnA?=
 =?us-ascii?Q?3wGi5WVXa9Q7eFNvH0GuY15YTCB4ZMERZzuDGmlrGTZpx7Jsy4/oU2VNUQnX?=
 =?us-ascii?Q?govjnPyPCmoU+wlCif8wSQ7QBUWlVgAoyLjU35dsnwekRSPhIV/4P608CSfz?=
 =?us-ascii?Q?DDyuEdNF7Hpw98FC2wgjvs5QnANetJqoUmno39E1lBTsVFmkj5HMrLFywAPj?=
 =?us-ascii?Q?oo8tbfAeyDgz9lwrcFluXMWOgM6qMkMIWfs6VLlhgQxmsNEoRj733Hw6uFa6?=
 =?us-ascii?Q?Ecle+lppWG83x7hpyh2af1TNdz4ARxlFVWbBxsg6j4AemTBlg+8dPXi8AgRY?=
 =?us-ascii?Q?g3D/W4Ge1EQXmExM3pIE0LcwHRgCQ5QQugZhnQJnYtFd3FkvXXtKBOMmb1LK?=
 =?us-ascii?Q?iW+eLZnBAXWS4HcyR72xhKMEUkg6e9QEOhmc2RzkI5AlIbLY1ZMp5ob1wntu?=
 =?us-ascii?Q?eA5J53oDG3WwrESjbm7s2Kw2ifBUVcZRY3Vtq7vhN1Ef2Ro6edsq7otiWp6y?=
 =?us-ascii?Q?b+U/k1aJVCmbvZZ8rAazqpT+kdVtxJ+BfIvLAdEFJnQ7d2aE69o0DTsOzqSY?=
 =?us-ascii?Q?AALHhH2xVZHlAomx0oxuLLlzMF2C/Hab+tt956Lylae+CgY5bU4N8tyL+gYP?=
 =?us-ascii?Q?Lk+Kvw1ZoQU1PF2qNyROYPgttwqxtmVJN/+bNhSta+m5VO3Ryi64IMmJMiZr?=
 =?us-ascii?Q?VeoFCqeceWnxUVUNYOkb0HFF4lYxv+5O4cLFTxO65IhKwLfqNbPrpIuiz4o4?=
 =?us-ascii?Q?NSp+cnOPpfbT0QHnzd4bFq/mm1ekHMCGtyxhIFH1eP16OUfp3pn3PUUK/jtG?=
 =?us-ascii?Q?cpmq0CBCKbg/C4TuJJ6hvSKi227oIyRpkmWwEMpn/qEhxvgPCoP7V9Mp9AfZ?=
 =?us-ascii?Q?VVV4mvL77Z+C5A665CuAKGSKJBN66vx7XiKkvwh4J8RJN4gyzxDdH7Bd8JK+?=
 =?us-ascii?Q?vXtvlT9eNaGKS7aoJdyRSjU5+LPDtvRQ6bNyBSdnWpFz4rboIjP7UOPC/snU?=
 =?us-ascii?Q?qPNXcPUe30VHl/8A7Fc/qsVmzgpbKZjU4gfUitsbODoOZPKbHZMTzMWjDuAW?=
 =?us-ascii?Q?Y0DOK2v9nlEz2rl8G5wn4zHCYBnmpLQo9pPldxqIuXwARvpagVw723okiyVX?=
 =?us-ascii?Q?tpeVe7nk0e1U8+ReQjmNm/RWFBOU5bufS2oWXGOS1T57ER3EOnTzWgcbxN+N?=
 =?us-ascii?Q?VqCdXpFqTDgtYbsJbNNRpxEtpv3sgCC79LJMsz2oF1LMnKB/GHGyYg8hdbhE?=
 =?us-ascii?Q?529dUSyki8h5DVErmHHbpYoCr+K7DaElzFMfpAP4biZC0WLdmJrtGFXkv9sV?=
 =?us-ascii?Q?IBwI/W0wEx90ieDdXDCNLW4e0ACiwdEigUoPQ/s9QrxkdhHh91ex2YRd43OJ?=
 =?us-ascii?Q?fonsFjlSCw95mNJX2qaQawBy4gmT6wovD0aDT4iaD3BOB56/gDTTH0FNByCl?=
 =?us-ascii?Q?mKbUrXBO4b6A1hQ0MCkdZWT8c/seWpx9oE1CzQP/M3Bc8z9Hp5/cET6O7ZEx?=
 =?us-ascii?Q?Ak1eklPGirOx4LwMGcpowVkS88ARdHGFBoyWpxW2n8CuhzKFPuASaSqFIW4P?=
 =?us-ascii?Q?p9J1bHKCSRfWKVhwAkrl10IAp5BXRIpT1DRPROGg79Iaxs2jjUQRB0ZMTWCx?=
 =?us-ascii?Q?x/sz0S2iEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efcef15-8cf5-437e-a4c2-08dead30e4ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:44.3208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8Pcfdavw3TYi6JEUpVHmzJUUGglXVzk3NRQX6IoyynMd1OXSfUwUJLvVYQ3y0zfzaqsTexHtG+zFiTRhINbEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=tdave@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

When guest firmware is told not to perform bus enumeration, QEMU
must program bridge primary, secondary, and subordinate bus number
registers before handing control to firmware. Walk the hierarchy
under the root bus, assign secondary bus numbers in firmware-like
order (PXB roots first by bus number, then PCI bridges by devfn),
and program those bridge registers.

Note that SR-IOV bus number allocation (VF offset/stride/NumVFs) is not
handled in this commit and requires additional work.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build     |   1 +
 hw/pci/pci-enumerate.c | 144 +++++++++++++++++++++++++++++++++++++++++
 hw/pci/pci-enumerate.h |  15 +++++
 3 files changed, 160 insertions(+)
 create mode 100644 hw/pci/pci-enumerate.c
 create mode 100644 hw/pci/pci-enumerate.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index a6cbd89c0a..7e8f5bb87d 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -5,6 +5,7 @@ pci_ss.add(files(
   'pci.c',
   'pci_bridge.c',
   'pci_host.c',
+  'pci-enumerate.c',
   'pci-hmp-cmds.c',
   'pci-qmp-cmds.c',
   'pcie_sriov.c',
diff --git a/hw/pci/pci-enumerate.c b/hw/pci/pci-enumerate.c
new file mode 100644
index 0000000000..2c6d25b25d
--- /dev/null
+++ b/hw/pci/pci-enumerate.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright (C) 2026 NVIDIA
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci-enumerate.h"
+
+/* Forward declaration */
+static uint8_t pci_program_bus_numbers(PCIBus *bus, uint8_t current_bus_num,
+                                       uint8_t *next_bus_num);
+
+static int cmp_bus_by_devfn(gconstpointer a, gconstpointer b)
+{
+    PCIBus *bus_a = *(PCIBus * const *)a;
+    PCIBus *bus_b = *(PCIBus * const *)b;
+    return (int)bus_a->parent_dev->devfn - (int)bus_b->parent_dev->devfn;
+}
+
+static int cmp_bus_by_num(gconstpointer a, gconstpointer b)
+{
+    PCIBus *bus_a = *(PCIBus * const *)a;
+    PCIBus *bus_b = *(PCIBus * const *)b;
+    return pci_bus_num(bus_a) - pci_bus_num(bus_b);
+}
+
+/*
+ * Program one bridge's primary, secondary and subordinate bus numbers
+ * and recurse. Return the max subordinate bus number.
+ */
+static uint8_t pci_program_bridge(PCIDevice *bridge, PCIBus *child_bus,
+                                  uint8_t current_bus_num,
+                                  uint8_t *next_bus_num)
+{
+    uint8_t secondary, max_child;
+
+    /* Bus number space exhausted; no bus number to assign. */
+    if (*next_bus_num == 0) {
+        return current_bus_num;
+    }
+    secondary = *next_bus_num;
+    (*next_bus_num)++;
+
+    pci_default_write_config(bridge, PCI_PRIMARY_BUS, current_bus_num, 1);
+    pci_default_write_config(bridge, PCI_SECONDARY_BUS, secondary, 1);
+    /*
+     * Unlike real hardware, QEMU does not require opening a subordinate
+     * aperture before scanning downstream devices.  Write secondary as
+     * a placeholder; the final value is set after recursion below.
+     */
+    pci_default_write_config(bridge, PCI_SUBORDINATE_BUS, secondary, 1);
+
+    max_child = pci_program_bus_numbers(child_bus, secondary, next_bus_num);
+    pci_default_write_config(bridge, PCI_SUBORDINATE_BUS, max_child, 1);
+    return max_child;
+}
+
+/*
+ * Program bus numbers for this bus and all subordinates.
+ * - current_bus_num: this bus' number (0 for root, or already set for PXB).
+ * - next_bus_num: next free bus number to assign to a bridge.
+ *
+ * Children come from bus->child only. Two kinds:
+ * 1) PXB (extra root): child has PCI_BUS_IS_ROOT. Has bus number
+ *    already set, recurse only.
+ * 2) Normal bridge: parent is IS_PCI_BRIDGE. Assign secondary = *next_bus_num,
+ *    program primary, secondary and subordinate bus numbers, and recurse.
+ *
+ * Order matches EDK2 PciBusDxe enumeration: process PXB children first
+ * (sorted by bus number), then bridges (sorted by devfn).
+ */
+static uint8_t pci_program_bus_numbers(PCIBus *bus, uint8_t current_bus_num,
+                                       uint8_t *next_bus_num)
+{
+    PCIBus *child_bus;
+    GArray *pxb_buses = g_array_new(false, false, sizeof(PCIBus *));
+    GArray *bridges = g_array_new(false, false, sizeof(PCIBus *));
+    uint8_t max_subordinate = current_bus_num;
+    uint8_t child_num;
+    uint8_t one_max;
+    guint i;
+
+    /* Single pass over bus->child: split into PXB vs bridge */
+    QLIST_FOREACH(child_bus, &bus->child, sibling) {
+        if (!child_bus->parent_dev) {
+            continue;
+        }
+        if (pci_bus_is_root(child_bus)) {
+            /* PXB or similar: bus number already set (e.g. bus_nr=1, 9) */
+            g_array_append_val(pxb_buses, child_bus);
+        } else if (IS_PCI_BRIDGE(child_bus->parent_dev)) {
+            g_array_append_val(bridges, child_bus);
+        }
+    }
+
+    /* PXB first, sorted by bus number (e.g. 1 before 9) */
+    if (pxb_buses->len > 1) {
+        g_array_sort(pxb_buses, cmp_bus_by_num);
+    }
+    for (i = 0; i < pxb_buses->len; i++) {
+        child_bus = g_array_index(pxb_buses, PCIBus *, i);
+        child_num = (uint8_t)pci_bus_num(child_bus);
+        if (child_num + 1 > *next_bus_num) {
+            *next_bus_num = child_num + 1;
+        }
+        one_max = pci_program_bus_numbers(child_bus, child_num, next_bus_num);
+        if (one_max > max_subordinate) {
+            max_subordinate = one_max;
+        }
+    }
+    g_array_free(pxb_buses, true);
+
+    /* Bridges second, sorted by devfn */
+    if (bridges->len > 1) {
+        g_array_sort(bridges, cmp_bus_by_devfn);
+    }
+    for (i = 0; i < bridges->len; i++) {
+        child_bus = g_array_index(bridges, PCIBus *, i);
+        one_max = pci_program_bridge(child_bus->parent_dev, child_bus,
+                                     current_bus_num, next_bus_num);
+        if (one_max > max_subordinate) {
+            max_subordinate = one_max;
+        }
+    }
+    g_array_free(bridges, true);
+
+    return max_subordinate;
+}
+
+void pci_enumerate_bus(PCIBus *root_bus)
+{
+    uint8_t next_bus_num;
+
+    if (!root_bus) {
+        return;
+    }
+    next_bus_num = 1;
+    pci_program_bus_numbers(root_bus, 0, &next_bus_num);
+}
diff --git a/hw/pci/pci-enumerate.h b/hw/pci/pci-enumerate.h
new file mode 100644
index 0000000000..b1e4b989f1
--- /dev/null
+++ b/hw/pci/pci-enumerate.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2026 NVIDIA
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_PCI_PCI_ENUMERATE_H
+#define HW_PCI_PCI_ENUMERATE_H
+
+#include "hw/pci/pci_bus.h"
+
+void pci_enumerate_bus(PCIBus *root_bus);
+
+#endif
-- 
2.34.1


