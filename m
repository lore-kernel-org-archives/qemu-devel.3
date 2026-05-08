Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406C4CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5Y-0006jP-In; Fri, 08 May 2026 14:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5Q-0006h5-KZ; Fri, 08 May 2026 14:38:08 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5P-0002b2-4Q; Fri, 08 May 2026 14:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eT0FLiYrrnD8zhY2JlBq7gdL/O7SGz2cEQdyK1GniyjalQrxrOOZtsaBfR19//6eUU3Cw8eHtTcQwrQ+zD6/5nwjXNtRwMnnMUDqJQnW8tub5FSRHIzfaCT63DR6uSv/4vxskd+J58i8D0DT6dg/k8topfu+sIDwny9AYBCFRFOD3LYaV/zwZ/Gt5qCp2LSzXcn8yGZT+29eOn+5srUoGC6g3klj7ABqaZPZQ8IyFtFDW6Prllru8e9ceY4VLey8ZFOdhHtAGNpWQx7kJz6IkmuBUyMr6AYVB5HNhUTbR6RA3+aqBdgSq2Ih6AboQPOPgeL6cfIDShx7lkBIMn4o7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj57KYpH+U+ZkBnHApaa/HFz/IbHpgaR9J4GKr3XX24=;
 b=FOQXXh8F1xVQwOONNfqCvPbge9lCxQZCIoiGoYYESfzBXyqtN6ckMgr7nXf0XvLBWwWHk4YoKU2x0CLzrkwtH+jDDJ8285Yctijbg216Yf3W2c9rjdsonV43ipVsgFBq6ekiHG/DoRnrI0JUukixTMaW+QcsUshY44xXr3G88wLfNPXj/rdD1LpqLDS6osaE7j/dI8+ipDoGmdcJUEmzFWfwh3eEnfOp7WDITC0pG2U9uN6AxPx9+RyPfAnA5t7IxPyzh5KrYKOnIcTd/9J9bvtZ1fuozYGsWkppg5XILf1Ig24+BXEE4r6Y6xmH6F/E3g3BvkQvvpcmDxP5J68FXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj57KYpH+U+ZkBnHApaa/HFz/IbHpgaR9J4GKr3XX24=;
 b=pxEOEInbgSZ+oQ4NwA6FzN1NUNEqfQ9gc2a7FI5qklh4aVSZEEcvGRicQSAfhCCwInKZ04cYHXYyZuZJ3rvqauAhLRabPia5caFc2p9o168H570nwMAEAWg3ZS9zn7oDZ19XUT6dWhhnunxdPSkECy3CHpf69+FIlyMWqiqYL3yTRr3Um1R9lb9/qVG+4EGu41o5jfP64qidPBDrEFUWBZxlaQYQXl5ODoWLLhEtxEhI5x1HvhaNb4uivm95jsYz0g/J5Jf2+qj7wxwpQQKLZmp1hk6d5rGmL4phSZPnIVVaP0rs6V9GyX5zjJqjbIy5m4ZafdJNE7tzIvfObuRX9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 18:37:53 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:53 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 6/8] hw/pci: finalize bridge prefetch windows after BAR
 allocation
Date: Fri,  8 May 2026 13:37:15 -0500
Message-Id: <20260508183717.193630-7-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0939.namprd03.prod.outlook.com
 (2603:10b6:408:108::14) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 929ce5f3-2add-4657-8224-08dead30ea64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: h50peUehNe2TI53gNJnMaKv9Gb8kzNXGt30xVoVnLLinerphPhHRRSegMh56AYjdYOY/Kg9y9OeFao+cvcx2GqTeDQPSBkpQTkgDtmjIViuA+8/OzHMmT5kQObL7vk/mTUSaMMLI+PmcH2k31PPGoCGp5zDpCU8t2pz614feTF5oV79hKn5HyUgeSqoU+pHTUsnGSkHzlIh8hQO16aCgg2HaMIhkwtCBnsXQvfUEo9BCfOkYkz7ZClIJxKLaQXsfbcn+ffLtuFWEdC50Rb5ecGTZO0yLgPcoP+0u34Ye3liX2I0/ed7V2FOFSWcrU7fPh2yJZN++htn97fjQ+hmxXsoqiI0gbTI3Zz7u7oZYHl2Paih3CEwXFh/u/jutd46Zl1hZ/GEc/sw0F0Ri8ZhXCF2O5qygL058ZeFm0MAlbmfJbSJZTmhvRCYmgTNri4wJ5XtM0mwUMqHuCRbut5OGH7MBUJmrffG9m1NejN/ldezVKU3zk4qrs2gPxksrrrvg4kkVk/d/azOghxZzbpmFSz2+Ot1A7bm9PizRAA+22ZBIc1c46ZqnhagWK279oaOd5XVxFlQdrKfZEukmfjG1dlGjd6M1x2q8OE/6HOBJmXBQ4Z4LHVFuB92/aYMQyfpdj0CIeBuxkYWFDnpZg1UWHg5femBMAZ6KrUi5oN1KsU5EiqwoYhmc+xqIhrqjxvJd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xHXZRtrlz4OQ0TfPI23YJrURC4EVzZMqQuErw/qWe0pa5NcwH8NGM44SozCl?=
 =?us-ascii?Q?q394xXWYiFTrjD8tqU6X7eXOT5xgTuMp1uIygOXwjJPN9aHs/f0VraH7eR+r?=
 =?us-ascii?Q?bYdueMwYYn/EoCf7kMHKrmpEELvkNFegYU5XTS5TCJf/bqoRu+KchWlvIryl?=
 =?us-ascii?Q?A4GBsXN+w3OsoxZn74uT6ky06uUTNuEd7LJ1GiFmAaVatwb8rDZweLT/A3ux?=
 =?us-ascii?Q?LGQj2Ih6kRBVlOORgzOhUsrYHw0BIMX6SdkiXSxZkbigdFG+/keTZrkxnFez?=
 =?us-ascii?Q?rK/njA3QsoQJd+rj8HJoAoo7TIiVJKOy/RpzCIX9+1obBQlAexR3syOaVu0N?=
 =?us-ascii?Q?k+j9l4n0Hf1+E9QeS6f3OOgcGDwGm73kI3X3LNXWua9nWO6YNiv3wCBUysD1?=
 =?us-ascii?Q?pUlIl2AhHL4835mjesUmRIIAcRC+gMpwIUWzdmTxOmghXwqSa3TbNQ9e4lhW?=
 =?us-ascii?Q?SzSIEcrzqFfSsbZSVAtEbcEsPSJP4qE5O9GDMa1UJUekaXvgTE1oF/38cpFC?=
 =?us-ascii?Q?hGT5MhLMyJJ8YUa9xCLGmhWrOwuD/RF6U+NAsXpUMAxHo/sHbjUku21ZNAx0?=
 =?us-ascii?Q?cFxEH6fCAzT3RYlOLWs9EXM7gxxFNjinC9/ziLjuzS6EqOhK7sFlZIh+8bEm?=
 =?us-ascii?Q?Xw6pNCpXr/z5NCY1H3jc+tY1ad8WeNV6wKheRnWFRaY92MLDqww+FM6Dg/8z?=
 =?us-ascii?Q?z0unudIZ6u1UAIAjvkjD680qqqL2jDHJG7Px1OlQXGkYI3mM8k/VztAq47Sk?=
 =?us-ascii?Q?QVZU/uSJjBMtjkynTmDD0eWKN8bhyO38eG6UvD4y5sE8WY4S1mGJalduCmLg?=
 =?us-ascii?Q?KiUTJjn63QxjxD3FKLIovoAzZuh63illGaNmMq0QIqq3Ci340TrNvkfMtUJ4?=
 =?us-ascii?Q?0m+TaVIYjjaRlzgvEddjCna0EFdiWG9qsXFODhM+LfNcarQJejrTimq2WwiP?=
 =?us-ascii?Q?RH3tpKVFea4FbYfCaS2ROddFApYRrp5M4BwC4oI3a4kZyRilY2qpDFE0b/Qu?=
 =?us-ascii?Q?WsUJ0+dH9+//Ep1zgKbTBK3ZKKev9yphtzMV0WUrhefK/imzU+PfcIH+dOa6?=
 =?us-ascii?Q?q+c7M+rPww8Jj1iYuqO72OxwQJCHT4YgaF7ZLCk4B1v3IW83WYR+4BY5B83C?=
 =?us-ascii?Q?o2+Z7aUg/TTnN/+Hur8z+AmjzoIrvihi+ctvEgWOiajwNCMhUObmtSGYh2Oz?=
 =?us-ascii?Q?mMgeLapNzmOZ3rbfmvmAYOdB2dYlF8MAeMw3xDnOjzDX5687JQeQwOYt/NOa?=
 =?us-ascii?Q?MQTqjunDDyzfVsUKSoyRnjvlwmGWmmoahRDEVEVSO2d0sbEN8GgyT1MkQ95D?=
 =?us-ascii?Q?PcLkrSobQB1o33h2wMaCpF2l3rsGXNp0WRPR+blAMKmYoKO6n5SwNHVLR3TQ?=
 =?us-ascii?Q?Oz953Bpp5WydCBcoSclc0B3K9j0s+6cgrqn4j1Lgv84krdagZ3TMC28J56N6?=
 =?us-ascii?Q?uB49MigSt4RDSPzlpuiLQyEnLxnCVcqSBYaxC8HJQCZgybkUhWdcFUh+X4M0?=
 =?us-ascii?Q?J9m8eW6EoMPiLesyQRxxrF1I6ugJLoYtdtrw+8BSjmwtyBGx1lscKCYQ/8mI?=
 =?us-ascii?Q?/Fz3EGM30LRYxIEgT/reKo3je28Ae2JeHVo+4FBaT8Rw1rvU2EwDsxyVDX48?=
 =?us-ascii?Q?J20XJjYkvO0o5bSUMLTfQRs4QZRqjk2YGv76E1KRuVFxci3RLkqbLIBJdT/X?=
 =?us-ascii?Q?/xdG3CtGxBvYudKf4UfE1BjQtyIducVpkdImoP35oamPWChH75KwyIFv61d1?=
 =?us-ascii?Q?Yx96MY3+YA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929ce5f3-2add-4657-8224-08dead30ea64
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:53.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNznszFYscpEfsMg7ZUlRvbzYEJvYkhdvTvvEifwQTvU0KbwX9Em9W+admZWEsJQcienTFTQKfnDkHcVMYMq3w==
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

Add a final reconciliation pass to update bridge prefetch windows
after all BARs have been assigned across all phases.

This ensures bridge windows accurately reflect final BAR placement
across all buses.

SR-IOV virtual functions are not included when sizing bridge prefetch
apertures and may require additional work.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/pci-resource.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/hw/pci/pci-resource.c b/hw/pci/pci-resource.c
index e2d2adc7de..01db59c4af 100644
--- a/hw/pci/pci-resource.c
+++ b/hw/pci/pci-resource.c
@@ -190,6 +190,76 @@ static void pci_update_prefetch_window(PCIBus *bus, uint64_t base, uint64_t limi
                                  4);
 }
 
+static void pci_get_bridge_window(PCIBus *bus, void *opaque)
+{
+    PCIDevice *bridge = pci_bridge_get_device(bus);
+    PciAllocCfg *pci_res = (PciAllocCfg *)opaque;
+
+    if (!bridge) {
+        pci_res->wbase = pci_res->mmio32_base;
+        pci_res->wlimit = pci_res->mmio32_base + pci_res->mmio32_size - 1;
+        pci_res->wbase64 = pci_res->mmio64_base;
+        pci_res->wlimit64 = pci_res->mmio64_base + pci_res->mmio64_size - 1;
+    } else {
+        pci_res->wbase = pci_bridge_get_base(bridge, PCI_BASE_ADDRESS_MEM_TYPE_32);
+        pci_res->wlimit = pci_bridge_get_limit(bridge, PCI_BASE_ADDRESS_MEM_TYPE_32);
+        pci_res->wbase64 = pci_bridge_get_base(bridge, PCI_BASE_ADDRESS_MEM_PREFETCH);
+        pci_res->wlimit64 = pci_bridge_get_limit(bridge, PCI_BASE_ADDRESS_MEM_PREFETCH);
+    }
+}
+
+static void pci_collect_mmio64_window(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    PciAllocCfg *pci_res = (PciAllocCfg *)opaque;
+    uint64_t rbase, rlimit;
+    uint32_t idx;
+
+    for (idx = 0; idx < PCI_ROM_SLOT; idx++) {
+        PCIIORegion *res = &dev->io_regions[idx];
+
+        if (!res->size) {
+            continue;
+        }
+        rbase = res->addr;
+        rlimit = res->addr + res->size - 1;
+        /* Entire BAR must lie in the window; do not count partial overlap. */
+        if (rbase < pci_res->wbase64 || rlimit > pci_res->wlimit64) {
+            continue;
+        }
+        pci_res->rbase = MIN(pci_res->rbase, rbase);
+        pci_res->rlimit = MAX(pci_res->rlimit, rlimit);
+    }
+
+    if (IS_PCI_BRIDGE(dev)) {
+        rbase = pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+        rlimit = pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+
+        if ((rbase < pci_res->wbase64) ||
+            (rbase > pci_res->wlimit64) ||
+            (rlimit < pci_res->wbase64) ||
+            (rlimit > pci_res->wlimit64)) {
+            return;
+        }
+
+        pci_res->rbase = MIN(pci_res->rbase, rbase);
+        pci_res->rlimit = MAX(pci_res->rlimit, rlimit);
+    }
+}
+
+static void pci_bus_update_prefetch_window(PCIBus *bus, void *opaque)
+{
+    PciAllocCfg *pci_res = (PciAllocCfg *)opaque;
+    pci_res->rbase = ~0;
+    pci_res->rlimit = 0;
+
+    assert(pci_bridge_get_device(bus));
+    pci_for_each_device_under_bus(bus, pci_collect_mmio64_window, pci_res);
+
+    if (pci_res->rlimit > pci_res->rbase) {
+        pci_update_prefetch_window(bus, pci_res->rbase, pci_res->rlimit);
+    }
+}
+
 static inline bool is_64bit_pref_bar(PCIIORegion *r)
 {
     if (!r->size) {
@@ -1004,6 +1074,25 @@ void pci_fixed_bar_allocator(PCIBus *root, const PciFixedBarMmioParams *mmio)
     /* Phase 3: allocate BARs for buses that have no fixed-BAR devices */
     pci_for_each_bus(bus, pci_bus_phase3_allocate_no_fixed_bars, &pctx);
 
+    memset(pci_res, 0, sizeof(PciAllocCfg));
+    pci_resource_init_from_mmio(pci_res, mmio);
+
+    /* TODO: 32-bit MMIO/ROM adjustment */
+    /* TODO: PIO assignment */
+    /* TODO: 64-bit non-prefetchable */
+
+    /* Align bridge prefetch window with assigned BAR ranges */
+    pci_get_bridge_window(bus, pci_res);
+
+    QLIST_FOREACH(bus, &bus->child, sibling) {
+        pci_res->bus = bus;
+        /* Use the full mmio64 window */
+        pci_res->wbase64 = pci_res->mmio64_base;
+        pci_res->wlimit64 = pci_res->mmio64_base + pci_res->mmio64_size - 1;
+
+        pci_for_each_bus(bus, pci_bus_update_prefetch_window, pci_res);
+    }
+
     /* Cleanup */
     g_hash_table_destroy(pctx.had_fixed);
     fixed_claim_regions_reset();
-- 
2.34.1


