Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92431077608
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxn-0006no-R1; Wed, 18 Mar 2026 14:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxm-0006mm-89; Wed, 18 Mar 2026 14:49:50 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxk-0004y3-OH; Wed, 18 Mar 2026 14:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTqEw2TLVS8irOvtfurwIhFQ82c1IKOIZFwBh6qCUyi2iBdOm58R//VfP53L80E1DuAjIbIGUnCFNM9MpZ7jMJF9GQoSA9HUcb5B5qM4Kwf0T1qjljTkXas4akFc/Dm5Pxhkk9ArkV9LSbtJpwA3/GFMlpDvzsizrwXUQYkh6kd7TET02Dxhq8DQI1IaBFcZf0apsCr0KHFIazP4NHJNFOvbfsYwnrM4VkTafORhBSM6rfku7zLExO8oHw4yTPCJySvRWXrBbqcKuu69a8ywP0MpfQp/2uOKPLFAYQ7J0n5o4Mf1xDWvD6fnBx46AbPZlSqJdceDWRzxHWnhHYKbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDUr+GPIGszPP9z6fXqV2qxavRAPdQkC2COVI+/2FFo=;
 b=QlG3jIeThecZ12aFgpnqovYgOAIrye6EjNqmPzaCdZRPTl/j10rwqG6P2JxMkCz7+xgvo1F54Xq+taqJEgSCAsh1PVXDrOFYpyLtY2Bc42Q9g5CavyNjmantwH9MBPhNRCs71TPACsYP6DBzaqE00L3ISaXBEv9Cn9z6TPYlcr+FC8TW9D5YTVAFA8LVYsJCGG/X1bYPJfojfeRKUH/+sJGMBjFj29/YDaWg2gkna4cAEpLRTgOeTUunVZlMj2x7onaXarO/q/5rRrZpXjTsah+PY6dbFS9Yyd357EbJZtI4FkzFD9B96sChXLL8K03rpLakM9c6XeX9zCqtnQMveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDUr+GPIGszPP9z6fXqV2qxavRAPdQkC2COVI+/2FFo=;
 b=RwQJu37qqrLoIB20GWjWgEY53950mK3exybZ8cbnF1vx18lcGj+AKnoIcVdFuZO0XOlUGJq5GJ0MluScwY1QVaqlhl+JxHnTB/UTg+2WqEjPxfWica/83sf7JkcCv7EzX8gpuU8R+/F643HUloUskaoKQOHAM95byLPQKsFzheQtctw1di418lko6c0xmvbPcE+qu+zq55C3du1AbjR79XOIVYy/01sp9EiEL/AIYPLdyheJcsY8KL4fRWTd5cij2qY7Pav0ZJoLupRWCnwCWJg32E/CEFdeGxCyteDfApuLGzbqS/XX/KPSSqbFG/EnjX5Tblq9jZf/3fa0si8OIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:41 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:40 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
Date: Wed, 18 Mar 2026 11:49:06 -0700
Message-ID: <20260318184907.4060030-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f49e25e-b7f2-414e-13a6-08de851f1cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kVPD4pWnHhkm2q0saGCValUYtEfP7HWYXWya9rPpjS7T4XVK+PkTAMoULmnUVyhprIhZYngCwlHywrcq2KFkt+QXJti54H/bAqt8m0WiRHVV3k2Gba29YXq2Hx2Ds2MeTRFdyQDRJFBmeHXvND5muE0N+RK/JUgHc9kWHWwoDA2jco4GOxwoFoFU3BPS9lYz2OgOUzTVzzFkYCOhvGvdh1H6pAakK7vVT2cxTA8S/jJBhaMCDQwLaHhnHpC9W00a0IuUCDfvPpSyno5hIgcLs33VZkVYnXNQx/zOZnQ0EBoszeCx84J/aPxsr3441Yae0H46ghZ7mC/fov0ZNb56DB8GJUMdqIFGZxpaRnaRSpqa4QO7YvqE6j+zTghVedTlx/C9cwdH/+H5SbfcfZQne42GJv5gKPy9Ry2sblkb+WksNzu5YldORkuqOoETyTxM2Y+bV5szqWRARA2dLl1PtQsxidDoUt87lMQHLvef+XtAfRErXumH6HDNObTrez+bBrzQWFf25vD6IdCwknlSpG5FS2NC8QPzt5FvzVYFBgQpyZDX2ke2GGHjCxBX09N0MWXzisKyaUioGpxLn2n7PUlRorA09L8fONHh1bZRYYWcyhqA34FWEQYVyy17ZFQ2pf9Ma+lImJEEuYfWMNEVN3DjTvDugspy78GltriMx4Pi/dm6JkBnj3r1sepn7fYO9HnJSlsyUugktQtQWMkau3GPjk+T9EipZXK6+dP5dM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3NEqU/hQF0xZm40j8hdJNzNERtFX7EsXPRfb/c5EQCOCaFWXCuYJfis3h1v4?=
 =?us-ascii?Q?vdnM1u03oUTCYkSiA6gYaSYzs54MsdDMZyIrVwBS0NE0RNQMt1LCc564sG5a?=
 =?us-ascii?Q?XPR8qxL79zSTgPh5FmaSGKAjVBRittYp7DpqvctHuq95GWnNKgobEacLlMBJ?=
 =?us-ascii?Q?IwrvU/QXU6Nzws6+SCrl7y0wtTD84+FR4+xjXi9AHrQZ23dc0W6ewJKCxCAT?=
 =?us-ascii?Q?Yn4A+xgmgdLY2oe/jH8ENnjZqlkMpURLs5IYf8ptN8xjZewPYQidoW0Sa60h?=
 =?us-ascii?Q?7nTjahC52ATJP9tKO8YlKde0Gwi8HNeI88EfL9Rz94cOou4EowiFj7FrH+GA?=
 =?us-ascii?Q?jkMN7vdz56RR9JWTPi4BOxXt73N/Lr1deDTa3NaIHmPqgcW/ITZEGjDbQ8ed?=
 =?us-ascii?Q?1dAqLrExOwKbsFU1tavyGfa+GOc2fyTb92tR8rT21FhabkAT+srORhfej6gb?=
 =?us-ascii?Q?ZW/1YaUhP1RXmNgUPs1o7CTAEi8+ogUev35NexZtrdXBcRWA/J03X76qzbc7?=
 =?us-ascii?Q?bd+NBHLDfI4u71VfwnaL7Y0w4F1rz+FXk0rYy5UY+EDFoYI9HI64YF3HwyEy?=
 =?us-ascii?Q?n5+bO0qwqRUGEfiDq3K2xNg1zHgvZ9hI1HlVoGGBpPhHz5fSadLWifiUgJj1?=
 =?us-ascii?Q?YnVb+td7DXyoe3C6IVDMvN5Cb5iv4S6sp4Jqcm6DPvnlRAYYvDf9BastfzYH?=
 =?us-ascii?Q?Lh193HxEY//DXQxCo0YUwyz8nevEOMoYUM25WaTvI26c5uCn57d01MzntVjR?=
 =?us-ascii?Q?2eEs9IpLWMWoLpl9O8QTPxjNvxQ8VYFEkwRRLLszWMbiVoSb3st/ladAqCf5?=
 =?us-ascii?Q?yV/71GNRva9wJhCO/1wJvOcVLI4kPaUA3nIaZOw1Q0TylFXwa4lcrA0Dyp1W?=
 =?us-ascii?Q?YH6P9TvXPNYc0McLD2I1HVLvczRmoZZwO2HpAaYK6uOFNuBbmaALKtAEyVsU?=
 =?us-ascii?Q?Fb28mucXkD5jB2rqKDdDQJ5IabJMWKtM7TZ4w61gu4ZJLZN1D/RwD58Iyb+o?=
 =?us-ascii?Q?m88Ruy4cuRZRp0hXl4YzcP/+q8sfP4oWn1VxL51nt5+B45UQA/r4r+7z9Xet?=
 =?us-ascii?Q?5Q0D0Gn3om1VzLzrjUmzZYMEpvONSecHdxn3okc06VgOIyHkxb8OaZcQRQ/a?=
 =?us-ascii?Q?UcSQkq5oLubCl44nI9NYjFMofRxj0TXwn2KIEgb7Lky9mYueczyqweZZ9tjx?=
 =?us-ascii?Q?an789Ayhh6oRUjP0FH1Jxtbcz6SQ6XOzGmxw1+QusIa7zw31ZxkulW91wAAC?=
 =?us-ascii?Q?g0fy9Ggbybt9aUzJnNjSR1Xo/OM0a3l+qn9rTGHcMBPLlxj/iBD1TjNk2rz3?=
 =?us-ascii?Q?mfd76k35cXiximzn/M9EweuhJz+ThdnqoX8AiYIFeG8/xsUKWWY+JUkBoCmV?=
 =?us-ascii?Q?cPQZwaDE7maF3oYZHzujMPslfXrHs6jdGUUj5LZmKxYWARXaNFGxWEFSmN8r?=
 =?us-ascii?Q?j1hPa1ZsLit5EkdnhNcLMdhKjV/Ef+3pDfa2cXWh4dFothNWktmXJV29Dn5P?=
 =?us-ascii?Q?gncTbZGlzGSXuUH4J1JP6akvVzM4DeDT0AX7Mqgb9uCACsrkDHhxp+slZfm/?=
 =?us-ascii?Q?WfCUmTPFdpqs/V+3OhEXsrpvjM6WYYlTolzeHaslAGpIU23A0JCatwX3pyTC?=
 =?us-ascii?Q?fCrZeyGg9HFbmDn4t0hzS1il59/jVWDUXXiJTZF7BdwvypDb98ckfMbkxPCV?=
 =?us-ascii?Q?nWvJXC0ewgzMTqkF5zdjevxMacgInstNt+Tr3Ge5CUf3LTnBXP7DSwdDImmu?=
 =?us-ascii?Q?DYWBgT3iiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f49e25e-b7f2-414e-13a6-08de851f1cbd
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:40.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqFwmF+A9lZzHHIzkKC2ylxo723wHpTCUejltRrxbB7NSow7f29sM2nSz7NVvz1dgh4Eb5fhU+IjdycRD2QiHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nathanc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

Change accel SMMUv3 OAS property from uint8_t to OasMode. The
'auto' value is not implemented, as this commit is meant to
set the property to the correct type and avoid breaking JSON/QMP
when the auto mode is introduced. A future patch will implement
resolution of 'auto' value to match the host SMMUv3 OAS value.

Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS bits")
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c          |  2 +-
 hw/arm/smmuv3.c                | 16 ++++++++--------
 include/hw/arm/smmuv3-common.h |  2 --
 include/hw/arm/smmuv3.h        |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index bc6cbfebc2..65c2f44880 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
-    if (s->oas == SMMU_OAS_48BIT) {
+    if (s->oas == OAS_MODE_48) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 79018f8d66..c67819d6f2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1984,6 +1984,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
     }
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+        return false;
+    }
 
     if (!s->accel) {
         if (s->ril == ON_OFF_AUTO_OFF) {
@@ -1994,7 +1998,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
-        if (s->oas != SMMU_OAS_44BIT) {
+        if (s->oas > OAS_MODE_44) {
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
@@ -2012,11 +2016,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
-    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
-        error_setg(errp, "OAS can only be set to 44 or 48 bits");
-        return false;
-    }
-
     return true;
 }
 
@@ -2143,7 +2142,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_0),
 };
@@ -2180,7 +2179,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "supported.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits");
+        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
+        "supported.");
     object_class_property_set_description(klass, "ssidsize",
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 7f0f992dfd..4609975edf 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -342,8 +342,6 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_OAS_44BIT 44
-#define SMMU_OAS_48BIT 48
 #define SMMU_IDR5_OAS_44 4
 #define SMMU_IDR5_OAS_48 5
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index ddf472493d..82f18eb090 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -72,7 +72,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     OnOffAuto ril;
     OnOffAuto ats;
-    uint8_t oas;
+    OasMode oas;
     SsidSizeMode ssidsize;
 };
 
-- 
2.43.0


