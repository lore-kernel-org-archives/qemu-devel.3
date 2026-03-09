Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFB1FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgCL-0005Yu-BM; Mon, 09 Mar 2026 15:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBa-0004zL-PH; Mon, 09 Mar 2026 15:22:38 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBY-0003e9-RH; Mon, 09 Mar 2026 15:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeYERm4amiadwC0kpYQr/vt7dK0qc5hgYIk1W2N8OBUWJb4uMWJMfkLCyXM0UxPrxFBOXEgAXVd+LbUKrA6IE4NQwUzxzwmd6AsgXT2FLPg6LHtAoSLX42aMja3jvJWmK2mTnIAfuhTygDiFZwwXa8KT/mr/dDGzcPvQXxVv/8SNTGpYjyKzaQsxrCodrRbKh0Q5G9jaUgju5gritgASXj5XKgSF6fMMdF/1WLHIqJnK0Z+TxC/PGQ9vW0hRlZQ3Lj+tc0T5411t5+VvlLnNTU08KhgXfiWGWEea9PPIY+D7Ir43FZopavHLnZ5AeS370SPMuxkcSLE8SVzXcyJLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fqAJPqsRvMi0Y7N1SZjOYz+A2Zv4eKpEWx3J1KI0xA=;
 b=kod4Z0cvOItQaxRrkn3ttpzXHvzZKQhhdHsaNBEFiwEp7HYkRnhBMtW8fw9AFZIyaK/BXCNQ8G8Jkht+7Y14sqpwPdXYa2UwqRHxPvKrJ0BRcULF62jHaf1GLDJbcCuQcLLuZ64vfqCyg5kTgUiMTWJqrqKhihaL4FR5FZNfBOIJX2fGDuiexVBYBfegv6vpzKQ0qZylzjZtL8g+zD9MtLeSauYb7Ph56WaSzq60iQvF9boBIV69NHtaStN6eqj8zGr1cogXuwzNat5uGNMfXvAWW/t2dcZQKDphXfif7+thLQPdqpeCVvJqx1PhcOlQxzToAOQT2HI8PwUnE/gLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fqAJPqsRvMi0Y7N1SZjOYz+A2Zv4eKpEWx3J1KI0xA=;
 b=aqSgSIbQeBe/rts69ZWQUOsWwB3fnLAA0CHIZUU99cuaZ4Dir1/CdknGNe2Mj76ZEWlXYAewfY6CRIYGRbPjnwO7UI6VMd6qvgi7aXflIEMU6PuGLbiRAn5B/B6PTJNXMkuZT5dYIHkTQaUNlfyXdFvwEhN9+DbUotJ7l74Vneyan/p1pho+SMUpsmYkSJODuEsZrcXISjZWgA8S04TH5eHwY5wrtgHhTMGW1V1cJHj9Wjvd5jijf69etIDWSH3T9xooYSHPCH2mmgZ9bPpYukr69eCJKCqow4B5skvWt74VaGocmRbdBMQZzmjuMrrHExIjc1ibjTHcerTxNOzFLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:28 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:27 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [RFC PATCH 5/8] qdev: Add a SsidSizeMode property
Date: Mon,  9 Mar 2026 12:21:16 -0700
Message-ID: <20260309192119.870186-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cff247-153d-4360-b8a1-08de7e113381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 4Us7yfIqEs3qtuEAWGsnkSUV8MJ0RqqWgZkpon/Q0zyScGnyjGX8kacp3wD/JjbsUsy1hjRo/D8HUsL2f8YES1UhrgvPL7jmW1w9Asy0fDQ2Rk0vfjwo3Nzas3XOHLJoQpJIlokkIDiSP+GqSC1tpCFxKp5BPbAfBLESBf6Uy8WgcMQRjsc9N3gLjCW98CtzNnjxga+JbomWFydR5DyWwGXFQGV4zeTt/8nWGLaIqdYexPDFxeuDYIrfos0yqnEJcV8hV7iaNwWtoAzumDNxXRN6g6rVv+bhWjz0bbhY2N0VFtjGKlB9nshSjLhtrxywpONSJjk1OVvifuxaiYs+iKrBbpnM7ik+BsbMImAQn3B+6Urj34pBDV4nVpMId5V57wXZkVVB7CLmURH2wNWoc28s7TKBrG6ySQhrtjuUXnqFeSyBv9F2U4VmoXNGYJsfNpxj/9sG3MMgh7RpAsjcuJx0rViY+viQaPqWqlJxNAirRoS/P65tFay3SjyqNCRF3Co7CQ9kbal3w2o3MB6dGtJlu2wf8V5YjVTiKHUMyHa9SiYQd0TERh6RkA3BuxMe4GNuK3FnxP1YC5z5Peet+5rms0Zn3ko/+PWKpWq8/6M+GmoBrxLkxW7wEIloHMVBnbyu3wKcuZuUA/E2GgCnZe3npq9AWQcYqusMDxEmjf15EvD+djYOyQk77H+mYH8sDQD2K5CeqpUlMokcpLitj2TjnIvdFFX2Fu5YJpqKmAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2eh8LgwsIeS+gVvsgy2QozYEWSd7RsXOLMmxIrpI4RCAApq5xjdyKHWOh/Ke?=
 =?us-ascii?Q?KbJC8sfz7iJqFyg5B1RMBL5SyMbSJFPduoM9eBLI1+KK22GP/cbgRv9O9/+Z?=
 =?us-ascii?Q?5hklhTlIUJfrNcsQ+TtvW+uR+WGmwk75u5v5tQT09jRsxvPybHR/BcHsqijd?=
 =?us-ascii?Q?hNynBphflVA1LhL7whMe9OGL2xbRFwME9g9rMaINnX+5jUGrPiCuK9wnLDIh?=
 =?us-ascii?Q?ZdizsO+iift3ZXdv2uLxYZ/RcyZfXVM8/sneStxt18BDHur4gUH6wNWXlTiw?=
 =?us-ascii?Q?UybyYsbNm7LVEMnk8ZVWj5gXexcV1WFzpuzxmOcP6Q4F5JH7qQMwT1ShEyUe?=
 =?us-ascii?Q?N2eNKeX8XpWHLbuLBRf8SsCMICx9PUSXixx3Dg2sw2Fp4mSXSOGBiab3YAt2?=
 =?us-ascii?Q?9Q1A/+V6+ZD39k1YBxD1py5ER5qlSWAKf6myR67PFCOT2/o+ToCd4YclZxd5?=
 =?us-ascii?Q?z41AJskmFceqwIimIDA0izE8ksiasKPdI/0zbg+t3BJNWwWLbZ3Yq7APYoRY?=
 =?us-ascii?Q?V3AQZvJBK0wKrWxDdseAdXe4lkZmFBaUm9jSgngeCgvxbGdoPq3aevb8gtBd?=
 =?us-ascii?Q?9EmuKZQXWPqr98fIvMKVyIqrC19/uFh8Sq7rEbLO052KOh/Jfo4GvveT/maR?=
 =?us-ascii?Q?O3dhTbctf1+WDQO7542g7Z0TakNnxxdoKeOAk1CVkWWIqybzuhVxvPtoHKSI?=
 =?us-ascii?Q?DIBznc6Z3cr5yriEuuo/CEZ+v65oFpWeabBVL98J/EMMwmeEsFSXJfPxiK03?=
 =?us-ascii?Q?YWlgM3IG+pSbe/Ke8WW693+oKup894PJ29u1GTPyX1XUt3BZx40Bi3H0l/Vn?=
 =?us-ascii?Q?PNSTYBz2uvSIlte8N6Uw6Yc5aAnoVk0kwTlM73RAOQvs6Xm71ZmZXEuMkJLe?=
 =?us-ascii?Q?+ySAmol9dw6RrL2TC2VEWPEH2unv/9pJSWPCGU0+B7DaxgOUe0hJlhA7y/bb?=
 =?us-ascii?Q?m+6YGgOXc2ImT9KyieRMfn0s6xtzsJTARu90I3FYgIBCZybLTqTGh0Zhef4s?=
 =?us-ascii?Q?SYYlqgXgd9ZxqWJ7vntbgmRFflHyukL8Pfrjk4hfZQDJtrDdb0qMqRKn8A1a?=
 =?us-ascii?Q?bddSFz1JbHhAaXEEqCU/o199o/cRRJk7o/j3TtleQ2eKRr0IjK2COLaWa2O5?=
 =?us-ascii?Q?8UlbsfCpuqqdVzqiCLiMah6Elsy2ac4GLLgQ8e7q11Y2L4M9WEBUuwTHytTi?=
 =?us-ascii?Q?qTMOPVBRgDjlzylEIoK/aZ01cYO1yz51UuUgDQui9YD4fmaj9MuNP84z3ggX?=
 =?us-ascii?Q?nj5RaGGPzm9wPsWUJpUdgqccdl6at1uPi2ZfDGHKu3Mz6EC7uuEo2D3DP3iy?=
 =?us-ascii?Q?O5hbxZznk5tMLu3XJIpvfU5Gv8AZFGIKkrlcJmebJtswk36G/gIhXmAYgpDC?=
 =?us-ascii?Q?T81gXovJPTYIjSQh2zJXnGpp0EVV1Gx7tuodfm7Nb+XlDtsvnASuZo3SZfP9?=
 =?us-ascii?Q?4d8wbx1CPA4yDgHvy42AjFjok95ZKa21N85oLh8EV7N9Vuzet/K9IIS3l2VI?=
 =?us-ascii?Q?mCuA+Q6u8qPdhUouHVLyOokzbcKTYY6tHNLkxsoiNl5jqZ5lNE4QcSgtgmkN?=
 =?us-ascii?Q?MhHkDDBqFwdKv64CWD1/j0qLrX01xl6upxHhLt0cM54DCLYIdtNYK0b4h0H2?=
 =?us-ascii?Q?MRcSLk+v3fmg89is3MzHEuZ/0M/SBWt7SuEGndkOaKCEIOVIGStkfoe5Yo55?=
 =?us-ascii?Q?7CPtA+BQXj0SIVLuwNEHdk7vhMJ2uJKGBRnZ7XX7dFYjvptZSP3Pn/Ysufvy?=
 =?us-ascii?Q?c6WmA+79pQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cff247-153d-4360-b8a1-08de7e113381
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:27.8716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ooj+fjinF5EcldEeGBfY/3YssijQA3pMBx32jJ59drF27danOrUMpfZGjiKMpYkxVJ934IYEtoYEUDYDSTEqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
 qapi/misc-arm.json                       | 15 +++++++++++++++
 qapi/pragma.json                         |  1 +
 4 files changed, 33 insertions(+)

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
index f921d740f1..b372a3661b 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -45,3 +45,18 @@
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
+            '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20' ] }
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


