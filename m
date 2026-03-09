Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F870FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgC6-0005Dr-LA; Mon, 09 Mar 2026 15:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBS-0004xN-AO; Mon, 09 Mar 2026 15:22:30 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBQ-0003dp-Nt; Mon, 09 Mar 2026 15:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agM3pXOeww4QVmQCt38+4Ur5HYxkeyKh2p902YlOCLdSu3oECLgXmrtTMTPZ5vSB0FqZJbcT/B3JrznE9aOU6fX4mZXjG2afREl6Z+bDM3Gos9hd0vtQo74dxqiP1GxTioKi57ca+IdYz4Hhc3AQ05i2Iraq4S1Pi0V8UkyRKlEF45aqSZmLoU9fjPwxQluiqxE+oVkkosktUmHzGuXkut/eEyLhQLuOjbEbeXkPjqNC10YKA2bSu5nJyDngDpDPPHRMpLyajMNjp4N3br3L+ra2ViX6GrBFRwGrYQbzxiWTjfE/nUVV1ZzgzzdqK0rY/vWVZWJIqSBfgiqZWNRDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWnZ8LN3FvHzRRUEvOXRsiMJYN+FrB6ORl+1neNKByA=;
 b=QwF7cJRpzrX1/jQZCEmfITnZITOTYiUAZHnVViigjJsdL1AWneMt125gKYDPfFTlJeaDNddFWeioOu0c3+YMqmcpchCYjU/LR+mtx4qxBpH82JnGUVDw+yBic1Mbdxn8VgLUddJh4G6CJ/rTN4S4zR2YgEk9NPmwifq9tow/HrQmatBfqGbhWobqWeQhbDYHtl2HxMe+j3sxuf8P9ZdYHepB7u9Hqpb/cbBHtsL7ADz2uvzJ05AVtGUiJ5H4No1m4pUuoira5swqdcSu/71jUso4f9+UsjUwtifZua5s+2aE/iid2gSyWpr8ii7AvscFyaoU0OBLb1YQLYO+w++KTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWnZ8LN3FvHzRRUEvOXRsiMJYN+FrB6ORl+1neNKByA=;
 b=b/yQQHgwcob0zZtdgXH/BPecWunZrWb3NTkeIRz9rm9yFmDJp8zfde7uhNO0MHv8oSEegwegBwTITAW5StdW5qtcgOQHEY0dZ7AsHs3TqR1hHw3ON37WuQtXrPnCmz+OlMv1pCd8QeGvLfeBbgnC+E52FmhMKaQT+LPviEBccH2e4jzbIP2Nbhg94NTSnMN/FLcmsWQRrIAT8ltbKYMuvwTYiQFzrxxrMWOE+KmA0Hv9j9kLCyBFKQvSfM38eB82eU47KJ7k2vBO9PMfbIfHCRO0xWFzvLaGeARRPicbRCqGXukucI+41aAETLGN0tULlR+B5oO51qgkkaqPHjftDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:20 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:19 +0000
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
Subject: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for ATS
Date: Mon,  9 Mar 2026 12:21:13 -0700
Message-ID: <20260309192119.870186-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df68b1e-4670-4ec6-4bd8-08de7e112ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: H1266ut33EdSvNMW9epJRqWdXGQhjp2cS7e3mJMMXcxLKPUQsFfKfSFa5sOoWCNTgkrvAHdDUTNo+tiX9WDTi4eU2Ohg/rV3jT3R6RbGInyR4dJhq5uuFJTy5zup97w4KmR5BjyH06WubkBZKdTwZ1muc9kz5cpilfa8VFKzoAD+y7hni8rlYp84wJMcovAtzktGaTz2ml5ZaTEmcN4+GY5aGtZjp4++mV4aOEiljUu/TDT6ii7utf8kP7/MrCSA9z8sNQyNNDCzGguYRTHjiqpw+K8P2kAiYjN/pogpQoONBzslmTQ/UmC9DJ7TBiyR7GCW9hTFwxkohxXYLW/BVdBl78LOgVu24dBWGD1nuhkV/LifWpYPZWrjNryuuo39IrrMKMDW1dkPEuhoiVkQT9Ci1EI/6njbM9+9Q/JgIG9B4h+D+xEhzoW6eEXVcy7FbrrWdRdJg0Pi4ayDif2gNFLucNhpTdC230k5CKdst0jg4F6F1yc/q0RQ48uEn8SC5zR9sO6gYHvho1f1ZYaPHq6DltdqR0pMC597ASWyb3yLHuxJU0qz5Cgl6m3oOsStkJkxyILV8B4xiA6YaQ2gpPv3vt7WJuztjwspeJ5UC3NeSA/0dUe5tiBkNAajjXrUxWyEZZvjzEZA8vrfZg9vZbL8cBwce+U0OpaBdbli5BMetm8MmZPlX8xPDxBrS9GMz6DZmr0694d0Dd51hw5wb/4rFg8G+msPrMWIO+zPXB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JXO/6zIzBZOUIL+VHwlokllAm8TO6Iy6S83gvT688IsDIbAOe5MKuw72s8d?=
 =?us-ascii?Q?KHP8sHFk7/9F9xBjt63LCYova6LWv5GtBf4yRRivwkTJSPbGMjjVqhpO8v/C?=
 =?us-ascii?Q?ZqopW/wb6Y5o0bjrkAlJUZKt5J+tQQrZze9nEIh76jb/lgTG6m8KlaLLa9t2?=
 =?us-ascii?Q?mVkRXCsxPKwTNdKGEHZCjxM87X+1wQnbxn07dK0Y+ZfeOATbri4xGtwKsO3f?=
 =?us-ascii?Q?oO5EP+GegPgdw/aEoMxwV8dGiJ3WMWXWXGU07yxIbMotO4A1moedXWethKvD?=
 =?us-ascii?Q?GSMxJD/bZZPXvCxLjG3vV+CmKQmiWfZrvccv161CvXRbOAt4ImB6ZLlhsyXe?=
 =?us-ascii?Q?gtaHRVTUMT7uUyMBBtT3Ffq4qyBHEDjaC+vc40gA3cNy7HGu20o+RxvQTsJV?=
 =?us-ascii?Q?O7msBHI5jgu6anvnTv0rFZkQYVp1g0uCrkLVY6hrKB0rFg6hRX9V6QzzFwzH?=
 =?us-ascii?Q?r1KZFu8+BKlboNJo71InyWHoUb0GbOBvaju4aFQppoAc1Ug0Xx7GgO6jxqNf?=
 =?us-ascii?Q?B9JxXCkWSGQnZ4/46Xw0kHJuD3saqnoHGoYOsuQ5wlMLUa3vnmTPmqzz6cWy?=
 =?us-ascii?Q?rpA3Urdy/Pr+hzvL0y9RJAbTqB/FSKvKI6jKyNALmmDsnhw0BVElQ7QUte9e?=
 =?us-ascii?Q?36/hEXdEEOWxkPutm0AIJeHM/4XwWpVad22OMe1iENVTz6NgQQFGR/XjoStC?=
 =?us-ascii?Q?epgyDIyZ+MtDGOFIaztxu06u56kC2qWoa3IO7gFSjKaKSmqDniPoJH1YuIzi?=
 =?us-ascii?Q?a8/nPlQH+LOxK3KKNLtKCAWQ5+kDSJ1ZZO0n/G7jIJjJLrFnL1WprzO2U7xi?=
 =?us-ascii?Q?bVKvV2mGVAf6PqU14fONxQXsY0RfxwwpqBWGOJFEdsNZWsX9Zor6e+lKdYBf?=
 =?us-ascii?Q?5bIdEaYIGCE8Fq3llhcfLGzXpKAuEjQ76TwLcQxAdkDVstonTgzfDaCglKE0?=
 =?us-ascii?Q?wbnLToXwRC3WCc7rA5ebTCBqdibDBt6mrP6JvQx0M4TtsxeRRgG9GPR7jfnZ?=
 =?us-ascii?Q?vYTEjBjpiunl9aI2sHCW+tjAJAdZfuJNNMZaW3PJlCeq4E7Hug9Znb69Y0ux?=
 =?us-ascii?Q?jrjzL1OQo6lJ2ZE1hu1RT7EkSWvVfTlmkle5GLAC556y7rTphG5jM1obO+B8?=
 =?us-ascii?Q?mCKhzE/gqbtGi7If4HY1YUGLL+r8A+pYusBmc/QJsIrNYzh3koETirut0zs2?=
 =?us-ascii?Q?fj2hNdOAFAOxpdE3GrIYBk86OgvwTZizrjaa2lChji70fyFDty88QIrPhjm/?=
 =?us-ascii?Q?jApczOu20rCzWl6zDWOgFn6krhuYsV6QqK2c97SvmadY0NaDwCe8nHb12C27?=
 =?us-ascii?Q?5wWBOFwB7mTaeUWeJAbBDAlYFh396yMXtZjKh+YNKQ4qlhAY+E70rylQ6G+O?=
 =?us-ascii?Q?SaevXoErqmEj6s9+kvuPAY56eI0cAXbEHS7sfoDbzi1jvwpcVUfWu+zw4lPS?=
 =?us-ascii?Q?SPmrX3hmd5dv78iZDyuDDp/cvaVABYSxYgWaommu0pKpiadB9Ca+E7z3qGVC?=
 =?us-ascii?Q?pct02I7avNXajunCH4JWE2/PZJSZ1QXJ3BKPH9XJ6wEu7Ty4FZZCiOQfTAmO?=
 =?us-ascii?Q?BI+OlwexG56P9jDPl5d+N9Qx631352aptEFIAmlr+NRNqHZlftCkVyzNPcGV?=
 =?us-ascii?Q?6+20OVgyL5hqLlBXgjuHLXFQn9t//v5//iifcyZZrS+kgaDMlWkfTkcMU7+A?=
 =?us-ascii?Q?Zw12IrdesZIJpn0mRSZ/oCbejcogoZIDfKSNolyARVtMjqGdbt+zsSSppE4n?=
 =?us-ascii?Q?RvPydKWM4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df68b1e-4670-4ec6-4bd8-08de7e112ebe
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:19.8337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPR8OY9PuVAdyTmJ7O1OKt28diDBTjK51mwhFlrSUm5ltLB7dbjLiSv5WxJ3ArsoQT+XP8BA2m3vHYZ+PDOJqA==
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

Allow accelerated SMMUv3 Address Translation Services support property
to be derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.

Set the default value of ATS to auto. The default for ATS support used
to be set to off, but we change it to match what the host IOMMU
properties report.

Add a "ats-enabled" read-only property for smmuv3 to address an
expected bool for the "ats" property in iort_smmuv3_devices().

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++--
 hw/arm/smmuv3.c          | 12 ++++++++++--
 hw/arm/virt-acpi-build.c |  2 +-
 include/hw/arm/smmuv3.h  |  2 +-
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 617629bacd..8fec335557 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -52,6 +52,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
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
 
@@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                    smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
         return false;
     }
+    /* Check ATS value opted is compatible with Host SMMUv3 */
+    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
+                FIELD_EX32(s->idr[0], IDR0, ATS)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
+                   " Services");
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
@@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
 
-    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+    /* Only override ATS if user explicitly set ON or OFF */
+    if (s->ats == ON_OFF_AUTO_ON) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
+    } else if (s->ats == ON_OFF_AUTO_OFF) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
+    }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
     if (s->oas == SMMU_OAS_48BIT) {
@@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->s_accel->auto_mode = true;
+    }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 068108e49b..197ba7c77b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     smmuv3_accel_idr_override(s);
 }
 
+static bool get_ats_enabled(Object *obj, Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(obj);
+    return FIELD_EX32(s->idr[0], IDR0, ATS);
+}
+
 static void smmuv3_reset(SMMUv3State *s)
 {
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
@@ -1971,7 +1977,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
-        if (s->ats) {
+        if (s->ats == ON_OFF_AUTO_ON) {
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
@@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
-    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
@@ -2153,6 +2159,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     dc->hotpluggable = false;
     dc->user_creatable = true;
 
+    object_class_property_add_bool(klass, "ats-enabled", get_ats_enabled, NULL);
+
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 719d2f994e..6c77fc5f6a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
+    sdev.ats = object_property_get_bool(obj, "ats-enabled", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 26b2fc42fd..2ca49ded36 100644
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
-- 
2.43.0


