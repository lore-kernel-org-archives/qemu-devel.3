Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C46CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5Y-0006hq-BA; Fri, 08 May 2026 14:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5O-0006gQ-Iq; Fri, 08 May 2026 14:38:06 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5M-0002b2-3S; Fri, 08 May 2026 14:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8FtgfQspDt8XpIK1nXypmybTNcMbCPBIefl2mNoR4KCb1wyg2cGD1xnLvkqL2EuipfQhjLLMSJ3hMsdtWjAG5YExkha02xtXLdNfjHv+jFUtmgN/E5lp9j8m4omzjeMR0cbaNS3IXCePZDnF4PQxwXz/QVygxcs4eFLihjvsvmv3HRCw+DGIfJk8qy5Lu324TbX2IzdZEfK6CvPoq2i1oaVpiHwk8L9JnPWzLIyT4njErh15VIN1IF8fHnnp0c17CIJBUMyLh7SUnXIyhc+R3X4fFf7KSau2mHnXDjGCVP5GHt4NxjD7dLsrrJZRO0hSbgW6Ih8hKQOXxOCPrrA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxDvV4LZ4ek8q78zLfgg06hLW8aN2srFmLdvM6m92Gc=;
 b=lN0MUQiOULMoNqBKgOjYgnKgndS5fmHnKczx3pc+tUYfxmQv8ooVdnlkOE5Y1fO4qvxO+inhllDxraIFK2X5N4W9qFJ5cxQ+hIyOVKMy6jZNrG/dmNfUp3KFZyXCIcudXEzsSXdFtb23EoYi/dxvx/4jB25rJmvQI3ihTFA68qADgQTyciPxshQKUnaV3x12x9s1Gx9Ipcdfk6uU41cpfUSUxiW+JFxDcAyJBQkzbhf1OHjnmORIOdmPSbd1WGfQHAwSUyRYYl6h62VXc+gGNyykJzcEz2+vjH5yYmD3H6L/Coc1B9V3KXlxd6VILosROOJ4IVRqnGjp5ntFET2Qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxDvV4LZ4ek8q78zLfgg06hLW8aN2srFmLdvM6m92Gc=;
 b=VCuso00Tww8StwdHPE59Lp4G59sNgi27cxczFr4sd8zidx2DcPSdyklEfTDv2Qqa0p+1DB5H4gQ7jzgovaOTPNWXc6ST1LPLWnJLdFbSS/y+tvWm3Unvl6n9Vv8DUZ/jQ/62vP55YtJrMGF2Z3+e8Ydwe7Z6SVwVI2nOb+GbBRZxbAn+PudsrgXOnTY2uvup9hzL5Zq4aG7nm8hWawrbJMWa+mFFp6aes2V3m47IU2ZjIglOzoBPo4Otl4FY4gaBEr+W7/6x07StJGrfTQ9XP3z/iSDWMi7ZMq7tM0zRIUKpCnk7QacVTfnPUav5it669DUFOeUQFG5WQF1Hl0Xnzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 18:37:51 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:51 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 5/8] hw/pci: allocate remaining BARs for buses without
 fixed BARs
Date: Fri,  8 May 2026 13:37:14 -0500
Message-Id: <20260508183717.193630-6-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::25) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: b889e638-85a6-49e0-485a-08dead30e8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: bAWKxHOpxI6m06hDAtwA7J3P1wk+6yDcVzKG9/BvJzJDja5YmZ3QpQ7noNdZO+GRKgeN2B9DaPCIz9362iBjWNy9Cdg/Non/keRg/uVBrggZCZPVyvDbcCNEuFsY4+AuPv+E+TmnEn/OR3g9eLQV70bdV81bqK6PbggYZCwhmns4zWTIy7hn5YpA2Yb2au4hPeZW9abv1CDh4ULW1dATdKbnEqgWJuBeskklTamPG4kFuzw8kGomhD+2IXW6OK9oo1rNK2/03trFWLPKtxZxOCALR9sJJdvtcrBvi06cfIuZbMSmBSkjcUj7qVrCRF9x9AT7XXw0sQlPSMshRkEbloxybZzMacRTMewyLIe925L7fk6ChfjakZkwecIOf4bbvxd/YperIgraoxrjYqeRGiFSQEN1u0LAlbVS6xyhFSBKU69bpjP8ttfE4yTJrnGvcvXgzWk3OfvWL0T8RbvQmOjqMF67YTGXP2RKpk4ot7p2IvVxxO5zWKVs00Z9XBH1XflzBFv5k3oJLnb9dPOhwV2cQnQgUMQn7hMZcWIi9tj1xhFVzoJjufGns+oQ6xCsvbM5e00DmYgb2JmwctyjS+rd3lJQYn6dyb/N6dAQlUMEtBVJTD79D2Mz4TwZkcDkJNyBu9CMmjEOTEk0x/t8ipKd/v7swfoyX6VDasvLzFIcIzHds866MpQbK4V4ED+f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rKNPOJvSY/g2FGYvckGMRzXy3nAT03LUHbK7zqTelcDw9Tay5di8HsJPojun?=
 =?us-ascii?Q?b59yrdj+HIcN9pb6qsbIoXRV2pbM20NP6yyS0CXumbGNsR7cCvriqAtUIbcR?=
 =?us-ascii?Q?/GJIvSpLvhTgxVfBuWStQoxB6pce04ppeqxWfzrtRB27TjKFMaM3nOHtvwna?=
 =?us-ascii?Q?5IQPzSbGoeaCZq4Y6Pbim9wITi2Ujn+vebbFEVW3VpCsfIaRmAzwyLUZr4Rk?=
 =?us-ascii?Q?CoJ5wGM3RNxZ2he1Fp0lgegNnpyfyMqS4+u+iSzWuZLBC3W/IGxzWoQv/djK?=
 =?us-ascii?Q?bfWcm30fomjqxC3n7bo3AtyxbDsLhrv6LrrOJdR9STcTmV1k5wajh6mfKmqm?=
 =?us-ascii?Q?eP2MNEAw7y5qYIhOdwvS/OlpkGRbtpQXZNXerQvZus3lN7kZkvAwBxz+Q7Jy?=
 =?us-ascii?Q?yZeCohg+o/vtSP/HSPzdY7bwpEDrKlhDFdQlvVSnR+/5uR+n8oOc24bXAWxS?=
 =?us-ascii?Q?Zn5i+Ke/yEZ7quZOszP8jYUh/fQj+JtFTRcEc5P9Q/9EWraHlIKJZoYvb0p1?=
 =?us-ascii?Q?ulB88rTt25uWYC9FnYVHWnQ/+FM6lqO3OhwYvby0yC+HDn3i3BumbCizAedm?=
 =?us-ascii?Q?Ap0XXKm+GeAG6RFs//U/yb/W3EdYx7LduJ0TrbauchmkknHcz+c6Q9oi+cUY?=
 =?us-ascii?Q?63lAqye3kmvlmYyztciXvkQVvT39VPRI87QVjXzyVijAhBzYjqQtnnh+DEjZ?=
 =?us-ascii?Q?SNGQEMX3XCynasg7w8pIAYV3kBSongzH6iaFyXFUQScYYZAhAYem+hwcJJ2o?=
 =?us-ascii?Q?jQrTNzFaSftPi20grPP8SbW/w14B+nJdHKInZGpsvP6OBqLnHWtO17BRfFsv?=
 =?us-ascii?Q?RCR9lV2e9s7jRwI9LFdglCNKs69TPje5bIJHrDEm7oS7jvQkQL6F7irbRUc1?=
 =?us-ascii?Q?WZHpPwDVrVRwB4xDI340k74gBxYCkt17inPjorNCr6KFEE/HtuXitVlYX6+C?=
 =?us-ascii?Q?JWBlPn03a640DufvUBjuA5thesWDyciOq/Z6lmeSo4uo08nk/mGvZ1Sa4qwW?=
 =?us-ascii?Q?1q7EM00m17fv/n13O2EK6MBCxQ2YrU9QSG0NunT+Zuh/biqJ3sWzR2JFNPrO?=
 =?us-ascii?Q?w4LEF9F9DvSyXRqyr6zsILN9t9a3j90Oht950J3CtgykKhDoRYuavH74XM5h?=
 =?us-ascii?Q?XkdYiM/nroH6GVzVZBYUnO5LABH3DuGDdRtrIud2gLbxEaDOz6nn0P/zBsWK?=
 =?us-ascii?Q?TiHb4HQ7rFIBiv4iUY7sNKObSruSDozWRau8g/dnDghDX5xtr6bvLM2S8nri?=
 =?us-ascii?Q?MOEajsFRBg6YAGZUZkgH1BhivV4Esp/UKN2SWOhu6VVQ3amCYGoJ7ACcgBue?=
 =?us-ascii?Q?7fD8oVsCn8SBnkdcLiib5jF4NGc5+YdyW3H4n3ssIj5gdxs7Z/xzTfB4rd5t?=
 =?us-ascii?Q?IE5mUsaqavsQVSpfsVBSzO1bbWidXwOLyhg+u6jJb7lXWfkSICLf609fn/mk?=
 =?us-ascii?Q?BidXnWNWpCESqV34CQd4NxDvHEq+s9ivpwhFP/kqbKvU9/E1xl+Cbq/zHkwM?=
 =?us-ascii?Q?EnQPiBU3INVb0Wl+pCdXFyHSXXpS3ce2ZemaOqRoCMj1Fc4jo1K5PTOH4rep?=
 =?us-ascii?Q?s6j/tHU/trphJWYKLwle6AuuZvN4c+WR7+ufMwGb+VFGehrII9dTC8AOjdyW?=
 =?us-ascii?Q?LvjCwYAAgHfNJYVcdFADQ+pO09jLeDTTn46+3N2gUkSeZxEyf8rtLM2UHtDU?=
 =?us-ascii?Q?0dlWR/8RK4zapTmtUgQV1E3PELxi4pTzATziRvfjjihiBTopHPCuiPlJjvk5?=
 =?us-ascii?Q?zDTzhN9Fmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b889e638-85a6-49e0-485a-08dead30e8f2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:51.2581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i63nodeRj54rYsPGA9Vvv1O1MysuFV7F28/j7mlsGAwa3QRHLiJzcgWurNMlzB1iyEh/IlmOSY1Tfb594Wh55Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=tdave@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

This phase performs PCI BAR allocation for buses without fixed BAR
assignments. It respects existing allocations and does not disturb
already programmed BARs or bridge windows.

It computes remaining MMIO64 requirements, assigns BARs, and extends
bridge prefetch windows if required.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/pci-resource.c | 355 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 354 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci-resource.c b/hw/pci/pci-resource.c
index de98924aa6..e2d2adc7de 100644
--- a/hw/pci/pci-resource.c
+++ b/hw/pci/pci-resource.c
@@ -371,6 +371,358 @@ static void finalize_bridge_window(PCIBus *bus, uint64_t min_addr, uint64_t max_
     }
 }
 
+/* Returns true if this 64-bit pref BAR is already assigned */
+static bool bar_is_assigned(PCIDevice *dev, int bar_idx, GHashTable *had_fixed)
+{
+    PCIIORegion *r = &dev->io_regions[bar_idx];
+    uint32_t lo;
+    uint32_t hi;
+
+    if (!is_64bit_pref_bar(r)) {
+        return false;
+    }
+    if (dev->fixed_bar_addrs &&
+        dev->fixed_bar_addrs[bar_idx] != PCI_BAR_UNMAPPED) {
+        return true;
+    }
+    if (bar_idx >= PCI_ROM_SLOT - 1) {
+        return false; /* 64-bit BAR uses two slots */
+    }
+    lo = pci_get_long(dev->config + PCI_BASE_ADDRESS_0 + bar_idx * 4);
+    if (!(lo & PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+        return (lo & PCI_BASE_ADDRESS_MEM_MASK) != 0;
+    }
+    hi = pci_get_long(dev->config + PCI_BASE_ADDRESS_0 + bar_idx * 4 + 4);
+    return (((uint64_t)hi << 32) | (lo & PCI_BASE_ADDRESS_MEM_MASK)) != 0;
+}
+
+/* Return BAR address from config, or 0 if unassigned. */
+static uint64_t get_bar_addr_from_config(PCIDevice *dev, int bar_idx)
+{
+    PCIIORegion *r = &dev->io_regions[bar_idx];
+    uint32_t lo;
+    uint32_t hi;
+
+    if (!r->size || bar_idx >= PCI_ROM_SLOT - 1) {
+        return 0;
+    }
+    lo = pci_get_long(dev->config + PCI_BASE_ADDRESS_0 + bar_idx * 4);
+    if (lo & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+        hi = pci_get_long(dev->config + PCI_BASE_ADDRESS_0 + bar_idx * 4 + 4);
+        return ((uint64_t)hi << 32) | (lo & PCI_BASE_ADDRESS_MEM_MASK);
+    }
+    return lo & PCI_BASE_ADDRESS_MEM_MASK;
+}
+
+/* Total size of unassigned 64-bit pref BARs in this bus and its subtree. */
+static uint64_t size_entire_subtree(PCIBus *bus, GHashTable *had_fixed)
+{
+    uint64_t total = 0;
+
+    for (int devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *d = bus->devices[devfn];
+        if (!d) {
+            continue;
+        }
+        for (int i = 0; i < PCI_ROM_SLOT; i++) {
+            PCIIORegion *r = &d->io_regions[i];
+            if (!is_64bit_pref_bar(r)) {
+                continue;
+            }
+            if (bar_is_assigned(d, i, had_fixed)) {
+                continue;
+            }
+            total += r->size;
+        }
+        if (IS_PCI_BRIDGE(d)) {
+            total += size_entire_subtree(pci_bridge_get_sec_bus(PCI_BRIDGE(d)), had_fixed);
+        }
+    }
+    return total;
+}
+
+/* Highest end address of any assigned BAR or bridge window in this bus and subtree. */
+static uint64_t find_highest_assigned_in_bus(PCIBus *bus)
+{
+    uint64_t highest = 0;
+    uint64_t base;
+    uint64_t limit;
+    uint64_t addr;
+
+    for (int devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *d = bus->devices[devfn];
+        if (!d) {
+            continue;
+        }
+        if (IS_PCI_BRIDGE(d)) {
+            PCIBus *sec = pci_bridge_get_sec_bus(PCI_BRIDGE(d));
+            PCIDevice *bridge_dev = pci_bridge_get_device(sec);
+            if (bridge_dev) {
+                base = pci_bridge_get_base(bridge_dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+                limit = pci_bridge_get_limit(bridge_dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+                if (limit > base) {
+                    highest = MAX(highest, limit);
+                }
+                highest = MAX(highest, find_highest_assigned_in_bus(sec));
+            }
+            continue;
+        }
+        for (int i = 0; i < PCI_ROM_SLOT; i++) {
+            PCIIORegion *r = &d->io_regions[i];
+            if (!is_64bit_pref_bar(r)) {
+                continue;
+            }
+            addr = 0;
+            if (d->fixed_bar_addrs &&
+                d->fixed_bar_addrs[i] != PCI_BAR_UNMAPPED) {
+                addr = d->fixed_bar_addrs[i];
+            } else {
+                addr = get_bar_addr_from_config(d, i);
+            }
+            if (addr != 0 && r->size) {
+                highest = MAX(highest, addr + r->size - 1);
+            }
+        }
+    }
+    return highest;
+}
+
+/* Next free address in root MMIO64. */
+static uint64_t next_free_from_root(hwaddr mmio64_base, hwaddr mmio64_size)
+{
+    uint64_t mmio_start = mmio64_base;
+    uint64_t mmio_end = mmio64_base + mmio64_size - 1;
+    uint64_t highest;
+
+    highest = mmio_start - 1;
+    if (fixed_claim_regions) {
+        for (guint i = 0; i < fixed_claim_regions->len; i++) {
+            FixedClaim *c = &g_array_index(fixed_claim_regions, FixedClaim, i);
+            if (c->end >= mmio_start && c->start <= mmio_end) {
+                highest = MAX(highest, c->end);
+            }
+        }
+    }
+    return ROUND_UP(highest + 1, 0x1000); /* 4K align for new window */
+}
+
+static bool
+pci_bus_phase3_ensure_parent_prefetch_window(PCIBus *bus, PciProgramCtx *pctx,
+                                             PCIDevice *parent_bridge, uint64_t mmio_end)
+{
+    PCIBus *parent_bus;
+    PCIDevice *grandparent;
+    uint64_t parent_win_base, parent_win_limit, next_in_subtree;
+    uint64_t required, window_base, window_limit;
+    bool window_not_programmed;
+    bool parent_in_mmio64;
+
+    window_base = pci_bridge_get_base(parent_bridge, PCI_BASE_ADDRESS_MEM_PREFETCH);
+    window_limit = pci_bridge_get_limit(parent_bridge, PCI_BASE_ADDRESS_MEM_PREFETCH);
+    window_not_programmed = (window_base >= window_limit) ||
+                            (window_base < pctx->mmio64_base) || (window_limit > mmio_end);
+    if (!window_not_programmed) {
+        return true;
+    }
+
+    required = size_entire_subtree(bus, pctx->had_fixed);
+    if (required == 0) {
+        return false;
+    }
+    required = ROUND_UP(required, 0x1000);
+
+    parent_bus = pci_get_bus(parent_bridge);
+    grandparent = parent_bus ? pci_bridge_get_device(parent_bus) : NULL;
+    if (!grandparent) {
+        window_base = next_free_from_root(pctx->mmio64_base, pctx->mmio64_size);
+        window_limit = window_base + required - 1;
+        if (window_limit > mmio_end) {
+            error_report("bus [%02x] out of root MMIO64 space", pci_bus_num(bus));
+            exit(1);
+        }
+    } else {
+        parent_win_base = pci_bridge_get_base(grandparent, PCI_BASE_ADDRESS_MEM_PREFETCH);
+        parent_win_limit = pci_bridge_get_limit(grandparent, PCI_BASE_ADDRESS_MEM_PREFETCH);
+        parent_in_mmio64 = (parent_win_limit > parent_win_base) &&
+                           (parent_win_base >= pctx->mmio64_base) && (parent_win_limit <= mmio_end);
+        if (!parent_in_mmio64) {
+            window_base = next_free_from_root(pctx->mmio64_base, pctx->mmio64_size);
+            window_limit = window_base + required - 1;
+            if (window_limit > mmio_end) {
+                error_report("bus [%02x] out of root MMIO64 space", pci_bus_num(bus));
+                exit(1);
+            }
+        } else {
+            next_in_subtree = ROUND_UP(
+                find_highest_assigned_in_bus(parent_bus) + 1, 0x1000);
+            window_base = MAX(parent_win_base, next_in_subtree);
+            window_limit = window_base + required - 1;
+            if (window_limit > parent_win_limit) {
+                error_report("bus [%02x] no room in parent bridge window", pci_bus_num(bus));
+                exit(1);
+            }
+        }
+    }
+    finalize_bridge_window(bus, window_base, window_limit);
+    return true;
+}
+
+static GArray *pci_bus_phase3_collect_unassigned_bars(PCIBus *bus, PciProgramCtx *pctx,
+                                                      uint64_t *out_total_size)
+{
+    PCIDevice *d;
+    PCIIORegion *r;
+    GArray *bars;
+    uint64_t required;
+    int devfn, i;
+
+    required = 0;
+    bars = g_array_new(false, false, sizeof(BarEntry));
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        d = bus->devices[devfn];
+        if (!d) {
+            continue;
+        }
+        for (i = 0; i < PCI_ROM_SLOT; i++) {
+            r = &d->io_regions[i];
+            if (!is_64bit_pref_bar(r) || bar_is_assigned(d, i, pctx->had_fixed)) {
+                continue;
+            }
+            required += r->size;
+            g_array_append_val(
+                bars, ((BarEntry){ .dev = d, .bar_idx = i, .size = r->size }));
+        }
+    }
+    *out_total_size = required;
+    return bars;
+}
+
+static void
+pci_bus_phase3_extend_window_for_bars(PCIBus *bus, PciProgramCtx *pctx,
+                                      PCIDevice *parent_bridge, uint64_t mmio_end,
+                                      uint64_t current, uint64_t required,
+                                      uint64_t window_base, uint64_t *window_limit,
+                                      GArray *bars_this_bus)
+{
+    uint64_t parent_limit, gp_base, gp_limit, new_limit;
+    PCIBus *parent_bus;
+    PCIDevice *grandparent;
+
+    if (current + required <= *window_limit) {
+        return;
+    }
+
+    parent_bus = pci_get_bus(parent_bridge);
+    grandparent = parent_bus ? pci_bridge_get_device(parent_bus) : NULL;
+    parent_limit = mmio_end;
+    if (grandparent) {
+        gp_base = pci_bridge_get_base(grandparent, PCI_BASE_ADDRESS_MEM_PREFETCH);
+        gp_limit = pci_bridge_get_limit(grandparent, PCI_BASE_ADDRESS_MEM_PREFETCH);
+        if (gp_limit > gp_base && gp_base >= pctx->mmio64_base) {
+            parent_limit = gp_limit;
+        }
+    }
+    new_limit = current + required - 1;
+    if (new_limit > parent_limit) {
+        error_report("bus [%02x] out of MMIO space (required 0x%" PRIx64 ")", pci_bus_num(bus),
+                    required);
+        g_array_free(bars_this_bus, true);
+        exit(1);
+    }
+    if (new_limit > *window_limit) {
+        pci_update_prefetch_window(bus, window_base, new_limit);
+        fixed_claim_regions_add(*window_limit + 1, new_limit, parent_bridge, -1);
+        *window_limit = new_limit;
+    }
+}
+
+static void
+pci_bus_phase3_program_bars_and_update_bridge(PCIBus *bus, PCIDevice *parent_bridge,
+                                              uint64_t window_base, uint64_t window_limit,
+                                              uint64_t start_addr, GArray *bars)
+{
+    guint b;
+    BarEntry *be;
+    PCIIORegion *r;
+    uint64_t addr, bar_end, high;
+    PhysBAR pbars_array[PCI_ROM_SLOT];
+
+    g_array_sort(bars, compare_bar_size_desc);
+    addr = start_addr;
+    for (b = 0; b < bars->len; b++) {
+        be = &g_array_index(bars, BarEntry, b);
+        r = &be->dev->io_regions[be->bar_idx];
+        addr = ROUND_UP(addr, r->size);
+        bar_end = addr + r->size - 1;
+        memset(pbars_array, 0, sizeof(pbars_array));
+        pbars_array[be->bar_idx].addr = addr;
+        pbars_array[be->bar_idx].end = bar_end;
+        pbars_array[be->bar_idx].flags = IORESOURCE_PREFETCH;
+        pci_program_prefetch_bars(be->dev, pbars_array);
+        addr = bar_end + 1;
+    }
+    high = find_highest_assigned_in_bus(bus);
+    if (high > window_limit) {
+        pci_update_prefetch_window(bus, window_base, high);
+        fixed_claim_regions_add(window_limit + 1, high, parent_bridge, -1);
+    }
+    g_array_free(bars, true);
+}
+
+/* Allocate and program 64-bit pref BARs for a bus with no fixed-BAR devices. */
+static void pci_bus_phase3_allocate_bars(PCIBus *bus, PciProgramCtx *pctx)
+{
+    uint64_t mmio_end, window_base, window_limit, current, required;
+    PCIDevice *parent_bridge;
+    GArray *bars;
+
+    parent_bridge = pci_bridge_get_device(bus);
+    if (!parent_bridge) {
+        return; /* Root bus has no bridge; skip */
+    }
+
+    mmio_end = pctx->mmio64_base + pctx->mmio64_size - 1;
+    if (!pci_bus_phase3_ensure_parent_prefetch_window(bus, pctx, parent_bridge, mmio_end)) {
+        return;
+    }
+    window_base = pci_bridge_get_base(parent_bridge, PCI_BASE_ADDRESS_MEM_PREFETCH);
+    window_limit = pci_bridge_get_limit(parent_bridge, PCI_BASE_ADDRESS_MEM_PREFETCH);
+    current = ROUND_UP(find_highest_assigned_in_bus(bus) + 1, 0x1000);
+    if (current < window_base) {
+        current = window_base;
+    }
+
+    bars = pci_bus_phase3_collect_unassigned_bars(bus, pctx, &required);
+    if (bars->len == 0) {
+        g_array_free(bars, true);
+        return;
+    }
+    pci_bus_phase3_extend_window_for_bars(bus, pctx, parent_bridge, mmio_end, current,
+                                              required, window_base, &window_limit, bars);
+    pci_bus_phase3_program_bars_and_update_bridge(
+        bus, parent_bridge, window_base, window_limit, current, bars);
+}
+
+/* Run once per bus; act only when the bus has no fixed-BAR devices. */
+static void pci_bus_phase3_allocate_no_fixed_bars(PCIBus *bus, void *opaque)
+{
+    PciProgramCtx *pctx = (PciProgramCtx *)opaque;
+    bool bus_has_fixed = false;
+
+    for (int devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *d = bus->devices[devfn];
+        if (d && g_hash_table_contains(pctx->had_fixed, d)) {
+            bus_has_fixed = true;
+            break;
+        }
+    }
+
+    if (bus_has_fixed) {
+        return;
+    }
+    pci_bus_phase3_allocate_bars(bus, pctx);
+}
+
 static bool pci_bus_phase2_fill_bar_lists(PCIBus *bus, PciProgramCtx *pctx,
                                           GArray *fixed_bars, GArray *remaining_bars)
 {
@@ -649,7 +1001,8 @@ void pci_fixed_bar_allocator(PCIBus *root, const PciFixedBarMmioParams *mmio)
     /* Phase 2: pack remaining 64-bit prefetchable BARs and size parent bridge window */
     pci_for_each_bus(bus, pci_bus_phase2_pack_remaining_bars, &pctx);
 
-    /* Phase 3: buses with no fixed-BAR devices; final bridge pass: follow-up */
+    /* Phase 3: allocate BARs for buses that have no fixed-BAR devices */
+    pci_for_each_bus(bus, pci_bus_phase3_allocate_no_fixed_bars, &pctx);
 
     /* Cleanup */
     g_hash_table_destroy(pctx.had_fixed);
-- 
2.34.1


