Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B15CD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIG2-0006U6-1P; Thu, 04 Jun 2026 20:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFz-0006RK-8A; Thu, 04 Jun 2026 20:17:51 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFx-0007yG-Hw; Thu, 04 Jun 2026 20:17:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIBRD0/xZTLo2WVHhgMeSuHZFpcyt5BkSEApWfBDOaJ/nsgLXptMHDPdFqlRNh+esDO0QwFxgU3Hr4bb5Av+XjZsuHQxCSAnABQpXIu3hSa5O080I9yLfrhhwGPwWXhYpbNFPt7bR3H2F7R7Tz5m43sI7Ppi4rfdVnf58ke//kOb6yyxNPcLbKo8yx/WFTRaC7N8S1ZIN8LCJUZFnAK17qFSTh1tByqIdbL8wpSH0h/mLX7T3A2i/U5SVa5H8XGbuI1OZS4wB2I34KywgDOFb3040M1c85YcI85jUiOsAXX1zhQJYmpwKGnXRmXncpQ+BPMoRFitexxfdSZd5XpHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFb5RNAJOM1rcW+i36hHiR8FTRZJjiySg7p+GFXj7UI=;
 b=sbiiBjqvMNy8CAKSV0pnhNfnVN5zMTM2vDwCyuTpqoaot/E7mcih+P2Yu5BDAGHw8V0Uh7WXDOgxvHX5vKB2N3koeMz2Ii9twczA8fgmttaUaaemj+ysJjeK4dQz1RXAOaiVUXa3tinAYNvbrYjIj4FaX+WH2rRlNRujcCo4/A+WctCJ94Hzb58wPD1IRbzBWvxywczRyfFQ8Qt1RvPvAG9QTWLarK1OoXkOtMPrAHTfsVlGpRGML18wInRClVMsSGIow1jQFbOgGKZiTiCulCqTWxpmHZAu3vxa/JY1+GOpRnUThwsVHUrepijdSy8BdQu2tQ285tZFd6YvIIGdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFb5RNAJOM1rcW+i36hHiR8FTRZJjiySg7p+GFXj7UI=;
 b=NsizSkO/oAq4a3F8Um1id/FIxGGPupGNlSJLLhIylYoGSeH24f62mtkRr523uwrPQ7pfstZ6xCkHt/NvN1DCsNMV3M4tGqaiCWY3a7WAl9O7MRCBBdCtjFMUATPC4YfkVdVQ5Way7hC9fzrCVF+La3oajGB+jBwDa+kMYwIJS0bW/c7mrAtCamghb5qEAsUe1dubxQKWBBSmv5/uTImSZzn3O5/4zqunK2MVejKs0dVjSYPkooq2OQJjxC7qyjwveyOXAhiblKvzXcoXKNHLcj7RGraCA/1Qqo5yv22lS2okeQlB2HbmQQSaBq2kWV64qoqH8WES26ZSM3XY/jpf4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:30 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:30 +0000
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
Subject: [PATCH v5 7/9] hw/arm/smmuv3-accel: Implement "auto" value for "oas"
Date: Thu,  4 Jun 2026 17:17:10 -0700
Message-ID: <20260605001712.1823737-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a923c54-f3c4-435e-24da-08dec297d4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: Kh7FYsf+uELJxrUJ6XoBzPd18iP3aPEX1bcTpRvL9XbPsdBCGI66oGg+k44Xz4EtbKoCzeZPMaiDsGuE3/DvajfgxU5Z2zCxXNw856pTRvq0eU6cvEOKOv0vstec6GgD7sKBcDJnzeKl3fJsNWdcJG9FvHreRP/7HaVFViVZwANJZoWEfLDPqFPpuQLOEm9LZ8kJoTcX31d2kkJAvAYT3gyyv2X9MiOWYMt8bNP/ZfATwtrFnhvd2MWzI4j+WqmlXNe845eR0h2MS41So55w4Qv6HC99dKyhz3b0harzaIKVJrTOpe1owORtYvOr9fWX3EiFd5TufxqGfu31MxwkWOKDU/Z8F69iphQP4x5A57VDJujTok9F7hZLKHTxDswN9mAMHVsw/3xltxHIWL1b+rPn3b/fuOhJh2ppwc4Kld0gxkhHWBYHG5lsaM4W5qxsC7t6Ig9qBEoVnVRNQMeGwhnCNOMl8lOUFUzouRJVvth4iRd7V37CJQO11Aa8y7XLQyFd2GE9WmKAUekvwV6T21/tHpuZnhYBDr26Gb6WtY1s6ciXmA1YaB4bdUyM1xYy84oPQVWWSMdLNi4ghurW50FYcLhH3FeHo/f6za7JdFUVO9IEsayRrQrfCgfEIB++zTP+fkIWtvgcMIpZtT2/GFpogwWj9E7KwU1CcY8gTGeWik+mjvWVXVtAtmDT/4RM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ccbTtsDURoI8zQ6+/dEo7yyWiLa4N50Oa8q8dYCCtEcndfFVp8kWVYOPNkS8?=
 =?us-ascii?Q?oSRIeAxbZ6oXwMH5sZBpr09b7/3Ug+Fa4i7TVHawydQLMTpOdKT6SsIvm/2n?=
 =?us-ascii?Q?9FZx5gm56XNv/9ZTRvGicHzeaTCJQX1Be0juNggsw4KQL40hq2qWOy6mgow7?=
 =?us-ascii?Q?3eJ/bRdvVdoEbU0hFZZvAKLl9X6vo6umLO9161u6uldsSu8NdZrBpQ948gzV?=
 =?us-ascii?Q?vkTiuIVed517fMqQCjx6ICZSPwZy3lOIrbdqVNrlabxshKeHQo2QTWrhnrHF?=
 =?us-ascii?Q?SZz1xWFs2dksLA7a2/Cpb9ifCHtMuqRdMSs7ftyAxj16W7SHMvduWgGWPymD?=
 =?us-ascii?Q?veM7FbQLugz/26GBvb18oZNtoLEyfBbi+pdcGpPb+jn/LG21bvhVhyAECrqV?=
 =?us-ascii?Q?lFGnTpFfH8+SHbpxSPjTUCQANKFiDJgzjSZc/HLintKXgsfgQorQh9i9zqTp?=
 =?us-ascii?Q?0BLl8SV2sjdO4L7T5CN44I2JOVLs/xluF2QBS1smLNjmtWH95jx5i/CuaP6r?=
 =?us-ascii?Q?ula/KuHpEWeo8yzLZoe0jCTlrtN3QrcQkFYWN8w4Ko86+/NIwGXkDTIpYa94?=
 =?us-ascii?Q?xk8Vt2ob8GxLjjvpov6cN765wPvhwIhhJnKzJGtqv3mZz0HYHi4lKKE5cKmo?=
 =?us-ascii?Q?Vq7Wy1oEykXJZLqk5tBatgakif9spDhod5cHzHZYitoZrm50Ra4LaXLdp+Fw?=
 =?us-ascii?Q?bMh84NFoFSiPt6qiKCtA1jP1okIW43bKmsf47/D9XZR7xzozsTpcR/hQ2wXo?=
 =?us-ascii?Q?4UW2ix8bdcgHvdiWii6Z7j+7z14qYM/c0ytRhHIBjUjie0lMPjVvlcAbMLh+?=
 =?us-ascii?Q?5pRc2GrwIakHDhFhViTDnphzRCOliWNfWI3ZVoQdG2omV6DX54LhenywfPld?=
 =?us-ascii?Q?zp7OT34SEUOx9wQEyrX9bROqlsAXwSQfpevd5ENTJBxbh0uqenY6tozAggQe?=
 =?us-ascii?Q?Q8Ro5vBOgHPfJ3j/rdeHx4Stsct6wriamKOVX2haoNqAr21NGQAL7ScfGydl?=
 =?us-ascii?Q?RnlLXDTWX4IIYqaoT6jXW+TaS74H+G7YUj4gedQFkfCeBZVYyyaRReQyuabo?=
 =?us-ascii?Q?b4xQFER0hmXpF3Y02X9OgF6TUVcj15shUTE4++l9Bblx0HYwdwSH8TAFQZCC?=
 =?us-ascii?Q?MKhHkwDQ+pc8OQy7aBpEwvZJFa/mRTuUfduZDValpPxZ1s33tUzYjkhRSPcq?=
 =?us-ascii?Q?PuEtjEmdyFywngBeHdH7RN0OZoGR8P9h2tg+Wc3szgf0W4QFoGr8FtM4cn15?=
 =?us-ascii?Q?M7YJdMgYg41EjVeTAUmxnT02ru12paFmpr5uQt5fDfa4mRfV2j6EMmlTpom+?=
 =?us-ascii?Q?F5C/1hed2JGdPbazvC9wzHks1WILHF+5WphUlXLXRCiMOaAIajVJbj7FikPO?=
 =?us-ascii?Q?nVLVmieGMhA3yOxjA16E01wwcycboAu2jNrCGJLp59Mx1uzxeegyPakW0yNC?=
 =?us-ascii?Q?8T6MBa2r/lt36D0r71fauKIVZjd3karUUK4VKoRLbzbSBR4yKkByeA608MEG?=
 =?us-ascii?Q?mERDZdW94EtsOY1gR1Fch28/PM2T6f/mjXRQKltytCfk9O0oPxJ4ihxB4PaJ?=
 =?us-ascii?Q?to9HUDkLVRY3i9i1vwYAU7AM2BkTeOCbBU65bDBlCldlopEPovIl1n2BUkPt?=
 =?us-ascii?Q?0fTYXY9+qys3YvF52UWCAt55bzv1ecpUUedOL5koQXn7kijIxUeXMU3aBIk8?=
 =?us-ascii?Q?ayuT1AbGKuCkPMdyszobdPYgBUcOKd5/7WlcXUQLaMSIpQPc8Y/Qg2x4aXIr?=
 =?us-ascii?Q?L0VP2/chAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a923c54-f3c4-435e-24da-08dec297d4c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:29.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeyGIWDP8rWFfq6lkkQvY380ibtGUOh8gO+UPzGWcKIVQZBLiROwyPBbELabGTfdRDfJosWwzeOPvLIWgyiq8g==
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


