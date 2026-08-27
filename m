Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49ECC5DF97
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOBh-0005lh-Ic; Wed, 26 Aug 2026 20:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBg-0005lV-EK; Wed, 26 Aug 2026 20:41:48 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBa-0004l8-Jt; Wed, 26 Aug 2026 20:41:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt6rIBd2Xp00uHOMVoaUNJ/+7kNaidqAF7uGBxdXzJDOqVnevZxTAguBrqX4dRUZlWBajU4TtbYQoNEIBe9r/+ktgPxaXOWC4jPHk9oyFVE0a2b7iH7qfzcQZK6LyCmcQd35+j3N40Xfr9trfB1Gj6sKvVq071YIDlpi11GTnpFTF8J0xP0KO8c0s6ucNiVVNG8OVSaRfPY+bIOMbWTdDp3ob7HCVutbLHvhHXUSb2mCZXBsoBztOrsVeFEE7J+kcbJ/XR+1gYpp0x0monxBGbjfhpumxvw9I6Z5aZD3YSySxa5L5KWMW6rwofkdGESqqYbmrFeo/1JJYIfTCWAHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBM8sM6WxFj712Jpq07b/YyKykJ3L3X2pg+IkhzCYKw=;
 b=klgqokQK31kytM99Ohdg1+n4Pe0dGVysoVffS9eE3u2fiypzMYzps1i8lJdZjQAtYlp6nUZhWrGpiXaSqdaaTlW1nI1FemduQ0oszBQ2jY4eyLOMecY6C3uTk9VunmdWRghTdQQowe5qKhHuVn4F2BOHNjbEc7aB79bljoW7vaT6WSBteXyNf/1g9TGVM180iOwbgwXhsHWVd7S6vpj5/33CkVQG6wzEvfzV9MaY/sXadHdeVoNKHFCBib0lC5INRwZOMmgEZMwsg/y5MY5WOhyApLs1htu5hNJGuoFvLaQtjBnZbPy4bB1rP0hv7fCVSo3i91f/nMTwspWr7yM5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBM8sM6WxFj712Jpq07b/YyKykJ3L3X2pg+IkhzCYKw=;
 b=i4LCjaISlDTOy/yOC+9s+riDuXWawZetQeSzDUuuw4XuxilWgs3Hz9kA/bbr7gru1jzvatFTX3EqsaKFw3BnM/s05N/oszCy4CtlMsLza0Mbe67tdgNHMDuMdqtemlnwK7Un3vLn4JYSydc4GBLdoYVXdg63g0LPLhcaMNNWQ/l+yiGDSzd+jMnsXJj780gBAG47KUQwMQu6QW5rYpKlfeqmeUwgnhVGEuuJd8TyNo/84q1Bvd7UMkWaD3C4fLIcjH7tIMhgvakl5tjEPB5iR7tm8q3sXFNIBU+/n7MYQt6Cb6dW4wQxfET3bT4JDQ5uzcj7lHoYnxw21Mwaklj4mw==
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
 00:41:32 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH v2 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
Date: Wed, 26 Aug 2026 19:40:23 -0500
Message-Id: <20260827004024.598351-5-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827004024.598351-1-tdave@nvidia.com>
References: <20260827004024.598351-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e3e3ed-65ce-4739-b8b1-08df03d3f087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XZSrUah0pTPdGbWWIO1XBl7R3+rCcnPKfa+Yl1wujx/L362jR44TYa2jdeV6NMuSPwFIMVb7tJvy41hlv4M8/A4mkDXlQd0UxeN5/FtLisIAwBrk1mGb7GoT5IGq6LHWC13FZRvNVDiwwdGQ0oSqFa5baufwC6yCwACbC2jgZqlYAD6aLLi3sxQcj7hSFfeIeL1UIl5F7YIc6jJQlOpCFNP7Va2W2G23qi7+HmJrkomguC8hzuPf172nYlYZJmWS5XvtaNmIO7JyQC8diqrylcHP/NmAe0yPoNAqCcV3ey0cOOU52awDSDhF87ina8T/eiQIIzhPZIfo7a6ity/Tw5U9Sw2s1QCEDgnpoDjTDFZEtB01LcHErlpg5FrmH7Yo0gSbDhDwFkmE6u3Vx6CV/aAnWMw3ewNwO5N4R92jDLfrDmSjaUpoF1sJ6cAuDwBgQ52rY+Ta+BeE3VBw0/Kb4TDcU3KZBN8GJFzjmmRw7xkUTDwVS7X/HluArzj5ba3V2EpzYSvDvtx6qIwjbyu4uX9RlNeL7n20jj1wYc/gk9Y8WUB7T7fC82rWGB0jHvRcLe1iOftsvjwzDZQpEEVp7tawPXMs3h0N1AREssOIXuRuXzwVceIq0wSeHKXtjag+GRer2TCq3eLjwqmfIcjsUNCEW9/J9YibE3PVE8OQ28U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Nd/UwveE/wTgOU+cYRg/96RUzt16/hDAo2go3xWh8wTghQnCGzqfL0X9zi3?=
 =?us-ascii?Q?SQVgspwAJxjMYlIf3vbNfrH7hMVDgNcKXUHNe9UeYAyBW8porAUDU5SdY3bF?=
 =?us-ascii?Q?hI+AVpcP3Mfjrb39KQKWaUHV0FJYHd4d1GqC/wEupjR7GNIcDzAakJ+zkyMs?=
 =?us-ascii?Q?lNL6mI8St0euxshlcxWj0Il1ttMSnY7K6JENKjs5HipgbghNaFy8d1DuLRTk?=
 =?us-ascii?Q?a4ecAyVQx0DR/hKIsCXNFuflPQ9hOTUxif0j2Ttcv4LZ9P7rstSXeZhdoT4A?=
 =?us-ascii?Q?CnGK3Vi5ReF3xaVLZRrUBYjoOyyyxloerbodI5Ni44OWU7+bdrOPY7AgLq0B?=
 =?us-ascii?Q?8Qn5h+hiC6bwfD7PYWHK7OSBgPDfULUmXaM7umdQCtN1zh/fbSBX4DQ+fzP1?=
 =?us-ascii?Q?DMIL5t2uRE7/AURbPrE0zFq518HjhZgkn5kExlYqRioMsWYL/2LSCOQWAUVI?=
 =?us-ascii?Q?l26lMzB7Yr+IPLfTTw0PlHtIzRIktsyub3tc4DhRjfMJ9Zu+A15ZvLExvh0z?=
 =?us-ascii?Q?GPL42Ugbm4nm4wjEbAduiKRwr8OnG8BivFCiLSYjYLT+Mn9XjKBr0O3mhit1?=
 =?us-ascii?Q?TM+WeJuIbkxi9h6uv5D++GzkAyvi864V5x9o0Di7b0IfvYCdFkkFGoMw8TrM?=
 =?us-ascii?Q?7I3BkGQArUpHk7r5dIhreEMZNnd35Xihsj3BKwGogFPJ0/rzP37ndKL8rqaj?=
 =?us-ascii?Q?5F0p83OTGcUZl8GjB34qFtFN3TW6FEvlqcd6+ibQm+sHRl89lTDF3ijxLCkU?=
 =?us-ascii?Q?wOKAovzKMZnSfZnFZepx0gsWjiQ6eb0jwhpiuB2qOyZT4kELpSo+NnoZHZr2?=
 =?us-ascii?Q?XBm6R7Oo+HqKkRUZoyXITn/NXnYMi6DgMzwrbq43USXMa9PIkjtPRVnUuCgy?=
 =?us-ascii?Q?G15xgRrOnKFDPG1feDkLX/7s4SoIBSeuJzGgyWolj/8pIhJbn+ROOREv4mpr?=
 =?us-ascii?Q?+n3DBybgeBbYqBzWRZmarktlVijALfpDlKqIjPMxgy9W2LjHg4ZKbleJ8pMV?=
 =?us-ascii?Q?aOE+S4pJdvmn/uxVI122B73JeVfYMytCv3FljLP4l7yOqv87vlmTDcDVKYAL?=
 =?us-ascii?Q?V+9oHaszqiPZsrX6NNe8Bnayyj1S7S9S0WDOZ/V2BItVXT4WzvOAFvm7SSh/?=
 =?us-ascii?Q?OGFaQ+AAFLm30DABXf4ePgVNbmetNZtrpoCq8ciHEezssAF1F9ZSnAAfndZG?=
 =?us-ascii?Q?Mz+Fpjz+RuSNQ+6NuHuraCEqMUBKo5+4MqehpjkB/Cc/OxjW6yd1y0VtbM8E?=
 =?us-ascii?Q?2kv69vA+uQWGT8olD4o7R7Ydev1w0uIr46n+eU2nxM8DPjEegA05AXBmas/C?=
 =?us-ascii?Q?QX1sR9rg5N8GRGE/1mO3+1Lwum6QhI/75pL7ixamZDfWceZqhuDm1N20Zx5s?=
 =?us-ascii?Q?eksO2y1QmlXogLHabYhD6VTcq/lhhpKZ3xtMsrbiV9RhgPDxzZuLBpUNJ03G?=
 =?us-ascii?Q?9RqTfw9+0Sz9DyDPXVEXMsCpfC/+a/W2TmLgcs+EyyD7HCBtRaflDCLkwtIE?=
 =?us-ascii?Q?sEUWMdyxxEmpuS6wdQm+4YZ0Ws+OxmU2uu0O07WtM426jJLif9AvBZ8L3YUO?=
 =?us-ascii?Q?LghoN6FP9bcCaUhvEeh5u3pqEBFgne4CoMzfeTCe4lxGyDlQ9+quOKJ0pAo8?=
 =?us-ascii?Q?W2aw6mib+tU8Aq7Ot3lYtUQwXaFaJiws4Dspj2hMYf28sxtbnAzMt+jkMusR?=
 =?us-ascii?Q?2yy1osPVWjyKKdxcrGaJkhGTvwqdnvA/EOXarqbFTxfhDJer?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e3e3ed-65ce-4739-b8b1-08df03d3f087
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:41:31.9280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xI6fbpMkZWowUapbStZdmx/CnfhNwlSRnYPTG+SmZlZ5y71i5HKKLb4e1tf3JlyEUEkYYeZiMSHpeDJQFT+IYg==
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

Export fixed BAR metadata from the virt machine through the
"etc/fixed-bars" fw_cfg file during machine initialization.

Fixed BAR placement requires firmware to preserve the PCI resource
configuration established by QEMU. ACPI provides this via the PCI
boot configuration preservation mechanism, _DSM function 5.

Reject fixed BAR configuration when ACPI is disabled, and request PCI
boot configuration preservation when ACPI is enabled.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e7a56e37f7..cb9cd2d25c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -96,6 +96,7 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "hw/pci/pci-fixed-bar.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -2440,6 +2441,21 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
+    if (fixed_bars_write_blob(vms->fw_cfg,
+                              vms->memmap[VIRT_PCIE_MMIO].base,
+                              vms->memmap[VIRT_PCIE_MMIO].size,
+                              vms->memmap[VIRT_HIGH_PCIE_MMIO].base,
+                              vms->memmap[VIRT_HIGH_PCIE_MMIO].size)) {
+        if (!virt_is_acpi_enabled(vms)) {
+            error_report("pci-bars: fixed BAR placement requires ACPI to "
+                         "preserve the PCI boot configuration, otherwise "
+                         "these BAR assignments could be reassigned later "
+                         "with no protection");
+            exit(1);
+        }
+        vms->pci_preserve_config = true;
+    }
+
     if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
         exit(1);
     }
-- 
2.34.1


