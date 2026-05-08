Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466C9CD37AC
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5O-0006gO-MA; Fri, 08 May 2026 14:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5I-0006fE-Pv; Fri, 08 May 2026 14:38:02 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5G-0002b2-07; Fri, 08 May 2026 14:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5FkCqitWBKd/1Ke2DzePeqcZARTEnIySGXs71PB9gzHFxg/V3RrUan18F2WexLMoQgC8wo774ld+nvGbU56ctm8Fyt90/QAdTWdGhKa/i4mZ099ljhAkHYTfoTtTuzyqgA8VvxETO61Juf9qTsaMmOJVpOVOxjQ3G2+VnH4p+I9GG5f1t3VLf17OPNvwwz88JKAFN8gCtUBxO2v7AnStVZ5hgz55xtGAba117wK589oZj/bu9BiCfZUNLmEu4VE97Zqpo0NXRvHBED6R3aCM+zgYsjEQCEce/svRLsFhJN9xB1I9zPt44Ankmu3UV+tbJQSybnB0EgamFAqB/AP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W726+PPqMc4z9M6h6iHFJtIw4+4PuxeojHkmcipqfoE=;
 b=v5KD10mqLEQjqVdCK/JteGUxH81WbIZtAHVmCGQTQc7Bg2OdaL5LhHdpYXCCb5cTKuOYwUz4+E3Fj6IXHYcxFsFXsArP7c2Z06H268FiDrW8UpWmpQLh8L6x3mkfT98PCtPYdnxZidEkcxWQ3pItwgMht5CFTBGdv1NYCuKGgJznrMst/6V0myCVHFPhgEZUQvLcN1ejZh14PHhdK2dTLf1b9HcSe70NZUqdp73e7WC8SaNrs28fjLrJhe3xbVNWcdYF8wNHdbRqDEvRpsdRPKrYahb5DhLusNFKap7tRYft+lS0onw1FbwRV5bFesaJ5zWiBZCDl44H08wj9yRc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W726+PPqMc4z9M6h6iHFJtIw4+4PuxeojHkmcipqfoE=;
 b=L+PImY0FkjGdq4whRRmU4O1sAKcwJQjEd/sqSnFZHZnQkwEd7AmEog+Cjl0qjz3v/GcS/O19QE4gVik8kK4IEC3iy6A+8bbdRHW9Zj9RnT3hpKySVrv7CfLQ3v1x1Dou2hqOxH7Av/ztg0gYwyfVuIAxIk4TW6tFjuPDUz2kt0wr0S8UIn/1y5+NT/3VwtAWOAvWsgJ90G6OoedWz/BE96aXctxXFWT+xzFpj76f9KKEaqotTTErNS7TeIL/e4sP7ip1Cecz8W1yPpNmJtPcYGc+xVg2dwq3oT57FfAfX9+6a7aO++GkZxFJkOF6d81Iuzuss/3jSbXHU6m86+UVoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 18:37:49 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:49 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 4/8] hw/pci: pack remaining BARs and update bridge windows
Date: Fri,  8 May 2026 13:37:13 -0500
Message-Id: <20260508183717.193630-5-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:52d::6) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa4b1ef-7f63-4400-21c7-08dead30e795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: pQ9YfJNrlybMJeXQGudKZUk81yqN98JdRvwcj93VnAZlV7cVHKk3wFotgPcTcKIfjp1ONhRMlcogtR46dtZQXRlVzc4fOs8M+7wm9bTBUhhF4CtUDCO8dHvuqkBWg3nnWGCtsDABVZtXoanM4b/4hNoUnK1UTQFHwzSmE9VI/MJV2H1ZYlCQS1xFnH2nnPL1iZS5bWkCO1KIzoZxxLLtRFlNiq4xO5jRj3VyQg2AExOPnkcZv5dMArw/eUu9Aj+ibosh/rA31biqu2vAliU0DNLLAAfOf7yuRwbne4z7KTwR390F04EUy1uiJ6iBS4HZxzwskfYXaMgvQRxsA9XXGx976LjBnhjqa26JXuPPryZYqDtQWClDcShodq21YF4VWgsqcgK76t27qRw5k4KbVi3I3tuQsL+eC1kxpaRbP1gHSlFLwkTeMbroWQarBg2hX+RKwDDwVWh5DvraAEysis0CUvZD9RYFhKtsO5fYxaXXm0eZ88JcLucWRMZGsrC3zCCnqRQ0LodWRhb8Fq+tvrACsaMRByFJd1NK+pps9ouEY1Q+5Q/0CWUhh0D+1Fa3AMjvCPT99oc4Vl9kaE/3Gj42Yqr8ZOEfVxW33ePv0B8tJOmFUSg7BAdABiAXWCPLWQ+D78jRUHzAXS/3/54SZC+ah9nXTW+5ATlECcTdL5sBYa16Vh016JH7j4W6PyHT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhCS2JNUUhPVnljaVFNYjlEOE54RmlidHFVRVRhMnEzUCtuWHhpelFxSDND?=
 =?utf-8?B?a0V1YXo5a3J0aWZEbjFRYXUrT1UyNzVKQzFhZmhCT1RXU2tyODJ3ZUF6OVZT?=
 =?utf-8?B?UTRxY1FTbjduU1lDUnA1Tmhla291RUozcGFXRUk3NExZd2J2V0V5bStpSHlQ?=
 =?utf-8?B?SisxYlFCQkxQZXVWMTRtMFd5Ykh0OTNCbkxRdnlvNUx3cGNwNWQ0eE5WeFJq?=
 =?utf-8?B?djZ4aEV2bW9iN014MGhBR1JYMGkrTzdVNEZJUEMzRzF6UzBXYU10c2kvUVZ6?=
 =?utf-8?B?ZE5tS3BENk01cnFPS0dTWlo4UzFVK2FJTFEwc3ZkRXNUeFgyR0hiYldGUTBD?=
 =?utf-8?B?U0xENXNOVFhzU3N1YW1JK0xjYzcxSTdIREZMSXFtbEhNNlRySHk5NUova0tp?=
 =?utf-8?B?SmhLY2xBYWVYbCs3aGxkNkUxQUtmb2NkSVI2M0NRNEVwTnhQWSt0NGs1TXhT?=
 =?utf-8?B?eEtXaWsxWkpsK1N2ZkxoSlJPK0o1dldzTnBoT3BkMHlyYlh0Q3d5TkhOektn?=
 =?utf-8?B?bW1YNTVidXJNZXUyNkVSQXFwZ1Axa09aV2I1ejZzNDRoL21MeW5NejRjRmpq?=
 =?utf-8?B?UkRvWkxNUHl5cmg3V0F0T1NnUzZ1VWpGRXBQUGVlNklPYmxORFpucXVTbUh3?=
 =?utf-8?B?SFlQb21sTFZ5cTV6MXluSk1hNGJHMm1Gb1FlZW1tSXVEM2diN1EvMklVeXBk?=
 =?utf-8?B?a0d6d2Z6aDlvOERnb1ZhN2N0ZjgyQld2QTBRRXFTK1VwNHNWbWM3Y1cxNGIw?=
 =?utf-8?B?d2V5R25WdEtPWk51bFE4MlZ4V3FZczIyS1pQNkxkMWVDUUo3U1lNWE5yUFcy?=
 =?utf-8?B?MGRNQ1ZvcGQya3BGUVZNcElDR0xMcjZERjdsenFrSlhScDd2cC91WTFha1R4?=
 =?utf-8?B?Y1l2WGRKRHpBY0pRemwzMTBpZUVObHNmZUh0dUxCVGx1aUtLUE9QeDdYM3p6?=
 =?utf-8?B?RTRHeGRpOTRZRzF0bGxoSmgvN05pa2pwS2ZGekFVSGJHRnBpUjE3MzF5VjRa?=
 =?utf-8?B?S1pPV3pDWjZZTGo4bEFCZ1krR3hzQWl3aHF6NldKNlRYQVAvWjk1ZHRiZ3lQ?=
 =?utf-8?B?RXRPRGh0cllzYy9TOFlIMkd5Q28ycE52UEVpa3poVDh1eXQzbFgwQmJobWt1?=
 =?utf-8?B?OEplV1pFQmFoQ1hVdG9qY0g1dFpoL04xWmx5Z25ScEl4bDZjNjVqVXZ4SHBQ?=
 =?utf-8?B?SzNpYXZIWUdpZGxnV1ZJL3o4MHdMMFFPL01KMXQ5dG11OS90UU0vLzlNc05C?=
 =?utf-8?B?eEQ2YU0wb1NmWDJtaG5ESktKNm4xNTRsaFNtM1UwVzNseXZvczlOMXArVk1K?=
 =?utf-8?B?dnZWWitSSGI1bXljQjJQVTVhTDN1dTcyNW9WRzZDSGRRekVCbUcyUE9kdHhk?=
 =?utf-8?B?Q2R2S2xXaFJYaFd4Z2xkQnVSYU1uRCtJaUFsZFEwR3ZGbHdpc1gvUDZWalNE?=
 =?utf-8?B?dDJvVkZ4bGxReXF0b2dYeDJWYk8rUHc2SGkyYzA2RjlMNDJ2MDVqTWlvM3ow?=
 =?utf-8?B?MmZEMGZnd2xlL1RIdDNoY1hHNjB0NVBSZkxWdDEyQzFyeHp6aGQ1MFhyL01W?=
 =?utf-8?B?d3Q5UG9ZejJtT3hYcU5rWk1pRHlSZjJBV2VEUlAvM3FBbVJUS3l6VlR6Tnp5?=
 =?utf-8?B?Qy80aSttejQxb2FBb1BaNDc4REdCNysvN3BDYWhXRXhLY3Y4V1A0QjJEeVUz?=
 =?utf-8?B?UTJBZGFrQ09VN3JseGxMbWlFK0VlQTdueUIrT05kdTVWb04zejBqM3MvRUY4?=
 =?utf-8?B?aEhWcUxEQ24yL2R5am5LZ0ZLd3BSV2JTQ09wUjk1VFdRN2tQS2RhaXZ5NCtR?=
 =?utf-8?B?WWVZR1lsc2pmVVl3RGsyUzhkaUhDc3ZrT2NmM2xsWnBqaGVvQ0Rmc0ZKUnNy?=
 =?utf-8?B?YkpoZFFaejdySmQyMGd6USt5RXNnR0V6QmgxNDlESThVV2MyUzc3eVFQUXNo?=
 =?utf-8?B?c3BnZURTSkZvT1J5TVp6ajA1STBVR3Y0ODNPUG1IaDZGKzJJUEJ4clVISGNr?=
 =?utf-8?B?cHNjZjhEaUdpTWpTQ1Zwa1BuRlpaQWF2TkVTd1FvOXFHVmttQXdnRTdjRm1x?=
 =?utf-8?B?Um1jdWFWWnVBV0VyYmVPRUJubHdvT21IWUR6MGkva005dEVmUVdzYnVzWVJ3?=
 =?utf-8?B?dUhZaU04SHZxWThteG9wcmhUMjI2RmNkRHlRdmM4VGFpb3VtcVp3ekxxWm9s?=
 =?utf-8?B?ZE1zRkhJeERjcHlwY2YwTmxkbTROc2dzcFRleUdqOGZ6Q201MThUU3VhdWRU?=
 =?utf-8?B?OHl1eFAwS0ZPcVNUOHFUUmYzT1NpNmI2ZGdtY3A3dTBGcjdkZ3pQeExKMTQ1?=
 =?utf-8?B?M1QwNHBaVUJuYmwybkZNdVEvcnNNRGJqM1J5S3pxbjJnZmRRSlRCZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa4b1ef-7f63-4400-21c7-08dead30e795
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:49.0225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRq117yklppaJ2/YbGLr5/4ZWZZ6gP4S71mjOkZobwHo90r678lwEhKZ5DWFS2iT9h/rvqUmgsuyYys6ktqhJA==
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

Extend the fixed BAR allocator to handle remaining 64-bit prefetchable
BARs after fixed BAR placement.

For each bus with fixed BAR devices, collect fixed and unassigned BARs,
compute available MMIO64 holes considering both local fixed BAR anchors
and globally claimed regions, and select an appropriate region to pack
remaining BARs.

Remaining BARs are sorted by size and packed into the selected hole
using a greedy placement strategy. Fixed BAR placement is preserved,
and all allocations are tracked via the global claim list.

After BAR placement, update the PCI bridge prefetchable window to cover
both fixed and dynamically assigned BAR ranges, ensuring firmware sees
a consistent MMIO layout.

This implements the second phase of the allocator that does dynamic BAR
placement and bridge window sizing for buses with fixed BAR constraints.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/pci-resource.c | 404 +++++++++++++++++++++++++++++++++++++++++-
 hw/pci/pci-resource.h |  17 ++
 2 files changed, 420 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci-resource.c b/hw/pci/pci-resource.c
index 5e9a78ec16..de98924aa6 100644
--- a/hw/pci/pci-resource.c
+++ b/hw/pci/pci-resource.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/bitops.h"
 #include "qemu/range.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -158,6 +159,404 @@ static void pci_program_prefetch_bars(PCIDevice *dev, PhysBAR *pbars)
     }
 }
 
+static void pci_update_prefetch_window(PCIBus *bus, uint64_t base, uint64_t limit)
+{
+    PCIDevice *bridge = pci_bridge_get_device(bus);
+    uint32_t reg_base, reg_limit;
+
+    assert(bridge);
+
+    reg_base = (uint32_t)(extract64(base, 20, 12) << 4);
+    reg_limit = (uint32_t)(extract64(limit, 20, 12) << 4);
+    pci_host_config_write_common(bridge,
+                                 PCI_PREF_MEMORY_BASE,
+                                 pci_config_size(bridge),
+                                 reg_base | PCI_PREF_RANGE_TYPE_64,
+                                 2);
+    pci_host_config_write_common(bridge,
+                                 PCI_PREF_BASE_UPPER32,
+                                 pci_config_size(bridge),
+                                 (uint32_t)(base >> 32),
+                                 4);
+    pci_host_config_write_common(bridge,
+                                 PCI_PREF_MEMORY_LIMIT,
+                                 pci_config_size(bridge),
+                                 reg_limit | PCI_PREF_RANGE_TYPE_64,
+                                 2);
+    pci_host_config_write_common(bridge,
+                                 PCI_PREF_LIMIT_UPPER32,
+                                 pci_config_size(bridge),
+                                 (uint32_t)(limit >> 32),
+                                 4);
+}
+
+static inline bool is_64bit_pref_bar(PCIIORegion *r)
+{
+    if (!r->size) {
+        return false;
+    }
+    if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
+        return false;
+    }
+    if (!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+        return false;
+    }
+    if (!(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH)) {
+        return false;
+    }
+    return true;
+}
+
+/* Comparison function for sorting intervals by start address */
+static int compare_intervals(gconstpointer a, gconstpointer b)
+{
+    const AddressInterval *ia = (const AddressInterval *)a;
+    const AddressInterval *ib = (const AddressInterval *)b;
+    if (ia->start < ib->start) return -1;
+    if (ia->start > ib->start) return 1;
+    return 0;
+}
+
+/* Comparison function for sorting BARs by descending size */
+static int compare_bar_size_desc(gconstpointer a, gconstpointer b)
+{
+    const BarEntry *ea = (const BarEntry *)a;
+    const BarEntry *eb = (const BarEntry *)b;
+    if (ea->size > eb->size) return -1;
+    if (ea->size < eb->size) return 1;
+    return 0;
+}
+
+/* Categorize holes relative to anchors */
+static CategorizedHoles categorize_holes(GArray *holes, GArray *fixed_bars)
+{
+    CategorizedHoles result = {
+        .leftmost_hole = -1,
+        .middle_holes = g_array_new(false, false, sizeof(int)),
+        .rightmost_hole = -1
+    };
+
+    /* Get anchor boundaries */
+    uint64_t first_anchor_start = g_array_index(fixed_bars, AddressInterval, 0).start;
+    uint64_t last_anchor_end = g_array_index(fixed_bars, AddressInterval,
+                                             fixed_bars->len - 1).end;
+    /* Categorize each hole */
+    for (guint h = 0; h < holes->len; h++) {
+        AddressInterval *hole = &g_array_index(holes, AddressInterval, h);
+
+        if (hole->end < first_anchor_start) {
+            result.leftmost_hole = h;  /* Before all anchors */
+        } else if (hole->start > last_anchor_end) {
+            result.rightmost_hole = h;  /* After all anchors */
+        } else {
+            g_array_append_val(result.middle_holes, h);  /* Between anchors */
+        }
+    }
+    return result;
+}
+
+/*
+ * Compute REAL holes considering both local anchors and global claims.
+ * This returns actual free space that can be used for packing.
+ * Strategy: Collect all obstacles (local fixed BARs + global claims from
+ * other buses), then compute gaps between them.
+ */
+static GArray* compute_real_holes(GArray *fixed_bars, uint64_t mmio_start, uint64_t mmio_end)
+{
+    GArray *holes = g_array_new(false, false, sizeof(AddressInterval));
+    GArray *claimed_regions = g_array_new(false, false, sizeof(AddressInterval));
+    uint64_t scan;
+
+    /* Add local fixed BARs (anchors) as claimed regions */
+    for (guint i = 0; i < fixed_bars->len; i++) {
+        AddressInterval *anchor = &g_array_index(fixed_bars, AddressInterval, i);
+        g_array_append_val(claimed_regions, *anchor);
+    }
+
+    /* Add global claims from ALL buses (including other buses) */
+    if (fixed_claim_regions) {
+        for (guint i = 0; i < fixed_claim_regions->len; i++) {
+            FixedClaim *claim = &g_array_index(fixed_claim_regions, FixedClaim, i);
+            /* Only consider claims within our MMIO window */
+            if (claim->start <= mmio_end && claim->end >= mmio_start) {
+                AddressInterval region = {
+                    .start = claim->start,
+                    .end = claim->end
+                };
+                g_array_append_val(claimed_regions, region);
+            }
+        }
+    }
+
+    /* Handle case with no claimed regions */
+    if (claimed_regions->len == 0) {
+        AddressInterval hole = { .start = mmio_start, .end = mmio_end };
+        g_array_append_val(holes, hole);
+        g_array_free(claimed_regions, true);
+        return holes;
+    }
+
+    /* Sort claimed regions by start address */
+    g_array_sort(claimed_regions, compare_intervals);
+
+    /* Compute holes between all claimed regions */
+    scan = mmio_start;
+    for (guint i = 0; i < claimed_regions->len; i++) {
+        AddressInterval *claimed = &g_array_index(claimed_regions, AddressInterval, i);
+
+        /* Free space before this claimed region */
+        if (scan < claimed->start) {
+            AddressInterval hole = { .start = scan, .end = claimed->start - 1 };
+            g_array_append_val(holes, hole);
+        }
+
+        /* Move scan cursor past this claimed region */
+        scan = MAX(scan, claimed->end + 1);
+    }
+
+    /* Free space after last claimed region */
+    if (scan <= mmio_end) {
+        AddressInterval hole = { .start = scan, .end = mmio_end };
+        g_array_append_val(holes, hole);
+    }
+
+    g_array_free(claimed_regions, true);
+    return holes;
+}
+
+static bool pack_bars_into_region(GArray *bars, uint64_t pack_start, uint64_t pack_end,
+                                   uint64_t *out_min_addr, uint64_t *out_max_addr)
+{
+    uint64_t pack_cursor = pack_start;
+    uint64_t min_addr = UINT64_MAX;
+    uint64_t max_addr = 0;
+
+    for (guint i = 0; i < bars->len; i++) {
+        BarEntry *e = &g_array_index(bars, BarEntry, i);
+        PCIIORegion *r = &e->dev->io_regions[e->bar_idx];
+
+        uint64_t aligned_addr = ROUND_UP(pack_cursor, r->size);
+        uint64_t bar_start = aligned_addr;
+        uint64_t bar_end = bar_start + r->size - 1;
+
+        if (bar_end > pack_end) {
+            return false; /* Doesn't fit */
+        }
+
+        PhysBAR pbars_array[PCI_ROM_SLOT];
+        memset(pbars_array, 0, sizeof(pbars_array));
+        pbars_array[e->bar_idx].addr = bar_start;
+        pbars_array[e->bar_idx].end = bar_end;
+        pbars_array[e->bar_idx].flags = IORESOURCE_PREFETCH;
+
+        pci_program_prefetch_bars(e->dev, pbars_array);
+
+        min_addr = MIN(min_addr, bar_start);
+        max_addr = MAX(max_addr, bar_end);
+        pack_cursor = bar_end + 1;
+    }
+
+    *out_min_addr = min_addr;
+    *out_max_addr = max_addr;
+    return true;
+}
+
+static void finalize_bridge_window(PCIBus *bus, uint64_t min_addr, uint64_t max_addr)
+{
+    PCIDevice *bridge_dev = pci_bridge_get_device(bus);
+
+    if (bridge_dev) {
+        fixed_claim_regions_add(min_addr, max_addr, bridge_dev, -1);
+        pci_update_prefetch_window(bus, min_addr, max_addr);
+    }
+}
+
+static bool pci_bus_phase2_fill_bar_lists(PCIBus *bus, PciProgramCtx *pctx,
+                                          GArray *fixed_bars, GArray *remaining_bars)
+{
+    AddressInterval interval;
+    BarEntry bentry;
+    PCIDevice *d;
+    PCIIORegion *r;
+    bool bus_has_fixed = false;
+    bool device_has_fixed;
+    int devfn, i;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        d = bus->devices[devfn];
+        if (!d) {
+            continue;
+        }
+        device_has_fixed = g_hash_table_contains(pctx->had_fixed, d);
+        if (device_has_fixed) {
+            bus_has_fixed = true;
+        }
+        for (i = 0; i < PCI_ROM_SLOT; i++) {
+            r = &d->io_regions[i];
+            if (!is_64bit_pref_bar(r)) {
+                continue;
+            }
+            if (device_has_fixed && d->fixed_bar_addrs &&
+                d->fixed_bar_addrs[i] != PCI_BAR_UNMAPPED) {
+                interval.start = d->fixed_bar_addrs[i];
+                interval.end = d->fixed_bar_addrs[i] + r->size - 1;
+                g_array_append_val(fixed_bars, interval);
+            } else {
+                bentry.dev = d;
+                bentry.bar_idx = i;
+                bentry.size = r->size;
+                g_array_append_val(remaining_bars, bentry);
+            }
+        }
+    }
+    return bus_has_fixed;
+}
+
+/* Find a mmio64 hole, pack unassigned BARs and program the bridge */
+static void
+pci_bus_phase2_hole_pack_and_update_bridge(PCIBus *bus, GArray *fixed_bars,
+                                           GArray *remaining_bars,
+                                           uint64_t mmio_start,
+                                           uint64_t mmio_end)
+{
+    GArray *holes;
+    FixedClaim *claim;
+    CategorizedHoles cat;
+    AddressInterval *holep, *selected;
+    int selected_hole, largest_middle, h_idx;
+    guint c, mid_i, f;
+    uint64_t bus_min_addr, bus_max_addr, remaining_demand;
+    uint64_t leftmost_anchor, rightmost_anchor_end, valid_start, valid_end;
+    uint64_t largest_size, hole_size, pack_start, pack_end;
+
+    g_array_sort(fixed_bars, compare_intervals);
+    g_array_sort(remaining_bars, compare_bar_size_desc);
+
+    remaining_demand = 0;
+    for (c = 0; c < remaining_bars->len; c++) {
+        remaining_demand += g_array_index(remaining_bars, BarEntry, c).size;
+    }
+
+    leftmost_anchor = g_array_index(fixed_bars, AddressInterval, 0).start;
+    rightmost_anchor_end = g_array_index(fixed_bars, AddressInterval,
+                                        fixed_bars->len - 1).end;
+
+    valid_start = mmio_start;
+    valid_end = mmio_end;
+
+    if (fixed_claim_regions) {
+        for (c = 0; c < fixed_claim_regions->len; c++) {
+            claim = &g_array_index(fixed_claim_regions, FixedClaim, c);
+            if (claim->end < leftmost_anchor && claim->end >= valid_start) {
+                valid_start = claim->end + 1;
+            }
+            if (claim->start > rightmost_anchor_end && claim->start <= valid_end) {
+                valid_end = claim->start - 1;
+            }
+        }
+    }
+
+    holes = compute_real_holes(fixed_bars, valid_start, valid_end);
+    cat = categorize_holes(holes, fixed_bars);
+
+    selected_hole = -1;
+    pack_start = 0;
+    pack_end = 0;
+
+    if (cat.middle_holes->len > 0) {
+        largest_middle = -1;
+        largest_size = 0;
+        for (mid_i = 0; mid_i < cat.middle_holes->len; mid_i++) {
+            h_idx = g_array_index(cat.middle_holes, int, mid_i);
+            holep = &g_array_index(holes, AddressInterval, h_idx);
+            hole_size = holep->end - holep->start + 1;
+            if (hole_size >= remaining_demand && hole_size > largest_size) {
+                largest_size = hole_size;
+                largest_middle = h_idx;
+            }
+        }
+        if (largest_middle >= 0) {
+            selected_hole = largest_middle;
+        }
+    }
+    if (selected_hole < 0 && cat.rightmost_hole >= 0) {
+        holep = &g_array_index(holes, AddressInterval, cat.rightmost_hole);
+        hole_size = holep->end - holep->start + 1;
+        if (hole_size >= remaining_demand) {
+            selected_hole = cat.rightmost_hole;
+        }
+    }
+    if (selected_hole < 0 && cat.leftmost_hole >= 0) {
+        holep = &g_array_index(holes, AddressInterval, cat.leftmost_hole);
+        hole_size = holep->end - holep->start + 1;
+        if (hole_size >= remaining_demand) {
+            selected_hole = cat.leftmost_hole;
+        }
+    }
+    g_array_free(cat.middle_holes, true);
+    if (selected_hole < 0) {
+        error_report("bus [%02x] insufficient contiguous space for "
+                     "remaining_demand=0x%"PRIx64,
+                     pci_bus_num(bus), remaining_demand);
+        g_array_free(holes, true);
+        g_array_free(fixed_bars, true);
+        g_array_free(remaining_bars, true);
+        exit(1);
+    }
+    selected = &g_array_index(holes, AddressInterval, selected_hole);
+    pack_start = selected->start;
+    pack_end = selected->end;
+    g_array_free(holes, true);
+    if (!pack_bars_into_region(remaining_bars, pack_start, pack_end,
+                                 &bus_min_addr, &bus_max_addr)) {
+        error_report("bus [%02x] failed to pack BARs", pci_bus_num(bus));
+        g_array_free(fixed_bars, true);
+        g_array_free(remaining_bars, true);
+        exit(1);
+    }
+    for (f = 0; f < fixed_bars->len; f++) {
+        holep = &g_array_index(fixed_bars, AddressInterval, f);
+        bus_min_addr = MIN(bus_min_addr, holep->start);
+        bus_max_addr = MAX(bus_max_addr, holep->end);
+    }
+    finalize_bridge_window(bus, bus_min_addr, bus_max_addr);
+    g_array_free(fixed_bars, true);
+    g_array_free(remaining_bars, true);
+}
+
+static void pci_bus_phase2_pack_remaining_bars(PCIBus *bus, void *opaque)
+{
+    PciProgramCtx *pctx = (PciProgramCtx *)opaque;
+    GArray *fixed_bars, *remaining_bars;
+    uint64_t mmio_start, mmio_end, bus_min_addr, bus_max_addr;
+    bool bus_has_fixed;
+
+    mmio_start = pctx->mmio64_base;
+    mmio_end = pctx->mmio64_base + pctx->mmio64_size - 1;
+    fixed_bars = g_array_new(false, false, sizeof(AddressInterval));
+    remaining_bars = g_array_new(false, false, sizeof(BarEntry));
+    bus_has_fixed = pci_bus_phase2_fill_bar_lists(bus, pctx, fixed_bars,
+                                                    remaining_bars);
+    if (!bus_has_fixed) {
+        g_array_free(fixed_bars, true);
+        g_array_free(remaining_bars, true);
+        return;
+    }
+    if (remaining_bars->len == 0) {
+        if (fixed_bars->len > 0) {
+            g_array_sort(fixed_bars, compare_intervals);
+            bus_min_addr = g_array_index(fixed_bars, AddressInterval, 0).start;
+            bus_max_addr = g_array_index(fixed_bars, AddressInterval,
+                                        fixed_bars->len - 1).end;
+            finalize_bridge_window(bus, bus_min_addr, bus_max_addr);
+        }
+        g_array_free(fixed_bars, true);
+        g_array_free(remaining_bars, true);
+        return;
+    }
+    pci_bus_phase2_hole_pack_and_update_bridge(bus, fixed_bars, remaining_bars,
+                                                mmio_start, mmio_end);
+}
 /* Phase 1: claim and program fixed BARs for one device (per-device callback) */
 static void pci_dev_claim_and_program_fixed_bars(PCIBus *bus, PCIDevice *dev, void *opaque)
 {
@@ -247,7 +646,10 @@ void pci_fixed_bar_allocator(PCIBus *root, const PciFixedBarMmioParams *mmio)
     /* Phase 1: program all fixed BARs and claim them */
     pci_for_each_bus(bus, pci_bus_claim_and_program_fixed_bars, &pctx);
 
-    /* TODOs: Phases 2–3, program remaining BARs, bridge window refresh etc,.  */
+    /* Phase 2: pack remaining 64-bit prefetchable BARs and size parent bridge window */
+    pci_for_each_bus(bus, pci_bus_phase2_pack_remaining_bars, &pctx);
+
+    /* Phase 3: buses with no fixed-BAR devices; final bridge pass: follow-up */
 
     /* Cleanup */
     g_hash_table_destroy(pctx.had_fixed);
diff --git a/hw/pci/pci-resource.h b/hw/pci/pci-resource.h
index cc4d6f71cb..5155a7cefa 100644
--- a/hw/pci/pci-resource.h
+++ b/hw/pci/pci-resource.h
@@ -47,6 +47,23 @@ typedef struct FixedClaim {
     int bar;
 } FixedClaim;
 
+typedef struct {
+    uint64_t start;
+    uint64_t end;
+} AddressInterval;
+
+typedef struct {
+    PCIDevice *dev;
+    int bar_idx;
+    uint64_t size;
+} BarEntry;
+
+typedef struct {
+    int leftmost_hole;      /* Index of hole before first anchor, or -1 */
+    GArray *middle_holes;   /* Array of hole indices between anchors */
+    int rightmost_hole;     /* Index of hole after last anchor, or -1 */
+} CategorizedHoles;
+
 typedef struct {
     hwaddr mmio64_base;
     hwaddr mmio64_size;
-- 
2.34.1


