Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D412B10F9314
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzD-0007wq-MK; Tue, 31 Mar 2026 21:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyx-0007jc-6J; Tue, 31 Mar 2026 21:02:55 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyu-0007bB-U6; Tue, 31 Mar 2026 21:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKzUshPx5DzUfYoGe7jxzv32sq5CtWta+newVt8H++ipk7ajHo/4cc+3LJuuPnU4rf5DVwoab7D++83+wWtg7lu925EszieJeIEv5qwmimHgGcwT35qPRt+sFTOf5TgW/6FBBd8NRLiREMnt7nUiZmXA9Vs43qFihH0uwdqhH9K33SAAxHfzmqKGqVqhCavB35Ap3hb0JrN5e/8X+CBhnWPLIeJURCBIpUdWMBU4Ss+TZp/bko63lzw4monkmSCrWXiiELFMQX8HNXZVy6SU8dHKg5WXJ80Pv024URpKIjGnxKFIVGdXy6ZcIbQ557qtVZpnd8+G79+TytnOmDhYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asJ++HujhCYmlgrxevq5JAeO4nXpw9UTaCt/Te75i2Y=;
 b=CzhssPaY/B41GIunKBlFVeYYUxcQd4N9R8uDZGy/aKyExy3woLeKb9aJ6rXWLiAW/SxW/F7+77BVDOBjAvqYyUo7cmfs3AQ2x6NWgCrGFebbqmFacRfPuiZbCZrHN6vGu+lRaGsEIJK2Z9SAhnTNk00OSrLOWNOBks79t+vjm3Sb4VBlBF+9r4TkOR3olq6zOaoQpasUtSl92k6UeG61rWbI7RG1Duz/23Nl1CvCyCQufeRmaEpulBBlB0gGDZhXi2Bgkoe98GarPxf0n9Ni4LitfhhARS3WUix5wPBQHvUaczKaCDVmQU5cTr47dnjU3B+/lLFpr3aKY0Upv9HrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asJ++HujhCYmlgrxevq5JAeO4nXpw9UTaCt/Te75i2Y=;
 b=SFk22OUyefzj9w+o0LeAedsPbEaHYpfyQrm9YAFrRcy09EUuEyT92syG43l2VQbyAXyNgAfjBm7zCYkDviOxPyyiZ6NQruimjyKlLfNIPNXWsjBKVg4KSgEMUFwCBG/KKMhelrtzAyAwSiP4mkTgxGpMCL3G+pUcvIrvZNgaAA9zsQ2+dYdsRbK7DCKNKiADWE02JOaSuwlucDWqaLPo3bw6jVQEQRj8mJW3QajFND0F4LSk84uCWAG6sqxmuHmUgPmKTsNTW2q1Qk6NqXSaocc8I5PRnTX4/ROjEFORRA5MF2nY5gFwQP5IdwD1cWOsX/OwB7iqWKHsZsEcmVmuaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:38 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:38 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 02/11] hw/arm/smmuv3-accel: Implement "auto" value for "ats"
Date: Tue, 31 Mar 2026 18:02:22 -0700
Message-ID: <20260401010231.4166776-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a03:505::17) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 585d2132-2368-445e-15f4-08de8f8a5e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: bseVslCo216q+7DoO3MaSPz6XqketOILbXJnEy9D6UGjMMaYCoeg6Zg6OItwYR3kDI4ZpU9fplXthMVCmzIznJN5xKyDiVez2sYto5gVjzX2ZtTFK2d77yeHTGkJZwH5sT3NRbz4lhrRBbyhgyavuP9yjhtUVt13hY+1hGVWNgM3yx/R5zfxm3CjlRrkR4BDfncT6woUGewLPIhbcsYDlUT2+Hb2ITeypTuOLZktlidtN5TFTWrjqHzVGXT8jcaVTkNSCDzhWOQLonR4q35FcxZ0NuS3vCYkNfCj6326QZs0aTIvKm+jP8P4kenSxYhm2bBXw9RxypC9gwykjEo5hc4siuLSmapxUiIAvbh0Jl0F5kkkdJZk1AOJTq0U51d8Fm+7YMQU2uANQzqKeRfW1TNjYCjlv9NmK+fU3FLQULj4X7nU++zCEZU1Qk5usc8I8EH0/2IQZK4LdYdOv2mtzHuFzdIendHCQ+1SlaVJWIqb3CjrnveWzCIqkU+E3bcWOd6VJJlkVehmc7+7goszmddvDlfFsledNotK4nIAPx2Sxp/swmbeMWkds5C93dAX7t5mNNA+9PJFJMZuydCbnxQ0Ev2MVrgYVzv9VR1M65AI//UbwVXhyBkKP2DjVtV8Ygb/umS2J7ffB1J+fEpfHZL6k4PLa0QFohEt2bsCsJ0NrQvrZd0MriMp89JNJE3Z1dAN0AOXd3M943h8WmrgSVsEQqZx9CUgWM7VNSJP6AM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eSOwKBFREpE7JsFstufPt8od1JgWtfC+Lz5zopzXtE5YVPuB+VYvU8C7EQyL?=
 =?us-ascii?Q?NL8/7vIctpvp7Ljd5RwtMXEjrkjN4C0J+kZ0qg4tLKGbeT9fe7c0pzi3PJAX?=
 =?us-ascii?Q?yy8Y8sW5Ua6PHoYOVUbU6RrElbXZuICW4P1idpptAAKUR94lm4dwyEqdvONm?=
 =?us-ascii?Q?nao4j6yu7td5GzunW8gX89kv24MVl94YjnDm2WlsRk3/SPGEQZJy7yIsCh6T?=
 =?us-ascii?Q?bVLjgTRimWOE8hAgw6iNiMKIwpxb1bGxxYrypB3QgkKpf5R8reM3t2Q6Mv8j?=
 =?us-ascii?Q?zLzbzI4mmMHidz9Nb+RckB4b+OsXk84gNeMamm4CqQ2YnGqOcG4ivRTfww6B?=
 =?us-ascii?Q?M3LcS0pbkRSeObLqNPzm/E6EzFTYeTe/01beZDRQ3IVkvcGPeiQOuezauB8l?=
 =?us-ascii?Q?mOfKi3WL/cTLdv1N7SqW2xsh7cU9ivzbo0IkcuVpTvZA2vpRNw4N80tWwWwH?=
 =?us-ascii?Q?A10lpGOffQmJtxnQRva5qaKMCZhawFmtKKOxpbUvYZ3dIMwJImS8GTEBtaiX?=
 =?us-ascii?Q?+pIjyr3zf75zwVRPYFNOpa+WqP2ArKrEzLHv+YXdp2R36HCVn2sEQnFtiENz?=
 =?us-ascii?Q?q2jtZ4fCzJ7azsguWX9M2q4hNjxfPAP6PVcuhRLhe1vRHoQMFO6/6Z8NEF7c?=
 =?us-ascii?Q?Znkbe1zkY4cDmbmvwFkyEmcXUKnly9u3lXmUL4tLAlfdIHaYSr/khJahOonA?=
 =?us-ascii?Q?zTFFUeKctjX6sicB0gn60TYbXZF/U7eqEN7DtSBh08CMQg0gd+LPHdxPd9jA?=
 =?us-ascii?Q?Dnm42jVMj8bHFP3xLkJ9Lb4wfhy5oxHie8yS+6AnD1BZNpTKsq2n7EPjmcnf?=
 =?us-ascii?Q?6O5ePbGL5gsGh3HdIPBn/HalcqN3nH8I8uJTYYHvm9UuOM5np4CAB6Ja/nxB?=
 =?us-ascii?Q?t7fGxajV+Kwe4Ksy09JhUv9i+exhJ4L0Sbbo2Y9naD6WjiBPI0Cw056Bwh/S?=
 =?us-ascii?Q?bGfZhYgYhbaxUWzHA9e8NGmrTOGHw+ApnVq/Y2aSDsWc8dC0/RtpH/cg7wxW?=
 =?us-ascii?Q?2wjrUVHgStdBZWv9vl5tvg9Snz3LFzf8miIuHVkMTpVJWyV12G4LVfUyEJ9l?=
 =?us-ascii?Q?O3RYciijfnxtXAromvmCqRmG50a/yoe1UZdHD/l/GxTSRCIIaFquZ/YJ5O+h?=
 =?us-ascii?Q?2f3lsa+D5QIJ+TZk7175WwLYt8sfhiU5Wu5GvLmzdvMJwpv8BCgzWeX25fQm?=
 =?us-ascii?Q?HhtY+Y2pAFVZKUQp6w+69+hFKAbJ6B+nqSPxMv6qdisVzbjWD9dGPBCD4aCC?=
 =?us-ascii?Q?zNWfWW0vKJ2CV4UvDVaQDWZvOSavSKdncGXxidTFgUVt6BKp3LNpy0fy/Qhp?=
 =?us-ascii?Q?Zj4ezVfaKNg9Kb9yR6dcpmAsIJVkpWvThc0qq8qua/5eUJrF+KqK4ZVLvu0L?=
 =?us-ascii?Q?gS5sr88jVED2oAY0ymFsgMCwGY0SQKrBcIst1nJs2GkOOHF37qNCTRbM87vp?=
 =?us-ascii?Q?fPP55A85e3ii0JaLFkVraieCn7XlHw4UTrQF0M4MHiBDwZ+A5mlpBPefzaQn?=
 =?us-ascii?Q?UVyyvzAVNM1mSwC9GLSNQR8+25W5MbflGlkcoNEY7BSqOyRsDZaWLNs8+bBs?=
 =?us-ascii?Q?M8F7RQe01eAN9bg9XUlZFmX2hZhbFImILLTbwQD13DnqMki4CESkq7ZqPEBz?=
 =?us-ascii?Q?RwolmW+xfH96xNG564fmKFFiqwSfZZTn2/CaCm1lDGmahWMX5l5PkQlQvnaG?=
 =?us-ascii?Q?XRcPTPPIZxyDsgFPnYIKD6L3olTVEs1hxGfrSahDfktGYv9FlWSvYRy7oqpJ?=
 =?us-ascii?Q?YKMGUSv74g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585d2132-2368-445e-15f4-08de8f8a5e58
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:38.5480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBMnNDZoep4nKgjVeY0QStnKkS3wuSWXZzcqCTRzKVohPy2/qVkyiMqK7NDtaOePfyHPmJxmnBUyxeeMtqATSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Allow accelerated SMMUv3 Address Translation Services support property
to be derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 10 ++++++++++
 hw/arm/smmuv3.c       |  7 +------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a0146c8d31..a835c8f220 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -44,6 +44,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
         return;
     }
 
+    /* Update ATS if auto from info */
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
+                               FIELD_EX32(info->idr[0], IDR0, ATS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -938,4 +944,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->s_accel->auto_mode = true;
+    }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 09ea08eb18..f3603554e3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1973,10 +1973,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ats auto mode is not supported");
-        return false;
-    }
     if (s->ril == ON_OFF_AUTO_AUTO) {
         error_setg(errp, "ril auto mode is not supported");
         return false;
@@ -2196,8 +2192,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "is not supported.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this. ats=auto is not "
-        "supported.");
+        "platform has ATS support before enabling this.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-- 
2.43.0


