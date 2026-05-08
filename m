Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB1CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5Q-0006hT-QS; Fri, 08 May 2026 14:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5K-0006fz-WE; Fri, 08 May 2026 14:38:04 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5I-0002Yg-Pp; Fri, 08 May 2026 14:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6vU6OVid0/K/O7U0+6y/Jz67LTbJoC1Jwor5p2QXbWAcrZEgYIo+gV9BZigATZmqnU+NAsScNEwBko8LmynNl1QoqzyvDjte5o7khOI2/4izSMHJ9pDFtUii5phLaENEVIOhygmHZ1exbGzFGjjtvlvMlTcWn7NcYyy39nuFdWW96COZivix1fRMyqpjOeXsbRNcWoFNQpcmYoBL48/eqjjvnOdonKdYKK3C9jPm2hF9QDEsH2FzQZjDPJZkQhylw1Gck+216g5F4TMqqd/yvXCoIcNza+VD1K6+8bEpCwAc/wFlPsNCN/aOtjLLZKrPDrxwDveJyowRvVo7xGlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqE/IoyY03xAlx51xRPj7NQYnIAcmcFFJKBlXu8boSc=;
 b=MVhntnwdiaAV8ZCA0S4FxH3zK11L9cdCUld/+QDBim2uab9ub86prTXw3Wb5FT5JIqA4VVsFiTnUEEr3UFkqmAgu5wbvMtjYive6oriXyV4L38H83LbGU8PiBivZkq5U8mfqIYd7+k7GVziAugPZSl3GOuWc58nSrguQPj0V/VAuIP1UOZAEFiVKIjGtKyv9j3cy13dOUqX40rAr/YXblLD72mipuh6XPDLXSYUyj0XBSw4qDSIJ/IaKtqvMQK4B7UF4GcPnPTaabc2BysrZmtIz1ES8hRPq6XxG9Rpysxah71/ubhZsgDCVeRWbJmfiwx9zGXgV3guNY0Nry39RDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqE/IoyY03xAlx51xRPj7NQYnIAcmcFFJKBlXu8boSc=;
 b=uqoaK8TARKmErb2fLWt1zZkhm9NKtpAF+nuWMVdbJFySR1eRfEUnZGd3jZtcVvY3WmNANXAUJe63bl0rR1hSBBbMAtbN1ab7jJeJ1vHcjKASfJOX4CPrhul4q/8Ksiig/09xlxf/iK8X22fn9hWRHi0uXNwcgrNL0V3COt/UdF6NmWtLs8apSsUO0UZ5hgrzQaHiouwbLMInNhvdv3f6+oQs/6qpTkyaySpczS03HbVl+JPsGF6ggYhss3MSTjLrN2U2T+OEuugzaP+cjHycYuTldpaKe8Ix4wNi/ulmGM5g00hjOZ9f01rqQA959grg0p2tlxt24pcv7A8uUJ3Vww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:37:46 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:46 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 3/8] hw/pci: introduce allocator for fixed BAR placement
Date: Fri,  8 May 2026 13:37:12 -0500
Message-Id: <20260508183717.193630-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::21) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: eacdf569-593e-4b94-d89b-08dead30e627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: dZ6h6c7jE+Qf1rebWfnieA+8iH2ASY5zo+ZkOVilQWoqaQbDkoY16ldhyuXAPHpvb+HfxWF3KDm3qq4f9mFuVG4zlHKBm7MV6yaYpLYAnJlOjaEKp9tdiE8jM78QDi6jIcZlFaDbeZUcERu4colPgm/th9zXfPRueW8JBRcJRxOY7KRtuh49T2WzVVVXNDB84/9MsF6c93pQx6MgoBbZGmeVRQoCuiwM3qDFe4AsHY0jPx1AE3rG4Oi063zDmlzj0tkwIqCokckeFl8fSkWiwh6fM4L8fB/uhbMAZ5i5jz3pQPWf0q7ansiRre0hfWerftG92leNLhSwzkp5GUDZmqDPUUXAVYHEIULpUYYzrGT+uDlk46QJkSmFDMTKkSC1hSV9mOfIYkqL9m00owruhg5+O58snNGBDzhun7OEuP65c9qmH9WGWOiAwzvDHaewfQawmyOZKpIqSvmncbbTaREx4Q9DSvNDmwmAz/o7XmRYvW0qU6JYma93ExMG3uYDH3AOUvwSHfEILu2N2/Ukz6sKxH3bKnho696qt/OHynrFRHVtWkqJgq79kRhDsSqFLhhafW376G/iiSjRlggS1cjDd7Kk2r3hVZWQlNiqvb2mhtUa8pB4bgGgVIlNqTilTgAl4BJiXUc5o+BrLe8OeZCfcbVKzoOx+6rlqv/ely61E2C4GsSjr2zuTbGCs8A5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTFIWHRkdTZ3TzRHWXRUV2ltM0hCQS9ENnZuMHQ1MVBqQ1JFSmthVldUdEJY?=
 =?utf-8?B?RC80SG5sMUhpVDZEM21oTVIwQ3lUTUhqWm5JMlZlQUU3b2JrVnJIaDBwYlZj?=
 =?utf-8?B?RXpleXNlSi9QWnpaenpnWjVsM1FkMUFoelp6ZXNudThqQVFDSmU1R1Roem5u?=
 =?utf-8?B?VnVaUTFtcHBTUFJLME9xbU9BYVpMZml2VTNjRk9XMjlDM3NoZllON2grZVhK?=
 =?utf-8?B?enJ1cFljV0hlbGhLUTlnb2lZTml5VmVySlh1M2dJOXRYOWY3RjVIcjNHVy9u?=
 =?utf-8?B?WHdSblNzZHlWSTJ2c2Q3OVR1NTk5YzVOa1R6L2NxQTlNQmZGL3V0a2YxSnVF?=
 =?utf-8?B?K3lFbUpLdFpCUFRzY0xuUDFMU21GZi93TW9Hc0M2cSswbFBjY01nQlQrR0x3?=
 =?utf-8?B?bjdocVNNdnRoSE9IZzJKaXFwdUJzSXl0REhiWmZmWUlBWDJNSVUvRHExYmFJ?=
 =?utf-8?B?UDdsYVIvWDdIanhMRXcxL3Vha05qbFJLVlFqSWlJZzBSLzMxVlhMZ2JoaFpY?=
 =?utf-8?B?L1p2U1VoT3d1eVRuUEtjRkpERENaV0V2OERRMVNpVlZpeGZueHI5Yjc4T2J1?=
 =?utf-8?B?dEROQlEyVStRYlRLa2Z4SGI3RXB4QnRvcGh4c1BQeWJ1NUZGUVJsVEYrRE5Z?=
 =?utf-8?B?Skx2NUptazk5Ym1UYjl3ZktXN2JoSFFoSk9wYTZTaENhczU4TG4xK0ZnaUs4?=
 =?utf-8?B?R2RDcDcvRTl2YTZieUVKNUdIQXplbUFDNzRFTzExYnZGcVZwNFFjZHJyR1Ra?=
 =?utf-8?B?S282TWVmWWMxbXJ2N2hTbFN1ZTBEWFFnT1pLMFhDV1ZNMGhza0NDVFI4L1Vy?=
 =?utf-8?B?UjE1T0dVRWRRaGVad0hjcDhnVTVxUE5rZ28wR0V0Z0h5SmkxWXBGbUVDV1ZZ?=
 =?utf-8?B?WHdhd3pPOVo2d3g2dXg3OHlBWmp5OWNpNnYrMGY3eTBxS2l1TlBMUHdJUzBw?=
 =?utf-8?B?ZkVGanlzY3lXOXk4SnhQNlV0bDVtaytUenBpVkpxZ3VmS1NDSGNzZmZQNWlx?=
 =?utf-8?B?cWU0bXI5dVBWZVNkNkdLWS85MlVzcjczNUdiQzhNd3dzTHdGMlBmOGZDTG5s?=
 =?utf-8?B?V0JudFBIZTN6Ymh3WVRZRFd2NnNOemtFbnBESU9BY0NHTUY3cnBheXdwRkdx?=
 =?utf-8?B?MXpmTEUwa2FBUTdsd0Yvb2JzMHZlK0hTeTdhcDltaUV6MGRSblNzK2dVcVVl?=
 =?utf-8?B?WDBjN2hUV0ltMGJOQmthL2tTdXlxQ1d5aXlMYVpTZSsvY0xlak42N200NjVy?=
 =?utf-8?B?VTByQTJJMEJNeUNhTm1KeVk0c1V3TWcxTmpZN2dWWTJSUlhkUlZZRXVmRWx2?=
 =?utf-8?B?TDMzZUxkY3FTdEJpY2hlUFhkVjg1Ump0U3VuRTlvWjlNYmFVM095czZUQ2Ur?=
 =?utf-8?B?Z2ZsTTc1ZHoreXJ2K256b1kwd21nS0ZSTHM4THR1WFdHUXlkcm8yN0l4dU4y?=
 =?utf-8?B?ekZydVplMlZ0TXFCME1jL3c5UFpLTlJzbkxtZGNLTDBiWXY0TXNLdkZUUXdx?=
 =?utf-8?B?U2M5aE05VG1mN1NxTG5KQ2w4TmJMVFVMWGhXSXI5ZmN4djVPSUZLbGtjc293?=
 =?utf-8?B?eitOdllNK1M5T1NsN0gzU2dnZFZwTU9nTmNnRi90RHJQN0Z0TjlFNFR5cGtO?=
 =?utf-8?B?ZStFNmdwL3FRZ3kwdlFpb0Yvc0JPdEVzSVlyd3JRMUNtS01pSlo2eE93eVYv?=
 =?utf-8?B?L2tvWWgzdjIzdHcrVkI3aE90K01rb2d2UTUwaEQycTFNSUJOT05BeGNnc200?=
 =?utf-8?B?SFVBejlaRHA2K2xlMkN3dzNWUWVjVHc1NnErM2dWL0FySDB4d3pUNHlmd1Nu?=
 =?utf-8?B?b0IyNnc3bFg1cjBsL2JMUENFTndQVllLR08wdTVJU3B5M2FNc093RVkvQ3JN?=
 =?utf-8?B?YlVCRUh1VjArZEcrMW1FZGFsbXEzVnNpNmJGZmZ6NExVUEpJWnFBMFZpN0pB?=
 =?utf-8?B?aVQvVHhBbno3R2FQa2lTUEVLNjBCb1hxdEc0aWg4R1RoTFRjMExVVjAvS1p6?=
 =?utf-8?B?bk9RR0lrZTFvazlFZE1pU0ZHWGtZdUVnRWRMdlFWUS81NFczdTZCbzRCQTkv?=
 =?utf-8?B?ZDRVNVhPZENydG03cDk5NEx2TmRWbzN6YW45NFFERmk0UTl5RGFZR3ZYcnVM?=
 =?utf-8?B?RnpTQ09uUHYxWFZ1SkJiYWhheW4wbWo5RHFjLzV6QjJlMmNGbEF6TkhaY2U2?=
 =?utf-8?B?Y0tnNVZaZjh4bXpYM1hWeUE1N203T2ZiMjY2WGJYVkpDNDlJMU91cm9GQ1cr?=
 =?utf-8?B?STEzTTMzS2FnVU9zbnF1VndQWk9oaFVpbTBPL2xJQnUwM2tnSFUxY0Z0WjY5?=
 =?utf-8?B?ZzY5NDIwOTlMS3hiWS9rMllUQ3IzdlZMUTdIOWRkaEZMQ0dBOFVJQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacdf569-593e-4b94-d89b-08dead30e627
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:46.6434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UaUvuHsktB3tELt2jpUicythJuZG0gonqpLi4XP7WTxkc2I5DmvSLzQgQvwpBLBwPSfBXbVjGQiTARhfdbHLQ==
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

The allocator walks the PCI topology and, for each device with fixed
BAR requests, validates the BAR (type, size, alignment, and that the
resulting range fits within the machine-provided MMIO64 window),
detects conflicts against already claimed ranges, and programs 64-bit
prefetchable BARs.

A global list of claimed ranges is maintained to detect overlapping
allocations across devices. Overlapping fixed BARs within a device are
also detected, and any conflict results in an error.

This patch implements the initial phase of fixed BAR handling and
reservation tracking. Allocation of remaining resources and bridge
window setup will be added in follow-up patches.

Limitations:

Only 64-bit prefetchable MMIO BARs within the MMIO64 window are
handled. This covers devices that use large prefetchable MMIO regions.
32-bit MMIO, PIO, and 64-bit non-prefetchable BARs are not supported
and will be addressed in future work.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build    |   1 +
 hw/pci/pci-resource.c | 255 ++++++++++++++++++++++++++++++++++++++++++
 hw/pci/pci-resource.h |  65 +++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 hw/pci/pci-resource.c
 create mode 100644 hw/pci/pci-resource.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 7e8f5bb87d..d26695414f 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -6,6 +6,7 @@ pci_ss.add(files(
   'pci_bridge.c',
   'pci_host.c',
   'pci-enumerate.c',
+  'pci-resource.c',
   'pci-hmp-cmds.c',
   'pci-qmp-cmds.c',
   'pcie_sriov.c',
diff --git a/hw/pci/pci-resource.c b/hw/pci/pci-resource.c
new file mode 100644
index 0000000000..5e9a78ec16
--- /dev/null
+++ b/hw/pci/pci-resource.c
@@ -0,0 +1,255 @@
+/*
+ * Copyright (C) 2026 NVIDIA
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pci-resource.h"
+
+/* Global list of claimed fixed 64-bit prefetchable BAR ranges */
+static GArray *fixed_claim_regions;
+
+static void fixed_claim_regions_reset(void)
+{
+    if (fixed_claim_regions) {
+        g_array_free(fixed_claim_regions, true);
+        fixed_claim_regions = NULL;
+    }
+    fixed_claim_regions = g_array_new(false, true, sizeof(FixedClaim));
+}
+
+static bool fixed_claim_regions_conflicts(uint64_t start, uint64_t end,
+                                          uint64_t wbase64, uint64_t wlimit64,
+                                          uint64_t *conflict_end)
+{
+    /* Hard guard: out-of-window ranges are invalid input */
+    if (start < wbase64 || end > wlimit64) {
+        error_report("placement [0x%"PRIx64"..0x%"PRIx64"] out of window "
+                     "[0x%"PRIx64"..0x%"PRIx64"]",
+                     start, end, wbase64, wlimit64);
+        exit(1);
+    }
+    if (!fixed_claim_regions) {
+        return false;
+    }
+    for (guint i = 0; i < fixed_claim_regions->len; i++) {
+        FixedClaim *c = &g_array_index(fixed_claim_regions, FixedClaim, i);
+        if (ranges_overlap(start, end - start + 1, c->start, c->end - c->start + 1)) {
+            if (conflict_end) {
+                *conflict_end = c->end;
+            }
+            return true;
+        }
+    }
+    return false;
+}
+
+static void fixed_claim_regions_add(uint64_t start, uint64_t end, PCIDevice *dev, int bar)
+{
+    FixedClaim cl = { .start = start, .end = end, .owner = dev, .bar = bar };
+    g_array_append_val(fixed_claim_regions, cl);
+}
+
+static void pci_validate_fixed_bar(PCIDevice *dev, int bar_index,
+                                   uint64_t addr, uint64_t size,
+                                   uint64_t wbase64, uint64_t wlimit64)
+{
+    PCIIORegion *r = &dev->io_regions[bar_index];
+    uint64_t end;
+
+    if (!r->size || !(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+        error_report("Invalid fixed-bars for %s [%02x:%02x.%x] BAR%d: "
+                     "BAR not 64-bit or size=0 (type=0x%x size=0x%"PRIx64")",
+                     dev->name, pci_dev_bus_num(dev),
+                     PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+                     bar_index, r->type, (uint64_t)r->size);
+        exit(1);
+    }
+    /* This path only programs 64-bit prefetchable MMIO in the MMIO64 window. */
+    if (!(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH) &&
+        !pci_bus_is_root(pci_get_bus(dev))) {
+        error_report("Invalid fixed-bars for %s [%02x:%02x.%x] BAR%d: "
+                     "this allocator only supports 64-bit prefetchable MMIO; "
+                     "64-bit non-prefetchable is not supported",
+                     dev->name, pci_dev_bus_num(dev),
+                     PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn), bar_index);
+        exit(1);
+    }
+    end = addr + size - 1;
+    if (addr & (size - 1)) {
+        error_report("Invalid fixed-bars alignment for %s [%02x:%02x.%x] "
+                     "BAR%d: addr=0x%"PRIx64" size=0x%"PRIx64,
+                     dev->name, pci_dev_bus_num(dev),
+                     PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+                     bar_index, addr, size);
+        exit(1);
+    }
+    if (addr < wbase64 || end > wlimit64) {
+        error_report("fixed-bars out of window for %s [%02x:%02x.%x] BAR%d "
+                     "range=[0x%"PRIx64"..0x%"PRIx64"] window=[0x%"PRIx64"..0x%"PRIx64"]",
+                     dev->name, pci_dev_bus_num(dev),
+                     PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+                     bar_index, addr, end, wbase64, wlimit64);
+        exit(1);
+    }
+}
+
+static void pci_check_fixed_bar_overlap(PCIDevice *dev, PhysBAR *pbars)
+{
+    for (int i = 0; i < PCI_ROM_SLOT; i++) {
+        if (!(pbars[i].flags & IORESOURCE_PREFETCH)) {
+            continue;
+        }
+        for (int j = i + 1; j < PCI_ROM_SLOT; j++) {
+            if (!(pbars[j].flags & IORESOURCE_PREFETCH)) {
+                continue;
+            }
+            if (ranges_overlap(pbars[i].addr, dev->io_regions[i].size,
+                               pbars[j].addr, dev->io_regions[j].size)) {
+                error_report("Invalid fixed-bars — fixed BAR overlap on %s [%02x:%02x.%x]: "
+                             "BAR%d [0x%lx..0x%lx] vs BAR%d [0x%lx..0x%lx]",
+                             dev->name, pci_dev_bus_num(dev),
+                             PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+                             i, pbars[i].addr, pbars[i].addr + dev->io_regions[i].size - 1,
+                             j, pbars[j].addr, pbars[j].addr + dev->io_regions[j].size - 1);
+                exit(1);
+            }
+        }
+    }
+}
+
+/* Program 64-bit prefetchable BARs */
+static void pci_program_prefetch_bars(PCIDevice *dev, PhysBAR *pbars)
+{
+    int idx;
+    uint32_t laddr;
+
+    for (idx = 0; idx < PCI_ROM_SLOT; idx++) {
+        PhysBAR *pbar = &pbars[idx];
+
+        if (!(pbar->flags & IORESOURCE_PREFETCH)) {
+            continue;
+        }
+        laddr = pbar->addr & PCI_BASE_ADDRESS_MEM_MASK;
+        laddr |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+        /* Set PREFETCH bit only if the BAR itself is prefetchable */
+        if (dev->io_regions[idx].type & PCI_BASE_ADDRESS_MEM_PREFETCH) {
+            laddr |= PCI_BASE_ADDRESS_MEM_PREFETCH;
+        }
+
+        pci_host_config_write_common(dev,
+                                     PCI_BASE_ADDRESS_0 + (idx * 4),
+                                     pci_config_size(dev),
+                                     laddr,
+                                     4);
+        pci_host_config_write_common(dev,
+                                     PCI_BASE_ADDRESS_0 + (idx * 4) + 4,
+                                     pci_config_size(dev),
+                                     (uint32_t)(pbar->addr >> 32),
+                                     4);
+    }
+}
+
+/* Phase 1: claim and program fixed BARs for one device (per-device callback) */
+static void pci_dev_claim_and_program_fixed_bars(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    PciProgramCtx *pctx = (PciProgramCtx *)opaque;
+    PhysBAR *pbar, pbars[PCI_ROM_SLOT];
+    bool had_any_fixed = false;
+    uint64_t start;
+    uint64_t end;
+    int idx;
+
+    pbar = pbars;
+    memset(pbar, 0, sizeof(pbars));
+
+    if (!dev->fixed_bar_addrs) {
+        return;
+    }
+    for (idx = 0; idx < PCI_ROM_SLOT; idx++) {
+        PCIIORegion *r = &dev->io_regions[idx];
+        if (dev->fixed_bar_addrs[idx] == PCI_BAR_UNMAPPED) {
+            continue;
+        }
+        pci_validate_fixed_bar(dev, idx,
+                                    dev->fixed_bar_addrs[idx],
+                                    r->size,
+                                    pctx->mmio64_base,
+                                    pctx->mmio64_base + pctx->mmio64_size - 1);
+
+        start = dev->fixed_bar_addrs[idx];
+        end = start + r->size - 1;
+        if (fixed_claim_regions_conflicts(start, end,
+                                            pctx->mmio64_base,
+                                            pctx->mmio64_base + pctx->mmio64_size - 1,
+                                            NULL)) {
+            error_report("Invalid fixed-bars — fixed BAR for %s [%02x:%02x.%x] "
+                         "BAR%d [0x%"PRIx64"..0x%"PRIx64"] overlaps an existing fixed range",
+                         dev->name, pci_dev_bus_num(dev),
+                         PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+                         idx, start, end);
+            exit(1);
+        }
+        fixed_claim_regions_add(start, end, dev, idx);
+        pbars[idx].addr = dev->fixed_bar_addrs[idx];
+        pbars[idx].end = pbars[idx].addr + r->size - 1;
+        pbars[idx].flags = IORESOURCE_PREFETCH;
+        had_any_fixed = true;
+    }
+    if (had_any_fixed) {
+        g_hash_table_insert(pctx->had_fixed, dev, dev);
+    }
+    /* Abort if intra-device fixed overlap */
+    pci_check_fixed_bar_overlap(dev, pbars);
+    /* Program fixed BARs now */
+    pci_program_prefetch_bars(dev, pbars);
+}
+
+static void pci_bus_claim_and_program_fixed_bars(PCIBus *bus, void *opaque)
+{
+    pci_for_each_device_under_bus(bus, pci_dev_claim_and_program_fixed_bars, opaque);
+}
+
+static void pci_resource_init_from_mmio(PciAllocCfg *pci_res,
+                                   const PciFixedBarMmioParams *mmio)
+{
+    pci_res->mmio32_base = mmio->mmio32_base;
+    pci_res->mmio32_size = mmio->mmio32_size;
+    pci_res->mmio64_base = mmio->mmio64_base;
+    pci_res->mmio64_size = mmio->mmio64_size;
+}
+
+void pci_fixed_bar_allocator(PCIBus *root, const PciFixedBarMmioParams *mmio)
+{
+    PciAllocCfg pci_res_buf, *pci_res = &pci_res_buf;
+    PCIBus *bus = root;
+
+    /* Fill allocator MMIO window once from machine memmap */
+    pci_resource_init_from_mmio(pci_res, mmio);
+
+    /* Reset fixed-claims tracking */
+    fixed_claim_regions_reset();
+
+    PciProgramCtx pctx = {
+        .mmio64_base = pci_res->mmio64_base,
+        .mmio64_size = pci_res->mmio64_size,
+        .had_fixed = g_hash_table_new(NULL, NULL),
+    };
+
+    /* Phase 1: program all fixed BARs and claim them */
+    pci_for_each_bus(bus, pci_bus_claim_and_program_fixed_bars, &pctx);
+
+    /* TODOs: Phases 2–3, program remaining BARs, bridge window refresh etc,.  */
+
+    /* Cleanup */
+    g_hash_table_destroy(pctx.had_fixed);
+    fixed_claim_regions_reset();
+}
diff --git a/hw/pci/pci-resource.h b/hw/pci/pci-resource.h
new file mode 100644
index 0000000000..cc4d6f71cb
--- /dev/null
+++ b/hw/pci/pci-resource.h
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2026 NVIDIA
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_PCI_PCI_RESOURCE_H
+#define HW_PCI_PCI_RESOURCE_H
+
+#include "exec/hwaddr.h"
+#include "hw/pci/pci.h"
+#include <glib.h>
+
+#define IORESOURCE_PREFETCH     0x00002000
+
+typedef struct {
+    uint64_t addr;
+    uint64_t end;
+    uint64_t flags;
+} PhysBAR;
+
+typedef struct {
+    uint64_t wbase;
+    uint64_t wlimit;
+    uint64_t wbase64;
+    uint64_t wlimit64;
+    uint64_t rbase;
+    uint64_t rlimit;
+    uint64_t rsize;
+    uint64_t piobase;
+    bool     available;
+    bool     search_mmio64;
+    PCIDevice *dev;
+    PCIBus *bus;
+    /* Allocator window (filled once from machine memmap) */
+    hwaddr   mmio32_base;
+    hwaddr   mmio32_size;
+    hwaddr   mmio64_base;
+    hwaddr   mmio64_size;
+} PciAllocCfg;
+
+typedef struct FixedClaim {
+    uint64_t start;
+    uint64_t end;
+    PCIDevice *owner;
+    int bar;
+} FixedClaim;
+
+typedef struct {
+    hwaddr mmio64_base;
+    hwaddr mmio64_size;
+    GHashTable *had_fixed; /* set of PCIDevice* that had at least one fixed BAR */
+} PciProgramCtx;
+
+typedef struct PciFixedBarMmioParams {
+    hwaddr mmio32_base;
+    hwaddr mmio32_size;
+    hwaddr mmio64_base;
+    hwaddr mmio64_size;
+} PciFixedBarMmioParams;
+
+void pci_fixed_bar_allocator(PCIBus *root, const PciFixedBarMmioParams *mmio);
+
+#endif
-- 
2.34.1


