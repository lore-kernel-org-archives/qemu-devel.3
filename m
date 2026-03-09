Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A85BFCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgBf-00051l-MS; Mon, 09 Mar 2026 15:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBO-0004wp-VJ; Mon, 09 Mar 2026 15:22:28 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBN-0003d7-Bt; Mon, 09 Mar 2026 15:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrPIzWGR5RoR7e6ZGeoOp7KOSob6WLsAu6mtvj1Q6iazb1fk00V/4BBYGJHmKagrq/ZWQiCOI4xacvoGYmTMLAPzQt3OWzWVqpFhmdYnc35AZR6B+i4Ye29q2lojFx84Vz/o/GkcMxp6WkXWnGjEmbAZZkyfPJCdXLLqn8sIshA94dUszxF+PEud7ZeAwmYbEJ4YFZ2v+EkYxH0A+AzmbmoZsvRROLPzuDvJIZFDnsS10jyj07/8UU+T1Ahk8rc1epo5IxYOQL5kUiYQwCbA6DD+IbuC5DZO+pVP/kEBiqEeQZdzaKWnj5qSAE8TO2wQt81iVcKdzaUkqUKoOioOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1Jxv6VXB9GIZaCGk7Zud3TQVKBZ0iDIPbNC3t2Jaiw=;
 b=I4Z/vxFh4zBDBzLpkpD5XM/mjTtbBbXZ5YaNSy5ed6Zjv3jBoKekWT845Icd942DPjJRnu7jttuaMjgfV8VO9aopzxif96CR0RBFXdVi8edGN3Wabs35YT/C1xG7S/uyNdjyb7Wnl9MkO1ZGxBOOfysrA89FQ9bNkszaM0xxBs6gg6eAQLJdBqr1PPybj8I0eOQdKGCD+tPGQ7wUiL/IATUFfcGj9rXNHKOuSEcmgzAsQhjZFpgaJBm4x9YpyMp3kAIVWyi/Ilv9s03jZn/50TpxunoVx4CD0jNJ+dUiSAKLr7Nhw2F0E7vt8QL+9d3z48Dl0yjfKspY7xKAROGcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1Jxv6VXB9GIZaCGk7Zud3TQVKBZ0iDIPbNC3t2Jaiw=;
 b=npbf77TNxBxU6lNbmA2nwuTKWFivJM46zt/UfmaRS+MLq53AdAUr6vPtIwsMO6ezqus5/fJtAsbIW8hSasF3M3nbeR9Wli8CnZdMDBuPoejZ5ZiKAasGxzbiOO1xQ8hPgGsPvOOJ3q1qOyIf+BwC3jzCh/5dI7kVzCtonEMAH8lD+BAJNexuHLcSwrC4mrGmR2r6pNEm5kK5/KZZYsCUZhJir5xyDc8hcr6x/gR1XXcZ7qCTZrMftc6a8dDyvwBseOqFcEQCmtZuTqpe5WZLq6yykQ2K0AlBqo2IKIKzsozJqsYcCHcobx/t0hfW31UgnwfIr3cIA2bnyK1gkRAg9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:15 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:15 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Subject: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Mon,  9 Mar 2026 12:21:12 -0700
Message-ID: <20260309192119.870186-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa098d4-1c9f-438b-edd3-08de7e112bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: qb+/uZ3h4ZAe2iuA1GBYVMz7ExMrHX+99jowmWMZ7kd9DTiA84fO3l+HevNBM/f8Ffq3yQDPwk3rU4F+F2yhFNOS6jPFjJNVAtVKg4DVowFpVfm59PO1N90BIHZb6m6W+eafaErKd5vHzwaS/HBgLk/KXJuADb8ZuwOKMQmwS0JolCVUGigR5AbB6WDLO6gF8mctVwsmX/9UG2o79yx5xH81vYbY45S5ZKq9nXBU2PDd/We1cz2sLs+76yXKghtKNFL/Ex/aQy/J/wNF0af2e+RIVXSxOSgp+05ryxa6hroLoodOeMdXH6RW3UzQt0fJQYGNgCOP7WmsGotCjSPVlt5q9rnjnXZZyzJumaWwGOO8oXYHO32JVmcJr97+iHkLW+Vwa8vGx8CI/MiWWWIoZ2426CtXDZSRrjgsFa0up8yBWJKEs5y4ORa5LNpiWKCUQV/4zjOjXk3CY7yFbUl8gtDvbhMmWsJ7sa6+Riu84oeiVO9Ims/7Wp6Ci32Gj0wceV9zmUM3Op0dxYXQmZCWtef53EQNDjkZi3LqwUYdaF68Kkpkzzqc8W5VxB0mYvIpt3Kd4gUxyfwYtKs7bA2lXES4sqw5VjBh8q0Ctw+lvM8weS6qDu9TCsTWCGmqK5G5iipix9Faovfx3AP4rUvlM22Xnc1uFPIOhtN7DymjVed6J9IZcINlGa2es7adikFR9Dv4k6swMOKIVGXlS28efMNlSLmWmqgSMpFM+VDA82A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKF76Y3ePtQk2MomENtZJLd4uW7XAi0u0ep7RoXdBHk8TlBO552qqrSfJ3NR?=
 =?us-ascii?Q?f4HxAzLshLo5hAs8dWCH2B11DIK48yu5dDJH67vKb9/njB24/cwHy/gPHuoC?=
 =?us-ascii?Q?CU0TcyeM+1/9mu3H3i41LHqiPARyok7tZ+iT8RRpg+3C6mSJKLjGumCTA6dY?=
 =?us-ascii?Q?f4rAp28cNtTx9cVcwcSSL4XY1/dKZQhCl6xdZnD80dIED1D/lzWvBkyg8zeM?=
 =?us-ascii?Q?eGqKeocj4qJmatoZBlIWOMWm62yH7yZ74KtN90+X/DRSdsUoWzdB7aTsQuFk?=
 =?us-ascii?Q?gKWytMur0JZw/WHfFb4OWidImCOdYvdeHUJe2tHzO4oA6L4kYfzC2OIVYdDo?=
 =?us-ascii?Q?xPig4VGZwbfF/Lz7uWfgAhWe7q1I+1WFrCUmoly/9MVOWIJsmtTZeApgunEu?=
 =?us-ascii?Q?7S8qtKSy6AK85b3FjR5nmNhUAojzJMwUPh55KnEw7LQRBxzwvokH69FyVzbG?=
 =?us-ascii?Q?sglhazd+uo1XoXtrcHgK8B+ToVnh6Z6oo7GNIDYVUylPGVmO9W3giWK12yco?=
 =?us-ascii?Q?fBvj4USna8pxNheB5OvejkxfzAmOe5b9CnD3XnHMiNEY8hlwUrmBULJ05v5r?=
 =?us-ascii?Q?flYi2LTA+2jokd0PqfGtfCPKI9Ov8Uu0q6Ugg9Er8W4uxq2xP0wpJCX6cT+A?=
 =?us-ascii?Q?OipVqrXp/onJJbEVUsAcWgekscx2xWltWuF9fHfh6b3Nbnpvvti62Q7i8tzQ?=
 =?us-ascii?Q?JsZ0yG0PsmkHCXCtYe5K/rRTC5qAwTTo9Y26dzkBkXewPvGsa+2QLN11ADoX?=
 =?us-ascii?Q?dJRaAPmxHNEqLPud780OQcIHSvgkG7cVRWdAcALnjFu8lYaNwqPgYoO0P5lA?=
 =?us-ascii?Q?lOl5f0eFQsMhzN6yG83u4LJC7K97AydFYL8ZimRGB2nFSUjcyhhM6dJoCzZE?=
 =?us-ascii?Q?QstId0tzPW1NE1zdpUeOoROEn1SKrMjyjERtAefPpZmsi6nMYpz1JmbKwyI+?=
 =?us-ascii?Q?GWyiokATQ9lfz7kPbEU2SqpLWrGYqOKd/FL/PiE/YwGmpk4ReMTb6Rqp75s9?=
 =?us-ascii?Q?W9XiJa1fs6lgzMwwYSXaMz9ghAbV7SQDUr/DTrQWQlQNeH/4c+fRAKIs8ra/?=
 =?us-ascii?Q?Nan6W6oUSN0IjoIC1rsj4hfScY6OVW/qH4Pd4n8MQxxPSPrA2Fe3gU4nOZ1L?=
 =?us-ascii?Q?17pMQWJKVJtpTK5BolaZB6/ktloQ5fnPSs7ES5VoqTuouciUutAtZtvOIHY2?=
 =?us-ascii?Q?Bfg+tkLKzF6/bGzPPJuP2Sqf+kSa1oj6EvvOLTatVjduyknfmQlxzr3Aee9/?=
 =?us-ascii?Q?SdtcxAN/SVhkswdvu4EoZfLUmdR/KBMtOwKguHES75HdPN4eTFAWOaJ1rBPN?=
 =?us-ascii?Q?UnE65vVBIQQPNeNnYYanSSC8J680BfgGytViPAy57LuUp0vOaJiile80ue48?=
 =?us-ascii?Q?cRdDWFgbTh2gQkwnVna4uio/YmA8+JaI391cEIxFFKjo+JR1oZsnw/6TIKD3?=
 =?us-ascii?Q?Hg37CFdEwYyfS3u2vKYWSHMPFfbNzFkGT06cNBvBy2pCkb2NHp/CD02dD5OG?=
 =?us-ascii?Q?7R7QILoXuo0KGEtvJADCwiHlofbIShwFaz5F7LRf23cchC4R4FKWya8OvuXy?=
 =?us-ascii?Q?TaNTUHM2DjNIX3TrJdPRfNEQOJfsixes1QLFQG7eX0skFPkWaJSZGigK0f5S?=
 =?us-ascii?Q?eb0EwLCBoQJSuojT3GqnrLTqAfXipHx0ZotaZixKFpEbTr9opUe1Wb5/bTSn?=
 =?us-ascii?Q?V7NL2lJm5QCUzMPte8yKRIv6uNFT3AkYKzFJWeiK24ELCKoSx4petn9PIhNY?=
 =?us-ascii?Q?AUUcJZ4DHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa098d4-1c9f-438b-edd3-08de7e112bd2
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:14.9553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nWvIGCVMz4UYUqtxwJQ6ZYO+STlGY766fa90ht31iOAyseBuLHv/H3lMunXF0HBjG1p9gOdHdonSqWpm5JAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce smmuv3_accel_auto_finalise() to resolve properties
that are set to 'auto' for accelerated SMMUv3. This helper
function allows properties such as ATS, RIL, SSIDSIZE, and OAS
support to be resolved from host IOMMU values, while avoiding
triggering auto-resolved values for hot-plugged devices.

Auto mode requires at least one cold-plugged device to retrieve
and finalise these properties, and we fail boot if that is not
the case.

Subsequent patches will make use of this helper to set the
values when we convert the values to OnOffAuto. New auto_mode
and auto_finalised bool members are added to SMMUv3AccelState.
smmuv3_accel_init() will set auto_mode to true when 'auto' is
detected for the accel SMMUv3 properties.
smmuv3_accel_auto_finalise() will set auto_finalised to true
after all 'auto' properties are resolved, and subsequent
calls to this function will return early if auto_finalised is
set to true.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 38 +++++++++++++++++++++++++++++++++-----
 hw/arm/smmuv3-accel.h |  2 ++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 17306cd04b..617629bacd 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -35,11 +35,34 @@ static int smmuv3_oas_bits(uint32_t oas)
     return map[oas];
 }
 
+static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
+                                       struct iommu_hw_info_arm_smmuv3 *info) {
+    SMMUv3AccelState *accel = s->s_accel;
+
+    /* Return if no auto for any or finalised already */
+    if (!accel->auto_mode || accel->auto_finalised) {
+        return;
+    }
+
+    /* We can't update if device is hotplugged */
+    if (DEVICE(pdev)->hotplugged) {
+        warn_report("arm-smmuv3: 'auto' feature property detected, but host "
+                    "value cannot be applied for hot-plugged device; using "
+                    "existing value");
+        return;
+    }
+
+    accel->auto_finalised = true;
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
+                                 PCIDevice *pdev,
                                  Error **errp)
 {
+    smmuv3_accel_auto_finalise(s, pdev, info);
+
     /* QEMU SMMUv3 supports both linear and 2-level stream tables */
     if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
                 FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
@@ -124,7 +147,7 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
 
 static bool
 smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
-                           Error **errp)
+                           PCIDevice *pdev, Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
     uint32_t data_type;
@@ -142,7 +165,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         return false;
     }
 
-    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
+    if (!smmuv3_accel_check_hw_compatible(s, &info, pdev, errp)) {
         return false;
     }
     return true;
@@ -595,6 +618,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     SMMUv3State *s = ARM_SMMUV3(bs);
     SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
     SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
 
     if (!idev) {
         return true;
@@ -613,7 +637,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
      * Check the host SMMUv3 associated with the dev is compatible with the
      * QEMU SMMUv3 accel.
      */
-    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
+    if (!smmuv3_accel_hw_compatible(s, idev, pdev, errp)) {
         return false;
     }
 
@@ -867,8 +891,12 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
 void smmuv3_accel_reset(SMMUv3State *s)
 {
-     /* Attach a HWPT based on GBPA reset value */
-     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+    if (s->s_accel && s->s_accel->auto_mode && !s->s_accel->auto_finalised) {
+        error_report("AUTO mode specified but properties not finalised.");
+        exit(1);
+    }
+    /* Attach a HWPT based on GBPA reset value */
+    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
 }
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de5..3c1cd55714 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    bool auto_mode;
+    bool auto_finalised;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
-- 
2.43.0


