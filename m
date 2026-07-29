Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB459C54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpC60-0003jb-NN; Wed, 29 Jul 2026 17:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wpC5y-0003jN-8f
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 17:45:46 -0400
Received: from mail-westus3azon11012007.outbound.protection.outlook.com
 ([40.107.209.7] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wpC5v-0001i1-6v
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 17:45:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLcuK+mmy6Eo9au22H0PNTZj8tmm2QFp1bNI8+Ued/A68AWXograb5KYyOTP7lkHHJmj5u+bGHj/S3xvEGRp3whcgDhiyATxpnQs2AjTaqjIcs6eWib4Qm14xVzsdvLhSBK38UMw98ONnXboZJ7if8oBB0VaVVyHkNmAPmT3qniovqlUIj4/Db7hgMdjpVXw4UpZ01VQNxE/qEmYGL1IltpojSjIZQrY1f4FVTwuoahWuVaDDkdd/w/rScVkgfh2JW342Nf5bP7hFHIMbS0Thn1mYKhC7m7IPODXc81sWso8QGIL0THVcaycUk2Srt/X0nlSWNtvCc9ROZB9oMbymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz9DoQmvDDPJtwclWhrgD8YrUIXvtVlVeCXhkdLa6hM=;
 b=ehfQg/rx+MCMjg6RLwZ78OVkeAalRxfo50+HcVebncyyCEIX4VJbDXs0+na/7cE286emxnluNfJA/eH87KXxELTEn+j65seAsKKOOqXYJAQtpK6hX32CUJlNKLZ5YNKdrSROe6uloFIIAsdnenqKQE1X7Ym6jrRg4ILYiSnK2SURt87MWXgGzhczpZWBBc47LNMAj8pB90r21k1EHL+w4nZK+6AEB9jBcazQhxuA+ogPCTOpzvdGGuefRUJHwk4YCCKqRCRK0J0fIOthnfT3RWw9laJC8UkDFJqxZMAqT0OtUDI2GKwtZTvevngKOw5pmHMj31ddnd3b6AG0MA0HzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz9DoQmvDDPJtwclWhrgD8YrUIXvtVlVeCXhkdLa6hM=;
 b=rgDNANCpVHVgGYMnj02Ty1DMVjXjQyu1wLtkaENbiu0mE1aNrUZ9uq1FnLTAsf2gVdY+Y7oiHpQXH087ugbJdvpDVlMBKMa/Of/YtxFr+F3RtjdSD/OGNX2LqcVTbSzu4hQ5KN1xWSyz0nWCoGlf364jVUAbmE/4REkSeFNx1VY=
Received: from SA9PR11CA0023.namprd11.prod.outlook.com (2603:10b6:806:6e::28)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 21:40:33 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::56) by SA9PR11CA0023.outlook.office365.com
 (2603:10b6:806:6e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 21:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 21:40:32 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 16:40:31 -0500
Date: Wed, 29 Jul 2026 16:38:23 -0500
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Subject: [ANNOUNCE] QEMU 11.1.0-rc2 is now available
Message-ID: <p6la62avrk72nmyjl2fasi4nxbj5xzojm24vfndbov3qtiqf3f@iw36lochgsus>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf5531a-87a7-4fa8-7a06-08deedba0418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|6133799003|11063799006|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: EgZql7J+ccs7UyMQbjn+kL2iqKFDAwqrubeCH5pLUHOmg97nGV/KNEm2VVA4JSOh0qcK+fDmNyoVg2F/QaMaFAj/yyIwg2l2z8JQS01Uc29Jlegzr70fcn6674DPzmkfRNS1LgPdIQ+wIZN2n1e1TsrZOtbIF4P09GEq2xBdwm6cp2WeGb8ao5EAPiMDM5cmMbhjP3TFKcdvpFyJpDWRc6IeFGdl5TZk1tZl4O86fwHaqHzXQ60ahJL6xMK7UtFYpavOVlbDjHD1WK+hmake6frpEd2cRb0SfmIY+SbbfOeUsSAAJJdrhor1At+XBlorggonhE47NhpXmHBabNWbqcaxFnHkdpqy3OHefyeDtg5ZkjPvI3lU0qcSEDW0HlJdCDBUA7UjAFVgOFQkYF3R9U+PPHXD/eWT11eRAzesPcmmx8pHo1tWSsWQ23P96jaId4k5URXDsgpx5wZkIoEuTJuDlLgj0Od+mnPdsfWjS88GeauKgb85dqa/8E+VMNfCRX4qRjOIyHluwXWUxBr9gHjmosrM+J1OGncnonvGX4bWK+pY5Oo/zjmS8FxuP6xpw9ZN0tXqGo9T0bx/U4rG8yBEK5G7mXAS0Hkhpn4gzz8LRbGqBiWX213v9RuLtIzZ42hkEEDEg26nxzYroiKaYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r7HWBHL5g/5eElQ9lUvj5PggzTvL8/qLIjJEFC2HRc19Y8BuNIKRVt/LSHYYgipu9WvtQ5NiTTxC/N33kzJQt/SDNGldLaY8g9mFDst1VBUiHjYG4LfBTY+YaRwKTJjCnKoJSunPFh+2UJ1eFxxS0KBJRBwiKvQUOQQkv78cX+526418ucW21EgA9HdWmr73NsaYtagr9vtTQTaAh6BFpLApQO/bIEuWf2OOGFIO6CRb0xYXUUBVvYdhl9wp1rBTBa74tYQ2gwsw9wH+s65Tfpr1ySgqsqrRUfZVmSHuaWUQBFEePK4MeMP8AGSRkVNAqQDStW1Cn2KKzETmfU8j0cLhNKgxEj7BWqfGW690Eo+sc2z1pJGkBSbtb9tDHfgKAsQqECmJ9UI9vfFVkjAwWTPDkAbTZlbZZ/s3R5xvOh4faInswlIr3pyOA6UOJhRH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 21:40:32.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf5531a-87a7-4fa8-7a06-08deedba0418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
Received-SPF: permerror client-ip=40.107.209.7;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
third release candidate for the QEMU 11.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.1.0-rc2.tar.xz
  http://download.qemu.org/qemu-11.1.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 11.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/19

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.1

Please add entries to the ChangeLog for the 11.1 release below:

  http://wiki.qemu.org/ChangeLog/11.1

Thank you to everyone involved!

Changes since rc1:

e1705a25af: Update version for v11.1.0-rc2 release (Stefan Hajnoczi)
c39e05af43: hw/nvme: fix unintentional integer overflow in shift (Klaus Jensen)
df67805ee9: hw/nvme: fix cross-namespace copy dif buffer overflow (Klaus Jensen)
6e5ca34f38: hw/nvme: fix assertion failure on subregion removal (Daniel Paziyski)
30724cfee6: hw/nvme: use GPtrArray for blocker_features (Alexander Mikhalitsyn)
352587cbe2: MAINTAINERS: update parallels tree location (Denis V. Lunev)
e8a28c2e0e: parallels: validate BAT capacity against advertised disk size (Denis V. Lunev)
4b620302ea: parallels: avoid fatal abort on large bitmap L1 table (Denis V. Lunev)
d5250d7ed7: parallels: skip loading a genuinely empty bitmap L1 table (Denis V. Lunev)
ac52279673: parallels: validate bitmap L1 table size before allocating it (Denis V. Lunev)
26c871c768: parallels: reject BAT entries pointing outside backed storage (Denis V. Lunev)
3a1e0618ae: parallels: fix bat_entries overflow in image creation (Denis V. Lunev)
af777e817a: parallels: read header/BAT table in bounded chunks (Denis V. Lunev)
a5f8d33682: hw/display/exynos4210_fimd: Clamp windows to screen size (Peter Maydell)
7dd1e22188: hw/display/exynos4210_fimd: Pass width to draw_line functions (Peter Maydell)
4f635bddf5: hw/display/exynos4210_fimd: Factor out finding screen width/height (Peter Maydell)
c4580a3a6d: hw/i2c/bcm2835_i2c: Correct CLKT register offset (botszhuang)
ccde37589f: hw/misc/mps2-scc.c: fix scc_partno field width (Simon Xu)
1892a0cd43: hw/misc/mps2-scc.c: fix cfg7 write (Simon Xu)
24506d7709: docs/system/arm: Update Nuvoton OpenBMC image guidance (Bin Meng)
62007626ac: hw/net/can/flexcan: Remove RX SMB raw view (Bernhard Beschow)
cf942d0268: hw/net/can/flexcan: Fix RXIMR reset mask (Bernhard Beschow)
21d3af36b0: hw/net/flexcan: Drop oversized 'mb[]' mailbox view (Bernhard Beschow)
7f780d9d2a: hw/net/can/flexcan: Fix mailbox reset mask initialization (Bernhard Beschow)
8f8f86306f: hw/net/can/flexcan: Fix mailbox index calculation in flexcan_mem_read() (Bernhard Beschow)
9981b70ce7: hw/net/can/flexcan: Fix mailbox index calculation in flexcan_mem_write() (Bernhard Beschow)
4ac969571b: hw/net/can/flexcan: Fix out-of-bounds access in flexcan_mx_rx() (Bernhard Beschow)
8af2ced638: hw/net/flexcan: Drop unused RX FIFO register overlay (Bernhard Beschow)
c4e2347693: hw/net/can/flexcan: Use mbs[] array for FIFO pop (Bernhard Beschow)
e5ab18130a: target/arm: Build TCG stubs as stub library (Philippe Mathieu-Daudé)
b3a977da8f: target/arm: Only compile gicv5-cpuif.c when GICv5 is selected (Philippe Mathieu-Daudé)
48201bb01f: target/arm: Add stub for define_gicv5_cpuif_regs() (Philippe Mathieu-Daudé)
39a8c3941e: hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX (Philippe Mathieu-Daudé)
db3abd36e4: linux-user/sh4: allow full 32-bit address space (Laurent Vivier)
c607cca75c: tests/functional/ppc: skip remote interrupts test if -net user not built (Shivang Upadhyay)
d8813fdc4b: target/sparc: set reg window data structures currently after vmstate load (Mark Cave-Ayland)
1e5efe6d93: hw/net/igb: recalculate rx_desc_len on migration load (Laurent Vivier)
b395a655ae: hw/net/e1000e: recalculate rx_desc_len on migration load (Laurent Vivier)
11ed6b9213: hw/sd/sdhci: Extract uSDHC-specific quirk (Bernhard Beschow)
aba80ad9d8: linux-user: fix guards for the fsmount(2) syscall series (Matt Turner)
8cbcf75793: hw/net/xilinx_axienet: Don't write checksums off end of packet (Peter Maydell)
6682ea3391: virtio: avoid packed vring virtio_queue_empty() infinite loops (CVE-2026-16457) (Stefan Hajnoczi)
70074cc48f: backends/rng: cap request size to avoid oversized allocation (Laurent Vivier)
0be94d8d9c: hw/virtio-rng: Fix host use-after-free (CVE-2026-50624) (Laurent Vivier)
df12999cc8: hw/net/virtio-net: Protect from DMA re-entrancy bugs (Laurent Vivier)
0691bb257a: intel_iommu: Check address mask before using it in pasid-based iotlb invalidation (Clément MATHIEU--DRIF)
292902ae4e: hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle (Haotian Jiang)
421f45d03f: hw/virtio/vdpa-dev: pass set_config buffer to vhost backend (GuoHan Zhao)
e07c67584c: hw/pci-host/q35.c: Avoid early return in mch_write_config() (Peter Maydell)
a90fcf0080: hw/pci-host/q35.c: Factor out creation of SMRAM MRs (Peter Maydell)
7ea56dcc94: hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled (Peter Maydell)
fa9c0c9f71: virtio-snd: check for overflow before g_malloc0 (Manos Pitsidianakis)
bdac94e9cf: virtio-snd: check rx buffer descriptor size (Manos Pitsidianakis)
67550d65b4: virtio-iommu: fix OOM due to unbounded call_rcu (Michael S. Tsirkin)
733a98a552: libvduse: validate vq size (Michael S. Tsirkin)
b9d248dfac: libvhost-user: fix heap overflow in vu_check_queue_inflights (Michael S. Tsirkin)
bf21298c08: libvhost-user: validate last_batch_head in vu_check_queue_inflights (Michael S. Tsirkin)
5cc182ba39: virtio-pmem: wait for flush requests on unrealize (Michael S. Tsirkin)
cf89b769cd: vhost-user: assert nregions within limit (Michael S. Tsirkin)
665c854390: virtio: fail early on bad config_len in migration (Michael S. Tsirkin)
d6384ad1c1: virtio: stop migrating num_default, validate vring.num on load (Michael S. Tsirkin)
d530f2dfbd: virtio: fix queue size validation against allocated maximum (Michael S. Tsirkin)
a5cff318f0: virtio-mmio: fix QUEUE_NUM_MAX (Michael S. Tsirkin)
f404bf0e65: virtio-scsi: fix SCSIRequest leak on a bad request (Michael S. Tsirkin)
27806d2ddb: vhost: do not crash on ring map failure (Michael S. Tsirkin)
6dbdc271f5: hw/virtio: reject zero-length packed indirect descriptor table (Laurent Vivier)
758ef96a2d: libvhost-user: protect against OOB vring queue access (Michael S. Tsirkin)
fbdfdbb992: libvhost-user: protect against OOB writes in vu_set_inflight_fd (Michael S. Tsirkin)
7724885620: virtio-net: fix short frame OOB read in receive_filter() (Michael S. Tsirkin)
52c7bb369b: virtio-net: fix OOB read in RSC receive path (Michael S. Tsirkin)
a6e0519ea8: virtio: use masked features with set_features_ex (Michael S. Tsirkin)
21a77a2158: parallels: fix integer overflow in header size calculation (Denis V. Lunev)
0e83d68945: migration/rdma: annotate and simplify wait_comp_channel() (Marc-André Lureau)
12d3fd9a0a: hw/9pfs: annotate V9fsTransport callbacks as coroutine_fn (Marc-André Lureau)
c15ca7cf98: qcow2: remove invalid qcow2_check_refcounts calls (Marc-André Lureau)
a6c131217d: block: add missing coroutine annotation (Marc-André Lureau)
1fe1ec6773: io: add missing coroutine annotation (Marc-André Lureau)
aea4af8c51: migration: fix qemu_get_counted_string annotation (Marc-André Lureau)
8c57370d18: monitor: annotate monitor_qmp_dispatcher_pop_any() as coroutine (Marc-André Lureau)
6b47b70185: block/blkio: fix compiler false-positive warning (Marc-André Lureau)
5e8d44971e: hw/hexagon: fix machine->fdt leak in qom-test (Marc-André Lureau)
fdad10190a: hw/cxl: fix invalid free on early return (Marc-André Lureau)
d541d7dc2f: hw/display/virtio-gpu-rutabaga: zero-init capset info response (Marc-André Lureau)
5c9ef661a6: hw/display/virtio-gpu: Block Rutabaga migration (Akihiko Odaki)
8dc8449a67: hw/display/virtio-gpu: Avoid leaking migration blocker (Akihiko Odaki)
4ae1c5c7d6: hw/display/virtio-gpu: Initialize blob mapping for ATTACH_BACKING (Akihiko Odaki)
0fa3e1823b: hw/display/virtio-gpu: Fix empty blob discrimination (Akihiko Odaki)
521500bd80: docs/hyperv: fix misleading hv-crash shutdown description (Marc-André Lureau)
8ac0a1c7b9: virtio-gpu: fix NULL deref in rutabaga set_scanout (Haotian Jiang)
415f2759d7: target/i386/sev: fix MemoryRegion reference leaks in gpa2hva callers (Marc-André Lureau)
b28778131f: net/colo: fix g_hash_table_destroy assertion on uninitialized filter (Marc-André Lureau)
4727cc883b: hw/display/qxl: unregister vm_change_state handler and BHs (Haotian Jiang)
efa7244b2a: ui/vnc: remove redundant rows computation (Marc-André Lureau)
1c1232c2ee: hw/display/vhost-user-gpu: validate message payload sizes (Marc-André Lureau)
76dcc0832c: hw/display/virtio-gpu: Remove the bytes_pp field (Akihiko Odaki)
92abc3c51e: hw/usb/hcd-xhci: Check return value of xhci_xfer_create_sgl() for errors (Thomas Huth)
68809288c7: hw/usb/core: Avoid possible assert() in do_parameter() --> usb_packet_copy() (Thomas Huth)
9b899ddb27: hw/ide/core: Fix possible crash via NULL pointer in ide_cancel_dma_sync() (Thomas Huth)
b7520c9a59: hw/usb/dev-uas: Fix guest-triggerable heap OOB access (Thomas Huth)
b71a179148: hw/cxl: Validate Set Feature payload bounds (Feifan Qian)
d71fa99ca8: tests/functional/aspeed: Fix remaining hostname-specific login prompts (Cédric Le Goater)
8268d216a0: linux-user: Guard local FUTEX_CMD_MASK definition (Cédric Le Goater)
1de8aea061: hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect (Christian Schoenebeck)
210701c82e: hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize (Jia Jia)
a0414545a2: hw/9pfs: fix O_TRUNC bypass on read-only export (Christian Schoenebeck)
d55b123473: tests/9p: reduce xattr size to 1k (Christian Schoenebeck)
7858dbb367: tests/9p: prevent potential error in do_local_xattr_limit() (Christian Schoenebeck)
443e024106: hw/ide: replace assert with proper error handling (Artem Nasonov)
a525551d86: hw/usb: record async control completion for parameter transfers (Ziyi Fu)
d915f9d607: hw/hyperv/vmbus: Use QEMU_LOCK_GUARD() (Evgeny Kolmakov)
f604b807a5: hw/display/vmware_vga: Don't allow guest to trigger long running loop in host (Thomas Huth)
68dd6989ab: block/curl: set User-Agent header (Vladimir Lobanov)
dacbde0ad7: char-win-stdio: fix typo in spelling of 'stdio' (Filip Hejsek)
1667cf6b7d: spelling: happend (Michael Tokarev)
bd9b3c50f4: hw/uefi: make SetupMode read-only (Gerd Hoffmann)
acba2d7817: hw/uefi: add post_load checks (Gerd Hoffmann)
8e0ddb4a6e: hw/uefi: account variable policy entries against storage size (Gerd Hoffmann)
647ba95eda: hw/uefi: check lower limit for signature list size (Gerd Hoffmann)
ff5a9eb13c: hw/uefi: remove debug function (Gerd Hoffmann)
702216619e: hw/uefi: add sanity check (Gerd Hoffmann)
e2da3d9274: scsi-disk: fix off by one in assertion (Paolo Bonzini)
d149a11c6c: scsi-disk: protect against guest sending truncated data for MODE SELECT commands (Paolo Bonzini)
51aa3f3e05: target/i386: helper_sysret(): Check that RCX contains a canonical address when emulating an Intel CPU (Andrey Polivoda)
0e48aaae73: meson: propagate qemu_ldflags to Rust link step (Brian Cain)
21069e6b35: target/i386: tcg: remove FIXME (Paolo Bonzini)
aef1e7c5ec: vfio-user: vfio_user_device_io_set_irqs: prevent excessive malloc (Thanos Makatos)
bf10c11af5: vfio-user: vfio_user_device_io_set_irqs: prevent buffer overflow (Thanos Makatos)
761ac964a8: vfio-user: vfio_user_device_io_device_feature: prevent excessive malloc (Thanos Makatos)
5f0cbed64c: vfio-user: vfio_user_device_io_device_feature: prevent buffer overflow (Thanos Makatos)
20b3a363fa: vfio-user: vfio_user_device_io_get_region_info: fix capability check (Thanos Makatos)
6a51aab908: vfio-user: vfio_user_get_region_info: prevent excessive malloc (Thanos Makatos)
3966a4258b: vfio-user: vfio_user_get_region_info: reject unreasonably short struct (Thanos Makatos)
152f7dd3b0: vfio-user: vfio_user_get_region_info: respect max_xfer_size (Thanos Makatos)
f6a321c94b: vfio-user: vfio_user_get_region_info: prevent buffer overflow (Thanos Makatos)
86abb10256: vfio/pci: reject invalid PCI_INTERRUPT_PIN values (Denis V. Lunev)
dff528657f: vfio/pci: don't narrow a failed config read to a plausible value (Denis V. Lunev)
4b2e6505d5: vfio/region: Clarify dma-buf failure messages (Cédric Le Goater)
256229e8f9: vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time (Tomita Moeko)
84a6c5f94b: get_maintainer: add ability to report Git Lab handle (Daniel P. Berrangé)
4f7615789b: gitlab: introduce files mapping GitLab accounts to real names (Daniel P. Berrangé)
15ebb1ec8c: meson.build: re-add explicit gcrypt/nettle request check (Luc Michel)
1b03da3bf8: tests/vm: update to FreeBSD 14.4 image (Daniel P. Berrangé)
7430c34b25: test-util-filemonitor: Adapt to FreeBSD 15's native inotify semantics (Jessica Clarke)


