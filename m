Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F338710F9314
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzE-0007xe-Sj; Tue, 31 Mar 2026 21:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz5-0007lu-L1; Tue, 31 Mar 2026 21:03:04 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz4-0007bB-6d; Tue, 31 Mar 2026 21:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfnJsHtmRzXkBP8gPfCzNmwx3gqDAt76etRBP8IHpaLlkgMv8lyhw16ipw3KM4EXcuBHwTet8+6cF9fnLAZoGhfI/vJ9BYaBXtbGAg41kfW+zcbPXRSiGVtc6t/sTHTVkBGGF3lrBgpGNMmoYtRdmrg1hy7k4dqvAv9ZahnazNqnSAnfezdyNXkbrs2/oMdAJLAasVu9gaJscaewKy/tH7zrp03vcKPcTGjeyyzebA14OlybwZkQNCgHPPfJpD1yoHVkVuUPXvCVFdtb1fIPtMwWT//wxPjEr8o+CIoR7fG9rqs/ifq0nvxXX6uMFam5Y7PyXGqgg7axMW8z8XW9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CKyUIMXDzJF5aucpTAwxnQjNq4xMCLeMToE7QIWk0g=;
 b=l3S4gfZQTRdTzZ9AtD1H7FVxOdGH2Gvsv/gWL+Ys8m3SU63vdb14oZOM9ck+x1j4UBhWHjnK3w8oQaeG045QpN4UWfni85Ub8Q3OLLyBmmn+aNlSJ5HQvHA3KfFyWfjufoAIZU7TB/weAXttmjuySf/CaRLdCRMMNMobqnpKeffAyct/iANjLyqeTRwho0i+RwdqL4Ufm/mGKCkJsg7MDLDoQIEPhLqSauNAPngP9hGDJG9qozkTgdSjT9RMj30T5DFqAmdm/3YLtxnY9BRmmPlgFisMQlhIfpkTLaqdVGSqELy+EVJ1zOqXC3RsIX18KaVESeGhmSk5yylGDz0nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CKyUIMXDzJF5aucpTAwxnQjNq4xMCLeMToE7QIWk0g=;
 b=iFo0SG/2rwv4hSM16ukxPH4Kos84+oW8s93r274PePS3bNM06nBZH/Vr+P+GhdBenPVik08Ihl1oRjc/k6h16MspKPm6DGxFT/U7JbzkrHef2++Ma+LAxY2kWFZzUTQVrtnAwJf5DX14hwKAILUwNgNIsSh7MyTX97H5l/NWAJK6PKFhApQR2+hN4OJ7KsN6iB+jRd+jqtyZ9zxxOK3JTQ3tOdodOlx2jZCzyMIKl24jmSgTRfvMBoy0oL6F6prGay4uBtsuJ1Th+T0lm2F49b/x/aMg+1LqKor616k1iq2BMtkYCYPL0Q5VAr4maHh/7oSTNgWkFmyA5rLa3YCWIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:47 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:47 +0000
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
Subject: [PATCH 07/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Date: Tue, 31 Mar 2026 18:02:27 -0700
Message-ID: <20260401010231.4166776-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5faa3e-37c9-454c-1df6-08de8f8a63a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: CuqAhJkl0xHhBIfTQz34ZqCTxjMj+nQ4qhmV/W/O8JTbu9pRC3x4npgsxkMC/ya8uewyhZgMwoBFJ1OF3MKKq7IGHpjwOTE9jEpOJS4VYXaTEaAQzOmk6dh8yd0wAS2ifEMSixZxgyeNbSmvFU/8UO2C37QWPPV208XSAgmdZa1e7vV+3cjWBIFQHeVyqXgcVnXpmEepnSg450OoUed4tdxF55lb2V1l5vK6nPeIb4O+TbQfINT+TKI8GP/S4vvZoKjZ0mWr5Kzdpw2uj6/6p+DZY7bfgLSIjqj2rVNvOXFHLyH+Ue7d3KgornC9UKMRqV9oD9Q4XK3yARCB981xQN5ZkiljIQL96d2QTj15WN1s8MwPTkEKy7SKReYkmqpDlmbLhdQ6h+18rS+jPe/8Vr8+d9IY+qpeODweOsD/aYN8ZiW3G943WVCiXlxJJXdJwe5mUQbcXoZJDGUEJ7jfLubHPH7BArIpGoCKWLFUlk72pknbf/FNz7mLmIaidwUTTUBuPI79VFfKyq9mTuozaqJcx438zGWcsT8UrlzIPSLvscut25GerS+CfrS3TLUUR8sOmSE3PfUlauq3DAAzNxYId346faKNCrBtVbdgpp3yHZtPouLhW1g65UzHCnjvwugU8onS/HEj4gJVnQmCbnDUVJa3sVRGjIxrNHbRIb8NPrIYLGPUR+iHMmMUI+6p5X/0EnPgBDJDShDT0BBM1bEhR2hcvC58pj97e6AwbWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOiRjwELEgGVB9j3wnjXzpMSYNPXPCqP+13hTI6OG2IxniA+eojWXuIS+Nyh?=
 =?us-ascii?Q?JF/n+RxJQCXERKv9rtz0Gw74U3/qWHQR0HLGuQ3Wrj944mlgeS9TVc0BPOee?=
 =?us-ascii?Q?xr+Md6zFkw7G2Z5Wd5fzmQ1C6jlgOLgHbkHVMnAGpeVzz2h9bbu1RuIri4Jx?=
 =?us-ascii?Q?hJTZGOlLXUQxwxCApu2OHK587KZYcerlQaUJ8aB736aTLmNyanOsm7O/iSnk?=
 =?us-ascii?Q?4/7eaiHSb2gP/IsMxOxKRXiNjRmzVTpQpNoZr1F/zVNKZD85SBbW3DN6/dCs?=
 =?us-ascii?Q?GdNvJuDkY5PwMUwTEws8U5EnjIyfKFUJeeSTEnrjR+lWm9Z2OSW9k9Yzn/3N?=
 =?us-ascii?Q?MWbuldcisWgiUfVqxbHrvNadWyNyW6wdgs6oA3aubzI+ztTTixHoQd1Rh806?=
 =?us-ascii?Q?/yN7MdDAAM58LxF62dOOHF1za7kP9GnmXGAV158ZsPBd38JPLfCXo8Z95vqY?=
 =?us-ascii?Q?mx6HA41JdMMiyGRQCp9aJlDUgaRq9z9pqgfJ6WC6kqEDA30Exbe44iOku1Fn?=
 =?us-ascii?Q?Ij0r8rSVv/5ssrdzAol8h6vpLJOkoioBbCN8ER9Q2KRGb6cep3DUvlxE9Fqr?=
 =?us-ascii?Q?5N/pp0u15FnF9t1WKP98gBCV8lZkUn+Nr0g3j2iHzbvoTWJVjhA8ZqgAY4nM?=
 =?us-ascii?Q?c76s4HqVzNj+xU00DNpZQfGJlmFT6HtGNz+IYHXMNprUEGlDqqC+iKp6mPrh?=
 =?us-ascii?Q?35kX9lYO7QEJ6JIs4j/OHWiYlOGWS3l42SJVM17lxXqLzTcD7OXsKU54mpRP?=
 =?us-ascii?Q?c5/KM8D8j/GAExF1IDTXUvhn9nTzw+XctqFHzkl9Uka64bvzCR5TJDUwyeA8?=
 =?us-ascii?Q?OQ35giXSEAEqz3SkEsIhF2Wxb3k++vjEhKRAAnw8MFsSCjWPX6OYz18PkmOa?=
 =?us-ascii?Q?tn0wSNilcGC7tWzA8IcwAXRfuszDIcXDjqj6DFehoZ8aad6w9+xITOPzLAjP?=
 =?us-ascii?Q?M23NvePhZDfqCy3zz1c7gPyceSkdY+CoiSfGszjGzn+rBB4RqTLeGk3lIJ/C?=
 =?us-ascii?Q?iY84BcwWM99+9Iuk90aZQ5+GWa6BsAyfubtQglcVEdPlNk+55F9vdW2I04l+?=
 =?us-ascii?Q?IOFQowsMCh3w6bKQzi/JZ9PPWaasTl5ywQf1+XWzfa5+vxJB4PjmkYAdtLik?=
 =?us-ascii?Q?C5Ule0gN8Vy60FeKfnBcBYKVXVZfj/TwDq2y5UfG6nuf4h8sixNjIKoYsfCL?=
 =?us-ascii?Q?6EMQH16JCzW4LxUBiMMYYjcu0V8le6ZpodhIv2I7qLhkW91RO8coIOaSbTHQ?=
 =?us-ascii?Q?6pxs2NneuiUozqXbUi68S03STos3idMZs34hd9Ty2+9l1TWPelT9Au3z3GRs?=
 =?us-ascii?Q?Njh2z+vyyIzxAKyvYvXwbxEaa7FKnjrIIbnjVGAo9OuhPZ1YCrF5Uph3rUNO?=
 =?us-ascii?Q?/i6UyBWBJZN8yBPWEb7AU9TlNN59/9mNN6l0q/AEGIHGEEtnt7fSCepH0zYi?=
 =?us-ascii?Q?X4+rGMMaA/iroHwft2kmjDGWubYUZKvPnO2haPDcIqJH6CIXSItqUmPzvK86?=
 =?us-ascii?Q?/XeawgtODJYa5fI+MT9Ok0WVyFASR5K2K8vPjfY5QspIK2ZjNofrw/LyiKZA?=
 =?us-ascii?Q?yNlRzjt8m2h1J8U/JVSePi4lA9cUFclVU1I3DZyFtv2RjU5arEPhsToyc4XB?=
 =?us-ascii?Q?9r/jcmRP2ZsKwvlc767dCaxFCUvLKTSuDDgygL4kcjijNFQ36TX2Cp77vG7b?=
 =?us-ascii?Q?LsMfI8wTLm0TBAugVtbEed9aGGFaXx4nw2H7GbyA+GtlSHA1tV/mqOoGYY8L?=
 =?us-ascii?Q?JrRO3gLTlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5faa3e-37c9-454c-1df6-08de8f8a63a4
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:47.4601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut2D5ythrojWnr6nVLdG1LacJhb3vX1YltKm+njZa+anQ3c6Vo1wi5j2GsWGDcg7ITuFyffWghR8T3MZwu0lBg==
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

Allow accelerated SMMUv3 SSID size property to be derived from host
IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
retrieving SSID size from IDR1. When the auto SSID size is resolved
to a non-zero value, PASID capability is advertised to the vIOMMU
and accelerated use cases such as Shared Virtual Addressing (SVA)
are supported.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 14 ++++++++++++--
 hw/arm/smmuv3.c       | 11 +++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9e7ec6a930..03393fd7ba 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -56,6 +56,13 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
+    /* Update SSIDSIZE if auto from info */
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        /* Store for get_viommu_flags() to determine PASID support */
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -828,7 +835,9 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize > SSID_SIZE_MODE_0) {
+    if (s->ssidsize > SSID_SIZE_MODE_0 ||
+        (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+         FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -952,7 +961,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     smmuv3_accel_as_init(s);
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
-        s->ril == ON_OFF_AUTO_AUTO) {
+        s->ril == ON_OFF_AUTO_AUTO ||
+        s->ssidsize == SSID_SIZE_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 74cc81ae32..67c499d22b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -627,7 +627,10 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
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
@@ -1973,10 +1976,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
-    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
-        error_setg(errp, "ssidsize auto mode is not supported");
-        return false;
-    }
     if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
         error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
                    "OAS; other OasMode values are not supported");
@@ -2197,7 +2196,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "Valid range is 0-20, where 0 disables SubstreamID support. "
         "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support. ssidsize=auto is not supported.");
+        "PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


