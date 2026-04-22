Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9A6FA1FFD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeQo-0000UY-Kw; Wed, 22 Apr 2026 16:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQj-0000Rk-C2; Wed, 22 Apr 2026 16:44:17 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQh-00071o-PF; Wed, 22 Apr 2026 16:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVVqmpla0g+0O5JKsboQtt/mD5Tdhz6bZfDEL127EvK+T0q4dWqO8ytfhaxZnVblGb6o8NhPy72ZLBLvjIlm6h+CnMqpQ86IeE0a951irtsRca3VsHm5hWdBs53Y1dXQCI+8wVT2MYBhLwmX2rFsUmHU6JxPHcoVLHd/JEdLn0QykN7Xl5+fjmdIS2zaHB2PUNMYPsksfh5jMvy1P3wejBJx/C/p+5udWtSPQuYPnOjDlyNL4aWAZKdcjQ0nbvTDZb1FDLEmS9+xEEX6fvJpa2MgpdnK5akaEVGZA+6nTVlgLmaP+1T3poJTLbQX6MXaZ9U6/Z3PCMWiAdks2h/FSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PR7j4lqXHYlWUlrQ9KsunC3UjfenshyWj4e2maI3uus=;
 b=DddJ8MVXvbzCq6GQJl3o45Vng20XcOPRh785+XokzslWIzzoRAntuUHsvMo0eKqhmONl2DwfA+dbgt4tiTeF8kVwV3D47TPmHk4ZknT05OGeaSPCcStZsOnh1Hp2wPtGmaDePB/d0U+aJnuMYO47mBQASctbAFFCJxZmqpurdO3EMLmxUSgHny0B9GFwigIHkGOAiaxxkKFsBdDyiVUxzAulqMYhoOKSc2ejzJV3ZsxYk1PNUxNsSgusV4JzYX2OLFbfo2/aYE/oxDM4fUW+Z3jZvjzL17LEZ4P7/ETXqwF7U0ON5ISinJoCJbLMkgKfIHji64u8ZOaW8xeU2iVlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR7j4lqXHYlWUlrQ9KsunC3UjfenshyWj4e2maI3uus=;
 b=ACcT4gO603A5v9rN2Twi/wZbiKTcESbp72JfAThlbwpm7PFiF46P+Hmte0VmhrwQKCPIRofckwIQDQLMyUnwEWr/zRVM35D6s8xv40urCmSFCiYGS323useAQOJS1ksEqa02DDQMYOWFAyuuQNBg/pP3LYt6ZJbK0v1J4PoWGwH8qbXUEz3lCHgofxyg9R4qyb2Lf/GburV6NHngVxv01jsMKfPIAaeDqfJRUHquSF998HXREw2igIOnpV1W1DfDNFlJuaPFZHaHy5uKLTeI2QVm+7OluM9r13ui3scU6ZJZSkMTKIruFO4ZCqG28f9Ijdo2z+hR3A0JT67G0wC/CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 20:44:01 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:44:01 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Date: Wed, 22 Apr 2026 13:43:35 -0700
Message-ID: <20260422204335.23116-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: a73457a6-1e99-4819-6775-08dea0afe27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 9kCwHxqTnQEPcjAVrMad3NFHfqkM1SIQm7MHnnQ+fLXtk0N0YKTDVTvrC1QOAkQgTmBFrt8cxr4PMeui08IYdLuWggrlVwO7bzn31fj3bkg82vxBubM9w06i/Gd0RqY4Z3DU7ahAU+zlnrlczn6h5yl8brZdbd11EGqCLomoLzTqIPexLLpbcPdXx82W7aavfs415JGUbtue91k6Sj1bRsot2D63nx7br+x+w4JH7MdJqxWLgP/i3O0AmzG5qNlHx1rsiUKhu+ZbWUbJyBILGJE8lfZSpPJ2dJf/Pu7g/CF2IOtmaVmrjfcf6A826O+O/9niRNU9EhgvXcyEufsulSq4ukJh4q0PexZJR9YfBEmkEe//OkMLuhDK8HEQBD2xZr9jxOD8GxMbEEoz0WA8Yc2rlloSRvJ1I7UdNH/xpQ0us24eNabeuiPGgQ6BQ+qtvlqGTkDZhKhzqbnHbfuMS8spTZbEpVFSV+8adX+CeT9SNWVZvUnl2BQv/8ZTm3XIvjz+XixoTx05TKQ6tZPJKwGW7dnOKSkvrOGQm34MRwUBA9WdXHSqhmFxNtqAqduwqHo+jwOJjdxN0WEbjkplLhqFpG6uldOYSAi+G946+Ul1c0E+CvU1vImjn/0L8thVjRU/gbLxKPIEyofXunPevg5lqhKwbHsrcypmpITkZZZUGtEnCrEH4MJVZQlLAp7jY95eI1ZQgwE3rcSb1d7U0Ibg7JMB5MHXEzbx3/6S7AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZ73ENQXa/j5jxEnyYGg8nHuzhTimFpRfuaE0E+VswBjA3OC6yRMDQ+9d8qV?=
 =?us-ascii?Q?N0RXnkhpzM3LRkVhIGvgtRVLm6DrwT+GwxHGXMuh4gwvfur2txJjgtz2Ax9L?=
 =?us-ascii?Q?/mv7h1ECAIk2rGh1+/ozG1mJfTqLHkRRPWQYYInzCS6FR3tUBh4K11cJnXPC?=
 =?us-ascii?Q?ROK3u9c0maHB062lIJQQzdHmhtDBX97bCw5J5E7iYUfCwkp9q+sT9k6q/zOR?=
 =?us-ascii?Q?gesaxPl4D92QmDgR1pYhMKJqdc0fftIdxhnJkmWJ0AaSl/U67AgMXyNQ7VU9?=
 =?us-ascii?Q?vO1wz7bg0p20xBWZ5Si+EId7MnAhWih59fvAMryWSve7+KMm/kmRrwJ2Wvsi?=
 =?us-ascii?Q?Ne7rZ6hR5lCem8qkU5bKzb4axBKQUapwKIXKQw899o2AJuA288wwnIx3lVm+?=
 =?us-ascii?Q?8SpCT7KXcI1HMkx+DO5+q/g/jSSAXnDzHVA53E4hf2yujAq5C1Ert622rhsL?=
 =?us-ascii?Q?KVBQWekAe+XTaLfr5h4jq+8yMQjAUjOw8CKgFHHCdeMjUWpDTP4zR38Ci3ze?=
 =?us-ascii?Q?UT0A9ozWH9lX8g4TweIgCjYLnXyZbpiD2lUXKs2er4GkoIEZix1gKGh76Fga?=
 =?us-ascii?Q?k7J2HavjmgNOlUeNVX4qOatZbZW5xX1U1xDBAlK2HFGeyZjEdbO6mJiA5H/8?=
 =?us-ascii?Q?CIAbYdjZQNUq3U2mRMEIdmJ1tLFipZsg+nS8ltRzva9R1WWXWH1NFHS+hJwz?=
 =?us-ascii?Q?BgBWtxjuKIjoymsY18/K1HWYudGfEuqE8RXzRDch7r9RQEq/i0rQMzkRMp1S?=
 =?us-ascii?Q?fVlXlFksd9DnqCF8L6362fdFNDCt5iOHvUcmSlLRxlqbKlnV15o2Lyq01OM6?=
 =?us-ascii?Q?UkYSsxKKCyub1PnIRONzF5gfL3Mt27ySjiQaZEe6VsZb7zslb1ek4EUezNo0?=
 =?us-ascii?Q?BZW1oCWk0C+vTaB8073tyUC9LdfuM7B21JmDX9TdipAOWZlNsddf8J7iIh/P?=
 =?us-ascii?Q?uFmsJ7zm9rCEuvFFOxxGMtpA3w4TBPIlq0XWJazw/nzr9eyY5FSuUBYMRcFe?=
 =?us-ascii?Q?EPV2X95YFPtAYPeV8cTmCQMe8WxbEivMwF+6hR4IhdkiXy56spg3CC26Xmyt?=
 =?us-ascii?Q?HBpKp1kehzmDRIqVLXcR+STj2nnzgrg3Q2GI7qGvzwuQfe3fSlFJvrEyRE3E?=
 =?us-ascii?Q?IlAGaI/ESL8kMoSjZGYZ4Vm69M0eMD2G+1l5duZ7VjNzsQvMwpHuLYIu/DMx?=
 =?us-ascii?Q?5fnU8/h4fAJSjQL5JUIQfOdNmwDs3WWVHaZv6ocbIGBpSao61Wy4kfzCzQln?=
 =?us-ascii?Q?Bd6fG6T5uYwtoqqaL/J+Ye4GSX1C8wOW7EJbgO3rQtH28wg+pp4r9y2yt9hl?=
 =?us-ascii?Q?JJcUfHKeMNkUifSRjD/DhE104UxO/5KQd/GwEzBtd85ZZ6JzGw0eP46YIMx4?=
 =?us-ascii?Q?f8pdVMaqaYfYIuqh7W+AHl+VDToWTCJKgZdUFEASueO9OYTPWO40AbmB0RjM?=
 =?us-ascii?Q?oOm1xK94yXSWFZ6h5XBOWC46SMrWnOenEnNPjTMmBE1wLiRGbwaSGiQ4a5FQ?=
 =?us-ascii?Q?Aa/7H4WiPww5/v0QDARIM3KHElSjmLPKztOaoMzJJUUTEqGcEZ8uheEMD065?=
 =?us-ascii?Q?ceMA8aMjZ64xtmec0H/A2pIagMd8FyqH4YBTnWmzirA0tGb7KoYnVGmsQ4qp?=
 =?us-ascii?Q?gm2TUFUJNotGmdp/nf4UtZbn9GJ7IDL4By4NKj5mESVBhK5iVTpyoRXh6kuc?=
 =?us-ascii?Q?qLqglz6COZ/FXgqZSP9ymDWGziYlA0wMPdEzF52SyoPzYubx5LBixJXsCSLK?=
 =?us-ascii?Q?BFW65WPohw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73457a6-1e99-4819-6775-08dea0afe27c
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:44:01.3806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSvlXJHdar/RKfrBIv86IQ/0L3Pldshc17yEpcdn9MWBjDnp4hMEpkaCafuqFizm/1gGBIehPBxzSIZw5IAKrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nathanc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Update documentation now that "auto" is supported for accelerated SMMUv3
properties.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 21972f8326..2c6ba16a26 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1291,30 +1291,43 @@ SRST
         Enabling accel configures the host SMMUv3 in nested mode to support
         vfio-pci passthrough.
 
-     The following options are available when accel=on.
-     Note: 'auto' mode is not currently supported.
-
-    ``ril=on|off`` (default: on)
+     The following options will be set to auto by default if not manually
+     set. When accel=on and these properties are set to auto, the value is
+     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
+     accel=on, this requires at least one cold-plugged vfio-pci device; if
+     none is present at machine init, QEMU will abort.
+
+     If accel=off and these property values are set to auto, the values will
+     not be derived from the host SMMUv3 capabilities. Instead, they will
+     resolve to the defaults described below, and a cold-plugged vfio-pci
+     device is not required.
+
+    ``ril=on|off`` (default: auto)
         Support for Range Invalidation, which allows the SMMUv3 driver to
         invalidate TLB entries for a range of IOVAs at once instead of issuing
         separate commands to invalidate each page. Must match with host SMMUv3
-        Range Invalidation support.
+        Range Invalidation support. If accel=off and ril is set to auto, this
+        property value will resolve to on.
 
-    ``ats=on|off`` (default: off)
+    ``ats=on|off`` (default: auto)
         Support for Address Translation Services, which enables PCIe devices to
         cache address translations in their local TLB and reduce latency. Host
         SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
+        If accel=off and ats is set to auto, the property value will resolve to
+        off.
 
-    ``oas=val`` (supported values are 44 and 48. default: 44)
+    ``oas=val`` (supported values are 44 and 48. default: auto)
         Sets the Output Address Size in bits. The value set here must be less
         than or equal to the host SMMUv3's supported OAS, so that the
         intermediate physical addresses (IPA) consumed by host SMMU for stage-2
-        translation do not exceed the host's max supported IPA size.
+        translation do not exceed the host's max supported IPA size. If
+        accel=off and oas is set to auto, the property value will resolve to 44.
 
-    ``ssidsize=val`` (val between 0 and 20. default: 0)
+    ``ssidsize=val`` (val between 0 and 20. default: auto)
         Sets the Substream ID size in bits. When set to a non-zero value,
         PASID capability is advertised to the vIOMMU and accelerated use cases
-        such as Shared Virtual Addressing (SVA) are supported.
+        such as Shared Virtual Addressing (SVA) are supported. If accel=off
+        and ssidsize is set to auto, the property value will resolve to 0.
 
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
-- 
2.43.0


