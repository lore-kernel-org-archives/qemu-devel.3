Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F93CD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMYg-0004lT-Ta; Wed, 27 May 2026 18:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYf-0004kh-3M; Wed, 27 May 2026 18:17:01 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYd-0002I5-M4; Wed, 27 May 2026 18:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIzs+CUMDVcta7K3wPQC4a/1cYyzz0J6kr7eiPTA2kXpkSXEj5qPBf8+fDCamL4ZjK/agngnMtKa6Qv0d1u9OzMpCLfyVTSHRRB+Gvf3bAJAeJ+LMRUojknS/WnFW/E6T0CUoAuJi2ShddULOs9owhtjbTbOFiChMKXFM9MsrqdyNQjq3hwwK2XHXhYlweBt251P2/9QrnMY0E14KVqMA8zCqSFMPKOQDfNVd6T3Yr9eg+uGtY7seB5x2UVGsNnokakE3gdnJV0zWGzFa7uyBAs5dgIPwRvVG1LKto9WfjcdhbrS59EgPlZUASkw9hivpe0RCXiobww/ZjAEOvgu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs/biPueW6oaZhn7yBW6Uh4WgqgMMKDOyy97Z2kOeZ0=;
 b=ZOjQgetLGWhyHLG+BpJdW9BOzV+1skN2oiY1RtRp0jm7yesq9BZnv41kpccsijzsBhFZo0d5fEjJdvywv3FGLrZATHDstOV6QEB3CGXQInYWtL2UBSzsC1H4CT//+GK2eKjusyFQ/svhZvmnQwwg5MCC0kWU04Op3WFeqFnpvctI/8RNGA0Pzj15xx/eAZi5hi3JQpm3nEjE83OPN/eN12cjeYKGZXT006tFkFpQzPVhu1Ymgwq2kEU8Zv7+dVn4OuWdBgOU3UzaC4ShjQff6IUKZWhfkEwBIEGom+DS9vlrbzTJaInOhA3t6/hywhbagP4ee4Pvd4yASHdANUvDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs/biPueW6oaZhn7yBW6Uh4WgqgMMKDOyy97Z2kOeZ0=;
 b=a8XYivzdrOmZIXSRftia7VQLTs3wR4yatD2gK5BSkqIHfgsDSJm1hl/t68FNkELA9+c3NxQ8oAl/y+cnAG9Bp2a7HpGsLu0YDCFurhGuCn0AaDXrm/DXjwXPXWTINOXHTlkX4X4IzFWFlxBhvS4iMaEsg+0EcbJRC53Tl9UxepgSk65+OgNtzek1eKwF/iZFjlQJshXUieXdG6MDi4tEQKJB8VJtypEx4ReMxHfbAo5x/WRt8+I4/zZeo6byIuKgs4n48UCNlBoKEWqzijkP+FptpSHZHV3z6R+EVAxnp4coQHT80AxBU7f5MdwgDZQccI6s2RIrZ4ZmNdw63hFDMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:16:52 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:52 +0000
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
Subject: [PATCH v4 5/9] hw/arm/smmuv3-accel: Implement "auto" value for "ril"
Date: Wed, 27 May 2026 15:16:27 -0700
Message-ID: <20260527221631.612026-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2771b0-60d2-46a4-abf5-08debc3da79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6qrntrY5p2mgsiq8qv1FjF26py39Cz7KcaCMuWlcJuLKtlxvDjTpOmNn6qPjau81OD+zRCWrEUIgDp87NP1qytDRjGbUUn74+pfZaISg8DzqFni1oU9VMn0hL3N7J0HODVkcFQqZmz6bQKEJs77VGjwd3E/R3kVGrbERQWz8TNgyiP6IeopTMZHlQJp2E2q1OxZJcTB8WGvdngbcEmnkJRh4DkGgM+H+Imh9Xl5VZr5Qzt3TMs8TfSENpe0pSlM/mRFeYqqEpDaj+QveLTyX/7srCwxvgHdehd2GBjtlpeAOY5znMXctAXx7wG4jqUaDRll+w1Do/oS+EdJ/SRXYl/3TlEEqu7USCJmUAg4Wi9xXLjFKuObOI8XDGB4EVnwzSYCrYl8zYsbpijFCmsvsWCahhv5RW1z+0OpXa63u2SD1B+mv5A0Gnm8UJzpOm4Bd5Uf4VzfV4T0K2F/vw9bijC0T1+yHlsbjpTjloig/XWjNLu1nROzG2y+BMsqoph7xDHxluD+UUj+3AqhXctVLniBsWF1eR7HpUm+RdllWyaAuXa4rlnR0GDdNJ72Ha7ip4z+PCs3nyURZYHDdkXOgRB1Y2HrvSX6TxfG/rmV8uOqvvUOZO4e9X5quhUqyBqlSOZXwh85wmHCw8gxDR5knXDEgh2yrlmcMCEn8E7RJ2pM6Apgo97EtTUIQgCyNPIHE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atAhvt/oojlTAIqqyadeyikA3LZdOUfLClc/bteA4CGjiPW8Y7FwTeDJG8KP?=
 =?us-ascii?Q?Ws/GBLPmMPKphOzLSTBaH3aPZ1xHPEaFqJGkhEVhQ6cOLpFqxmuFpz/fLA0g?=
 =?us-ascii?Q?RS7xc9vFSuj482GTWPbTsTg6QgxnrkQ3Gb4AT0DStXjUfyFUCkgH3pT3/kYy?=
 =?us-ascii?Q?N90hKtD0AjDk74AJI18Ju9i5y2JnNgSwqhDe3UNl0RsOVEiQP9BndB7fgh9l?=
 =?us-ascii?Q?mRSrCcAJcKjfppZd4SObGqGZR70j/BZaUjpCh8drspnS3bXCb9SzkTxLaFu6?=
 =?us-ascii?Q?84ZOukaxtfh5oOUzn9pfTc2+H3nzhUf6p7bo6+CGm3SIYHVf23LCIcqiVKa+?=
 =?us-ascii?Q?+V4/snjqin6Md6NaFWuFSvXL5erIpSvq6b8I9n64tJYjetxLeHRN/k3SGloo?=
 =?us-ascii?Q?+ztCISEu2xKJDVVcBXDAemNo3B0Ocbsg49MJTWU+bYbIqBuMFmwpJPG+32RJ?=
 =?us-ascii?Q?LVjoECp0aqUi9bIUYN4qsUO2nrwqDn5fQgWyYaI5vyInBFE67On47U+q4y+7?=
 =?us-ascii?Q?oXO1IND3x1wprQKUX5NFRyRKd4kSDbAuTwcpyrh9qU89j6Ze95KxjvSQhOSu?=
 =?us-ascii?Q?noQ1zDl6M/CPoFIagQUGvWebXEXvyDkodm2/geSReWTTnSmN+jU1oewNe0IQ?=
 =?us-ascii?Q?EYo/9+88zhCUInId2pGjGV5xd5FlW6IPOE6Vt12ARWBUqo0p1asgx+JGcSFi?=
 =?us-ascii?Q?Cr+QyvA8Blk3kxCMci58WXx42M/TgXWoPDhVWBvfO5VyHQ1Jqr0iHApD726r?=
 =?us-ascii?Q?SC7gD/SYPfC/QdA8HlLT8Vy0sWlxtrnZ2V1DTxiz9kbCg/u7yJe7vfljYyko?=
 =?us-ascii?Q?DtesWGmEdPYtgoY7MbumDILxj/cfbGUowmz8PCVjjuh7Lyfc3+UnXIAYRrwN?=
 =?us-ascii?Q?R/3UECw3AFzH/HyFDDHGAUzWVYz60m1nmwag+CIQCABYA/lXGU91LT2yeZ1t?=
 =?us-ascii?Q?er+5ypmvsGronUMWJZ3xMkpiLRIJ4GygdeXoS/ubuv47IciJ4WDdch9qlrX7?=
 =?us-ascii?Q?Ft/ByRtX09mrSOzeRLf3nmFoCo0JTYeJqwP/Wi2Oshk0DfxX5Gz1hj3qNtUC?=
 =?us-ascii?Q?psX+3UGg+YcW3o7vtYGbv7qPPij2VHo/yjsBFu1L+ZHEtqxd4TjijLLA6aeW?=
 =?us-ascii?Q?Ikd6Dl9MKgCSKz6F9WdegoaNvAlT0hhRsW53FCY7qlUwh1ExdkDBgmhikgT9?=
 =?us-ascii?Q?jcCOmf01uIQYZmwdBfMzrPaPOjAnZac5riY5L5uKuY+QjfeHMlaLNQ7Sv8ZN?=
 =?us-ascii?Q?7e7lDRqyhhcvC69rA15K9aKMkK42ck5V0xL7s6nXie7Sdp6LsTOY99WS6c/G?=
 =?us-ascii?Q?WuOAywL1e02UW2wQHAY1/+8wKNKUJR00EhMCDDD7tXUouZpJA26YZZe1frg7?=
 =?us-ascii?Q?M3w6DJZ/6FdFBW3ihu+dc1qjGg/ZD5o7Y9QKQ1fU1UBaHvA0ByjeHRgecQ8Q?=
 =?us-ascii?Q?hyIrnbQ5TAKpXkb48GyzXYufQddW99NN5sw/ZsQbCaqlAFnlAMtTRXHwgIKl?=
 =?us-ascii?Q?HvT+FVLPYk54byaTGOMWesLTAMOp++02WRkYd9vH6ph9M/g7ouzdwFMx2UTN?=
 =?us-ascii?Q?h3HT/WY7Q3cu7AXH/LzgmeaVC+kHTFgWcVKlfszBor0afuzzSXjU5oOfENPD?=
 =?us-ascii?Q?cetkeoRd0Ht3ODZy/gsREwZIX3FIEtGRPyoJGSmHhyi3+u0Lr7EjutCRod9W?=
 =?us-ascii?Q?gmtRhaeKh3OWB4PKSrO+nr224xBAGE+kiDMv0XXdOuS3GZOu5g3m/5wKk4EW?=
 =?us-ascii?Q?A+E002Y1lA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2771b0-60d2-46a4-abf5-08debc3da79a
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:52.5264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VlYzImtGUDXiKAazOsctx8kBiuofHWrh45bKzGgvuXfXA8f8smAmbyv++Q2OjwJrwu2SKM7vTqcyyHZSztoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 10 ++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 4c2acbbedf..25699a1317 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -58,6 +58,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -966,7 +971,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ee1453375f..5edcd73fb9 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ril == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ril auto mode is not supported");
-        return false;
-    }
     if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
@@ -2165,8 +2161,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "ensure the host SMMUv3 supports hardware-accelerated VFIO-PCI "
         "device assignment before enabling.");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on). ril=auto "
-        "is not supported.");
+        "Enable/disable range invalidation support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to on. "
+        "Any attempt to turn it 'on' while the host does not support "
+        "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
         "Valid values are on, off, and auto. Defaults to off. "
-- 
2.43.0


