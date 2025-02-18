Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04F4C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 19:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSrx-0003fK-De; Tue, 18 Feb 2025 14:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tkSru-0003bF-FO; Tue, 18 Feb 2025 14:02:55 -0500
Received: from mail-dm6nam04on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2409::614]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tkSrr-0003oe-9N; Tue, 18 Feb 2025 14:02:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFvqd4fIaNGQ+700Xizf+XbV1s5MrxL0Aj1DDbFj+Nd94tZEzfrA/3rfw1l7ZDTe3oosFKkYsOCicSvgxfli9jqueKgDr+v1yM0Lk5n5o28zDsIMDhBnqj+efrNVW0SCR+H7z17H/9ub57+tQWdKHPGsw+MeX+VnwasO2HE8lRa0fsyHXB8L7ge0ei2ytSnrunAvzaCMre6vpyNyBkkeK/cRLJwx5nuQy8ORxaT9b/pyTDNS/NasIptYRPH0Y6jptMvMeH7iL3zuqwJrcWPPOd3WyM9GQQ+ZXtLIQsowQeE3l/PBFXQJRB+ygwudd1xJXnPDkbhbgWuIS/3FJmI6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMoev5SqZ5hgw0RR8sj3xzUTqMGtBSCLFCJPfx9qB08=;
 b=RoaChE3+2k5plCch2JgXAf462pbPVAEnB5XIus9lcxeKkJQFekQMF7u1Q47GDstkLzEp18LZtxIhwNJhhRyRivfGkzrCYCNxrruh6ohJnAz26YDmRjgb5mVXIRTkNIoI7pxSgZ2OrMr5ZWOL3K31uE3RnV6Og2OWgvnLT7CojPsTeVWPKnP7XVe0Wj4ESUch+rYy94MKkYaV0ULmj4adLRkMqucvGT8mPQltOxyKCSHj7NSj1U2ES1JKpZ3kUQVSb17i7kloBeKXkFJYbphfzeQB/dqvEklZcIH/pPZY1TssCEZ0N8ewFzPumocoi67dnoCGf//+6wih0X/3kt5BEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMoev5SqZ5hgw0RR8sj3xzUTqMGtBSCLFCJPfx9qB08=;
 b=K1TL3m2vNp1JOH8nVdACOxRbfaitIkUIb6RR8FUYLPnK4wBh7vXIFEVNzxePsf+bsPLEievkYUeQrHGT9cjexJekRVd0hn851GfTC4Ib8l7EpiWJCXEMERmPO03Ro0A8TGBo//S4Z4Hk+EP3L77NTmyOpjtXfhkHWayM5+d1EQq6wdn6r6KvVSaeyraIaKQamaME+Y6QuKzeWsVo9bwsPDTqk/cZfnmdXSre+eqxyeUKRbKoykPqNy3fpVIoqFtoK+nDrRyh1b8UDTvGZQ1R3AykEj6KHQNUVmA9niPX2ou2uLa09azGpubmXn4GRrPdNjH7HtnygF4e3ODHrH9lPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 18 Feb
 2025 19:02:41 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 19:02:41 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com,
 nathanc@nvidia.com
Cc: qemu-arm@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 ddutile@redhat.com, nicolinc@nvidia.com, ankita@nvidia.com,
 philmd@linaro.org, gshan@redhat.com
Subject: [PATCH v5] hw/arm/virt: Support larger highmem MMIO regions
Date: Tue, 18 Feb 2025 11:02:40 -0800
Message-ID: <20250218190240.3070040-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.46.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To MW6PR12MB8897.namprd12.prod.outlook.com
 (2603:10b6:303:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8897:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 56132f78-398f-4a2a-1d1b-08dd504ed1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NMhZhmKk56YjxtENmpnarNZZY32geQSItk+C9RDuTCzXjtjVGE4STNtvXwk+?=
 =?us-ascii?Q?NFt/BzKikPxNwzZXD0SYdooChAH7GxNVRtH/3ievYCIDr7G9pbGPgyzXTcLN?=
 =?us-ascii?Q?XD3GL1ujKAdB/gjHFuB4IvUhrL3i1yuV3ronvA+sRDIfJ9EULvCXyiGj1bRg?=
 =?us-ascii?Q?kjqAHRh57J6ECBbvc0eSJjh4ABlVquGrwgwtE+/uKzyXpDIGcQ0ZzvJm4M09?=
 =?us-ascii?Q?ulsWOu5yUmGrLNFpOOLskihj0q/JbaLngmfwzQ2+2FlJASYGasS09TmblHKm?=
 =?us-ascii?Q?3kGQb9oLMFyxCASD6lv/IWQjInszE+57nPS9dQQhh5HEEMv+UXv5phKFoqEh?=
 =?us-ascii?Q?sRoGMe1mVPXWt2ZODiA8x5sU/+3x7yOEt6aee6AWxa6tOECVm3cG61AQLOl+?=
 =?us-ascii?Q?pPfjrfgxiR/q4jIWa+9fAN9BxcSEkTN1xnY4czuuJwYLZ7lxFsTc0KPTvXbZ?=
 =?us-ascii?Q?s6IV4AXuNiLOxMMsTVMeSISw52QkM3oKHo5RgojaahxcMYowz2qpV87yL/x4?=
 =?us-ascii?Q?IYRFIhqDNEPtEqMEC75hvCoaARGFMkTRXPbYQgqhfJ6sPj6T3lr3ImIX9d+y?=
 =?us-ascii?Q?ci+KFkWBEh0oelFTJJH/h2kLw/h7+qoeNcU6eNJBzHs37QUvBxR8Hg/3rl8H?=
 =?us-ascii?Q?RegA2x7v5wj99RAhMGTjrWKVvMlIp17TCpEXAanGttqb3vyIQOUDISjVzILO?=
 =?us-ascii?Q?Ib6peRfaMWq+Px/orTe7xUgWe5n221+ptA78yBvw0PxXFPowkrxhf7vEEg9n?=
 =?us-ascii?Q?t5KyJoF6HwgUmzQ0SKbklVcAPu4YWZv8DSz0aDXnqUR0UrcFHE13k52v3S8R?=
 =?us-ascii?Q?2DcR/gmcWl88MyyvZPepzNWwmXTl1fY9ywXf8k0IXwxUmJbPYJlnkKQwXjLh?=
 =?us-ascii?Q?7KfvMTW/UVS17Ukjcus+nzW/5uWs/5e66U5uk8Vwjk3gzZnX0as2VwxG2ACo?=
 =?us-ascii?Q?zGD8qzPfeQIEZlfVRRxkAg5VyWhdIqrTxly9iIUb0/PT+GwuEj9kkVDEZBss?=
 =?us-ascii?Q?GYYoC4YHeoPidF1FXqNWCkCLrDOjK0fgyIoiKmoI/4v4kx5GmikvEm7MUN75?=
 =?us-ascii?Q?bUdOrxVJBKQssBS44ltggoahhVv04IuFpQBVBmU7xtRnR158t0gU6EFMhyYc?=
 =?us-ascii?Q?tXmHKYoBU/Wki1KHSvIvYoXh0uIGkzj2U0+7s5yjhONiwdZUppyd7A1sy53O?=
 =?us-ascii?Q?/R4KOC2Lqiql5VAFShEWqGs/NQpDJ+V8B01xISDe1QjyH8+plifqGb71Affl?=
 =?us-ascii?Q?vAabwN3etdahsLSyqKqs2BpeAnU3J5be4lz62abnyMaitUr7Sy4xMgRFnx2v?=
 =?us-ascii?Q?v7ypytmeNWfSm1nzDxVVDUbiZNZ+6vj2d5Dv0kTlAwvFleRdioNUQ6s9a3gN?=
 =?us-ascii?Q?jCpeA1Vt1IOKOgN/5rUNjqETP/73?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1lQRt1bJoEhp6Cl5bC1j4t8bN4KLQUbJRUoTRQcwpFJFWIEv/MgYDmh3UNT?=
 =?us-ascii?Q?1BEw5jZhndF+wEJuYPaPMS9DZ7cu8YNlY77Gm0Zcxn9ExxaLyzExOA7gPhj4?=
 =?us-ascii?Q?QjRAOc9UB+x8buVjDuRrcGW2l34ir65fIyKJ2mbP6sb9rVBR0V4GaZqFyWvt?=
 =?us-ascii?Q?AI6IIg556lAqi5cwpbrQdNHFFNFwyc4oOfVloW5bGhpGjq/1tzttpWgGj+Nd?=
 =?us-ascii?Q?jM84jXqIxJvh7YjfNdwcjPOJ5ZMww/ywfyv8n3DeHvunxoLom0owE4nEYfrD?=
 =?us-ascii?Q?6zQqAwcUhe08oQ9EAsSyVWjmZhdrUI+OJ5Y6aOj16EILGpdNpkqv7oAdxS9K?=
 =?us-ascii?Q?M+VzMzvOu/O2HZepoAmuQo+YzjBGfngGs826dmHwlfE9sr5iCvr2XfhQtUtX?=
 =?us-ascii?Q?fg5NsyGkZns3YZMRq2LQTXEfC/iU4uhBxv532hAu2ZVHMPEq8FJ5dqf8OGuy?=
 =?us-ascii?Q?mcklsHtSMuMbwDGH9/cAOOGy4ucQOygHFbTiIJht9a2a/O5yy6okukAbvQPk?=
 =?us-ascii?Q?WDQ2te5BMisj5EPYiie9OKVQ0t0fVeQhaydWcc02tAEUDizTsLGV7CLl2a8a?=
 =?us-ascii?Q?PrwkT++hllsU7v97sdtEWSxDb+ezgIsUDSQ/QqWF3PzXG7DyjwfBeldcPxyX?=
 =?us-ascii?Q?rY0Msc/o7o7f2x9XuoWhQtS9XWDh2b5T5ZEPveiPUQ/K5rHrzqIorSfP+S/c?=
 =?us-ascii?Q?vmGWp4QqfKwBuZC5QL1sbQqJffZyzZyBpkYb+FGKG5t9yBhiJGYVSZWQ45Hr?=
 =?us-ascii?Q?tfcL/N+UpRFMCoxvs/LjKsipusqjMKvMMJCkoB3DNlfr85FlGMBe8QiBourF?=
 =?us-ascii?Q?3Se2p8Sn9+DRlmjR2S6jHPSR3KCVzFlo+h/hP18CP77umzCE8iHgjXoAF4ZM?=
 =?us-ascii?Q?JJFaQBuU+jO1VB9YF+ERln2xGgQJNblBA6quGrweqacLCYMgPBslSgvOyA4p?=
 =?us-ascii?Q?HyYdw/CbqI4ogsEqvL/2b7rYtwSuampIrfzWtDs0ElOMSdK4yY9qavnaKsFT?=
 =?us-ascii?Q?1l6bnTsT0lJzZPFhAsFccVAw005NU50y6n1f07lI2PogVCztaF8q5OBDIuhF?=
 =?us-ascii?Q?k7c3sm1KjfannH/CKWLaUOan8g7OIWK0IRFSWBXWgXbb/PaMMD8Pr9pQ0aj+?=
 =?us-ascii?Q?FLcFFyrYUxLOnzu6PHXImE6DuOc/DuXG8ljx3etb4lfw4f53lukYd6bPxtne?=
 =?us-ascii?Q?gXgE2wHrDkGgYFESxghW9z5awq1yFkzwK7D0U8Fqialuel6JaekMlSz4aPGW?=
 =?us-ascii?Q?6hXhHzYqFvw562xmKK58g8/EMmEhS4yKWdF9+qSxoWoaPmEIkPwPUKGo+BsG?=
 =?us-ascii?Q?ee2C0be1VVJBmDk37nO2EGqwl8OXJPMLSLMwYUxr3KhJp/wr85n6Q6K6Z7JD?=
 =?us-ascii?Q?xfCUTHclvXZzz+Mx2w1wl+1X0AFbEXTDnUaJcV5qm6PoIgc7IcXGZEoaOJYd?=
 =?us-ascii?Q?P0ue04/w1AASmckC8H8OEMjdzGBteKokevQPklpane22RslFW1AykQlOnCLH?=
 =?us-ascii?Q?eIY2p+2W3rV/9BR1t+Kjx7LLmUcIJ7VeX2eh2y75kXwu1UuGccfU/H87/5JO?=
 =?us-ascii?Q?5FxlhQPm+4H40Ex5x1wUnNnATxCVvow0cfsnWxzh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56132f78-398f-4a2a-1d1b-08dd504ed1b4
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:02:41.3771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voP4xFkVXcIJ0SVows/pcoG0uURbQd7JyXglVXSOJG1rm03N0ZGP6bed/Eg4xuisHhL7EuZ1RQdMYKX8KcEwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
Received-SPF: softfail client-ip=2a01:111:f403:2409::614;
 envelope-from=mochs@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The MMIO region size required to support virtualized environments with
large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
(currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
new parameter, highmem-mmio-size, that specifies the MMIO size required
to support the VM configuration.

Example usage with 1TB MMIO region size:
	-machine virt,gic-version=3,highmem-mmio-size=1T

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
v5: - Removed hyphens from power of 2
    - Consistently use property name in all error messages
    - Use #defines for default high PCIE MMIO size
    - Use size_to_str() when printing size values
    - Add comment clarifying that highmem-mmio-size will
      update the corresponding value in extended_memmap
v4: - Added default size to highmem-mmio-size description
v3: - Updated highmem-mmio-size description
v2: - Add unit suffix to example in commit message
    - Use existing "high memory region" terminology
    - Resolve minor braces nit

 docs/system/arm/virt.rst |  4 ++++
 hw/arm/virt.c            | 50 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 0c9c2ce0351c..adf446c0a295 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -144,6 +144,10 @@ highmem-mmio
   Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
   The default is ``on``.
 
+highmem-mmio-size
+  Set the high memory region size for PCI MMIO. Must be a power of 2 and
+  greater than or equal to the default size (512G).
+
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
   Valid values are:
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a5a9666e916..0d5382904a04 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -53,6 +53,7 @@
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
@@ -192,6 +193,10 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
 };
 
+/* Update the docs for highmem-mmio-size when changing this default */
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
+
 /*
  * Highmem IO Regions: This memory map is floating, located after the RAM.
  * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
@@ -207,13 +212,16 @@ static const MemMapEntry base_memmap[] = {
  * PA space for one specific region is always reserved, even if the region
  * has been disabled or doesn't fit into the PA space. However, the PA space
  * for the region won't be reserved in these circumstances with compact layout.
+ *
+ * Note that the highmem-mmio-size property will update the high PCIE MMIO size
+ * field in this array.
  */
 static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
-    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
+    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
 };
 
 static const int a15irqmap[] = {
@@ -2550,6 +2558,38 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
     vms->highmem_mmio = value;
 }
 
+static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
+
+    visit_type_size(v, name, &size, errp);
+}
+
+static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    uint64_t size;
+
+    if (!visit_type_size(v, name, &size, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(size)) {
+        error_setg(errp, "highmem-mmio-size is not a power of 2");
+        return;
+    }
+
+    if (size < DEFAULT_HIGH_PCIE_MMIO_SIZE) {
+        char *sz = size_to_str(DEFAULT_HIGH_PCIE_MMIO_SIZE);
+        error_setg(errp, "highmem-mmio-size cannot be set to a lower value "
+                         "than the default (%s)", sz);
+        g_free(sz);
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
+}
 
 static bool virt_get_its(Object *obj, Error **errp)
 {
@@ -3207,6 +3247,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-size", "size",
+                                   virt_get_highmem_mmio_size,
+                                   virt_set_highmem_mmio_size,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-size",
+                                          "Set the high memory region size "
+                                          "for PCI MMIO");
+
     object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
-- 
2.46.0


