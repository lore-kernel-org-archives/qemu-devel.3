Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93326C88E77
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6F7n-00073p-Lz; Mon, 14 Sep 2026 18:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x6F7l-00073T-ST; Mon, 14 Sep 2026 18:26:06 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x6F7j-0005f3-Kx; Mon, 14 Sep 2026 18:26:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4tkDMdkaPSzaYJ8rUqHvSjgRUmtcEZBhnPu1m4+lMB8GaOUwhX7tVuykNA9+Ogpa2+CRHWblJaS/onptBkLiHjuwPKLBQIVPNihN8ABM/ZTIKqvinh9poV3B7ATYApjKQvRxuioKrINXX93vkb6Rl6jdtJSRfKVfFBLDobZGIZH07RK5XA2jEi5+m0zCOsySRbTupZADwqqsQxLQOO0aYAnUrjSgnKQJ2mykL10qGYmLd0eyiysDnbQ4wh79AOW5BaOeiDMafB7DftZd7H6m/re4ShXGTQHjsoYI0hqv5H9Vgfha0maZtN3rTQNpeSA3PqQkwmwYjVuaf7FA6ULjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mhe9N2isVCqj6tL4tpXQo0PGHZmXnHcoHZX3phRD9ck=;
 b=tCi2aIW+MdSbfctP/WII4WH1OWHt5RcSnrqdeYN6j0wElQclO58Que4+JwN5GCoOwXb8TCxGdcsJldaozOtZZ0ltmaJJOL3GxK6xb7N01uq8TRzdkj9R7DorGFvXOOg3NVWUpWWBL7++CyCk3VYn+zJjfoOrrJ7cb7rWIo5GKRLjlbm/OpJwxXbp/V0Wj9UPVbGofMY0wwErVTa7qijB94Yt/rhCefaodXoVRRn8JcUiidWgX86haJlTEPLk/eXmdU8h5BnHwoMNiGLKhljPhbMNV/KvPgwEuy3SuiPpYPkiy5sn5nlqjKeke3hPixiFq8rA30XyCLntK7AoR1EtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhe9N2isVCqj6tL4tpXQo0PGHZmXnHcoHZX3phRD9ck=;
 b=fkiojcw3N5JpP4xb+PKd3HOxx/aJFUQjTynhzIP941amUryuMi+aCUnlVou8Cu82gRpyPZPm39Axb2ipY6X0SQ1aECyyHKXou5NcrqSauqIY4JINIhexVk1sdEP+Yhc8db1XImDo4nMIiwkB+NRerhG9hQgRBoHHYN8HCBGvbkC3sZS89kxDaUwd0xTw6JmpvHb5jEpSD0eFkGA+T0ZopGHuMWoyQcHFV585plCY2wONcrFftX7jis+fZMLZ4GTbX8KvRdLV06GRUtZ3knIHFoSg4P2KB+T46o3o8wo8xzhLoe6MDe3RvL2m++/CSSnL3H0FmVcFO7Xu5b0zdioTbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 22:25:56 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 22:25:56 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-stable@nongnu.org
Subject: [PATCH v3] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Date: Mon, 14 Sep 2026 15:25:54 -0700
Message-ID: <20260914222554.708582-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd86aaf-4ff0-4dc2-6d64-08df12af24e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|5023799004|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rC/HDDhGD7m6G4pd+auGUBCMz4hpLN1M7jrmYCRmJvmdbAmiDCbXqbAI1h0+igzAIXgEmlKYAaE5lhJt2mbujUrHT7+wvSiDfg28rpouAOqVfOvW0SKNMuyKp4oarmkZ2obnTrJubHqICHruxHsG5REgDcwGU41PdmI7QLeTjnR/Bf3oiDRzLCbtdUwxlVAH6jK5ue2s0TZNTzIO+QByppcW+n8iPolOwx5fZY2MlNTSX1Hu3OGG/EQ123pnHX3eRltVKV3x/JJZ0mDvp6/D6yRQR3NJHQHYXVkI0E6iCvM0+wUTynURDiYksZFQyGKaGVgSIO43a4afVxjbh8CE4QxOQpisTIU2Gunm7UfUJ/mpdz2a2fxrgH5/I9E8QYQ4gVWL7PseyLV3/Lo8kxOa8xAPTDKqs/Z9ebIfpdPTv8ayWdyxd2sHr0YD1EHf9KMPbBSNVPfT5wv2oIcTBw/kFFfuWLfx1iRfn2Tz6JvgmVzYFXIe1mVGUhA+XUUbiQO+FyNE8S/BhYSdl2weBBhXN9TFFaNtBoi1MWXDmihPdusi51UHhBupDcrEITKXvnCRWHeFEJEMiUTEH78utAeezehpv7XA5+89yGquppoHq53R0Dp/U/7c4wz4/m9axuO92klAMJCMcramp4xFdjweEp8YH2/z/EyT3bvbdguGlv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCoVCH1USQfkll03JNbsKP8efs3cqIaW7QLnjW8oFAgAPmek+9oXbKQE0t2X?=
 =?us-ascii?Q?mflRLRTDTzBuLMTh8Pj2Cqhgaa4efi9lU7QQDE7RITgYZHddoYbfJNPnZkoh?=
 =?us-ascii?Q?taI7U4y+fJ2clP3yTR3FEKQ9jdhFNVoY1AeLGsCqzA5yZWHBJs7AdOCLmLuQ?=
 =?us-ascii?Q?1Cr6vwLFFwBGl7ZM4X+KVhFN5tanPAGpru5WEfE+IA5jAwZK1Up+Xc5DmCtr?=
 =?us-ascii?Q?JFT5jxPib0UWpt/tf3I29K7oJdoQtzcjeJ0WfPT9mWChcVXe87TDVSAt8c9n?=
 =?us-ascii?Q?iT7qTBqePiQPnzfM05TO2GLBtKytmDGFpjatLBjT094KkMDbPxyq6EHiO+3z?=
 =?us-ascii?Q?0WSPngi6nDQeY6qU9UTTK3hFiNl0X3jaEXrUbBo3Z+MhHIxGExlSUKqNOubV?=
 =?us-ascii?Q?e6lfRSmXEDY3HhcJuO3OzbD95t83nXHiQxy+TcBw6rcd5JtAXP9Osw7/4WGG?=
 =?us-ascii?Q?tZyhMmTYXCRhvY5pHm0s89SlLnyoXRmwWeBWrBgNOC29Jrdcq09alHNyezNA?=
 =?us-ascii?Q?cOyPLm+BtYSvrTeeyag5n2GZD0XaXiru35bU83Xma7YC5O0EPCL0tn6H+Oog?=
 =?us-ascii?Q?roVukqnFPEneoYf2VNNfJejOKRxEzoLGKTK4kaoOXzb5/CCMZr6Ww6wczLBy?=
 =?us-ascii?Q?SHnmVgYHoumnuJtFvNuda3oVI1KVyGfSyjNx8pevKWSifGB8+amFfxl8Z1JI?=
 =?us-ascii?Q?VesN/nid6N0DXsYXt2rpZxn4fVwtjWNdHwjX70oYaSofS883VRQT0Qe4lB1R?=
 =?us-ascii?Q?qspgjCET15uszQHlJjAbiw5SrfHSNK+M5zb3oFSKA0K5fT3/mWSF4h4Tw+E4?=
 =?us-ascii?Q?CPMkpfnyVzm99gPUejsNjHUlI3l+shaOQTcbsB/FJkLa9f0oAOgVu2QTg1u0?=
 =?us-ascii?Q?FRsVYhwoXi6CBLSD3cBAhRV9Ru5MMBtyb8qxTFqqgCUBTVXZXCyQBxDKX+s5?=
 =?us-ascii?Q?AeIPIkc7wS8Z/+lgiT0k039aK+Cvf3OTpU52LyJ+MrYfaXp7Vol1H4dBlXv2?=
 =?us-ascii?Q?JU7rlkVZcJOtQcQoYFcCTTMyWvbXR5Xr9YlAVTq/GV3P01t+yvAyeju7DFUl?=
 =?us-ascii?Q?O4KK4Aq/GBjje0gZo7DASAMuVIn01SOZJXcM/ztxCmeZuVG9zdH1Ub14znVh?=
 =?us-ascii?Q?DzetqqNELVhfqpOyHOs0Wv41zhgMM/HhwUf613mMVlEQ37FIuiSmascWKe97?=
 =?us-ascii?Q?EMifx0zQBDoL64p+PRb1VJmC7xH6uT7jHS1pqA340tadtygpZpPS0u/PFcRv?=
 =?us-ascii?Q?4xyBWwEfTbky4iwGDQq9h7mZEUfA1RO197W7b2DPmUpmdLDPfHbkOnTHlwCn?=
 =?us-ascii?Q?jBGf72fxAnAMkRC5vRoFlM96tDq//f5ldwxvMjBinP/0cE42ratuy3IgW9ns?=
 =?us-ascii?Q?yfBr4y0zdQlgV4h8o/fRT32iDMW9mML/t8UWWTrIhlWyReLFBpCOOBiH6YoR?=
 =?us-ascii?Q?UGqUV1hvikFyjnYOgY3s3wS8DFfjTTJbHq4dwpgNa83rRqzpTNPOQW+v/EfU?=
 =?us-ascii?Q?Pky1ZMz44e9w39k8KxZ7QA88+E+ugdFqygPoiVDaHNS6qbF/3Ivihc9oFi0l?=
 =?us-ascii?Q?LD3cyeQGY+wAg16FwjGidGunzCeXeTlTwFKT0R7bw3tdZvFimdXVGafb71Dc?=
 =?us-ascii?Q?J5SMWHupr/zFpBMkYJPt9By13bqo/iIVfTXBn0ZvSN+HUhQMQkIDAx7J3HCU?=
 =?us-ascii?Q?6AmJ7Nfj+zxMwVuHxCJ865SEJWUCo9a6Ct4zTv7C4MKjW4UCAw0kQsRrqS5E?=
 =?us-ascii?Q?HhXfl7CpSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd86aaf-4ff0-4dc2-6d64-08df12af24e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 22:25:55.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQkUzxauPBm1YWdAPbRsCVMnvFU9Am7pFNOYWwYfgp1MjBqLVYuJ9vmDiTTfNqplhWidVEs+GILZtS9pJGCSaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=mochs@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

Embed the VINTF page0 MemoryRegion in Tegra241CMDQV and tie its lifetime
to the VINTF page0 mmap. Initialize and add the region disabled after
successful vIOMMU allocation, and remove and unparent it before releasing
the mmap during allocation unwind. Guest VINTF enable and disable then
only toggle the region with memory_region_set_enabled(). New FlatViews
omit the disabled region, while old views continue to reference valid
storage.

Keeping the region initialized across VINTF disable and reset is safe
because the vIOMMU association and its VINTF page0 mmap remain stable
once the guest CMDQ has been initialized. QEMU blocks hot-unplug of the
device that established the association, so later hot-adds reuse it
instead of associating the initialized guest CMDQ with a different host
SMMUv3. The CMDQV free_viommu path is therefore only invoked while
unwinding initial allocation, when the region is still disabled and has
never entered a FlatView.

Fixes: 5965b81ce283 ("hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF page0")
Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
v3:
- Initialize and add the region disabled during vIOMMU allocation, and
  remove and unparent it during allocation unwind so its lifetime follows
  the VINTF page0 mmap, as suggested by Shameer.
- Avoid calling memory_region_is_mapped() before the region is initialized,
  addressing Peter's review.
- Link to v2: https://lore.kernel.org/all/20260911190431.4085464-1-mochs@nvidia.com/

v2:
- Use memory_region_is_mapped() instead of an explicit initialization
  flag, as suggested by Shameer.
- Link to v1: https://lore.kernel.org/all/20260903184710.2052780-1-mochs@nvidia.com/

Reproducer:

Start an Arm virt guest with one passed-through device behind an
accelerated SMMUv3 configured with cmdqv=on. Add a QMP socket:

  -qmp unix:/tmp/qmon.sock,server,nowait

The failure can be made reliable without an ASan build by starting QEMU
with glibc freed-memory poisoning enabled:

  GLIBC_TUNABLES=glibc.malloc.tcache_count=0 \
  MALLOC_PERTURB_=165 \
  MALLOC_CHECK_=3 \
  qemu-system-aarch64 <options>

Wait until the guest has booted and initialized CMDQV/VINTF, then reset
the guest through a QMP client:

  ./build/run qmp-shell /tmp/qmon.sock
  (QEMU) system_reset

With the unpatched binary, QEMU crashed on the first reset with SIGSEGV.
The core showed object_unref() called from address_space_dispatch_free()
with the object pointer set to 0xa5a5a5a5a5a5a5a5.

Testing:

  Unpatched, one CMDQV instance: SIGSEGV on first reset
  Patched, one CMDQV instance:   100/100 resets completed successfully
  Patched, four CMDQV instances: 100/100 resets completed successfully
  Patched, forced allocation unwind: 20/20 clean exits

 hw/arm/tegra241-cmdqv.c | 54 +++++++++++++++++++++--------------------
 hw/arm/tegra241-cmdqv.h |  2 +-
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 273633e62937..57041408a7f0 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -131,36 +131,12 @@ static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
 
 static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
 {
-    if (!cmdqv->mr_vintf_page0) {
-        return;
-    }
-
-    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
-    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
-    g_free(cmdqv->mr_vintf_page0);
-    cmdqv->mr_vintf_page0 = NULL;
+    memory_region_set_enabled(&cmdqv->mr_vintf_page0, false);
 }
 
 static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
 {
-    char *name;
-
-    if (cmdqv->mr_vintf_page0) {
-        return;
-    }
-
-    name = g_strdup_printf("%s vintf-page0",
-                           memory_region_name(&cmdqv->mmio_cmdqv));
-    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
-    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
-                                      memory_region_owner(&cmdqv->mmio_cmdqv),
-                                      name, VINTF_PAGE_SIZE,
-                                      cmdqv->vintf_page0);
-    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
-    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
-                                        CMDQV_VINTF_PAGE0_BASE,
-                                        cmdqv->mr_vintf_page0, 1);
-    g_free(name);
+    memory_region_set_enabled(&cmdqv->mr_vintf_page0, true);
 }
 
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
@@ -899,6 +875,9 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         cmdqv->veventq = NULL;
     }
     if (cmdqv->vintf_page0) {
+        memory_region_del_subregion(&cmdqv->mmio_cmdqv,
+                                    &cmdqv->mr_vintf_page0);
+        object_unparent(OBJECT(&cmdqv->mr_vintf_page0));
         munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
         cmdqv->vintf_page0 = NULL;
     }
@@ -910,6 +889,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+    char *name;
     uint32_t viommu_id, veventq_id, veventq_fd;
     IOMMUFDVeventq *veventq;
     int flags;
@@ -955,6 +935,28 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
 
     /* Set up event handler for veventq fd */
     qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
+
+    /*
+     * Tie the MemoryRegion lifetime to the VINTF page0 mmap. Initialize it
+     * disabled. If initial vIOMMU setup later unwinds, the region has never
+     * entered a FlatView and can be removed and unparented before releasing
+     * the mmap. After successful setup, keep it parented across guest disable
+     * and reset, and only toggle its enabled state so old FlatViews continue
+     * to reference valid storage.
+     */
+    name = g_strdup_printf("%s vintf-page0",
+                           memory_region_name(&cmdqv->mmio_cmdqv));
+    memory_region_init_ram_device_ptr(&cmdqv->mr_vintf_page0,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, VINTF_PAGE_SIZE,
+                                      cmdqv->vintf_page0);
+    memory_region_set_skip_iommu_map(&cmdqv->mr_vintf_page0, true);
+    memory_region_set_enabled(&cmdqv->mr_vintf_page0, false);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
+                                        CMDQV_VINTF_PAGE0_BASE,
+                                        &cmdqv->mr_vintf_page0, 1);
+    g_free(name);
+
     *out_viommu_id = viommu_id;
     return true;
 
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

