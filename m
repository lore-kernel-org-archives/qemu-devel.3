Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BBFC5DF97
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOBl-0005mh-BA; Wed, 26 Aug 2026 20:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBj-0005mC-8g; Wed, 26 Aug 2026 20:41:51 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBh-0004l8-3p; Wed, 26 Aug 2026 20:41:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2BhhvXMZ1ODHCnLnFY8hqcGijYu6J2Z444JIStY1V0V4bLYAd4f9bx08bBVlzKdwZz4vgQWbYewFCgo+X3uH2XXyAYZ7wCWvU13uo3HhwUR6mKx2kyFUNB9s7fi4J5TaeoDdMLF8A81G0/UL5hLX+GYJMEQfcvnNFKVDpsqaUxFAdXauvR0vS2WbYQuaxC5Dp9eqnf+oKibf2nahXQLvc5+j3eBYt1lcWy3ecZoiht6r6wECDDYhdDuMCbitNDv7H1wQ2oPW2luGGXElPB/nV81XXsda4MovPXouZdtZhPKxIhjXFoKAqLPxRn03eV6nDIirfww/pmWEwJpIT5k8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwUKyt99BT1KC26D5OJ4xTMAFpN2pgv29wq1gcDOvlw=;
 b=f3m8uyRiuXTPz0nG87HPL0lKD79CVNRjvjoFvk3v9m3uhIuU+glt4S2ADAZqrSQCfn7nQnMOqvex4ZcNVzx2ViTfH19OvlxRZvJiLRNJUYhVd9X3f/EIPcZpeNIj9WXfpqbQsAsSINXaUt3u8kMk9UbwyXJNSrSs9iyZRp/xgiFlNdNcj5+xK9s+Km9+NJqNVj+R1FYgk/eQFjOu/9QlD0cYx1d5+4WSQRDULhWlAQCXMKY08GCF/cM96gwUBm5+woIo+RuuLuyzWHsfewErwRim2j3q44OL+IE5aW7uG7cLX8OoMAKvyMuYCvlzFBhwXHJMUN+/ET7/srPDVrQ7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwUKyt99BT1KC26D5OJ4xTMAFpN2pgv29wq1gcDOvlw=;
 b=C+gqV9nP+awExlLTvadUBnmShUabdNdnuN/7NXFTtQsxkFvUJWjdsVZRcb6NHM2db5KqA/iD0yYYicPJ9EkMVWNRas4dElWYghTi/b6XOu2qh/rEAo6N6cVIepA4dCItFi3yThBswdFZlayQ8CPucuARrA3abDQI2g8XoJDRCSpH2ZrKQNVZRRPblOsm7cBLEg7pIb9W6ECjkvjFMNS1VbgJx2pD7k8L6iu8dGf+txFQj1iMa1SVOFFC8kFTTuBpgxbnhG15Rb6erpbCSyDN4h+gjCBo8xU07fuj6rsB3TQjRxcrh7h8UwrONqU8mrB66zzmTLu5RsRyZHkMg0zg5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 00:41:32 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:41:29 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH v2 3/5] pci: add fixed BAR fw_cfg blob export
Date: Wed, 26 Aug 2026 19:40:22 -0500
Message-Id: <20260827004024.598351-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827004024.598351-1-tdave@nvidia.com>
References: <20260827004024.598351-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2252696f-bdfd-4462-aa96-08df03d3ef36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: zeFK+NLcgDsPmP3JHGMsBGs2MDfikC0FDbLIK2WF5GAlzJRGm7i1ECeoOlH6cCwUx1LeL4xEWG4Zm2k4LnsOOiNCYacJGCFyDs+X6KVJRkCa8XvolmLWfKU12en4+a/CEk5+22+yF7wtzjPGXC6AiqCdrZUSektszrlqrxpmwrp7S0XvuIgL8hVrMcUhexE9QKE14hKqequogVM6wkxDK32Bim1syrGLP9l258QTd4AM5ksXlLAuh5/7D4f8I8hXOy0t+n6cjjFKePXgdrjOLL98tSvnmDuQ2Ct1bk2tQjBZwNAvj9hKvXBRyAtQuzH2836Y/CQ7QkpHCix+a5gkaMW+d9cnZyjb6aABot1TkJU9J5iEMCAOgwk6j3M/h7BDT2kqQQr4POKP/9RuAtlkzLYoAsfwyf0Co+zY23q+tUYItBZFXif9YAyKNty4up/F29dLmTnS762GZE2sYJHKysHU3w7OXmPhF2fMLf1lPDCwvoPFN4FItuJ8TickLynBFUMKqLLrD2M8PSix2NHmTxKbFSFSf4NORwdK1OjmYh8bg5vsdF+O+efQnJWVMkNNzFpuzK68RJGdi7AwyzI1Evku6J5EN4D9BqKNSWHK47tl79fvtp1SVJsV5tFsjOowg8K2aZJ9kaDT7L85vbyTVkNGpNDO7nRLGrnMjh+bDvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGtZNHg4blRnQjJodzFUVkc2R3Z2bmlrVDYwWlhnNWpaeWRzKzBhR0lFSmN2?=
 =?utf-8?B?RW5HdDA0VFdCaUxiZXVZWXJDeFpOa20rYWxtck5FcFVUTG9TTG95bUlIS01w?=
 =?utf-8?B?MDdyYWNxek5SdDFzdkI5MWZWc3dDWWtqTjV3WTJMVWhWOE1NM3hqM3Y3ZnYr?=
 =?utf-8?B?cFM2WEg1a1BYMkVOdkFteURmbWRZTkZVVk1Xb2ZLRFFUK1JEKzFWalF2YnBR?=
 =?utf-8?B?QzZEMnFzU2RjaUpKU2dmNjBYYXlHdzJ2QjJzSUlKclhxaEtsQ2dOSHhobXgz?=
 =?utf-8?B?QThBdWdIcXlHVW9JWGhubk0wUmxjUTBNNHE0cm9WYUV4OEt1LzVheURnVUpN?=
 =?utf-8?B?aXUwZ2NRSkJkdmhZeHBhSkxLb0YvNGl6UkpRankxRFBQN21GQ3dFR0Q1TkJL?=
 =?utf-8?B?MEltSUZkcXN6b1ZnNVg2RnA2aFNOazBCSWtTZkdMdmJadDJZY01ScVpUdi9j?=
 =?utf-8?B?UUozTEduWE9wa0hYaS9vQU5ocHdteDJJaTQwSHVDaXpja3kvYlZLRjhIdFVk?=
 =?utf-8?B?WHUwMWxwdmhQUHdpbGtJNTl2cWN5andZMmJRVVZqMkZKUFhiNHNJMW5qYW9y?=
 =?utf-8?B?OXYwOXF4RjkzSkRUVmI2T2FnSlpza2lUbFRCWlFoMjlFUjFwODZ1dDhPUVQ5?=
 =?utf-8?B?QW8vTEFhaU1vZ2VZeFM5VjdPR21yZGZVWW5qWCswMm5NU0dtY2pYQzRZK1FL?=
 =?utf-8?B?aXE1RkluUTZZSVFoMW5YMmJxMG5vUUt2bkNzSkx0dTFFbkUzaDh0MjFPOVFU?=
 =?utf-8?B?Ulp3Y2lrYmx4V2VOK3k1Ry8vWHpSVzlaR1dTSFZNSDBtWmgxYkJYdTNPMXVa?=
 =?utf-8?B?SVBMdGNOVTkwS1RCZG1yVzllU0hCS0xDRUNEaUNXYUlEZG5PZWdwRjFzZlJF?=
 =?utf-8?B?WlZHSllnZkVOZzhLdi9jdFllT3laVDFQVlVPT0kwS3phbjZ4alErbW4vSEdE?=
 =?utf-8?B?R0FCYVordGNsYkNOMEx2RjhFR2JZcWQ4UzNwcmZGekZMYk1uOHBmMGNXUTdJ?=
 =?utf-8?B?TVpJSENHaVlJc1l6SzJOQkIxeGcxak1pbldOc01TOCsySGk1N3JpZTVCTUY4?=
 =?utf-8?B?MStSblErMXlaRzNMNGFOWmk1YWNOdUJ5YTBxQUFoNG9BM3VYQ0NQZDNTalc1?=
 =?utf-8?B?UEpwNlBvY2NMY3Y0OGpRMlE2bWlHaWJWQWRQN3R1cmR6bjdOTlZTM2JjRUhx?=
 =?utf-8?B?YUx4aFV1eVk3OUdQRmluNkE2R0dUbzUyME8yMVBsekNKZ28vT0h6cjZhbGlM?=
 =?utf-8?B?MjZhSXlyOHpBSXoxVHJoUkhvdHdwL0FEbjVDTVpuWjNEN1BKS25ZaG51Zi90?=
 =?utf-8?B?TURxcVVRL1F5SDBvejAzbWRjOEVWL0hLa2VZaEdXMkRkTUhiTTVMNEdWVWJ1?=
 =?utf-8?B?UTJFeENsNTJ1M0VibXpRTDdMTHowYmlmNno0S1pjSFJqZ3pUcDJHV2FSSkR3?=
 =?utf-8?B?MTVQdXlwbFc4NU1ld0RPQWpydTZmTWcwWWhLc3BjYWNGU2lNWEc1QWtENk02?=
 =?utf-8?B?KzBpKytyN1dLMnI0azBlMEd2VnNYQ3dRaTNSWlJkWmFMME1JL2s5c2hmZlRB?=
 =?utf-8?B?RWpyK2M0L3ZzQm42VVJ5VjMrUmhIR1FxVFdiZUtlek5FdHhlR1BSUUNOTysr?=
 =?utf-8?B?UlpFYkU2ekV0dlRMdmhiVy9sRE10WThJNVpmblY2dGhQM0IwbmxjbHpkQzg0?=
 =?utf-8?B?eW1rbS80MnB1WElJUUdJQWY4L1hoNXNWVmpOTkJSOEtLSVRKdEVQY3hSZ1hJ?=
 =?utf-8?B?bWtia3VUU28raGxXRmU4MWpRTHdXdHo5NzExWHo4QjNnRitKRWh2eDNyUlh0?=
 =?utf-8?B?SEN2allacFFWeVNCaVVMZmFxQXIvT3N3T2NscktYZjdkUXpRNkFuSVdMRity?=
 =?utf-8?B?b1FlaUFXY2F2TkVLbWVsYkRBME52L1cyQ0dBTEp5ZGFsSDczM1NYVnJPTVA5?=
 =?utf-8?B?Wi9xanVPVnRDaGo5c3dadUFjbW1HVktWU1p0eVAwNW5QOWpQV2RjYkl6dS9U?=
 =?utf-8?B?T1hVQUp5aURFcHo1bk1sVmZ4eTREZVBvNzlqczlPUmlsdGNNaENkZTlkaGpn?=
 =?utf-8?B?d2IzNnhHWU9CODdnV3g4S2hVY3BVYjFoNXk1RHFOQWd2TXgrT1BzRFRDWEwy?=
 =?utf-8?B?WGJ3SlBNNjh3QWt5TithMDVmVitpME1UZ1lXZEdIL0NwTFNzM3dhYWNYVitD?=
 =?utf-8?B?TjJuYU1yY0EvSlZBV2lPY3Y2RThESTZySkhTZElubDh4MmV0UitZaDhud1g5?=
 =?utf-8?B?eWFaMEhIZklBcDFndGpMM2E5emxaWG0zNGdTQXh2a0FweEdCZmRXUmNkWTJ6?=
 =?utf-8?Q?+ysZV02uGFgUrqy8+v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2252696f-bdfd-4462-aa96-08df03d3ef36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:41:29.7776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lFx4hUTzeHTyJuEXv9zGOaokmZVAlGlh2Ty7vb5Oh/67YS/VkD7NKN9xfB6rq3bcMqTI6QdgQ9WFz2rQahfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Introduce a fixed BAR fw_cfg blob exporter that serializes PCI
device and BAR information into the "etc/fixed-bars" fw_cfg file.

The blob contains an entry for every PCI function with memory BARs.
Each entry identifies whether the device has a fixed BAR
configuration, and fixed BAR entries include the configured address,
size, and type information.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build          |   1 +
 hw/pci/pci-fixed-bar-blob.c | 291 ++++++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar.h      |  60 ++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 hw/pci/pci-fixed-bar-blob.c
 create mode 100644 hw/pci/pci-fixed-bar.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 44b94a24b4..5d975f27ef 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -18,6 +18,7 @@ pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-validate.c'))
+system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-blob.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pci-fixed-bar-blob.c b/hw/pci/pci-fixed-bar-blob.c
new file mode 100644
index 0000000000..d60ee65bf4
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-blob.c
@@ -0,0 +1,291 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * Write validated fixed-BAR device info to the etc/fixed-bars fw_cfg blob.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
+#include "qemu/error-report.h"
+#include "pci-internal.h"
+#include "pci-fixed-bar.h"
+#include "pci-fixed-bar-validate.h"
+
+typedef struct {
+    uint8_t  bar;
+    uint32_t flags;
+    uint64_t addr;
+    uint64_t size;
+} BarInfo;
+
+/* One PCI function entry to be written to the blob. */
+typedef struct {
+    uint8_t  rp_bus;     /* primary bus of the root port this device is under */
+    uint16_t vendor_id;
+    uint16_t device_id;
+    bool     is_fixed;
+    GArray  *bars;  /* array of BarInfo */
+} DeviceInfo;
+
+typedef struct {
+    GArray *devices;
+    PCIBus *root_bus;
+} CollectCtx;
+
+static void collect_device(PCIBus *bus, PCIDevice *pdev, void *opaque);
+
+/* Visit every device on this bus, in devfn order. */
+static void collect_bus(PCIBus *bus, void *opaque)
+{
+    pci_for_each_device_under_bus(bus, collect_device, opaque);
+}
+
+/*
+ * Primary bus number of the nearest TYPE_PCIE_ROOT_PORT ancestor of bus
+ * — i.e. the bus the root port device itself lives on, not its
+ * secondary bus. Falls back to the host bridge's own bus number if bus
+ * isn't under any root port (e.g. a device directly on the host
+ * bridge's primary bus).
+ */
+static uint8_t find_root_port_bus(PCIBus *bus, PCIBus *host_bus)
+{
+    PCIDevice *parent;
+
+    while (bus) {
+        parent = bus->parent_dev;
+        if (!parent) {
+            break;
+        }
+        if (object_dynamic_cast(OBJECT(parent), TYPE_PCIE_ROOT_PORT)) {
+            return pci_bus_num(pci_get_bus(parent));
+        }
+        bus = pci_get_bus(parent);
+    }
+    return pci_bus_num(host_bus);
+}
+
+static void collect_device(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    CollectCtx *ctx = opaque;
+    bool has_mem_bar = false;
+    bool is_64bit, is_pref;
+    DeviceInfo dev;
+    PCIIORegion *r;
+    PCIBus *sec;
+    BarInfo bi;
+    int i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (r->size && !(r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            has_mem_bar = true;
+            break;
+        }
+    }
+
+    /*
+     * Every device with a memory BAR gets an entry, fixed or not — not
+     * just ones with pci-bars= set. This preserves the exact device
+     * sequence CheckDevice() needs for positional VID:DID matching (see
+     * collect_all_host_bridges()); only fixed devices carry BAR records
+     * (dev.bars stays empty, dev.is_fixed false, otherwise).
+     */
+    if (has_mem_bar) {
+        memset(&dev, 0, sizeof(dev));
+        dev.rp_bus    = find_root_port_bus(bus, ctx->root_bus);
+        dev.vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
+        dev.device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
+        dev.is_fixed  = (pdev->fixed_bar_addrs != NULL);
+        dev.bars      = g_array_new(false, true, sizeof(BarInfo));
+
+        if (dev.is_fixed) {
+            for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+                r = &pdev->io_regions[i];
+                if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+                    continue;
+                }
+                is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
+                is_pref  = !!(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH);
+
+                memset(&bi, 0, sizeof(bi));
+                bi.bar   = i;
+                bi.addr  = (uint64_t)pdev->fixed_bar_addrs[i];
+                bi.size  = r->size;
+                bi.flags = (is_64bit ? QEMU_FIXED_BAR_F_MEM64 : 0) |
+                           (is_pref  ? QEMU_FIXED_BAR_F_PREF  : 0);
+                g_array_append_val(dev.bars, bi);
+            }
+        }
+        g_array_append_val(ctx->devices, dev);
+    }
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        return;
+    }
+    sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (sec) {
+        collect_bus(sec, opaque);
+    }
+}
+
+static gint cmp_host_bus_num(gconstpointer a, gconstpointer b)
+{
+    PCIHostState *ha = *(PCIHostState **)a;
+    PCIHostState *hb = *(PCIHostState **)b;
+    return (gint)pci_bus_num(ha->bus) - (gint)pci_bus_num(hb->bus);
+}
+
+/*
+ * EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL's CheckDevice interface
+ * (UEFI PI Spec 1.2 Vol 5) only passes VendorId/DeviceId/RevisionId/
+ * SubsystemVendorId/SubsystemDeviceId, no BDF — so in EDK2 we can't
+ * match a blob entry to a specific device directly using BDF. To work
+ * around that, we prepare the blob entries in the same order PciBusDxe
+ * discovers devices, so matching by VID:DID inherently works.
+ */
+static void collect_all_host_bridges(CollectCtx *ctx)
+{
+    PCIHostState *hb;
+    GPtrArray *sorted;
+    guint i;
+
+    sorted = g_ptr_array_new();
+    QLIST_FOREACH(hb, &pci_host_bridges, next) {
+        if (hb->bus) {
+            g_ptr_array_add(sorted, hb);
+        }
+    }
+    g_ptr_array_sort(sorted, cmp_host_bus_num);
+
+    for (i = 0; i < sorted->len; i++) {
+        hb = g_ptr_array_index(sorted, i);
+        ctx->root_bus = hb->bus;
+        collect_bus(hb->bus, ctx);
+    }
+
+    g_ptr_array_free(sorted, true);
+}
+
+static uint8_t *create_blob(CollectCtx *ctx, size_t *blob_size)
+{
+    QemuFixedBarsDevice *dout;
+    QemuFixedBarsBar *bout;
+    QemuFixedBarsHdr *hdr;
+    DeviceInfo *dev;
+    uint8_t *blob;
+    uint8_t *ptr;
+    BarInfo *bi;
+    size_t sz;
+    guint d, b;
+
+    sz = sizeof(QemuFixedBarsHdr);
+    for (d = 0; d < ctx->devices->len; d++) {
+        dev = &g_array_index(ctx->devices, DeviceInfo, d);
+        sz += sizeof(QemuFixedBarsDevice);
+        sz += dev->bars->len * sizeof(QemuFixedBarsBar);
+    }
+
+    blob = g_malloc0(sz);
+    hdr  = (QemuFixedBarsHdr *)blob;
+    hdr->version     = cpu_to_le32(QEMU_FIXED_BARS_VERSION);
+    hdr->num_devices = cpu_to_le32(ctx->devices->len);
+
+    ptr = blob + sizeof(*hdr);
+    for (d = 0; d < ctx->devices->len; d++) {
+        dev  = &g_array_index(ctx->devices, DeviceInfo, d);
+        dout = (QemuFixedBarsDevice *)ptr;
+
+        dout->vendor_id = cpu_to_le16(dev->vendor_id);
+        dout->device_id = cpu_to_le16(dev->device_id);
+        dout->dev_flags = dev->is_fixed ? QEMU_FIXED_BARS_DEV_F_FIXED : 0;
+        dout->rp_bus    = dev->rp_bus;
+        dout->num_bars  = dev->bars->len;
+        dout->reserved  = 0;
+        ptr += sizeof(QemuFixedBarsDevice);
+
+        for (b = 0; b < dev->bars->len; b++) {
+            bi   = &g_array_index(dev->bars, BarInfo, b);
+            bout = (QemuFixedBarsBar *)ptr;
+
+            bout->bar     = bi->bar;
+            bout->flags   = cpu_to_le32(bi->flags);
+            bout->address = cpu_to_le64(bi->addr);
+            bout->size    = cpu_to_le64(bi->size);
+            ptr += sizeof(QemuFixedBarsBar);
+        }
+    }
+
+    *blob_size = sz;
+    return blob;
+}
+
+/*
+ * fixed_bars_write_blob - validate fixed BAR addresses and write fw_cfg blob.
+ *
+ * @fw_cfg:       fw_cfg state to write the etc/fixed-bars blob into.
+ * @mmio32_base:  base of the machine's 32-bit PCIe MMIO aperture.
+ * @mmio32_size:  size of the machine's 32-bit PCIe MMIO aperture.
+ * @mmio64_base:  base of the machine's 64-bit PCIe MMIO aperture.
+ * @mmio64_size:  size of the machine's 64-bit PCIe MMIO aperture.
+ *
+ * Returns true if any fixed BAR device was found and the blob was
+ * written, false if there was nothing to do. Aborts if any BAR
+ * address fails validation.
+ */
+bool fixed_bars_write_blob(FWCfgState *fw_cfg,
+                           uint64_t mmio32_base,
+                           uint64_t mmio32_size,
+                           uint64_t mmio64_base,
+                           uint64_t mmio64_size)
+{
+    FixedBarsInfo info;
+    CollectCtx ctx;
+    uint8_t *blob;
+    size_t blob_size;
+    guint d;
+
+    if (!mmio32_size || !mmio64_size) {
+        error_report("pci-bars: zero-size PCIe MMIO aperture "
+                     "(32-bit=0x%"PRIx64", 64-bit=0x%"PRIx64")",
+                     mmio32_size, mmio64_size);
+        exit(1);
+    }
+    if (mmio32_size - 1 > UINT64_MAX - mmio32_base ||
+        mmio64_size - 1 > UINT64_MAX - mmio64_base) {
+        error_report("pci-bars: PCIe MMIO aperture base+size overflows "
+                     "(32-bit base=0x%"PRIx64" size=0x%"PRIx64", "
+                     "64-bit base=0x%"PRIx64" size=0x%"PRIx64")",
+                     mmio32_base, mmio32_size, mmio64_base, mmio64_size);
+        exit(1);
+    }
+
+    info.mmio32_base = mmio32_base;
+    info.mmio32_limit = mmio32_base + mmio32_size - 1;
+    info.mmio64_base = mmio64_base;
+    info.mmio64_limit = mmio64_base + mmio64_size - 1;
+
+    if (!fixed_bars_validate(&info)) {
+        return false;
+    }
+
+    ctx.devices  = g_array_new(false, true, sizeof(DeviceInfo));
+    ctx.root_bus = NULL;
+    collect_all_host_bridges(&ctx);
+
+    blob = create_blob(&ctx, &blob_size);
+    fw_cfg_add_file(fw_cfg, FW_CFG_FIXED_BARS, blob, blob_size);
+
+    for (d = 0; d < ctx.devices->len; d++) {
+        g_array_free(g_array_index(ctx.devices, DeviceInfo, d).bars, true);
+    }
+    g_array_free(ctx.devices, true);
+
+    return true;
+}
diff --git a/hw/pci/pci-fixed-bar.h b/hw/pci/pci-fixed-bar.h
new file mode 100644
index 0000000000..3afc22a733
--- /dev/null
+++ b/hw/pci/pci-fixed-bar.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * Fixed-BAR — QEMU side declarations.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_PCI_FIXED_BAR_H
+#define HW_PCI_FIXED_BAR_H
+
+#include "hw/nvram/fw_cfg.h"
+#include "hw/pci/pci_bus.h"
+
+#define FW_CFG_FIXED_BARS        "etc/fixed-bars"
+#define QEMU_FIXED_BARS_VERSION  1
+
+/*
+ * On-wire layout (little-endian, packed):
+ *
+ *   QemuFixedBarsHdr
+ *
+ *   For each device (num_devices total):
+ *     QemuFixedBarsDevice               -- device header
+ *     QemuFixedBarsBar[num_bars]        -- one record per BAR (FIXED only)
+ */
+
+typedef struct {
+    uint32_t version;     /* QEMU_FIXED_BARS_VERSION */
+    uint32_t num_devices;
+} QEMU_PACKED QemuFixedBarsHdr;  /* 8 bytes */
+
+typedef struct {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint8_t  dev_flags;  /* QEMU_FIXED_BARS_DEV_F_* */
+    uint8_t  rp_bus;     /* primary bus of the root port this device is under */
+    uint8_t  num_bars;
+    uint8_t  reserved;
+} QEMU_PACKED QemuFixedBarsDevice;  /* 8 bytes */
+
+typedef struct {
+    uint8_t  bar;
+    uint8_t  reserved[3];
+    uint32_t flags;    /* QEMU_FIXED_BAR_F_* */
+    uint64_t address;
+    uint64_t size;
+} QEMU_PACKED QemuFixedBarsBar;  /* 24 bytes */
+
+#define QEMU_FIXED_BAR_F_MEM64       (1u << 0)
+#define QEMU_FIXED_BAR_F_PREF        (1u << 1)
+#define QEMU_FIXED_BARS_DEV_F_FIXED  (1u << 0)
+
+bool fixed_bars_write_blob(FWCfgState *fw_cfg,
+                           uint64_t mmio32_base,
+                           uint64_t mmio32_size,
+                           uint64_t mmio64_base,
+                           uint64_t mmio64_size);
+
+#endif /* HW_PCI_FIXED_BAR_H */
-- 
2.34.1


