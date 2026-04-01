Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B43410F92EC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzH-0007zm-6e; Tue, 31 Mar 2026 21:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz5-0007ls-0x; Tue, 31 Mar 2026 21:03:04 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz3-0007ek-KM; Tue, 31 Mar 2026 21:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoCh9cHB3zXxAEH3Oxm3iCpFKZHjSxYbqfpK4JUmGIY97pv7ByrhqS9w88xjzLtm/09xZvtDI5mYRw2Q97vscgxZsuAjh808hP/TjmvrB1NDCauabGkalhSLWbUFe8suCxKbg19qg+o82Ihh/4RyZgMj73B2agDyOyg/1uSVbAHn0BcXVamhYsXnDN4cQK5BIgKGfsIGj0tDdQMbBDI1fDIetqkctvSvfhqTicoLbLHF3ITeF7A0RIWVldeCuG5iGBVTZEaBAa0sr5m8IOhdFHtelEXUv+CeouXPvjlspoZlDEgHQfw+CiP4cPxg7h/I8XLUUtrNYFdUPhyLpDQ+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoFdal64FHyXKqtIyH3+rBVT33AyJXXXAxuQAq3z/Qs=;
 b=YbbVMjHW7/OD53FhMe1Qt74uYBBuf2Gq3zz8Fl4WHakDy9xa7vHdMuauKhQ1VxUnzabmH7moeuakOltsMIXP1RLt3T494RwBLVFOG5MD74gq/rPLy3nfhK7aCCcwFS5F4CsGfqCWjfXn5FuC8LztpH5k90xyKezv6CeYRiSJbV9IZqnoxNZVYYnvEolbP1NPTTU8LpFjInYN/HO0KZOQEXZ+DbCSj5NhwsQ9il9Ax3gs0ONGcfytH2DNVQd4qWJTAuN6p64t85a2yY0w6J9O6oxxHYoIJF316qzoizI4otUsTK4TTiLiEkIsZ0mm1QYwwNhFRKzLn7PJZ/Z3VRh3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoFdal64FHyXKqtIyH3+rBVT33AyJXXXAxuQAq3z/Qs=;
 b=dES8I0VySzmU/TmM5zWaaMR+H2YEl545tN5PEFEUE28ipuLY91IgwCIQEK7dJlm5DPHtYn5hBGX/BkI9QmHu19NI4DCGpueoFqTxMqaS4RPum1gyh2LMTaYDI8zDe7pF7JkQwb0ymfA2u9b3sw5/2r2suPBwZYPqRyz2ckIUw37XRvqOp5YIO3oXZ018LRNZCCIueGUd5DV58Zeh6J2hVR9HBcr1fmE2IZxy8XXZMhVTEbn6K/ImmwdEEIyvIqc4mBIIDnOJJ1w8stBGcRE49bD8Wp3ypSNh/SWOYcBT3YQAvD30qreSXunNwLixKSd1peLyk6QZNj8vtMmqyVW/yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 01:02:53 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:53 +0000
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
Subject: [PATCH 10/11] hw/arm/smmuv3: Change the default oas to match the host
Date: Tue, 31 Mar 2026 18:02:30 -0700
Message-ID: <20260401010231.4166776-11-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: d923dc0e-d9bf-4cfa-a31d-08de8f8a66e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: N48SjpCeacCYHELNgl/RbChKXQUNQqDuHQIGR/GVhMwS4bndcoMFdcqJy8DSjhc65VHBsUO+BcGgcWPj9W6TsTtJkLtgH7r4KBWjLKSSiFB5ULqwEEEqMkMfoGn/NkqrGWgQ11qdkgjQvWPhqlha1nB38aRVA/XesjDGde8dyodueebb3Q3IXNXPrwcYGXCxghDPozo6rU/wBSzPGPBAZZqFsyfvf/6Otkaw+t3KadqqfwDgp2GPRChlnY39PCpF68o2f0DqpJsMb5arhBb7c1ZOUYykk+RfD4efrabCPW630E57EM7CrZwnU0wAefHNEMJV7aETTlLWY3IanKMNUdptw6bxzTzxJlvIl8zy4//aCXmB+xK9CRE7yzOCxrHbwvsi66cNHqOcYOAEGdYRQHJJeREptuCQOBT8ykGHWbz95VtQwhdleMK87fm6rnfQpiGOuMvO0uov5W+tVnOID1Qpx3vHeH15eO1jA06nVk98wd6XUPsiXViweVUmLXAMofxmMf5oSrvB/sg/HymZSE+aQHk2YjQlqwqI2noGEieauBjy9c1HjhBxVWoV0YYipntUjt9aTZ6T/T52dKh5D8LJE4osFWk0eWVNVBRAouMSl8FmjTtxOumr37QhuqmfiKpbSPEoSe0Tl3X4ySAHJfk74p+v9dvyX3p0XAV0XgAL6Tadf1L5Wg3Pp4gG4g1yySWrcn1FXhQnd8UpZJyPEHuJJ88BrGPmgknxFs1ogsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ph7e6i4OVtfLRyWNRVIC5+yX9b2R1gnNOs7nOuCFONThAgbqpagwpBFU578?=
 =?us-ascii?Q?falExWhQmOX/ScfZXGP1JxMMLJ/yeRneyXWz5Sv0+WZW3JGaH3rlBqg3uP1j?=
 =?us-ascii?Q?cUDmDxDsE7/Z+58IieK7AeX38xrZ8UicbGe9onewRkgMT++HmZfkCr4kqvYk?=
 =?us-ascii?Q?6L8cacD9xJW8ko48JZ55c78eguOMR3TrKLp0YuvBU0nCCeYomgCuomc5OHys?=
 =?us-ascii?Q?nhqTBey3fmpZZY1dNevO0Pk/0Ou2AYC3SPdAKibn65fxjsbX/LP+aakoXw0J?=
 =?us-ascii?Q?ZmylScxeYVvinPQa5fC2cUna/zE8f9ZBhnv3mNW6giLUCUJr66HlnY691Sa1?=
 =?us-ascii?Q?fvXgpC4HMuPIlA5pQfjB5qIJ3PYlr40muiMoCHzyVZ58aIHdOsI80cWM0FRQ?=
 =?us-ascii?Q?AQjUC8YSkd1upg6QEsC9vgDfYwiGEHtX0YM7pLD31+rGreNb65LiV8YGWb5k?=
 =?us-ascii?Q?RezazQLuqE+MLvzS5lZuJ5fX4MPG2Zlzr63pufLKozW8HRxjywdXnsAJdNcb?=
 =?us-ascii?Q?5wGOMqwSuQHPcLt/zvI7YzV0DppPU3TfvJ/VWCB0jWdNMdxMDZn+MbjUNGbN?=
 =?us-ascii?Q?IhecS5ScrasjVtrGWkgdOAbtmj7ERCZoUZhyuUtSdPoM6n9PGJNKBoCH0mNK?=
 =?us-ascii?Q?esvmuvtMPpF4xdcgOieAxAu7MGEYQFlJCLbkC0hTrK+Aokz2GRBVmO5uO6Dk?=
 =?us-ascii?Q?nh5DSs2GNVVOSbhdXO0bm8aiw+5l9eLiS9o2YIj4S1b+aO7KbJoxZWIAqapT?=
 =?us-ascii?Q?q8MhJgRPtnv+cw3fKkMIQ9SCNYynukhgsWp5actt8v3Q+c04MIUIicL90lNf?=
 =?us-ascii?Q?YXxcrpM3mra1ftgHApK2ZxR/anugwyduULIn6VB8XH2fU3UQNM1OvxPKY8FS?=
 =?us-ascii?Q?vltW2SdRfmqU9QH6U6apJcNllylVMsj1XD1eO5nztCnjbdp0zNm1O6KJl8CA?=
 =?us-ascii?Q?AFXqPE7Swxc218J2FHRl9YS/DA9BOuIW50U2w4NRjKNglgDvYlhuBXL9dN2I?=
 =?us-ascii?Q?kgWY1U813jq09rBBOL0t85IC/0J+x0GainAdgLmsjESem2IDlkVWRSjpQaYb?=
 =?us-ascii?Q?CwKJdDdjU2qb7IyCrAwbnh2bTXAWS/Gie4/NOsB668UmyyRmb4ocVmLD9ZM5?=
 =?us-ascii?Q?hmAdkFIGdh9uBXnyGkbJdCO/jsLov21MLf04s8rvylHICc38+dU/pQouj0kh?=
 =?us-ascii?Q?AP+TgqKTa6oFxSaWS/qSQ6jS1FAZOkg5eujCaeEeu9gcpbWaHz7C80Vc3dLw?=
 =?us-ascii?Q?pZyoZS3eOLKYwGHeFRd8UGK6OHv61yCJXG751Z1chS9moTYbcCtxlFrtw+lM?=
 =?us-ascii?Q?zGXdd3j6+jZ/KBLDfzxYBwnohqvyMEvtygZobp9QQiJUyylhuI7FT4urrcac?=
 =?us-ascii?Q?cvEGeDZGG1QhqJjkeF9ehkQCz77GaaFX0VPActC18s0yNIim5LeInpVp4sHx?=
 =?us-ascii?Q?RxVFxhp1v5U8+PCcIT+16ZuhZYQOQTgZTwJ1c2Hrjnc/ks2vVp+CSaBFW2fv?=
 =?us-ascii?Q?KF/7ctyCCnM6vTG9s9w+Rdcm8sI/8LBGyWip+BYeO0Xqy2Bmya9Yf1z0padz?=
 =?us-ascii?Q?Kb5HpCbyO33xWJFyY2YP2tZ02g7PR5Kxv7bZ/4OLh3yxyoEXIc7jrFlUXFT8?=
 =?us-ascii?Q?imkKtAjaVmVVRu/M6jAPQzWuFwGUYxZKe6AoVuvkhzpZx4LpezK+STKhaUUv?=
 =?us-ascii?Q?4Ry7t4o7Ds4Yfixh7mHqbOetq9+3v2r0Y5AHnqTqN6oKBOzOj0SUzFLo1uTu?=
 =?us-ascii?Q?kFcyK5JQ1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d923dc0e-d9bf-4cfa-a31d-08de8f8a66e5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:52.9357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AceZVHwBE/14b1PUYS485/9qgPmiWkgo171XWMnWGHRCgHz1PX/cAc2+m+mAApv3cgYQcZtqfC4Fry4Ogimtw==
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

Set the default oas value to auto. The default Output Address Size used
to be 44-bit, but we change it to match what the host IOMMU properties
report so that users do not have to introspect host IDR5 for the OAS.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 4 ++--
 hw/core/machine.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0ab6d1e762..7d537b7947 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2155,7 +2155,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
 };
@@ -2190,7 +2190,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "platform has ATS support before enabling this.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits.");
+        "are 44 or 48 bits. Defaults to auto.");
     object_class_property_set_description(klass, "ssidsize",
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
diff --git a/hw/core/machine.c b/hw/core/machine.c
index aa208a2d9a..a668bb2ec3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ats", "off" },
     { TYPE_ARM_SMMUV3, "ril", "on" },
     { TYPE_ARM_SMMUV3, "ssidsize", "0" },
+    { TYPE_ARM_SMMUV3, "oas", "44" },
 };
 
 GlobalProperty hw_compat_10_2[] = {
-- 
2.43.0


