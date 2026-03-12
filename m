Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22A3106ACEA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCT-0000ul-4o; Thu, 12 Mar 2026 17:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCP-0000sy-6y; Thu, 12 Mar 2026 17:04:06 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCN-0002qm-8g; Thu, 12 Mar 2026 17:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiwtlUlj9aemeKe9C52xkZ7a5sf9zu8nwDcQCNN+3QvG+CxfB7UFgc+i5ReQ3EPdfMUukRBAzdsdX0Wu7rAX0+NzMuAvHfjgwrYII1nCakTiy5cFoGgeZiQpBI84OkUnHniTvISaX05iAJ/MRnYw2NImbeOQYDYwpC/HFHfIH6dIkoefzNXvjzxGs2gvCOgUqmxeM1FEx12bMUGY+gpFB8210FOB+Fu5a+SiEfxyVAtZ5fV1BVGXm4dc/ENUd8wmSA4Qrfz77+KFvJ566Se1aD2muvjv2nAulz6nzUd7KjqUlpdw/QfES8aqSYHj5NihYLp/qbfeAw01FY0lOKxiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NA4biZ+aMDw3/QcO6mNg2gT92yWfh320DtiLBjxZjM=;
 b=uKCqePitodXSwLtexob8TjcAidi2KF23RTfdBEfQ1NC+R37jxQFMB8DFHCmQy413m1X/dOx6/K/rf+Gvm1b55d0wSi15bNY8Uoll8+KZ17dCwaPKaHujkEuw/K912DekBur15LVc/mB8+yaMOds90jGo4FoWTalc2pqamvqAA3J5GTu/l46D8BKh+OccD2b7myQKPLFlDf9PXmfbVezJyr9zURggQUdNtaiINE+fK/+RSxBcvZNGRvHcHDFPlZzZOEt/qzUv+b8tEwWpKUhEGDyYIyfEM/N/CLet3RsjAOkYfZoKkJ5W9TytuGmhzf57HaY8i6LXuhkdxwbwL5oykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NA4biZ+aMDw3/QcO6mNg2gT92yWfh320DtiLBjxZjM=;
 b=Mt9fE2wWp7O8nrnNg+aS5C68yc3LZHjwzGJXMfSpEXctMMr5tm0tB3lLeZfB9kEnfq11zBm9WjIo/3R6+sC2P4lZalCH4JblpeVbVfxFSfV2fGlbDK29gS33APAdnxQKsCp0shgSCLYf36y4YR0xaR07f+lJ8Y/17hpggr25jaj5rRFF7cTylLLoiaYqskcgMJJayEazbOT5k8hVMMf58AAajrILzZo2Ff3gpGY21aAiyzFowwlt7EQ5nyvlSqGd5DSi9ZD0XmgeRYbC3HsUui9tQMHyAaK9aSZUnJkc4K75CfUyqf3x2H2KS2Zg05W5JQyOpDH3cZVuicKvcsL38w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:53 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:53 +0000
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
Subject: [PATCH v2 4/8] qdev: Add a SsidSizeMode property
Date: Thu, 12 Mar 2026 14:03:23 -0700
Message-ID: <20260312210328.2016191-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6ced10-c184-418a-bbcf-08de807addf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W9Y00E2LtEAd/4RnfKS8OINYnSGqwdQd9C38nL/jQpF6Pqd451HQlcogH3vOYHtjQEkqBwLLf8U6SJy2DurNo25QwhXbuLU7IlZGzK5cSs1w2RsH+SfoBZXVb8aFBFNCUFKjgVEWZVeUB1N3ktRJA9zt6vIohZKZ6u4azjfiJC12Y7XlbpmjTCG9G81UC7sKS9+d75ixVRe0mn3Ncsagr9AcCGLCK559mtXJ6MvRvb6Yl9BqFHHml1ciOwZDziV6LHzP0RRdL+VZRtS2+jQuZGzPTynyUJiZTevJkMBNAYeB2oK0X+jqN6UTPW7DxxNpkB8fGcSTwFgCKV2pwPsvAPZHSwl2q7fYElXbHVvqpFawxZj2rmFHcC8a+v0JaKnlISxpp7yLhcEcEy4JlKccXDK8b63WwnWOQB0huIVef3szZI/MYjFGdkvmZPSfbjvB2cO6GL3V1voG9iFMRl4run/VTggNuxmHkxY1u8Er3rmR4ulAwco5C1nJf3oLblasP5OeHXol/4+Z9Up/eggor1T6ED2Px7/gVAjuExdeaK8CmfS4GlrbQT+Aho7Y5pG7fOnQ/JKr1D6DpydTLumgaOYbb265WkR7Btu+MdYuAWw3a6pada7+YNzdZ0f4+eqBhDBbaTn+CmriIThlM7dmBtH6fQG1JVMnPz5V6kWHn/do3itrN/nVkTakz9B14ttZKEYjrRq79H19zjkyeJ2Vflc6F+1u11lbaOe4MDZwSYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sm/ysRK13ZlYH+QkK2RgpvBhRZb9PWzYDSC1vljDXcbOxqcNPf84iKOmxwwn?=
 =?us-ascii?Q?G9GS9oirxFrVxozb8HI+5EjhZoX5ZG9YxmXuSXwi1jTQ79f8yoE0OCK48USY?=
 =?us-ascii?Q?Z6XDRwID80AFQLMIq4kChKOOc3kJNi7KaN0i7K7adOW1pnv6LaGkMdg8iaZL?=
 =?us-ascii?Q?W6ZDzUWAMiMVrGXF6N0bVlO6eMY7WokDdu3qFonx0ts1vQg52GDd33I1DFuT?=
 =?us-ascii?Q?ZswzPlof8TfKsphv7o9BlWbClIxSYt3Ti1BwXqYFohjPrzX+Uqt4HxCOhU3P?=
 =?us-ascii?Q?tUvk2XPZyArx5Rbv8BSasbmOZp0+E5zfay5cYZqNAf6M3NGZRet1wT1hau+Q?=
 =?us-ascii?Q?zwT8ItxRZ9aPeXIZSFcSjVClUHqPIMYnJQcxT13YzIjPPp1tUuRkaUNYiQ7e?=
 =?us-ascii?Q?4NFpb9idONdePXBTRryu37UJHgRNVjL28EgvICP+zM8qtYe44R4CMVk5Ra/v?=
 =?us-ascii?Q?2bS/jmYUgmeMEGA9Df1JigFHic+APBlG5WVfd1CJSS7G7KAt0AvHkpAdx6c7?=
 =?us-ascii?Q?oTaAfVs7queNZG8/oCluyiljPFwfSe9wk5IdzSfCgOiiXCxzUO+2FGWcT/ay?=
 =?us-ascii?Q?EhA1/uuzrQKU2mNCE8UdlQqrAuVA5Cqa6V9OFJpGLcDP8OJDx/kwU4sNuSbs?=
 =?us-ascii?Q?MhzgCEOV1vfWzN7lBeexZ7kGPFjjkgbY/sEv3hv0N28mpwQEOihhu4WFMBny?=
 =?us-ascii?Q?v80PMWDythqJNsX/NP63mQc5sJYylDK5rqKM59fPbqVhXAx47pxwf7509Vx/?=
 =?us-ascii?Q?z83lGQ63tUGPTq7PdBX9SSN7DovZ4jzKeKmE2Lurq4okJQgzg6Lwk4h/ynx+?=
 =?us-ascii?Q?LMdhDM6PIGUsNn1FEfs6GwszHbSuK4W0r87ghjKqZZuau6fJG62HLHI5NW9q?=
 =?us-ascii?Q?VrQWEDipgDIHiHS3LKO+SKIIfA4oV5fqizxsVfCsnnUpM4kG3dnR+PUzaW3a?=
 =?us-ascii?Q?fV2Z/O9jRHOctlGw2zUHnMfjVslQplGVCr1bTBLFPlGCIQLrO4txl/0hN2TM?=
 =?us-ascii?Q?aqZM+7YKoQi2g9nLo3+9ZPWBozW3E8+cVit/G8AnE1sGlYZ7A9f/15d7e8Hw?=
 =?us-ascii?Q?BvdLFMv7Hh4yw7jlMtHSjodXfpmam9BjC+mLkVsrltLZe+1ktHFJLoNVWKjR?=
 =?us-ascii?Q?S8xm0qPVdWISaRff5wGMxvTPY9AFWNrepUuwn9o3H9P87t6MR1jF+xTHi2j5?=
 =?us-ascii?Q?P01+p2d9YtI1tvf2x9PC8hHak/cD+t04Ef7pyeRHEE2q1kyB3mMR2xFBuylp?=
 =?us-ascii?Q?6ZiHsvHfDMexlo0WFRsUVTZAi5YSiZMAW1z4vySO8DO+OgQxn6Y2oRRTNdCP?=
 =?us-ascii?Q?6ZJnoYe8jK6UFgp35YSNw0DXOeO7qGzmuiuZu8sW34UsXcguZJNM3RW7Wllw?=
 =?us-ascii?Q?cvmAHqozXPn/y5PKW8DkMZiS/IpHsA48f2gH/5pBIIFfhZc+5EGjsocStzSJ?=
 =?us-ascii?Q?nj3fSJCb3rWDkZ9BznlyFsouDXGi66BSUPThuoHuErAdURgrnno0oH8TEMzT?=
 =?us-ascii?Q?lJMsF7B0zJVwk57FPlKVbVhTvZjm1vfqFO4ZQA1RTrMpEUl3mMy8jbw4zUPm?=
 =?us-ascii?Q?tJaG36EdV0bcFLCeyYXW/Q7LVEk6Aut4FZfxaXDXlWQxcJ10fdGlMgiDvU+g?=
 =?us-ascii?Q?ytv6eA4mPXTb3g8R3yg9Qzpb8leBno/DB+CQBiH/0AVct08vvbPADtEgEVOH?=
 =?us-ascii?Q?RdKCeWoN57VNJj5s3A/kXocs8ym0TBLnCzctfyPrX1xN1FCgTJV0NsKKfNvf?=
 =?us-ascii?Q?zoD8LclVnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6ced10-c184-418a-bbcf-08de807addf5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:53.3115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFRZr4CMlE813nPbjHdYLuunfPlZidedIpWvMz/FQ129j7b6xkm8/f8x2xVs2eXm8LreCoWQX6wtL5NsfmQFBQ==
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

Introduce a new enum type property allowing to set a Substream ID size
for HW-accelerated smmuv3. Values are auto and 0..20. The auto value
allows SSID size property to be derived from host IOMMU capabilities.
A value of 0 disables SubstreamID, while non-zero values specify the
SSID size in bits.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/core/qdev-properties-system.c         | 14 ++++++++++++++
 include/hw/core/qdev-properties-system.h |  3 +++
 qapi/misc-arm.json                       | 16 ++++++++++++++++
 qapi/pragma.json                         |  1 +
 4 files changed, 34 insertions(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a402321f42..4aca1d4326 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-types-block.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-types-misc-arm.h"
 #include "qapi/qapi-visit-virtio.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
@@ -723,6 +724,19 @@ const PropertyInfo qdev_prop_zero_page_detection = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- SsidSizeMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(SsidSizeMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_ssidsize_mode = {
+    .type = "SsidSizeMode",
+    .description = "ssidsize mode: auto, 0-20",
+    .enum_table = &SsidSizeMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index ec21732ce5..4708885164 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -14,6 +14,7 @@ extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_granule_mode;
 extern const PropertyInfo qdev_prop_zero_page_detection;
+extern const PropertyInfo qdev_prop_ssidsize_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -61,6 +62,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
 #define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detection, \
                        ZeroPageDetection)
+#define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode, SsidSizeMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index f921d740f1..76ea0a09fa 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -45,3 +45,19 @@
 #                     { "version": 3, "emulated": false, "kernel": true } ] }
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
+
+##
+# @SsidSizeMode:
+#
+# SMMUv3 SubstreamID size configuration mode.
+#
+# @auto: derive from host IOMMU capabilities
+#
+# Values 0-20: SSIDSIZE value in bits.  0 disables SubstreamID.
+#
+# Since: 11.0
+##
+{ 'enum': 'SsidSizeMode',
+  'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
+            '10', '11', '12', '13', '14', '15', '16', '17', '18',
+            '19', '20' ] } # order matters, see ssid_size_mode_auto()
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 193bc39059..24aebbe8f5 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -68,6 +68,7 @@
         'S390CpuEntitlement',
         'S390CpuPolarization',
         'S390CpuState',
+        'SsidSizeMode',
         'String',
         'StringWrapper',
         'SysEmuTarget',
-- 
2.43.0


