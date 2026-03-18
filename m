Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4461077603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxe-0006jI-WA; Wed, 18 Mar 2026 14:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxc-0006in-ML; Wed, 18 Mar 2026 14:49:41 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxb-0004mZ-0U; Wed, 18 Mar 2026 14:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXhu0NE2B/AzTSP4bJXSoY9ITSiTlt0XJR+4zXuXPKJkYt/fSp96gBmSf9O9l1cclBFaeg0YMIW9vLS29bQKaxe/o07s5z4FyE6PIXL346ajXcR5ElrQ7BCoAPIBrhhD3MLPzAdRgIOdSp7jWDaRzwnAXmHwhyctDBPYG4GMOL+XTuS2ehaHKOM/yJjeCAHEeVjRKGyp4DnbHbzed9Z42vsVEmIfsinV+iKmyRTTbVUKBgjm/X3pJp2qt+xaUkbP00tJjfNBdDQLkwSKNkKkDT5WccJWSSZFfE3m8kSnzQsZD465LUbpprHsVOAm8e7jDZiE0CMpL0+1ufZmoRNkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETNvnY6uYOhdDQuKSbIDnGQ44P6TP2z/FfBneVsOzoU=;
 b=h8xpb/NPB20Rjb+cDyxt9ejG/ZIeVFrHGUqbiKzS4ekQwinu8DfWMvfBQPqG3bhz9SiE6EGtAZGMp9i1ORd/Au2TuoDOZaphpWOLILaJ80i+YshnsQmg81i+T8OH6d/ALPJpKCp2fkE3235Sz09Vux3trWm9Naz50g6AwOhvlcUDuSSLV8y+mUfoPKl42rJ5B2igiDIjrwVUxLc1UUeWDyqBJ9EKfMY52VSJeyPR64ARXeRKW7eElWwNIITvSAmYvWUDOiWuQ0LVmaYsY0rieSoWX/h/xzad6eGfm8UTzNRtxtkC3yGTRUSF6jaL43kjZykQfLNGXPZMm87hM110Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETNvnY6uYOhdDQuKSbIDnGQ44P6TP2z/FfBneVsOzoU=;
 b=i3C5pRPqdC9DYYapGm1xDnX9DauAsYDWOST5/wOBEUDU4aF4iycmf409HBBmrWOfE3I6xfOvdtoWRDSiK5ZeyhLlQAExhnj7A0Zx3Ob2uEZAkE4dJDfVTDP9cVd0G/JO9gpa84V5b7fw76Lutu61wMoiP2hTd+Nj2ve/lFggRg9zzOiCm1SSyQfQXa5n1ma9qt+MMCABrmLK3vHNU3ciWXUQ4pkqqu8iNw/7LLotcfVUV2A22doMGXs14iZK5JR26YcRVq0j9kJr2vPF6ha4JUQX0HlLp/f3PImjaCa8HuLM2zzJaZ4VGvzL0Df8h8ChES7vCjIgS0QakpexFHOEQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:33 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:33 +0000
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
Subject: [PATCH v4 2/8] hw/arm/smmuv3-accel: Change ATS property to OnOffAuto
Date: Wed, 18 Mar 2026 11:49:01 -0700
Message-ID: <20260318184907.4060030-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb461b8-a14d-4ae9-f499-08de851f180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vf3hH8myZUbNUoJic1OzGjKx5Qz1wwpr3zrBMLaE/hv2ha0lwhsYfb2MHeObYMxnuBWcbCRqWZQkEmdwfJv9okFnKx8cUeGS+rnpc5HRDW99huTGipS7GEOv10y0/i/LU+TWhaScspeQH8MlnyY6cnPZRjGsrLqVWiqYf2BoxBnguxdjCzhZog9ZiTAoZSOH5tbNR04ugJbM3ksrfWovMXa/NvAYaEsLpMlhsSwmg1gQhdZw1v2L8RHmBj7DSSUH7fHB7IWKAUuST1+mknEsJdSzUG5rLd4TvgLA0qE+BVGjTBU/PRwb2JO6UvlTCKcS8wPQtwSIaNolpKXV+rFcFVJEOQ5sAcQGTW9tqfI/OZjLGZruOXjha1KZrrhNkppU3CG+MB15jFswHgpoMjwIcoMt4xpCW+aE4SBIYVx9+xbkDoWpJ4CrfelkQJQzIb9hkA4ssvbxUsDtVid5ttOsDyIwzXX3oFeDbLd7As/sur97a7MGf0+dhpGBYi3Rj2joOV9b2I7/4pBSnJYC7oV8Ui+efzuhRQWTCNLZenPeMjN61Pdmozx4xv16F3E2GsiKjrCjhD796PDX15w0v3A7/fCcw8FUCUeKtBAntO0/C36dcz7UlXAJzqFsfGwC1f1OHrGUKJwXfOz3pGRbbf1kzzD8oMb3umKcxOsSqYSx0ra3+O4WjXyyKy4FNoUvdfK/bVYmzvqSiZ6ZTJWhR2RY1A1nEnH+xQSFq+wjNALpou8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2ZL00+KdqusNuIggKw4eZlYN2XM88vUlpUfH3UlNMJu5bdFErE/M6tne4Kh?=
 =?us-ascii?Q?W5Dp1zVpNFc4r+Y7yZ/GBE88UrVG/oiHT7i+rzGfza+/pTM7ptm+XTTNxOLo?=
 =?us-ascii?Q?1lOtBYhAru3dNBLgtM15ZozZE+LPnWMaJO33HC/KzQES6jUbCuDqcHYCUj6u?=
 =?us-ascii?Q?SdbOXRJDfm4xhVNP/XQoiUM1dGzWkflJJGW4ufwzobqI/Bghl9E5jaPG2+lS?=
 =?us-ascii?Q?ZllEbJXlRqnzylhIAnUmgz96a7+FAJaE393zwzpBJdM9Y+TudtgZcwak3ggs?=
 =?us-ascii?Q?xK56knls4cNYaoBcCoWqGZjNYXyn7lKOovQzfwrVXf1L60QKzq1RkOi3b7QP?=
 =?us-ascii?Q?4/EtT9vWEckkzoAH4VT7ErKS+OjoAqu1Fe1eTSIWCCRY2DHNUejzStGFamMo?=
 =?us-ascii?Q?peXpn/G3fGf+SfQ1+V85A+6MmtvgNC28IXkX5sR/47+Kum7Mcor6NgkJ7psB?=
 =?us-ascii?Q?07YS/w5rKtkS6+5sA9/qFUpvMNX6a3vvYrBNK1RT223hIuBFH8KPsl3+OHet?=
 =?us-ascii?Q?Wf2Rvd+JAI2shEi25CumBdxTDYw8+gHFAYaUoqLLjPJIGxZVHbAQVmX+ldYg?=
 =?us-ascii?Q?VjXy29OhbA1eG96O/qod1iGRi8Zx2ZOR6G4PLAJ1+p5vbWTQpf1CiUyOTvyZ?=
 =?us-ascii?Q?hKFz+qnTLRIjR+E6nX15+up9oYga5P4wuC2JITk8mztMZFZUvRNdd4H06Niz?=
 =?us-ascii?Q?dp1JlVyT5S/esS7tPrtDnL2ni27MXts0WjrMOM9aZszxw9O6d/MQ4cb0KDwY?=
 =?us-ascii?Q?56G+FdrEy+Y6SjdTCokEXg1pxUuTsyEtALVwX6rQxlBBkjJP7Amxt+hT5+yc?=
 =?us-ascii?Q?LZUAQWdhr2TDoOyZKpGdsT4jSb+ubr719zDP7/Mjhk13hffYLVtcigTQlygh?=
 =?us-ascii?Q?fY4lm/VxkHCtjRb7nhJtXzODYs191WO4ey2GuhNrd8nWkhpliaKxnWUzdRop?=
 =?us-ascii?Q?PVswTDIPu6UK1ygHHzrtdepGYvyu5EryKxzvHs5lDggwQ36is1DpB8P6sKmh?=
 =?us-ascii?Q?l6MZd7rAw7TSrczxVVERrOAsNPci7gdGoUB5qoe+7wAKWcoAfxdz0NPYfynq?=
 =?us-ascii?Q?jTv+ruVs1YXZGANjLiR2xbGekLI508UGPKgoj4Qf9Vd0cXrcYuPUSKbDXCZN?=
 =?us-ascii?Q?dUta9imnhZcG6nDWPKCWtaqB97UAwiphwuotJYsiWPq1ukh6G47C/eMhDS16?=
 =?us-ascii?Q?GUfSZ5YFrfjmM9xt2ybePBICnnPeuY5mHZnJPdD9ZrY7kEiqiPj3sKWdB9mn?=
 =?us-ascii?Q?Ym3accBssQ6h/SYm57jBbNcEjBv8uHTuw/8mAd1IiHPMBj7ykRA5FasHyUw1?=
 =?us-ascii?Q?TDUFqlUNZR0niFU3wPovJFJhe6UREZLM0sS7DC2a15KH1ILsF/QRHe5jiJUF?=
 =?us-ascii?Q?0EHYjHcPfzIjJ5cpxuRTgMad3TBLYs2eVyO2fnKN6Ht8yKSaSHuJE4qm27d3?=
 =?us-ascii?Q?e8QdJtPX7zjjb1qqvc/yl7ww3yOSkdSi8YJXesLKOCKpKKHJJjNAyLZTq18a?=
 =?us-ascii?Q?/XpytqactbQM6/z0wD3H7IDyo4HH+qltdPn1C7nzX8jSCMK1eZpkvvBpetTb?=
 =?us-ascii?Q?GQseb94RcbDFh2k3ItsaovGYy58nZ8nW+DvhF8Xu1ArBbOnlz26wg9LqEvyB?=
 =?us-ascii?Q?x53m+89nrkrJIndfj8gMIcsFjUemp3KRN5Nw8L4zrkIZL+eQj36Op9rrkqam?=
 =?us-ascii?Q?mAVsR0gihbsnMDGX9z4EQki042B1G9zcndnZ7U359U8Rlr+j2kih1fy2bFeK?=
 =?us-ascii?Q?fQoV6S6S7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb461b8-a14d-4ae9-f499-08de851f180c
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:32.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiBjHKHqAafLbR95SpyUMqdEuqQ6A+NNVonoae7z/RBid5Y/emVnIVKtr+qIQQZeKH9Lh0OVyLOHqoUDmNSTXg==
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

Change accel SMMUv3 ATS property from bool to OnOffAuto. The 'auto'
value is not implemented, as this commit is meant to set the property
to the correct type and avoid breaking JSON/QMP when the auto mode is
introduced. A future patch will implement resolution of the 'auto'
value to match the host SMMUv3 ATS support.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c    |  4 +++-
 hw/arm/smmuv3.c          | 17 ++++++++++++++---
 hw/arm/virt-acpi-build.c |  2 +-
 include/hw/arm/smmuv3.h  |  4 +++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2bb142c47f..f21a6a9997 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -827,7 +827,9 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+    if (s->ats == ON_OFF_AUTO_ON) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
+    }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
     if (s->oas == SMMU_OAS_48BIT) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 068108e49b..a683402a0c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -317,6 +317,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     smmuv3_accel_idr_override(s);
 }
 
+bool smmuv3_ats_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->idr[0], IDR0, ATS);
+}
+
 static void smmuv3_reset(SMMUv3State *s)
 {
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
@@ -1966,12 +1971,17 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        error_setg(errp, "ats auto mode is not supported");
+        return false;
+    }
+
     if (!s->accel) {
         if (!s->ril) {
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
-        if (s->ats) {
+        if (s->ats == ON_OFF_AUTO_ON) {
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
@@ -2128,7 +2138,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
-    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
@@ -2160,7 +2170,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Disable range invalidation support (for accel=on)");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this");
+        "platform has ATS support before enabling this. ats=auto is not "
+        "supported.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 719d2f994e..591cfc993c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
+    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 26b2fc42fd..ce51a5b9b4 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -70,7 +70,7 @@ struct SMMUv3State {
     uint64_t msi_gpa;
     Error *migration_blocker;
     bool ril;
-    bool ats;
+    OnOffAuto ats;
     uint8_t oas;
     uint8_t ssidsize;
 };
@@ -91,6 +91,8 @@ struct SMMUv3Class {
     ResettablePhases parent_phases;
 };
 
+bool smmuv3_ats_enabled(struct SMMUv3State *s);
+
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
-- 
2.43.0


