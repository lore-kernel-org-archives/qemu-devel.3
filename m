Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10260CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMstv-0004d0-TX; Tue, 12 May 2026 15:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstp-0004XM-UA; Tue, 12 May 2026 15:36:13 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstn-0005nm-2f; Tue, 12 May 2026 15:36:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEpd3XfA4OnPMG3/eCzEo91Oxkoxjil7inLtrK6Bdj40Q5b6zN1YXkwQt0LdEbh88qEnCQ2RhoVFUNO8gfFYLprZOk6VK+P03SIiL0mMhGjlvk6eHIIAiolUWINHVcuw02orh85ND4O1LYlhWEbTo4+xn/DTvHvQo9EcFg+6XYlIPj8vhxzd7P45PYFL92dfXllNxkInOIpUxn3huGCmmHrXfZHOhtm4KsC6/zBNBhLeh9NjeaKkEnOcWXXTe8wFpEqhiH7S7QpUzO1TZ/xZvRunUDjVzkw+K2aOGmhfEcAO6EFjuz7EsWGfZs2Q9TGH4WFWsM5uTkZGmG4oA6uPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZq8lwmT16a02zEvdkf9AIsMuxbwSxvegJWOMaZ1oNM=;
 b=ZasCS3C89kaaTCKKjqXSs1w4Da1dtGiAMdr5R7QlwTxrBy/NXwfi7YP4MIOkP7mols0FVVCj3/9NWpuCm9RY+eD3AjYNiErBN8tscNJSgkj2OoORTsw+ipqEpsOpsEsvvKVnSw7SM9qDsQbH8sAgJpCleoHoVhw5rDb7eqt/EIZoc8DTvvyYtg8thwpQ57cDMef2fKWZOCMlCUA+CpxpEMnYs0PtoA/4bYZ9AvdQhwdCP969c9nUS2aKCkX5S05awrww2nJ6F7JwClY9BMdxGesjsBLaA0RuB339zmdvBC6N5kMSbA5ps8PntrWQGg9ODQeZdBufS9KhTECqUxleLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZq8lwmT16a02zEvdkf9AIsMuxbwSxvegJWOMaZ1oNM=;
 b=XmiF8g2rUCPIPLzUyzMo2h5w1TqVr9Tu3D3/Sc3C6REI+xcII1zhcanmsmsIpJGQPO7JBqtNL6P6fUaQYR8XGCbOYsYBO1E6GPg611qZ+rIR4dOjRwQt5WIpg2e5mX8DzGdJCOqBNjCjhyck3UoArLschQLHA5220/D9AtaxRNKYrhNccv6uEpQ4i7sl5Ox0AcdST7579qqriojZNKrtEgbrDkA6M5Do/0j4q/CEu+FJ7+0iqsbau8h1SEScXowoFx2clAcXlFQ5haEEq+VFiqpS143T1GyzZ+rLAqRgpP0wlhD5ny1oUmIPUjjs+KfK3UPz44RGb+g20O7FqK67zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:51 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:51 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize,
 oas to auto
Date: Tue, 12 May 2026 12:35:19 -0700
Message-ID: <20260512193520.3109172-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b633515-565d-435e-ac7c-08deb05dad24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RFc+Jgr/qNR6tFFSUeiV4JDR4jZsuLD2leOoXu42SIbl2u7kZrM5ATfbC33QdifoQ9oN8kHaAhY70rTvde0jOQyWhnoUjdBf1FgPLH42fuYsX2Y8GU9N1Vk6MFULhQysIPkkjehIEX+tMs5NRADtHE0dYI9GxGUppRRMcIne4tcCTYH5E5P8nvG1LUPPkLGB/tfQUUdEYEb+928ICH2ul0qxZNFaeZAMBYER8rK9E1Ptq4AY5bxdchGc+tBVCwASLqFBgxAjMxZwFTanidIh9SKES61F8bvUTbRUGwy5NawLVPaFRbQamYnV/tnSND3jDayWHlY5pOe/Zmv1iC407jkqwYI5QT88uVAdhcFzZHLJzg1hBIeNUxchBOPMw2N3IVJiygrM8r/aAcssCoVzgLEW5m7fEv4BkS1IQ8cExFaEJGNT90kVsK2Y1/f4R1/bONSuWfTRmUYRipvh0GWz33CnFha+pm54QSgV+vo/XxUSrZIV+mbmZ5tT8kNa9UOdcqM9oqhzUzL+x5vQxXSe3z1jmIF4iZYHTmYodBOKeDgLp7MNJ3GzUioUQMO9Zt4FbgbHr7nb1H7DkABepYQlN6+Hpvca4J+C4p99ujEce8GHp6eH6Ov99d3GfW56azSvbKSRI7a5nJIGB6Fa8TkdJd50ZLhiLmF4Bm148PmufvGSOu9Ava0dG9vMy8kWQeoI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wKltpAE/LtGr/Qbq9F8LMXUovxDCPoa2Sd4GrVXyX9kM7tP2G9ul41+Je4ou?=
 =?us-ascii?Q?5jNavrJStsFvvECL2IOvaJFrB+w2xCfuATvTCmQryKQwuphOcswX5A7V4TMy?=
 =?us-ascii?Q?nLJmsWwGH7NZpk547Ef4ry4zL94IjHHHc9Y3CiTVVhMemMhtoGb207zx4He8?=
 =?us-ascii?Q?oKi/VjnF9FDTrwOKHUCbHFptCPL0/rPwmwJFjh58SxuhznzF0HRKK6N6S54w?=
 =?us-ascii?Q?w0TuJEGcmeXFwjaQ1Yo6puywI4jzKuMAdGnfK6j60hPHa7TqPIi7E/2q0YTx?=
 =?us-ascii?Q?pB/QjxesJRwnA5YRYvLfoXxS5+YRLUEB17fvY8meL+sLpXQ/2ofIAKsFcblN?=
 =?us-ascii?Q?MC52qp1F/IPpCAk0mb+yGuTGZ1IcEj2auviO/yBZEyALDlxNtLzbmRjmGSFl?=
 =?us-ascii?Q?3Sa4S3+22I171J8H0k+AZxvZrGVI6BLtZiflgnze6IzalFphfYT+86CMj30m?=
 =?us-ascii?Q?UKaGTX5sj5GZZ2vJBCZH2+Qwl7tYDrBmvlFNCVu4wafbqFW0m0KN2aj1iHET?=
 =?us-ascii?Q?hh2WjCP4yobjZ93BXp+Jj3/9316w0f0LBvUCXuL3Xz9wQKNCsR12OZJYHWc6?=
 =?us-ascii?Q?1v2ioPvtWRlLKm5vDlPTxwklBcI+H+bEsGeD4iEHUsxfSYOhycuOFjV97+yQ?=
 =?us-ascii?Q?GDwzPIZlMC8UVhH5t3f+vW4dQetQ4WGx3PYHTioZy7rWVSo85Kb/M86nSQBe?=
 =?us-ascii?Q?gdTY9rfM2Ivr/n4CpZ8EfbLDhVoeTjnpxDfqhoRtYAEgaEn+YnSdv52L//zK?=
 =?us-ascii?Q?mcJAtZ1VbZR7XPBhoKOOjn94gN9+ba3azp5dotYSUoAN+xItNVrmNGotD8DF?=
 =?us-ascii?Q?peRrIXrfDRmT94qRAxjQZy/TIjirqL9Fbng2ZjsXTCM4oWcAeNjQjXyzItD+?=
 =?us-ascii?Q?Mjksdg0nhr8awgNL8bxb4eLJmaoA3GaALW/SKJjOk6xuHxag82LFSim4bglm?=
 =?us-ascii?Q?H/n6vBHqJ12FTNdyoKnQX4j3qGHPDiWyUZLb0XXPxYzbhxlJX1i+4WpjL7Gp?=
 =?us-ascii?Q?lljj08WSTcvxPmAPydLvKRH9QgWBZabZMDlNQkYhjdXMDIuxpqNFPz1oenLA?=
 =?us-ascii?Q?qeAMJXdiKKLgR+KeRCU82ZsE7gffzM+ipsj9Q2PuMvK8D0J9smG7VAWJEScg?=
 =?us-ascii?Q?AtjyPKaV1wVJHVNfXQGv9c/ahW3C18ndo+NrLGjnZ/Ft7uRUqSsyRpA+ttkU?=
 =?us-ascii?Q?eJtbQvet3sFvP9ASCTnKyv6QnNGxaAFDYA0HQTkndq/oLYdqxMdDnwyEM306?=
 =?us-ascii?Q?oZcxzrBeF2BQVLB46sgdUHQeJONQVNuHXU9cfK1KJPDDkHSqgy5ei/t6pa9S?=
 =?us-ascii?Q?KwTu2IbJsdg/+38akwm+x15h8nyIPSe+1mU7Zl6H+Gx3CaR5+jHjKD2kMERS?=
 =?us-ascii?Q?9Oba8pWVtMP+awhFOHcc8T02jxcWiBbAEvtXYmrnstObNVWvwsM7+U1UNOxM?=
 =?us-ascii?Q?7Yh/OX1TWHGWHMAMeLtS0ZEO1pPM1r2J+q2EEjzb7hN2DagmfZ4t2Nte4qhn?=
 =?us-ascii?Q?YJJtDQMGnqmXqpiAw2UDWeE5XZ9OPRYEvYssMgG/mQVN0/F2Y92vWC9sGdIA?=
 =?us-ascii?Q?7/aHgfquQZAm+dh/MPnduVW1Krmsl3UrK/ZPMtCzH6nM4kssIFcfE475jAAP?=
 =?us-ascii?Q?wcXfWt25pnJVeduMTx/n11iSZreN7KudLzQncTRSUmqSd0RAQUIONMeDpmfD?=
 =?us-ascii?Q?0YigYEL5sNKvlKiyfPD4uffAzja6Hgh3b91MHDxZWn1P9MDT/zhHjjUGcrFT?=
 =?us-ascii?Q?LwU1EfpArQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b633515-565d-435e-ac7c-08deb05dad24
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:51.7832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKroXTf/+hiE+FPbJh+NT1SAdpiRNK/zMZeBwnN92YfK2TKgSNtcKx7JjHfoJ/gtUzK/7QlLrU+FLdf8L7IE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nathan Chen <nathanc@nvidia.com>

Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
to match the host IOMMU properties when accel=on.

If accel=off and these property values are set to auto, the default
property values defined in smmuv3_init_id_regs() for OAS and RIL will
remain unchanged, while SSIDSIZE and ATS values will remain initialized
at 0.

Introduce a new compat for the changed defaults.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 23 +++++++++++++++--------
 hw/core/machine.c |  5 +++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 31c2eec2f4..665e6a2538 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /*
+     * AUTO values for accel=off will resolve to:
+     * ril: on
+     * ats: off
+     * oas: 44
+     * ssidsize: 0
+     */
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
-                              SSID_SIZE_MODE_0),
+                              SSID_SIZE_MODE_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2162,20 +2169,20 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
         "Enable/disable range invalidation support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to on. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Any attempt to turn it 'on' while the host does not support "
         "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to off. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
         "Set Output Address Size in bits (for accel=on). "
-        "Valid values are 44, 48, and auto. Defaults to 44 bits.");
+        "Valid values are 44, 48, and auto. Defaults to auto.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
-        "Valid values are 0-20 and auto. Defaults to 0. "
+        "Valid values are 0-20 and auto. Defaults to auto. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "A value of 0 disables SubstreamID support. A value greater "
         "than 0 is required to enable PASID support.");
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63baff859f..3339da99ee 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,9 +38,14 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
+#include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
+    { TYPE_ARM_SMMUV3, "ats", "off" },
+    { TYPE_ARM_SMMUV3, "ril", "on" },
+    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
+    { TYPE_ARM_SMMUV3, "oas", "44" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
-- 
2.43.0


