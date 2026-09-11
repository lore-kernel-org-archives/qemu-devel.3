Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B638C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56YG-0001w2-PO; Fri, 11 Sep 2026 15:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x56YF-0001vk-60; Fri, 11 Sep 2026 15:04:43 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x56YC-0000GZ-Q8; Fri, 11 Sep 2026 15:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TebVGxfq+X/n7GLNDCBFqN1Aa0bKJyHuPnCAh74z9pH0qnaHlVBmlVWTBMwFAWXsp6uhvfja50Lllgpp12g6zBf/vt90tikEUsZFPzSRUm+6IsNp7QcncYCkRKxQcW1b4iyQEzhjjjbR24vgqEZvOw/JPaA51rpe/qOtsfsTo2IM0UwDDoW4H/w5NEKShIKJB95Eqx9EQzncDyXttonyYyCMsnxX9x38d23DZ773iFEaAl3brN/rhu/bIL4MDqGnJpETt85VCqi3dmVtpe07Kq50hnpXA9dz/79/rx0hrz5UX5yzqKo0fVgYv8Hlfgikg4BU94QAiNgQt8EvjtLp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldiOvfta6n5e1/xGJnkIh7Lz+355jFZQy8DbdaTLpaA=;
 b=MWaX8ShXevRyOo9+i2GKM/NZZkAVYskod9xfcw7SPpBCwtwX2nBtIYcu3T0Q7yWi1aR9uuGUQtIjls6xcbukF/IrkKr3/lBKeIaW5IUorsP7CUKtpJ0eDPTCtcZAFFxIFyni13Sh8gjkK+wYCf3Lth8voSJQpBUN0oFcyd42/7Yyxk6EcKYEI0bCfvuVd+ARGLkNGm0e6Tm0tZE5zodSlw9cBmRiNRUfID5WM+b3QtCkKPu/bOzeVbSOyA4YwLHgRPrqeeyh3l3PmSd8J+wo5XsjthGsAgOa4ho04jvWGMiFjYDxnKiFR3UEe10FmV9bQrlqzPmmuLzJeWHYVTQUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldiOvfta6n5e1/xGJnkIh7Lz+355jFZQy8DbdaTLpaA=;
 b=OpuOfhWDACPCMRPGJjUcJ9QZQEb7JS3gj/Tyy9nDdsMFxlWrFbKHwTON05MhqXQNUAqIkklT7QUdrkH/6vqyvdRZrOMHJY5UyX/q3qQSEnNyRpbuWVDU3kv9Liwd7X/kUvfU4LdahEQFkFSEQKVgbUqHZgYLK6GlM3hOrxeSR/U70gLmcOR5amDVxNg3eRdDORKN4U8ps5CD5lFMvgc6ufzDpOpsaV6h+0Lo01koE4zIAByWbHtidPm7RcusnVKDGBG42r5DsnFYppWcSf7H41eolVFmHSshNYcKcglwDrfj0nCRcwwmvzp7B6FrPE43mL74qv+Kf2jjCgZkdF3kAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:04:32 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 19:04:32 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Date: Fri, 11 Sep 2026 12:04:31 -0700
Message-ID: <20260911190431.4085464-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::7) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: de4832ba-9b51-4984-8ce4-08df1037838b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|5023799004|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: wBqykaaPcExpJd1XU+ghuhMrxqqkM1Et4ceChhXCjcRHXZ/0E+qLo9KOonJw1nB8hRIoKmi21bRrUz3m1RoWWuJfKJzW2v5gPH0bUdPaj/IkOQ9EMkkPb9xgJDbTL3pt1SCIj+7RYD4qy5RGTcdg+Mrva6HSv3N24FwL4LbV3ILmzaPMjmSzi5Uq7KN+FDYKZR4oAs2JO1ejC3zym+j9Ypq4TGUJAwXTEYg0R3U0duzDzRCNnRaBW+xqScrYtcZ3xRpQTMfiCnHulcM1PZghaAq5gh/YVYdPTTlHfQOLglIgHUK6apLVIXKW0XS2eCXnuKTX/4TfN92HuWWlfWAaZbpDPy3BHR4zCUJgt722mTM0EJ1XtOEN5N28wYk+DlPeGu9wGmdQIJuVmiEkxsdRyOJo9bEsCqyMl/UldH6+VR3Xb1BhNVUuB05yoIR8obNFwnToz/ZvMCaHdoO4CQ5FGnd6Xsyvd6c6Un4oeZ54Ne0tEjTXQOhm9urQ772SNv1AbTg/BqR/rukyMC3mjlt+b6g4uoMRJUJHp8Vhw+US9HPP41sfVzquAVb/BHxw7Ki9UoAmOzdbYi/aMe5lGr3svsCwYMSUrh6Y/LQ4HtSy+VjWkB4XUbpFw731VcFZ7dXogytLn5rVQOIfwYA/fkf0ZfJ2D4HoYK4segXkTRmKzJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vUCNArxDrynJinMQtbT/j51MPJPiumXkHWv7FJ4zgGL0e13zyw5L2kDhXXUv?=
 =?us-ascii?Q?4LwYkHmPesbsNxUKfEOp3qKc6Cs3BC7bi+YMH7+s5FtpuJGnr/w6het/fKr3?=
 =?us-ascii?Q?O/sFmV+7t+0nTr4FacLnmo9a/LaMEOB1UWsmnufcoeVMyf78GwRqoIJ6Ham7?=
 =?us-ascii?Q?uA4os2/jj7QXrrjUp8iqE75clfeGhfcjXX9dm2FAUS8Z50O/rA0JGLAJ2+X3?=
 =?us-ascii?Q?dy5oC3g2hzogxsnbWFGvw8nf55JvTJwIpflhA0Khy+tV9vDm3FjUMHnMXLOr?=
 =?us-ascii?Q?J8kd7WrPZHmf4U/h/U1DZVnmHR599vEmbHPUnxFkfpF44w5Ca6+vV5bB8L2d?=
 =?us-ascii?Q?ZlyhTr4oJjzMJ1FRNLm/LfwagIrkDEBZDC6OkAwA/SD0bnWhQkzL9wJ+KO5n?=
 =?us-ascii?Q?Ct7Lhuh0LhTvk9IJlIf5SNpmfpWc1MRs1f9rvsaa3JwXLG1clQyQsPE4ySs2?=
 =?us-ascii?Q?3GkqDEPO2pl9O6K0rkCAxEkd0cstKPWxz+ZG3KR8/lx7bPlXvRDDWzmAObvR?=
 =?us-ascii?Q?L0CGX5aRPK9h6pIVqL4bDzxMdPPe08vL5bKOU3VHxE46eWCuJrzBTjN1mUTJ?=
 =?us-ascii?Q?CY86g/+42N0Zv/okg0v+51cuvZTbhhVdg2Xux22st7foiAzhTcQRpnmT1gNW?=
 =?us-ascii?Q?siJjnpIWoiTMEuvm2WOuHd5ULUVQGlsE+OXmUKYPj6QILiKED6qT83rLHR3F?=
 =?us-ascii?Q?Sr5zCUUNARZPparwAY6FfhWdy6avjrc8LnlCXEgLuH0M+PqDbE822mcOVx3z?=
 =?us-ascii?Q?9USVgJGrKVrEVO5b0h+T1MnyfyfWuWIkwwWOZ00xtb041fblU6CQlVNsJkdc?=
 =?us-ascii?Q?snej9nWcos9XyE3Du/zdkzADWuRoNgQ/Zn8Mw7kXVH5p4NBmY5+EoeCCeA2r?=
 =?us-ascii?Q?lzj7r8kOUNH5ExVUhGi7uY9y5TXi3ihvRVK1snnk7bqaTK+pqKmO2kn7x3AI?=
 =?us-ascii?Q?DZj8xrM4qcgob4FB+PHGI67iAyDA6CnYvIjYg4TAT1oEIo9SMy+UlGtN+aDE?=
 =?us-ascii?Q?4tdROggKpUGdPvuojaH4acVfW4kpVBc420lvV6lOz9tM4zyld5drWgIPDBxj?=
 =?us-ascii?Q?C0qbAe37I1UmjC3Dy9Ypz0k9SjqPngyx2QhNJiwllhZMmePA26t6CKJpwACZ?=
 =?us-ascii?Q?WCNTkJY+urvwDBjvDad3BOr4jpyZp1az1CA3+ZDdzW3sRfHoBKGPg/CjRQhD?=
 =?us-ascii?Q?M9fOz5hP2HPKvk1jHKngmFXCwZZI9dUb8KHJrkJ4kk+u8h+R2+7mYUxy71e9?=
 =?us-ascii?Q?ck8aXJkX0/ljV/SR+3GtbUwpaqdJiS/GCxTW8HHl0xnIW9FBJiKPg/mNSk9I?=
 =?us-ascii?Q?6Epxw/S/HcepHYnrdj9DI0+gVSytLbzQVyZ0dwMuk7fRzvV4JzuGuGZcOHsX?=
 =?us-ascii?Q?sLmhgLcRJw3tN3V2cyB+TmDFogSG0nilF2hPaC3HOZX44QSScFkw9C8esspB?=
 =?us-ascii?Q?xAosZR+TJ65vfY4qb7csHVC9HOs05Ism/r0zi4Ek32+5AimzXI2JHBvZFkFL?=
 =?us-ascii?Q?kwDW6xCEvskywk4Snp5NCsrnF03ifNk3C8GJfKiEt9TuiwbU/epNXfAVp7A3?=
 =?us-ascii?Q?kZC9za92zm0SlwXSjVJIgeH6Sd7LNejXLvVgqN8oEBxD2EMha9cI+an2Sz9A?=
 =?us-ascii?Q?aMbOgduSWB+G10vHrRU8VvndB3/nIaGlGBLWaDVY5ZRAUfDj/FKKO7Jx6QFD?=
 =?us-ascii?Q?kkcQNwZeyXv/5hnpdVpJ6LHQNSH4DoffcUfNaQxhhd/5O7DyxYTme6QqO3GX?=
 =?us-ascii?Q?W4cg5wntSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4832ba-9b51-4984-8ce4-08df1037838b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:04:32.7379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qNLJOaWVsAbmi2nckX28mNeLkVipYH4y7OE709hYqCxLVeWN9CMOu4blgu0yDmOGHnv0sHjhu+EALkUzedC2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=mochs@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Keeping the region initialized across VINTF disable and reset is safe
because the vIOMMU association and its VINTF page0 mmap remain stable
once the guest CMDQ has been initialized. QEMU blocks hot-unplug of the
device that established the association, so later hot-adds reuse it
instead of associating the initialized guest CMDQ with a different host
SMMUv3. The CMDQV free_viommu path is therefore only invoked while
unwinding initial allocation, before guest CMDQ initialization.

Fixes: 5965b81ce283 ("hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF page0")
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
v2:
- Use memory_region_is_mapped() instead of an explicit initialization
  flag, as suggested by Shameer.
- Link to v1: https://lore.kernel.org/all/20260903184710.2052780-1-mochs@nvidia.com/

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
  Patched, four CMDQV instances: 100/100 resets completed successfully

 hw/arm/tegra241-cmdqv.c | 21 +++++++++++----------
 hw/arm/tegra241-cmdqv.h |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 273633e62937..51357885b5c4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -131,35 +131,36 @@ static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
 
 static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
 {
-    if (!cmdqv->mr_vintf_page0) {
+    if (!memory_region_is_mapped(&cmdqv->mr_vintf_page0)) {
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
+    if (memory_region_is_mapped(&cmdqv->mr_vintf_page0)) {
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
     g_free(name);
 }
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index de4c1e53358f..bba985099e3b 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -49,7 +49,7 @@ typedef struct Tegra241CMDQV {
     IOMMUFDVeventq *veventq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
-    MemoryRegion *mr_vintf_page0;
+    MemoryRegion mr_vintf_page0;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
-- 
2.50.1

