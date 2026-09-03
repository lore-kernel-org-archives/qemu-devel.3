Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255D3C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CTC-0007TU-7G; Thu, 03 Sep 2026 14:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x2CTA-0007T6-Tn; Thu, 03 Sep 2026 14:47:29 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x2CT9-0006Te-45; Thu, 03 Sep 2026 14:47:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBg+HFMszYpcnpqDTdnAfmXc2Bkv16jjxXCe3rGLwAdRxeKIYhxSwvPjQEVXXSSwEGA+upI/n+sJTFQ7OtYi0zl8PloNSiwBch16HEWMnkxdkonePN4xOGG8WCfF9j57mn7fzt7j4MLdZ1wY6hH35aJ4ajKgQHQPKjhcOw8sNBCgu7kNY6tGoeLgzdqvnBUMSUElw89JRb4t2HJYzDfcTzfq5OywkhEL9VYEhhRf8yIwKR3GKpfM8A6EXBPlIHOfH2M/qkPXne8jqlez1XdDLXeRAH/Vod7R36tINGI/V2uRV8wL0YmkKw+eTH4CnPxnT3YZAr6kLBOm89iJT02JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qCqpPWg9HaEw9AkNFL8ZfZ8t/h/Nu0hLubNsnxPNPs=;
 b=V0OK/q4+FGFJ+0FW7f/MRCB7q4kfwcW70vI5WiuLnawwwWz4l6BntPBS7V1gDInJ/7N997FKzDLALfHLdadnJZpbNut2+5k3ErEmMuuCqu4Dc97CkZcYNAjoIUK6OOxN0Dx7LrgviT1hl29Y++9qnl27feCbZex6K5BG5VYQc71pZCenQdyHv2BsIV2MgxVZZ2PfApv02Pp/KVl7TsI4UXt/rqzSKE9g4ljh60He5vb2sybcFmTorw3bqa5se7DaUEakc6FAKrFqBW8u6rUhC1q3g5w+u8LL8AeI1dmEg4yl2bCRR/xuEVS4XJn6/NE51Mpi73uO4/3eLfyOsPphbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qCqpPWg9HaEw9AkNFL8ZfZ8t/h/Nu0hLubNsnxPNPs=;
 b=urZs3R8CTUIHo3Etx/lVzmkSWSV4TLcvzMl6JVS9dEgRTBysg97b0RLTif5SKeS/B2AQhes2wYraH/vmgSl1qTzjssqwPTmmaWqN8nCjoz3iT6HFdKR3eIpILrKDdIzdeYjp6FCZeP4P9Q4e670ezmOi45qK7jl1fEDOjbbFEnt82TBW8afEBn9zsawxjcHmsnVxiDnvAqiOLFR79WnTJHoZZF374lqvPeJlTGQHn47H/+ktKVgGQnAOXUbFDzVJHUk5U7QAok+A9y0vZj06bN2gq0poWkHTMMt8sUmR3OCuWEsUa1RFcoHnHDPSi17BqIpcFCSoUzBV2V6tVbgx3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:47:14 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:47:11 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Date: Thu,  3 Sep 2026 11:47:10 -0700
Message-ID: <20260903184710.2052780-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5c5f31-446f-4c6e-529d-08df09ebc3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GtVirOwfRurLt/EKYV5n1W+BmZ8wAGld+1HK81qbjnBhVA7OTT9PmMjuVuEYHoejL47MxwghwLDWYmtUFbnHXGy2NpyTZLHJXPRnxmKEvr1Opdx/GCjplCxsF2dncBDPXUOolMeIZFzETImLgbziZflW+nNneZXh0p474MDh60JyOR3+LnfX/GsIsAJHKijFMA64CZUdngisCBQBMLRgJI7lGn4VIXCK6ARfceIDRrWDatqtbOrVUTK8xbdllHlJUoj2vcRuoliGpV1gYvaIXC+5rLMS19CNzsPJQ6gblXF5cK2fnPQcoUDJG/9WZQh+L0h6ZfHJEKd6EVxlRngGjmu7dqSbNwcYR70NzYjmMMWyq3OJYHZOfJJ9FFNmIdtYcUTmYCWNIWp75CCBA3jCShCtSq9j6N2oxp1Tj//Dq493SoWwwezXyGqYF3f9CzJPjaQJlgZA2fWk9QmfbBOBLejgn3dkczWSJ8Me4ebOuJav7qyYmxyxx69xrYADeVLoNVHW/c0qevfDw7dz6LN+gheoRxpu066Z7sLr7OuuE4nEhKvz+TKQ/Fn2tSPaSgu1x2oW11Cj62mVDhl4faqm5T50r70+c6Boz8FYee1cfiOMpHN9FFBPIQUu036YZrK5N6Pul4/cuR9Ss9bE9G/MD5uwgo5qe4jj70dpMsWEHLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(11063799006)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V1udwiNMNrvaggUYeWBrg2ajx+uXvqy+b5l6y3DhuvTwhX2Kd05gTTYFZ3ZN?=
 =?us-ascii?Q?YPyOYuIGjofrwTsbWA0yZZZN+GaRPBYCeS9KwpH5h2P34wdpN572VxyiUXl6?=
 =?us-ascii?Q?AEI885Ym+X3diY56YkdX8j/z16RpFy76pSlzo/YVU+RSluKmeMW5Vt5a7gQ9?=
 =?us-ascii?Q?wKm7KjQuKa8AtONbanxBMyIf0fdIUimmfY0mmFLJC1InHDYUVXI8jI8LUZGZ?=
 =?us-ascii?Q?TeaD3iopULwY3NV4WAnsZKdo0usBFtNsviV9LI9Uw53CxLdwuyw1WL9vDLjH?=
 =?us-ascii?Q?jvF5rFG1yQCUQJGC/zhCtuljX9zg3I4OX8Mt8Ai8WJkZxwI9U/K1izwsfpWL?=
 =?us-ascii?Q?12GJg5YjxghWaeBBYEYeRiZcjlJYCTjdZJMPoF9RL2U5i/PQP01GE2Ia1eGh?=
 =?us-ascii?Q?CsGVLhWF5MYnKNwLqvvaBKWjALS1YZupQ8v2MXxzXCR5ozHoaKScXYoEsk1t?=
 =?us-ascii?Q?kTS86Oc56ESgzc/nQgqhV0aFOaUsWCMOLL8U3NFfdWmd2cR6IT97T338Cgez?=
 =?us-ascii?Q?kcC8w4zxP8WGJZC2K/Y/dvuzPhGRCK7KF7NuB5DPl17cZXJycJvm+ytQvdV1?=
 =?us-ascii?Q?xoyRgdfjIjq/zXOGn/+hP8RWixNRd76zzRfd0AZnrzIz7L/7MGhE7FC4BlWa?=
 =?us-ascii?Q?0CrjZu80uHqm24DcoTAqvX9+dC7t4G4puPXmuYms9EL2eD5uG3e8OaNEBsmy?=
 =?us-ascii?Q?DRz8oTPU7Ullm5fBkMRV3vukjSvbgAqcjlHSMtjoNujvjVpANekUUspKzGbl?=
 =?us-ascii?Q?pn2JdKQka+gzJIoPpsB+LLmBLfTIQnZw3W4f1658h294+XMRTmXN2Fe4x4Hy?=
 =?us-ascii?Q?QnAXXXIyHxldThv6/9OcLsUnfr7vMgRuV4A7eBNSCaGYftDGg9MzDQId3ym7?=
 =?us-ascii?Q?fAYbH7y+mJnR1t+KCiI1BxH+YNm/WQLSbUiT6QkgP3kMH+mvJHbxG6ljrL8W?=
 =?us-ascii?Q?CUwk2eMndSL86lAs7stUCof5BrDiQptTwWJ7nXExKKwD29uGDmvqAruTN0mu?=
 =?us-ascii?Q?bzJj4x/UqLX66Psc2E2VQ5Rw+B4ZSpzzbIEyqS3jQHHapUhJA9TVUacA5kI5?=
 =?us-ascii?Q?uRQPR3tOrBCo8cnZXSMlQhH2npBLo63mGDzF+a51N0zrcGWYn3QgKiGxtcpc?=
 =?us-ascii?Q?vVj0yFKEzUs+9rsRqHU4dlxdzdDAPXGfvYCuubAhOp3qBNlWaOxDLRSmaGSr?=
 =?us-ascii?Q?XcTS8DI5/wjGv9FJ4SFCG6ZQnuQplf2SYehQVC6HculLsZ+n8QXMjLrndR0Y?=
 =?us-ascii?Q?5A9IfiODUpMWkY90clGWvlf1KuNt62SERI4HY7zDx+j6/uBhw6yhKAUMQ62S?=
 =?us-ascii?Q?65yYdNWO9feL3WM47B22NAoeY5/nvUQ+GUaGV4ih0CXubLb/OVrne2TguxQK?=
 =?us-ascii?Q?/ZN1adEZ89ifKpJc5hX73/DgghYI6V43g/SjhHDbA5V/Lda9iMGNkMqSrYmN?=
 =?us-ascii?Q?hPLL2E8KqlnpozzyX1YVQVBMX5XQ/frjAMDCvaArYjEZpVzsbw5xFHwzDate?=
 =?us-ascii?Q?MzzjndBlwkPr12uAlWweayqdbdhgVUQM7DN7bWUEwZJIhMZTi2VY6j9c5Gmf?=
 =?us-ascii?Q?nSMu6NhPUVAAOiSeaWHgR3qiAADn23TMAJj44HzQtVpCXi2tVqwqeBZ4YeQL?=
 =?us-ascii?Q?S0jq9YpZMsjFf+Mb3jehNQ3gZxEczdpFvMYCECNxye4FM6RqUxyxkJW6G6dd?=
 =?us-ascii?Q?JStPN8Hq3qEQ0MTuBw7oU4N4h0y23dJjigDArJncsXaeQmKVSdWLoZw744jm?=
 =?us-ascii?Q?d99EdBDRkQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5c5f31-446f-4c6e-529d-08df09ebc3d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:47:11.8521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXp/GyVreGkm7pVPdmVbJvqjgXvqTK3OcuBLH7TSCBCfFhJ7vb+Q3qLEdWzqoG2HLvekhfJxq6mmnFBjik9jBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=mochs@nvidia.com;
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

With CMDQV enabled, resetting a guest after it enables VINTF invokes
the VINTF page0 unmap path. The resulting crash is intermittent and
has been observed on the RCU reclaim thread as:

  reboot: Restarting system
  double free or corruption (!prev)
  ...
  #5 address_space_dispatch_free
  #6 flatview_destroy
  #7 call_rcu_thread

FlatViews retain raw MemoryRegion pointers and release their references
asynchronously through RCU. The VINTF page0 unmap path removes the
subregion and immediately unparents and frees it. An old FlatView can
then access the freed region during teardown, resulting in a
use-after-free and heap corruption.

Embed the VINTF page0 MemoryRegion in Tegra241CMDQV and add it only
once. Use memory_region_set_enabled() as the guest enables and disables
VINTF. New FlatViews omit the disabled region, while old views continue
to reference valid storage.

Fixes: 5965b81ce283 ("hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF page0")
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
Reproducer:

Start an Arm virt guest with one passed-through device behind an
accelerated SMMUv3 configured with cmdqv=on. Add an HMP monitor socket:

  -monitor unix:/tmp/qmon.sock,server,nowait

The failure can be made reliable without an ASan build by starting QEMU
with glibc freed-memory poisoning enabled:

  GLIBC_TUNABLES=glibc.malloc.tcache_count=0 \
  MALLOC_PERTURB_=165 \
  MALLOC_CHECK_=3 \
  qemu-system-aarch64 <options>

Wait until "info mtree" shows the VINTF page0 region, then reset the
guest through the monitor:

  printf 'system_reset\n' | timeout 5 nc -N -U /tmp/qmon.sock

With the unpatched binary, QEMU crashed on the first reset with SIGSEGV.
The core showed object_unref() called from address_space_dispatch_free()
with the object pointer set to 0xa5a5a5a5a5a5a5a5.

Testing:

  Unpatched, one CMDQV instance: SIGSEGV on first reset
  Patched, one CMDQV instance:   100/100 resets completed successfully

 hw/arm/tegra241-cmdqv.c | 22 ++++++++++++----------
 hw/arm/tegra241-cmdqv.h |  3 ++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 273633e62937..29123f6267fc 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -131,35 +131,37 @@ static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
 
 static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
 {
-    if (!cmdqv->mr_vintf_page0) {
+    if (!cmdqv->mr_vintf_page0_initialized) {
         return;
     }
 
-    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
-    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
-    g_free(cmdqv->mr_vintf_page0);
-    cmdqv->mr_vintf_page0 = NULL;
+    /*
+     * Keep the region parented: old FlatViews can retain a pointer to it
+     * until their RCU callbacks have run.
+     */
+    memory_region_set_enabled(&cmdqv->mr_vintf_page0, false);
 }
 
 static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
 {
     char *name;
 
-    if (cmdqv->mr_vintf_page0) {
+    if (cmdqv->mr_vintf_page0_initialized) {
+        memory_region_set_enabled(&cmdqv->mr_vintf_page0, true);
         return;
     }
 
     name = g_strdup_printf("%s vintf-page0",
                            memory_region_name(&cmdqv->mmio_cmdqv));
-    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
-    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
+    memory_region_init_ram_device_ptr(&cmdqv->mr_vintf_page0,
                                       memory_region_owner(&cmdqv->mmio_cmdqv),
                                       name, VINTF_PAGE_SIZE,
                                       cmdqv->vintf_page0);
-    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
+    memory_region_set_skip_iommu_map(&cmdqv->mr_vintf_page0, true);
     memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
                                         CMDQV_VINTF_PAGE0_BASE,
-                                        cmdqv->mr_vintf_page0, 1);
+                                        &cmdqv->mr_vintf_page0, 1);
+    cmdqv->mr_vintf_page0_initialized = true;
     g_free(name);
 }
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index de4c1e53358f..502fb1e6ca54 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -49,7 +49,8 @@ typedef struct Tegra241CMDQV {
     IOMMUFDVeventq *veventq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
-    MemoryRegion *mr_vintf_page0;
+    MemoryRegion mr_vintf_page0;
+    bool mr_vintf_page0_initialized;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
-- 
2.50.1

