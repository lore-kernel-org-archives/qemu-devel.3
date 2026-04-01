Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22E210F92EC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzI-000816-G5; Tue, 31 Mar 2026 21:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz2-0007lH-SH; Tue, 31 Mar 2026 21:03:01 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz1-0007ek-Ak; Tue, 31 Mar 2026 21:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3mqoq3J3qWTjUnD3uZrToOgIyzr1hPFoDmBsImfe/jkUG76EJgAwqG523x8NBAjMPAYZdwFbfl/JtWcXPHVctFqI37dmFhInwqCuulociWOpRBCff34Mz+ACPQePbk/a27tkQg7wvj1ApD5iav6+AZtKIMEX7xH5PxxNzN0Dd/HU+WEQDtzNu0zTctjCGF4QvpRI3t8x4h7RGQlkgVfq4xu9nc0Ia1YCpx/tJL+p3Eh/wjAAb2qnkJO3uNOah7Ll/5Qc1vXNTZt1zBpmaOwF4wkw5BybCBnPmYhE58HklcsxF79/3U1iiZDDJPkIT9R8WWtl/bEmysRVOXjZYUgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUHoBIjDprUNYARsb32QzIyv8QGHcCNHMsyg0xCShXw=;
 b=J3WSf/+qi/9jipWCwPD3pr35oPIjjPZua2385yyKa/UQKmGt0byd0D4oPpTap/ce3lGpgPH8Jie6m0QJIrRjuEL3Fd/U+EH20ob0/PAOG+vUYv5WUi9ENg/kh3xlWKT1CZ/99ddiAXZL3odJpEM3uROQXsNBao9CHCKq8VmTx63+AXsEo1jmgb4VhQHb3nMcuAnxgojyyZMn5JCMfspjyx/epOdDr7kjmJgm/exmD33lXNUw5/lZfkECq1KTcqKPyrGhiHerIgrv8LAOPAsDTQPNuZKudVvDrCcDFIsGcMzZy2UjA+3Q078HzGW8R5o0xooZXXopwBbdEAJNyHa/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUHoBIjDprUNYARsb32QzIyv8QGHcCNHMsyg0xCShXw=;
 b=BLQXnIulJWdoL+QGFwY/wo8Wl7h2hgOyxHkvcaZ8g4qY9nW+tonkWVm6g3oTAUQtwD0IWldi5JpDChOH+2RWdgzNzSniPqpiIkZ0s1aASSEpekWGsbV18hQNdfF4x5Ucm075VhzTXD4f9dwHTUE9ea32OqSJoPRqYVem8/IRUE23amBy9VPLhNDqVQHUKcArJ3yk0b0SgTcRbaKT+AfiO7ep1IcQvlIC2WefsXFft5bTzQiBsyu+9xic01xCTqza3voZy4p0osSHoE6zl1MiLtnkyP6q55snQ0dqxFirMrt7eqwPwBRci95GYUjXyvd0qmrcM6wGGbzZ0+BS+dHbNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 01:02:51 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:50 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for "oas"
Date: Tue, 31 Mar 2026 18:02:29 -0700
Message-ID: <20260401010231.4166776-10-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 6437de2f-b838-4967-374b-08de8f8a65b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rA1fzy1QwlncBjGnNIfAkbszjr0w63DSOWk/zN/PlIWMscu1zFE9yS9UbVjmGSKTfhQaYtKcRWB2t9e5cyI+b5ope6952OB0Z9TDIyqALdjXysGb4oPPTYsC/iRoSMifNgjsBYgmNMuiRJmX9y7pWcHTkWN8GKZ4lPjUtU4rgpS9HjdLPhiHOEM4gPZQCO0kgAihKcf4fctiTsTAHrjqGIJEvIs9RkiianjdfS4EORCe1YHw0e0jb/TKburtGvctKeF3WgPuHhtx5ZhBmoqeR4pP9+94ysjwUtIiHUKrhaVjkcLPGY6ZNL7j0MvIWrfITHf4o1db4FKMmzt9tfaxQWmR4OpMCTfCSMUYqF6r61BLc8N6mVrWnlDBzkpvh8/QzDD7swaSk9MJwPDP+1Y5yjomg8Ph+6dLK3S0mJcZ669mhjZas+hSHIZfnnyypu1POGMvjcFqppgmJBNRobW2COj9MWlrxC7jKfiKFJgCzauOiMj8HOLtUTOCE5MWBPJWhdwN4M1Z+edUrmby50gBaO8V1yUQMkbp6t0NN0O9DpLBVG1FnIFSZlD59bEbbBSD8U+4+xOKr8JIwoSdxKU9bc29kJLLCH3+RJmcTeM3GEmoxqxHBtwoA7O7qicX3p44NaOoBh6v1VyjX/d0peni9QcPMCCCy0ZB0fVjCKgMjqRbNw0CEUqzA7gwdBEHI7rO2ZZzS24NPNnFZrl25uJnWIEKz9kpDTT31tetVmwzrvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMYUR+tk7O1vabCTry4h8dxRwwe6VEvZgBMe9xsVdPEAXn+tpaYPX+DBsiBW?=
 =?us-ascii?Q?MVa+LkZQohKgEFfa3wF2kwyuhLZVVh2PxiVQB+Qjwdmqt15fTxnmU9tF6g5G?=
 =?us-ascii?Q?GeeQ1ZMVs5FMS84PEdsUXajovN9JooF6wR634OvFPlQha6UBlxu1oq+w3Dts?=
 =?us-ascii?Q?IE0LypwtZIaREeWiMwgzHQchoZf7+g+C3hKnOYS2s874vxiQch6Iju0ZjlQl?=
 =?us-ascii?Q?8Vg/WWGMtnHenXXahfy2uw20yEV23eWGxvDEX0rS7VtQWSFymqh2e2wd0XN/?=
 =?us-ascii?Q?6/NFFhKFIx4c/olRwSyA44T+AsYYy3qCJmNxxvsgAWvbtjXRru+1XOLK3E2g?=
 =?us-ascii?Q?jdXj9WUmhCPgVBRCHHZkxeQ+TMGoe7brk8fDQ11X0Qi3uRsrEHn/mwHNoWFs?=
 =?us-ascii?Q?YGtV1jES5Giukyzx1Rgkihahd59usWLvX1vPCEqdQPkev2BVer0SaKOA2gXH?=
 =?us-ascii?Q?OmeGlrAqpWrdxSj+CgskxAMbTuGPnTtwnKnV+Pu9Gd/ZUiw3qRwQpt3tDwTj?=
 =?us-ascii?Q?y4mGloSmGS45aiEkrmziwrnOm+wNu5wPf82Rg8YkJPfjyfc65YE0qmq4I7ru?=
 =?us-ascii?Q?PaHBv2vBLy2uDquqVXZJgqbY07lJpn08NX/4nv4qyb3mIwBa8Azv+pFGZRvU?=
 =?us-ascii?Q?1pKAk9T+/Quy88JLp5vc6lUNdIzoPJXny/ijnlknr6eMLe25rALt6kbg7qa+?=
 =?us-ascii?Q?65jazi5fCEXayrtW+tId02hHi0eAy/HZ2YHn4owZ/unCSwFQY78vVcIgwiTB?=
 =?us-ascii?Q?jyKRn9mZtev+PVX2wZbQ+yvzTGlP5D+WEIeLr0J3PeAgZdk3WK3I8vN93ATH?=
 =?us-ascii?Q?eHrn/sHB/yb/KQS4CiKoRyy1dI8orKYAeP7A7v8E6EU7+lO9Ky/8rDC63SHg?=
 =?us-ascii?Q?OQF8/GoOhvp3Cd02T+dMHzB7tz1X1HRwWVk8tsq7WP5OhtcnNKO/xTs7gr5Z?=
 =?us-ascii?Q?TjBITRqeMGk8RNXJbMmZunKYiD+e2PXmq94vv6vNw/EEO3XpG4G1GnjSjQ/X?=
 =?us-ascii?Q?ofxFxOBhPHFLmOZ4iAPa14BCVYwenSCaIlxQG+DV4FZtSrHkNCa9ZZxP9TrP?=
 =?us-ascii?Q?wqXAN6/j48ehDhZw/vql71F6wucMCJj5ZOg2P0iN2/y7DlhSORMZfYCA0pmi?=
 =?us-ascii?Q?RMWDaNqWzLDbT4g8qps+q+3tjLnP0WbPp2Y+DwZn2XPQhADh/F07vzeQgxK4?=
 =?us-ascii?Q?9mZzG1zoeTPGhVZyhGoDYEmighNJs3sRZ5FRv6DpnxSowxtvhwUiIRTtivb2?=
 =?us-ascii?Q?75SbZjjkWqpE/RqEY4znAkQT/Rb1L5zY7rbLcbk16lmbvBB8qgeaiMlTlvXr?=
 =?us-ascii?Q?A2chb2B6ahvIl0WBvtkbBHweJ6mhwxLQH8iQohsf24BE3yV+T2Umq9Sqc07d?=
 =?us-ascii?Q?o00HojTtPwmVV/mec/frS2EQgTHqza5Ml40VShZ+v8RhlAqIrU3tCax6hegB?=
 =?us-ascii?Q?8gh4Apm0fPmY4T+hAcwtKUYT29BU5YT8n8FHm3klWznxhrsuwBXIotk/gUEe?=
 =?us-ascii?Q?M6L2CJpQrOLflfIvhYAoTdF3e9qZLm6YcZgNSJ+WzGEKwuzBWs1tPqxqq0JN?=
 =?us-ascii?Q?IXjmd68PIrA05R34vPcCpUTydRtk4FhmZqj89PDRaWOvz81Di3bAX4Uy01OB?=
 =?us-ascii?Q?1AmBUPx/WS8i2r3xloyB5J1c799lrUAeUAUnXtmfXHVGMtrsASa+EJgfiW1X?=
 =?us-ascii?Q?Rz0LFk27g6oFZbvOQix3v7gPdzDyNeX80/mqf7QNFeyCkV9PCWAU0pwczxF6?=
 =?us-ascii?Q?oybYH1BC6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6437de2f-b838-4967-374b-08de8f8a65b4
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:50.8843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XA6/8CeI01P84cU8Pwo41wF7GaZ8hIR5nxcaPW6z9myK9BRfnm6w/vkXb0lz5R7O6rCca3UjNq3GQRmHQAK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nathanc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 9 ++++++++-
 hw/arm/smmuv3.c       | 6 +++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 03393fd7ba..105f6d26bf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -63,6 +63,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
     }
 
+    /* Update OAS if auto from info */
+    if (s->oas == OAS_MODE_AUTO) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
+                               FIELD_EX32(info->idr[5], IDR5, OAS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -962,7 +968,8 @@ void smmuv3_accel_init(SMMUv3State *s)
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
         s->ril == ON_OFF_AUTO_AUTO ||
-        s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->ssidsize == SSID_SIZE_MODE_AUTO ||
+        s->oas == OAS_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cb14a08a66..0ab6d1e762 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1976,7 +1976,8 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
-    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
+        s->oas != OAS_MODE_AUTO) {
         error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
                    "OAS; other OasMode values are not supported");
         return false;
@@ -2189,8 +2190,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "platform has ATS support before enabling this.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-        "supported.");
+        "are 44 or 48 bits. Defaults to 44 bits.");
     object_class_property_set_description(klass, "ssidsize",
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
-- 
2.43.0


