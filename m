Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01D4FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgCF-0005NI-9f; Mon, 09 Mar 2026 15:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBc-00052K-TE; Mon, 09 Mar 2026 15:22:43 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBb-0003e9-B5; Mon, 09 Mar 2026 15:22:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+sG4ZyjAUPKC07j518NtK6di0imrk9G9UPhIQozpyGi/N5o3bXeb7UysDp+yp9gd7U2FXnjOHSW6tk8GTgj7EEmYLFmV/FHKi8SheEFVEUp//qkbxXNYZX9GlCsWI+j35EjRl1+ewj4aUPD+G2mAvCITsKDtxtZvKzyN61ufBotpyvMyYLj5y59xUYvKIy0FF34zDXf+rBWGltm7GuVu3IkXo56osNW3evmARGXNpxTReyEgCeGslXMk5L/Du2nKFNaemT6oKja1apjkMGpRY5SuQt3RdSDtNiwxQ1GkUZELUWq+FaBqndDKJoDjv9a1+KuMvMXj20t/Vz1KW4+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLeETNO9uJxO2mC7vdxtfPae6IQuKiVnU3ju2LJLZS8=;
 b=rcyzl5+C2H55av+ORAdoE2xVssfGGCysKp1a07sj23gm6k7xDYLVMJpYJZ+Zj3eenh4bwupcaVcaiPFcW37sqd7YKMEBUOmjy4na3PwPaMFIWU/vLwpW98LAFYhN+guMaT2tfycCTtOtxE7HK//GRaB2qMD9lrY/+Vd5ZcWFAkLUtOPg2CBfuFj5YSfuBJW0wtTyJoSQV6TF4Dpk1cbuYsYxYdum/CANYyJYYrDqksk4lWmedcI75e59ll5MQKU6vwrvc5aUtD0rdTPkzXbmvza/FbdEtnhz1kR6a/YsCoSckAnSB0QFKzuSvTrw0Yk6MzIL0Zn7j7Azknm78PR/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLeETNO9uJxO2mC7vdxtfPae6IQuKiVnU3ju2LJLZS8=;
 b=Em/KfFQf23fW//96FT9EWabu2OWn5bFbEOkP/CXgq8KKekWJof7+g/lY/bISwKfJh4HT2usdTu2qC8HVGkCfFSaHVZBVNq2Nb4gL6IcX3yXE1QG1yQ9F12qnUuBo5J90kPqtvNdFQAYgkWRo9kPKL2UE5zoYSfI/1eNgUnIWcts3Wqn6YvdwkDjhxLLN0ph0iRatMfwbZZIvjuOVkS54RGi35y2ii/VgIOtqmvLjBKyx6famhltp+yLop3D5gPRb+NiK+wDXF7gRXCNkaIT609XMWjRuPC9n9D3QZeNtxq4Um/3/mis6DHtnarnTOH4Ifk0tFNtndHDyWnl+fJCg1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:26 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:25 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [RFC PATCH 4/8] hw/arm/smmuv3-accel: Introduce _AUTO support for RIL
Date: Mon,  9 Mar 2026 12:21:15 -0700
Message-ID: <20260309192119.870186-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 60632f74-5ad9-40be-dd7b-08de7e113255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: X9n2QNfO64cRnNhMPTHZ1cMuo2JcyaclOw1T8f7MSjQkuv7mkKIoqKKr4d5qfOjZEIZICQhJmx140eu6ZZAWdVclt8XyHie7Rnp2SJVgTd+6ED0StaFN8FTAh6pHY6E2lsdHv6pszXswUfoKmIHvOsrt73NbjlC7WZwnkHQPcoEtgLxpzqSLPlbrSVJjR+gfJxZSAnflLUhugqO1J+a+1Ev4iQe1pDFP/w8pFf3sko4+EWljnSetD++EMQfOrQBrlWujgDE7F4jT4FOqmrAOylVEhn+XmYtoV7TVRv1uQzXr8rpahlATvzE7VLzLQ6BHmebwRlvfNWDYCOznkoLCQcDjO53+4+GIUPiatKIr7JHKFyV1IitCcuJQlsePKvbIBeGCoZ7x6E6ncj/TkbQ7txJjH4lO/Zq/Lpj84VyuGtu9AJzrmJMWKgklwqJnTdPSR3Etprx7ctfoFlE6p9VUIUf3jddMxNZGT8tIe7qehG7slFWuYd13cr1RQB19S4Ocw6PtU/ESGJ1ADRd2aeUudJLrFQs0l9Oc8JSpcaCkLqwH5lv+RIGUQy69sRn4QUwouppcgbHYdPmxBh42TEPJYvcw7TdMRJMilWUdk2Z4bhAiu5o0pRMrM/Si1RwHNlzal9EhgyqR7mD3uK60miPcavEN51cBLSj4LPfiK1TCeUW1kwmxxx4C8eyoltIWb3qic5PARpqyuGCZyF0Yyg13LrqqdgjhXUIm9i/KOVOlAEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfHiTz9OBnP9VikcUC4kJ7eQ+j7m+60BljPP7nmQfT+aUUgXTnRRRqF13l6J?=
 =?us-ascii?Q?7WuO6sSJZG6hBmz/SvLcaH3YPRZ+faEHzOI//WE7tjLwO41UN6/rIlEoS8hd?=
 =?us-ascii?Q?Y9BNsK8LcFFfoICVMdVifuYwtklPw/Gl5HgzDbdceHF9CN4c+rZLrwnfUJOi?=
 =?us-ascii?Q?upSajKzUbDcvQ55wAxOppUNERak5ene7L6JCJbwk9mAD+h51n0U2+DWOj+jx?=
 =?us-ascii?Q?FH61Q8VkBbA13Tuz6K+Ka30pn+0wlqS9dVdJTa0ANpy34LAVVm7w3K8qBbLC?=
 =?us-ascii?Q?doWSga5nKXZG3YDyA6jcHI7hPc6H3TMdaK6W+KJobkKzRk67JXrKlt6MuCKa?=
 =?us-ascii?Q?v35Rs5q99OFbKRDdXDUm/aRRb4ZM9yU6FOH5l4HClGZeikSYmW5cdfnvtDq0?=
 =?us-ascii?Q?RXmoDs3zOe5W613cpM/Zu4TU+KBgo1GsZ7SYS2qYck+OQZcZ9T+4iNY69SHm?=
 =?us-ascii?Q?EBHT1yjc60YtIPQCHZENrLm75uFxn08EABS6fIk6hMhaai8fWVXy9EX+kj0D?=
 =?us-ascii?Q?LqtXI++NUesID3GZGW9p5DQ0RX3PngvqgWF+jF4vYUhZ61GycKHbFr/ms1IT?=
 =?us-ascii?Q?vnrKsU5W6Ic84x4w9Sfq6VXKW69awvy3ILihQ7G6qP3L+8Pf1O2uXH5Bbd8W?=
 =?us-ascii?Q?OLCMlAtpWRHFXalabZ6MPbcqDsV+tMC+ZS8tt8i1p5uxl9M/iT2KEg3zD8eV?=
 =?us-ascii?Q?2Q3PbVoOmVyEqrSosq1FU1eg35L4Ao1p5k6tZ8lsxmiXqnORyyjn89c8sqx8?=
 =?us-ascii?Q?uhYpolPyt+EIysvxlx3o4Pbstc7/Tvd63jW/l2SIeE8o9kLoVKLJOGBakJfG?=
 =?us-ascii?Q?KJpv6bmE0LFcJre4Q8kcHQjThGG2bhSDtMFRAEVCyLmA7xEX9Gcqh/Nwqvpu?=
 =?us-ascii?Q?RnZaecwRoUDxKr3pbZJ+uBTILYCd8HGCCoNA7tb+IwBig15eQ+nh9mEzEC07?=
 =?us-ascii?Q?atpIXtMuq5kKCmsFH9oCc7EMB7X4HSMN2YlmuknMWFGFqxIJXgTUqwUdziIW?=
 =?us-ascii?Q?AS2+L0rJPFzosu0maR1s+cBILi7ZwItRobtDjMLsiiDMagRzGUEqLkBKTLIM?=
 =?us-ascii?Q?RtxFg9z4EyWFe2KNJmIk6HRcsvqu4CodaPIh0TE9FW6JoKDldFMMwIxQb/me?=
 =?us-ascii?Q?iwMRMTovYNKmTOtqDFu8A82fm1WZUjo0v4LSMb1PJW0EhdFgMCRhl+qHzPx0?=
 =?us-ascii?Q?pdsz5K/di2oDDVlnkshM05S2b1spAsZpyPYr0oPKzpms8aKy/seaHT2zjwLq?=
 =?us-ascii?Q?o2hoUf9r6o7NUJGRf5D1Ls31352Ww/ry6Nd5EcsqlMOz0hEp1mUD4x5p7PIX?=
 =?us-ascii?Q?TSjIIOUex3PO06Qur2KtjwGXme+9a9Ve6+/h/s68Ucnv6jFjrtBDywZlbe3g?=
 =?us-ascii?Q?jfZSM4ZFFEzEYwtwCGQLQAbRsCdQx+vwfgcGFx2KTWiu418c198udzl6ehD2?=
 =?us-ascii?Q?YkhUwW3x/TxYry9yBbccZyh1yfoVdUZq4x2wXqHE1TvxXSR1LVXVzv1v/rzJ?=
 =?us-ascii?Q?pTgwIgHqoGMvrIAm/qh75CVGeFTS/SDmRVqwSvOcg3uFDDKgFqMW1ZxF1GaZ?=
 =?us-ascii?Q?9GiApKuXSJf88igtW8dx074JUz4ZBvyBzdEPncWahwp6A837SUMBr9a0+1ZZ?=
 =?us-ascii?Q?HXiRBY+OKjoSt3Y61+K0Z4Z6wcObGth1mjXBbSsQHBvCXBKA8n6NTtHs+VU7?=
 =?us-ascii?Q?X18zSxQKvnMtv8MDpxAwCLsF0TbNHGlsi4AmUDp2KCFpTQlIu4luM97Nw9gf?=
 =?us-ascii?Q?zKZJ4pmPpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60632f74-5ad9-40be-dd7b-08de7e113255
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:25.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXSm+cDxoIwxwp4mDkIV4fmbJ0JvAu9tlikYBdx6LQ3N645YAIgvnn9j+bBBrsz0bVHI/t0WgXunTUrx1Ukf3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Set the default value of RIL to auto. The default for RIL support used
to be set to on, but we change it to match what the host IOMMU
properties report so that users do not have to introspect host IDR3 for
Range Invalidation support. The RIL support needs to be compatible with
host SMMUv3 if accelerated mode is enabled.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 20 +++++++++++++++++---
 hw/arm/smmuv3.c         |  4 ++--
 include/hw/arm/smmuv3.h |  2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 8fec335557..02e3f7a9f3 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -58,6 +58,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    /* Update RIL if auto from info */
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -854,8 +860,15 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
         return;
     }
 
-    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+    /*
+     * Only override RIL if user explicitly set ON or OFF.
+     * AUTO will be resolved later when host info is available.
+     */
+    if (s->ril == ON_OFF_AUTO_ON) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
+    } else if (s->ril == ON_OFF_AUTO_OFF) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
+    }
 
     /* Only override ATS if user explicitly set ON or OFF */
     if (s->ats == ON_OFF_AUTO_ON) {
@@ -941,7 +954,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 197ba7c77b..7791e5294d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1973,7 +1973,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 #endif
 
     if (!s->accel) {
-        if (!s->ril) {
+        if (s->ril == ON_OFF_AUTO_OFF) {
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
@@ -2133,7 +2133,7 @@ static const Property smmuv3_properties[] = {
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 2ca49ded36..9124bfe751 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,7 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
     Error *migration_blocker;
-    bool ril;
+    OnOffAuto ril;
     OnOffAuto ats;
     uint8_t oas;
     uint8_t ssidsize;
-- 
2.43.0


