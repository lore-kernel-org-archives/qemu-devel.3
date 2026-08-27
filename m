Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F3C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOBY-0005kW-KK; Wed, 26 Aug 2026 20:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBX-0005jo-1T; Wed, 26 Aug 2026 20:41:39 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBV-0004l8-31; Wed, 26 Aug 2026 20:41:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEVdMa+p7XQrkSIzr4HuZa1COiPuF+8owG2ODGLVgyRtnrl5wSQa2HK6HtIxBf4XP22D9NThyF9WFUHtbdoKEC7XEakqbFX4OHPIDA3PFbl/WvewQ8dOHu1XdDZg3hFR/7pf4pA55Z5qWfZSrvjHLiy67h8ELF3NeW61d8hr1cXAPOqFkj8mzd3q/SoxNRQHgzz+1+FA4wZ8GaOXPIzT/pZ/FChJ2CYVPMbkQVcBYMfbCiEjZQGe4CLJxxOb3Ot+NIRTfBmdnFE36AedTnE6zxnLKCiD5Nobj9n/POZQ58rnyc1l00DOHSyrRQrMP8tikFyRYF3rSs2gCwOv8g2goQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wD/EVjjXxdUtJBEvHv2xhNUz1iHn7S5dT0BJWnR/3s=;
 b=LeGB8OtXb6NeoS3SknB9iDaElgMgZCy3lkdOH4ORAbRFf+HLuG0VLXqExSXHIUCHppVK9oERZgSAIO8jGUvXmEV3Ay+7X4JhuGfe1h6SWanBHgUYpzUkDeHLxD7Q3Z+1xHBbJdBPAhzbGBJSFBZ7it/86b5s83TSmImUzM05KGQJVM6iBBWyZNyQ07THQR3dWd8Dl5cOC3bcuz+ATXWsVJjVmUB1QyVjfQrypzhyMRH/ojCUjLUoh1nCQyr3xfKYRxHmSRrvIimkYkDsUTPkXZIQdKFRD6auYoqaQMbVY58ECCX1OyffKMfN5x6L/TsJ7cnh/TYjuyS7ne6Z10/SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wD/EVjjXxdUtJBEvHv2xhNUz1iHn7S5dT0BJWnR/3s=;
 b=SXteM8sYqA2FX5k6gnFk2lMrsRbaoAb6LDGXxPR8Qv2L808i7rOZfa/J3nsf9Nt9r9LokAYadJo9OU9lEyWWCiBby4nlZld9fVi81AowHUg+zCvZ9+tMvWsJceTQ+erAYV870L4s3m2k34DgKswV4QcxUAjbSDQhGVHY8t3PJY5iU1agW7gXOWgzDaK7vnuTwyA0iV83tibT3K0Lc0tQis4B0opwrgs3gY5N8AaNkj7glUOEy2i1Cp3r9hseE0sS1onuYmh3E57ExSWU1GxPTeNaloAbrYVRatp+39jqVf7TP/Skfe9Zqwj69RIWuoTkDtp3d8fCzvOsDeO7nlw8pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 00:41:26 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:41:26 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH v2 1/5] hw/pci: add fixed-bar and pci-bars properties
Date: Wed, 26 Aug 2026 19:40:20 -0500
Message-Id: <20260827004024.598351-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827004024.598351-1-tdave@nvidia.com>
References: <20260827004024.598351-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 585d4d2d-b91f-4e21-1aee-08df03d3ed2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FqXS9gWd2yskd1mjokMMA2+RUTc66vfsPA9dn4LWYLPyYAgoq3Ybdg61Epcfqxzc8Rq0mUi/4+f6NIQF6zp3VQaWqsgbTswmQyYmsV6fCp2JlbjxSLlvrxXGmWaCT7QPAE4tPTk4Pcd3hDv6N/kFwBPZ6thojakclIvTcngwbz1YcQI4zB4Xk/caCzALvJpibYDuK6JrWjmCCDoIwhxDnmrT/mzRP6eKaTXYZakViV+JOU9h+96DNFlybB7Xm1hYxPLS2O9ghWTJmL5IwKUXpMlqkGMlD4hQz/OtP4QOJ+l2J1fQewwIy/HmOjRkMBzlTHRS1itNATM7frADLzNininT+P1UQCPW5Lz0Inf6O/MlPVtfHarwzaC6KtfmPW8rHoDSRF1x0e2xIzTuijn02UIHiSM23JjYNJyKKjAWTDGkQf+kQONzl4dAI9SV4fhkMaq4XITRKOc1JuHjpiDt4SFjJ6L+5xde7sQtTEHNy3Cw9l50Yqkzh8alv4N8v3jAABjMqNEmYoLppCqqm2A1Xpjv1MRMS7jes1nXiwLZb9Q9njnD4B9v2FW9lGgZPeRI2OPQ9H9+2ul2SVmTUw6aNT7caB/wyvRzmLdNnMTLZQW7LTRgPWMR/s4czkf+QMpqWTn+BJOUIzzw+UDDAdL9KewmZbXsPuFA2LNNuTKGJx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VqmqDDWJlrqzXZOSrkcR1iLTd86HvGT/+dEYC1GPfYR1+yPq4+z+oLTTK0dt?=
 =?us-ascii?Q?wTxgNWxlHy7rzKi9nYoMDFwkVW4YTtp1De1mhwb7kGW7a5wYslYC29UxZUiS?=
 =?us-ascii?Q?MRegm1CRhy84xXilncyAc5+e5a3EQftiK+qqRYHMAr2VeGfzkkzKxxq2K2Vi?=
 =?us-ascii?Q?jN/EFuVmqpcC+P75kwR9sgkEBEgIvFwpISOCAoRSn9npBET3sqf5RTX/bU5t?=
 =?us-ascii?Q?39QZTxxqhzxZCYsk67dq/huTnTVh2qb+5fATsO9KlLhGuZcvOJ5LRMAA+5kX?=
 =?us-ascii?Q?UqUuITw6QNNVXEMLCLPr4KsW7b70WG8zqOh+fwsGwyfsaJVWQNwtDtsFDE/z?=
 =?us-ascii?Q?kBmuQlmhewqLfG4HO1eAuXv1yC8jHpsmFRH2taUFgVFidhwxIqHjWF9mX+U5?=
 =?us-ascii?Q?Mt1j+9j7moLIahFl0FwtI6GA+CTJertDztiUdt4U/Qrqknqi3rGGc4RJoqHd?=
 =?us-ascii?Q?7m3UXJjCrq7rtNoMn4smrmDFAr0+rhY9Tdily8WlMUXOfNzaO65TBLqxLe7S?=
 =?us-ascii?Q?YnqVe1Nmjsx3wFaIRxr8jQUouP8yBhcRLBIvNZAzu5e1xnX4qNQQ9CvnK5Hx?=
 =?us-ascii?Q?SxTD0U7c9U84skVVk8CEinIqWQoURjN3ZEdtxhA9KnK1w0FIjLsy43l/6+DJ?=
 =?us-ascii?Q?7hvsldV8mhhQHGSX5SauHCxlPqQ+pD9A9OyvEe0qhrAcJ/CDB+N/jvGhrruT?=
 =?us-ascii?Q?9Ni4NWjAbN37lZ768Gs2Pg3T0GVN+gxKacpV+C5YZsiUb79HdNgNk5b4BRLh?=
 =?us-ascii?Q?YxchCg1W9UIW1IVqiYsa6M6ATIx6p2jHKHLhwk4uUWvDhMPbS0Tm0V5+bTle?=
 =?us-ascii?Q?hJv/iCJgpKWDZhOJvhBaeYa9XztTACgaHDcZ0dEQRKWfKgBqPJ6hC+PMOV28?=
 =?us-ascii?Q?tdkc6hd6l+UGw+iW/ufacdJ1y4J8Gb/K2UwOmckdrQLKRbW8/pjMc8xWCo6H?=
 =?us-ascii?Q?J5i7zStL2SUtsB1U9BxkVxlxn4fkdcRdjdI6LluQrKNa0XjY9tZj7Lr3UHWa?=
 =?us-ascii?Q?u1yjidjApWY3ke7iDYDbJypKu3jOcaKkTISyqsjivIu1hNtpNQmfUsdB8Twh?=
 =?us-ascii?Q?sikeWIbaReQ4n7eX5uZwdVxEN7UEHlpPHYZ0Q/49xtsF7Kk5xzX8AWdvk3vJ?=
 =?us-ascii?Q?FI4Szlopo5cM/Jmxwnqe1XPijsZbjJrUENh8ZaL823S+0puRSpg5vr9MTST/?=
 =?us-ascii?Q?TzeHdRReTfBgB0S6SKlGOEQb3iPQkIz2MTUvUpaXU0BfRoZevWNDbmtQRvux?=
 =?us-ascii?Q?Ogu2Dg10kACQTCf7qQWZfLc5eKMwJI7JUfjMAQqHC6OuPxqJ/nFgISt2RJ+1?=
 =?us-ascii?Q?Vk1e69UJzZjS6RL4EBm9MoqdNBpmO9Sn3HCpitHtbLPwJVETP1EM9VMlWozo?=
 =?us-ascii?Q?qt5/GAbwbRXT86lBOkXhSM82bSYaoUcaOZejyEpPrd5IBTf6NHF6aNOq2zNy?=
 =?us-ascii?Q?shoaFbrlR1qz2soXHl+FF5dHheendMpHE/1at/sy0h6QBogJqqEXNtsUM7YV?=
 =?us-ascii?Q?cWYlQLzpxs9SgP90M08Sg2RBcRoGpS11ZQ2rQOWdA0YopFnrVDxchzndKvL6?=
 =?us-ascii?Q?Q7SN1WbAg9ittA1+uNxGT1npHHH4za3luMu0YEOMOsTjNWBJgZZW/bbqJJMH?=
 =?us-ascii?Q?DTwhaPcw5VqGl4uA7cLER0rr9KhnMg7q2SPEcpTErZMDwXa6ZjxJVXygZFVn?=
 =?us-ascii?Q?s5SWDprx6ULYE+vkncU+qQaW/0+xk7IMu99P10joX410kinc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585d4d2d-b91f-4e21-1aee-08df03d3ed2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:41:26.3350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cgldHrRQwk1GzY5W8S5A8Drt5ADZPLBh2ogevWPlsXAkNzzivrJudLroiXNpiYMXTx1nsCIhvKZ+55AiJI0rg==
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

Introduce two PCI properties used to configure fixed BAR placement.

The fixed-bar property is added to pcie-root-port. It identifies a
root port whose subordinate PCI hierarchy participates in fixed BAR
placement.

The pci-bars property is added to PCI devices and accepts explicit
BAR addresses in the form:

    pci-bars=barN@<addr>[,barM@<addr>]...

The parser validates the property syntax and stores the user-provided
addresses on the PCIDevice for later use.

These properties are generic and can be used with both emulated and
VFIO-backed PCI devices.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci-bridge/pcie_root_port.c |   1 +
 hw/pci/pci.c                   | 129 +++++++++++++++++++++++++++++++++
 include/hw/pci/pci_device.h    |  10 +++
 include/hw/pci/pcie_port.h     |   1 +
 4 files changed, 141 insertions(+)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 7c3e78010b..cea39b92ca 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -151,6 +151,7 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BOOL("fixed-bar", PCIESlot, fixed_bar, false),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..1a326f6f91 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -50,6 +50,7 @@
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
 
@@ -88,6 +89,7 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
     DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
+    DEFINE_PROP_STRING("pci-bars", PCIDevice, pci_bars),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
@@ -225,6 +227,125 @@ static void pci_bus_unrealize(BusState *qbus)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
+#define PCI_BARS_SYNTAX "expected barN@<addr>[,barM@<addr>]*; "
+
+static int pci_parse_bar_token(const char *tok, Error **errp)
+{
+    int v = qapi_enum_parse(&OffAutoPCIBAR_lookup, tok, -1, errp);
+
+    if (v < 0) {
+        return -1;
+    }
+    if (v < OFF_AUTO_PCIBAR_BAR0) {
+        error_setg(errp, "pci-bars: " PCI_BARS_SYNTAX
+                   "invalid BAR '%s', expected bar0..bar5", tok);
+        return -1;
+    }
+    return v - OFF_AUTO_PCIBAR_BAR0;
+}
+
+/*
+ * Parse pci-bars=barN@<addr>[,barM@<addr>]*
+ * Stores parsed addresses into pci_dev->fixed_bar_addrs[].
+ * BAR existence is checked here against io_regions[], which is already
+ * populated by the device's own realize() at this point. Alignment and
+ * MMIO-window placement checks are deferred to blob-write time, when
+ * the full fixed-bar topology is available.
+ */
+static void pci_parse_pci_bars(PCIDevice *pci_dev, Error **errp)
+{
+    Error *local_err = NULL;
+    char **entries = NULL;
+    char **parts = NULL;
+    const char *endp;
+    char **e;
+    uint64_t bar_addr;
+    PCIIORegion *r;
+    int index;
+    int i, ret;
+
+    if (!pci_dev->pci_bars || !*pci_dev->pci_bars) {
+        return;
+    }
+    if (DEVICE(pci_dev)->hotplugged) {
+        error_setg(&local_err,
+                   "pci-bars is not supported on hot-plugged devices");
+        goto out;
+    }
+
+    entries = g_strsplit(pci_dev->pci_bars, ",", -1);
+    for (e = entries; e && *e; e++) {
+        const char *entry = g_strstrip(*e);
+        if (*entry == '\0') {
+            error_setg(&local_err,
+                       "pci-bars: " PCI_BARS_SYNTAX "empty field in list");
+            goto out;
+        }
+
+        parts = g_strsplit(entry, "@", 2);
+        if (!parts[0] || !parts[1]) {
+            error_setg(&local_err,
+                       "pci-bars: " PCI_BARS_SYNTAX "missing '@' in '%s'",
+                       entry);
+            goto out;
+        }
+
+        index = pci_parse_bar_token(parts[0], &local_err);
+        if (index < 0) {
+            goto out;
+        }
+
+        r = &pci_dev->io_regions[index];
+        if (!r->size) {
+            error_setg(&local_err, "pci-bars: bar%d does not exist on %s",
+                       index, pci_dev->name);
+            goto out;
+        }
+        if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
+            error_setg(&local_err, "pci-bars: bar%d on %s is an I/O BAR, "
+                       "not a memory BAR", index, pci_dev->name);
+            goto out;
+        }
+
+        ret = qemu_strtou64(parts[1], &endp, 0, &bar_addr);
+        if (ret) {
+            error_setg(&local_err,
+                       "pci-bars: " PCI_BARS_SYNTAX
+                       "unparseable address in '%s'", entry);
+            goto out;
+        }
+        if (*endp != '\0') {
+            error_setg(&local_err,
+                       "pci-bars: " PCI_BARS_SYNTAX
+                       "trailing data after address in '%s'", entry);
+            goto out;
+        }
+        g_clear_pointer(&parts, g_strfreev);
+
+        if (!pci_dev->fixed_bar_addrs) {
+            pci_dev->fixed_bar_addrs = g_new(pcibus_t, PCI_NUM_REGIONS - 1);
+            for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+                pci_dev->fixed_bar_addrs[i] = PCI_BAR_UNMAPPED;
+            }
+        }
+        if (pci_dev->fixed_bar_addrs[index] != PCI_BAR_UNMAPPED) {
+            error_setg(&local_err,
+                       "pci-bars: bar%d specified more than once",
+                       index);
+            goto out;
+        }
+        pci_dev->fixed_bar_addrs[index] = (pcibus_t)bar_addr;
+    }
+
+out:
+    g_clear_pointer(&parts, g_strfreev);
+    g_strfreev(entries);
+    if (local_err) {
+        g_clear_pointer(&pci_dev->fixed_bar_addrs, g_free);
+        error_propagate(errp, local_err);
+    }
+}
+
 static int pcibus_num(PCIBus *bus)
 {
     if (pci_bus_is_root(bus)) {
@@ -1479,6 +1600,7 @@ static void pci_qdev_unrealize(DeviceState *dev)
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
     pcie_sriov_unregister_device(pci_dev);
+    g_clear_pointer(&pci_dev->fixed_bar_addrs, g_free);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -2376,6 +2498,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         is_default_rom = true;
     }
 
+    pci_parse_pci_bars(pci_dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     pci_add_option_rom(pci_dev, is_default_rom, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..0bdc7ebce3 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -187,6 +187,16 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /*
+     * pci-bars property holds user-supplied fixed BAR addresses.
+     * pci_bars is the raw property string (barN@<addr>,...).
+     * fixed_bar_addrs is the parsed array (PCI_NUM_REGIONS-1 entries);
+     * each slot is PCI_BAR_UNMAPPED or the address for that BAR.
+     * NULL when the property is not set.
+     */
+    char      *pci_bars;
+    pcibus_t  *fixed_bar_addrs;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index b28af067a6..ef66c9768b 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -65,6 +65,7 @@ struct PCIESlot {
 
     /* broken ACPI hotplug compat knob to preserve 6.1 ABI intact */
     bool        hide_native_hotplug_cap;
+    bool        fixed_bar;
 
     QLIST_ENTRY(PCIESlot) next;
 };
-- 
2.34.1


