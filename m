Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A9ACD6E75
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIFy-0006Qy-Rl; Thu, 04 Jun 2026 20:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFw-0006Ob-Rg; Thu, 04 Jun 2026 20:17:48 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFt-0007yG-TR; Thu, 04 Jun 2026 20:17:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/CSPgEk33FTlWYUvKXNXqxUVJGb+MgkHIuOI7zovYkYaT1mnsPGgi9bwMD/PU/PNDGYmFFsQ1P63zhsOvsYmwy/rV0882UiROCLDdXzLNXx9c2qYB7O6N47b5zkmaS1aEjUCrejbHTZs/lUX6pjP5R48Hr+gKd6YkJJHWyrO/FMRQCv1jtEp2y7yLB1fsiNmZHSkVU9AwnIjZg67+MhzTw+RT7qR1hiLshCpDP6i3KTKj9yfJIpDUNuEG05xvTJBOyhHHJtG6pJSTY6KaCETANqw7nRgCCnceJej9KHCFoQevanLqCMb+GzUuFqt/9EMYTXtLW2zgAbRIgeIWxhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY8iZz4ttOJgjcp3lzn/kSQcIbvJTBxlwQ+4/ZQVWgc=;
 b=UUyO6hEtnShoPVAA7WXJmYaKjdRm1ZCw+z7Mjc4xH95IYFZ83Kz1O2SpeQYr+MJw+LYZxHU8i3TJCwYDhPumhIDoabo2olz0gYKkaaYn1eUBtX/5tUiB8e53yT2E3Yyk4MUMg3Zxdzsi6XEMg+DNcHIE1LMTnCtS5+oYXXyIEI870bucA7bxMQbMYEZ623U5QmQit3oeVaZImbs1HbefuVpDEfh4T5AyJXYpSltByc4aaplrMrhWzaBTX4zzAtlCSi6JmtHDHVuEMu0TvO77Hbk0E8BtTkmYOw1NlwAf+FkbWJIIHv7hEv052CWTJXgOxyDooX/q+jAhCUMJsPrrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY8iZz4ttOJgjcp3lzn/kSQcIbvJTBxlwQ+4/ZQVWgc=;
 b=beo5BXntwijvPiH6SrqIN3zdcXKrngCthWuNFT9U7LTcgbVyILkVgqKdckyEuFZqKFKbli3l0feH5SF/gMsANvN1AQ0SJ/HiN69BT9BMLJfFGepTSMtvziNznFKUJnNh4SWtIFZkOtWNH2dW5FKpOSPLY3apb0jDqyhu8npxR9G0HrWtQ7igzfKGwOi/W0YyZ7OvrT3AH4h3OJKdX7QEf84eRiLuflTJCduH73fU0JQvvHjEWDdAa4FfjMRxO4hXQA3DhlWNPGrhmDxDYISVIOw979f5qHlHrH9S3yqCttt6UpGT67nI0DVE3S9F6Iwwjr1lO7OMeBUArRNVB7ACbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:26 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:26 +0000
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
Subject: [PATCH v5 5/9] hw/arm/smmuv3-accel: Implement "auto" value for "ril"
Date: Thu,  4 Jun 2026 17:17:08 -0700
Message-ID: <20260605001712.1823737-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: a5afcb22-e20f-41a2-834a-08dec297d2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JIKxutW9GLaomsaqiEC0nZoe7JcZDPU95rdgaKlCRRUyJEWzEEVvPPmqaoknkgP3aRX8y4TjZVWQceNM7vqA5lZUYOKHnDESuP0OR4W5ROfCMgnfK/YomVpjU36uWpa33px6YmzK9SVNNpTFt2Lt5fAg53u3nO0iLLCEtbs+7IqktY48QjYQpTl3y9JwiiiHWxcjfkitVEUhplzta7C341CuL4G6hs2tYGYHeDtTPL14xXeboqacs0C9TVKfDFuqw3zVzI8fgWdiZBzzTUVqHq/snM5Amvp+CggeOBID7/yUxO6OY9jngHYYQN3uf+ZLYALGsyIzo1S3AQoMceX0bJv0zjYx5dmFCyLSkjQIgoAWVfXHcMaDCpljExluaGp/v+/8kZp/yOAO0hV1B9btVnyDrfmF3NcfOI+C/PfXUy5KuURDVfel/P5AlUHZRV3DAFeSBhF5B/SKWGTPcln+XsQLVbY+IfA6GZ8ryGtmpnIzkCFq9AXjk0yXICFqdMzij1p/BMLlMXNcLV6/aZeBhgZX0pBmaDneCpavSocxsnk21w1vksCxybamjJqJyJ8HW02jQIHqfItlXIxWEyXSYWkbTmqSyVl19AoJ1wrz32umO1ESvW9dSy8Ie9tgPXfn6ZVThCOGaXRYu8dSIkLcUs6cOk8+DhIsd3BX/1PkC2Q12THCWwOIw4FKhJ5ZSXc6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AF6SOPnMU5WSmdZUWoUf8GqVwbtuQ2HR+dhq0cAYzMZa2Fvb9YFauIqHck0u?=
 =?us-ascii?Q?8WQ1PZmxyQ0VE37mmSjwVX0BRa9mkatOm38JOYy9ACHAXkHU9piC8soSeP4O?=
 =?us-ascii?Q?zdpIS3HSE8xig7uKOfjBH6KcFtzNKjo0i0Jrjo8zHJ1aJS9okaUmwhdiyrtX?=
 =?us-ascii?Q?7IK2mQalHcmWg+H4xW9eFlmBrlpGDTvfEOsWcwfZ8FLPxGDw7wIYgBa2JUfz?=
 =?us-ascii?Q?Zp3ffiS+9nlOZcuQKRhYClgdl9eNVwIPW2e2iMw1Kda8VS69Jjl6hL/gKNzy?=
 =?us-ascii?Q?9FQ3OCCMDKeJSRamsrR14+TCjBImoBZLNBahZaafDc1NsKKQt+XfjwhhNXDy?=
 =?us-ascii?Q?FHr8kHrnrBRi1XiAdX6jSiCYMXA2Yv7MDvEkIPU1vAT0kEQE1rGX6QJlrrFQ?=
 =?us-ascii?Q?eOJ/tzanQjyCWMzl36fZUFeGKTBiw76o848aeFDEptlunVZHK5KM7/5FyoWm?=
 =?us-ascii?Q?FFvr4WHSfJ/q8SReFdI09SxurdmDSGqibvvpTbb3asrtaNXthW845kYgdFXz?=
 =?us-ascii?Q?JSm5Fh5ameNqtkMvjZMjd2WJ/UTDpu0IVcLwWfHwR6+FNQSpLOnZA00Fkrsv?=
 =?us-ascii?Q?7sM2QmhAO75+hGp8plmMXPrsnUcLiPstKxPax8LBBAwfANtGVbgSwQZlGZlk?=
 =?us-ascii?Q?eq2vKyfqmSHrc/WJeozQYKfocs2Yw7EPS+ybF/NiRVbO/Ic0rocXVK3iHt1S?=
 =?us-ascii?Q?BXfyPEke4TPIFCN4+lcRfdrKMDOkJuM09thxYI8I8HQD8oI4iJ4doXJrusdS?=
 =?us-ascii?Q?g3e2hjw2QnM5Gvj7gFbTEn6eADbpZ3EwQNfnpqY99o65s3qBV4Rz6T8shSJv?=
 =?us-ascii?Q?9R05wQgrH9/wAEdxJbL3jBDHBjVhRKOngmk4DvMr8n8PNww0CDNr51JVCVhG?=
 =?us-ascii?Q?Co/XZSHlldatmsyIvvnJKyeF5ogFpXMK3LXpcGNkCzh0rIKIJFtSLSsMURy2?=
 =?us-ascii?Q?j2Jr5avJOPhUMH4G6MnJw6Y4bcW9qQ+ngiI40rAOjX/GlSGmS8261yAEII5j?=
 =?us-ascii?Q?9PWRjNmteH4Gm9N3Vghg4F/bxM3Tm1UscgEfWxZfLuJCqhCnH75RbYm3xAMQ?=
 =?us-ascii?Q?1WAm3+Hee4KdPXzayy1wnA9XpJVe9D7EP5FvN1n/zNOD43bY20TWfYwvpSUP?=
 =?us-ascii?Q?nWL3u16wzWA8fJ3sZjrWtlSAh04PULVmpp/qcsUSQZQLTx9L67a+1jZt+TgF?=
 =?us-ascii?Q?NI8EklmQ5JZhRex2qBpNRrM3832qmUsTMfZIf7i2kzthi7O48t5KgI2B5q00?=
 =?us-ascii?Q?XraSPH67cOOXNx5EuQCRGnftyMTp5YVuYQvol3nH8KYzPx0ouzNJucDu8Bo8?=
 =?us-ascii?Q?6EU5imgDaV5KBCAYSBx19Cpvszk9ByWZFv+coO13AqmPSHxpGBGsk6D4qu2d?=
 =?us-ascii?Q?T8KlN5xchjxHV3QmFJIFyrAsManlNe5OV6KjONoB54LC2aCVQjvbfTrIqAEe?=
 =?us-ascii?Q?qBvj3WGTHGGl8ONQfQFF8EbKvNpFHs32Ces/QWFNxbFLLu19O50HY/hJ8iLX?=
 =?us-ascii?Q?J1B29f0r18GeQ+THmcfkB+YAnUNs2CowEDLRNGlK53yFimpbC1OIdmHY9D5c?=
 =?us-ascii?Q?d+2yVcHVN4OmgKTRMMnwbyPW+wQuvf8jUuYsX9x5MUABCSxlZNQHEPzOKASV?=
 =?us-ascii?Q?wQNGdk1Ou8gj9JsZum97JaDtrt83A/m3gUh+xZ0gVjSzaFS/Yy5f+agYC+y7?=
 =?us-ascii?Q?zUgF9uidM/3KOQb3g9jyT7YFL1U9Cyl9B5QEtZriRA72vG224l/p/U7ZALfF?=
 =?us-ascii?Q?2iaUUpGhlw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5afcb22-e20f-41a2-834a-08dec297d2c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:26.6198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xgg9/rj+g+VvQkNGLu/iz9e5ERuVotTCOZI1OMycIZs7vjloGT61LOV3isEKMtkkA6jMt0m6VA+k2YaSjspI7g==
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

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 10 ++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 4c2acbbedf..25699a1317 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -58,6 +58,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -966,7 +971,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 436155d883..c183964b2e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ril == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ril auto mode is not supported");
-        return false;
-    }
     if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
@@ -2165,8 +2161,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "ensure the host SMMUv3 supports nested translation before "
         "enabling.");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on). ril=auto "
-        "is not supported.");
+        "Enable/disable range invalidation support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to on. "
+        "Any attempt to turn it 'on' while the host does not support "
+        "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
         "Valid values are on, off, and auto. Defaults to off. "
-- 
2.43.0


