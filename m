Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D18EC982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uoA-0006US-52; Wed, 16 Sep 2026 14:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unu-0006SN-8G; Wed, 16 Sep 2026 14:56:22 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6uns-000632-3t; Wed, 16 Sep 2026 14:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyIcnmroy794SCYMFifSYpjtoX9Zm6F6sKizy+Ew0iBKYcNKiEo6YTmO5L7knEqxmSDJVyuwpyGYs9M1O45dmDBKSzv+Q4OKD/1r60d1EKENy1gIh/wgf3FbOAywsP6hXzRwjuQ1fxP7wuzS9Dh/2dImkn13AEYo1sWQx7X6QVz8s+0BhLyDyh1nmi1yG1YW+0GYwL+n4V0Zvpqd6pT/ZW8cLxbScjRw82Eq8qoY+rR94jblSGDiGJYCt5JubSFO4Y+F/WZrnxGcD1YDR5EsWohhGf198RegHTjs3KewrGHqQZn2BMDExFx4g2wXerQFybNb2nal5uwD2HMcPJPyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSLoSpRui0ziPYPZZjwgu4Ce6IyROzULGt923nTUiJ4=;
 b=zQH5zOlWL2XZ8nqcsh2QjULla8TGTNWbLcwBiH/IVlOhwd56ZihUZHzzAAav8IU262smOqsuMjOIFB8Lr3ElH7YFSKTxNLTUE/ELUKHQL1e1x4ISdNv99gN/vukUvdm+i7KCZcKsaLTdj5l/C/JrlnB5Bqt0AwhGXAJQOYauPAsQrRQI7Z/JupGKgT02ZD451OiUHPckoCTnmwy5m3HtcVrBH3GBtVTZ140KL8Q1C9yWkj7ryk1mMPbOc5kyD+P676O9ggY9z0+NAfwSaPLMjtMk+U7Xdzr9gCo5wS3aSLdtdNRZp6a3VOcbd5PXK2vH2jAEnl4sq8SxSo4XhL7Dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSLoSpRui0ziPYPZZjwgu4Ce6IyROzULGt923nTUiJ4=;
 b=DRDs66NJ3lwRPcw4t+QbSrKiDCZS1Ul0a38s75+f7dKe9LAvr3DS99DYDAoZ4/U7s3Y/OI9q96m3fn64x/GGvVKWEHT2UTsDW0gQZLYZHTuXR6z08J0zwkzAf0dRMCqV6aOoNjsODHqDO8j7+XaiFNwEhrmY37CAJ56SBW3ijRn0wNDfcuCgoKKqo8llrvr+UhttfZ8SKL4tt5fNfSyQHJQXENH/9cbJ/Yb+sX0d6LAsye8L+k64Pg2W2p2NHkKbfzxPYyrSbB0N/CzeDrOOSoZZXRkInh/1V1FmY3heh0fSngn1vqOSl8vRdxTmkRNPu3Pdjj5PY71Cp0uXtgLALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY3PR12MB9631.namprd12.prod.outlook.com
 (2603:10b6:930:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:56:06 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 18:56:06 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 3/5] pci: add fixed BAR fw_cfg blob export
Date: Wed, 16 Sep 2026 13:55:52 -0500
Message-Id: <20260916185554.917526-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916185554.917526-1-tdave@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:806:28::7) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ffa120-2c8d-44dd-87cd-08df142429a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: uVBjKRzOSwEOXD+r7+9cN6LikblWWUK8shyTM1DlOuLv7V4GDmPzLc7JWRzbDW80mtSJKFT2fCajWGLnnEslBB6xPrXaead/9efZCTolLGFbcxEiBwMPibBU0qie4I6HiFCV4pNcU9C5nMM+CXKVJbQvva6l3PLRrCj1PPKYZQNT2ECwlbh3SfxhZHAMOd9LbxPg06wxfNqjMUZE6oEGGmr9fcDNnXGf0D1lSwzTYmhz39BBrGg0jNtj0vGJMXYo7O0ba7/ARBNNvXIaq1hmHRBgr0guVAgFa5mW+rCBW/LmLutkQXXzM13+w3KrrI2+mOcJa8avQUyt1qgyvOcVoV4MUlDKBufG2DgbSbdnIdjS5CE2ZIs4qyuKHGmzXPYpOfibSw6n6Jmhzkcrf0uJ5TV+YmTh/iDGwyuZPMOiegWgCs15lQcK1QWSIMxxWJ7fS/y0DBE3ZTccioetIJ7RBhRMW7lDGGI0oZvrA4CjotyqUAL8DMxmjdamRjQ8p9VqhbFWCLyml+Gpa1oKqqdttpU9w9HNJIRLtnw+gnpg3CaHKh83adfY/QXI9hbmk4LsBM5qNMLKyChTR7lXLOKQydL+gigkVxBqXedQu0vaFabg1Anbdj9PVxCd6EqIXGPq8fx9E1yxAd7wJKVJ/Bx43XF8dM1qHN6XGWTdRVXbuM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azFKREs4dEVpU2JhWVdHeU1uTlh0TUR6Q2dZbnE4UU5QRTlMZjdjNWpLWDRO?=
 =?utf-8?B?am5USklEU29EUitQM0dWWjIzcEFaaXhvNDN6VGNoRDdjbWl3TGgvQTVtV3ZE?=
 =?utf-8?B?aU1rRko1SFYzQXUzZi9nQXVKWTB1T2lmMGpwM1ZIUUJ5WFJkZGpHTGhmNEpq?=
 =?utf-8?B?U3Njb3kzbXA0YXZGdEdKTUd3UDZHK1BCcGZ6cDRzM3RBaVZ1SXJFaXpieW9Y?=
 =?utf-8?B?WWZxZWYrQU0rQ0Y3MXFjTWYrS0FvNnJuaGVMWEFsVW1mLzh6UmdiYXY3cmRH?=
 =?utf-8?B?Vld1cWQ2bHV5eUYyZVltRWpZcjZGZ2RING9ZZ0FVZzdGRnkxUDNLdWo4d3Y4?=
 =?utf-8?B?b1AyMzhGZjdVS1RhSlg4UERoVWprb3g1RUVjb0hYVVc1UFh5ekFiYlhFdnZY?=
 =?utf-8?B?TCtaL0NFZ3pwcnM2bEQ5eFdEZ1lsYmZ4UjZWQXg3UzM5YjNZVEduSDdWUzdl?=
 =?utf-8?B?M0dVa0NoSkJUMEdoOW04WHRuYUZRQVZNa1hQd1UrODRGclljaHNkRDBZSWVp?=
 =?utf-8?B?RHVYVW54bGtjS3lSOFR1NUY5RUNkMWJWdE92b2xvZzc2TCtZeHRBS3grVnRx?=
 =?utf-8?B?QmRidTVLTVNGbENXbDNvTFZCZVhzRVR1Ty9FVHFrL0dOOHd5eXVUKzlDVU9Z?=
 =?utf-8?B?YWc1TkVCNUdka2dvL21HOHJ2WmwxcjlRUTRrcWJjeHFMQnE2K0JNNmVUU1dY?=
 =?utf-8?B?YnNsZ3UrOVdRYXY0SDZ5YWZ6NkM1eFp1OHpiV3hEWWQyT3VJbEdMdzJNakVY?=
 =?utf-8?B?SHdBVnZ4VzFQZHh2STRwUnk2Y0RLd292SDRkaE8vZEh1NktITWtKUDNROXAx?=
 =?utf-8?B?Q3ErR2FYUzcwclNEblBteTZ2M0pDakhRcW1OdjdxVVlpRjJZSzdpbXcvSXFj?=
 =?utf-8?B?RDFyd2h6alNlRmY5Nk5peFR3ZWYvYkpkY3pMblZkcWY2ZExYUFY1QjB3cTdk?=
 =?utf-8?B?dng3bkk5R0hqdEVwVlExeVZLZGxBWVI1UmR4T2pJN09iemVNdytrQ2krOFMw?=
 =?utf-8?B?RG93WlpRVDVtaHdzL1dxQ3BJb3FRamR1MGN1K3JlOWNTMXo1ZE9DdHFYd3ZO?=
 =?utf-8?B?M0FFSTNFQ0NmVGxFYUVqd3pzZEJxN05sOUJxYlhUR1J5MzJSS0krMzVnM3Yy?=
 =?utf-8?B?ZStxbE1wVmYyb0UySmF1R0x5U01iKy96aEhqd2doK2pXUkNwYlBvdG5pOEF3?=
 =?utf-8?B?ZVE4NVlTb1FFZndPOGZWSjBNbWpTZFdOc0lPVDhOQWI4aG9NU2JDNkhGeWhK?=
 =?utf-8?B?SzFVaVRFSGMvRkMwTHdBeUI2Rks3NkZoK3pLMHF3ZHNwTUhFTUJLR0xWNldq?=
 =?utf-8?B?N1YyUTh6WWVOK0ljSGNUVmRVTWVYK0J3cDdvREc5eHI2amY2djEvQWFDZVpL?=
 =?utf-8?B?a2xTM0ozaTlVaExOTkZ4VU9ZNXh2Uml5UzFjYkF1RnBLOU1uS29QWmcwcDNy?=
 =?utf-8?B?enlYWlI0eHNqdEEyYlRjaWtiM21KOW9IRDNMQWpQeWlQUEE2b2JzQWhpd0Zq?=
 =?utf-8?B?SEdoR1dBM1RCTnlWdUZsL0F0T1JjaWNaWWVIUEtNVXozd0ovS0Q3SGt6L1Vv?=
 =?utf-8?B?dk8ybTdNckF3eGVaeHRURFNmNmRoS2R6aGNWa05ISWZXcHVJdVF3TmpCc1Q1?=
 =?utf-8?B?NVk4NWU1MEpPekJRM2FYdTRKVXFUWmpoVlhHOVNKQ3cwMFdJNGJVbDlOQnBS?=
 =?utf-8?B?YnlmQWRtNlFVNWVIZGs0WWs0a3Nubm9qWnpXMXhqc3FQdHAxYW4wU3J6RlZo?=
 =?utf-8?B?enJDSlpTVWpOYVdsM1QxTE5IOWhoVEdqdGY0TXNNVkQzN255QVM1Zy93dk9H?=
 =?utf-8?B?RFRZVUZiMGhtNmR3TytxUTN1Tm1GNzVjeHUvYzdzN1pCSEdlSnh4SEFOTnpt?=
 =?utf-8?B?SCttOVlHbnI4RTRCa3FGT25IWEtLN2FsUEw1Qlk4em9wQ1FsUkhER3FadDBt?=
 =?utf-8?B?NFduRTZUR0lvUk5iLy93Y3ZqeE50NmhMNjdZWWQ1cjhIcmhRbXQvekt3ZlR1?=
 =?utf-8?B?S0ZKSmx4SzJuSFpsL29ZRWlGdkZybDFDSXNmcmtkaFV5UWJzc2JGTm5QUWhp?=
 =?utf-8?B?WDFyTkpjaExJaWgrN3krc2hDMjRWakY5RUx2bGhnVE1aZVBONDNPTjhvS1dh?=
 =?utf-8?B?elhmeTE1UUpoWWczblJIUC8xVTJnRE9TN2VnbXhLdFo3ZXQxZFFRaFNQcnF5?=
 =?utf-8?B?bVhxUExabS8xc2hIVm5zUDdXRmcvYUErNE1EYmk4ajZRUGdFYXg3bWc1QU54?=
 =?utf-8?B?Tnp0dlF0M29RUkJ3elVDZlRJM1lSZXZVaGZ6S0tKMFB5dEVCZHh6Znp6Z3Z5?=
 =?utf-8?Q?yrCxCCK3TjceayArel?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffa120-2c8d-44dd-87cd-08df142429a8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:56:06.0785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpcN7zynpr2keT0X7z673U5CFqjprozlVdu+FQB9P760s21XUoZqe4xOqiaoWJLrupjB0w5x2UDudDcRb8muDA==
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

Introduce a fixed BAR fw_cfg blob exporter that serializes PCI
device and BAR information into the "etc/fixed-bars" fw_cfg file.

The blob contains an entry for every PCI function with memory BARs.
Each entry carries the device's vendor and device ID, whether it
has a fixed BAR configuration, and its firmware device path. Fixed
BAR entries also include the configured BAR address, size, and type
information for each BAR.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build          |   1 +
 hw/pci/pci-fixed-bar-blob.c | 305 ++++++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar.h      |  63 ++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 hw/pci/pci-fixed-bar-blob.c
 create mode 100644 hw/pci/pci-fixed-bar.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 150085c997..b81cc056c0 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -20,6 +20,7 @@ pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-validate.c'))
+system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-blob.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pci-fixed-bar-blob.c b/hw/pci/pci-fixed-bar-blob.c
new file mode 100644
index 0000000000..b9fdc6b7d4
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-blob.c
@@ -0,0 +1,305 @@
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
+#include "hw/core/qdev.h"
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
+    char     fw_path[QEMU_FIXED_BARS_MAX_PATH];
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
+     * just ones with fixed-bar-N= set. This preserves the exact device
+     * sequence CheckDevice() needs for positional VID:DID matching (see
+     * collect_all_host_bridges()); only fixed devices carry BAR records
+     * (dev.bars stays empty, dev.is_fixed false, otherwise).
+     */
+    if (has_mem_bar) {
+        g_autofree char *fw_path = qdev_get_fw_dev_path(DEVICE(pdev));
+
+        memset(&dev, 0, sizeof(dev));
+        dev.rp_bus    = find_root_port_bus(bus, ctx->root_bus);
+        dev.vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
+        dev.device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
+        dev.is_fixed  = false;
+        for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+            if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+                dev.is_fixed = true;
+                break;
+            }
+        }
+        if (fw_path) {
+            g_strlcpy(dev.fw_path, fw_path, sizeof(dev.fw_path));
+        }
+        dev.bars = g_array_new(false, true, sizeof(BarInfo));
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
+                bi.addr  = (uint64_t)pdev->fixed_bar_addr[i];
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
+        memcpy(dout->fw_path, dev->fw_path, sizeof(dout->fw_path));
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
+        error_report("fixed-bar: zero-size PCIe MMIO aperture "
+                     "(32-bit=0x%"PRIx64", 64-bit=0x%"PRIx64")",
+                     mmio32_size, mmio64_size);
+        exit(1);
+    }
+    if (mmio32_size - 1 > UINT64_MAX - mmio32_base ||
+        mmio64_size - 1 > UINT64_MAX - mmio64_base) {
+        error_report("fixed-bar: PCIe MMIO aperture base+size overflows "
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
index 0000000000..0d4e31b301
--- /dev/null
+++ b/hw/pci/pci-fixed-bar.h
@@ -0,0 +1,63 @@
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
+#define QEMU_FIXED_BARS_MAX_PATH 128
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
+    /* qdev_get_fw_dev_path(), NUL-terminated */
+    char     fw_path[QEMU_FIXED_BARS_MAX_PATH];
+} QEMU_PACKED QemuFixedBarsDevice;  /* 8 + QEMU_FIXED_BARS_MAX_PATH bytes */
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


