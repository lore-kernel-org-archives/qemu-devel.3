Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14822C4452D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmKdt-0002XV-Uj; Tue, 21 Jul 2026 20:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wmKds-0002Vn-Cy
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 20:16:56 -0400
Received: from mail-eastusazon11011037.outbound.protection.outlook.com
 ([52.101.52.37] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wmKdp-0005o6-Rv
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 20:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6Gvrq7uOcWcZuaCzdvhcWPrnbzTZL4ofePaQjf4heNQ/wDTiE562F0XZ5WWXgzuPvqgNii4qd+dZScVvLjkBKYMXcbpGDIiQ2wDdbgH8stK5NVRxw/cFltK6x6a4Qo6CfnP6SiAoYDDdYStV8Qo3kGQDLoADfcmA62kMRXzRgpoOiVOebFPrg/QUbBusfWog7/tHau7clNWyyiPGypTF+zpnhpGa1NNKpDPvBiGrq0aLFTrwRxQdsFe8O1gGqCjtiMw8IlyZ2ydHEr8u/bRc7c1xYflIxRP0OxvG2F1CcS8qoZevVEXL2wvM/t8NyQjXnrJWCe1eg1xFtCoVboCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFzOQvRVt1ciMahGqafEYQboh3OYnQq5RdWfd1scmzo=;
 b=hoXPyQHgGEw7XQ0Dk3izZhEypb1/Z9CxsP563kZ60VfV2C8kR3XGIGfiZKovVV/63CX2VsM+vkzJrlrE3rpFJmkxhGc3JWfWNKKHHQLQ55+Msv4J+285B6NXnh7WS0Jn/v3xepGXuDS3Hz558JjUcF6t+ETJgfhmhvmBWqrUOmi17ihpBE+HyMmuCcgTgdKOeKVRM+jwLfoS378bXS0Z7y0qBFX9+KMfb7nlaOaC90W+xBCwu0yGwAJRp+l2vfeygx8SBjNBva8flWICf5XsraSdSwuSFcadruIaYb4rxIgIgq2sf69lTcHv3Phq6KuyVYABgCnHYJHGTBh5RKjTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFzOQvRVt1ciMahGqafEYQboh3OYnQq5RdWfd1scmzo=;
 b=uUcXfxiyl/bwc8c/ZuQ2UWQJ6temHpRqc0GlW9fa6T+MN8WdWa+YAQ2x1bO+1Rhu+YfHEPNV0wyNatVtiR/KqOp22R2AHv74mDcq4eoaEbciIdiueo4abD+jwg3+brYdIbUnKnWaNdIj8GGusWLMpERB81oTFT16qc2N0xyVcjc=
Received: from PH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:510:5::29)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 00:11:45 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::62) by PH0PR07CA0024.outlook.office365.com
 (2603:10b6:510:5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 00:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 00:11:45 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 19:11:44 -0500
Date: Tue, 21 Jul 2026 19:10:53 -0500
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Subject: [ANNOUNCE] QEMU 11.1.0-rc1 is now available
Message-ID: <tdnktodfircf6x7qqvpuzegxaucsp7bxszesvlmu23iq37sowq@aayrijkcpjnb>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fdcf18-f4ed-45e4-db36-08dee785d0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|10067099003|56012099006|11063799006|13003099007|18002099003|27256017;
X-Microsoft-Antispam-Message-Info: 3HdI39tKjkBEEAS11QIKn6ddGPJYO7j3VjIYsTh+t/uUnawF6v79fB87XWZY43Hd1EMOLkMqZTJA/Zn18aRA8tIN5wjSYoMxx5mgKtPZ12Eh8rPtdzAU9p8UpMZbXy0y9HJDSSAWnPglz/bTbICACDs+C/TxSR6yCx4pw2mlv6CaQEpaowWxWkBLo/llcYsf1VI7lEJeMrPh9YDuexMoQWBZ1+Cb6y18LZgLsdmJyy2PUKGkt8aie694RoF0Vr7de0SWHpG8ehLDVrwpSq88Nj0V6m7AJQlUnwuglBtkfvwbdVihK7fRc6pv4Vz/YClJB+hCpnVfRUdespOjYRwRhEpGibZ+859iu3O8LZycbljn6ncLZTBXs5egcOiaEKYVJkDWYTJt4yxqa+Y97wIzV5c7KeRPEps+7NQgeD/+JopLo3JuhiQ64HnoaPDM4eQ3+vDrqRU8UMa0bKl+lHHMJxGlOCF0OEWwnlUH9YnPn5ALStLkZonLgISFHacAi5Istc2SLbdS7v0h0fDlOKEaGSq5onn2QDHJDJewZpsQMLdWqD2rkusmPfIzwI8zy1YoPW1OP9C1TSUknVR8YDWjhJf1g0cITmjMTlgsgCOAVC+cACCxl5jICOivgre24uqKU+6YF2byt+sEp1Qvl19zOfjX9yr+KxHIt0JwrzT6E56CsQw5ocM/3g7qyDyYBYudPwCEfpcppDUNX9s4q1sgOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(13003099007)(18002099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pB2P/MFXqFvmI8o17Fkz5RIV5qCYuE7A2/vPW5WQFp5F6Ym4ZmAXXJwh8DL7ZAC0oHqJJRfM2/XeVv1O64fum74K+la2/1PdSGdSVv6AY9SDP1hrOTW7l2j8VmrkYC66R1aKfsFCwq+TnBvtFMAq3xIwPpBmtgzfTzRBfzwF5uDLjX6gq0gdwujcJf3OZjIAgPlGHXangfXe1SWdNfI6fJGQTLVJlr9c7WWrwZDXtWAPlB4qP9f8tM1qRQ8IcRvFo/Zf//MfutTb9wvlciiB78j+Wg6NI0h8hQZcgjmme71NTxlkMW0JbeceNRLa/AsG+a3lw8r1Qe8OFNgUPLJ/ANZTcTLvQYww0RQ2UkZdLvLxW/bdmpHvyENuZ1xutuKhly4Bst5HcRbbzLdOX+p4RUYAlKuFyMqNwgxUjJosGkdW3jpcEMyfHeGqn26ENQtY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 00:11:45.1076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fdcf18-f4ed-45e4-db36-08dee785d0bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
Received-SPF: permerror client-ip=52.101.52.37;
 envelope-from=Michael.Roth@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
second release candidate for the QEMU 11.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.1.0-rc1.tar.xz
  http://download.qemu.org/qemu-11.1.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 11.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/19

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.1

Please add entries to the ChangeLog for the 11.1 release below:

  http://wiki.qemu.org/ChangeLog/11.1

Thank you to everyone involved!

Changes since rc0:

cbd42e2b75: Update version for v11.1.0-rc1 release (Stefan Hajnoczi)
c3662589c4: docs: fix sphinx build failure (Pierrick Bouvier)
ad14439be5: gitlab: remove gdb from MacOS jobs (Alex Bennée)
d06edc83b5: vfio/listener: Remove unnecessary 'linux/kvm.h' include (Cédric Le Goater)
c257745248: hw/audio/intel-hda: restrict all DMA engine paths to memories (Haotian Jiang)
c477e32b64: hw/sd/sdcard: Fix error case for CMD18 (Bernhard Beschow)
94c510a5dc: hw/net/cadence: Return current Cadence GEM queue pointers (Bin Meng)
2142689d92: hw/misc/applesmc: Fix a typo setting MSSD key (Philippe Mathieu-Daudé)
fe68e4b47b: replay: fix use of uninitialized pointer on error (Marc-André Lureau)
701e8d1ee9: user/guest-host: Include exec/abi_ptr.h (Richard Henderson)
9f436938c5: hw/display/qxl: validate monitors_config heads[] in phys2virt (Marc-André Lureau)
b1e73b2ddb: net: Correct padding check in qemu_receive_packet() (Peter Maydell)
533c98e769: docs/about/emulation: sharpen the dlcall boundary and its guest requirements (Ziyang Zhang)
99916cdb4d: tests/tcg: correct why the magic syscall number is safe here (Ziyang Zhang)
bc5b22b4d4: contrib/plugins/dlcall: correct the syscall number claim, note the data model (Ziyang Zhang)
b693da615a: Revert "target/arm: Build cpu32-system.o as common object" (Peter Maydell)
fcebaea2e3: MAINTAINERS: Add soc_dma to OMAP section (Peter Maydell)
a5223ea536: include/hw/arm/omap_dma.h: Move to include/hw/dma (Peter Maydell)
f5541f51cf: hw/dma/soc_dma: Remove unused mem.base, paddr fields (Peter Maydell)
3162318194: hw/dma/soc_dma: Use physical_memory_map() for mem2mem transfers (Peter Maydell)
22afad9489: hw/dma/soc_dma: dma bytes is uint64_t (Peter Maydell)
efbf01e03f: hw/dma/omap_dma: Be more careful about overflow in transfer setup (Peter Maydell)
68f788e705: hw/dma/soc_dma: Remove union from memmap_entry_s struct (Peter Maydell)
f00bef33fe: hw/dma/soc_dma: Simplify soc_dma_ch_update() (Peter Maydell)
02cfe21f6a: hw/dma/soc_dma: Remove soc_dma_port_fifo support (Peter Maydell)
1f8aa4b6af: target/arm: Fix testing of raw mtx value (Richard Henderson)
a148ca7627: target/ppc: Remove unused helper_lscbx() (Peter Maydell)
2a9847868f: target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can change IRQ/FIQ (Peter Maydell)
4ef00a9fc4: target/arm: GICv5 cpuif: gicr_cdia_read() ppibit should be 64 bits (Peter Maydell)
8392734722: hw/net/xilinx_axienet: Fix PHY register 17 link status reporting (Jay Chang)
8833ff95ea: hw/char: imx_serial: add missing migration state (Tao Ding)
94bd02908a: iotests/108: avoid leaking FUSE mount (Stefan Hajnoczi)
cc479aa897: hw/usb/hcd-xhci-sysbus: Fix OOB heap access in xhci_sysbus_intr_raise() (Thomas Huth)
4daeaa2fe0: hw/usb/hcd-xhci: Fix guest-triggerable assert() in xhci_find_stream() (Thomas Huth)
a002485bfe: usbredir: fix infinite loop and SIGFPE with zero max_packet_size (Marc-André Lureau)
9bf52d056a: usbredir: fix use-after-free on buffered bulk packet overflow (Marc-André Lureau)
ba54d7e66e: tests/qtest: add xhci-pci unplug finalize regression test (Xiangfeng Cai)
054ef33f67: hw/usb/hcd-xhci-pci: break host link cycle so device_finalize() runs on unplug (Xiangfeng Cai)
12d8ee9d53: hw/usb/xhci: clamp interval exponent to avoid UB shift in xhci_init_epctx() (Feifan Qian)
c0e370474b: linux-user/sparc: Take pending signals in sparc64_set_context() (Peter Maydell)
260d15c45b: tests/functional/hexagon: add arch_tests functional test (Brian Cain)
94a5b3ff4e: target/hexagon: fix PC not advancing for non-COF TB-ending packets (Brian Cain)
c4066c84cd: target/hexagon: initialize deferred sreg-write temps to current value (Brian Cain)
44d1829c6c: target/hexagon: fix get_phys_addr_debug with in-page offset (Matheus Tavares Bernardino)
430261acac: tests/tcg/hexagon: add unaligned scalar test (Brian Cain)
13eb268182: target/hexagon: raise SIGBUS on unaligned data access in sysemu (Brian Cain)
84b9a537d6: target/hexagon: raise SIGBUS on unaligned scalar stores (Brian Cain)
93cf730514: target/hexagon: raise SIGBUS on unaligned scalar loads (Brian Cain)
d7a6df755b: target/hexagon: handle misaligned load/store cause codes in cpu_loop (Brian Cain)
8aea63e965: target/hexagon: fix -Wshadow=local build error on GCC 14 (Brian Cain)
e872e09add: gitlab-ci: build hexagon-softmmu to enable functional test (Brian Cain)
390bf4fbc3: tests/docker: hexagon fix podman untar, 22.1.8 (Brian Cain)
60f2281450: migration: clean up postcopy blocktime presentation (Bin Guo)
c923ae77e7: migration: fix ineffective overflow assert in postcopy blocktime (Bin Guo)
f1af81ba2a: hw/display/virtio-gpu: Check pixman_image_create_bits() results (Akihiko Odaki)
9c724426f5: hw/display/virtio-gpu: reject strides exceeding INT_MAX (Akihiko Odaki)
e99488c5d4: hw/display/virtio-gpu: handle migration iov allocation failure (Marc-André Lureau)
8720061c6d: hw/display/virtio-gpu: cap submit_3d command buffer allocation (Marc-André Lureau)
861372428b: hw/display/virtio-gpu: validate stride against width on scanout (Marc-André Lureau)
6d2cf4466f: hw/display/qxl: fix TOCTOU in cursor chunk data_size handling (Marc-André Lureau)
db2716bce2: hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure (Marc-André Lureau)
6075444c5a: ui/vnc: validate SetPixelFormat field ranges (Marc-André Lureau)
e650e4fe0f: ui/vnc: fix out-of-bounds write in lossy refresh dirty marking (Marc-André Lureau)
53f0d87db7: ui/gtk: Narrow DMA-BUF critical section (Akihiko Odaki)
82b4d693d5: ui/input-barrier: fix off-by-one in keycode bounds check (Marc-André Lureau)
3162692a3b: ui/vnc: use RFB wire types for client message handlers (Marc-André Lureau)
fb71c895d7: ui/vnc: validate color shifts in SetPixelFormat (Marc-André Lureau)
3543c2b855: ui/vnc: fix OOB write in vnc_refresh_lossy_rect (Marc-André Lureau)
40cdadfefd: i386/tdx: fix uninitialized variable warning in tdx_check_features (Marc-André Lureau)
c4ce04cfb7: tests/docker: ensure container command is probed at most once (Daniel P. Berrangé)
fdff1c864a: plugins/execlog: fix execlog vcpu_exit execution print loss (Harry van Haaren)
c0c8990a2b: plugins/execlog: fix segfault/race-cond on per-vCPU structures (Harry van Haaren)
504f2bad93: net: only advertise passt in netdev help when CONFIG_PASST (Rohitashv Kumar)
ebe66684a5: hw/usb/hcd-xhci: Use qemu_log_mask() instead of fprintf() statement (Thomas Huth)
96c9f9709d: hw/usb/hcd-xhci: Remove the FIXME macro (Thomas Huth)
5257259428: hw/usb/hcd-xhci: Turn guest-triggerable abort() into qemu_log_mask() (Thomas Huth)
98e5a8eb4f: hw/usb/hcd-ohci: Make sure that ohci_service_ed_list() cannot loop forever (Thomas Huth)
564c4d7e99: hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure (Marc-André Lureau)
76dbe26fd6: hw/sparc64/niagara: use int64_t for vdisk size to avoid truncation (Dmitry Pimenov)
a3cc0069e1: hw/display/qxl: fix TOCTOU in cursor chunk data_size handling (Marc-André Lureau)
ecc569639a: hw/scsi/vmw_pvscsi: add a comment to explain the endianness (Miao Wang)
5a811329bd: hw/scsi/vmw_pvscsi: translate data endianness (Miao Wang)
6387fbad45: docs/devel: Document SSI dummy-cycle ownership (Bin Meng)
5157ceb10c: hw/misc/ivshmem: clear chardev handlers before freeing peers (Haotian Jiang)
506fa577db: hw/sparc64/sun4u: Mark unusable PCI busses as full to ease device plugging (Thomas Huth)
87f608e3c2: json-parser: fix formatting of comment (Paolo Bonzini)
f87693a841: MAINTAINERS: Regularise the status fields (again) (Markus Armbruster)
9dbce799e7: qom: Fix device-list-properties & friends to show legacy-FOO props (Markus Armbruster)
8b61adae4e: qapi: Fix misspelled section tags in doc comments (Markus Armbruster)
8ba384cc32: migration: Fix invalid %ud format and trace arg typo (yujun)

