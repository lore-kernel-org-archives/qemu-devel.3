Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0430106ACEA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCW-0000wW-2d; Thu, 12 Mar 2026 17:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCR-0000tl-Ax; Thu, 12 Mar 2026 17:04:07 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCP-0002qm-Q4; Thu, 12 Mar 2026 17:04:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rbi+UcBgp64gpfOJgY5b8oo//bE9mvrQDg5c5A5+RtcPmq2Js9zrtyjg7h+H8+VLqMhTJ+d8kI3FlRfcIFMX7MD7DLqbmYbAMQTrdT0fzawC0O2ZLm3V4s9ZSVBu3+cWd++8TDOcb9MDXB3fQF8n54u2xa5PDS4uMTFnFsySz+Nq8HmbniFgaxP0zl00nUx7EPd0Tf+GLlsRR7Et9oG9MsKp8l00ZsKyi9zxYIaPosKgJx7Tr2hCQH7v7tLG9nUonON7D5bYJnx2BQYWgS3HsfKkmvJ6ByPUbSWMJe5cOTfs51mO98wH9DsJtOwlKE7sEPBf/e499dkQyWpVFqdckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw9FHfTdUWmRjn6vGQ1/fhacgRymJmket7aTq0sbh54=;
 b=OwSyKBwfPvkY2rVIvbcQldZDlgO9Ko47YhizDFsAddYamJ+il2okgLJHzE/YYe8+s+kOmsTzOqDtOF2iKXzmGn3O0cBeRWR8tRaQK/FvJs15M2PJ789T8Dk+W7oudTqD9KZSmSm58WR7g+f9FEfV+syGFLBLIqRBcsmWZawuhKcPRVCmyF+VsiwcpZo3WuLXdm41sWYsrlJ/HDZTL/7M1uBeBVrLKBel/A/xJHNbR6KnO3zyTiBZwxEYPQqnwnkqbDwtLnPsMJSFNjHRnmV2w77NGFPtIM8Zk8K+LQE2EwS/R/MgBiW2vJ8L2AkkiWS6jfcawB1iGnR/4/NBsEYI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw9FHfTdUWmRjn6vGQ1/fhacgRymJmket7aTq0sbh54=;
 b=sIdi1PngfU5NqPdp2LVDO27bywe7jlpq5cL+C/OYuMpqYX5BUPUBJky9/wxfm0gUFcXu2Y1Vs1fM0gAwQnTUuyEwJp3e3uT1JgJKAZ64x7UKsp4bdQ/HyU7b4OnGJQKrkgKhIY6vFcdKc/sazMCPFQ9XknNUsW61Qp3TSoORYPPFNNFRdgIM+7L8zxMJNi1KmLn6Q6PMd4Uxq/2/etKfKlhOsOGn/yJxY5qGiIYzSekhKWjzh0A/mcOATjmT+Dsw8Tm0uFlljpY0ZxurP99bOCdLr6vgguANNIPCY5/BCCvautzt76/KUrwmyxwJq0a+Py81ETKMfpSWQLP2v82g1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:55 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:55 +0000
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
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Date: Thu, 12 Mar 2026 14:03:24 -0700
Message-ID: <20260312210328.2016191-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: db3b60c5-6fc1-4598-55b6-08de807adf01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MQ8+ghemEb0LjkS7qR1mwtWvygxnMghYqac2nogV2L8OZCfKwtTFNJJ5D5aHRfWkJAxEHQWAZdekZ/K5PrKz/Ohi/27YgXrzCjWPOvfTIDoPfFSqvz02NToCQdnZrH+Iau4JnpA6pL1t6gkYyw7QuZmRT0hppEQiOp7lqCod3q6my7kFWziCuQolMVntQk7CZupwO329b3dmSBSFgjJnvI6KVvf65Hi5SMQe2qIwqXT5ZG/pfCEc5gNkkRCTpmnedae8cfEAQlbaTPv+bmsIi/LCVb+N96JoMYVxSWv9adbtbWcLyNOVF/dzhzmW2/CDbUBjYLsiaOI0TkCkVCc+OafQGOcrNQ8iij3m9n2STTzzhqSVXd2NCvtoA1JyKECagg70Bqq3XQ8azvkpCLOUjVPBSx6adibDJI4QCLhWAbIvSedK9AinDw3+Wmy8OF6U/yugydrTzZf4YKikXQyU9rhwDqUSbICVZ/oi229inP3kR+ejvL56V0Y9I9PYzTFN0+ZPOva4hqVkqiVvYZON2N9Bfa4NoJN2kTRf26kCdBmjPGuvE3g0KEhe/QMMgL8PoiIyLd5UTEJ3ukIuSkhy4W781RA4gpSuX9XW9eMq7mC5AsNzrHBZVlYeVvCl0J+QzK+LKkEuaqh9cQiNKVdw/nS4g2Mi5q3oTOHgJddemWgZkiY786dJiv7KclwNa7PcnjTkI1mhGCflmV1pI+yswJFOxusOo4HRJoPgPkhdEPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikmde7CPqU3eFIeTkeexT3C5vjU551XImmE2a3wReKBIq2kMv1ALJ80IVc3p?=
 =?us-ascii?Q?FlPSgctNQINYo/ALqHnRFt9hwDK+S0r906uTDlcmfkUilxuai47cjBbAJE6s?=
 =?us-ascii?Q?9ZlrU1HEon7YoKcAlxNIFAJr1QRw2I4VCNVqlaDV3P0ME5Ta4svlN9es52Av?=
 =?us-ascii?Q?cxbnCcLoLjnMCCTyoph+f9TwM9Hk/wEgmSJbXc8SqIC3PxWfqxl3FheZWabI?=
 =?us-ascii?Q?Zuf+6DCIfCCSfR4wF+BHId6IUaGe1dM8n5hUg4fxC8Lposr+qAhL0knqVWVr?=
 =?us-ascii?Q?aMb3H17TYIh8gYFCMOU1W8lWcTcC2D+PzWKHoF14UuyLQw3StXxfZPdV7J15?=
 =?us-ascii?Q?SeDBTWzqEWwD24WAuAsV269fK+Yc9Nf9A/rwuZehkWV4h8vvvgLcEoCFAAcz?=
 =?us-ascii?Q?Re9HJgnq1PhP7rzaMDZowB4IXZFvyNj1bXCdn18zBmiRV4vO1Uajkab+dxzM?=
 =?us-ascii?Q?8RGylCCPcFBbmyQarEXxoDO0zJKL7aW5PqJJMkbRCQpggT8DidEfZ4HyHw2x?=
 =?us-ascii?Q?ne+AR7FyMa/SE19wskVvFaiAJbwODueffw93UhUGylEz+fWKcBckYsISas/g?=
 =?us-ascii?Q?jjnhQuTj6bPxIfeqldHJt+2jL42/dq2A3O+mmUFw8sPYnoZMnU5X9T78nx/t?=
 =?us-ascii?Q?TxjLYw7L3RNP8/XHo204AuVIOaJCEPQ+7wdAFJ4pWLthaB0B+qOdjhc8/Pf4?=
 =?us-ascii?Q?Jgdui36FuewwpT5+FyKIRI2HwLh8P+fVniAChVwLBlUk+yDMz/e9wdy+/XLw?=
 =?us-ascii?Q?x8EkqiR5fM4tSXLrvAbJDGTb4QZyx+cIdpGTxytjEZ659xMtQrPTIoKGlN4d?=
 =?us-ascii?Q?KY9+kQ3w/+ASbqgeRYZd5bsqSGVpx+KTpZ3u5O9DKyRjD8muW86lWIIS0g5o?=
 =?us-ascii?Q?C3K3aP0DgHY1nLf4h5WQ7kvi1aeCmlIt/JZ2lRtZBC6zFQfbZMXK86pSjM7y?=
 =?us-ascii?Q?8ZQEao+wkssT17aKjeNWW9d/Bhuwa+w8TH3RMXKS02KnWyk2lqIsBMLllT4h?=
 =?us-ascii?Q?U7TM3AH0XajtA3/5D3qYOuXaO8z3pdntvMfZH9/RfT98SIGr69pGD2ZulgRI?=
 =?us-ascii?Q?YpCOfGDnDNVK9XyWmMAccNDB1PMTsbsAaVVm8ho4H0CeLAdyu7lLTIbCLL4d?=
 =?us-ascii?Q?enoe1dLI2lzKuwmoE9NV/R80ph2n+4eXxnwELLALumDFgLDPT6q2Q955W1Ay?=
 =?us-ascii?Q?49C/BK59WfI3TGfHUkS2jyW+m9DyUIiPh6K9KlB29D1BfYWhegmMFjlcjuVp?=
 =?us-ascii?Q?M5c5OhY/h1/fmxrqYP1WOdOgAGjtu5j7fDZIwksdA284aBUWliGAwjIBza8I?=
 =?us-ascii?Q?Eldng31H/IaDBr1+VrhqUFAaOC0aKDnRS8xLYcIoiIWk7rDjRwkk/9xcyDVU?=
 =?us-ascii?Q?zQCoPUdOaqGttuqIAf/bFzpP8sC+pJsysvypMhkoMUPo3i5SgcxE7MX2Ghe0?=
 =?us-ascii?Q?zRnxwvlas1EC9US2W8VuLpogQE+/c9gYgA+70hTN4UOKyC1db+Idje9KkrkP?=
 =?us-ascii?Q?dN8IUF+LIveEi7yaWIkkzwRQsK/Ye0ccp0GE/ZhRSPZgRkAI2RrdoeQJY5Jq?=
 =?us-ascii?Q?NqleBzsg8azdzNUE3VVeorVeMG9L3gRfwwobuEM8TA0NLbLlAPrd4/ByGmJX?=
 =?us-ascii?Q?IejL+abV5DDJoj/1ZktacZF9MqWBMY++Uzc/VnaOXCR+itVora7ipl17rrUz?=
 =?us-ascii?Q?5hnluvEPvjTNHJXpbhozpGL56SnlLFLQ1xqmVwrujh3UfVOBCK0AbWGLNkKC?=
 =?us-ascii?Q?oiKiNXdIpw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3b60c5-6fc1-4598-55b6-08de807adf01
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:55.0248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHqvbrDCYSxom52QnO6VOb+xrjGnipddUYO9meA2tebVe+xbk6J7BLF5eg5oXvaOXIHtszCRkSd+DH15AGtGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
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

Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
Setting 'auto' will use the default value, i.e. 0 in IDR1. A future
patch will implement resolution of 'auto' value to match the host SMMUv3
SSIDSIZE value.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 17 +++++++++++++++--
 hw/arm/smmuv3.c         | 16 ++++++----------
 include/hw/arm/smmuv3.h |  3 ++-
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 6f44fd3469..ab037df7ac 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -803,7 +803,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize) {
+    if (s->ssidsize > SSID_SIZE_MODE_0) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -818,6 +818,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
+static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
+{
+    /* SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. */
+    /* SSID_SIZE_MODE_AUTO = 0 */
+    if (mode == SSID_SIZE_MODE_AUTO) {
+        return 0;
+    }
+    return mode - 1;  /* Enum values are offset by 1 from actual values */
+}
+
 void smmuv3_accel_idr_override(SMMUv3State *s)
 {
     if (!s->accel) {
@@ -847,7 +857,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
      * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
      * has enabled it.
      */
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
+    if (s->ssidsize != SSID_SIZE_MODE_AUTO) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               ssidsize_mode_to_value(s->ssidsize));
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index acbd9d3ffe..8b0121c0ed 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
@@ -625,7 +626,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     }
 
     /* Multiple context descriptors require SubstreamID support */
-    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
+    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
                 "Configure ssidsize > 0 (requires accel=on)\n");
@@ -1984,7 +1985,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
-        if (s->ssidsize) {
+        if (s->ssidsize > SSID_SIZE_MODE_0) {
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
@@ -2002,11 +2003,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
-    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
-        error_setg(errp, "ssidsize must be in the range 0 to %d",
-                   SMMU_SSID_MAX_BITS);
-        return false;
-    }
 
     return true;
 }
@@ -2135,7 +2131,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
-    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
+    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
+                              SSID_SIZE_MODE_0),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2173,8 +2170,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "Valid range is 0-20, where 0 disables SubstreamID support. "
-        "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support.");
+        "A value greater than 0 is required to enable PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index c35e599bbc..ddf472493d 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -21,6 +21,7 @@
 
 #include "hw/arm/smmu-common.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-misc-arm.h"
 
 #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
 
@@ -72,7 +73,7 @@ struct SMMUv3State {
     OnOffAuto ril;
     OnOffAuto ats;
     uint8_t oas;
-    uint8_t ssidsize;
+    SsidSizeMode ssidsize;
 };
 
 typedef enum {
-- 
2.43.0


