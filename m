Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B80CD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIFw-0006OD-AP; Thu, 04 Jun 2026 20:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFr-0006MY-R5; Thu, 04 Jun 2026 20:17:43 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFo-0007xI-8e; Thu, 04 Jun 2026 20:17:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZNDLlpU8ESfRon1bJTM54vKhLxfGq9Wit4K6ANtoU9vu5KlteOJftzVVeEs9QPtbQjtFhN2BQocojzz5A3M5fo6wMeMTxgaPah9vvvkxvCezKiQ7fSP3c3o2UzJyIkchCOqhtCf5nyCN50K8whK8wWfB6E1VHkLJdDGEpgLtbXwweeyZrSt8vrwj6t6cl0FKUXaBq5tapA0R1BLd8hFRp/QF4fhZep4OpkcMjMnn9bUKx6MFxlZ5zRLjeNMNfUq7LsONu67zroqlvz3rvOlq0yLOFw2T6gQT3MMC+arCmBTCp06EuBHCnFkdRyFYaOnEOnj92tfsK8b69eA6vjl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MtDtCD47ZPEekMvemzEuGyG56mJaPca41zNRQtRZTY=;
 b=R9ppD2k9/h7pl2T6MS5IELaSGZtPTzhNoL9duLMndb5qiRwg4jIwNTVw+O5xH2RAoOA9m/E4qBb9v97ZZIq/s+mADB+MVCBb3VYLUgX78IsNj+SPyRkCRg7AuWHLo6c50R5+zAmdz13PU7s8j6JieFScqWktHbF9PEW8cdTL5532ipIAz6zSY21bPDxM+0vv2htR5Dz8wnZrcr6weI7OI5GdYg3OxJWLkW+ggAJgyFx4VAPyTs8kXC5KrGtB0s7AHu5+9A1PdYNUnucnUrPeSauIoYt9hO8hQqWvcMQDyETkpnH6++IzdVO5/nFC9wkSKR7N4sf7O7cDUnFtPeOASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MtDtCD47ZPEekMvemzEuGyG56mJaPca41zNRQtRZTY=;
 b=GOw9cLvvIv2QnSgv/9H17Ou7pry05rVw8SYg+Te6Xt62XVKDs9Wn9BymQg/Y2MBVTOIIBpLbGZwYFBN4y0Ax62kJZ29PPOv8/NpI2NjJ6pbIoE+3nS/k1ehF7VTDxwO9h1/1oYRuy/PtChkpMlbS+7BvjJM+mdsYPiAM/Mgj45z1woby71TtpabypqaZmia1PB2VN0P/zPi4Ye47qFNsZVge/xwpZ2R3WunAEzvU1RyHRWgw/1v3k5sW4jaoJ0Las3p4DyXZidK3i7CTbewsYA+vF2QooprCdNQ7Fj/OdWccXMUhpxFHgQO8A1vbbgaWmE+xXDPbUgeyjd0LVibHqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:25 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:25 +0000
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
Subject: [PATCH v5 3/9] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Thu,  4 Jun 2026 17:17:06 -0700
Message-ID: <20260605001712.1823737-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: df79dd4e-8b5d-4401-f6d2-08dec297d088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IF5yS+stVfF0/cvklMZDIfnE02JXL2uzNQ4h84fdh6rbv7sovZ6VJySY5FiZ8k05lBgIaZ+IUYqLv3VEZVIXDJHS/QkzhbrAqPcY3mJeX4oVDTeywAvNUrB5jfnli5us7L6AP8NkM+Vs6rq7+QyfKK/i2Y8kONViiVfRVDkxPQNCTMDeIJjYxkjQTWFWx27hWgBEFaZ/L0MZ/SBCCAIwLRPdwbXR6dnvqnnAwtGyvk1uST6+x/L/HmqKdcKIgZAAT/B5sz169n/ovsmobE84eLpi3FpFgrAOGQBE0MRQC0g9sMZqIa3F6NUyCRP6F9jCFECKpksPsPlZjvoxIRmHm1nc+oc76hWKjf19petkUsSEKfrw/JNucLsp4kWun1xq3+pu9xaaxubuNKsMcIRkXTaz/3Qrb3qVUvhhjggMCmKEz0fwqhOl+tHbmJ7qhbbqiEA53Iy9y6tdJRSxcilNNMBP5hhbMilS7ZnzOf440ypipPZoFN7B/8O4SnRr1vwrkQSYK3xsFnXxMQIQeMYTfGDmGe3w2WxRBPU5Rx5ZGyjFjHGq1rv0XN7fLNAJysKGDUZeYaIE7wIUCSjncLGCmK2IZSM0CfdPZvX9p1MmDFPrRzvIuNFZEqPnfskQTK0zvYkgUIjgsljrmGvDvspbMciJO1mi5tjQWtpJgck5Dumo2pfoIGTrNfiMucCDNg/R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mm7oakUfg0VQrSveIvjn4Q4BDW/ctvFrlFntdTl0AOJGe/idicCL5VBqjLjX?=
 =?us-ascii?Q?qB+l5z61NBzQj23V6om0hX/39H+yXsD0aaOGlc2gV1zgJ9HY0UH4zgPKmj4O?=
 =?us-ascii?Q?ODbpYXpcRISirBL4nf8eJSTJ2WWexqTOOSFiYdTus6pNuvP3BsSjuAvlwqs8?=
 =?us-ascii?Q?csAomKWDtM8irSNyi8bGnoNdLj7Xw2+9Tpa3U0dGiQUfwyYO2kqZj0KsVIJ7?=
 =?us-ascii?Q?gcRPXPBRBwluE/G0yVaNYMlfdUU4wZXoV+xD7ewrVmrlxhLTxmXWVjE0miCv?=
 =?us-ascii?Q?DmPwpJbG8MNe5uzltYAscfZsZmiLLGmN1igCFzEi7NBQDP0ifqj6bFGD8VuK?=
 =?us-ascii?Q?hlDbW3VPKec13DFvnayt7rRkOlfED6eG/zAAgqVMv7FzRc945ZzUI8kVUEml?=
 =?us-ascii?Q?o3fRzlbqcn+8DSQBUBr4/YCc+Lkhwf59qSaSXCO3DCBlbHyC1I9EInizJ1Td?=
 =?us-ascii?Q?WCgqa3s6oDdM4OnbFgSReRWIuh3j6KfEGyuHIX7Sm2IoQkbXoRJc8OPvq2g1?=
 =?us-ascii?Q?lHmOGkQdN/9ODpqOqrJJGiseqKIf6sft42MAo4wGXQ6N3Vtm0zBsBoafa76X?=
 =?us-ascii?Q?Zx5NbWAP/NJfmRvmOHCNcouuoFmyvpGJ0bAfdkQFogNWR6/jBN/snY2CvICg?=
 =?us-ascii?Q?SpCQ2KGUAeScjMJ0867h1GEnF4vdBklshyVH3iQZBR4CHuOdWsDlUdGFK2ud?=
 =?us-ascii?Q?ByZYo+7W612o1iIZK3ReqVBSPwDXl4UK6iUm2niyB2H92xjWeOYsjq+LnOnO?=
 =?us-ascii?Q?tuzfe8+vHI5RFq3WO4NAPvGh+5pq682hSYMm5SUxM5lQEePWK7G7ynueLV2I?=
 =?us-ascii?Q?o8XrPjcjepBiF/BtBYWcTOHplnQZMwEY0E9Hx9pH+2homJQMseosR2awtVR6?=
 =?us-ascii?Q?C7isTyXmoQ+lrZMbmoo6Zm+LeQTxqCgRIPdgjTmdq/Lp3ZcRK+VZopTBNtTa?=
 =?us-ascii?Q?ecFByvrE6z0L9Dkn7cWgUFqhZE/XmBjVzXImqzoEBMQLb3+mQ4bfeuO27gcR?=
 =?us-ascii?Q?CFTcjrWx6CxemLCLgqQAwGD1Yhya1GaY9IWsittqrWHYf/dNGNI968IKzUL1?=
 =?us-ascii?Q?UrkVPUfwNZP6SjWdctfSXDyYor4kwexebcFjSjFxwupCWYuVxrJC3g2bHdJX?=
 =?us-ascii?Q?P1NMFZ4A/icHEOCj97+mV9TilOHAlH2YBJ3XpI/N5MO8yX79Xgxeu7zy29CO?=
 =?us-ascii?Q?pHeCSi5mhwcJ/Rfd6po3Fk1A0P3/DxkBxbibeVeXZgI+g1DI6W5CdCGI7T6g?=
 =?us-ascii?Q?//Tgh+WEyzR7+GeQZigngOFGRXDyOjtGHuqJkMqK2nB32k5jT+WhKKaMRDC8?=
 =?us-ascii?Q?+UMq59sce0ubpzVlrYjZGNf7Kpb9aRI94PLYdvw2Mg7jd5neW6lNeXj9bs3q?=
 =?us-ascii?Q?DtvDVTUCMb9TRA8pOacjwEznbIYfj26Spw+HrEzmrPvWmgHJOvpRLdCeJssC?=
 =?us-ascii?Q?sxJFtmikS67ZrAUjikZNTqjNGkmkga03ohqkhLFJuv31mp8NbYDRobcmddkf?=
 =?us-ascii?Q?9p43tpUQ7/+iTd7auIqvsDcxaepHCeWQ3i9Cx7HG+TxMcM817o+VCVGveniT?=
 =?us-ascii?Q?tGP7X7tVuv6DL1yI62Q1mV+bkPpIsaa/8/gyOaJ3f9JJAbAs3p4GAX2ftQ6s?=
 =?us-ascii?Q?5TTUW+RIMOJpDzom4mv7fvp/8L89/pqGaXatun48AkzrzJoUodkVzLCVOFX5?=
 =?us-ascii?Q?aqHfvGVhNaeRSABh5K9/k+GoUocGh41O14jNF0MlJ4N8yEtdlUlytmcXp6k6?=
 =?us-ascii?Q?dnD3UfEEqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df79dd4e-8b5d-4401-f6d2-08dec297d088
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:22.8685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXBzPd+F26TGDe90I7ojysd+3RovGk1Fw1x0CqDmvX0OUF8Dx86ZqfrclsnbxngCDbZ+2Gp3V4IwWKM2dG70RA==
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


