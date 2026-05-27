Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05114CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMYc-0004io-6H; Wed, 27 May 2026 18:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYb-0004iZ-Ch; Wed, 27 May 2026 18:16:57 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYZ-0002I5-N5; Wed, 27 May 2026 18:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElXWPh8p8b6vWuCgo/rMoL0MVFU5M7rVaCRq1Qd3mQpxb4BoieJBRiM6/Nxb6PaGg5lihPAMS9a4oPvY9hGpmzgh5yMqZ1ksN6dA6hhOyGaPOXXLmu5olrUCQAzGMG0450Ai2/OqDXH2o3ptv1CE51CIiV5SFvij1cTLH6hWeYyv+qC9BU5vYRJfkGkLd3L7b1ryu+HV2Kb9dl7J2lkscnC1Td7olUmUEdBFAHy6pzKwc4BApQgkAqE/Ks6j76nZEqW78OUouNU4aktErgbEC+NDBJMZcgRmHDKj/lOe0DkiQ1jjUPF/QCyzNxnxJtxEk0i4Z0jNR+NWEpP5VUqLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MtDtCD47ZPEekMvemzEuGyG56mJaPca41zNRQtRZTY=;
 b=BGmnWH/yEYLe8AhWR+NePtwTHI5BydkURyneAsGycjvFOhB78bF+Q+g5yXa7Wm/E5X+00NE7cS5qXesTzuxzgEmrdNPJwXwMReBlZjI/kC9aDEhAxcfOPqNKb8HcORy4oOQApMvfaT4Vi/95WiXVdAKAciU94oW04PTevrBOBVQw3/0/27gQpCCN/YDsyg61NLjVUv378OsN8U4QRvqu+bqsedRjsrIgm6bT2ggmo1+Vimf2ruK4l4Pd2FNqsYqVJc1W6KSRI7rb+w1DQxLG/xbKevEgOvrkigOoH9gbniWzYepgessz9a0w1bQkEHXzek8lT3yS0m9nMBRBw7SzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MtDtCD47ZPEekMvemzEuGyG56mJaPca41zNRQtRZTY=;
 b=ntY+r1lrQqlq2O4HlZ5GMxZMKuSG6d9Y1RVYTQsGKTAyFY5p5eQQ5Hg6PGQoCh49qZebrEwOU2b1fMw+11q1wE2XS2u/y5gtvnSp7fS9NSH5PtfX8ImECc3oOfKFAaDP8P9taPcaIyyZPRbx0sdYZ1MuFC321iQoLaWz4MA38J+STciyngQBeZRcGShJevnNsylFRjCsLkb70VvqpuZSgfSnnURonrhd7SegKyNKW/IWJuAlfB7UlZ/+Pm2ioi3WFV3JdMdGr27LwzmiF+8LDLFtp4KckkqlEO2Y+fr/NMnmfgz2y7BE12RhjS94WwAqVrwi46G9MfiM/W7Sq39cwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:16:48 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:48 +0000
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
Subject: [PATCH v4 3/9] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Wed, 27 May 2026 15:16:25 -0700
Message-ID: <20260527221631.612026-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: b82b96a2-a74b-427f-65b2-08debc3da52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4sC1ll57jrnxRwvG+TwBWVguYmFQNHMltZlvfVy8fvuPulqWT/SRwCehkXNz8kTb6bdu8u8hmzRd9XU1P14jZRqmi7m4btU9RZ9ndLioNo5jzuMm838RWRS+p+VaemjetMDj2oFsyfzafYx3A+6Hco/dSTQeyRBxzdENk3OV6UBZJVPqJvKgKeWOZ/8GKrlvVJ0ql6wHZ675708hCvVQfBu/wc0uLdTKlHplk5HGQdv9PgpGGbxajt7wzXP5k+4+8HNDk+TkxWdkgEqRXIL+sqktiWEDyJP3Ug9pXopNYkejuV9NsaeZl9mTx/U6OADCCo6lAxC663/SNmXJwWW5WDSKecLZjpV60Kqx1pTJEV6QaBdtFqEjbdzb2kev8Qd1Hf1GWVps3JGT8fw0m1rTrtAaaZg274fs+gVeHW175ZpTXWFG6SzJZdVpwNhQ9qcRdiY/sJqjXPjQKcp/+gVAJD4B4nbfyH+/4UJdDOveoA5qisSLiVCqbh9vYqwJzg5Nd7nCy6F1J4l02xxLdXZawhv6gFbG48V/iOjAagPjBR68DRb2/Xk7Vuym/oWSmMur4/KJuc9+Xar0xFapGS3jozOm2rxwyvKbIhT/97zFR0niqFxOtrmECmYx3FztvSPB+aD+6trU+1ofpZ5i49dX7zRv0owjib93LJ2LUAXBSoWapug1AECgmGv/kTgdCefW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGo4FFfEv2WxW26WahC473ZdoqxxtkVtDuH4rh45EbFdW5B/cmmmQjTDUyBe?=
 =?us-ascii?Q?IJ9d5bJuz1GA6dlH284qqC5G0DWf7LGXeGEF+qTMx5MPcwq5WGeTsZ+txB5o?=
 =?us-ascii?Q?ePU/krmN7fuJ6YlGIBD0xDLvyadftrKM3eW+wHGY6nv5OWqvAJymtM900kqM?=
 =?us-ascii?Q?8Xscgo3DRN/ch+aoBfmK6OIGhpeXroBcKsQF+k/nXMVs3P8QqydsLsS8WAe+?=
 =?us-ascii?Q?NbN0Wqb49U3SKDGAoJdGjhhPjzxmvZeoPJ5HvVGcsq72KLRL+Dn4B7mz4lLt?=
 =?us-ascii?Q?RmLvwkRNtbcZLiFBVMf3rlQu6bhRZY4dIJre+TxoGuUysTpwf8KgcniH9H/i?=
 =?us-ascii?Q?lT23jg/s8s6LJloatNT4TDERI3gqgVFv0FdMgXCPzpLhoVSOwJiQSfM2Ekp4?=
 =?us-ascii?Q?YrlS/2cjyOwjFYcBrqu83/Lq6OZ/bViaZ8Hei0uDzqy8B+p2QgVQGJNcTMCX?=
 =?us-ascii?Q?jfmokJv3MUUnhf6D84NHWwNP3o7PGMvYBmu1KV+zZ+g20B9Ex5U0b6vKaC3j?=
 =?us-ascii?Q?A0pdKNCYNVOfTOxzaeuSVEes/AoGn02DHb+maOoc8CKh0V20xBiQ2E7Ro/3N?=
 =?us-ascii?Q?pSnYPmkiavYYNGEUo72BxESV+2RHogu8LWpNmSa/MCOnjqc5sAUPNOq/N4Zb?=
 =?us-ascii?Q?Lc3WxozgNYkF5n0HzqD0yxCxeMSPzG20V5WG1B2aT+qHmvU0IOOnrwTnZys4?=
 =?us-ascii?Q?x+Dwzo0YhP8RuP6LgqXz+cvSlw3onfQUf20Fib/T3hXsO26Hhxr/KXt6ZFsi?=
 =?us-ascii?Q?VSRil2ywyPlG59uryPvzt2t+iuZUqtnkcRbaJvhyBpYdclRsHSmfkKRE5HC6?=
 =?us-ascii?Q?3eI6ux+eufPSRkKHazYB5d7+kg6CO/Zcxjaobhte6cqRiZKXwKuDaOHHqiQ4?=
 =?us-ascii?Q?47aTT1SRJtkpv9war3A3xp49EnskiRqcwZDh7vCTm7e1p/c4qEYrnDGph2Hw?=
 =?us-ascii?Q?UyPZE36vqHuKTZYVbCzcF9xP4bqS3XIgEgTx0sAogwp4ls47JeybgG1i8zqZ?=
 =?us-ascii?Q?3u50IvlqtQF+DLVMYbbeTOgtETklfVbwIju+KKZQgt+8OFCh+lnUP+XXB6zI?=
 =?us-ascii?Q?InFECp+BwTjbkLZiB9JpR//mjz3XaiYsAhR0MjBSceRo2B4zV3zZXOtOFlXU?=
 =?us-ascii?Q?z/GTV5FlHj198Z+j4BhaW8Jg0RspMO5alBKj3ABQhfCy0+rU5ZTkhpHOmtNH?=
 =?us-ascii?Q?Ej5KCDH6Qah9lGKReCFaiQ5ZVrp/LzOWC0DloMHPgfwyeBH9yXT0neC3p1Cg?=
 =?us-ascii?Q?BB0vnJurhEmSA0Id7y5MKJYaqeYNIsZMyZwhO8IJHI7vt1Rm/KdxsIcXGjlJ?=
 =?us-ascii?Q?l8xlPIlc+dqZv0347x4a0wnOW7QOaTl1hUEHU+5HQA5YeGDrFxEivPl2m5Fy?=
 =?us-ascii?Q?YGVgqUAAwjTlmW+rOLSyyR3x+V7z2OjL0lCk93SLpOJovn97q5BF7yCyobD6?=
 =?us-ascii?Q?a6ptMaFzpCu8uP/cwUNpNU8P4EdoCp2J/0XXapZa2InLOajpvjpaNavJWtGo?=
 =?us-ascii?Q?0iQX6agD7KaKKY4VTCH4yLHFLPsX4C5FnH2+2ryI6PRDYrHbDSvQH9xz+gRk?=
 =?us-ascii?Q?7JGGa7Mk79JyDdlm2J1AdJAllNh9ZlkjtZYBhr49ros4JZVfHDTX6JQwKJpm?=
 =?us-ascii?Q?pMy7bzJc/f+BljuToppKGyiSuEqVifdii061pfGjpn3h/mk5OC8u6A6xAjOB?=
 =?us-ascii?Q?oSXQYp794MK9tOSGD8KeRU8HztfqZeCEzdRb9G8O7wFspNQ5uu4D8uA3cxMI?=
 =?us-ascii?Q?TvwSXCuHsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82b96a2-a74b-427f-65b2-08debc3da52d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:48.4672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RjJtj6p5RhhU4IWxHeLzRNF9fUcsssPpcO+FpT3/ZchuqYej/ahIsC+eUdUO8XgpOJscp4ApwJHXYmddcTElQ==
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

Introduce smmuv3_accel_auto_finalise() to resolve properties that are
set to 'auto' for accelerated SMMUv3. This helper function allows
properties such as ats, ril, ssidsize, and oas support to be resolved
from host IOMMU capabilities via IOMMU_GET_HW_INFO.

The later commits in this series set the auto_mode flag to true when
an accel SMMUv3 property value is explicitly set to 'auto', or if the
property value is not set and defaults to auto mode.

Setting these property values to 'auto' requires at least one
cold-plugged device to retrieve and finalise these properties. If the
auto_mode flag is true, register a machine_init_done notifier to
verify this requirement and fail boot if it is not met.

Hot-plugged devices into an accel SMMUv3-associated bus will re-use
the resolved host values from the initial cold-plug.

Subsequent patches will make use of this helper to resolve 'auto' to
what is reported by host IOMMU capabilities.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   |  2 ++
 include/hw/arm/smmuv3.h |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 862be814a0..fa0a97cece 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "system/system.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -35,11 +36,33 @@ static int smmuv3_oas_bits(uint32_t oas)
     return map[oas];
 }
 
+static void smmuv3_accel_auto_finalise(SMMUv3State *s,
+                                       struct iommu_hw_info_arm_smmuv3 *info)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+
+    /*
+     * Return if 'auto' was not set for any accel SMMUv3 property, or
+     * if property values were already resolved from a previous call
+     * to this function (e.g. if this function was called again after
+     * VM boot during device hot plug). We do not accept new property
+     * values in this case where auto_finalised == true, and we re-use
+     * the values determined from the initial cold plug.
+     */
+    if (!accel->auto_mode || accel->auto_finalised) {
+        return;
+    }
+
+    accel->auto_finalised = true;
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
                                  Error **errp)
 {
+    smmuv3_accel_auto_finalise(s, info);
+
     /* QEMU SMMUv3 supports both linear and 2-level stream tables */
     if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
                 FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
@@ -918,6 +941,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
+{
+    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (accel->auto_mode && !accel->auto_finalised) {
+        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
+                     "at least one cold-plugged VFIO device");
+        exit(1);
+    }
+}
+
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -925,5 +960,11 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+
+    if (s->s_accel->auto_mode) {
+        s->machine_done.notify = smmuv3_accel_machine_done;
+        qemu_add_machine_init_done_notifier(&s->machine_done);
+    }
+
     return true;
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 407940616c..87fecb5c68 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -25,6 +25,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    bool auto_mode;
+    bool auto_finalised;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 82f18eb090..85be3d7467 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -22,6 +22,7 @@
 #include "hw/arm/smmu-common.h"
 #include "qom/object.h"
 #include "qapi/qapi-types-misc-arm.h"
+#include "qemu/notify.h"
 
 #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
 
@@ -74,6 +75,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+
+    Notifier machine_done;
 };
 
 typedef enum {
-- 
2.43.0


