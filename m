Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A10CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMstl-0004TP-C2; Tue, 12 May 2026 15:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstZ-0004Qt-6D; Tue, 12 May 2026 15:35:57 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstV-0005nm-Ra; Tue, 12 May 2026 15:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv+QZQSKqse4Bpry27WNfqiI9ngk6ZSErSXsMmf4hv0am5UeOM9yCbCNqwWCfJdNUikO7OQzF/TVrRkljZMXXLPWN3tQdTciG8ZAiGgnQypkn6BLX494QKpSs2ubaciJFcCD5FQkbKPMg8KfRCLD56f/tVfo4lMHKXOM1hv9Yxf6oVeWrn5mKgw2+LA5atAXPK97yN22xmYTvFW9jljesCqLoArLw6upnDPN0tEjEI6T49HI8oRI67WaMFE8tvauQoKZiqZ1dyrtfJnhaIeSx9xps7bBePz5hBK1huAlZ2SYHaOGgB9DmXyRyVJx/2aV5VzM8L8qIBaIIKSiT6SycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkZ+rbB8L77qcfJR+71L0SjzY8/C7UWOQOnO4mwZmvo=;
 b=XD6aTOpVA2vffw9Bga+/10QPazYfIgEsH/Tk612Bq0DtKazd0BBsI4n0fOqoqbMVn+C7hxAKB791/fHvInaJsSUayyh6PCbBZx++/G0NwgTCow6k+RNlUbn99gRJvCrmP3sKUZ3zOw6ZyV5r7v1Q6y3TxnTzKweH7HDB5yx57o56LSuzGJbeqxsO5NQtjdZYO6vS7uV0RB3ffbrR8KNVh3x+sn+zqTEQT3e9OsvShdNWxV2ZxkyOb1oOfM9taQSbur+DKte4TrFeteJFmwBEosaFDeoaP+qva3m7IMI6wfmwAeWdSyphcntggfVYNg909Pq6bci4IxqAFwbco0Cbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkZ+rbB8L77qcfJR+71L0SjzY8/C7UWOQOnO4mwZmvo=;
 b=oKUYcj/pV4ToKiOxfz+h6GbxlabzK+E3tNQ2WqcDebfrsGuKqlMV000IBMm8/OYQ9bURbfs8kBfyQl1Gn4zpDUHa/zQzjpnCcxwxslXs62sc2OwdUE7ndYqT9IIv/1MnMe478kUgIGBYNh2DWpx0AOEKjPyACk3JYMvWwvA2bEG1iL7SyLZmYeAoLA/cvkBzLmEqFMVXEIueUqtBE2mlxffWGLnqZBS8uETuYSYWeBSvOakS+8MXLZTbTaw6W9WXSO9DD6VyLfsuroUWQXI5OdMSKoPoNuQkfaImZZmGaYEJKH6ou/fFg94m4m0Hg6/+r5Psuh+dlGDxTwoUOf5LLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:44 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:44 +0000
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
Subject: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for "ats"
Date: Tue, 12 May 2026 12:35:15 -0700
Message-ID: <20260512193520.3109172-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 79064718-bf52-4f13-2825-08deb05da8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p1fWo4NLUKH3L3RtXBppgPD62+zROANOG8+IoztT8PVkhvkSt6XQn6JTtBAEN4Ntke0+1MROOm0Lwh/Fa1EFVRJ94mMcPzji8HTJzKwu82vdVMVll4McU0hYWcdIHBTLnHGfBVMiObAOYxLLefTRCUIstzWssXFrXh5loBEAhk07vpo7WYqxIiIu0tSD9cMxf4vBTNl5Zn8CLbhX1O2vbdj08LVLC3O5NIzI/IqQnw16dY3PxQfh1OatItTq7+ga+Y3Fs518EZz0AW91rFt1iOLH9DxaF/gvL8jdTGjsHWm3kOaGoOEdhqL0Uj05N8RIaL9VIUo9c63qz523qfbG2zg0l3yWNLQwHvkzTiJssBQPv+H1Xk7tpeTNEAxptwg0H0dIW8MAmlJgh78zD+N23fWxupLd27wLBseIENEJ9W9wfLlxpabtuPzETu/WuaVIXEZ1dZfJwGh13Z/QWqJ4d4ilujeZShP1thOs3l4kpArcrKEM/CiebKiPIplwKMldD6webVdL61Mk5bA7x0Ruhbc5F5/RZmIqjh4k7ciVjHeLTF+vGMbttwILcKgvasey/Pmu8hWa3IJnfXdDF0oALInGNA7lCQIVX4V1OLwMGH19YsXKb8z4kCBJjMwx4nUyolkfy+CeYK1i5blwj8im8yS8noZ6xF3hJoQms9sNM5YJIOP7e+8plF1dpj2UXOXA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPH9hhF3f7R76eG1GJFvuGLd7m/2o+tW7f5viW65n3nPYuTNYnOS4yiYFtvs?=
 =?us-ascii?Q?oi4ZYTVsfcsjZpVVrAoXsWCbzawoRCTOHCJft8whF6ZM2OnVI5PtotvuJvp5?=
 =?us-ascii?Q?VWYL1mNS0y1fUSZzYWG6lva8VIp9go7V/hVm6Z/tQHzdH3+lutJ1uwpCZQ0s?=
 =?us-ascii?Q?Dw/4gl4IVhkqoLNWRvkSZlumr47xatNnvB9QwqB/xDQD2HFbeF3QigP7SQfs?=
 =?us-ascii?Q?Mrz6uJP4yRm9uab3PmLzJstQ9A+RfBCXM0n/RKlATQmu9JUYZZJUwaO3uvqx?=
 =?us-ascii?Q?pEDM9y0KRfktfuAfFXAUnyg3XfFuCw49T1c+NAwCsYishf+oJz2oDskngi62?=
 =?us-ascii?Q?GLG70ZJjRDeC2DgF68jRTNQT77uPVVFwjQPDlwM4LKzwtv2X2GTTA27RXg77?=
 =?us-ascii?Q?LK+2jFJg+egSeXKYz+x4S2H28rGFKR7ouvQTEClWepC4K8AadU0IT1l0ABrT?=
 =?us-ascii?Q?t6iEyaH3xPJ3EDdoXz31CrsdPYU8X4Kkp6L+EFV2pErjHDgCu4It3wGJ59L6?=
 =?us-ascii?Q?ul9B78IOz6avwIyEoP1aJtrhIr8wztX+sp/0W5pNcBHuDJmw/8LCp3OIAHJX?=
 =?us-ascii?Q?rhkKSTiih3UMK6XkQH3lPX+Ozi0XykOwOqs4LmDuFvoCEWSh0Iw9gpsVW5+j?=
 =?us-ascii?Q?Lizrgnmlx2xlidMku8CxbOaeA0piDjVYj9RB96MKUsMmXNk6D5aiqWwz9WUm?=
 =?us-ascii?Q?VzbGwTqTr3T+4uELZjFHptLiDJwaRS/Pq0+8fnnCZ0E1wp6p5PMNJmFEc9v2?=
 =?us-ascii?Q?NglvA8Z00u3ir4/el9wMQaU2khB6mBM8wynqLRgRV1k2aGLA0+gEuSdORboY?=
 =?us-ascii?Q?0T5B96f9zVZyv2HNA8rTMpBwpU/5mk7y5DBZoydrEqjPpBY0JKIT/Ks9Y96j?=
 =?us-ascii?Q?I8Hz6z+qPZ787GyVKFJK117hZjeoRqPfTXcTUxLKf4cbRlWRSFxxR8C6ie+d?=
 =?us-ascii?Q?0YGJrFofqC1R35Ro6kjYN5IHEPNtxqvurcnvwoyzFty9qkeNvWnh2KhNqM/U?=
 =?us-ascii?Q?gbYXfFQd3zBWszwTGi1IIqDp7thGTERw+prOIXa85A/UPZDYBrbdUXT5tLes?=
 =?us-ascii?Q?7laaJQ07s2AcmG0mHnm0qq6nzD4eqSgpX/LEbe33AyJod8q6X/+AP+e9i6Ow?=
 =?us-ascii?Q?Sn8rkZWwWNrKbXS/HCp9XVvU8H+XB54IUaD5cN7riQQWbivrmAEUCOEILhPR?=
 =?us-ascii?Q?/zCZIxj27jMTRzfiCRbyNw2PckJVkIlkx8Fop5Rp6qEFmzl9R5O2gizu3DyF?=
 =?us-ascii?Q?pPhdtCwwTio/3ClaLaTXw6cDjIJguw3Tsu8LMcNcTwLGUJf6G8Qs+bPe/bLx?=
 =?us-ascii?Q?kCOljYOD3l9E2u4hWIAzzsIP2m40SCp6hT2yx9jbD6rbmmLs1f8Gpykeluu4?=
 =?us-ascii?Q?F3IixQzVDzsY+qbk2scYtWhISi+4L+ahEu0My0Fgf+5b0bO/2eM11QLW4WAq?=
 =?us-ascii?Q?6KwCJJcwQ+w3h/woUADUzjrOcwUT+Ufot3F0vnv4E/xUogLaBS16IQzGAZls?=
 =?us-ascii?Q?fiUzOXc7eCdOqmArxdYE9DfBpQBZTvbcqvTAwwMshtT51W/SwV7Ax6dnDb/C?=
 =?us-ascii?Q?+mVj6HoLXNOs+XUAjixNR+siNdIXtLtXi9k4Zj+wHQxRIB1gSBOAq+x7cjnY?=
 =?us-ascii?Q?ZfdaH95S/tfiBxx9L/pfdOMGjBPz2oKaXxg6t6jm5qyUQzqKfwAiZpRZYRcx?=
 =?us-ascii?Q?tU7V5y5LGvLjQVFgXz6e6OYcWC6G4Eubhi8/42Pfx96/eKhNofM/nnM2CUDj?=
 =?us-ascii?Q?9VhsjaV2aw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79064718-bf52-4f13-2825-08deb05da8d2
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:44.5460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBNmW2uCFt4qLouv6GO2/vcWyDc5OXyjeXR7WC1NmIjCkmyFX8/YG8Zf5HMIU1YjlfM34lQBVwjY3LToVcBEPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
index 82c0800f4d..9fbd13c438 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -52,6 +52,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
         return;
     }
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
+                               FIELD_EX32(info->idr[0], IDR0, ATS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -964,6 +969,10 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->s_accel->auto_mode = true;
+    }
+
     if (s->s_accel->auto_mode) {
         s->machine_done.notify = smmuv3_machine_done;
         qemu_add_machine_init_done_notifier(&s->machine_done);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5c2855c377..e558f09652 100644
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
@@ -2170,9 +2166,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
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


