Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C66CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMstu-0004bS-2Z; Tue, 12 May 2026 15:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstm-0004VM-H1; Tue, 12 May 2026 15:36:11 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstj-0005nm-RW; Tue, 12 May 2026 15:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sny4xGD5CRH52av/b1G6+jNesGOQQcNKYiUSTFJSQ9zqs4HvIhaFknnekLG+JUK0cBH0s5seQ1wKdSadASOuaHNPLI/8FbFGkzsuebQaTU29jZQifFyxq4zR6+HalsaakObTWES3b2S7q0UhG+1LZvJsCjBhfsKZc8+RLFBS0EgPnzP31hvAhXcKhWSKoBX+VptZtEBA69IF3fdd7OjZW88acW9QNP8OcyniHzKzZ3WcI0pCbQqA2gtYe4K7qctzOgm3tc6btwX637Oipuz6T8IlkiGHSeeuCTnekEMCQUepdkompjGMcnfu3MainGqyoasRAxVMCUm3ucJgZVVZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1LF74ovB9Y3o+wzrtY0nQlpzIQH4fXZ+vFWNvtqaFQ=;
 b=TFhf08oyIa6f5ZtoLn4TDrdYxYSZgQ32mxCoYzdodV2Dh2a/gvHLFcPrLtGApzC5S0lpCK0q994s0ekzHCBlhGhizjoi7eKxPUTTHGnnCirq0AhBQFwT05hvUadsc3oAJgOw9O+3r2s+D69CEzlK3goiQamtk6BRuUieokgFcyqXxK678e7uDUh2P9MGT35fpSwyoIziUC+2NBACczlpMX82yowqxNrnbbKFqanEgWAVwQKgNSNM80FWAwQ+GcLvNqGK5rnAThpYvfKmQjyEQsO9J/XX4hTpBeVBUVDAF6bLEuwx6uhZ/qQimIvauyosJrF10m711m3/tynjBQEE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1LF74ovB9Y3o+wzrtY0nQlpzIQH4fXZ+vFWNvtqaFQ=;
 b=UExgipx1qsJ4XU87gpUI2qBASiES5wrYJsSS0rOvcOJO2KGtbdsiJDwU+fBnPirLeBAb/z7NVI+yCaa7CJ1PSlS93AcVvN/OP7RbArkT5/Q0TwaOp+M1nECbKMcmLXXS5boFQXldmem9Kj+3Yir98OiC+02F37uZGPyJmhJi71aW2donrPVWzE5saFAyIoSaPQkpMainMCkBZrBy0r85qHz4pgGNq2tRdaO/tQajKFweHRfr+2lxUJmS+ddURO8fw3ySnxAKsEr41ldr4Lahe1a7AelEcq0AHlfEHoTOxsptevw6T2lfJbW77aQ+zJEr3awBHGDgd0tPSe21IRRqYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:50 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:50 +0000
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
Subject: [PATCH v3 5/7] hw/arm/smmuv3-accel: Implement "auto" value for "oas"
Date: Tue, 12 May 2026 12:35:18 -0700
Message-ID: <20260512193520.3109172-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::27) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4b04ae-3e89-47b9-1160-08deb05dac1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tdJ7gfBi7o0k48RXuR1jl52ay4cuKTeC5XvfeHt3r1vswwrwUNUXco0MAwweLO/Tviukun7bj3HCPR2pSYgibGmVx8k8fmoBNKEuWcwABou59OQPfXrtWHR4qtWNA2CgxJt2Sj8baGm1EOOmQDKKSS0RIj5uNk25tQgY/QrzfuAnZeJGl/qY6NJ3imMBB8D7f9bzbM9hCVyJWGTtk90k36jQVCvX/dsjreus8JgDyIt/Lf7J3MABg53Zxe/i4BWt9tQb+uOa+Bt1dyyQMLodO81FW1gCg+OCfRPezFfz05bYvqTIffTrEXPPZSCFQSn6olAqdVxXfC/jPb3Wl/nzs3B+hLMIpOW03N47GqUWkZ+XbTx7DHV2HBf0mrHyXeS8BubH4ng4tlrEFWdimLPc0DklacGCTodKEIH7xChuLdlCXz/2BjRYoQu5NwIQyBAMjAAXs4OeMT+ljtwTQj3jK1hAHEFdbr5moIA6XjcTjoLurQPa3VWJgiI8jrhS5lKunj54KVIQ2Rqqfqoxv2tdSwKgXy8ohS3Z7csBRot0xGsJTNBlTIcFpyv0S2mpV7DGo74GSfg3/7ZxtT9f508dtJ3xSAFmjL1gNvbWBuFkhiKDhaVXYZbsOrqgRmsCvLGggPC3FNoLqnl+22fuDUuLT/Zh7JVrGPH5fIQE8ubOUQGxYK/OdRHF4XLROBu5PA6Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYySB1zBb8QAKySa3TyIa7wcVBRYeu+I8c0HkHcXb5g28nqDSulGVaFley/+?=
 =?us-ascii?Q?PKZl0FnV5l5GBKy7hXGGC8NnGhnSWIEs22GupGN+NadlONXEy1qmzDSzOq0j?=
 =?us-ascii?Q?6lASxPHlayZaz1iniq1kmz917Q+UU8nQFo4yKgNOBy8hiMVOmAs/dYg/1gj/?=
 =?us-ascii?Q?gSLjttuqEd+sl9NQCe9h53fk+JMc2A/kVSZf7/npBLN+JKxvOaZTJ3ozjtAr?=
 =?us-ascii?Q?j2iAYI2q94lTsCuVwKN0P2GTP5+iBZa85QHzVgZklcfFcsfuqhbSfFRmFwtV?=
 =?us-ascii?Q?oI10MEJJlJGscoG7RVnnZ/6HnUDLtKYewwFXgtkHrK99zQlWIy2kr3nMDNvC?=
 =?us-ascii?Q?WqD5fs+Dop6K1v3sscoxmlQr/lob4sa6du7/DIbltERSaHlZCXGLkLV4HsM9?=
 =?us-ascii?Q?gfRpATh3uVHU+WbwsxL8EZ/aKiOQ12ib/OpatP/olC1QDEyTXqjQedxXJf8j?=
 =?us-ascii?Q?WZLYFk019yqDWLiznjARPBWg9587U0xpFsjVX2xI3qCaDhe9E2Hr/oMQ+DW4?=
 =?us-ascii?Q?3PMc3N5jcXA0J7Hr2owcUPscw3CoDR8LvO2qedYwx8qX+49exeXNW2S315jA?=
 =?us-ascii?Q?5aQFdFs8ManJttQ5ymc5FHCF8sm1Ky1sINdiSI2ZjoB2w5ljBN9UbXWW4dit?=
 =?us-ascii?Q?qKSs3Uk8wommfGt0d7qL69t17Yffyz88BiX+OiPk2W+tdwDA7pwJ4uPTQhNy?=
 =?us-ascii?Q?qissSRpQCpWQqG2woErXP2LcWL0DInoP68BfMB3XCpN9lyJY0/CatiN6G6z2?=
 =?us-ascii?Q?VN90+Ga7Dwvf8+Y1MwlkPxkz5TwsHTGPsTkjo/aj5A20CuBewuRAxwFlRcLv?=
 =?us-ascii?Q?iTJfC2o38D+qnroHB8LKJnlhyXvKIS1xalZGbwSLaVf+aIJ1Uy97ImB5gj4+?=
 =?us-ascii?Q?yWZizXGfM0SQq+KjZcG5WlJCDLq3ZTW3T/wqmBKew4sugY8VDQVS4RQV7JR1?=
 =?us-ascii?Q?r88d0RRw2bXt4SqAoessoCMIuJf29yiChOc7vjSPnwD71OE0648QI6iWnM6L?=
 =?us-ascii?Q?kFsT+o/PU+EPmVWEEEJmnyPwJ+0AgH8mE0/ISIBR7FJNVIksWLs5CU2ZEnTG?=
 =?us-ascii?Q?n68rmQLbXNESGhdxvemD1uB43GizombAHg0NRWGdWUDuyJUe7x2Gy3BakA6g?=
 =?us-ascii?Q?Mh/7gzRtWPeoJT0aJxinpPaG3rrkIuTTXsl0ZdZcwMRLsa3hT/IZyBBmA7n2?=
 =?us-ascii?Q?mvgRJKIdYXds3DSvqPN9r4n1VMvm/2YgR0irie8s1111uTj/lAcSmzjbnogs?=
 =?us-ascii?Q?jZfmefhu/xq8sSKasX651tK3/6bONvhLCV73W7fPMMmj4E+7EXdGYuFdXfmR?=
 =?us-ascii?Q?z2GvvdsZPGdStVrfr31ExjGjueQioFSCCzMQ4WmzvixfJOkJRJ+6wUbIMn+6?=
 =?us-ascii?Q?2FrZJNdUb2G756So587APKhulylGYeF9eBlJlcFQSMBsbyL7QZ6rnnfEcSDp?=
 =?us-ascii?Q?+Asga4FdnAyV/xS9NvI/5jRdYmZR3a3gKzj6nLMwwqY+pk99INyuuXOjSfEw?=
 =?us-ascii?Q?0CFH0hsxC5i+HPrP7MJU8nt1m2qtqonLKg4e/t+nMonCsBoOxBvn27/tAjbg?=
 =?us-ascii?Q?HysRls99oDOlYav8mVF4ZuwjHEVmJZjyj4q7bZKl0h69DJjLsh5bveeCOvI5?=
 =?us-ascii?Q?oDIVTrMxCPoZvCnp8G+4kkMoKtudFZOJd8XVGqW8d/I9Nyv195VBQ4rmGsOE?=
 =?us-ascii?Q?swCxLjIWZyqsDYuBw5KAy+TIkwoqUCE+bLHNCX6qvc7JXA+spyQf627WVbJe?=
 =?us-ascii?Q?VKMR1IX3AA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4b04ae-3e89-47b9-1160-08deb05dac1f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:50.0677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JZLRWiJxz36k99mvZV2eS84Hyynhw2gzKQVpsc8nAd7mWTRsjeLwtrtn5LpzzfauY+jsb96uSth/v4eK3eFGQ==
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

Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
OAS from IDR5.

This keeps the OAS value advertised by the virtual SMMU compatible with
the capabilities of the host SMMUv3, so that the intermediate physical
addresses (IPA) consumed by host SMMU for stage-2 translation do not
exceed the host's max supported IPA size.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 15 ++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 5b1af062ee..05257f74ed 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -68,6 +68,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
     }
 
+    if (s->oas == OAS_MODE_AUTO) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
+                               FIELD_EX32(info->idr[5], IDR5, OAS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -989,7 +994,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
         s->ril == ON_OFF_AUTO_AUTO ||
-        s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->ssidsize == SSID_SIZE_MODE_AUTO ||
+        s->oas == OAS_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cd30275717..31c2eec2f4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1968,9 +1968,11 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
-        error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
-                   "OAS; other OasMode values are not supported");
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
+        s->oas != OAS_MODE_AUTO) {
+        error_setg(errp, "QEMU SMMUv3 model only implements auto, "
+                   "44 bit, or 48 bit OAS. Other OasMode values are "
+                   "not supported.");
         return false;
     }
 
@@ -1984,7 +1986,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->oas > OAS_MODE_44) {
-            error_setg(errp, "OAS must be 44 bits when accel=off");
+            error_setg(errp, "oas must be 44 bits when accel=off");
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
@@ -2169,9 +2171,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
-        "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-        "supported.");
+        "Set Output Address Size in bits (for accel=on). "
+        "Valid values are 44, 48, and auto. Defaults to 44 bits.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
         "Valid values are 0-20 and auto. Defaults to 0. "
-- 
2.43.0


