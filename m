Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E9BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMYe-0004kc-RJ; Wed, 27 May 2026 18:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYd-0004jm-6G; Wed, 27 May 2026 18:16:59 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYb-0002I5-QI; Wed, 27 May 2026 18:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIA31gNlRWbn98LKYWWaUcpyXJgpB3hAnxC7I8EG64dS54lqXNhm4E0nTXb/1L+x0XSVmwCfSo6GLa/usPkm4LizDJqFCJ9YdEj22ufJiaxnv729dlpeBxqQpWFa1c756j4FVg9bMpwI2rtCwma0uYZKZy1E8XdPYDNgE3Wx3oYr6+3D3i7r2kVrcRCPEUgctqo7/nIyLThmE+oAk+RIDFUIoRVYGy8ZDPcd7miBZrg15wyBvKks8RnFyNPd97lFQOghJqk+gNogp957NkgvidMtgQxNKlRiBlpcR+qCAexbMXrSFOkDZZsajhaCjs2v5WUJDBJP2GTyCc6NmJoXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ4CPZ1ZMQB1fFWHaZdHhcd3RwQ5eCHmTqYAU9NFmr8=;
 b=QP+SKQuByxbpz6I7p28aFDWFa1HLiYFKsnYX52Loh2sfH7MuRWh2o97KnoNbST7WgCqyV4Wfd/oNxOX26GXu35FUcbGfYxeS2QJXkXb+x356UKxNAimVCg0Vv2fIv8sDWKHkTbAe37CXlwK7OPYGLrY/bja1GIg6psxTADbsic5hXMDXEtZjfmtIWu9EbZ42UWmTfRFkZvmxXreVnw76yuIXR97QLgDXlqQ6qPpLRrAvRIbwO+eRZw5cXTVkP1FTDSlFAgKuBN5SBlo26qcRRc0AWdC3wViMaxdUNNlBXcjVlZREY6/zMmslhX2iRXZURGDhVNGquShB4F4jF3PdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ4CPZ1ZMQB1fFWHaZdHhcd3RwQ5eCHmTqYAU9NFmr8=;
 b=AAQ490Q2XN5opOlbLzMXmfPMmF+MgZWLVB1HZLjriH+OsfcrwN14Onk3C7Su8d9ByhM2/lRLn7Wn0WgeVJ28+ee3PGKjgpjbWqEAlakxYuSwACnEioT9MXWBmbxwH2ZJ3OJCgNYWYpSHqvarh0MO7qEFDvunqjIFuXmG31RJORylzScjz8WsFCXCvo00F2qH3tDzKgisDJR6m+HM6P0RLu9EjjRKTMKUx7gI6uD5po/j+kE+msIU9buyJauKnLtSkuUE44H802q6dgDIqp4WCBEtamg9ImkBxNXFqM/JsaHpa6/kqa/Mvpc51l1CToXpQpOan+CPdjH4nME6Ed0EgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:16:50 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:50 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 4/9] hw/arm/smmuv3-accel: Implement "auto" value for "ats"
Date: Wed, 27 May 2026 15:16:26 -0700
Message-ID: <20260527221631.612026-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ee26a1-27b8-49de-516c-08debc3da670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mPyjTuqSkInt/dnT3zIIA6Ysd3nTkEb7NbOpUTob543vWjR6Fpu2iUom8FNeeWkB/nvFvOzO6g50X3TYQHQfNHSdipkQoHNR3FYfO3aCWEBNKRk8G0CnF3sjQnFaY45ndBrLFrFLATi5TlDUOKxDhPqngFycu3GfTLCBAEmA6E/NgrXdh+fXFtjXxpWo2yzsN8tX3VYde9fBcbYFF4f066JMNbagVHoMBrvRV19n8KQZr4N9bbDCbnQyQlKTffMyspxruyHh2Kto8LQhl6jfKIa+HGQPVybeKwidQHsTZoqSqpkBvXnK2Oq0PzU51KUAlmUqvQPWlamrFu8f7MbM10Cq+iYvPAJZdpLd7KsIEhjyd0KxqTbZZ/9do6ty3oDDqSwgNCMzXPMPTj2z19OC/Lwom3djBAEBZo12wWPW8AVIL1BfdBpqbUjfYVksBHnn8NnaUK3XixVJmhNMXlqCwTThX9x9Iayws98IdIZFl0VVcBLWcHBvPE3+1EmM8Es9kydHdyTZAB2BKRKgOuPzDFoI6XLg2gAVBaHQ8SzIjm3uHJqeUPlunuPgH9SP11RHGhiapfL83EGWPEKkQZgqzkuQlRpplM8jeGlGfmgx42CNzCg4FHE9uQeKI/UFkipe266NZdhUfM7iHlZd+Hmeb9EgMDdAhbk23UJOOahCE5ZnbmijOC2lkbx94TPuqa0I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RaIZIqK4bk0aeY+UbqkT+6CqWJM/jWbxvzXJEVhQeUV2AP2CpdEXLF5EAptl?=
 =?us-ascii?Q?LOpEwt786TmZLpBgLrMhtA8OM3NJ/hImpPbkTuTs6YN9ha9wSUFqXx8CrNWg?=
 =?us-ascii?Q?Mlusp+YvK6u/Ayu2lAnNWDUT0D8TDp+bRTy4nK8Lp+jCJqC6YLyhgsK1RV6p?=
 =?us-ascii?Q?y7bgQdkr6IRDwOtiGjN+r5jf9w4Y5L2+pk7+srOBbJ9VwvEkvB6z54akKPXY?=
 =?us-ascii?Q?jxDDK44FQxrdVp6wey7hQF1nnDEBvBaeTnHoSOA6CGXQnlRZBheTdhrzbWFt?=
 =?us-ascii?Q?wQPGNaj8NxGWvZTK/y7WGyUd4N1OthN0+zZ2vR+KCcmbTc6C+CEFsF+9DwV2?=
 =?us-ascii?Q?PhW7QSQyYPLBkoJ4L+px1+gYy9zTvMqudmPCQlrbLNNn/JmP92n7vV3Kw5j1?=
 =?us-ascii?Q?jka4KATQ7T9EyPkhoqY772oM9fr42s8x34s+oHQ9OGCO1BIRb+bMokdU5r/z?=
 =?us-ascii?Q?72RZbuX/XQpeBnFvYXsBO3krhE5wKcxumZKGYIRQoCnKPWSch8vV3dxwUiWf?=
 =?us-ascii?Q?JVdV9GVrTY2xE9XPiwdr4wp0tvBDGYZAn9EQI2BEwEMWZvPtztvnkaJMYJ5q?=
 =?us-ascii?Q?z0jgoO/sXr3uXtMaSA7jq6VsdGNvkiFpyoD6tLbw0vjrspzRhFH985d4RABb?=
 =?us-ascii?Q?6izDxprRcokKeNk4dktSICPyUfX91bjWtn5xgnLW+8darva9/Un9QYHnmoMc?=
 =?us-ascii?Q?ikP5DmaGp7imEwjiJgmChT027lKeOnBUtheTDpxqrI8bYpxGmuvcRrTLnpvU?=
 =?us-ascii?Q?ygDZ9PvgazfUB5Y1zteYYypmEvIq1Z6pCVKIJnpU/Wxb694XyXGVzvlADgrH?=
 =?us-ascii?Q?SSTshRA2wD0CCaWfM/ItkcyT23ErY+QhSL/HQ1B7TAIf0CFBz3Bf4i/zhpkC?=
 =?us-ascii?Q?sJzs91cbr0uE7lmRuREmogWs37TZwsm1BIfCwBLGdGD3qYpOfxatVkbQcS7G?=
 =?us-ascii?Q?o8fT5RwNcM7bIv9/IRgN44NG07iY9gWxu5TrqV0Sm+txC6wPDXAYyVObmHf7?=
 =?us-ascii?Q?j+drMWleizLAckshsyZc8Xh2DpFoIYs/jQ/oFvDq7yZzkiaCwtPzSyk2SC7i?=
 =?us-ascii?Q?FE60Zek07e+Xr98J7WNos4H94KSieoMKXvE0Zs/5g8Ku2AxnZcdqjqhX/FOT?=
 =?us-ascii?Q?vHKM7BsCFIIINwtMiNdwbRWNhe0hGSS858kCtR3ptvu5IWhQAUP46hAWq6ra?=
 =?us-ascii?Q?ZnckX3B2xGOWFnDxQNEzvnyeEKDTUQ+NOHbyAOJDCK7AM9dlPGCm1NgB5Bsk?=
 =?us-ascii?Q?gKxh6VzT72j2pLdXc1I0rqBcUaVpbwDdh83AGD6ZKpyrecZoA7Iw/YpghDAg?=
 =?us-ascii?Q?jOHqrA5xXD7BHOWEfiRvZgbGShz3vWyxhEsuiRDmQG+9Co971gZwEX2sQJYt?=
 =?us-ascii?Q?a2dNmgZeLvbXaBizhPkaFk8GaxN6mDfBW3fSmOBhGJUvPY52T70gX+PK6jF7?=
 =?us-ascii?Q?5KEzliqr0JX+LmBc8Q321tzHh3z4zffZzpfla8jbv29PEEJXVLYO+0ditjik?=
 =?us-ascii?Q?exfF8DAYF8yq29NN8kgnevhdmU8JbuYQ7Fy6/Op0yYJP4n0UyBuNzF4cVRvW?=
 =?us-ascii?Q?vYAeDbnoJceCvgL0bNTjnYZKlvr3HUokvIrIC2f9+i53K+uAtJJYvYJRy0Bj?=
 =?us-ascii?Q?t1+juF36BQfegf+dcfF8p7gRJG8VUcAT0jMgpPcH+Pn9Lf0Ja7lL5hVmVuO3?=
 =?us-ascii?Q?DscunTIhUGpL+mDgxZhZtCw/02fQXl6oppFTcivfrW8aNbyzxjJB7ARaw5nx?=
 =?us-ascii?Q?PqZBcxtjXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ee26a1-27b8-49de-516c-08debc3da670
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:50.5848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T08nMd0fOyJ5d9qIpHZUS7RRUh53MTrAJeAMxTt1KhU3oZlLq7WTYTPZ5U1tsl9LmlLnOk7kb8jaRDTXVzfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

Allow accelerated SMMUv3 Address Translation Services support property
to be derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  9 +++++++++
 hw/arm/smmuv3.c       | 11 ++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index fa0a97cece..4c2acbbedf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -53,6 +53,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
         return;
     }
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
+                               FIELD_EX32(info->idr[0], IDR0, ATS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -961,6 +966,10 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->s_accel->auto_mode = true;
+    }
+
     if (s->s_accel->auto_mode) {
         s->machine_done.notify = smmuv3_accel_machine_done;
         qemu_add_machine_init_done_notifier(&s->machine_done);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a8c49a48ac..ee1453375f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ats == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ats auto mode is not supported");
-        return false;
-    }
     if (s->ril == ON_OFF_AUTO_AUTO) {
         error_setg(errp, "ril auto mode is not supported");
         return false;
@@ -2172,9 +2168,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
     object_class_property_set_description(klass, "ats",
-        "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this. ats=auto is not "
-        "supported.");
+        "Enable/disable ATS support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to off. "
+        "Please ensure host platform supports ATS before setting it "
+        "to on.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-- 
2.43.0


