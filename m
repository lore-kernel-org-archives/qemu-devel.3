Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D952ECD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIFz-0006RV-Cg; Thu, 04 Jun 2026 20:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFx-0006Ox-3e; Thu, 04 Jun 2026 20:17:49 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFt-0007xI-US; Thu, 04 Jun 2026 20:17:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojBnHPR/XNnN4CNFZm+LBVcPQky8OJQW9XlP4sPtgiJ6up1CcazpMnjPLnXN4x16z/4+5My2OZ7RtwCAOyXn/YxJBq5N1cAu/rM4J+WNAm6hWtmooFFzdroR/fNI9kUL+8mLQt6eHAhxzfTugHc8P8xvnzNC6h5MSSCKctXfJ7wU/7nffVDaEBC8BVFRJP6gsy/MgdBRvDTHsS4rhSUExo6IRQwKTvhIWjtIi5/UJCrf6hnGwjoH7P150UkxzunPqFKY4kHcAut+iAqXMd+Pos/Ou4AEfTznpRxiMusx50EHP/usTebc7i6Q9AwFKxfj6w3UUOjV6cf8+2cQ7hv4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOcpORBxXdGMHIDUoVikNmeu7Nmz1EN5FRK2g6AK1mg=;
 b=QaieVNaEfzhD+2N2vzJCTdhZA1vY7/GVcdBQVN/zwsZqVxiqoOv/3gWdQJREams8Iof72A2Yq6Rb/9WjDUTo0wPLnY9WObP/DKGqCLUecip53+DaiIeX1prCA8foEKgrSHZVhWS4i+fkK+E6iSJ/Uy8khlR2wQFNqUN1vWYBntQTds/piOKqry+fVmYX4J0qOnVdfzSJqrjrFdResZESUr4oE3YrKhJcMs4Qt0xrlhW0lUZirWSHwDekIQg3RLv10RcAf/E8ONVB50NnXnyYnmgedXat1Obv0lA9IV7h6enjbux6qbkbrw35ZY18LGu0qk0D9m9KLM5PQKTnFxkihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOcpORBxXdGMHIDUoVikNmeu7Nmz1EN5FRK2g6AK1mg=;
 b=GFVqilrQ4h845VmSIApy/KKgSk3INa1YPKrSN4d+01jF82abRB+LnN4YwfJBET5nBCClxWQSwH53yFYNsW1lzrZqPwELAXB5V6DnohUUBXsMxA0Jfc0rb/17OYAZfAlLvWyBBphZ5WKPh07zT0kkUnMXTE3FdAsNYIyJAmZj/rF7C6cTPIX79VBPtvrJn0CwDYi+YacEk3fGifWwXW6RpDnxlLKi4eGi5XqnjnxZus7h69PCM3YMbSE8oXqYyIue6NSBeL8rlNGEMnbJ1m210QUtMzCvDgHEbSbpATwWftL4ZAsaLvbpbYu8oznOqFEd8vStGVdGOMDYPvF1WTsjvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:28 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:28 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 6/9] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Date: Thu,  4 Jun 2026 17:17:09 -0700
Message-ID: <20260605001712.1823737-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b637da-3c2a-443e-00dd-08dec297d3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 0UU2l4G5JihmmsPk4Ydr0ImsjEXtGAjdzXRZzWryDQCOBCZgBNljnQa60dQqMYvLDiEDcTCEM7AruYoXvpNqMQz9tjcSdPBQGpDKmzQFP48jhIw50FqNPZdk39Tae3rMLYWv3I04yN/BFAUKeZRipHZhLDkst0rJWqK7Z79UUjCO+gfuVFn27DB/wHD+nRsKV73+hT4RNdis5iSSSLa6rjvpauhj4BqhQ7Wht4ySeBCtYMWRQwXMvAdib4+RVf0yZGar6CkRzNQWDQJ8BahophrePX4CO32jk1+PVzTFvRs30EC2fCbAlYPHvsIqgWlgGYNNSoiHJMILn/YepP14SYhTuJLMLRc+8i9YsQ4xMmZs452JjaDhOP2dLOXtPgcMUymfTJ0zGhucGrPnh6TGLq+LLEHQZU5wZ2mneMVpsTIhswrTnxMo5kc0V5teOxeXkRKGk5E1vX3qDfHuNQfIQdBL668E2ScktpikuqW/Fyvx0E8A05iPiFUs5Lr+e0saDsPjI3EVqotfI868goHsHuevCnH5RXFUCGhfoYKYPJH13BRN8m7CCIgRdOqq9gaeFv4Ja81QuVK/RiyZJudPl8ZQJjKAIPCqyiOBE+lFhSTmsLuLFvBPpkJk3BCltOeP08NFvv4qBS1BRjYCvB0d6nZKkU8y1PPqId97MjuHiCmcn9CNUL/jmtr1ZE3dZXYk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zloHuGcpTrnlrVS6B30hvsZK1/3fU1AqwUV23UXkaMWW6Az78hxKZXkWsfmf?=
 =?us-ascii?Q?+gdTzky3lVvadVXwI/UOK0WMv9bRfWem7dTrQMSeu1m8cwwrrrhrz2QcxJ6u?=
 =?us-ascii?Q?gFSYW2h0RwzLwGXk7ulDqIr6I2GbV3EaeMRCuRpMy3SbNm+68g6pxSMWcfjU?=
 =?us-ascii?Q?7Io5GWd9ySKbSBOnrGKv6ROzLRO2SKLQ+/B2H1gOZdNCeFpn6uIOWR7h0AOs?=
 =?us-ascii?Q?d9M8ELfwRlMFGwpM3FT7YOHB04CZ7qspHb191q1S4pfx+oWld9vfE16vZBNl?=
 =?us-ascii?Q?kPQVq56C+fvuvhq+kCycDkxASaj+NT3paW325u47Ky3ISWEesJga7eGQAPln?=
 =?us-ascii?Q?YGkru11pqPmRNq1lOKAgQl/rfZLqqrA0IrhTq4wvpERqEN72d6eVuW96aGAz?=
 =?us-ascii?Q?jRHOTK6GJCVesVB3rbSMBeCok6hIi2Z0lzlCJFFWZ9cfZvTk180Bo5sSbn8/?=
 =?us-ascii?Q?3vKdBTPjLIsSYxOzD8bvubnWGg0VVmqJo6orhgJ3Kf0hW5SdZJLLE7WY/rr7?=
 =?us-ascii?Q?lS2qT1nUBTHA4Oq9MBWGVcTbUjMS4fozgFCmWHLaK3mKx0Xba4ZlCPqaURk/?=
 =?us-ascii?Q?x/Fm7sejhCGTQA/ThekDnaD0t7+ANAGf8FRz+pQX8ut3NbvcdF/AoCovE95R?=
 =?us-ascii?Q?UIwZqbmntVhMQg/pcfvjBbLzwKk4NzjiS8/QtP7k5ISuqrse++pu7XpqDcgl?=
 =?us-ascii?Q?E4U+6H3zyx6GhA6weVkYda/iAvpQrZBDzBp8ZjUisifWzklbjJyWT0/pOP+8?=
 =?us-ascii?Q?PgqwJE6tONV9LZ0s5Sq5PfmTs2Bh/J+ovPZwLYhqkhuWe8+o//iFvuBus6UN?=
 =?us-ascii?Q?XLGoOv9coM/vOaJNZbF0CHZwKW7R+ZpPUvvVOM7N3o20u89CCku2vc2knN5E?=
 =?us-ascii?Q?cMWW/X/Q/bf/wj9iWOgqNHlS4LwApkdMNguIQE8k/urluIQl4d2sreLiGeaq?=
 =?us-ascii?Q?eVXip3WNlGVf/w2ETDS0Zj0Ele9ddd49JL+bc3hhp0jzsjkgsf3AjS2VWHB4?=
 =?us-ascii?Q?Izgr+r9k6nEf3dYtPO49e+Nz+hOsmZgUn1PvQxebORhDu20doNl5wki8G+41?=
 =?us-ascii?Q?0et++r+QPPqqSpqyyTueqY9RhkrtEpIzPg0UmNHG+/TPwyc5fOZPsubeMjZX?=
 =?us-ascii?Q?hTqf+IkMjIylnmetSSe9MJuKsD5c2vquQRm8MUVO6HJOwkIWDPUkbcxqVm3y?=
 =?us-ascii?Q?riHfAp3fgA28vHNmAo9EI+2eqaKoixGF3ynJv4cM1T/IU7tX8/3n37FVhxA9?=
 =?us-ascii?Q?XqK0W5JX3j0knYWsOoUM3fPpcDELtrJf3ksT7Nf7jtNef1kqEgm3o9hqOyAk?=
 =?us-ascii?Q?bVL42Fq52O3YuENkBirr5jcvoBccuo9MBrGEFBlmLm/EQQNgptioFBwToa/u?=
 =?us-ascii?Q?LxdgEjcXUO6lYoZP8lgnjoVtyFH5A+Yc3cq0tW9I6sToOC/9BR4lpEuLT9ys?=
 =?us-ascii?Q?jw1u6rQzvv9XviZ4FGpEylIDBmV/9rozG4q0Nc74Il1xrr9rgf9BfaFR8v85?=
 =?us-ascii?Q?QiK0CJTAjNv9GX/uanqD9seN/uwaPib2TawIyZKQ1xyrt4tRoSKycFMwQWux?=
 =?us-ascii?Q?K7Ub/8lEsdlZvBc+HVKculdwFXT5FqKZECUSMSd4ZcFjjUg12x9x0+N6g/KG?=
 =?us-ascii?Q?dTuiQG8cMJM5mDCqWJMUEYjZ4/whXNekpXyEIK4K4KPY9nrHqJxPyTZZXCn1?=
 =?us-ascii?Q?4LgcM/UNpcJKOWrFP+xbrSg/KsUypBDvVXN0ipX22ewr9uJa8GH4neG4PQi0?=
 =?us-ascii?Q?BGL5ey8UNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b637da-3c2a-443e-00dd-08dec297d3b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:28.1833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWjqLlxfhvtmG7DiXobLtoMeH8h7H+cBmHjUutfX7blRhhyI1GVugHwjoD28WOtHcr83Jbg+mlblAXW+J2rR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Allow accelerated SMMUv3 SSID size property to be derived from host
IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
retrieving SSID size from IDR1. When the auto SSID size is resolved
to a non-zero value, PASID capability is advertised to the vIOMMU
and accelerated use cases such as Shared Virtual Addressing (SVA)
are supported.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 17 +++++++++++++++--
 hw/arm/smmuv3.c       | 22 ++++++++++++----------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 25699a1317..3f141991eb 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -63,6 +63,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -823,6 +828,13 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static inline bool smmuv3_pasid_supported(SMMUv3State *s)
+{
+    return s->ssidsize > SSID_SIZE_MODE_0 ||
+           (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+}
+
 static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
 {
     /*
@@ -835,7 +847,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize > SSID_SIZE_MODE_0) {
+    if (smmuv3_pasid_supported(s)) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -972,7 +984,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     smmuv3_accel_as_init(s);
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
-        s->ril == ON_OFF_AUTO_AUTO) {
+        s->ril == ON_OFF_AUTO_AUTO ||
+        s->ssidsize == SSID_SIZE_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c183964b2e..d59931d1a7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -626,7 +626,10 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     }
 
     /* Multiple context descriptors require SubstreamID support */
-    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
+    if ((s->ssidsize == SSID_SIZE_MODE_0 ||
+         (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+          !FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) &&
+        STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
                 "Configure ssidsize > 0 (requires accel=on)\n");
@@ -1965,10 +1968,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
-        error_setg(errp, "ssidsize auto mode is not supported");
-        return false;
-    }
     if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
         error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
                    "OAS; other OasMode values are not supported");
@@ -1989,7 +1988,8 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
-            error_setg(errp, "ssidsize can only be set if accel=on");
+            error_setg(errp, "ssidsize can only be greater than 0 "
+                       "bits if accel=on");
             return false;
         }
         return true;
@@ -2175,11 +2175,13 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
         "supported.");
     object_class_property_set_description(klass, "ssidsize",
-        "Number of bits used to represent SubstreamIDs (SSIDs). "
+        "Set number of bits used to represent SubstreamIDs (SSIDs). "
+        "Valid values are 0-20 and auto. Defaults to 0. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
-        "Valid range is 0-20, where 0 disables SubstreamID support. "
-        "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support. ssidsize=auto is not supported.");
+        "A value of 0 disables SubstreamID support. A value greater "
+        "than 0 is required to enable PASID support."
+        "Please ensure the value does not exceed the maximum "
+        "SubstreamID size supported by the host platform.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


