Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98877C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 15:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u00R4-0005RY-Dv; Wed, 02 Apr 2025 11:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u00R1-0005RJ-Pc
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:55:24 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com
 ([40.107.243.72] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u00Qz-0004mS-Ah
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:55:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWzUEuQMDgSJbOP/nUszR0uMS18QmDSDawgp3IVb8oL4l16V0Vpn48p3jaDsEX191VLsp70cijZV4y/WNOSY8WZDAXhLhq1uZd6t8AO6maruugQdAdR6El5IcQBC+PjFtShKOQAnu/svtwzPRYvI20S82FpskxDM7ZtfnZ68FZLuA0AxE7gVM1iLaQe71f2mU5ODpGlH4wsOqF3whnYZwjfmG0x8rM+MpBmXVhabk7BaKhFU5ehEpg4dj1yFG1ZUP4gFPHZhoGP+SclAPiTmIDWCgJ+YAyng7RfMBftGj5Ip0qE8esqzaWwSlFj68rtAoDvhogPGPko5Hhb1NzbuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+mvkcMlTtimDfxr3wsdR0sUI7IoIIiT9X8ODR327Zg=;
 b=iYr78HHaRmyTuXdJVVYqEQkaq2I/OibMa/TpMwAo2PBZ2XTHKo/6GE0XwhDY/3ME4S8+/6XcvpBcSzOb21UqsgsAskXqDkrrkoF7EagabDCvyftEWQEdaSEJc0rsY5fMZhc20dkv6O2AWlC6rvSNLwIlQvPaSOhYIf4hSSymWiFj0E3IGR8yo342gWEUYmLXG3/iwg/IGkk5dE6fHBFlOPhfp/4DDu0enV1zGxhwErwTh5O352EJ02uQ9qdmElBdQR5y3dKxY+5VX5SQc1iOnOMOatSZ7odra6nt8A4gmpOsCfc3apLAFgz64TQlOEQwvrAfkQTxv57MPnBHof214g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+mvkcMlTtimDfxr3wsdR0sUI7IoIIiT9X8ODR327Zg=;
 b=LP3JvX+GvbMRl5LgQvbdSP69jPROiWJpo8nBi0fhFfAc1wu3SnamHORMFoM4mQUv1F6BPbiyGzVHll388WBqT8w1f3rwN0IsDhwU70wGNzo0Ph+okRmsz6GII/Sw+N+6rA8TcrM7kjClzroLD+6iFxqgLzTeoUZDQ7Oz4kvWn7o=
Received: from BL1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:256::17)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 15:50:13 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::72) by BL1PR13CA0012.outlook.office365.com
 (2603:10b6:208:256::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Wed,
 2 Apr 2025 15:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 15:50:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 10:50:12 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.0.0-rc2 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 2 Apr 2025 10:49:57 -0500
Message-ID: <174360899767.2652907.11077257925426395819@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e4f49d-8fda-4dd7-f9ad-08dd71fe0dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW1SUHlhSW51YklCNEEwNDFMekZBbFJkUFVoY0lnK1BLOUVBanAzc0dOcE1W?=
 =?utf-8?B?ZUh1UUpRMzltTUpiL2NPNVhyNmdrSUQ3SWRxSXFsM1FvQWwvSDFLbUdNVGJ4?=
 =?utf-8?B?RzByYktLaTVsUk5BdG5melJqWlFJY1hlTnVNM05FTFpYbU9BVENkK2hyQkFB?=
 =?utf-8?B?UTBlRlhqWWJ2TWs1VDVMVDhXdXQ2YkhqNjBoTTZMOEhObEdWMFRnTzNsaTJ3?=
 =?utf-8?B?dXpsQWpuajdlN2RPbktnS0YrejdLS1VDZ2tQTUs3OHF5NGFFU29rZnpHWnVm?=
 =?utf-8?B?ckNvQ0JPYW5QSmxqbDdKMmFzV0FFZFJzMnROQnBGTm9IdXRkWHlDSTI1MTBB?=
 =?utf-8?B?NEdCdFJWcTc5S0VPMHdJTWxNWWo4ZlRyNG82TWdwMzlRcDZlVzhHa3pINVdl?=
 =?utf-8?B?cloxOENoWFR4UkxNd3JjVnNYMnJRLzZ0S1VIdnI3M2NxVmlYYzNmSWQzaDhZ?=
 =?utf-8?B?TFpQTkdKQmFsbWIrWmg3OVRiVldLUkl4NGxsdURVZHo3c3FUaW9LUzFnVk5T?=
 =?utf-8?B?cW1oeVAyaWI1RXNkSUVGYkJsLzdwZ0daU1BhMDB4UkU4TjBjTmtIdTczUEpz?=
 =?utf-8?B?ai85UUYxVmxSWVVxc1daY1VDRVVEeEdqWGhtOFVZa2hWbm5hWHNnQm1mMjNn?=
 =?utf-8?B?a1VINUhXaTVEZ2hCOVFtMm1rMlU1cmdZbkVOMy9CcFpyZWIweGpGSG52THh2?=
 =?utf-8?B?NS80Q2R1UGFUSm80UThxMTFsUEhPc0NPeHdEYTdFUG5DdnFrR0VJUXY4SlNj?=
 =?utf-8?B?ZkVnelQwZ1kwN2dtSmJET29zTENHZzVJd3U2VG5JcG0yaWZ1U21lcjhQZGVQ?=
 =?utf-8?B?Q2UxdFhaQlFvcXFKWmtIQy9HRFVEZlFpSGlMR21CQ21ZQ1NRR0RJbm5wdlFV?=
 =?utf-8?B?UlE1RjVSOGE5Vnl5d3BRK1ZtM1BhYXJEMGQ3ckZpcUJCZlNVTTlaNWhvcFhi?=
 =?utf-8?B?OGZvQkV5OUd6N3NYRHc0ZXd2ZENvcTJvTnlpREZFQ1dudTc5SUJXeUo4bmlL?=
 =?utf-8?B?VmJ6YTliSmNtOWQvQmVxRVd1OE4vZElDRUE0QzBITmVQbFJHektkYTVnc3Rq?=
 =?utf-8?B?Yk0yYTcxbytGYi8zOUdUKytTWjFZUXhUT21FdjhEeG54VTdhdVJlZEpPRXJk?=
 =?utf-8?B?Q3B6Z3hqdzZVdFovUGF4UzZwM3BDVkh4RGQyNDNDb0ZMRFoyVGJIcTE5dDVJ?=
 =?utf-8?B?MUQxK1RYSlVnYm81WlBoV3QxWUs3VDFqUDJ2ZFRCNFUwZW5VUlYzY0VRaWJM?=
 =?utf-8?B?eU1BRTJySmxEdGNlcXRGb3FLRnRhQ1RpOHJmQkZHaUFXaVdhdHlhQ3hsWCtR?=
 =?utf-8?B?TTltOGZCdjBCVzMzOHVXSW9nSktOL2luZzBzWGJBTHdSdmZKWmdZbFNLaHhI?=
 =?utf-8?B?WkhYL0x3K0ZJeXdVb2ZXRDVxd2FjZ1hYaFBmNElBcWM1Tkp6c3YyNVZUL3do?=
 =?utf-8?B?N2dVVjJaL2NhV2lFU3pZOVIzT2pnV1E0dmVjZHpoWW1yTG5DbFlNaTdxMVF4?=
 =?utf-8?B?dzI5VzVkVzNXOUdCYktHb2RnZXFkR0VHMGdQdEN4aDVnTkY3WFJTcHhRV0pQ?=
 =?utf-8?B?aEROS0t3WEozSzRFZlJ0NGVkeEZaMlU4cTRFZWhQK0RCcHNRbGJYcm1Pb040?=
 =?utf-8?B?a1JoZHdrUjZQZVp5S1hBdk1nSUJudWwyVzZja1pFeDJiTU5IWVlmeWphL3hl?=
 =?utf-8?B?RzV3eElKV2xNMDQrWVYwSHY1Rng4QndiNis5akFnWlpCRGJMaVVuZ0Y4VTdk?=
 =?utf-8?B?dnVNMWEwdlQ4VGNTL3pITnM5VWd4UW1ITXlCRHRZM3Vmc3YwK1FTTEc4eWky?=
 =?utf-8?B?dnFGd3ZJdkQ4VHRXQ1VMbko2SkFMNUhWVERkck0wd1p3bDl1UGYzZDBMZXFa?=
 =?utf-8?B?OFF6SHUrUlZFZE95bkVyM2NNZkZOSGFSakRNV1Y4QlcvL3BWY2JKYkd6eWRD?=
 =?utf-8?B?M2tkREtUN29kbDZJYWtOOTJUNDlaQnFkakVHZDd5T0Vueks3NERRdkduMDUz?=
 =?utf-8?B?TXhDMWhydERnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 15:50:12.6677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e4f49d-8fda-4dd7-f9ad-08dd71fe0dff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
Received-SPF: permerror client-ip=40.107.243.72;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
third release candidate for the QEMU 10.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.0.0-rc2.tar.xz
  http://download.qemu.org/qemu-10.0.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 10.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/15

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.0

Please add entries to the ChangeLog for the 10.0 release below:

  http://wiki.qemu.org/ChangeLog/10.0

Thank you to everyone involved!

Changes since rc1:

0adf626718: Update version for v10.0.0-rc2 release (Stefan Hajnoczi)
20ab88a906: hw/misc/aspeed_scu: Correct minimum access size for AST2500 / A=
ST2600 (Joel Stanley)
f0095c8ad9: hw/misc/aspeed_scu: Set MemoryRegionOps::impl::access_size to 3=
2-bit (Philippe Mathieu-Daud=C3=A9)
256ba7715b: target/mips: Simplify and fix update_pagemask (Richard Henderso=
n)
d89b9899ba: target/mips: Require even maskbits in update_pagemask (Richard =
Henderson)
fca2817fdc: target/mips: Revert TARGET_PAGE_BITS_VARY (Richard Henderson)
8001d22b0c: target/sparc: Log unimplemented ASI load/store accesses (Philip=
pe Mathieu-Daud=C3=A9)
070a500cc0: target/avr: Fix buffer read in avr_print_insn (Richard Henderso=
n)
fb5bc76cae: target/hppa: Remove duplicated CPU_RESOLVING_TYPE definition (P=
hilippe Mathieu-Daud=C3=A9)
04e99f9eb7: hw/pci-host/designware: Fix ATU_UPPER_TARGET register access (P=
hilippe Mathieu-Daud=C3=A9)
c458f9474d: hw/ufs: free irq on exit (Zheng Huang)
70fe5ae121: hw/char/bcm2835_aux: Fix incorrect interrupt ID when RX disable=
d (Chung-Yi Chen)
1c2d03bb08: hw/sd/sdhci: free irq on exit (Zheng Huang)
48ca224250: hw/scsi/lsi53c895a: fix memory leak in lsi_scsi_realize() (Zhen=
g Huang)
b2e72fadc8: hw/nvram/xlnx-efuse: Do not expose as user-creatable (Philippe =
Mathieu-Daud=C3=A9)
490aaae935: hw/misc/pll: Do not expose as user-creatable (Philippe Mathieu-=
Daud=C3=A9)
2542d5cf47: hw/rtc/goldfish: keep time offset when resetting (Heinrich Schu=
chardt)
facfc943cb: hw/mips: Mark the "mipssim" machine as deprecated (Thomas Huth)
c0a1dabd0b: hw/dma/i82374: Categorize and add description (Philippe Mathieu=
-Daud=C3=A9)
43b815eae1: hw/display/dm163: Add description (Philippe Mathieu-Daud=C3=A9)
82bdce7b94: hw/block/m25p80: Categorize and add description (Philippe Mathi=
eu-Daud=C3=A9)
581ca58246: hw/core/cpu: Use size_t for memory_rw_debug len argument (Richa=
rd Henderson)
f32d678252: hw/arm/fsl-imx8mp: Remove unused define (Bernhard Beschow)
26c1c41e8c: hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from TYPE_SYS_B=
US_DEVICE (Bernhard Beschow)
02e5214624: hw/arm/imx8mp-evk: Fix reference count of SoC object (Bernhard =
Beschow)
8dcfb54090: hw/arm/armv7m: Expose and access System Control Space as little=
 endian (Philippe Mathieu-Daud=C3=A9)
897c68fb79: Revert "target/riscv/kvm: add missing KVM CSRs" (Daniel Henriqu=
e Barboza)
e768f0246c: docs/specs/riscv-iommu: Fixed broken link to external risv iomm=
u document (hemanshu.khilari.foss)
4a7b8c3f5c: docs: Added docs/specs/riscv-iommu.rst in MAINTAINERS file. (he=
manshu.khilari.foss)
694b5a913d: migration: Avoid SNP guest crash due to duplicate cpr blocker (=
Steve Sistare)
0c346576e4: target/loongarch: Fix the cpu unplug resource leak (Xianglai Li)
5a8d024f8d: tests/functional/test_vnc: Skip test if VNC support is not avai=
lable (Thomas Huth)
c3612d0b6a: tests/functional/test_aarch64_virt_gpu: Skip if "dbus" display =
isn't available (Thomas Huth)
6a93b1c7b4: target/s390x: Fix a typo in s390_cpu_class_init() (Philippe Mat=
hieu-Daud=C3=A9)
dba0752f2c: tests/functional: Add missing require_netdev('user') statements=
 (Thomas Huth)
f0a6b3ec6d: tests/functional/meson.build: Bump arm_aspeed_bletchley timeout=
 (Peter Maydell)
3b9731020d: tests/functional/test_ppc64_replay: Mark the e500 test as flaky=
 (Thomas Huth)

