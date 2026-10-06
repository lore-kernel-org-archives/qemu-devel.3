Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7EFCA5FF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 01:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDu2e-0003dW-UI; Mon, 05 Oct 2026 21:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu2a-0003dE-Kb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:32:24 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu2Y-0008CY-RH
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:32:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL2KINOqH+HKMUntfUW1rLyuIQ8UvKz0jp1G0wfgx2msWBSpSJBzJ3GkkJP+89UchxJVoAY6CuryoMNC3EP0B/9J80SLZakZHDvjP27EhQ7D73T8KSdoltjgpahNZH8J8EXccr15TGxmHCaSPz4/jaRrMoGLy3THwEAH9z09yPGFpUG/ggZWSw4/dGeNCkD6fdIjZZaCEHglUQXX2J+54Zc5j1g88JLTMywZSw6XhccUyhwnkTXEPUcxbhQBxAhBBf8Muwrw87xCpDnsr1A65S7H1RK0XYwJOldCoVvUuqTZymhOeMgyX7NUeLOLrYef0YoEooXY019q1i7O6fQw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGJSNE30MAS46WVhfDrDgLKMWYFTFCBdBkwbj1gPp+8=;
 b=UW6kDc13kJZ1Id4i9jty1QPMSt2rtsxoXgK8okLozkHVxgcpQpQqo3cI1t4rqidYVRZOT0qYzyfhmWGWhjGotXpPQI7u0Tw3YjhEZvKQojxGIchnsy2nkeLH93WqgKyrLmzK51yfyIFmzSfbQag907RYi5uueSnJoPXLbC9Pz8bUdHN+N1RfIlON7IZ5Mus96SJxo4Yc4Tgz8bxqSRujiL0QpLY1wirazNqvlD+JYRakF+mixOMks0OKdPWgDMSLAyQyY3+6eqLZ2K5NuiNOFf2xdPhS8AlYF3gbt9Tdgq8XGIa0Y6aW6auptgDv81unUQ4yoN+ewgUvGyHEXLvfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGJSNE30MAS46WVhfDrDgLKMWYFTFCBdBkwbj1gPp+8=;
 b=J8Rk2xuEkvxbF4DsRAE4/k4uBRJIkEmq0eyXQgRxPlJoodpnC9cNwprXxaG/3RCRPkxNBBFQzt05ZRKXsMFEtIKkv3OIJfKgxK1W56865+641i7HFmXE6fs5hFDVhMygus4SCm6keT5AMDpBUCYO/pMNZf6QM9Pc/gSJyLYVI573pkafCHrnrwGJnvqThGswjdpeMOLIxQHAZmp6BXLZFX85KCGL5I8Py3oOIXLAypAj2TmE3JWImndm6eeetvM8364zFYGHtgXWH5FRUxL5sjx4ydYvx5XPCRsjPes9skqp9xrTQv+oSzdEFpDLhzuhiuldwhsYsWWnaXjWu17GkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY0PR12MB154213.namprd12.prod.outlook.com
 (2603:10b6:930:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:31:43 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:31:43 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH v2 1/3] xio3130_downstream: Add ACS support for downstream
 PCIe ports
Date: Mon,  5 Oct 2026 20:31:31 -0500
Message-Id: <20261006013133.3457555-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006013133.3457555-1-tdave@nvidia.com>
References: <20261006013133.3457555-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY0PR12MB154213:EE_
X-MS-Office365-Filtering-Correlation-Id: 48baa558-3909-44d1-5efa-08df23499435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 1FYwBH+cnHYap6aHGJyi8OmSQ2/44+Xu/mPIpF1P96FIAmCeVSYQbE9TwurnfaGe/Ce7tIfgiLsS6oDIzx/oy3YsgcRmpqhocp622rDRJjHW44Y57Y0RYTfKEuvHHC+XhVNPxSQQDGG793S9aheAtkGG2ft/mBE2re/KilhvsFKJircR1c9jmjRXX9u2bnp0nFQsfgoe1Sh7GA62v0uYK/jLI9b0PrtO3LwUo5VTRgBrUdnJ1GWLnl0keOC3SveGo13RScBtp6/x6dDuKts8gleUNJrTicuIqjz8WwmXoy+CdXJxuyafl7nHilRLIcN3Z1/9v8u66zEGy5lpDdGexBka/yVuZRnNiHokgZHh4kt05KFarjWa34URF4hFL6igW7nRzRGQYEKmr5nJ7nnzfFJm/ZAMwAe58vbNwN5ef+F7ytliZuAG5mFTl5FZYTQ/wraHCgOjQRapu9l7by14nH/+FI3lcfI7vuau92SL/B9nV326z6wgyNpilCxdW478sF56YkQyWD3PtRvSOYbjsZMTqN41kPNIGSU0/s5uLTK5FfERu8HfSxHC+iAN7kigzC1eV3mioWlI8AI2ss6sxLWBnO1UGqg6EWt5Braw0QRmeX3sEs8itQyX636UQIyTb/5UexRAlv8S+CmLUB6sfmwNoIwtUSFW6bmPGxggcfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cyrrDjrq3sAVCv9bFnWEgbxkVK9dbMpVGKS/BAtsd+2w+lbuBzB9CqTywq9?=
 =?us-ascii?Q?HRUCFHtNCLJLHFloBKfZJ07TySHWPs6rtuE7+ZIguH4K5b4jvJ6McJdCjGF6?=
 =?us-ascii?Q?o/Ebv+723KY+i9hLDlAe7B6LfUo6qAw9KisiU7sWkzMw4ayUk5m6NoHhB/I3?=
 =?us-ascii?Q?myJ2l2GdeRkALnfXmBPwtva1TeMYAxdJicmsGh9ARZMdSD78lZygbMLOKA/W?=
 =?us-ascii?Q?kZ8BdUijx76fgGxmXPESQQu7rDfldV9tfE21vNjxE656lj/RlLoycfRVVfj6?=
 =?us-ascii?Q?6WcFtSYVn7T1EUjsHFrBROeVzo/O0+iAdA5RlJrHrF6yxuZ9OLOsRzBT6DMY?=
 =?us-ascii?Q?mq6YIsdSK9uHoedvC3opAgdBwQxeNHFYJCDKbCakyumHKWMmtmfZ6hK4a/A8?=
 =?us-ascii?Q?OHkDx69Ae3K7SUaru5/5RI10E9adT94pztyUEdFWaZzqoalIfSWE8D5nePax?=
 =?us-ascii?Q?Qn/4/QYj4dkS0JEZLFtPZt1ZAF2Z4VyBxkBUJP8myt1GwujAHdFA6FNfSeQ1?=
 =?us-ascii?Q?SfTX6Y9GIi5RPJK5m8AnJGEBKHExjFZNjhaI6YvzRT5/uRZWfa3uV18Oap+/?=
 =?us-ascii?Q?iZC5R9lxsr9ykHKEE+1rxqDjmq141ECfu9ufVqO+dadFyddOcMptTZQvH06e?=
 =?us-ascii?Q?EQOAZWJDEPAXshKm0/zmsToeYSE7bACZc7qDuV1Yb8DNZTE0j19FDrQ73ugf?=
 =?us-ascii?Q?iAV+g0WQFzLY6+4Sz+BBBmDuLNyaw85HbqKPE1i0UjAEiEQqyd65HhKBVC3T?=
 =?us-ascii?Q?BTnVv9loFKF4yXcRlk9LFYyLQymnzT1J0EpDZT12SNORwDj1WxdNom1mCiXq?=
 =?us-ascii?Q?EFgo0H9vNKUte4LBzOPzKqNe/TENA0sEUjIMUNoZUC542qgGaQHDMN8gE3XT?=
 =?us-ascii?Q?v2a6xBfOPTrBzfKbVQ+83PKX3QYRUydeAqZU2NqbfdSqIF8WqdD+FTY8YRau?=
 =?us-ascii?Q?PgBRnkHUXXsAhQ70zKmIAwLtXwhiH81L6KXN/pNwT1pHlkFOJpaLAvzMlbLV?=
 =?us-ascii?Q?fIKgj2aQZtX019R8KyG/i1YP6+m7bUfiTdC8tTusIK2V0qh92due8wTw57eD?=
 =?us-ascii?Q?/X77Alwebc6nsejyV/up0p/8S0lLPOICmj7GFzjcM+U1Yv910hEjQcinDHEe?=
 =?us-ascii?Q?5cOUqzMpaCEFe20GnjINgYrlX1Ul03mLeMzrhYf7P86WnxazRPlj2ed+Xwys?=
 =?us-ascii?Q?OG/2dQvzAbBbhfQcrsFv4uDGQsmMuM3exlycQgU4L/EkT3PqiUjd77TkW/ne?=
 =?us-ascii?Q?S6NvW/joQ//TVsKqzyRXMGiGCiXArBaUnAgD+zUmoX2ORg7PHz3FOC7yY++t?=
 =?us-ascii?Q?Kr5xRsMcJbQGBklUbFHuCsM8HmR/Ab15gezFRyzN+akn3lZx55dDcHsipoYk?=
 =?us-ascii?Q?USebF1x64b264GDB6YOaLnRIhWqWcE/QVBsrJ9mdQW6g3NizrrrfyF6luzaX?=
 =?us-ascii?Q?Uyi4+UdwJSh+U515W8dhTLehp3TXPmAH99BQ15xHsDS/E+5k/05NmL1dDEpj?=
 =?us-ascii?Q?xw30wfzTvPHgK9wJ8SqPux3oQ1fm89TH0ugS6Pe5jh0IXmwWW/QmjvXmgrhL?=
 =?us-ascii?Q?YY8ooqenLzt8F4viBWZYw70pzLv9Rrg7iF8t9ecj29xUNwYNn7Ymkb1fRcUM?=
 =?us-ascii?Q?ubS0t/F90eUGlqnv0gEHw7thokdP2NO/VJtdi2X8/wcM2Qzgrr5TAXuAB3I2?=
 =?us-ascii?Q?JBAONKsX82/ka0t4zfDlYXWTE7VDkAIXLL/4zTiKLZyFEKfA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48baa558-3909-44d1-5efa-08df23499435
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 01:31:43.6608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpIrpdaVZ8HITOQ4xOBvt3P/8Ez7AI/P9jdx7csP7W1FWOZv0gDlxKSp9tvHAP3GFGcFxSyyuWDOvBqVS2KTrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB154213
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=tdave@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
 hw/pci-bridge/xio3130_downstream.c | 9 +++++++++
 include/hw/pci/pci.h               | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d9ac4b419a..b1b3911430 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@
 GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+    { "xio3130-downstream", "x-pcie-acs", "off" },
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 0c3fed3053..6a9df5c174 100644
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
@@ -137,6 +144,8 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
+                    QEMU_PCIE_ACS_BITNR, true),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
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


