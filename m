Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0380BF483E5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyE-00022o-OH; Mon, 23 Mar 2026 14:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxh-0001oC-VG; Mon, 23 Mar 2026 14:25:15 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxf-00043g-9k; Mon, 23 Mar 2026 14:25:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX6/Q15may21HZlMWeac8w/coLAofjOYs6Li5HzVNR4mIvtSzCl8Ql+c/d1TCnI7f1esjcHkcBVjq4A3d6S6bKjBrF4i6MUkYQWA4A1VuRLESmWKN95rfhFqXoS+CfY/HP41VyDOn3/XZbCMuShBKGccNdkPGp01WCP2WNs2p2R3L9ys1Cy2E3UNf48I3vBh6iwZGnz2zay83rSw63CAdTs7FapFTMiPcTxcGhqBiOsdJif8kXgt5vcLDaymrBZ3yU0iQZz2pfNLEKIu4Rdw5Qe5ljB0Frflt9eRP23ACnxjnvt6UyQPqVRV+TdwltlM13YcMcWdps3cMcTSeTsVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUA7momm04Ldf+ga3ygVr/UlG098QI6ny9D2P61VRCg=;
 b=siHRcx4vjxCUKClwnygPk0cYHb5b3t1GKG21Ssi72SCmORNJMLzDik6yKj9ueRiupbwzXuf5aPNc5VsvNJ6njTdQ0TSnzHALpujmuFHxZ2z4ktHR+mL4huS/NC1TRMGEcoklTUR2VKVyARJ5R9ube5U0JJMQOLtYDLjwgMuVqQRVIVIXx5qwi7DCs/8G37M8g2eyNhoEHHtI+PqfhERirxg3/XdAABJzkXkXN/B5z4dYG7vE8JzMaOYjx6nGpiEAdkizN9TDGYpnU9i9WiPVPp6ViaO+SyV2CmqPi1XkS+pm7JCAne0Yjd4cpkx4LFvkr8gP2By+ZA/I9rrDCKfFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUA7momm04Ldf+ga3ygVr/UlG098QI6ny9D2P61VRCg=;
 b=qSy3YaHsYpacFcHNnAHc/HpeVreVsMZ0kHGD9chQT+PonhzddyQDUyLDdTxXYsmUv+XkxSP9mdBuel5HKlOb17Vg1uAI82uXTJflRUfbVMtxsEhzVKPH7ZqkNIJAd+MmntMCE85qjZE9wWh8tjZ9PjDwlYSc0rQMiPT3FuHgolpH/GjzaT0R8bigAXJHxuujNwaS2lOTKNP5ts6YsWkv7bcGPGbLO7z+Vw3Te8wJmsmObH0kmMQtZmdCQOxJ23TJxcZG29Lcgp0tA8/GMDjMAZ2yT2b4im+9/kU6/U6UdqwAd5f25bcXK+bCWzdBw0N6xHejgCli8UPC+JrssOlX5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 18:25:04 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:04 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 2/8] hw/arm/smmuv3-accel: Change "ats" property type to
 OnOffAuto
Date: Mon, 23 Mar 2026 11:24:48 -0700
Message-ID: <20260323182454.1416110-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c7b053-145f-4f25-0695-08de89098089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /2njaOvpl//EwtUenbRuvBvRTmPHL1XFWMkS/jCkzVXR5hxdJYBrpDNfqajxrwg52tRBQ0TWM9hOrlHW6h3/jmz3d/jmn8mLHOn9OsUkGuUWRbzNugBPT1jqm98j4UVWUuYPGCOp9uoBjrum0X4TJm4pCpQFJ8nxKaBGCmPVaAA/sdKvWN5m3H5FKyUQJDlcrl0odkfTajEXE6rGSSG7mkRw1H6zsLYgkkeCGzMNwQEMFXUlg2NwJj7j/3QtAWBaKG6YhRL8Q2Y1FyGgtazFgtjrXe5uD0MVN2tqEUV8F7r3mCGui45S2O/bl24X9KeCE6YTYip+QPMJY8zltxn4VMdDaLzkV47cWSIbGo1doKsxpxZF+akQ8MtRE+IPqT9oEgZ1D8YIqE/5Sv9KMe5V3Y5cjf3hLEkEl1dpIulZaijOmhN7x4pIcPplgHh404KM9GlPZ2DgJNOsXR0FVOhHwpzC//7BpThoJeFVyQYlh6piikGu+zje2VIEGHrhUEsKnd+oV/kKSUMd2ZBtIt4kkr2miOUWB7Q42RVGHwR0tgvfOs4wp0ZxZIrlVIA3TVM/BhyJeWGexzcWcT3quo6a/K1cE5m7lCFCx/wWyWEmNpe29djqIiEYs4JOmjsNQL8NcrG5rF+oBj7GSmwn+5sefwod3M+EpA0WGoBbVzYgFfS11nblNhGB9X1rHgV+SSUKIsDmdsLG1u86S+YEvEgyYQZzSUjRmCOzfns50UycPvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ezxzBLEJ6YmS5dInXYesJ3aa4eihVgnJtnXumoTEBtBf8t8xaVQ+bAyC4Bdx?=
 =?us-ascii?Q?ou/YRtI/MNnoBM591WHH35fz2xJOy2NQL1SMQxgmKDJNSIeUWug+7EfrHH1S?=
 =?us-ascii?Q?QAX4HInb+qsIux+VzmtKRb4HvdzdvmhNFWlzslLQ9/jm21dLe8bLT3xb7cnc?=
 =?us-ascii?Q?pGfelbnZvuXVrXiSNdm5qeKfluySkAleddNmqI7sMo0s2XtpcwrqsFR7OsoD?=
 =?us-ascii?Q?9WYc13O2vxxMGVIPJlkLv46ALT1cGfc9Q3oCfcO54dpg3mYvz92Dbz18+cdF?=
 =?us-ascii?Q?TU3Vblfn3SgfBNmGZ8cj7iDPB1lmH3aD7XJydbknjGTYtjS6yMPwIzD8rUgH?=
 =?us-ascii?Q?zFptvkwX4cis221FJBMzCrnnSwIf2bifJlnJ/O56vScCB7Xt76OlCMCfEEeg?=
 =?us-ascii?Q?BMpSXeC5Isdt4MVfv6oqhZuRLGD0jxg3ZJ20KaweNJvi6bh52t/cmvU8KgEz?=
 =?us-ascii?Q?99QpaK+YhtPq+1rfhiPBW0cE9S93n9dpy5dJYFCs6ektE50qpQ4S2t9Qd0Sn?=
 =?us-ascii?Q?xiBVr1NcYMUBZoena4bZS5mr+KYgPYJzl9dXs3Dv88pE+Ad6yRzqBsbtI719?=
 =?us-ascii?Q?wV2ossP1PwGcU0EXO2CSgNoimng8JBz/CC1RXp7h/xu3wSTtbwhLFVTnklnN?=
 =?us-ascii?Q?bcuBAUgwDMdYE/c39m//yLs7gvrHEgQ0G+ot43Gj71ouTY98xWFQV60hWThd?=
 =?us-ascii?Q?89WqstyR/NSeyIFuTzYVvhVcHOIFAGpNHsRyU0dbnj1GMD7FDfgZ+ETBzGfz?=
 =?us-ascii?Q?UuQuyoXpB1QBrasGPPeNalnn2g9OyFvRtrk7ElAx423ivXx0eFgIc3OM+/lN?=
 =?us-ascii?Q?fYAH7NyUwguQpZsUarj1V7pCi58PP8wVK5ZNYHntrH2GLadSme991Y/p0Rfy?=
 =?us-ascii?Q?prvLGsO0s7RqNMvBDBJbFVUNvw7P9RZYsUrgAKgwKmXioKkS/eUHKfeiMHdy?=
 =?us-ascii?Q?DpdnXv2q9lbNXjmhxVfpDMNT4VO8fgsGDRm//+oh1roxfyK90NHzMnBmyU5P?=
 =?us-ascii?Q?gzWYrBsPHf1Jwhov8dhZnRP1+G9gBmKW/LT74+jqGHtkZVujLodY9Odxy9i0?=
 =?us-ascii?Q?9a4sw0AZZyq1KBMS769hQVO/QrdIQ6g3UC1tlF+bYUYeQkFmh/Pu3tDyWtza?=
 =?us-ascii?Q?//pxodAmm/qHeesZVR996sevdKGxCFhQYIW5l+YtcpfTSQ1f51G50Q7IR4it?=
 =?us-ascii?Q?8f9vK8L1tx74NJS99gzzbH1oE5JY+nwwk9RtakbYneCDOqjtmYNuvSDMDYVb?=
 =?us-ascii?Q?zY4jEoT8/MGcZRgB7278ntbjSuC/uFWypOUhkHFnOM9CKL9yYhoU6yVZuEgD?=
 =?us-ascii?Q?0394m/pB1Hs1XVK+B8yhEFYJfGNl6XJv89YNBUJWScM7i9eIp12JtDTiFNUj?=
 =?us-ascii?Q?xjf5p96XFzpnqN6gvm1eMmmHyobNb9+S2J6bYpLO43xT4frWx2hJSuDJ81Q5?=
 =?us-ascii?Q?Z2zxcRsy42fo+vrDaFUP8Hb34HlnITRL/QFXO3YnxFauBvjHsSHNf5DYdvRw?=
 =?us-ascii?Q?uOiKDeg5moDSTx6R30COzTc9mCOIhlmauIqtll5z6Nzkt5ZPaVdKer9VLcx7?=
 =?us-ascii?Q?FCxNtF3RiLFKNn9u5PT0m0Ca7hBDrQ5igEMDHzJQLAEjMQmTJLKXZOBm7GP7?=
 =?us-ascii?Q?p1IJtExWrYS0DLpU0N4DBTOM/g1luCwoCJX6k3G+6qUDUWZ7exwTsqMc424W?=
 =?us-ascii?Q?fRnYj+/JewZ32eXulPfLMmrbSMTQMAn9bhH6gj6RjupdO0fvlhVFOWaVz2Pw?=
 =?us-ascii?Q?OZtExD2eAA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c7b053-145f-4f25-0695-08de89098089
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:04.0085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSPDqR3HIBuCak/pZgFOKd+SFCzIk99y/RgjG0ieAfAtzPnF8qb5K7gxTpulY402Ouc/j2RHzw7PQGW0nnOBMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Change accel SMMUv3 ATS property from bool to OnOffAuto. The 'auto'
value is not implemented, as this commit is meant to set the property
to the correct type and avoid breaking JSON/QMP when the auto mode is
introduced. A future patch will implement resolution of the 'auto'
value to match the host SMMUv3 ATS support.

The conversion of the ATS property type to OnOffAuto is an
incompatible change for JSON/QMP when a bool value is expected for
"ats", but the "ats" property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c    |  4 +++-
 hw/arm/smmuv3.c          | 17 ++++++++++++++---
 hw/arm/virt-acpi-build.c |  2 +-
 include/hw/arm/smmuv3.h  |  4 +++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2bb142c47f..f21a6a9997 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -827,7 +827,9 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+    if (s->ats == ON_OFF_AUTO_ON) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
+    }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
     if (s->oas == SMMU_OAS_48BIT) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 068108e49b..a683402a0c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -317,6 +317,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     smmuv3_accel_idr_override(s);
 }
 
+bool smmuv3_ats_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->idr[0], IDR0, ATS);
+}
+
 static void smmuv3_reset(SMMUv3State *s)
 {
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
@@ -1966,12 +1971,17 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        error_setg(errp, "ats auto mode is not supported");
+        return false;
+    }
+
     if (!s->accel) {
         if (!s->ril) {
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
-        if (s->ats) {
+        if (s->ats == ON_OFF_AUTO_ON) {
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
@@ -2128,7 +2138,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
-    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
@@ -2160,7 +2170,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Disable range invalidation support (for accel=on)");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this");
+        "platform has ATS support before enabling this. ats=auto is not "
+        "supported.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 719d2f994e..591cfc993c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
+    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 26b2fc42fd..ce51a5b9b4 100644
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
@@ -91,6 +91,8 @@ struct SMMUv3Class {
     ResettablePhases parent_phases;
 };
 
+bool smmuv3_ats_enabled(struct SMMUv3State *s);
+
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
-- 
2.43.0


