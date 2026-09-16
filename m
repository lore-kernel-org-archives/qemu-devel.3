Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCAC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6unx-0006Se-Ps; Wed, 16 Sep 2026 14:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unt-0006Rw-Kw; Wed, 16 Sep 2026 14:56:21 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x6unr-00062u-Fc; Wed, 16 Sep 2026 14:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2xLSXYx33KUMqdaIezhAfkwgFuitDfeP+bxGEZNCEu43LwqjfS26SixzfX/DMM84yGIplL5GMYacR391cTzzUIXuQ/6uMUea2Bmii/GRdtDYvilJLfnxRAVkkT/gVwVhzTy8q9z/wd9fAX2R1i70bN/dO56oX7wBbZg9gxdupvoo8266L4nEZghRFU719O/7SE2EX8U0WUV33QwdDPbNzaw602FbUCQuiXh4SiUQBOPddY29/8F781w9tJhQ/drLrJTntUdTHMd/nMEZvlrQHrt1YZeYXG1djVuxCLZD172/kyuWGgpw2QKE6uCxdSgFnTPNgTcmytSTRPmbZLGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLC6jwzk83hAxCPSgr5+eOF7z8X2pPvkUBV8OR2as6U=;
 b=sYqqJkN41M2kqS/Sxan/t9fPG6PbGEoYeddWrYo+CjFueHibUP2q7uokYFc7H2IzeaO43b0paq37kYlihTWuL6OXSkEp9q9fcm9w6G+2ZpAk7qaYwgtiaLnNVnmfYIT//KnFq8gua8TuLuf9X7tf4d2LBR6S98hDF8eoSleI5+96FL467/oNiZgMR0Zv+s5KAq0Ayp42RX/GmGFnDBFh+WEWKJ/A5fx+0Q8hJvtT9dNz5z5rlk6dCMa95L9GNaNhTIzh+3ofDPLRY41tJGn6Qy6TKk7kvYKIPywsTiGYnrdlvipJ/JaQFbSLAI230q6uTwQ+oo0NhvLc8YkSCACDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLC6jwzk83hAxCPSgr5+eOF7z8X2pPvkUBV8OR2as6U=;
 b=bHxN5fpRksW39lnoXuwiG0bGlE3JBDWHOgDA/N4ps0VdFLwz6beAmm32/q03hZAUpluhBXC4pTCPuNj7VP+caIWFqtAMYAVfirdgtdTKT4K9Hb6Oi7/LTBAgjik/ypsLSKASM9nnm/bRZa/UXXxqOvK+JtLhKkdmZXUT3YFbq6yO5c5i0lhgvJsC9slJ/EnltHN7QxqRq1a7HL4GHLEl9ENZxjFNZ7NH9lcsZAAlVNvTyeeZWwiusRnPZ4gVj+XrsXI+I9dvP3EKDbL7ygqozhgNeB01psIKCoSclwQXlalD9SPi8REGYMDU6EnmUMzlrLTpW5RMPVZdoSVtWG8jBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY3PR12MB9631.namprd12.prod.outlook.com
 (2603:10b6:930:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:56:05 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 18:56:05 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 2/5] pci: add validation for fixed BAR configuration
Date: Wed, 16 Sep 2026 13:55:51 -0500
Message-Id: <20260916185554.917526-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916185554.917526-1-tdave@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:806:23::35) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 6207f35d-c4f9-4df3-202a-08df14242900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: nE+ldT66+y7ia9PtEVpOBVgnmcyqxR8vhS1jleeUhttui/AYiyL05vchmy1AedPfXyuyHdk2qDiXpOlR+A2Olr4ZUXKnOaVL5jN2rLwwZmmR0aGKX3gsFoYIeaH01/2gZRiq4RR2xmta6BPGTBNx5JJS4olQrK9cbRwVsN7Xit69oX0MXnJDGN1eB3O1M/kVzlpAF01nVH8Wy9sZN+w6UThEjcSuZ5J6wpgWaZzxceFJe52RyiofEOGLiDRyRFyRqMxviumPpQCnCkN2C0ML/i+Hl+QWmW2cHihjCFJpPb87dMbbvLQdGMmlbvkLvhQznG06hVM+JIT3ZjshGjipGU6NyRcwDJFubWD+L6qqZZ0F1mPfmi8dDOCO+YixidNbklk04W3UAtv46AP/9rzBVDpiwUYDceoBKOhqBVZsztE5RLf1u7sccZR5bg93FjVMXVRLU1nkfAuZ4i/ICdze7+85+jOoAGdbAbL5PZvjTxdHcR1nTPJzWAHgvsSG3tfTGEnHshQSuY2PgZdKBe5oXXwcEsdlWsU/QWa5k0H9AkkXwUS7wxqtKFohb+9oynKYOL5/BJGtOwdxGG6dTH9nGeUWVCF2Rb1pnEBLqu5EuY/Hd7u8z97mcIil7k3uLaIiOg8lUMw+VKLha/RVO3vrFmKdDpwYVSXzkkeDr3DLZuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1J5TEtoN1RJaEl4akJiQXJsYUtadW5zZ2M0bWJuOExWc1k3NEwxRmxVUjN5?=
 =?utf-8?B?bXdOMWg4SjdvUi9QY0pkYk1BaldHaTFiTmFQUUVta2FlVXh6R3FRd0FsVTJt?=
 =?utf-8?B?Tkd3NFZuajkvdDdNTWc1V2tzVU9IRXhVWi9QdmlvbU5GQks3OXdSYmZmcjBy?=
 =?utf-8?B?alZMYXZXRUZyd1Y5YkFJR3JJRDBmcEFETEYwZGlNZ2dwblZWblBGWEV5R2Yv?=
 =?utf-8?B?Z1ErbjN5VGNIRWRHdEJhRis5TUVOdzJndGxFR2lRSFVBa0ZHV0E4dForZFpq?=
 =?utf-8?B?TUt0aVdNRzVyNGYrRTBCYUltNE1hRlI1NzlXYnZ6VTFZdTRRZVZ4WCtzMkZL?=
 =?utf-8?B?ZU1CRWNBZmZpdEVFRFhlYlRXcU9mNE1jWEdYR2R5T2QxQjB3aERJTlRwWVlO?=
 =?utf-8?B?WHpPYVVzN0lhY1NRT2orNGZRYzhFendvRE41S2YwRlR3UEdEZFd5RkpDekkw?=
 =?utf-8?B?cnI3dEJ6cDRtRGRtUEpPUUdHWXhOR0VobWZqL3BzTUlVSGkyU01EakZPSGF5?=
 =?utf-8?B?WWxmaVkxQ3ZTeVMxeVljeHhkano0TU1PWnExZUJyVVdyem1VRWM1RXhIV25Y?=
 =?utf-8?B?TUFnM3kxQ3FzZXRlVVVhaDJnNGlaU0c4bWdRRmhOTkkxS0l2K2lTUEZWZHgz?=
 =?utf-8?B?K3hhWFl0ZVZLQ2Y3dDZqOUFYeHpsa29pbVQrVnR2MThaclUyNnc2UzNtVkhy?=
 =?utf-8?B?Ulo2R1ZGaGFEVUdNVXBod3k3WUxGWjJYc1RhWi8wUUx0MGN6Q3ZxaG5IYnVu?=
 =?utf-8?B?dGlXQTVEWWRoK3hvZ1VwcVkrUjZmYmI0MGg2QVpXeU5UWTZ1TFMyZU1Ea3Zj?=
 =?utf-8?B?MU40dFFESjZnQ05ZeWsrRGxpclZ5eWdvWXlsWGdqei80ejUvNUFmUXdLMlhC?=
 =?utf-8?B?OHZ1OWFMUVMxaCtIeHE0Q0NiUjQyMFU2elJkT3l6SFEzRUIrRzdKdlNkRy80?=
 =?utf-8?B?Uk5hakcxSVdsSWdZcHFoR3FaSnF3N0lQazF0MDJnYmtQRHBQOVU4VEN2VGdD?=
 =?utf-8?B?TVB0V3JUVFNXS0lyaUNJZDdjOGJnTHd2M2orRVkxU3pZOE43UERNektTeGpP?=
 =?utf-8?B?b2czOEVNTkE0R0tiUmJnV1FCMVg2RUtzT05tVGlQV2ZQMEFtV3B6eWNReWJ0?=
 =?utf-8?B?WTFDVW5xZm0vcDJSWkJMdmR0dEpNRjJKTE84dW5jckNTVDNRcGFZZkZXOUNN?=
 =?utf-8?B?bXlYbENSVTJ2b2V4bFU5RDk5ZkNLMEcyYVZDNCtvSkdvZEtqd1V2akJ1WTZv?=
 =?utf-8?B?ekF2dFpMNVJnZFlTeUdkQXBOOHcyMzVMazVGeWtKT2lXSkh4Y1JDdVVCQml6?=
 =?utf-8?B?dmV1U210d2NyMkZiVlNhTHg4YmNkYUR3TENrenF1UjNpTTF0aGNkcCtuckRp?=
 =?utf-8?B?S3FxeXI0UkM1ZW1TS05jQllJYTQ0QVB5RDJPQVFjYjlUM3lhbW1kK2k5L2VT?=
 =?utf-8?B?Nmk5SC9PZFN5cTlPd0ZFRTBjNE40NU1uZWlWZ3FVZVQrd05aSzdjK2NMdHh1?=
 =?utf-8?B?TUtpcFZHZzBONUVxdnU1MVBlQWxVLzAwOWw5RExVZzhZUzdxc3k1KzhOQlda?=
 =?utf-8?B?OWZ6Zkl3QkluejZvR0lnV3owRHpLc3FraHQ0Nk9ULzdCa1N1SjMrckFPYWZi?=
 =?utf-8?B?TUtZZGRSOTBIWjNUb21sRjdqR1p4ZTEvR05NUU9nZXBhUHRnQ3ByWUhpdVlW?=
 =?utf-8?B?MmJTSkRSY01RZ052aFFiM2VDanozalNLZkNKc1ZmbG1MTFp3YVkwY3ZWTm1B?=
 =?utf-8?B?akRKTXZmbFQzWWN4U25CYXFQQWRscUlGRVp2K09yVmlMUkVVQWxNeGsvVmlP?=
 =?utf-8?B?T004Qkpad0VxdUZFM3I5VHlsYVhkNGxwWGxJQy8wb2xXMzhJczAzSlBWYUhz?=
 =?utf-8?B?ZXRBY1M4SDhoVWphZE8vYW40bEx0bkNqWTVKdFA0VXI0ZVVISEJEZS9adzlS?=
 =?utf-8?B?UFRJeGwwMzRDcVBTenRuTHJmalc3VFpmUFRsWTQwYXVqWXNsS3hUb3VmMFZO?=
 =?utf-8?B?RjJOcmVZaHhCOUhEeUgybVlqdEJNb3NCSDJmMWllbkdFbVMxZXcxK3NEd2Zl?=
 =?utf-8?B?aW4zWEF2QmdXc21tODFxL09QQTNnckdKd3VncUQzRFJ5T3grT005WXJlSnhU?=
 =?utf-8?B?RFA2bDR4QXIxcW00N1RiRnhaWnFVUmF6aHlYNlNsNG5TNTlqeGFCL2lESzEr?=
 =?utf-8?B?MjRqSkdpZG9yVm53UGF6dGJRNmltbklaU0ZtdWJkdWxiZFdaSzJjSzVvaEVw?=
 =?utf-8?B?R2h6SVBNZDNmcjNhS3NjMmFuZ1JOQURSLzBGdVZGTm0zTW1UaERPYWdmaXVT?=
 =?utf-8?Q?qf8G0j0OyK2fD6/7gF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6207f35d-c4f9-4df3-202a-08df14242900
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:56:05.0041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2A71K2zutQGkoqT/DsPQ51QTr/UcKKKXKHysv6QYl0bD/v95UJLFLG5BOsDVpRpfzwCNO5IblWveQO4Wm/OoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=tdave@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Validate the fixed BAR configuration specified through the
fixed-bar-N properties on PCI endpoint devices.

Configuring any fixed-bar-N property on an endpoint device requires
every memory BAR on that device to have a fixed address. Validate
that each assigned address:

- is aligned to its BAR size;
- is within the appropriate PCIe MMIO aperture; and
- does not overlap any other fixed BAR.

Under a PCIe topology with a root port, fixed BAR placement is
all-or-nothing within that root port's subtree. If any one endpoint
device below the root port has a fixed BAR, every other endpoint
device below that same root port with a memory BAR must have all of
its memory BARs fixed too.

Endpoint devices with no root port in their ancestry, such as those
attached directly to the host bridge, are not required to match
their sibling devices. One such device may use fixed-bar-N for all
of its memory BARs while another sibling device on the same host
bridge uses none at all. Per-device completeness still applies
regardless of ancestry. Once any fixed-bar-N property is set on a
device, every memory BAR on that device must be fixed.

Abort QEMU if any validation fails.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build              |   1 +
 hw/pci/pci-fixed-bar-validate.c | 326 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  21 ++
 3 files changed, 348 insertions(+)
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 984c7327e5..150085c997 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -19,6 +19,7 @@ endif
 pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
+system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-validate.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pci-fixed-bar-validate.c b/hw/pci/pci-fixed-bar-validate.c
new file mode 100644
index 0000000000..0b5baad8a0
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.c
@@ -0,0 +1,326 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * BAR address validation for fixed-BAR placement.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "qemu/units.h"
+#include "pci-internal.h"
+#include "pci-fixed-bar-validate.h"
+
+/*
+ * Claimed BAR ranges — detect inter-device and inter-hierarchy overlaps
+ * across all fixed BARs system-wide.
+ */
+
+typedef struct {
+    uint64_t    start;
+    uint64_t    end;
+    const char *owner;  /* device name, for error messages */
+    int         bar;
+} FixedClaim;
+
+static GArray *fixed_claims;
+
+static void fixed_claims_init(void)
+{
+    if (fixed_claims) {
+        g_array_free(fixed_claims, true);
+    }
+    fixed_claims = g_array_new(false, true, sizeof(FixedClaim));
+}
+
+static void fixed_claims_free(void)
+{
+    g_array_free(fixed_claims, true);
+    fixed_claims = NULL;
+}
+
+static bool fixed_claims_overlap(uint64_t start, uint64_t end,
+                                 const char **owner_out, int *bar_out,
+                                 uint64_t *start_out, uint64_t *end_out)
+{
+    FixedClaim *c;
+    guint i;
+
+    for (i = 0; i < fixed_claims->len; i++) {
+        c = &g_array_index(fixed_claims, FixedClaim, i);
+        if (ranges_overlap(start, end - start + 1,
+                           c->start, c->end - c->start + 1)) {
+            *owner_out = c->owner;
+            *bar_out   = c->bar;
+            *start_out = c->start;
+            *end_out   = c->end;
+            return true;
+        }
+    }
+    return false;
+}
+
+static void fixed_claims_add(uint64_t start, uint64_t end,
+                             const char *owner, int bar)
+{
+    FixedClaim cl;
+
+    cl.start = start;
+    cl.end   = end;
+    cl.owner = owner;
+    cl.bar   = bar;
+    g_array_append_val(fixed_claims, cl);
+}
+
+static bool validate_bars(PCIDevice *pdev, FixedBarsInfo *info,
+                          bool is_fixed_subtree)
+{
+    const char  *devname = DEVICE(pdev)->id ? DEVICE(pdev)->id : pdev->name;
+    const char  *overlap_owner;
+    const char  *wname;
+    bool         has_fixed_bars = false;
+    bool         is_64bit;
+    uint64_t     addr, end, wbase, wlim, overlap_start, overlap_end;
+    PCIIORegion *r;
+    int          overlap_bar;
+    int          i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+            has_fixed_bars = true;
+            break;
+        }
+    }
+
+    if (is_fixed_subtree && !has_fixed_bars) {
+        error_report("fixed-bar: %s [%02x:%02x.%x] under fixed-bar root "
+                     "port has memory BARs but no fixed-bar-N= specified",
+                     devname, pci_dev_bus_num(pdev),
+                     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+        exit(1);
+    }
+
+    if (!has_fixed_bars) {
+        return false;
+    }
+
+    /* Completeness: every memory BAR must have an address. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+        if (pdev->fixed_bar_addr[i] == PCI_BAR_UNMAPPED) {
+            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                         "missing a fixed-bar-N= value",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
+            exit(1);
+        }
+    }
+
+    /* Per-BAR checks: alignment, MMIO window, overlap. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+
+        is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
+        addr     = (uint64_t)pdev->fixed_bar_addr[i];
+
+        if (r->size - 1 > UINT64_MAX - addr) {
+            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                         "addr=0x%"PRIx64" + size=0x%"PRIx64" overflows",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, r->size);
+            exit(1);
+        }
+        end = addr + r->size - 1;
+
+        if (is_64bit && !(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH) &&
+            !pci_bus_is_root(pci_get_bus(pdev)) && addr >= 4 * GiB) {
+            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d is a "
+                         "non-prefetchable 64-bit BAR behind a PCI bridge "
+                         "and cannot be placed above 4GB",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
+            exit(1);
+        }
+
+        /*
+         * wbase/wlim are both inclusive bounds (mmio*_limit = base+size-1,
+         * set by the caller alongside mmio*_base), matching end's own
+         * inclusive computation above.
+         */
+        if (is_64bit) {
+            wbase = info->mmio64_base;
+            wlim  = info->mmio64_limit;
+            wname = "64-bit MMIO";
+        } else {
+            wbase = info->mmio32_base;
+            wlim  = info->mmio32_limit;
+            wname = "32-bit MMIO";
+        }
+
+        if (addr & (r->size - 1)) {
+            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                         "addr=0x%"PRIx64" not aligned to size=0x%"PRIx64,
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, r->size);
+            exit(1);
+        }
+
+        if (addr < wbase || end > wlim) {
+            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                         "[0x%"PRIx64"..0x%"PRIx64"] outside %s window "
+                         "[0x%"PRIx64"..0x%"PRIx64"]",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, end, wname, wbase, wlim);
+            exit(1);
+        }
+
+        if (fixed_claims_overlap(addr, end, &overlap_owner, &overlap_bar,
+                                 &overlap_start, &overlap_end)) {
+            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                         "[0x%"PRIx64"..0x%"PRIx64"] overlaps %s BAR%d "
+                         "[0x%"PRIx64"..0x%"PRIx64"]",
+                         devname, pci_dev_bus_num(pdev),
+                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                         i, addr, end, overlap_owner, overlap_bar,
+                         overlap_start, overlap_end);
+            exit(1);
+        }
+
+        fixed_claims_add(addr, end, devname, i);
+    }
+
+    return true;
+}
+
+typedef struct {
+    FixedBarsInfo *info;
+    bool           is_fixed_subtree;
+} ScanState;
+
+static void scan_bus(PCIBus *bus, ScanState *state);
+
+static void mark_if_fixed(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    bool *found = opaque;
+    PCIBus *sec;
+    int i;
+
+    if (*found) {
+        return;
+    }
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+            *found = true;
+            return;
+        }
+    }
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+        if (sec) {
+            pci_for_each_device_under_bus(sec, mark_if_fixed, found);
+        }
+    }
+}
+
+/*
+ * True if any device in rp_bus's subtree (the bus behind a root port)
+ * has a fixed BAR.
+ */
+static bool root_port_subtree_has_fixed_bar(PCIBus *rp_bus)
+{
+    bool found = false;
+
+    pci_for_each_device_under_bus(rp_bus, mark_if_fixed, &found);
+    return found;
+}
+
+static void scan_bus_device(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    ScanState   *state = opaque;
+    bool         has_mem_bar = false;
+    PCIIORegion *r;
+    PCIBus      *sec;
+    int          i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (r->size && !(r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            has_mem_bar = true;
+            break;
+        }
+    }
+
+    if (has_mem_bar) {
+        if (validate_bars(pdev, state->info, state->is_fixed_subtree)) {
+            state->info->any_fixed = true;
+        }
+    }
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        return;
+    }
+    sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (!sec) {
+        return;
+    }
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCIE_ROOT_PORT)) {
+        ScanState child = {
+            .info = state->info,
+            .is_fixed_subtree = root_port_subtree_has_fixed_bar(sec),
+        };
+        scan_bus(sec, &child);
+    } else {
+        scan_bus(sec, state);
+    }
+}
+
+static void scan_bus(PCIBus *bus, ScanState *state)
+{
+    pci_for_each_device_under_bus(bus, scan_bus_device, state);
+}
+
+static void scan_all_host_bridges(FixedBarsInfo *info)
+{
+    PCIHostState *hb;
+    ScanState state = { .info = info, .is_fixed_subtree = false };
+
+    fixed_claims_init();
+    QLIST_FOREACH(hb, &pci_host_bridges, next) {
+        if (hb->bus) {
+            scan_bus(hb->bus, &state);
+        }
+    }
+    fixed_claims_free();
+}
+
+/*
+ * fixed_bars_validate - scan all PCI devices, validate fixed BAR addresses.
+ *
+ * @info: carries MMIO window bounds for validation.
+ *
+ * Returns true if any fixed BAR devices were found, false if there is
+ * nothing to do. Aborts on any validation error.
+ */
+bool fixed_bars_validate(FixedBarsInfo *info)
+{
+    info->any_fixed = false;
+    scan_all_host_bridges(info);
+    return info->any_fixed;
+}
diff --git a/hw/pci/pci-fixed-bar-validate.h b/hw/pci/pci-fixed-bar-validate.h
new file mode 100644
index 0000000000..297d1480c0
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_PCI_FIXED_BAR_VALIDATE_H
+#define HW_PCI_FIXED_BAR_VALIDATE_H
+
+typedef struct {
+    bool      any_fixed;
+    uint64_t  mmio32_base;
+    uint64_t  mmio32_limit;
+    uint64_t  mmio64_base;
+    uint64_t  mmio64_limit;
+} FixedBarsInfo;
+
+bool fixed_bars_validate(FixedBarsInfo *info);
+
+#endif /* HW_PCI_FIXED_BAR_VALIDATE_H */
-- 
2.34.1


