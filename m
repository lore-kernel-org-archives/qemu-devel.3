Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBFB10FCAEA
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w83Ns-0003Dp-Ed; Wed, 01 Apr 2026 17:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1w83NW-00036d-Ep
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:45:43 -0400
Received: from mail-westusazon11010033.outbound.protection.outlook.com
 ([52.101.85.33] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1w83NS-0006Rw-FW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSoE7bRGLio14lICF18F2CeFf3qto1Uj5Uke711rE01crPOend+rvjFy8xbX5kyv/kcvPxIkSlBbuqKWClHUnLL4UhmYYBdCTwwPDcBvA8CDCw5QuJ95uCq8f1QnPS3c0XRK81DuxMkZ9nntJDVQHrZgQS+k9Mj76ljy5b69LuDX4w/yvMZLGzKyHGu4kShvjrx0QI6SScc+5EIttEHGaRErlSfSlDxwNRmzznaYR1zi0DhuJV3tSALJ+Mp8FerPLkcw0ktmmzDN49ssqBGVqKfwoeL6Hh+klrfS34RdoTPKLcKcVgF13T00+RA/S7DP+OeOMjUKmJB0fxlo7uRCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY0zgCDtc8Rds+eU+QrF88OemSAdPA88vx0XSpLthYk=;
 b=GcFWYpcalOYz8b3lM0vm2b1IbG4qt5bXOXhBm9IY2oXapRm0Zoat4SFj2UbSXYxwsj5QuyngL3TpkkU5Sw5EZyLMQHCHdLSrn2qnlEfVyYbDH6QF2cDRzgWi4MXTJsrDK0ajik/pelvpD/JqEcQ48xqKuDaH2U2OWnENpPv5j0fs4ZxqQQw7ETWN147qQheXYNtlWWen2gDSpNAypM0F94w7FLaXhrm2XvsiN0RfTIvIeMn8KdSw4hS03MPmmep0zOVbJhQug+/g5DzSK04OKsYlLiU6qXH8Qe2q0rZ1oyENBqrheHLrBzT7p+JHqM8KczRL01FPQ+wBTnQBUoy0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY0zgCDtc8Rds+eU+QrF88OemSAdPA88vx0XSpLthYk=;
 b=EIQpGY0jnfp1JrbQrkVCajAEc4UmNGM1+ojYaQxCSQqMM3kcXrQgso6OORdXUtzCAbNPQGpBm0ohoUbN0qChwP+k/4a97PnFFxBDsg/JNwSKlGsllK8G7aglxDXWMk5QBoW/e+4F+NR2jlMpLylhEWJbEwfR5GePjSb87/XuJJc=
Received: from SA9PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:6e::35)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 21:40:20 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::66) by SA9PR11CA0030.outlook.office365.com
 (2603:10b6:806:6e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 21:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 21:40:19 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 16:40:19 -0500
Date: Wed, 1 Apr 2026 16:39:29 -0500
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Subject: [ANNOUNCE] QEMU 11.0.0-rc2 is now available
Message-ID: <pw53f3hacd2a3c54p2oepee5je4gfousuxiquzyd7mdroqmujo@6drz7tyr4eff>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e3f50c-2f78-44ea-416b-08de90374563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0DRVE05/sPR51LFF1ceq+5C5v3rLXHfkeycLn45UZ5OjACQpMd7UOQiBrgCdDarxwfW/8TRBDTe992xZdGXIpBq63I25AQnFB14uBdWA1ZX8VNreESc+NT8Zr6+7CQyb1aL1QfMuuudEoF+OxubmR3pMIkfOso+Kp0HTA2WHCphJB3wkBBVPqfmYJx7vIlxezBgPeS+MWUds3hpn7p6TLg1ZSqhlzD8rJE9PwMSZ8lPo5YJtb+Y4Dxk09O6gx3oxOEYs6P7chAzPTGvPcn1ps0sWTOr59dnfmKQCP2Qlrd/whCB5YYR2sKLxeXSYlmvu1FiJqTyVXc0yj63LM3puY8vtCWi+0c/4e92JUTrsx3C6x1T0PfdpNZQQ3XkWq/YsNq8ScsgCLODTdkGwkFjwu9AH2WLCM25sSsSoHRzRKAwWw/UycdKBkpUp06kJNv4CEjm+YWB+7XlHSEF5+Ny57T7BMnNzs/+1hW9m1mZaWX2cwe13bCeAco9ogmecMpjzPsXc/kulOKPZfWKxDcQzs34+v5zTlg29Kq8oxvaM/o1cQGCIdshVa0/FikTdlataimNlyT+xuFhAokmbuatxN8X15sZf524uOlBFO+Ac7UWBKBvvdGIV0yc4z8/vdUamER9TI++Xc0Z9b6Ow4PcLp8glVqQqW8PNWrGIp3fOFN+IkaSb8MPhb0XWDNZeNXH/22uxjjP3LVNaRJK6mfxK788bHf+mAWaR3Y2Joc4Mubg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rTCIisUDbnvUjyl8sU2w7LVVUcPHJKUDpc0BUgsFw+cY6ko33yC/LJXfsmfBBDo8HsakiUhESd4dwAgmCZehVmHYgYI5ukSfkDK8Roy+b2DxT4DLbozAjoa9Y757REmtQs9HYe9D/jszcAdekdQA/8N7Aq8PooFrFuxUigY+580QRFK8gGnBCtX6Qkshj7jsGVM9fQHK7FlCHWdNnIWrGuzqDJUP+oUbQQsj5B5itxGUW+IE7NlJN9ELaoJVSbgP5JKyhVfso4+t+EE5vgfq6dVldZiGVQkDqBLBAVDZ1U9EAa4JbZpNXmIBQuhQjy5DbRWDtYVg/OHvN9bikLIqn56a29NkhI7/c7jJ6pIVrFoALDvpQ0CynPTIfXZYmYGt2qycanx4s0mO4KHr+PuDg5wVUCmiAS2Lxq+IEDv72MKAU6mYRtl1soTiPNRqWpFD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 21:40:19.4313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e3f50c-2f78-44ea-416b-08de90374563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
Received-SPF: permerror client-ip=52.101.85.33;
 envelope-from=Michael.Roth@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
third release candidate for the QEMU 11.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.0.0-rc2.tar.xz
  http://download.qemu.org/qemu-11.0.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 11.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/18

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.0

Please add entries to the ChangeLog for the 11.0 release below:

  http://wiki.qemu.org/ChangeLog/11.0

Thank you to everyone involved!

Changes since rc1:

b6a7d06213: Update version for v11.0.0-rc2 release (Peter Maydell)
bf758751aa: target/hppa: Update SeaBIOS-hppa to version 24 (Helge Deller)
4a84032a26: hw/hppa: Implement memory ranges (Helge Deller)
afcb125165: target/hppa: Fix TOC handler for 64-bit CPUs (Helge Deller)
a45862947e: hw/pci-host/astro: Add GMMIO mapping (Helge Deller)
12cd2e5ec1: hw/pci-host/astro: Fix LMMIO DIRECT mappings (Helge Deller)
4f5367f0a2: hw/pci-host/astro: Implement LMMIO registers (Helge Deller)
64f676beea: hw/pci-host/astro: Fix initial addresses in IOC (Helge Deller)
a3210e056d: hw/pci-host/astro: Make astro address arrays accessible for other users (Helge Deller)
7e966ef38f: bsd-user, linux-user: signal: recursive signal delivery fix (Nicholas Piggin)
fa6dfcc373: linux-user: Make openat2() use -L for absolute paths (Sun Haoyu)
9b7d64686b: linux-user: update select timeout writeback (Sun Haoyu)
22966937f4: linux-user: fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set (Clayton Craft)
8330da591e: include/user/guest-host.h: Provide g2h etc for both abi_ptr and vaddr (Peter Maydell)
ad7a005d67: include: Don't include guest-host.h in cpu-ldst.h (Peter Maydell)
a55402d5c3: block: Fix crash after setting latency historygram with single bin (Kevin Wolf)
99bfc1c754: vhost-user-blk-server: fix opt_io_size=1 causing severe Windows I/O degradation (Max Makarov)
fc1a2ec7da: monitor: Fix deadlock in monitor_cleanup (hongmianquan)
a4d5cfe3ee: MAINTAINERS: fix OSUOSL typo (Alex Bennée)
6a0e2db073: hw/hppa: Disable Artist graphics card on 64-bit machines (Helge Deller)
508a870550: hw/pci-host/astro: Update copyright and documentation link (Helge Deller)
6af42f7c50: ati-vga: Add upper limit to x-linear-aper-size property (BALATON Zoltan)
3b4acaf9e6: ati-vga: Silence warning about operator precedence (BALATON Zoltan)
f2a8070d08: target/i386: Treat qtest like TCG for supported-features (Peter Maydell)
1e0cf63987: target/i386/cpu.c: Correct minor grammar error in warning (Peter Maydell)
a85c5ed33f: backends/igvm: switch to PRIx64 (Luigi Leonardi)
07ec1a7235: target/mips: save CP0 timer in vmstate (Trieu Huynh)
946e4d6506: MAINTAINERS: Separate QDev section from QOM one (Philippe Mathieu-Daudé)
ba48bff09f: ppc/pnv: generate dtb after machine initialization is complete (Shivang Upadhyay)
6bd32ce558: block: Fix references in bdrv_bsc_*() function comments (Yunjian Long)
ccc613f96c: scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable (Kevin Wolf)
59c1d31136: ide: Fix potential assertion failure on VM stop for PIO read error (Kevin Wolf)
425f084fd2: tests: don't build audio tests when no audio drivers are enabled (Anton Kuchin)
9b4edc3eca: igvm: fix parent object type in IgvmCfg struct (Luigi Leonardi)
5df493476f: igvm: fix memory leak on failed memory region init (Luigi Leonardi)
f61ff065d3: igvm: switch to PRIx64 (Luigi Leonardi)
36212b4e85: hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode option values (Peter Maydell)
62ed99e8fe: MAINTAINERS: Remove Igor Mitsyanko (Peter Maydell)
4646224f2a: MAINTAINERS: Remove Riku Voipio (Peter Maydell)
a0721c099b: hw/net/rocker: Avoid double-free of l2_flood.group_ids (Peter Maydell)
31b8d287b7: target/arm: Don't skip access flag fault for AccessType_AT (Zenghui Yu)
6f33b6eebb: tests/qtest/migration: Fix slow test dirty_limit (Fabiano Rosas)
75ecd66028: migration: Fix references to parameter names in error messages (Markus Armbruster)
95650cafc3: migration: Fix up error message for max-cpu-throttle (Markus Armbruster)
c0eaf14d93: tests/functional/migration.py: Skip migration_with_exec() if socat is not available (Zhao Liu)
0f254f70d4: hw/acpi: Do not save/load cpuhp state unconditionally (Zhao Liu)
d459131ff5: lsi53c895a: keep SCSIRequest alive during DMA (Paolo Bonzini)
7c7aaaa342: lsi53c895a: keep lsi_request alive as long as the SCSIRequest (Paolo Bonzini)
1ca38f84e1: lsi53c895a: keep lsi_request and SCSIRequest in local variables (Paolo Bonzini)
64807c84e8: lsi53c895a: do not do anything else if a reset is requested by writing ISTAT0 (Paolo Bonzini)
eea54988fd: ui/vnc-jobs: clear source tag (Marc-André Lureau)
3cae0b46be: ui/vnc-jobs: fix VncRectEntry leak on job cleanup (Marc-André Lureau)
e5ef268596: ui/dbus: tear down clipboard callbacks on display finalize (GuoHan Zhao)
2151a67eb6: ui/dbus: associate add_client completion with its request (GuoHan Zhao)
924b0be88d: audio/mixeng: fix sw/hw mixup in audio_pcm_sw_init_ (Marc-André Lureau)
4862d2c951: lsi53c895a: keep a reference to the device while SCRIPTS execute (Paolo Bonzini)
7be175e65f: hpet: lower HPET_MAX_TIMERS to 24 (Paolo Bonzini)
24b9ebd5f1: hpet: fix bounds check for s->timer[] (Paolo Bonzini)
ee5b216c0e: target/i386: emulate: remove redundant logging for unmapped MMIO access (Mohamed Mediouni)
77a5deba0d: whpx: i386: trace unsupported MSR accesses (Mohamed Mediouni)
ea1169bca4: docs: add WHPX section with initial info (Mohamed Mediouni)
1feb92de34: meson.build: remove i386-softmmu WHPX support (Mohamed Mediouni)
9160305d92: net/ftgmac100: preserve full VLAN TCI in TX tag insertion (linhuang)
9c32999643: hw/i2c/aspeed_i2c: reset and migrate pending_intr_sts (GuoHan Zhao)
a2f0c836bd: pc-bios: remove obsolete linuxboot.bin prebuilt blob (Daniel P. Berrangé)
af4eea83d2: hw/display/cirrus_vga_isa: Disable global_vmstate by default for new machines (Thomas Huth)
d7189d4009: hw/display/vga-isa: Fix migration of the isa-vga device (Thomas Huth)
de9698ead4: tests/functional/qemu_test: Silence warnings from pylint in config.py (Thomas Huth)
bfda4354ee: tests/functional/qemu_test: Split huge fetch() function in asset.py (Thomas Huth)
d22f790934: tests/functional/qemu_test: Silence (most) warnings from pylint in asset.py (Thomas Huth)
d5a678c87c: docs and tests: assets moved after GitHub account renaming (Pierrick Bouvier)
08497afcb2: scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic (Peter Maydell)
65b9f4791c: scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS (Peter Maydell)
b5abb655fa: scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms (Peter Maydell)
eb5cc99aff: hw/nvme: fix heap-buffer-overflow in nvme_abort (Kaixuan Li)
55720ba97d: hw/nvme: re-enable wzds bit in namespace dlfeat (Pankaj Raghav)
e074c90947: tests/tcg/plugins/mem.c: fix endian swap in update_region_info (Pierrick Bouvier)
a08fff99be: include/plugins/qemu-plugin.h: add note about endianness of value returned by qemu_plugin_mem_get_value (Pierrick Bouvier)
539421a428: tcg: Pass host-endian values to plugin_gen_mem_callbacks_* (Richard Henderson)
ba41e52541: target/i386: emulate: follow priv_check_exempt (Mohamed Mediouni)
a003cd280e: target/i386: emulate: set PG_ERROR_W_MASK as expected (Mohamed Mediouni)
746a823a17: target/i386: expose AMD GMET feature (Paolo Bonzini)
cb1e8c18df: hw/audio/sb16: validate VMState fields in post_load (Jenny Guanni Qu)
378b1fdb1a: whpx: i386: fast runtime state reads (Mohamed Mediouni)
9489224382: whpx: i386: fetch segments on-demand (Mohamed Mediouni)
09442d98ab: target/i386: emulate: segmentation rework (Mohamed Mediouni)
016dd86d89: whpx: i386: indirect access to CRs (Mohamed Mediouni)
9548e5b2fe: target/i386: emulate: indirect access to CRs (Mohamed Mediouni)
e2a11aea4e: whpx: i386: add implementation of new x86_emul_ops (Mohamed Mediouni)
94ab400266: target/i386: emulate: add new callbacks (Mohamed Mediouni)
40f1b4d61c: whpx: i386: don't restore segment registers after MMIO handling (Mohamed Mediouni)
ccaa2fb7c2: whpx: i386: skip XCRs read for MMIO exits (Mohamed Mediouni)
fe8c0a8b7d: whpx: i386: skip TSC read for MMIO exits (Mohamed Mediouni)
d2d6d91794: whpx: i386: enable exceptions VM exit only when needed (Mohamed Mediouni)
68438cb3cb: whpx: i386: workaround for Windows 10 support (Mohamed Mediouni)
3060e9b93b: treewide: replace qemu_hw_version() with QEMU_HW_VERSION (Paolo Bonzini)
f093ee7ac3: tdx: fix use-after-free in tdx_fetch_cpuid (Paolo Bonzini)
36578add66: tests/functional: preserve PYTHONPATH entries (Alyssa Ross)
cf9cdaea6e: io-uring: Resubmit tails of short writes (Hanna Czenczek)
7eca3d4883: linux-aio: Resubmit tails of short reads/writes (Hanna Czenczek)
cc03b62df4: linux-aio: Put all parameters into qemu_laiocb (Hanna Czenczek)
51fc8443c1: block/curl: free s->password in cleanup paths (GuoHan Zhao)

