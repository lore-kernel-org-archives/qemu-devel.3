Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E169CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6W-0006h2-GL; Mon, 08 Jun 2026 13:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6U-0006gG-I6; Mon, 08 Jun 2026 13:49:38 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6S-0007Bn-Q1; Mon, 08 Jun 2026 13:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEgbgVfbJvEYcAVD1JEMuahk6llNCAlR7NKQZo7V+cuXoOeymgfJuzeU9ucV0OkJYZi8cItppEOPHtxa6qbshCrHcpCnrIdEWCQwnz9uV6IXj44/05Mo3qAlIQZ4HW8/wfbQKHwb3RpTm+uRgwrdk6qBZX52CM27ZaFCdh7EYNtvl/IpA2xTUQ0BZJmdJtg3vPmlgp9wJFsna5krba7FT7ddTjAoyVfqx2MeZmqW99BxCArmF2M4RRAFuQebWoMGlOhMJlbb3G3igYepc8BHto/4B7S0mVz5QgeADpGNRQiWOrbn2LWcoRoABd8/sYBa1QPNtE8vWQ+d8sAxyzlJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOcpORBxXdGMHIDUoVikNmeu7Nmz1EN5FRK2g6AK1mg=;
 b=Iep4li2GCJIdYTZFQ+3z3NubAOnpXeBqF2PlAUD0b8Qvo9Oy0zm+Cwi+/87xByrUC8fJ153QSWn87FjDhW+o2cfYJTjwTmX49XIkxlEupCad/VfCuojUnOnNGhgo/YMoEELZaWRriWS4TMYAuGWZbPobnTwpb+VdeC0G8KSnLjTVZKWxeGXDwdQSmQFNmbYgB2RK1pHO7ljKOXOgsKt+am8unfAf8zZzSKczrvFf37jQ/8Hf90XauGE0sf34aKrqpUp1WU6zXTnJS9+0ffcvcG5tpcjZz16GamBKW+UlpZTBlfi4ZPPvuGJt5KSroNf4ihV1ys1kspx3y+CGQc0qCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOcpORBxXdGMHIDUoVikNmeu7Nmz1EN5FRK2g6AK1mg=;
 b=Wu4YfDofEPRBzs2H2pLVDOVIGWUemqv2tfjL8PEL7kvAHu6fezwHNlMU2OIDsrGYeySY8yWcQPWXe4FCIhK4QSU0R6QbFEURw9r+NZP+OrNtkdz+cQAXgS2ME82/LOaABrghH1ENNo8LftHSWdeo64X+4ArZ/O9Ztb/5/BHfKA1ig1S6htsUT30QkU/xO94HzhzNXyknGwzBj7Pvg5OXfLM0BFvq6Pg6WQ4D0tF797yIPQE3X2fe91ncfRKoD0X6fYuUtNdiwEbdQAePyHqNMHDP1el2Z9AgIC9nNKPyFq0XO+HkrUltj+GLpHfWUmybNh9x0EiQzkfo04yDM0KeFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:27 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:26 +0000
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
Subject: [PATCH v6 6/9] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Date: Mon,  8 Jun 2026 10:48:57 -0700
Message-ID: <20260608174900.2227340-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: ae017f0e-3db8-4f79-afd4-08dec58648a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RJVsJpZEeU0++KUewph4+9qdbxlXNfB4yj9SQeGYUz0Za8XYTwq/LSCiDojtxQsGb/BAQA55Sk0h2Z1oitZmsAWPkMps5JPhbcSrSIAqcg4qKYiMIAdgFlCOWAzGGjP7JXb8JGGY47u4lXGkj/5Un41puKPc8IrOYBTkgoNCZmnmLFhstqSIT739pWdKJ/H8oVywezPBhOWWdw8v+HhEYIbcLxI8wFRC9nXPSOcCyiZ13SUX8GTq9e4JNQFTn5oARCi1OE3HIpt7gX1T77VqBQIAtsMqAbc8p+EZtdJE5NZhIQFBj6hkgOCsALOBwET0eF3ocPq3FkfywD7HMurT+u5ocNEB49OqS4R1Ctj3TjiCLJINdM1LxI3FCWCnk8pc0SjUeehp7fcsCsHLQv1hjxGo/ZNP5xKJp8eOkEHCcfJpvF0Al1vw2g+qFr6LUZzQvOi7XClKgi3SN36XVUWSGRElByBheP7tRjfZ7qHDNH541hj4Q59yIoI4Ht3HR/+quSrkKjevRQjUfgzIvAp1zbZNFNVflaprSVjPuXqt+4zG+vSlThZ5YMNNTQf+7W0VLmoAIaoA976U+n1qSg2cwYsg2Pgn2RTQ3fiQcbyL+DzrEkO3OPZ9Ro2RT6LaaH5LHo5UasgAogJyruvSODMqEnLaPJKVesnM1lBgHgFwIU3H7pl45C9ztGoI9yLtjB9F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?larvwneIYDEmkuyIpg9kYPzUewYlRzhbfSGT8diKmuG/b4RMQM5vksR6gG1C?=
 =?us-ascii?Q?HoHzq53wLlaKbBTOHU38Hckcz7nH650eB3nqrTQ0eC3ltLtIYAzYT7xzXR0m?=
 =?us-ascii?Q?GGqew2yhL3KOp3fIpYS3U6Bqy0lM3KxDjMRjxeV98v6IIChnyErtbdUh5VQc?=
 =?us-ascii?Q?Fx5BYWl1qm9Y2FOt6ztPk6BJH6kZxyvelzGP+X+q56BVOcw85FR5cVYf1acW?=
 =?us-ascii?Q?t+1YbkjZPG46gfJaVvBVlaWUnEipivHfIBnCcwEbzi87AyeKtR3WIcjBxSOc?=
 =?us-ascii?Q?jTnNpXj7Vk/umCRZz8zrCUk3npJivjUP4ufJ4K4rA6CqAiSXo6cikdCzI2P1?=
 =?us-ascii?Q?JGTiAi4Ro/AJ30LVnbyJtWCyzNq4/Zv+fI7lSertoUaEbbrZ+84DUaiCWDBc?=
 =?us-ascii?Q?BrN2zt3XDeO8PWDREDpYlQQ0JewEiQZwOQ7DtelDvgkixgHxnd1hOdcaSL0w?=
 =?us-ascii?Q?h1WPx5p4VOnWwFvBd9O1NRMHLNgAInUWnNuY3W8YPWc83esVh9HpFUANGI7K?=
 =?us-ascii?Q?bNjar9o6hKE+r6xhbUlymZhwn1CmD0kBVnqYIggY3s1HW8Flx3O05UUATjLj?=
 =?us-ascii?Q?D2ZFMrjCK5wA9uDsWemZwsA80464Jn7XJYe2ix7J/g4YxfJ4r8nrtOsYM5Lc?=
 =?us-ascii?Q?w+FANeFv73d/EGjQX8LvLLPyAxeRITg+S7tBQcm6Ai53NJgISfqGUPQqekl9?=
 =?us-ascii?Q?gA5l0j1mvVBT5Cxu6R1neuk1Z64pnstQ442ky0HGQsHDkh/hz2RzNroWNT3Z?=
 =?us-ascii?Q?558SjF/DhUv2s43MhFgyZlrQtFrTWII/DnmWfGdS4bJQDS1fO+8+IIxJ3gcU?=
 =?us-ascii?Q?iWz7XgZzQH3K1Bx2eiTEYl6DvzQvNhZ6TSWMXmgBMFEt8LiJZ4C0srDGOCfx?=
 =?us-ascii?Q?HialOrkGySkFe8MaWUELMVaQEna+M9XmWPXBGk5LuCA2grVfWSGaWxjCgysW?=
 =?us-ascii?Q?D07LWUvnZre2PpRkyvoKlbrX30ClhMRnaas71AZ6kCjU8MYCC+cBJgDnoMMM?=
 =?us-ascii?Q?Pg8wGMOkpycTLcE9CQJi5P3n5GCTUp8/PlleILvpo23AVTyQAuShhhlcftuW?=
 =?us-ascii?Q?Mkx0wvW325iuQZuEeNBOOCZm+bzNrMAiMoSjbzg+cAcS7wwpmuzkHKQgpT+N?=
 =?us-ascii?Q?wz66D+YM1Crut0i1VTwZcp1eI1OF/moLFiOC46QqFSpeqBL+DinXoMBZx6fo?=
 =?us-ascii?Q?CQIeEyU5xGZ74nE03PHqBsRBMqjYsoh8MemLCad9C55oRNBZCWGmnPhKPCVh?=
 =?us-ascii?Q?zoxJ7vktqREHNJ5l1Y9OnsYYHdcYGOefy9P/UMHW7IIIiZ+ow/wLkw6BzK3J?=
 =?us-ascii?Q?wgqaoq9SP5RMLsCFkKFnoOlvgoQlZmMQ91hUv5itZjVQhrcVGPTDXZ7d9gFJ?=
 =?us-ascii?Q?0WzivGyBIYuIIje1H8JOXa7Of3xW34Yh/rbK8bL6hwMfnDMRF/OYzriS8rc+?=
 =?us-ascii?Q?fDs5Q72uoHTDIZxodF9XQ1JtW9p/Mhyu8gtc4QIrZbXFPxafMq0TaRmMPmeD?=
 =?us-ascii?Q?tmGGlT6lUGFUmeSPdoldL479PHOkBZ/Bi2FNm5fy9chZXihCngW5cH7QyEMl?=
 =?us-ascii?Q?zLeNSylrPYe7zRUQRAkFjsOLitog+XKt8a4JgYttytVaFu6Dv5tPK9ozoFXb?=
 =?us-ascii?Q?0SO7cj7WIe8GlOSJomdzi6/KxHXjlxdWr4zVgv+ueP5EmA0Te6NnPbhyVvPv?=
 =?us-ascii?Q?KYRjJ/AoRGk1UnUNjUrPSZ6hKzXyalZlWjFILVTk0wJDpwHT0h+JeqTshusK?=
 =?us-ascii?Q?peKPm77BNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae017f0e-3db8-4f79-afd4-08dec58648a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:26.8970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkkicuyvfOHqVffXGuOjeweFdKvAvo1PqAikP8ymlUrcQiDlaprj0mjZSHu5jOG89lbr24D7pixVwQfOR1rNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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


