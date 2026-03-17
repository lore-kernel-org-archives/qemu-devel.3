Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95AEFEDA06
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJl-00045x-9Y; Tue, 17 Mar 2026 14:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJj-00044x-PW; Tue, 17 Mar 2026 14:38:59 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJg-0002wk-Gy; Tue, 17 Mar 2026 14:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYj4/eo5x9lrIZfHJEoIdMXnKlqUfnmOSgJYX/MDNhz9sjKOvOW18MtHQ75VX1dAVPLsbwIFVWbwptTMPNvsFn7dY/lePvio91FzkRJZOPk8aT1Z1V4FQetzmVlraWKFa0hOOPlPPVLDU9wI9EPWdAFuLeQJAWj4in3M6heaQz6ns6z6TpmM5dI88zgWUBTbGEDhTHVlIJP7RbmrysSvjNatCs9VgF6+AnDrmBcr3holjFBpz2YWNedIN1rfywFAzc80nTdWU97tcNvWpRS1Z9zH57W6lw66K2VdORPQbzXo7yz3FSN/bMBhPwzsa8+h9U9s0uubMcyA+Oh5P7TTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5BJGJNKpTNCsPMMpOFJcDHh74TseA3YKa3/LyDWeZc=;
 b=m1pGEtgvL67DhyEgknRGLs/X7upg5chOcyDWyxDjz1pAFdnlooUbivGN8SupDC0VADSVz4JiZgB5vejmFFBOqddphqBZ/GH0tTsnd8UUch9Me2D2z5AyDrGeuzpR8T7awuenhBy55SkkWB2dPjHdERebeF6kWBJLgmfo+UCFOles4yqGkqy3NRMB2SFur04r0PfqJ/OJRlU8/kKPAWRhtv4KYq2IK9Q36TAx16CERmp/VV9D7tBaNnAFBHYIhwNPs9b5WiEIz2sjQwy0VjRa1jAJRt93gaj1dRB8P6bMSEn9skunUo3h/bkQyQAEhchjC6eNLic/RfbhK7xaRQ03XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5BJGJNKpTNCsPMMpOFJcDHh74TseA3YKa3/LyDWeZc=;
 b=S3MrO7dFCFbc19pknEmaHQtOjMYCp1jBujPiXptgQ0hd3UNC8slLk9LEZUzCQNd0hP0IVAnNDxsr61vfWlwDUc5SqAvbepBPsCk0MkOCxx1NbBQ8SIc8sqNdhEAl/5h12IWXhTtHtiYzLCcbUNkTJNMQD7Fe1juug1SFzNwt+vmzDRphYPXwbYxU+i7KiOhzxHkZMXTrwmrUF/SoMR7fH13DOszTnoP/xz3HlIKvJAGC4/07mgjEXHO6GYpg4f/cLSUF7kkWMWvXsDCOyHiMZ/72nNxYiuyoFroVg4mZoIQrpCf+8KX3wszLS16iQAB1z3AGjAEYrwsgKlbt2hZMgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 18:38:32 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:32 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 4/8] qdev: Add a SsidSizeMode property
Date: Tue, 17 Mar 2026 11:37:51 -0700
Message-ID: <20260317183755.3721625-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 77724820-1a47-4d1a-ed79-08de845463f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Dq7m0mb/2xqv7FCuzMLagG/SOarS7jWTit+fogY3fa9GxO/6VIiobOlTSsu8v4W/RwoK3fCV34ObsDrK8WM0UQ4a0hIQ7/j4m+Tp3FpgMkxNtdrqG7LT71iyyg0o03jkafXNc9QWaK+qzpuJ7Ewq2sRzftH0FnUzA9J8HaIbnPH9HrQ5BTUyu5ctjUeHJ/IXTmZrarqcjsjFJqHBbZs+wcpDV0fXseWvjfMuoUgJAla9nDmff8Xq6O+TB2Qe/GJQShMB57qft1OkzSck/f86B0RtxIsdoN4R8zKDvWQCNoR+0/fuh+1MLozEH5ATKuXL35JqmzO50HluDUIA7xiUZtex4wV9qyFN0jSy6NFtNWAR9uzSm2by6PMmEgw1bNHUVh8VpG3F0kFNmuFLKHn2LmvZjyuMqU/zhZ/NfA0kJKm2crLNEGJCHlGBHusbW+qCIsaIPgBBroN8fM75amYIm9oNtofm5UM9P8grBfiJG0ZyZmYcreWu6mgSAwyk8vR3aKFnR2UXZeDPJbhQlCQkaYGdXw7DqqEpZgCfrbmPpUU+iVyh5tCwC/fhv5yFnqw+fIx3X58dXM/1hQX/coCyL6jIJeM5c1RdXSXWgk+G6zImjYODc/U59N9oLMaCAm/vfz47lMep67pdKHTDMHmE2U87hg8hfvmRc/brTtPc8X8ZZxiwpn5VBbgZQGfzp48ERIM+rglNtFCldeVUMrD0OwoTmNEPqK502/8Nm+3eKXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CWDu5uRpMa7zCeAzi1GuJSFbqLekYk/cQPMv7R+aQbtukAnMYpRTn9ORCVNt?=
 =?us-ascii?Q?XhvKK1JHgoEJj2PQ8TQBx6Qlrr6NBzZHJX6RQjs+ijNidBh8RiFsYYlsiYfO?=
 =?us-ascii?Q?DCPaFVtAucztjHPLgL8gvrIKVRYHn8nW0adrXnOWuvHCcHVrrF5vUn4Jx2Kv?=
 =?us-ascii?Q?AX3RxuQ0ouZCgo+cztxlNIYlYXDG/KkdAS1E5VmubGXiMSJNoabNf7FGM2ZU?=
 =?us-ascii?Q?aku6E2q/Njaz00Y60zcnqjQ2e1jd6huIfsYDiWi/hI1BWldKPPqnuaLeN3ee?=
 =?us-ascii?Q?LTZVYjfzbssSUUShCkbksu2DOOqiWzjEapIz0Q2k28zdbMhErzwBPAiRDZ8s?=
 =?us-ascii?Q?CujidAtHYT3DYC+D0tkLLk3m5DjtMPV9f9hfIXRSg3aZR2Yb6xE+31r9jUyl?=
 =?us-ascii?Q?rjPENO2NMvzO5eW3BxxRYTKuPpQTPpFJHPwE5u0ABNhPoZZyMBSGhn6tK4yM?=
 =?us-ascii?Q?zfPzlHj7JPMY7BI3mmAOta4ya8+phd3+orFx7s/jvf9PqdgS5xMnpTAXNUae?=
 =?us-ascii?Q?1BaTl8aNfdiSNIH0Nmlg12mZJTs/ysfrNilwrYpE1U8IgQN/Xt2sFnzzYPS4?=
 =?us-ascii?Q?Bn0osE+JBBI6XHsWzBAwYEKm22K6dQABVST0BRlSrDL/4/DZM6g5hhjCe4BK?=
 =?us-ascii?Q?jtMGhp2Cv5qurLh5MTH5PyizUL7EM/lldaFiBUzrrCj64bUGikyDS1x01vB+?=
 =?us-ascii?Q?+BZ9eR66jWMgSYf5z5k2MN3Ukw0sZKcUwLuz89b1S2q/xWZda+xJif9bVsmL?=
 =?us-ascii?Q?73DzCm3jKhLFjFaL5ANndAxuCyE4Y+Q4m6IrElIq6IONWXnBvk7MxFPzpzIi?=
 =?us-ascii?Q?RQBuiySZW82VyhdmTiTWxXi86asKtbKau0R4TyJHXZpYmyvuIwEk8ErKEaX2?=
 =?us-ascii?Q?qObnM3kGFgVfVEfbp7wBiNXRPsAa1mdCAYVJI5jbM7WJXmusgyJfm4CbtBtX?=
 =?us-ascii?Q?Zb3lPCijXBcdm9abVqTnqkTi2kjC/1WesVZSMmU6K7amcM3KbgYLWT/OBGIJ?=
 =?us-ascii?Q?Gyy8FBs42kn74qkGPUuP+qC53RUvBNoiRYoPz3FmSo3I+QKT6mkVDIGmLIFu?=
 =?us-ascii?Q?9uuCFpudORbPV6LUEU7Kj5FnCAwPzvgwwWIfgUjSjkitRw3nKV0RIjibSk2V?=
 =?us-ascii?Q?uQrqFVVZpmtOiIYVsw6xI11dbw1iWhKQ1FSsGHfXs0e6urZn4LybVtTwfsrz?=
 =?us-ascii?Q?V8od7z24opw0KOZh4Lc651n5Lgpq7O8zNPAMHXHNqWOaylVF5LRYgF0xJLkV?=
 =?us-ascii?Q?RCxvN9kMmCL/C23hfMPKOqyNsWf4+IhHNe8yH6vw2G6MRnSP2O97qHGliJwP?=
 =?us-ascii?Q?1RfK5uourIRyaIr9OMg5EgtjuMIwhCzzP2iFqvnFNu/hJ7YKrwAfbYbvzgJu?=
 =?us-ascii?Q?BEczw7FKQukvwa9NEfsObdT6qpD7nGsnzRc7F+90wdtxIXMhZd14yJiOhaaS?=
 =?us-ascii?Q?FjncWCW/1yZCPk5qqQzDu1uVkw5fzbGHXZjVw4sHusODEoVlx9CF+iPSume/?=
 =?us-ascii?Q?OY4E30QLMQ9IO9FD7tLZPqOJKb8/7X8rPQ9UPzEsNHfwUh0V7FWbouBwuuef?=
 =?us-ascii?Q?nxxDiJp0HmcZNqyc1kFMZKie60BWTjDoVPjVKVT7ic8HPqZfJCOMP+TfPEdq?=
 =?us-ascii?Q?GlryAtNvEElTLm5Hrf/kmFP/rmS8wuFfalx5EsbX00HZjKhj0i1NCliY9cK8?=
 =?us-ascii?Q?EIRPCTnzXG+Fx+JSuNdP6bklm7rp27Pa9vFFkIS2FM7yVRSJIHE2Rn7r49E8?=
 =?us-ascii?Q?qmVFZdWuqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77724820-1a47-4d1a-ed79-08de845463f5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:32.4831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGjXeVyOv++BkIxND0kRdDzVsmtTLPOnXQRLNBm/B1IWgCbYjb7o6euFA8lEqYwigmOVkIt49yBDPU3tEwY/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

Introduce a new enum type property allowing to set a Substream ID size
for HW-accelerated smmuv3. Values are auto and 0..20. The auto value
allows SSID size property to be derived from host IOMMU capabilities.
A value of 0 disables SubstreamID, while non-zero values specify the
SSID size in bits.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


