Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7579CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6b-0006iG-4t; Mon, 08 Jun 2026 13:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6Y-0006hX-OR; Mon, 08 Jun 2026 13:49:42 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6X-0007Bn-6q; Mon, 08 Jun 2026 13:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maSTpVrLIbPaa2YJjz33bkFjEWasB7oP9Vdn5ZXE+pdT96w1s1UeJPJJHZ9ElY+uEQARjW+i6dFfMc3dMkY+gHlmueqWqhALLx81z73s/ti6QsdCkteep5d4+6nLIfPsTz8i68G0XjLaT7pUC0xWk91HC32FATV+yW1DKpe/2PJximJDXux5GEm/JBV5hrL5JXhF7OspTTPidYM2ulgJZg9e5Di8oydfF+0Cilekx0E1e/60SLRIUPZ5D9OFMhQHuIQD2vjAS2j7X5gA7pFeKNvk+ArJhpTy/pIrJUAGM9vKpuSSsn2wIjiPGdpWU/+L0m0ebqf9t5lRb2h4cwVCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFb5RNAJOM1rcW+i36hHiR8FTRZJjiySg7p+GFXj7UI=;
 b=KyQ2hLyxGqLyh/1G/sL+PHXOwAObLvCCTX0/ME+mKVTst3xRKLDLQncM0EcX/f8O9ACOk+RECyTh/kCAaAjFpchXYptcdz3UxTxIj45d02shhAzEc40RYLaVmCoVzloN6NfdOvNLqiGLP4jlO8wk/4flYERJLYgNGEjsGdohlv98lzbqwDx8snlSsUfZzqVVLFg9skZ/D0ok3Usj5WGgUJw2R53IIaWq/njSNM6H5+sQhFyJzXk+B4XRL6eSagpkHqmqvzYuKyFxIZvzmQKFtcwONOjTor0dIvVialIAW6OtNeUUMnE3v+YBOdcy3j/BUeSOuodIXeLIYuRku+QjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFb5RNAJOM1rcW+i36hHiR8FTRZJjiySg7p+GFXj7UI=;
 b=Dl7g8R6G1ujx+Hlc9JJC0GLL/DRe6AVxkBqG3NDb3kVMTSfvg17GLy+5s/xSfKu8aSUQMHIJuwSgiIbJBUNjTLEkZGVnT9gmgd7kxZbyBPVEuwDovEYDuSSADk3R8SD7w+vdnvVH7Re4En711nuQibaihI1obYSrJnVpynZOUqoawHjd0jI60gXXFHsTP4BVbG8aYX3+Q6MlkbnZm3fM6/374ubz8ZgsAWwwmWu815FOmkFWIdBF/jm1twfZbJ5iWaoKJa6SWs5U6uWM7I7lqarZ8+0j6qOHJQ0UNKCYOGetQNvtmk8+Sxekieddd7GL5lCH4GwKlO7oJnLQuZP5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:28 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:28 +0000
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
Subject: [PATCH v6 7/9] hw/arm/smmuv3-accel: Implement "auto" value for "oas"
Date: Mon,  8 Jun 2026 10:48:58 -0700
Message-ID: <20260608174900.2227340-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::22) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca17406-f36e-4079-f858-08dec58649b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xAyT1n+LLsb3qxIqnUI/S4EG+LH8OdkTppSenVxsiouXnmnNUlokRJa4qyOgxRuUtQG64Y4+wnfQIcaB7yJwpusTLFp2swC3f/DtkeNzVVyaaK3M+O2+f7t0Zw3TtlhZMGj9jX5aD2Os1jr5yuVNr6Fvr+W6QYVhEIUSAYeZTQi83xms9Oyxm6Jrr9gSy2sZn3ouESxiI/v53bIiIA6/oiCr3r3ACl6NuNVrhWhG9DZa+VfAsaPZ/IvKcyCx+JT47/1QsCM5s9TEO/xGakwTcyboCfUCVG3ITBxPnd2CPBr6ObkymBWp9+vz8RfAzAvvfidznJWNBLcd7Nw1hj3bm1SytvcldQAIxV6IKZt9Awo38Z55a0tSj3AtxrAkDZzt81FH46BN/dh266ytGKS/Fp0SzrmCJaKWNeNph+KS8Wgf4aFgBbp7doGMhpNscIhYY4I2iPPgGH3soBtBfndXm6Pu/L8/g6J5wUVv4fGgBAIgyixsL4dX5RA/s5W0i+6BMmM8Ev1vUERQGdLBoX4yUglkon/18NOiyQBnq194hPt1/fFq1sTzL7l37AhvEsThTMSwvKTBXAGNjgo20wGVfAAolhxyANw7Y+Ome+nvEWjtVfx0QO5ltc0oviYwE0zpSfDpXRAvLdGZUalZVgbwjYdt6H1APkzyJbASZgjlES4bEZ3oR0UKoAJ90k+gtu1l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbS9wlybQCHUvVkLKyRLVMe0JFfJ/jrPrKMGDdwnoeVtP8r3dOd2ZO9bVzU7?=
 =?us-ascii?Q?ElVKvzMhZe/KoQiW2c7ItsQ3I9cq4HJBiBGXtInvaB2G89Rn567pR0CsKhJa?=
 =?us-ascii?Q?3INCLk5n/mJvkOdMXJ/IbxfTBvkthfOX5j/UUYbIuFxO+vBAO69AmvSrnunI?=
 =?us-ascii?Q?AXKJHOvFaU94lKxCnme+fCsLVj8wM+gd896jkY7ecqmWT9k0c7MDj6XDGJpQ?=
 =?us-ascii?Q?A/iaore+85ePjhTwKX4sgvpVgxx016NNuF2iZh1yNvvH8Amh5qwTrXPARRdR?=
 =?us-ascii?Q?FunLo1Zqy44xhxpGLxRoAE0K8NZuJzs4/JXD/A8PHE/9j1jB8x8g+aFQW3I4?=
 =?us-ascii?Q?SvVgjZasimHCiPi29P4swvHQmLP8peCPqG9IdKTxqbaIhgFJPRx27qIIE6va?=
 =?us-ascii?Q?sMJLBvNjnQijlwbur3589iW0LqNfcmSnu4tbHDo1v37VCKcRncgWbZy6jOj2?=
 =?us-ascii?Q?zEqSUgSColtl99who31SAhYOdRY/yktMBWRRyQHcVTHgFy4akzVryZevgTdy?=
 =?us-ascii?Q?qYlBOvYGLCB1V2sJKsd7Fg+8jYaeZZ3E1e+35JBrsixWroOBITc5uu3sETsV?=
 =?us-ascii?Q?VnV9HjWoo2q6CAxari5NgTy/d/y2CkPgZAfcBTA91hIkY3ODWuH9IzLal/GS?=
 =?us-ascii?Q?Hc1cGh8yYO/Y7KNcUa6ALQpRfkZmfKUw3xschEQv0HZ/DjNM6RlCjqsRs9Dm?=
 =?us-ascii?Q?aP1JqnNhiOv+87tHrtDZ9XresodU7PQwXfozTIn1SIm6uzSoZUJvnITJY+c9?=
 =?us-ascii?Q?pTuaYG3WVcaxh+GkMEiutlBy7dsRxAhplorDnm8z0eny/eyJE6KNLBJPTcN2?=
 =?us-ascii?Q?fBEQH8t6XYVtvwnW75pgvU37EjH95e1hqVQx8EgFl0/jWZ2STDnhprywFhOY?=
 =?us-ascii?Q?L+qG07NorEEJJ5kZXI+uQ4vhOQzeQp/aPsa2VtibRbGOAEsO3VKAkejSPg8K?=
 =?us-ascii?Q?vXX4hZfsUV25M1uZYyhZ5H5WPRLT3fe0hKpAAP+GqdpibNo+1K8S4IPGZSMb?=
 =?us-ascii?Q?aYFrsNnwmqfyPZETC6H1InJHkp9G44yN0tNuxNR+cjJHn1LeYjg1DlTr/mf+?=
 =?us-ascii?Q?hUx8pe99014uXcv7tkMJxZCBbJLRehJppDCmnOY/ccHAJafrYSwuVOZ14738?=
 =?us-ascii?Q?XBUEXkYQAYdOnR5lGlpG9Y+F5AP1qAKBjeAZa7hZDLqXU8L8deyqdcTte115?=
 =?us-ascii?Q?tILENU/YHkrhclDcp3Xt4eV1xEqa1GflrNruhYAo0zUg8qvfMNMXACi8v7Fd?=
 =?us-ascii?Q?daHOMOMVN5iv1zY173SYqjQKvLZ/Kkrm/ej4wcoYVuhBJDOovlIQpFCRjsm+?=
 =?us-ascii?Q?lVPLD5cgWEgJBpWNFb1491ObScfBgmDdasu35ztb5aidJTXKdCZfTVcsNYj0?=
 =?us-ascii?Q?iFP7ABpc23Lf2F+uFIoWpzBTB6k/t9yP7bQamIKePKjjFfeXU+EjpSOCRgW3?=
 =?us-ascii?Q?DH1Aklk4dY/ZoNK6dNJURyTTTbwfzeQ3KAx5KBYrEJP7KUthzHwbaiHyou0f?=
 =?us-ascii?Q?Rp0JX7/3GPBiZIf6tBuCAb34jQTbP3DxSBL7ioHJrFzuukp1vKY2tpQMppsu?=
 =?us-ascii?Q?3F46yYpQzOzfHqYvt4pYoomwQAvvVs6puimP7UXgW9txnH9TwYL6leyfFIoo?=
 =?us-ascii?Q?uTML5uWsTbdVC9Mom+3WOEMXzZT1LcT+UFcbfXIFwapK51HuKLBRJlyR+a79?=
 =?us-ascii?Q?bQCyz3M+Ix+O97if9c1W+Ckk/Ki7ykkCaqSmDRoXXwcWBsNDYurjE7zJhzHg?=
 =?us-ascii?Q?POzhEvi9xA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca17406-f36e-4079-f858-08dec58649b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:28.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4WVlPtD9V7d2cWIpHE7v2RDObLudJVa34LrWDme9qJGva1Kw8tFi5MXg32ITqGyQBzLWlomWlwTnnDAopjp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 17 ++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3f141991eb..06dadf9cc7 100644
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
 
@@ -985,7 +990,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
         s->ril == ON_OFF_AUTO_AUTO ||
-        s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->ssidsize == SSID_SIZE_MODE_AUTO ||
+        s->oas == OAS_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d59931d1a7..89289ab6d2 100644
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
@@ -2171,9 +2173,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
-        "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-        "supported.");
+        "Set Output Address Size in bits (for accel=on). "
+        "Valid values are 44, 48, and auto. Defaults to 44 bits."
+        "Please ensure the value does not exceed the maximum "
+        "Output Address Size supported by the host platform.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
         "Valid values are 0-20 and auto. Defaults to 0. "
-- 
2.43.0


