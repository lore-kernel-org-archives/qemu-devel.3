Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC323CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMstq-0004Xc-5U; Tue, 12 May 2026 15:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMsti-0004T1-Bb; Tue, 12 May 2026 15:36:06 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMste-0005nm-Vq; Tue, 12 May 2026 15:36:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeKlwxfMTFEZ6U18jiXvsvu9ZQ0kzRLHwb5blQXjCbDFSyc+hsHuD5vpf+eWj1UbZBz5wNpT6TSkQmFG5NP1VK78G+KxoBcaJctdbervAFGQb5iRMZ7S477zkaSiuECs5ZggDPAaagUgjaTqXN0MRXt2SJ6f1Idr+rBsD5KMxHMymLU5hvWUIua+V58gtqlbTzhA+CnMeZTkHmGxAlff0rIAuqDNGP3WsHELNSD+utUWL7/e/KFsiMQNmP1w2PFpXHYnIlpQAJEbQpaW+aTYE7CivfiFcYVDPdzMBMtkMksQY3jXyeofVdjPM84EFR3jbMd8xRvmePWFmqiF/bPCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nro4wBKeHK0oO7H9cPk1Abqd6P67FxRaVqxAEBYOGsE=;
 b=BhzmMCBqwJD5N7jucNs6WGbLxHD5iImmMQ3xGF0A4BCkUaNgKe5DgK/nTv6CACU1yTa0mV9aHs3nRV9u5rOPydjIQmYndTtrimwyLIHc5iMqs+lA3+Ok6loZ0jICJCdoXb0X0c5gOQKFWxu7HfMapn+96xklbb73T1vKq9Ee1vRZntcBiMeEsdxXuwoiyZgFBsJGNcUvftf16PAiiDniGrZykD8PovmhhkTpN3VYprUJpfUEM/ZHFN85VypEPF+xmU4PCGtYtvfK7jF/OHSFwYIjCATR+FGpUejBWWdJf2hWcV76yoju+nsO7xgiM1bpRmb3vY7rZq4t8ZW1XullTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nro4wBKeHK0oO7H9cPk1Abqd6P67FxRaVqxAEBYOGsE=;
 b=BlWgE0UP7qGy3QiaKZ0gs78/KxviaRUP/1OmRhF8Kwj3TecZ3+mrQe/4I9V/IoUMFYNhMIB/nYVFR7TX1sQGA2LPwOGPAOwZKm5OLpaYicuT+zC8NLHJMO4AFrhMnQ9ngGnGgTt3EzUYiFoIsNEhjd9FTJwCPyEVQrxsmW9+WLYI/ofjjztiBrBTM/rw1wPgCAJwF1IYy4tLAiPKWiKXGy+RSn/ygJjP1ro25cGCfRV4Vl7Y/guK5B85AOWR31awYVKrODZ313R9F3wtaN+wYcSV1wVU1+dCwgiPtOVvTg8UB6AmfIHQiveCU805BnS5SCY0jSS6MIcoJYEueGRVmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:48 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:48 +0000
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
Subject: [PATCH v3 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Date: Tue, 12 May 2026 12:35:17 -0700
Message-ID: <20260512193520.3109172-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef2d2ea-b5cf-41c9-d18a-08deb05daaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Pgn3H5bbT+Q/AbmMTOQoOgiz+v0AAhDXLzKjTeSH/E+dDJ4pJr7gOh8yoqe8kNrFQfEpugWr8e1w/tJi+eg+hnzevpTz5MDpI8UAu7ju9hGgCmo+idmU6gc0WbRHkL7FrARlyKkL4LkwwSakNwxjh+LLNnmU2I+qpQtw6/Hx/dx3O5YlRlptLDfUH9+Xm+ThkaawkYqjn+EgfOaT6aAcELZtRsGLUVfjz76Xyi43LClLMGj31VZsA/ksJ9KjjcPPNsvJDdPxXpuXbNWBPXaehkbnV9jlXqS6AcsUdtZIBYBN2Wb8fR9Cw2iyoXuXJ3YZHsFMdXkO4EgOyT75WujrsKi41gGPSpbOWUoGZgnQntDibk5UjNKBQ1W3ayMDXmfQx7r/aNZ5RXr1tDjUlEzmvkTO0UXGEx5IqRHkWyEY1A8KGsU05PpMNA80kI90tqP4N6FiHUZ11rFmyw/wGPZKuIh2jvz8NuIdh1OfVP9k5E6dlSlzS+sMrlZ+wRyrCc9dZ5XHpWrT8ArjlU59XCT3I7sH2n/w2iPXs4NlrgSSLCh1wjNYyHxkbGLjfa2cIknSPr5GLEo+6gy9gjYTaPu3e2dpE3EcgHtL7TWkGfkDC5SPbNjEOYMVylEnUGiVXWJdVVG5UZtsfenkFc6hDcUKe2sHMflsSLJQCbWHPKobOSMROZ4TiUBSfTx2+6d+3Izf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Czq2oLwIsdos0uZiwFi36NiLynS7W1e4NLwEIReDzYMeYbgCy0aVTV5bLMpZ?=
 =?us-ascii?Q?+VsZhHlY9CdO3sxdTsOQ14o5tOI8sDbcWM8gS+jbgKMpKYSqKDienW6QrqQs?=
 =?us-ascii?Q?Ne10bp+sYKANPk7WudOVid0dxqRjsva1ylIB5WAYeVD0WIlykjgA5U3b+xtx?=
 =?us-ascii?Q?t5E6Wi2ghlKj/BmuxGE4xps29d9iVLuKxe1C/SlMdiPfhqARw1K94kFqDr2X?=
 =?us-ascii?Q?kjOWL96KOAoi+B8fDsJGwcYIlg2oZwYu2d7znWboihV/8h92jVPPf4c9hJqb?=
 =?us-ascii?Q?wIu49YfgAZzRkMv9JZF3Z+b4b/jfyeVlKfipellJj4AiC1/dnvl20UHwo8Bk?=
 =?us-ascii?Q?WoWDMea4vWoJiYHNCenajrrgt4JwGx23DfbQEHiHG2qaHeImOWrTCQJBQdLU?=
 =?us-ascii?Q?H+7FpZ0UA1ZBb2XK9oT6b0ht8T45dbTih7Gv8gK2TUs1PFqLUCM7oPAGSW/n?=
 =?us-ascii?Q?P0SCoD8R+Dk6DvZhNS/8XYRfYgiLs+OSC7sYY6jKM3LUjrR8OaxefTLbVNPA?=
 =?us-ascii?Q?Mbr4jgsr98eGDVNOKzrVSB1JJwQfal/0pvnNuSpeXDWGWDqPGN22oytUEkNS?=
 =?us-ascii?Q?op2VZeI0kGMldi1G290JfdeZyDar0tAvA+ZYDTQukzVeSDcAFKFYasyA5aiG?=
 =?us-ascii?Q?YUklnVEqbjdZxhcL8TDmcmUJFGmtWKFmP+DljyKavP8Tkqq20i+9k3iR7yip?=
 =?us-ascii?Q?+5+V6RNdcMCi3Ba8LHUPZKCbPhAut8Yhsa1bKoUNV9IAyV4AKKvVjpu78Mn2?=
 =?us-ascii?Q?tpX/802tE+9sjbhUmkl6Qa5ScYgFEmagTHpzykU3+O+Knf6m2/oOJOOvxzBD?=
 =?us-ascii?Q?qh9v+/1o1UVzVG/7tOFwXZNlJi679e9yXC3mIdAvr78sWoN70IIdpcy9d4QJ?=
 =?us-ascii?Q?e57wqWcy/BSWRl/UqmqQqkPt+OgKllOvAridQjXfqdvYb+eFVmGbPve6ef+B?=
 =?us-ascii?Q?kBpO24+K+fQSpFPT5UquKDNqIKJzd5ax23m8UyfRtff3wiGW75Bi0tTYGCX8?=
 =?us-ascii?Q?M+5QClDqeUQfOZlUCUFwqvUGj6HI58UlVDMmR0yuYEmFTn40N1zHX3+dM8u0?=
 =?us-ascii?Q?ADPhFFqnLliDRu35CSpoIh7zWBRNxj426jqLSWkd44pv6VdQTQB643C611Xu?=
 =?us-ascii?Q?D4ezJG/miQlEpr9rfsY6Ot0W+CnbJTNZij/7hUVAebqmVeCfLkMVSzAY+FQX?=
 =?us-ascii?Q?jpoMQl+TUA97g1K4kR8VRlHYZ4/tjlcjaUuIGNGRPSzRYVdk2N+iUTR8ddXO?=
 =?us-ascii?Q?/dSGsq3q3BRejj06cLa0OcmQQikRlGzx930hTSWiuJN+4Rbo0yfw+FSBwUnY?=
 =?us-ascii?Q?wIRLB5Yxnl+Zo6hFwyyx2N2BRQbm6OQ9IaJUJwf8ZXAA77uj/i256hARNdYV?=
 =?us-ascii?Q?hKGRNr4RyQjyE6YpFGkqLhivgv5I6ZfVnGVDb1EFswKvFiJqMAzWbz6SVawk?=
 =?us-ascii?Q?GXUZA9saEywliHWDUCwMEXp22I5HXlgWawD2nBDkOf1mtlcjm+OeBpj9+YTV?=
 =?us-ascii?Q?Thshkndu90zqNGISqarGbz7NTtyiF2Or9N5wGVJ3mN5DSHBJtoJqD8UL7frT?=
 =?us-ascii?Q?jkS5nQiT8b44uKs8j2WFzSPxQ/9oUpVd28U5ujEhW76Og5CNPbYhQlHZKzce?=
 =?us-ascii?Q?jr4gaAECKqLswVIYSWC5cvUMTuONUlpGSrD9SJ7ASp9+rhXSdnRoNH9GN+lO?=
 =?us-ascii?Q?C6zdjA4/U4U2one/3gAeynLg/aBTACm0krkLFuvS1cVLjbJ0AtLsS+8PxY6W?=
 =?us-ascii?Q?UrgUZFrMwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef2d2ea-b5cf-41c9-d18a-08deb05daaf6
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:48.1206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlCq4OFZ5UqO31un1OI6mi5TdRxl4/NN0p+NRYxFONsqpeSvoezVSN6PYoGaT4fbJiDSa9tLC0rOll6GWd1uQw==
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

Allow accelerated SMMUv3 SSID size property to be derived from host
IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
retrieving SSID size from IDR1. When the auto SSID size is resolved
to a non-zero value, PASID capability is advertised to the vIOMMU
and accelerated use cases such as Shared Virtual Addressing (SVA)
are supported.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 18 ++++++++++++++++--
 hw/arm/smmuv3.c       | 20 ++++++++++----------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a5973bd499..5b1af062ee 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -62,6 +62,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        /* Store for get_viommu_flags() to determine PASID support */
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -822,6 +828,13 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
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
@@ -834,7 +847,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize > SSID_SIZE_MODE_0) {
+    if (smmuv3_pasid_supported(s)) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -975,7 +988,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     smmuv3_accel_as_init(s);
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
-        s->ril == ON_OFF_AUTO_AUTO) {
+        s->ril == ON_OFF_AUTO_AUTO ||
+        s->ssidsize == SSID_SIZE_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7ec4241ecf..cd30275717 100644
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
@@ -2173,11 +2173,11 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
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
+        "than 0 is required to enable PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


