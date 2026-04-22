Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C992AFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeQz-0000XZ-Kr; Wed, 22 Apr 2026 16:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQn-0000Tz-HK; Wed, 22 Apr 2026 16:44:21 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQl-0006uV-VK; Wed, 22 Apr 2026 16:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHVLAtJ6iYEiuaBMuD3AygYop1rTq43w9WKxRsGEeia2bJOax7t+ZwYyrPGc4gv4T2Na4f7N8YQrfczxLiyFcRUUfRNhC5mD/F9g8Vkd0xHTBlTEck0Qyn2+JqUD+8KllF/M3/bAJ6UHIMx0HZgLKfzg5hwKXajdHK9RqvCmWL2MxpSLDeZSp6jp7SESB4g9ADBNLDPYf3l+O+EWL9Hc6TL13croFLJ7x32kkJP7NI9faFOVJhqO3OHBtel/st2TDYkf7aoPYVy1wZff7LsOnzWrxYiUEE07sI5IkrHNbWmpy8w7WHIS7hZX2IaaOroEJh6QoogF05S9fheZo/ft/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B++aQLhUTz4Ffo+zFAUhsq3Jls/PqCHMEqF/PwDmVNA=;
 b=Bi+KjqPNFKxeontxL9o+T8/W3M8JGd7XvbDqKsbAKGCxdZg6qw/WBXcl5KV1E/LX0B1rvz4PMxnex3XBvsGOwfL+6V3/NVK4p9iSgFrbY3r/6LJzemHm+/s/hj3B5O3+b0yJP7nYuiQaiywtR5Jchi4gaIoYayQvuM5fFF0Z3f/t92W7Mg9zuO72t0vgdP35/oHfwDTMzaNN4T1X+9PY69nMxxx0c8N17EG81NUCVwb9nmY6cA/cVL4w3K+LL4rdB1kXsSngZnJfIPW/v9e865fb8lSpEcma2zWKnwiSi7qHJ9PO+PbH+801SWT2pl6VErBSejic7cxmkK8sKJxgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B++aQLhUTz4Ffo+zFAUhsq3Jls/PqCHMEqF/PwDmVNA=;
 b=SXxSQZqorBHXWq+6IPxKl3GfiFJUf14m62WRM5xhumSke9IzqZiFlu6QtyeVZdJJjdAKiLK9TKYU+shXbwBFFyetl5je74+tBhLgxYK0+kfERT1Zz4OBuiV/LWid4k+fvv7oQZeQOWn/vbz2Txk0T3Jdi3mSFqVMdcECb0MusG4ehHXv1nV0BqwXKdMMBirKUer2tiIwezSyeDrg86UPg5cvgncrrlf2KcaJ7NI53Ur3s023o4hewP7bcQuTuH4nSLKMzcOqgFcBCCYHxYmTlO9v/kGhSB0MaatVulTVBfHCyMspmeQcQMPTyK/hB+V8O2VRmIeRJ1Damxsl9X0qSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 20:43:58 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:43:58 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 5/7] hw/arm/smmuv3-accel: Implement "auto" value for "oas"
Date: Wed, 22 Apr 2026 13:43:33 -0700
Message-ID: <20260422204335.23116-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 726ffc82-71b5-4a07-b81e-08dea0afe0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: PfAXYG3+LtaevURC4mLxIRTTDuAt0Qajj7h3RoLOZjT2YJBcd34d9ri90ITt0ANZ84ubmP9bgU0adCRTrMFZ4325JK6Js6fthEzQSTfySPYfStSKp/qmbBkspPF9Pc1YGC4R75yitJVojqGGel7WUdORf7GbVaV8AqLecAD5oCXfIKyj9eblFY/jIvuAzEp+M+yRU/61Dxbp2qrWU9QJRbJtXCmelbPhBoOqgnvchXnjGxNiCAOHsejP5gMR4qYLpuf/3tES6LxaS7xoq6oOc2g9hS8DLKz/oa4KYz4uwWROVbsNEPB18orIAzEVFPs5NLOFURT9d48pTPtBGwBTGmcVknn5WUTsOQ4/Z6AJk6ySIyk/By/ft7OxM8JdGXZs+wG0xmoDNzDVEYfZFYUGApdPaN7AkmLgTq3NX9pCEgG9R55OL3WOJQaawXgh6eI6nWKlvpxAh9yVXooQjmJU0FEsxUYL6lmvsxD4hwzkektTCdoiRjuOVWhPUfjpHsBik9DwWPxSoLvTvurZFBXHwVyf+IWYkTXl4c+GzSaPPV/gomH+WDVGUz9QZOgC/63VpBTDQ++WIcvR5MkMOV39yAQXHYCeTmNQaETJuPA4p7sY0zQSIvtG2UNaCF2NSc1CUvPH3BsIATNjjhjCqPVaiLA1EVr8CH9+TqW/J/pVUU20RhFkGXApnt+b0ylOCykhYZe6ZWKA7H70RRRO7XGETwVzUgCNb+wP0RqzldNjecc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+l5kIYeoDUWzTc5wHUoeRR6wK5kBj2hRfevxVNlU823qc2WXRssb8WYU4yT?=
 =?us-ascii?Q?03AzkDmeXgxZPk7RxfkCu7UBpx3L3+EQfc0a46Kfn7J8+btfn7vaDTqda2qD?=
 =?us-ascii?Q?qQtHZmQ3qt6nL+tGVIVJ3xzeAT8hwzazoi5dDo5xBoCDAa74Wg5Hm2mzKMPp?=
 =?us-ascii?Q?oUYhcv/CJh4Ls4thnlBF3JMf2AU0FuJq+lXZ5U4rhNgEN9/cwd+hPn+BLLtF?=
 =?us-ascii?Q?w5cRQxDHkaq5eEZi7V4Y65OptVqJQsKnVoX1YCEwL2LeGf9qfbH6ObbKvcNw?=
 =?us-ascii?Q?Kq1UJR5xINnJkHsQx/OMoqnucNhI5exyWZsFI8Yk9wdQlYNtfKtlOOMmmD5T?=
 =?us-ascii?Q?DWJ22CPLbdKD+mP5Spw52QdYGXiW5uf7oE07Gn88cmGwgI1+cUC33YrK/qAQ?=
 =?us-ascii?Q?9nk7EwLBPtSftpYj/Rl7Tlvjgy8z2l7x22N0QIuupTz+OJgF90BUt+QKg8MX?=
 =?us-ascii?Q?2tv0SCPVcSWi2p+dtB83GFgQnZ2Ci+nV0R08I0f5waGqP1r2d8n3EZSwNdji?=
 =?us-ascii?Q?SdPrRv59wk3uQjimZsCr/WA5ORqH/tEJ6F9YYo4KTB0bXlBpAQzIiS142Nl5?=
 =?us-ascii?Q?3TD2Qxu44v87273VxtxOZuatNShTR7gf91HvfkyVIR4W0odTl5AZifwRU2HH?=
 =?us-ascii?Q?88knQtHjX+d/+K1x31vfRr3jY+4l/f6471nw0nWx5ZvleDkz0CwhMO0RDJE+?=
 =?us-ascii?Q?WqU/JyuXdKwJRNb1NE7JJomRn8E9XIMXLSJWlsjZN4L2H3EaBNxUA+I45EGM?=
 =?us-ascii?Q?6seKU7V7SNjMGSxasFp/A1kjuuCUt3ni4pJzce8x/Wdn8kq9893U1QBUESuD?=
 =?us-ascii?Q?pLeO5U/XUL863kggIZYUmrk23+y8eDfTj+RiLjpIdjuao8UoQMoxNYu6aRc9?=
 =?us-ascii?Q?0Fr5MnGslsztrwuoNRxerDtmsyFjK0HJ+EKWI/mGGlQuXmNtfMDMK3AB2WfM?=
 =?us-ascii?Q?/UEhYdgnBTc4y8C6L5R7kmVSmQAeMk7xGPCzUM7PKCeayZxDCZfXE46Xt59I?=
 =?us-ascii?Q?W2CoJe9Sv6GmBugjO7RnnYYljVaPEwmHZMWITwp8ZKiteWPS39AZVeO2jC4W?=
 =?us-ascii?Q?xTx6mPS4RRAxf8ASdxvjwH+Vpft/ywmM8gvwpea66lWaEqN+GF/J5+H+qghC?=
 =?us-ascii?Q?DDjobsr0j4dX8DNcIivhRMdT/J2EJRSN20mOa1wL7xCtIgObsyoRwTY1AyWs?=
 =?us-ascii?Q?P7U7EEF7oXAuWngu5RkT3a79+u7FV3YrtxaaQTe+61XNWY21dJzvmx3t/j9z?=
 =?us-ascii?Q?wKeGx5+BSCJr+QJAeIfeCst2rZ4dwpv57l+r6ufb3RgnSFygeN2uVgd7pTAq?=
 =?us-ascii?Q?HOrA7hGHlM/oGxJBjAUizo2Vka0rL21AOhuIG69nTPzOaIhboABCxISW8Y/i?=
 =?us-ascii?Q?a9G9AZTD8M/fIBq++BMZxYeJM6heUE5rsIIG1xakduXUVIBzDwXXwF4glihQ?=
 =?us-ascii?Q?NKTPiVdkWvWOFz/1Vc+mpuRd4rLtoMgtBeYzIdBtcq8tJx93kdEZPLN6OG+Y?=
 =?us-ascii?Q?joStcLdm7lQlCRONk6iKJ+1m64E0UkenqQ+rBci5/GulEIPAWy2gNrPoMYYK?=
 =?us-ascii?Q?3ORk7axrh8DcCzhUGCOQlCK6H2BaeBnSt+hjqK1c8z2hMaemtM10W77yqZik?=
 =?us-ascii?Q?o3cg9istQ9MMa9DqhkKwqrMUTZGhKI220L99dV/5PKcpTZkbAKwDiNzXatlp?=
 =?us-ascii?Q?BX7PWJ/OE9GSb+YrftuILrixnoj12a4DoqmdggPH3hg+MTLfV+TP3fUnEbE1?=
 =?us-ascii?Q?aK7vzxspqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726ffc82-71b5-4a07-b81e-08dea0afe0a6
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:43:58.3051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0fsDSB1/2rZiSE8mvQcQTUD5QL0acUcfw3yYQY/Krqr4A2Pp71c6F/aCNMrhjwUPrMIQQ1Dsen7ZEw/EcEZdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
OAS from IDR5.

This keeps the OAS value advertised by the virtual SMMU compatible with
the capabilities of the host SMMUv3, so that the intermediate physical
addresses (IPA) consumed by host SMMU for stage-2 translation do not
exceed the host's max supported IPA size.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 15 ++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index d13d15a11d..f45e268bde 100644
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
 
@@ -988,7 +993,8 @@ void smmuv3_accel_init(SMMUv3State *s)
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
         s->ril == ON_OFF_AUTO_AUTO ||
-        s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->ssidsize == SSID_SIZE_MODE_AUTO ||
+        s->oas == OAS_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 07025245e2..39a6f72938 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1975,9 +1975,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
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
 
@@ -1991,7 +1993,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->oas > OAS_MODE_44) {
-            error_setg(errp, "OAS must be 44 bits when accel=off");
+            error_setg(errp, "oas must be 44 bits when accel=off");
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
@@ -2173,9 +2175,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Valid values are on, off, and auto. Defaults to off. "
         "Please ensure host platform supports ATS before enabling.");
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


