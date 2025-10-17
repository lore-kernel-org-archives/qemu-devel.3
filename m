Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD16CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nAb-0005Up-Hc; Fri, 17 Oct 2025 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAU-0005RI-Rj; Fri, 17 Oct 2025 12:19:02 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAN-0007dT-Cg; Fri, 17 Oct 2025 12:19:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VONYzctGqUeP1e83UBr1NlkllOtuKwbsHEUcCdXKhkLROYJnQfGeX/RAff0FUWN2OEMEyQgDSL52Ssl350ZHvcOS4GQchEtZCtmTM72gw7JQeJ308iLPeMe/ouOM3iYOUGoUb4JHucLDKnUFYa1piYD/JA+doh6mN/r5DQ/WA6iGirHdSSnRHxQU5Hhe7vP311bz2HFyTapUccXn4MYuVKeFsWWe9cXOWvWxqynxFVcGleUCDO3/oTnVI8NqyBjaeXApl+GC7bI1+tfwfAEwTD6qHvM9ZTCcBuzHzvrVDKX+5CP/MWbo4pNF1RXSuARQ/KDwtzx2XoNC1jrfchN5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyZTe82I9LNu6s0C8IbsX7nzfESH2ZT4972Ow3dfDt8=;
 b=HLMOP3g1Fff7YbN/zTPwnIDbsx9mm4cVcTrraaR00dheOxYHIyn4uAnqOeSrsoTRy01LDlXa757GDom2RuF/47e163vYDospxWJ91JROjhu/fPyptAoNVp1BkDMznsdl9yiyOQFEc0Qsl7TUukY6pKTkkuhv9/LkvTO3rGs/We/I+fO4sW5HmMuzJZOT+cAhMH2+nS4a9PjM/vRkcXgEEBnHkbQhWuu7jSIk5LTmAgxgCpUUmAURlKulCAvtliQpOigpHZPhl3O8lH2fibbUr01HGkZfQP1D9Qw9+rut1WbwM9Sk0GPGoTdWd++H0tNv69Khbe8uogHoD+yPfxKEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyZTe82I9LNu6s0C8IbsX7nzfESH2ZT4972Ow3dfDt8=;
 b=K6jhiLZXe8TAOfq1O3nAueouxbyzeiBUVWSbALKwKpcMeIbVsOeba987YQsYozDfGP2F0X/Zn/Hyy2iaBAd1yEXQTd/UNLLYkdOVfR0MDRRIfqKAfJLhwFkgn5XXzCfUhqOhX3T//GuJ51O+Fya1/xR6C2elqwlZi1g6+1WEkKw=
Received: from PH8PR21CA0018.namprd21.prod.outlook.com (2603:10b6:510:2ce::8)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 16:18:39 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::1d) by PH8PR21CA0018.outlook.office365.com
 (2603:10b6:510:2ce::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via Frontend Transport; Fri,
 17 Oct 2025 16:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 16:18:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 17 Oct
 2025 09:18:37 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Oct
 2025 11:18:37 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Fri, 17 Oct 2025 09:18:36 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: [PATCH v3 4/6] hw/core/register: remove the `register_finalize_block'
 function
Date: Fri, 17 Oct 2025 18:18:03 +0200
Message-ID: <20251017161809.235740-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017161809.235740-1-luc.michel@amd.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5fc49a-f1ac-4a1a-9bc3-08de0d98d4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vTwBFxDciJ5I4i6Mi86YA/q1FsT2B0KFSd5e34tmJXLAMi/gtrfNZM79LxLW?=
 =?us-ascii?Q?PnIdUjD877gDbUpFUTmTiX1aVkkYYCqXp7OpTJHO0yl0XclBe48Fzp0ZHRkz?=
 =?us-ascii?Q?pHqgJuJQIka1RRl2TJHMOZt4j+s3TXwj5VUFCEcC+BlYjROt7oSdhXGK5DxG?=
 =?us-ascii?Q?Kj1D1iRvY06BfXoVQQRB03G1tuGsdEDE292hH+tMlgk0NAwqdp6H41rO4Kzv?=
 =?us-ascii?Q?mT0fhlQL2JA6RkMLB4WDl9aoyRwRScjQ5zEtT0IOLKghwnhdePPXs+Y8eF6k?=
 =?us-ascii?Q?y/MCKC2BY7+u8CpO84vap3IpDiXVQaDwYbrA/spyFzbTQ1kgC577fHuK63C/?=
 =?us-ascii?Q?l+15DCFSAsaNewOVlsBSpQWOu9laT8ziewpZg+Z98mGxzQYSZoEoR4JaBssR?=
 =?us-ascii?Q?fy31SsYwM5js/yqjDJeYEoKsP471JYPZ9pH1FFuKNzih7fWGxaMXVTFdaWE2?=
 =?us-ascii?Q?nnzRJXiWK4xTMWEWqP2XgGTz9uBA3yKtnojMpoK8Pj8ublTzY4pURxgXAtwj?=
 =?us-ascii?Q?oa3Nszxg4vFwtMWlGhqNP5lLQ5DltjgsElWylPmH1Zs6eNughcf8wZrT3SLb?=
 =?us-ascii?Q?XZGAKXundvkwAB/ISkA9bioR9xdJoa7jcingno8gjtZogaYuSdOGi8Pascxf?=
 =?us-ascii?Q?rVf1f56jLZYcAKrPmbqhGfoFSgrX0/K8Gn5RvS8vsIQO0jPXQsgNRWraiU1G?=
 =?us-ascii?Q?Su6KE78XI/RU3BErWmHnn+No5niMwPFaWHSTXrNifWxG6qX2CSkBZz2RqJNg?=
 =?us-ascii?Q?osSJ/D1WQfBj/yCL8Jvb2W4WFjWTXLhKtFAJYeq7Utt79iVOVmnFPiy11HKa?=
 =?us-ascii?Q?1IQ62xBeIPwlB+fgBTlrPEF9l53RS0LCKrgXrD6XkS2M+8Vjbcnx3tQC+qbI?=
 =?us-ascii?Q?PyGO/wwX7m4Z3JPkUq0uT/bnI2ZpPeXY2T4Sm84Pw8hOgG2x0WXLjTTxIrzW?=
 =?us-ascii?Q?awzI5U2YJtl9umyz/6FchCGzjy8+CSlsP2cFBFKJdub5gajv+23eltr2mt0C?=
 =?us-ascii?Q?G6sabQVfKGCo81EO6Oq6d4PBQXm8/Nbq2uC4geRPefcl+889mPjqF2Zhoc4z?=
 =?us-ascii?Q?R43FqepQ9/duJCG8F1seYrEU/gGBZDuZ3RHXOUrc5IksNtzOtKbhZb9NzRZ8?=
 =?us-ascii?Q?1V6GHhDzn1Cmi8yANLurbV3vid5OqPf2Bdl3dkwO7B2uc3Lw9nUB1MggtfNm?=
 =?us-ascii?Q?cWorBdS+/lXPVHciX80DQ7SwyELIgOmWXI9so4vtRcGP2BZjQEsphzlcrbl7?=
 =?us-ascii?Q?fp2zbXFO9VAMK32rln9uj4C3v8AQ6nkEjO1xy8DFpTDLyg7ZujsACexPgyxY?=
 =?us-ascii?Q?W7XY+yeZXFEtU6FAt/pve7mJznqOTtEMRGYU/YstLnEiB7Nrc0dQklTEiWeh?=
 =?us-ascii?Q?6HvwR706vhn5R3lIRLcA2MU5wYCAy1lD7Vc2hDAzdkyPq+qXrSWVu70PLqI5?=
 =?us-ascii?Q?S9+5ivEPUFCJb3faq5iYY/M3bqMTQjzFlCZpQuJn4JRMb8DUpfv1SAa6Gt5h?=
 =?us-ascii?Q?ODIicY4BInaBw6BNwC1bWVpxUBqCK8F6futNEqzIFlkY570ywlUM8TEbYYsS?=
 =?us-ascii?Q?E4yXQiSCWq2AyM8q0hI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:18:39.0251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5fc49a-f1ac-4a1a-9bc3-08de0d98d4e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This function is now unused. Drop it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h | 14 --------------
 hw/core/register.c    |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index 65c82600e06..7b0f4c8b7a6 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -207,20 +207,6 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
                                          uint64_t *data,
                                          const MemoryRegionOps *ops,
                                          bool debug_enabled,
                                          uint64_t memory_size);
 
-/**
- * This function should be called to cleanup the registers that were initialized
- * when calling register_init_block32(). This function should only be called
- * from the device's instance_finalize function.
- *
- * Any memory operations that the device performed that require cleanup (such
- * as creating subregions) need to be called before calling this function.
- *
- * @r_array: A structure containing all of the registers, as returned by
- *           register_init_block32()
- */
-
-void register_finalize_block(RegisterInfoArray *r_array);
-
 #endif
diff --git a/hw/core/register.c b/hw/core/register.c
index 1612ad174f9..81316d48597 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -320,14 +320,10 @@ static void register_array_finalize(Object *obj)
     RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
 
     g_free(r_array->r);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
-{
-}
-
 static const TypeInfo register_array_info = {
     .name  = TYPE_REGISTER_ARRAY,
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(RegisterInfoArray),
     .instance_finalize = register_array_finalize,
-- 
2.51.0


