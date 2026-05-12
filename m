Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4794CCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMstn-0004V9-Jx; Tue, 12 May 2026 15:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstc-0004RW-0w; Tue, 12 May 2026 15:36:00 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstZ-0005nm-Ks; Tue, 12 May 2026 15:35:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo5FdMJTVMCn/uEE2/DI+MLwdoWyzyHgtBkQwOkOjExSD/nucwI0tuCinBLr0ZsevfHQCfhMsXXJeTlnb8iyWBllFktYLIomTsuX8z8HlGXKyD//12Vn9LiGDSj9DYaOhsP21R/KDS1obYA3G7Ja6mThiiSXuDfmcdPBAh9WeN82ER4HOY4BWCajGAY1Gwb4kMmFHXcLIeEnUWNiDTVVW+6xa5B9Ii2THc3LhLPtw5XSO0vZ5KDCADkXYXbQhfTGMAedvR5PB4vwlCMQHsEvoY1LJgQ2rR+Td9X210+5tqQUL6KP4//XSLfot/CEv8Oskm96j5Ux5IPvycP1g9lOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=178zSAXuhNEY1lF/2NRHKl4SHpPU6toYUsOGAdFQ8yU=;
 b=cJhy1vK1Wr7ynXaSbYTmXIdjfBIqBOZwnj2EoFp+X7+TBrJuAqiHx8/Gx2rvjd6R6KeVb0rCn04ogLq4LrNfAZjRckqscyaOE9+YdlsFpnpkTKwBIk7tvriOJlNOkHQhHJ/NlQHwezBabXOs84LDUhLzwQXQ8WodzUQ0y6HOga3jpowEyRlIQVYJzziE6XN1cUEi22H972/Ei2fJ6vxq0mUn0nZU8myVJZLx7ilpTFTIpKWxztAbiF8nCUTmkWlIWYAZAtIvrC1aRvo1zL3qSO0grQhJltubVGt7rR06AUPz/yHp9Q1Hi0eSyL4TODtPsgQi30rTM4f0W8tx6lemoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=178zSAXuhNEY1lF/2NRHKl4SHpPU6toYUsOGAdFQ8yU=;
 b=iEmipxmTYqhUJacu88jnCZXORl2ppEsS7mTm4pnK+zzGa5MabneHvTbbRvLuo22EtratyE/zry33evNfEus8OHCS1Z8xVBR2FbziwpjwiFMJsngyWlbBlQtSJHJJOGWIfvXnVl1PJxyZvJHjzztiOz0eO6KYI34oUb81jAxmqlRcj9ZATDVLIQQOz7hKnao6Mj86LZl6JyAGukHVN2xGhCymSwKtq8KiYyiWI9T3Ec2BVG39mqERpqDxCMWmkS+BMg+1Onk5JvTZRtfCr9F8/BGpDS5C2t7ffmJJoJ+voEVUtC+XCVVBeZgbfhiyeielaqBhetxLm9KsJVzdUbLgLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:46 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:46 +0000
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
Subject: [PATCH v3 3/7] hw/arm/smmuv3-accel: Implement "auto" value for "ril"
Date: Tue, 12 May 2026 12:35:16 -0700
Message-ID: <20260512193520.3109172-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: e881a0ef-91b5-4c21-2020-08deb05da9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hCn33ccQaO6QL3XxZbXLr81kUlo6wLyPfGT2e3AeBGr+Br28NP2RMQKgAceRBjdHzqOTsTldNPG/ojNjKHfTYKBcCW5jU98v6X/tfR4CQET3rNc4RQoNtc8f1lrersKH+Y6AERDmgwDEjVvU0LObEmwM3G8h2US1bMe+gSIZ76hBgZjZmXoE1MfCXKpYf6KFK/o1YIkng0EsO2pxpSO9JPO3kHNsvsOgN+LuVCato9bz3H3+Z3nmsXh54lw+R028sDcSp+TdVgNOs9k3SPM/06eVHN2reRnKe0z5EKV5hIAuG9952pE+d7dG9IEG+G/MC8n3LmZ3zE31sZsmO0D4Eq+jdPEz6+SVa2Vg8OB52xt/AzdggO5+2TxjpJBh0On9cssz9K82ulxd5cHcyWTzZmOxBzw3X/OFWBEzfk+599gX4+SHUYFuofY8tXsvwzdTks+1ga50i0+MM+yoj3Kb0syoCBGUG9lqoLShQZW30yWvmF/KC3MLV8/QIlWmipLKZg5Pwen3/rzn8wi8jxYg2U0+FicHC51juJWCxV1s9ksclaaIUnFL+SWJUqfmHxk0YQ5oRVdZ3w/osGGty3CgBhVLHmws82oKyBfL5LYt0RJjk+jh/J/POvQ6nDEc3i0hgV6g6bKROVZaKn+rv7YtsQ5VLMqplrg1gOY2jJqNpx+GOCEK92Nmfk2HffyM476M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRFeGQ+W/xdp3zWoXnLVZeXJ8O/1iIS/QvKwh86ID7sKM49UkIEnqPaLqhno?=
 =?us-ascii?Q?HLP0BDiBqueXhBK68VhrLl0JKEOo/rYyLKuyqss4uUigonqPyDvYFe5cSJ/p?=
 =?us-ascii?Q?lnTTVHEFYCfjhSxl8xBmp9hMp4+znlYMVQnXvr+iJam/VK4C1/D2EYSTmssW?=
 =?us-ascii?Q?/lrTkAy3CivdpKPTpZRrjhmxAHUeJCDOivqXjINjjh25bPv9UIJ5oWCIcTRU?=
 =?us-ascii?Q?U7Q6sj1WEjW6GpHQsX7izYcfrcU+614g9105fYXZxK8VqgyAY8v8g6Fcpsnu?=
 =?us-ascii?Q?jLSva4qCPM7i12aFfV1sxDvFsEyUj7vkCGXZlFSFnHRmavPHkVohgOc9mjtr?=
 =?us-ascii?Q?A24h1sXQ0kAV/IgEdfC7QQjZWluP034B/adKARMhEx/XP0YLj/ykNbRRviwX?=
 =?us-ascii?Q?3EVztvckjPEftHo4oJNblF5dPAqN/TL62QGZKVkn0wgcbf+20wYRe3CCOMMN?=
 =?us-ascii?Q?eLcchJzATzy9iD6TVpMafiWndQfMZ2IKQMfZebtwZf1bcxTOTEoWT6I9rttl?=
 =?us-ascii?Q?dhFa+67xKGDo7Til/52/0kv6WOnQxYnZOa1lbXo/U6DrNvZdjZdwUbI/VmIb?=
 =?us-ascii?Q?Wn6TR36QKgQx5BQY0+TAjWGZ4y8vs1TGOhi/s12kEEgIwiQ0e//U9Ah0z+si?=
 =?us-ascii?Q?Z79Z/Y3nxn2qBjS/Mo15EziZt9kUdRXfUHphb7jnCwOQDbZ4q6C4SPgPJTDR?=
 =?us-ascii?Q?wQ3Bx8ng4z9ld42GxKZOdn5BNioFG7ol7kxVEdOxjzvZfQ9zU87Fv9K3Id+b?=
 =?us-ascii?Q?qU0mTNEaObtU7+5C2Llf3TRlMAPLs9ZfRQJ7XXQyTUBofs3F8RVvhjQsEF6L?=
 =?us-ascii?Q?QozxMgcWqlBmj8km5JNllwGxskXfz46DXJmGghEoaxSxq+k2SGQRQg9mV2pA?=
 =?us-ascii?Q?3XJ7cRILaB8s/vg3AHXYkACWBNjxw/DmyRc0Ql4+IJV5PcdZiXVluUWe6RYK?=
 =?us-ascii?Q?0Widb9ockHnFzDNhu5SavN3HSB5wrzFg8uNhxIeljyikM6CnGm1/9ENdRDIS?=
 =?us-ascii?Q?oG6cqt5V5SMIQYOcZjVx+M18dhLQkA2LzNAuRry59hdyIiaQlVDUbMkIileU?=
 =?us-ascii?Q?QZmdpH3KybgCGxKAYeeab6R+6N1+/3D3x3ISLB+CyPV6aiDwih/LbgEefjbP?=
 =?us-ascii?Q?yCqu/Xr+eoAMonV4/1EFSJcnxMn6N9VlaY0DeSxI5tLqOFHI/0yOMQyVhd//?=
 =?us-ascii?Q?tUcumgx+6AycvyMy/tB/FJI35sDIlpvZbXB7mpKNLxfhMin3u1bjSD02mSEv?=
 =?us-ascii?Q?DQVNcHPDk5Hw3vRLlJjQvCft7i/b/4xl0T6L5oDEHF3Lx/OM1YJr6MTew1cT?=
 =?us-ascii?Q?b+OloQKncusEZ5IbiVtYRkCHgTY05D6+lGJLII4gm2NBpJL2l3tnlF8t36j/?=
 =?us-ascii?Q?k0dFDKtPepNkK4VelUSX1BAViS6jbCnnCojwp7FcOmdjkegR+ePIkY90kz4t?=
 =?us-ascii?Q?7HO5cfsIUt/Tl32iWNe99qoFlC1YXX3LwseIX9daHC9StI/c0fD05g78oSpu?=
 =?us-ascii?Q?InVaNGFKFhwIO9rLKtyPdT3gCyMqEF4OxZTBUl6/Rd+tz55eAjucwctGB5wz?=
 =?us-ascii?Q?pVgGpDDSRi6YWd4X2MpgHtx8m857RnhMHUBzPv/JWXJVsv0eYEwVgQY35Hom?=
 =?us-ascii?Q?cfUEsSlYHRFKJnmWJTdtZGgddltEpzyfImxh2lXcpMbYqZyoV/cSqQLWJOyG?=
 =?us-ascii?Q?w+EKUO46rTyCnEzb2sWMjDxPgtFUI4LeJFqUdzCAmp6nSDxtdduPqbP1hAvU?=
 =?us-ascii?Q?UHuYfLph7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e881a0ef-91b5-4c21-2020-08deb05da9e8
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:46.3733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjJrgcK3u9eb/Ve0mheXUS9gYBkvMnvuzYc/PsvNO2Tf+9USoxT2uSXhj/E9enEVslFFLwDy9VBF59fcegoW3A==
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

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 10 ++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9fbd13c438..a5973bd499 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -57,6 +57,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -969,7 +974,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e558f09652..7ec4241ecf 100644
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
@@ -2163,8 +2159,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
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


