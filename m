Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B154C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 19:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruzhg-0007a4-4e; Thu, 11 Apr 2024 15:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ruzha-0007Zm-O0
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:03:14 -0400
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com
 ([40.107.93.48] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ruzhX-0004ru-RQ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:03:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7lMQQVEFtxIrQ1+HztHHoR1jZnc/s6cdY4AC9gkVgX60YuN4VU0fd4unnvz8jix62raPQfbqW94jbd+NuiLCbhGE8xh8r3tK4eGYkwu3CmMLx6wLfGzgFj0cwV3qWvYuxdvK3c9Avkz+3B4PYXA2pTCd00kfMbGReYQgFhL1jNsPr0pgpA5hC5gN1KbrNz9REg+BQ814Xn6bCbAfDVY5OYIXQwW12CDNZ4C5Oxj2vRUctLY8UplRd8WuPHzngGpYqP5QifciMEyYD+fAyR/ETrOIzEFxAZaJZyV21HPI7BSZH7L7KS2OmAEOy8oNb+3aI9pHdMEhzOdlVbVH1ZZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x/v7Hov0VVy5+J+B7JLNKe1ZqH5hMpucKyF63Qg6d4=;
 b=CWL9eb/ydFQn+y503MPa901buFP8f2WYO9m6xusgXwcp1VdDxdXIDOn8+NWxAn4li3pauHBewlA7pol+bq7o4pIZ1FoCXys2IOoCRui41rNtbiGVg0Ub6qgk6l913kxvalqQtaaKR+dSI25fQNUpQ2XZ8UUHsZLYcNE6ZlNo+5IkoaHUMHh+e0K7EuXJqK+H6fdt1pIvEtmFpncX9OnCZqVv+D3mXM9cfdiYcGwvWrGQNHg8xzQcN6+b0e230SHRQygQDPzSUes3pr4IyBxMxjcQfZq6Eux59XB/9E/zcO9XUbK86bNGTPMj9wxPHjJzXrz7jzXfsBD/wTBvYuq/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x/v7Hov0VVy5+J+B7JLNKe1ZqH5hMpucKyF63Qg6d4=;
 b=jkyQGOxvIWAic6woIrB8TUgZoPjZFEDKqGUWaZ2LO9hSFP/w6lUsGSE1cxkGB6W9m/GjvLxSF4S03rgR8AolN4hyr+NQ9zyLH5arly6rsO1MhfHcfCdIOHYbBPtmaQ7TQeil/bW20o1wbwlNtIsi65B1zgddVTTubyTj6P+oSIQ=
Received: from BN9PR03CA0572.namprd03.prod.outlook.com (2603:10b6:408:10d::7)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 18:58:03 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::f1) by BN9PR03CA0572.outlook.office365.com
 (2603:10b6:408:10d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Thu, 11 Apr 2024 18:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 18:58:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 13:58:02 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.0.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 13:57:46 -0500
Message-ID: <171286186657.1077131.17471878693107298142@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: e694d1e8-fe4f-4c17-43a5-08dc5a595043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GtK2MrkPfAQ5deF8RJgkxPBw7ndReR93bf9ULLY/R80MrVBn3oExW1YhdInAeTYJ9sqDHrzplPvmSgMrAOjx6IRzgAcj79IxI5Ovzhg1Fi1FoRuXFbK7CRkC21TdZvNFXEkbwO3N4c4RksWxbTuuIPgdatfhEs/RKDsHt1X0VLh8ADrN2AWxzUzKXlOGT+8hF35NNMRpF3MDXUsxcs/iajwRj3uYPo1oy8F4Qx7jfi1sPuJNz92JcYV71Kum7P8Sw/EQTS5NO5VEXM7MKENGbS96uuyholl87KwiLCnAmS/qT51nKqmMZXpr+1soXtBXMp0Nbt9e5XR+B6lfJNd/8cemAPMbycvIODAGXTALCgouPu3V4zGVGPpsrX8rFfjwgdp7hx8HjigK3b6XfRokGlDsE2zhvjX2zt0w4oNsVayOc2rJqlgPHj9uQDLhXsYRNlH/9M2B/7HTQvLYSxo998QaTENc7NhCxK/bBMW1G15+NEHcamquvl64ut+k6K04uqFo3jME3ew0Z0iN9w5B7ww+geTFHaYUmLZJu83ILwgYmbtos/JToH7wh14PbM/u4DTzqu0cS2bjobfpCsK3nGtVyWqhsu4e5Lg+36rTNe2NZulbWwXwHw0AsgPsHkhSMneo/zAzVDnqxFIovTSTp6UdF70pn0GjKIDVHAUPBDHXTab/KJWecg8Yc3awPFXfjRIrzlfyrx8lJNMmyNq0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 18:58:02.4630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e694d1e8-fe4f-4c17-43a5-08dc5a595043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
Received-SPF: permerror client-ip=40.107.93.48;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 9.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.0.0-rc3.tar.xz
  http://download.qemu.org/qemu-9.0.0-rc3.tar.xz.sig

  http://download.qemu.org/qemu-9.0.0-rc3.tar.bz2
  http://download.qemu.org/qemu-9.0.0-rc3.tar.bz2.sig

A note from the maintainer:

  With luck this will be our last rc, and we'll be able to make the
  final 9.0 release on April 16th. However there were quite a lot
  of late-arriving changes in this rc cycle, so it's possible we might
  need to make a few further fixes that need us to make an rc4. In
  that case we'll release the rc4 on the 16th, and the final release
  on the 23rd.

You can help improve the quality of the QEMU 9.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/11

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.0

Please add entries to the ChangeLog for the 9.0 release below:

  http://wiki.qemu.org/ChangeLog/9.0

Thank you to everyone involved!

Changes since rc2:

02e16ab9f4: Update version for v9.0.0-rc3 release (Peter Maydell)
dcb0a1ac03: hw/audio/virtio-snd: Remove unused assignment (Philippe Mathieu=
-Daud=C3=A9)
83ddb3dbba: hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum() (Phili=
ppe Mathieu-Daud=C3=A9)
9e4b27ca6b: hw/sd/sdhci: Do not update TRNMOD when Command Inhibit (DAT) is=
 set (Philippe Mathieu-Daud=C3=A9)
ad766d603f: hw/net/lan9118: Fix overflow in MIL TX FIFO (Philippe Mathieu-D=
aud=C3=A9)
a45223467e: hw/net/lan9118: Replace magic '2048' value by MIL_TXFIFO_SIZE d=
efinition (Philippe Mathieu-Daud=C3=A9)
eaf2bd2953: backends/cryptodev: Do not abort for invalid session ID (Philip=
pe Mathieu-Daud=C3=A9)
fc09ff2979: hw/misc/applesmc: Fix memory leak in reset() handler (Philippe =
Mathieu-Daud=C3=A9)
5c338216f5: hw/misc/applesmc: Do not call DeviceReset from DeviceRealize (P=
hilippe Mathieu-Daud=C3=A9)
d39fdfff34: hw/block/nand: Fix out-of-bound access in NAND block buffer (Ph=
ilippe Mathieu-Daud=C3=A9)
2e3e09b368: hw/block/nand: Have blk_load() take unsigned offset and return =
boolean (Philippe Mathieu-Daud=C3=A9)
7a86544f28: hw/block/nand: Factor nand_load_iolen() method out (Philippe Ma=
thieu-Daud=C3=A9)
aa88f99c87: qemu-options: Fix CXL Fixed Memory Window interleave-granularit=
y typo (Yuquan Wang)
f4729ec39a: hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs (Phi=
lippe Mathieu-Daud=C3=A9)
b4295bff25: hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs (P=
hilippe Mathieu-Daud=C3=A9)
ba28e0ff4d: hw/display/virtio-gpu: Protect from DMA re-entrancy bugs (Phili=
ppe Mathieu-Daud=C3=A9)
ec0504b989: hw/virtio: Introduce virtio_bh_new_guarded() helper (Philippe M=
athieu-Daud=C3=A9)
143bcc1d59: linux-user: Preserve unswapped siginfo_t for strace (Richard He=
nderson)
dcd092a063: accel/tcg: Improve can_do_io management (Richard Henderson)
b338970f8c: target/s390x: Use insn_start from DisasContextBase (Richard Hen=
derson)
401aa608d8: target/riscv: Use insn_start from DisasContextBase (Richard Hen=
derson)
e231345027: target/microblaze: Use insn_start from DisasContextBase (Richar=
d Henderson)
8df1ba49d7: target/i386: Preserve DisasContextBase.insn_start across rewind=
 (Richard Henderson)
24638bd17d: target/hppa: Use insn_start from DisasContextBase (Richard Hend=
erson)
4642250e3c: target/arm: Use insn_start from DisasContextBase (Richard Hende=
rson)
e7face702a: accel/tcg: Add insn_start to DisasContextBase (Richard Henderso=
n)
07843f75fd: tcg: Add TCGContext.emit_before_op (Richard Henderson)
5888357942: target/m68k: Map FPU exceptions to FPSR register (Keith Packard)
b754cb2dcd: target/sh4: add missing CHECK_NOT_DELAY_SLOT (Zack Buhman)
7227c0cd50: target/sh4: Fix mac.w with saturation enabled (Zack Buhman)
c97e8977dc: target/sh4: Fix mac.l with saturation enabled (Zack Buhman)
7d95db5e78: target/sh4: Merge mach and macl into a union (Richard Henderson)
b0f2f2976b: target/sh4: mac.w: memory accesses are 16-bit words (Zack Buhma=
n)
26d937237f: target/hppa: Fix IIAOQ, IIASQ for pa2.0 (Richard Henderson)
2ee80bce4f: linux-user: replace calloc() with g_new0() (Nguyen Dinh Phi)
f0907ff4ca: linux-user: Fix waitid return of siginfo_t and rusage (Richard =
Henderson)
e25fe886b8: tcg/optimize: Do not attempt to constant fold neg_vec (Richard =
Henderson)
e3404e01c7: edk2: rebuild binaries with correct version information (Gerd H=
offmann)
2c4eb439dc: edk2/seabios: use common extra version (Gerd Hoffmann)
6494a08d10: edk2: commit version info (Gerd Hoffmann)
6539c73dcc: edk2: get version + date from git submodule (Gerd Hoffmann)
e1999904a9: qdev-monitor: fix error message in find_device_state() (Vladimi=
r Sementsov-Ogievskiy)
f67d296b6e: vhost-user-blk: simplify and fix vhost_user_blk_handle_config_c=
hange (Vladimir Sementsov-Ogievskiy)
6ae72f609a: vdpa-dev: Fix the issue of device status not updating when conf=
iguration interruption is triggered (lyx634449800)
2d9a31b3c2: hw/virtio: Fix packed virtqueue flush used_idx (Wafer)
731655f87f: virtio-snd: rewrite invalid tx/rx message handling (Manos Pitsi=
dianakis)
a45f09935c: virtio-snd: Enhance error handling for invalid transfers (Zheyu=
 Ma)
4034159c1a: Revert "hw/virtio: Add support for VDPA network simulation devi=
ces" (Michael S. Tsirkin)
e34f4d87e8: kvm: error out of kvm_irqchip_add_msi_route() in case of full r=
oute table (Igor Mammedov)
207a2baa16: nanomips: fix warnings with GCC 14 (Paolo Bonzini)
19b254e86a: target/arm: Use correct SecuritySpace for AArch64 AT ops at EL3=
 (Peter Maydell)
d1ce2cc95b: Makefile: preserve --jobserver-auth argument when calling ninja=
 (Martin Hundeb=C3=B8ll)
8e0b21e375: MAINTAINERS: Adjust migration documentation files (Avihai Horon)
7afbdada7e: migration/postcopy: ensure preempt channel is ready before load=
ing states (Wei Wang)
9ed866e10f: target/arm: Fix CNTPOFF_EL2 trap to missing EL3 (Pierre-Cl=C3=
=A9ment Tosi)
d7fe931818: esp.c: remove explicit setting of DRQ within ESP state machine =
(Mark Cave-Ayland)
60c572502c: esp.c: ensure esp_pdma_write() always calls esp_fifo_push() (Ma=
rk Cave-Ayland)
ffa3a5f2be: esp.c: update esp_fifo_{push, pop}() to call esp_update_drq() (=
Mark Cave-Ayland)
743d873645: esp.c: introduce esp_update_drq() and update esp_fifo_{push, po=
p}_buf() to use it (Mark Cave-Ayland)
2c1017bfc2: esp.c: move esp_set_phase() and esp_get_phase() towards the beg=
inning of the file (Mark Cave-Ayland)
3cc70889a3: esp.c: prevent cmdfifo overflow in esp_cdb_ready() (Mark Cave-A=
yland)
5aa0df4067: esp.c: rework esp_cdb_length() into esp_cdb_ready() (Mark Cave-=
Ayland)
5a50644e47: esp.c: don't assert() if FIFO empty when executing non-DMA SELA=
TNS (Mark Cave-Ayland)
266170f91f: esp.c: introduce esp_fifo_push_buf() function for pushing to th=
e FIFO (Mark Cave-Ayland)
da8381260b: esp.c: change esp_fifo_pop_buf() to take ESPState (Mark Cave-Ay=
land)
1f46d1c3a5: esp.c: use esp_fifo_push() instead of fifo8_push() (Mark Cave-A=
yland)
61fa150d12: esp.c: change esp_fifo_pop() to take ESPState (Mark Cave-Ayland)
0e7dbe29c2: esp.c: change esp_fifo_push() to take ESPState (Mark Cave-Aylan=
d)
1828000b48: esp.c: replace cmdfifo use of esp_fifo_pop() in do_message_phas=
e() (Mark Cave-Ayland)
2260402be1: esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in d=
o_message_phase() (Mark Cave-Ayland)
f87d048705: esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in d=
o_command_phase() (Mark Cave-Ayland)
d103d0db71: esp.c: move esp_fifo_pop_buf() internals to new esp_fifo8_pop_b=
uf() function (Mark Cave-Ayland)
bbdf902366: block/virtio-blk: Fix memory leak from virtio_blk_zone_report (=
Zheyu Ma)
8fc4bdc537: pc_q35: remove unnecessary m->alias assignment (Paolo Bonzini)
e497e6a557: lsi53c895a: avoid out of bounds access to s->msg[] (Paolo Bonzi=
ni)
1d1ee7e0a1: vga: do not treat horiz pel panning value of 8 as "enabled" (Pa=
olo Bonzini)
3b6d2b1962: vga: adjust dirty memory region if pel panning is active (Paolo=
 Bonzini)
3826a372e4: vga: move computation of dirty memory region later (Paolo Bonzi=
ni)
5c00acebb6: vga: merge conditionals on shift control register (Paolo Bonzin=
i)

