Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12020C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98OI-0000zo-Uq; Tue, 22 Sep 2026 17:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98OH-0000zD-Ez
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:51:05 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98OE-0000Wf-5G
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:51:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTzM/NKqTccEVIUt1hSXWQ/V4EUF7rqkZsEcCRcaLHyfBKRnw3eR7PhCcnpaqa5p5nYkbE8ySv3b7sqZAWBHcekjNXs9QfKPqkQTBiy4FbAJM41n01vVC13rLH781S5XYe34LNCAlHf8cSYXVdVtVGth5kMg0b7j16WR2gxXB5GFlSGmSglumlId/F8wWGLlGDseRTUWGuwkSGxVP19ssvpSY11PnMJiF8ylvdxCd5sb5Lga3G4Egvej9TvF+LKY3Y7iVq/GH/XDhXbIQGiy9zqVvuwCEj0RGlu4/TthcY09FbQflCgyyEzXFaIqMgG/Cf+j903i3dcksF4dz7J86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/IBfilOhdmXY3OPzd2Clf6k/xoRkk+PQrelyr8wL5k=;
 b=bjUTfqv8i5guxlYYN44ohwP944YUYNwJGAJ47F9zze0atzosexrlrYxVE4sgU5A3TG7VNtp1MOsM8ztqc/xPcDwF9xA1LnELYg0hAYCbF5e85qiV2qNUKrd0RO/BORt5/QsQN4Gcl4LNrE1IIx+1HrXuX92AhhPzOAIiTf5zzAAJxQjKw9izWWxWTpo8wk9GrEXKvIA/YVUn+r9S20OD4lSyFsADDW82xn8pFPU/nykYO8cUWCSk8UK3cIrtcgg9lcLXm+qXkPfbOyWAqFLaemDycWl5K8EZ1YRWVeioIdPBim5TM/88B7rse8uupTYJBMtlDAZovgWM2VIU3nBO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/IBfilOhdmXY3OPzd2Clf6k/xoRkk+PQrelyr8wL5k=;
 b=dmoxsqhTY6wGgxMyMbhS0X2TdgrXclgKvSq7GtfDss+QzvwD6bqRuVs94AGrlsHxuWHbgU8xvUO0cXy6Hs5IBh8Z4MF5Yr8VHUz0bEXJ0pJ1OSgHbfDB+Yxn8jc5NbFnvwdchXVe/ywJXi8p8mUDWWx7Flb1V+5gCKJbQbrH17pX/VKXtz3YVZdIMR8IWccLD+pDAoiTk2lv6WvNu37BFZcYvMxyGCFp0xS0xrLaYBMrpKaxQqzbsHl0Cd3ouQ5qrW14V+SZ1uaIbpq7ORqnhobo3qQqRo1Z5xmjZEEayZAKgPOAa+Q+PJBZ8xxxcF5eyLd4mQm3zntowkAUI1Xd4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH0PR12MB8126.namprd12.prod.outlook.com
 (2603:10b6:510:299::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 21:50:18 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:50:18 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH 1/3] xio3130_downstream: Add ACS support for downstream PCIe
 ports
Date: Tue, 22 Sep 2026 16:50:06 -0500
Message-Id: <20260922215008.2554402-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922215008.2554402-1-tdave@nvidia.com>
References: <20260922215008.2554402-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::20) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: d970bd2f-cc77-4c8a-66b0-08df18f37e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: s1FnN0DIcr5FgvSLgURGoT5+zDfkVKLBxpoJTtbTjAh8DmHaE7P3Fxsj/ePMVyHcVnrusWYBYP4J9KgHFYGH6j37ttjtoRx9NDMky+fgfcPFoc8M+uGBK9tJWMIaG+0+5Yi6hbJKvPAXrFdv8eFfJMj1taiiUMtO892w/HUxGrF2+rMfmbxdnY/UmGQUWWIhok9E7vXfq1eH7Q3Tz6IEX51gOf2xbU7rIG8PO0pxJQxNRyMiye9PZEdVgFKFa027gyDhexVd5h8pWnzfhzeoLa3i4QgQ2LY5LAGHUkzOJjWLO2lws93kA6Wpxf72u14opNF8zI5thrAZ5iDlr2jT/n+uCiIDK3qFKcgxGa+Y3tkdFhApzhKORYa44dVNEmpKCMALIwT/K3iQ4m+b0TjgSxdyo8qcOrZ5jVJyiND8Ld5qHe3XhpyrHWrFK+7eujGivMu3Uu89vcN6QEkskQ+slJcXu9r225jWgjy2rd8nHAGL+35u10E+9VdCMClyhAt0zV87Wn6bb7PxuTlvRJEkGx8gYvLyAYgFYxCPQHFjYSc5wFAndb/xwAujIUo7gPjGqFj9SmNVqbVpbCzmWzO4tsor87gcrw7wcZ6KI9EeRVUlpggI3wITNu/ZkmfVOQovH5mpZYY0r2p+1mmeVNgsG7lU0i+Sn6k2nM7n8W4h1JE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRLRdpEONfkbtkWUFUl9aekInH5sf5o2K/UfRPR9Zrn0ianQzDsI1apAHJBq?=
 =?us-ascii?Q?ndu5002fOX/o0PUMxCGZJ9kvDOwplPLSrYm5tsCFttb0xGqbPAoh+YEDO2xl?=
 =?us-ascii?Q?sae9o6FV1ONCe75cvbpS5jbD/HANoMu0uu3kwbJutbcU1HfN9+UAQxYbHJPM?=
 =?us-ascii?Q?KLQkZHPRUhe/Bhht4aPij/Qqe+YctgL/bE6oYJVEdu/DWisKnDVOK0j25QYR?=
 =?us-ascii?Q?sAnpkP2UBs4muu9uF7kSXK2ViUZD/m/zh7uMhdHNZ06IxO1r88s0FLscXFQ7?=
 =?us-ascii?Q?jtG63tv/avkY4z4LkDoPiAbLn8/9FBdbWtm3lXz5c5AlZ9AEAxVFTYD4sxHY?=
 =?us-ascii?Q?WN9XhBcpBpqR/cFzQGyBh7MGtdceAIGYA+USTJgxvLLL9LJtu5VNbRjH5N8D?=
 =?us-ascii?Q?59v29jwatAm6Z3jXvFH4VV8nhtcAn60lzBroSCd9sgMONCabkqs6utCaGqjb?=
 =?us-ascii?Q?3nxGsZ+j2X1s9iKLK/8WReunDjGu5GX/nxl2Uwvinv76uUlCLp9nQ/7bH36s?=
 =?us-ascii?Q?RvaHR7AI79UO3f6tLdtUKzgyZQKRQkYv/kmyC1MtY3Z2X9vzS5y4g4k7J3fR?=
 =?us-ascii?Q?XLS3UxWZA/J4y46JnhgYlyJDLtwDfh820KF7zSNevfuJ0mfMC6cZ+BNPT4dA?=
 =?us-ascii?Q?bmM4+OOjqZvczpE4IWKST+w33kWdmMmrL7zEvsT+FuRh2PO0SitBsC/jnoBa?=
 =?us-ascii?Q?WNv75OvZ6Y0KDXaMdSnPEPdMN3dbP90wPkcLrt+oH9+38gb1oMR56KiafxZt?=
 =?us-ascii?Q?ulGJTkgHW1+KV3CwEKF4JdlYuhmIGyFeMOGhtAJIxVH/oFc4nU2J3aizDMEb?=
 =?us-ascii?Q?oP1l39DeUmZVH+6Zf22UHQTkaHhL9nztpJ5pk5H5wJb6Hsp5NuT64wSsciGR?=
 =?us-ascii?Q?A0ewQPnz4fbA+0quyJzifVRru+7MZaCPSsE0PJs2eTFsoQkXodmv8zHN2O1h?=
 =?us-ascii?Q?14cFGWN/9O6XB5PfaH8EOLviuRm7/FkhuziXM3Gb5m6RIiK3VgRv5R9m3/nm?=
 =?us-ascii?Q?0kQJ4aoA2dwAsWneddsLdf9/UZM8UoHjqnpLjNqYutNLrYt2bfKa6DvI0onU?=
 =?us-ascii?Q?f4QWD5qDdTAfGW8cJ+dct3UgMpqZX+UeHpisg+VqZ8H+E3ma3H0Zsr89wsW/?=
 =?us-ascii?Q?LUQcBceo+Jbd+j38lTz7muR71HPjEJNAhMxfBsxPJgQXkHpJZCoK6QpPjh3c?=
 =?us-ascii?Q?7azZxxvrNKtnXwAC0i7d2WMociwscQpaeK+ioc9NUkODRIK8Rdvyulzshx0y?=
 =?us-ascii?Q?pIFtzQk8rfSD2U649bC7RzkTi5+7kyFJUKgUnU3douRCDxdK3Xv08HCKGb35?=
 =?us-ascii?Q?H6uOVAo/umKdIY+tmp6mQUS7ddF+CvN/vlTkJ++cq6U3AmlLGonoylTz5p9l?=
 =?us-ascii?Q?Gm+lkOHPu9TlNK7+TyJhqyiWp/aQvXL6joaa/D8fedZRwqRWFzy1tPkR/1TA?=
 =?us-ascii?Q?AlICSHt5M9yElQ0dQ7Mc1GehwtI9Z6Wj+yvxN32Fa2tNJWov0ZdG8KSwc65X?=
 =?us-ascii?Q?pJxI2CbOmCBeyWTLMu6SeYB5VhYcXRBXqfAOnDBiwTR58nP+dJFWPHSdHVbP?=
 =?us-ascii?Q?Ffk+8KpeY2YTqEWPTiTgzMZGEZb5p/ndsw7LyylnaMp+A9VD5dmyTWIcnnIu?=
 =?us-ascii?Q?av5P8SNlpIRpDpKqm7MX7MuuUL6slXLOnONmmmur3MhIRSxMR/tb8aKOfrYw?=
 =?us-ascii?Q?e0RjmRVScb9gW52oGGr0hsrvVQB/Pt9Kp6BuplB4N4br2ed4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d970bd2f-cc77-4c8a-66b0-08df18f37e64
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 21:50:18.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdqoeWxMnKdV5cDL5XA3n9Cntf72pvlLWr3ARyHYupDj1uVkdG6gmewLRVXMZu6iQJicNzuZN+cBytptAiQ9RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
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

When a PASID-capable device is added behind the PCIe downstream port,
for example, an Nvidia GPU, the PCIe downstream ports must expose ACS
capability otherwise PASID won't get enabled.

In addition, the other use case is GPUDirect RDMA using Data Direct
that must require special ACS controls at the PCIe downstream ports
for P2P communication.

Gate it behind a new x-pcie-acs property (default on), following the
x-pcie-* compat-bit convention (x-pcie-ext-tag/x-pcie-err-unc-mask/
x-pcie-ari-nextfn-1), so older machine types can disable it via
hw_compat to preserve migration compatibility.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/core/machine.c                  | 1 +
 hw/pci-bridge/xio3130_downstream.c | 7 +++++++
 hw/pci/pci.c                       | 2 ++
 include/hw/pci/pci.h               | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 92f7be52a1..4fd48f594f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@
 GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+    { TYPE_PCI_DEVICE, "x-pcie-acs", "off" }, /* Added in 11.2 */
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 0c3fed3053..87ba30eb36 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -40,6 +40,8 @@
 #define XIO3130_SSVID_SSID              0
 #define XIO3130_EXP_OFFSET              0x90
 #define XIO3130_AER_OFFSET              0x100
+#define XIO3130_ACS_OFFSET \
+    (XIO3130_AER_OFFSET + PCI_ERR_SIZEOF)
 
 static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
                                          uint32_t val, int len)
@@ -60,6 +62,7 @@ static void xio3130_downstream_reset(DeviceState *qdev)
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
+    pcie_acs_reset(d);
     pci_bridge_reset(qdev);
 }
 
@@ -111,6 +114,10 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
         goto err;
     }
 
+    if (d->cap_present & QEMU_PCIE_CAP_ACS) {
+        pcie_acs_init(d, XIO3130_ACS_OFFSET);
+    }
+
     return;
 
 err:
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb..807729ca75 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -105,6 +105,8 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
                     QEMU_PCIE_EXT_TAG_BITNR, true),
+    DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
+                    QEMU_PCIE_ACS_BITNR, true),
     { .name = "busnr", .info = &prop_pci_busnr },
 };
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a..dd52b9639e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -231,6 +231,9 @@ enum {
     QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
 #define QEMU_PCI_SKIP_RESET_ON_CPR_BITNR 15
     QEMU_PCI_SKIP_RESET_ON_CPR = (1 << QEMU_PCI_SKIP_RESET_ON_CPR_BITNR),
+    /* PCIe ACS (Access Control Services) extended capability present */
+#define QEMU_PCIE_ACS_BITNR 16
+    QEMU_PCIE_CAP_ACS = (1 << QEMU_PCIE_ACS_BITNR),
 };
 
 typedef struct PCIINTxRoute {
-- 
2.34.1


