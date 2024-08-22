Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6A0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 23:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shHGw-000151-UG; Thu, 22 Aug 2024 19:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1shHGt-00014N-KC
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 19:31:17 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com
 ([40.107.236.70] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1shHGq-0004qO-Aq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 19:31:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbltK35bJd6Bl9CKIfCcddnpRrYSGI1FLAlcMVTRE8FgXEQVoGkHPxcyHLe+HFo4owP+8bupergeWXZarUfpYM31So3nrvaeKwh+1Fodb5gLziMgLSA5i14xoQFBvcWO6kJ5XlBjoWy1wO0vO0orwcQhb7YUT0W4FA8iQoUxc6LoNlMW7aA41QZmczl7/+Hp9B3h2l5mLvW8bBzK0cUHtonepiOmu0KhIOd4Z4gUbS2PP8UGTj43/TdHF1Tzs7vE/UGxOp5TgEW4xeJbKJRqXwZh6Z2+iK3+RfUOwtZdQuDT5uVu5wGHk7xW1VbcdbTJwijsROY+CkxaXu3h4rHc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eeGEiaMrYvZiZmw4hJFmtzVER7+NchtBkiCyXNwprs=;
 b=AkYzBj3HZb+gKakHlA7IfRHOm9Ah/J7v63zb2KuzqkAdbbpwcBsx5j5IoQ95Q3SPDzyVszSfMK33KjiD3v7/1o6X7q45ffkCuIMAKd5aFx4tyoA9fxD29Rjbv7wpr/I74pkdlrimH5G0V2aBRC9PPgQTmmihbvidZDlwFS296E9q6C3o0L63sDPk1cLo/U26TxWVC7uNJ/4b2A3vTW+GZBSr9DGh7uCq4OLikn5aDOPDcENy/Nh36CPuxngnuN1kbGXugQGdAnVFKLT1vofK+xQ8hkBSAiCeqtc8XOaj3xk4CHJbYCiOGdsTOgvN3RZ9RErxr4ULNv1D5vHTx3A9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eeGEiaMrYvZiZmw4hJFmtzVER7+NchtBkiCyXNwprs=;
 b=EpydAcgywAIlpJIxwBIzkqYmo6Uvsm1AybA21lbYTs+wsHS1oMkggldih3+mfLF4Id2TE1Xw0mKoVFZ3LPW3YWz8/zgcFmcZwsqaKTA1tpMiup2DMDf5TaWtJozCZlU1uytxjHgWfAbvUPKKyHW2Y+ybmOkDz8q/KeTiAhLVq5A=
Received: from PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::25)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Thu, 22 Aug
 2024 23:25:58 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::77) by PH7P220CA0003.outlook.office365.com
 (2603:10b6:510:326::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 23:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 23:25:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 18:25:56 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.1.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 22 Aug 2024 18:25:39 -0500
Message-ID: <172436913916.2566042.12317315060973305874@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: dd60eb7f-ecab-4f78-b750-08dcc301c6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWRhU1UzUGFWdnVxYkJSR0lRM290b05mQ3c0bCtoQi9ObGVRaThsV1VWa2xp?=
 =?utf-8?B?K3F2bDloUUR6emdrcWxlMEZsR3BtUXpjN3pMc0dlZDR0QnJEOGw2WjU2ZDhB?=
 =?utf-8?B?WHFScUtLOXJwTENVVzNuVTZxQWhTOGFYc0hpb2lGUW1TaVFsc0lYYVpsQU8y?=
 =?utf-8?B?cTdaSjZDdmErTkVybmNzTTR5c1JhSFVXSWo2ZkNtWlpHTGpoRSs5bHM4VGdL?=
 =?utf-8?B?WUdlSGcwS2VqVENEQTFmbVdhc1lOZUVLQnZwWW9kVy9nazc3TWUvY2JxV0pT?=
 =?utf-8?B?TUFZUDJUalZtK3pncExqeHRNYVlnbTE4clRsYlJJV2NtUW92SEczZWhiWWZV?=
 =?utf-8?B?MmdVeWlZUkVRWlViN2IyMGRrRXhqM0tHVC9LalV1SXhRZkNBV2hQdTQvVWJa?=
 =?utf-8?B?MitYdGtyQ0k4WnFQNjZDZEU1WGh4cjJtbllTVnFUY3Q3MHM4UVA4cUVxcmpy?=
 =?utf-8?B?Vyt2T3FRWER1R0tGL1ZhaWsybkF0VUY3aVVLWElzYzI3UDZreHFnR1dKZWVF?=
 =?utf-8?B?eXlRNm9zRXFsM1BUc3BrbnIyb2s3RVgvUVpBYWFWTFVncDlJQ3JLamdTb3pn?=
 =?utf-8?B?NkZqNXhiODJad2ZlREg1ckJ0WUx3RFlqZzlWdHc1akswdURQSG5VZzNyL2gy?=
 =?utf-8?B?NEF6dDB4VGxNaFBlR2hWVXFUa1VWdHZ3T01aS1lwTXZXSEM4c1VyV1lNa3Bj?=
 =?utf-8?B?bnNUMnVrVms3YVJGYjF5RDV4bnUvdy83aS90NFdyM3E0UVRwc3lmNVFrbzZo?=
 =?utf-8?B?Umx2R01aYnhsSkxLU1hlejVvWTRHeWlWMUhEYWVwK00raERzMFJ3Z01NeGpG?=
 =?utf-8?B?WklhZndreG9KMXgvWDlmcWtVVlZ0M0NiV1YvZHRwQjRsL0dyN3I2dHZRUkRp?=
 =?utf-8?B?MWtwaDN6dWhZcWcxNkdCV29nSzFoSlRwRnlmYk0yTVc5clNGYURLRGR3RUNO?=
 =?utf-8?B?RVRVV2cxQjRNYitFZ0RZVFA2eHJIc2hTRjY0K1ZIbjhGSDlLL0hXa0xJUjR0?=
 =?utf-8?B?amVFaEFzK01ZS3J1VzVBQWlMOGJIdmx1c3lvemNoc1ExdnlqWjJzVzRjVmUz?=
 =?utf-8?B?OFU5cmdTelRPWWV4RVp1K2ZLVWJYUGQ1NWRPbS82djVzM3Nyd3FiVEc0NmdI?=
 =?utf-8?B?NU0wTFZocytVeHJvTEFGVlROb3grakp1THRwb051SXdGVmVsZFN4UUNjYUUy?=
 =?utf-8?B?b2N2N2pUSFZqRFQ5OENmRFZSMmZoNStwb21LcjJmUklnSURWRDlCWlN1Z1pE?=
 =?utf-8?B?WWNzNVVBSkkrNzkrWmpWNzBvbUNXLzN3N1RadFlxdG9mUHZZc3hhVThWeXZq?=
 =?utf-8?B?Z0M5ekN5UnFJME5YbkpXcUo5ZHBkTHR3dGQySFljNk05ZjBzOTlvMkIvcnBh?=
 =?utf-8?B?YXZjbkZZeVBPdVE5K3NZVVh4Q2ZyY0RESjNySy9FcEswbkJKZmVjMVpCbENH?=
 =?utf-8?B?cmdWRndjOHhaeGo4bTdUMlFwMnRLNXNrV3lLK1J1TlFvc3pRanNuZEtmZmIx?=
 =?utf-8?B?dlUzNUljc2JNaTk0TnMzNGRpTFN1YU9ibXJXemxEZlBFRm8yWUF5bmJrMGJq?=
 =?utf-8?B?ZUJuVUlMZ3l4dTZVNkZKOFJCcHVnNTBKVk1nSVN4OGMzRzFzOVphRFZTekVp?=
 =?utf-8?B?dXJJMWs4ZEhzOGVKYWd5Z0FhRFphMUVJQkVYaHdFemo2MU5ZdGg2dUw5cXpZ?=
 =?utf-8?B?SzBGQ0lZZXlwVmFoQmpPK3doVTkzc0NUeUF4SWFhQll2WXk4aUQ0eHdoSE4r?=
 =?utf-8?B?YzdsOUkya2lsZWVNckl6TzNFdjdycUIxMnRmeFh3Qm9zZGhkUEVRRGJmeUJF?=
 =?utf-8?B?em5JczViekpYZFp3VjlQb3paLzdCeGNNOHlhTzVNSU1RTmdWMVZzRXFLMWFq?=
 =?utf-8?Q?6kQU7NtAA8Hlw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 23:25:57.4436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd60eb7f-ecab-4f78-b750-08dcc301c6b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Received-SPF: permerror client-ip=40.107.236.70;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
fourth release candidate for the QEMU 9.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.1.0-rc3.tar.xz
  http://download.qemu.org/qemu-9.1.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 9.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/13

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.1

Please add entries to the ChangeLog for the 9.1 release below:

  http://wiki.qemu.org/ChangeLog/9.1

Thank you to everyone involved!

Changes since rc2:

407f9a4b12: Update version for v9.1.0-rc3 release (Richard Henderson)
d4f5e5af86: hw/loongarch: Fix length for lowram in ACPI SRAT (Jiaxun Yang)
ded1db48c9: target/i386: Fix tss access size in switch_tss_ra (Richard Hend=
erson)
83a3a20e59: target/i386: Fix carry flag for BLSI (Richard Henderson)
266d6dddbd: target/i386: Split out gen_prepare_val_nz (Richard Henderson)
5b73b248a1: bsd-user: Handle short reads in mmap_h_gt_g (Richard Henderson)
a4ad4a9d98: linux-user: Handle short reads in mmap_h_gt_g (Richard Henderso=
n)
4c107870e8: migration/multifd: Free MultiFDRecvParams::data (Peter Maydell)
a8e63ff289: virtio-pci: Fix the use of an uninitialized irqfd (Cindy Lu)
7d14471a12: hw/audio/virtio-snd: fix invalid param check (Volker R=C3=BCmel=
in)
f8e09b973a: vhost: Add VIRTIO_NET_F_RSC_EXT to vhost feature bits (Akihiko =
Odaki)
6a22121c4f: hw/nvme: fix leak of uninitialized memory in io_mgmt_recv (Klau=
s Jensen)
87e012f29f: crypto/tlscredspsk: Free username on finalize (Peter Maydell)
702cbdc46b: hw/i386/pc: Ensure vmport prerequisites are fulfilled (Kamil Sz=
cz=C4=99k)
c911f875f8: hw/i386/pc: Unify vmport=3Dauto handling (Kamil Szcz=C4=99k)
6373fc0323: hw/ppc/Kconfig: Add missing SERIAL_ISA dependency to POWERNV ma=
chine (Bernhard Beschow)
12d36294a2: target/sparc: Restrict STQF to sparcv9 (Richard Henderson)
47f06fb4c8: contrib/plugins/execlog: Fix shadowed declaration warning (Pier=
rick Bouvier)
8e540bbe45: tests/avocado: Mark ppc_hv_tests.py as non-flaky after fixed co=
nsole interaction (Nicholas Piggin)
4a85f23157: tests/avocado: exec_command should not consume console output (=
Nicholas Piggin)
e922abf5c0: linux-user/mips: Select Loongson CPU for Loongson binaries (Phi=
lippe Mathieu-Daud=C3=A9)
309ce6af94: linux-user/mips: Select MIPS64R2-generic for Rel2 binaries (Phi=
lippe Mathieu-Daud=C3=A9)
1e5a7c57a5: linux-user/mips: Select Octeon68XX CPU for Octeon binaries (Phi=
lippe Mathieu-Daud=C3=A9)
f7e3d7521b: linux-user/mips: Do not try to use removed R5900 CPU (Philippe =
Mathieu-Daud=C3=A9)
7d3a421fea: hw/remote/message.c: Don't directly invoke DeviceClass:reset (P=
eter Maydell)
dfad8421af: hw/dma/xilinx_axidma: Use semicolon at end of statement, not co=
mma (Peter Maydell)
44017c6655: target/mips: Load PTE as DATA (Philippe Mathieu-Daud=C3=A9)
7ce9760d64: target/mips: Use correct MMU index in get_pte() (Philippe Mathi=
eu-Daud=C3=A9)
453ba4f675: target/mips: Pass page table entry size as MemOp to get_pte() (=
Philippe Mathieu-Daud=C3=A9)
68baeaafa5: qemu-options.hx: correct formatting -smbios type=3D4 (Heinrich =
Schuchardt)
ec276edb38: hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection (=
Jiaxun Yang)
d762016d51: hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineSt=
ate (Jiaxun Yang)
6df664f87c: Revert "hw/riscv/virt.c: imsics DT: add '#msi-cells'" (Andrew J=
ones)
278035fc81: plugins: fix race condition with scoreboards (Pierrick Bouvier)
3f9f9a37ae: docs/devel: update tcg-plugins page (Pierrick Bouvier)
24c32ed374: docs: Fix some typos (found by typos) and grammar issues (Stefa=
n Weil)
97d2b66dcd: savevm: Fix load_snapshot error path crash (Nicholas Piggin)
44bc14fa1e: virtio-net: Use virtual time for RSC timers (Nicholas Piggin)
a0bf401b8e: virtio-net: Use replay_schedule_bh_event for bhs that affect ma=
chine state (Nicholas Piggin)
4c193bb129: chardev: set record/replay on the base device of a muxed device=
 (Nicholas Piggin)
253ec604a8: tests/avocado: replay_kernel.py add x86-64 q35 machine test (Ni=
cholas Piggin)
94962ff00d: Revert "replay: stop us hanging in rr_wait_io_event" (Nicholas =
Piggin)
9dbab31d9e: replay: allow runstate shutdown->running when replaying trace (=
Nicholas Piggin)
4926b6e644: tests/avocado: excercise scripts/replay-dump.py in replay tests=
 (Nicholas Piggin)
01a385fb49: scripts/replay-dump.py: rejig decoders in event number order (N=
icholas Piggin)
00140e79bb: scripts/replay-dump.py: Update to current rr record format (Nic=
holas Piggin)
20fdd01e51: buildsys: Fix building without plugins on Darwin (Philippe Math=
ieu-Daud=C3=A9)
cf584a908a: target/i386: allow access_ptr to force slow path on failed prob=
e (Alex Benn=C3=A9e)
503eb470e0: scripts/checkpatch: more checks on files imported from Linux (S=
tefano Garzarella)
5f9ad35e04: configure: Fix GDB version detection for GDB_HAS_MTE (Gustavo R=
omero)
34a4ef1c5c: configure: Avoid use of param. expansion when using gdb_version=
 (Gustavo Romero)
819039a5ad: configure: Fix arch detection for GDB_HAS_MTE (Gustavo Romero)
6fe12bc659: Makefile: trigger re-configure on updated pythondeps (Alex Benn=
=C3=A9e)
8a69613e9c: tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot (Philip=
pe Mathieu-Daud=C3=A9)
b4be15a9f9: ci: refresh package lists with lcitool (Daniel P. Berrang=C3=A9)
6d67a65f10: ci: add gtk-vnc to the deps (Daniel P. Berrang=C3=A9)
3185e5a6f7: tests/avocado: apply proper skipUnless decorator (Cleber Rosa)
e25264fe7b: meson.build: Check for the availability of __attribute__((gcc_s=
truct)) on MSYS2 (Thomas Huth)
e4a4edc10a: target/s390x: fix build warning (gcc-12 -fsanitize=3Dthread) (P=
ierrick Bouvier)

