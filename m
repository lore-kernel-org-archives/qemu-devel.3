Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5090BC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uoF-0006We-Q7; Wed, 16 Sep 2026 14:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6uny-0006TA-Fq; Wed, 16 Sep 2026 14:56:28 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unw-000632-O3; Wed, 16 Sep 2026 14:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swxvS0qc9SIxW3vaFIR9e5r3AEQcWJb1+M99YABDd7m0FV6DcMrnEUDvhcw/3GnqmaPPyOie4aw/ox4J4QGoHUi+X9dT/AzSY+pW4jBOyGasWLJuEMORYgkO+yalzMEj0Koo0IQoymWIc1D81rIGzrlYOaCytQ7ckYCSPaRH23g8okdUa210lDaeb63qUQe3PSpDsnoQldXPEafkNPT7cauhDrEBJ4zy2r3kZM64WOb9px/bp9xZeJtJqXDaQf4JgrMss0qz1rV71i+WddEPTO+gnW+BWLr9g9xLiBcd1j2d64AZwIbLjhbENmxDc5G/bMaeKhycnUwbNJfywYWGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtZFbS/13ma2fehmVKQEA7rUZNJnAxLgR5cAUhYvH0g=;
 b=FzFN0wJG2esPo0RWKS7B2ZsaVxMoNW9F2pEI+WuXn78BQzeDVW77vb21jeBgjkA+GNCfifXsg5uH3NpMQo73bU1S/hR08m9BOPcxtOAc9vlbzXFT63GuoKt5uodqCX+KolgHBtE72O7igb2WPRb5CXLKXmm7MN41WoS8QVNi8B9VHZ6lI9i2GZ/w0t4mvJLqIuYISE5LyY90vOmb4H0kPC2mS45FaDpqWcITRtQP5simCoPk1VRb+a9wbNF7yN48mLKl1b1Q7t+xVy7aRz2UIpLCspJdms+y90cLW5mPTgupL26yFPL6eEjGmstasvewJlSvHcQ8tGhSvRXx5n3BFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtZFbS/13ma2fehmVKQEA7rUZNJnAxLgR5cAUhYvH0g=;
 b=TKMV4XuwPjNN5Pr5Tvjgp1InvuZ1WYX8nvLbLil6B/r1M2PXf9iGdQuuazclKhTQ5h8ff8i6Ptw+ZDwPoKitR/zRpfZLCIQCej1q/rU/yariJsO3PhVBd6CyWTK3Cz7uRzGmkYW2iF0zef/N7l2O7emReyIEs2pJuN4aZ7UOzJleW8OFkeuBHlwQbCWJiHN9Sq8Gt2ELZo6PIP2hyZv9bP0WmqLK8OejenYYY2jY8AgjSs+oqrYwHIFFXmH0JIyHtxIFWefn5RQ8K17hZnSFP+YrtfFSJKgA8pjtM8sGlMkmZbYtNTH6xrUpN9oY1E/2ncjYqbvyxkB9w3hPupghFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY3PR12MB9631.namprd12.prod.outlook.com
 (2603:10b6:930:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:56:08 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 18:56:08 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 5/5] hw/arm/virt: add highmem-mmio-base property
Date: Wed, 16 Sep 2026 13:55:54 -0500
Message-Id: <20260916185554.917526-6-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916185554.917526-1-tdave@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:d3::28) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 530dd892-96d4-49ef-ab2c-08df14242aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: f2kw+Ya7cXZ4btsUtpn3wNDVDKP2Hnl9xXYfPps8mo4wZtNePOdfOWQ45S8cAkiczCc7XUUDQJI6zkjoDYKOO+OyCrTCe8YGeeJgY6rwMqOskdORVBkIcKCcyHyREZW80w+G/kQ62Yq7wotocrTpP1tM6BdaynEr1kzvzSlJCIPRSDJI1MVXlLn2/6i3GqOTPPPDftVxVdg72NberlcJ9fqK/TrGFaUoTv84/TkIKFI2XjUKJv5Bqd2SWv03Cu/l3b7hXKIH9kk73YLn7ldgHB86qdHkUX/lUlSFaXQMUQngT4NPfW9E3Zegpysfr7/HrVK4/hrZF1WcGkGECVrAQupQ9YYRgw7RGJngt1ZHSRZmYN4N6sH1jVhgzwxEfHiIVLUfFb1H1Y7moFIDPZAM0XONtZHjaKuqLzpHUiEFjSl3BX9/txTx+ZQDdHIGof4zqjU76eZQkitv+LGA+Hc9f87m+eBCNmCz4mJm86Pm0VwEK9KuECAru2pnNOmW+2EoJxa6fi/OJbrpLU5NNPMsIIKIL/bvQ19ZPYp+VzLxTMRi7qn6n9wPH0keqezyMkuJdvUQJbts15QANgpvf6cU9RsRm7UTk2zmmbXT36c8RCRtKfzsp1EGEdy7Uud0pdy9ObwOdOm3r16Eo+dxfvDIlOqTRRqezpbr2C05Dydl9/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kZ7HV0pXT3mdQYXxpmb6emyIbJJWDkpHuF/31gIAG3czN/Fm5az+x5j3lHiJ?=
 =?us-ascii?Q?HEnc6AgXv0XgZ4Jau1cq05MmAVfuc+CXFZXdZeslmpggrilYzVaK4YAlOtKM?=
 =?us-ascii?Q?bDjUWThef73MpuABVnoBKljNgWLEw0zDSf6Syj4KrwKkG1ZxcgfR2hDstB1I?=
 =?us-ascii?Q?hx0L4oGBE1ekbmRuhUJJXv73BOrMQVO8OCguogcmtGPpuyTlSc2OIwBpCfjV?=
 =?us-ascii?Q?Rp4XlG30zPD3Ehhejc7lfpuX0Pq/PhauMHsFYf4+FgYmnIwDSxEf0wzVDgaI?=
 =?us-ascii?Q?kXuAYWopLvhSL2jlyeGx5b4MlnsU6ZyHELF/7nGVhJUkrUFuk4bZ2vxbFjhv?=
 =?us-ascii?Q?+rshayX5adzLrEDlCfZxQwICeM1Yy9uS2K9entbWoXip/i0OdyUB7QulV6PU?=
 =?us-ascii?Q?YtIHlAYVaWpxuFcTD8W7Bmg8jvk47VzA8ceriT1G+gWafNODY5s8eh+Dg9hd?=
 =?us-ascii?Q?oUAEpYdey4DxPPMElu5tvS/AsQdudlCrsdZC+sFcNeUSMiRtj6QkLdlVL8/C?=
 =?us-ascii?Q?QDKICe29b1Ssw/UdanR13ZV1x77heyHWQ6CevsmbSifGRrKP8/ujFSR9Iwxw?=
 =?us-ascii?Q?jALoRRMIz67RQs7sPkYhDsvz9HJKDYOtiCziW+hIB2BPWP/G0DiYmLV6YV3I?=
 =?us-ascii?Q?o8esBqrhMFg6Ocj7OrnA96Spzfr9VP5x2H7uDvBwd/9CT3HieIetsZmDarR9?=
 =?us-ascii?Q?7mOsmlqE6mLEMyEndCRtl1BQacF5HeAE6GlWcz+VtNcLqckzeKdv/x8GHCxI?=
 =?us-ascii?Q?ibDjvkBnykIoC7MU8gSjyBHBBQzVyJhTwe90hx1lvuUluGdz55WIAknvFlOo?=
 =?us-ascii?Q?7Y6C6B68d8GZkfpuLm6E5a+Q9jb8ntwpwkGSPdP0nB7YcqZ+SCKnqVhkzxdK?=
 =?us-ascii?Q?nXO9u2imiHQTYXSybElnQrT68Si3aNgneiPQ6aXsvuJeyecQ6GFePviyhlTa?=
 =?us-ascii?Q?HMf8ru46AhyGBWCaXZeu40d0DnMEJnfOc3RltjbQuK3neMs260plM3khqNpH?=
 =?us-ascii?Q?jTE/d1YRw0EblRqotbDyM62jhTGGLhyh5M+KDQ1MCfLzKptn2sFRi0WYRC97?=
 =?us-ascii?Q?ZaHCKZvHx/zPGMPu+yKYsHS0IX8LPq9cl9Tvbkup12jX/zeCNeuzmFk5DY08?=
 =?us-ascii?Q?vJ82oUqWZqmPKIqY+7QjN2bv+l+aZRPMeNwXvnTqXTGAGhmafz6r+Ydru9ui?=
 =?us-ascii?Q?yaWfu2sh2MNW5nzQyJ5PDA5zv6r95awEeSbCB2X1MX2SvRCHHbKMFI/iubJU?=
 =?us-ascii?Q?RpQ0jAYuOYgmp2vfN9uQalCCOVun0PV5B+T5DlGdmgUmb/Yc0iP6HGxdA9hz?=
 =?us-ascii?Q?zUHT0ZEZNrND8urhvL/4BBos31NK92rW6sjx3W1RChRhQdis97ZeAoebXq/Q?=
 =?us-ascii?Q?qx3rTTPX7dwOtxEgrCe0jOrjqOwmwhJtFKyvUUFCIL1gcppxzNTowujCNlLe?=
 =?us-ascii?Q?kgv+mguyNJc8e1eqTZEAVpDfaSjXRKOql29s3EyDjqDvzK9rC3EhecVyVIki?=
 =?us-ascii?Q?iUC6pRDRLrI00WecMCoIc3TnwVOozx+9dgl/DxDcaDhFKRAjuV7boN7dr5Hp?=
 =?us-ascii?Q?Pv644jHu6626GiPXYI/jBJgJkglOrvmjL2T9kCZbjHJChN8OiUzNgPrggegn?=
 =?us-ascii?Q?+A2S2uBWlTxbVpHHnZzOZ6bnw214oD8zagTqFokXvhAa+kLulJwNWtcxqbVx?=
 =?us-ascii?Q?JRq3C4wtiTVPnxhOg72BBtoII4a6YLKLLzYu+1TYiw7QljCo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530dd892-96d4-49ef-ab2c-08df14242aee
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:56:08.2110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDubafHJe+9oWxmvvEzEaNDXO/IOP1Fw0/xhzUYp290DSRb4wzEPAfhDSZxFbyE0Erumc2K9PkyAu3BOeIDc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add a highmem-mmio-base property to override the base of the virt
machine's high PCIe MMIO window, alongside the existing
highmem-mmio-size:

  -machine virt,highmem-mmio-base=<addr>,highmem-mmio-size=<size>

Some PCI devices require MMIO resources to be placed within a
specific address range that cannot be satisfied by the default
placement. The configured base is validated to be non-zero, aligned
to highmem-mmio-size, non-overlapping with the existing high memory
layout, and within the configured physical address space.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c5db663858..3a554dd26c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2513,9 +2513,34 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         region_enabled = virt_get_high_memmap_enabled(vms, i);
-        region_base = ROUND_UP(base, extended_memmap[i].size);
         region_size = extended_memmap[i].size;
 
+        if (i == VIRT_HIGH_PCIE_MMIO && extended_memmap[i].base) {
+            region_base = extended_memmap[i].base;
+
+            if (region_base < base) {
+                error_report("highmem-mmio-base 0x%"PRIx64" overlaps prior "
+                             "high memory layout (must be >= 0x%"PRIx64")",
+                             region_base, base);
+                exit(1);
+            }
+            if (region_base % region_size != 0) {
+                error_report("highmem-mmio-base 0x%"PRIx64" must be "
+                             "aligned to highmem-mmio-size 0x%"PRIx64,
+                             region_base, region_size);
+                exit(1);
+            }
+            if (region_base + region_size > BIT_ULL(pa_bits)) {
+                error_report("highmem-mmio-base + highmem-mmio-size "
+                             "[0x%"PRIx64", 0x%"PRIx64") exceeds %d-bit PA "
+                             "space", region_base,
+                             region_base + region_size, pa_bits);
+                exit(1);
+            }
+        } else {
+            region_base = ROUND_UP(base, region_size);
+        }
+
         vms->memmap[i].base = region_base;
         vms->memmap[i].size = region_size;
 
@@ -3416,6 +3441,33 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
+static void virt_get_highmem_mmio_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t base = extended_memmap[VIRT_HIGH_PCIE_MMIO].base;
+
+    visit_type_size(v, name, &base, errp);
+}
+
+static void virt_set_highmem_mmio_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t base;
+
+    if (!visit_type_size(v, name, &base, errp)) {
+        return;
+    }
+
+    if (base == 0) {
+        error_setg(errp, "highmem-mmio-base cannot be 0");
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].base = base;
+}
+
 static char *virt_get_msi(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -4286,6 +4338,14 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-base", "size",
+                                   virt_get_highmem_mmio_base,
+                                   virt_set_highmem_mmio_base,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-base",
+                                          "Set the high memory region base "
+                                          "for PCI MMIO");
+
     object_class_property_add(oc, "virtio-mmio-transports", "uint8",
                                    virt_get_virtio_transports,
                                    virt_set_virtio_transports,
-- 
2.34.1


