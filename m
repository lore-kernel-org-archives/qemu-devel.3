Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02F9CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMZ0-0004vh-CS; Wed, 27 May 2026 18:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYl-0004ng-L4; Wed, 27 May 2026 18:17:10 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYj-0002I5-CJ; Wed, 27 May 2026 18:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6NM9BKzxnFQfAkORg4QnQTwGWlgn/y3Mc9SrcXrtc1U51cd0br3vaFUtd1ZkEKsi7PE+PIFcvCn95MdJiRwdYrxz+7e4dWiMQ+xMkdWAVseV3etzI9w2EqQPpsHONke5bBtUTk0sGJZLFyRJRFMYXM+lojcqVOk4o8b5uIW+MPKkUZr6vofunuTLJw4LhtM6rcDo1TQrPcUEoe91j6u2x6/acT2ahkjdDt7GxZ/rVtO+oIXfbAeMpRDkt0uzoDutXqYNsaIaRFzdA9Br/3JnwEdzMhxw0c4ba4MMXtTzlzUdMpdZy0jvjxegiZanxawDb3APbj4hpi5+jSoxUvlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCao5/XERfqoyqg0whr0aClc6KmcV5CYbZqCxpvXsyU=;
 b=wE2yV5w2z0S2UmPtTVKVw2eGiwx6a6QNioXBoezslDuXyM8aY1jR4WV1PuMpl42dqJU8eq0TIA1d/N6ZimLEZqnoR41sGXgYMxjeHi6nEl4vByvPQveInXUUsUgAQ7VvBT+TpOsP0+EHQARtLmkCFyi3e15RuXgrwcQD22VeUx33o0B/IFWi2O9Uxq7vn8iXzVhbRNX6Y1FbULfdtg18Z8penXAatHxKCV7ipejPPxgUbjzTUxISFWXyLVWydYLvRei0DAwx0CSDUOB+YJkjk0TGmQ9o4ydH5b4AGO2C53xKz+5ymDTk9EO+623ZkA0yNgvqVZ61a2Lk0DT0mxBxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCao5/XERfqoyqg0whr0aClc6KmcV5CYbZqCxpvXsyU=;
 b=KrjmFcqfwrXDVIlaKIksHWWBfVcFW98lDpiG6W2T8+PxzC+jXMxVkbMXlQz5tKEo02b9VwaA92o6FXBM9s6ib1Yob+7Dsi98mzQsWpxO+GLEHaZE9qLdvhGuGyFuyd7qmp0hkDpFYzABPsioGDFgjdZAWHPO/WTb3wsZuPu+N0sKvuoQflhczdvboZ71N7FBZj803leKSPUaRbJxbe687f9KWRT8ZL9ZSGkbUGiH2jh9mKyEPW7aNP2iU5QX8QHz7ve+l22QYXQbgql1J3iTUOTBGb+ADM2DxO8L/4MgLMS9Yk7eYLt86c+gEDjbcEvzgepAKczrcGuk4C8va4WwAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:16:54 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:54 +0000
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
Subject: [PATCH v4 6/9] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Date: Wed, 27 May 2026 15:16:28 -0700
Message-ID: <20260527221631.612026-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: f1635b0c-a96b-4937-784a-08debc3da8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Masl6rX8VUMR81/ZbJI1eglbuQoZLPH0KE4pg6AL6VCFxTo7KkW0t+Xc6bpeVB+cB9X13tc9nG8jYNKHP/CmRy8wc4I265/JPaB8WSKiJ4Rm7QFj4Ls8luzNXSaXI/k5GbhvAbonWhPLfO4ygML6ZkrGJ08OwhABicfJkIQL3mijOEqZtefocJskVWptQPwJbGmaHbEQgvYQxNBV3npDp3Lm+r6+lKVErKZ+YLsPtfsKCVD1tPgP98u1lMntv7f+VRjpa0/tzkQkRm9lYEz9jp2ZBqzwmgvB40FxFJ//J11FGgBe0TfH0eRKJ70VMwHjgsTbBa7SxT637zFK1hzFchZ4E70//czCdlT4i7AQTSzLgd9PrGoPLjavmGO9EzKkcFI032xaDT2PpCCpMS4FM6M24XJdtFaWqblawr20gT1ol/kOSGA17TWaFloipk254v+kEbUta9eRu0AEMfxTKkJiUGTQ1cvS6zo0Tp+c3ms/aMiMU872mhFcJKtkp/wmffltO1IdJ6o7AzzqM5pBSqa45mevCYp4fJNU9RxaLkRc+0Kyh6PRH2LyPJ7PVVFW9tSYPKGinJhG+3mDjfZZpSSBREmbQNwxhQf26+YbuMdN6XxCbaJipCFQJaz1d8hqEsB4fz99rTiRoNJr9pp57N9wuvGsmAsIi/0mM402ahRCFagzaKS0Now5dK8IiIPb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZMjqrP83Qfg5iE06uwkP7wdhxEa54HP5Jfy6eJvkuhhDiuxEbQhtVwXleWU?=
 =?us-ascii?Q?UgWzWRtyOVV4+8Qba93tEJx4H+0AcjNGITRs9VagM0SUylf9pP4zwoTxoJTE?=
 =?us-ascii?Q?+n4Ar+xxkfroo/JkM1twa8qnvbQanc29gxGa1x3rBZ/QgH8EAyIMhOg9q761?=
 =?us-ascii?Q?7Ydvau1IzjV1LCTrUS7EszYEiowSENhqO8rbFqTlEZCY7/JbOruEpw9OUBtN?=
 =?us-ascii?Q?dCFmXwueX1PMZJJJLTH1JCFuwV1GHp41fl/oNoLOtgPzya95plZZ6prDB2tp?=
 =?us-ascii?Q?6U/gFt1mX451TN682luh95K6b/ZhF9vf9XN6FfhyNwBgO+kmD2vSnbxdKicA?=
 =?us-ascii?Q?8xPG4e9PG5l7N3zgmlg97zwo5MZX5MjklreEDHog+8tjA+NR9AI/PAQUe8MV?=
 =?us-ascii?Q?ifyK2tWvKBvwqPnB4JO3iQSpeJ8GWRc+JOGtD1KTCZwH/AuuAstOA/KvBkoR?=
 =?us-ascii?Q?GJbnqHKsw8xnE6HIhAR41EnMtn26KxwtYWr6HbWS3pgeZnYC6Q73VrrvJXVE?=
 =?us-ascii?Q?yz7rNuo9mCI6YBmeT1bjRch2PBmEscpBzeO2SFh5oHFW4Uaui+esJfV38GLH?=
 =?us-ascii?Q?y30eGepI/Y2aowYzgC1zLPJqh8MB0cbVH3wtkJ3gTQHDwW3mIipRxdyohO2I?=
 =?us-ascii?Q?8Z7RmGjaMR7NvSQSMEheefmTXzyI6gVcZLIjHl46sOVb27kEWlwOBpbPPzYc?=
 =?us-ascii?Q?8U0LUeYPSIbTA0KmRh14GNsDYFrd5eu6qqW5I6ysIZdM5eMYh5u6ihQJi97C?=
 =?us-ascii?Q?TEWR3X+CeT4682TBUlRkF2je2NRujyH4h/jalIdfWA8wSD8ya+t1mN7q0rCw?=
 =?us-ascii?Q?bULt7p0RoCpRpZUGBLasjyx3PKB1drFwAwQm7O1enI3e/lKc4v3JAH7+ZJQi?=
 =?us-ascii?Q?86+yxM7jEKPerE8U66n2q3D9Td+i/J+O01iyo/YXru9augXXLkPW/5v5aujJ?=
 =?us-ascii?Q?QTfBxXe9hzZGSqlLn7vZti3+cCuVr65AhCwW65rb/s4Q1CNOItcCZbC2tOPU?=
 =?us-ascii?Q?z2lMuYOkGcj6s3GfdlOKhUvoZvz4cmXqWvgwxgUw0TjPjqFCDdTvggV7Wxbd?=
 =?us-ascii?Q?ftrrbAK+Eb8B/ZmmBR90Xa0hvgt8CTnppUhT/+KkJwg9QaAfpaKehK7F4IEH?=
 =?us-ascii?Q?3y0ONOtCI0X1/tvOzD73S9ZfJHX6a1vCbPMSCFtXLgy9ZQSqQPkksohVJL2b?=
 =?us-ascii?Q?T1cGnpK0J4FsFUjmP6xyrkFvgqf4cCo3KJE5Ps8h4naBAdXltleguKpUI0pj?=
 =?us-ascii?Q?VjUvL2G1Q1gcfy9W9GekL2psC7brlxixJMvV3KPfxyAYH4YTNndsY/oi0V5O?=
 =?us-ascii?Q?R9kMMe0+WxVERUvj4xtz7T/D/M8kp1/MKaopNWVy24N9Yt5by30gkN/JZKDH?=
 =?us-ascii?Q?RllbHTj27hq1FDfYko4RMY6MUsAtjMspuD4QLpyWyPqsG/i/YmLwtkC82GZ1?=
 =?us-ascii?Q?DjCB8kTPaM0QFZUAF8S73aykj2wkx7U4kNRAGcwe+efXENYJnJUY7GOeCA4j?=
 =?us-ascii?Q?obhhFNCuKQjXUjnMK1E1qNT5pSk7oksyOJ9r0sJL4+3vLq15jGFJzcznuxOQ?=
 =?us-ascii?Q?6EzgW5DEc13tvTOxUpAij9oqYhKlkjS2U3rpGQneznbH0RWIMKKTbTxuLFwf?=
 =?us-ascii?Q?800XBRocfA2oaa+aNI6p/kCMWW3O08t8qpQVq1Fpsfxn+E4skM/Bw7YNiy+I?=
 =?us-ascii?Q?/9tfSm7BIKUe0hOT8ox8B5HS4Q0Ykk/dPSePoK5H57PHSlgKHkKJ1Oo+qp6Q?=
 =?us-ascii?Q?KMjzS4yhzQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1635b0c-a96b-4937-784a-08debc3da8c2
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:54.4929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /G286UHIi5AH3BP/FQl1HzbIiQpdaDvIQFUmlt7znHMM9exqJdLCCaJciE1J6jjXLxMiIDFWSKaP+59tCoDJyA==
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

Allow accelerated SMMUv3 SSID size property to be derived from host
IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
retrieving SSID size from IDR1. When the auto SSID size is resolved
to a non-zero value, PASID capability is advertised to the vIOMMU
and accelerated use cases such as Shared Virtual Addressing (SVA)
are supported.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 17 +++++++++++++++--
 hw/arm/smmuv3.c       | 22 ++++++++++++----------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 25699a1317..3f141991eb 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -63,6 +63,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -823,6 +828,13 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static inline bool smmuv3_pasid_supported(SMMUv3State *s)
+{
+    return s->ssidsize > SSID_SIZE_MODE_0 ||
+           (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+}
+
 static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
 {
     /*
@@ -835,7 +847,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize > SSID_SIZE_MODE_0) {
+    if (smmuv3_pasid_supported(s)) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -972,7 +984,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     smmuv3_accel_as_init(s);
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
-        s->ril == ON_OFF_AUTO_AUTO) {
+        s->ril == ON_OFF_AUTO_AUTO ||
+        s->ssidsize == SSID_SIZE_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5edcd73fb9..2250a7361e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -626,7 +626,10 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
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
@@ -1965,10 +1968,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
-        error_setg(errp, "ssidsize auto mode is not supported");
-        return false;
-    }
     if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
         error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
                    "OAS; other OasMode values are not supported");
@@ -1989,7 +1988,8 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
-            error_setg(errp, "ssidsize can only be set if accel=on");
+            error_setg(errp, "ssidsize can only be greater than 0 "
+                       "bits if accel=on");
             return false;
         }
         return true;
@@ -2175,11 +2175,13 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
         "supported.");
     object_class_property_set_description(klass, "ssidsize",
-        "Number of bits used to represent SubstreamIDs (SSIDs). "
+        "Set number of bits used to represent SubstreamIDs (SSIDs). "
+        "Valid values are 0-20 and auto. Defaults to 0. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
-        "Valid range is 0-20, where 0 disables SubstreamID support. "
-        "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support. ssidsize=auto is not supported.");
+        "A value of 0 disables SubstreamID support. A value greater "
+        "than 0 is required to enable PASID support."
+        "Please ensure the value does not exceed the maximum "
+        "SubtreamID size supported by the host platform.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


