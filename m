Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D14FCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 21:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrlvn-00057I-Lc; Tue, 02 Apr 2024 17:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rrlvj-00056K-HD
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:44:32 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com
 ([40.107.220.87] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rrlvg-0005b3-7w
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:44:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfcxn//rMZ6ZxE06nApGbWntwaYoSMGb8yOWmXh9Bit3X2qAJLcInoGNOZoK9bLyR3jbK8i2h0VadSobibAr4qNVVIsQsxKLMyMVey3i8ZdFDEo2OOcJwQM9OH3BfcJWJ8tO6JLsGWHkvSUSXpFBEZN0O+VHZqvrnozWRQbIbuoI8gvUh3uKVpkfcLCX3uiJFRyivx1RZo06eOjeaFsm5Jt9JIIHv6IxoO942i2L4s4HdtMbvddAvEdmCEWPK5NJYwCugvLiQSLpwj1ANfShdevtgoLnJWMoOTBAvbydQ4YzHSVXjKn+edkSVaJxUCngfXVmezuxefi1RC1Eyd7UOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1qTOcz3CnzFlpC2VbOwpb36YyFcV2VZ3CFWkHbNUZc=;
 b=V4L9wyMDRB6GTas7QiBMHmWlzVzYmXFroKVUCQHPz/coz2rsz3JDhySpPNrMA0P7JZoqZECO181dhF2W5tN/BEuAFQ+1yRhmDvtdwCDvSNrXJ75bdOgbQp0qlFpp/ECqxmI3n9EA2Gj5k44Vd1fhkqqVXwgH9CUEuBSoZ2YRcaOzt/AyTqxj3iZQVn57S7pAnUqC3Y3f17szq0Q8Y4Crmwy1NyA7Wpfb8jTRNnizvT88hzlo718hi6Zbl+p3/JmD89HpfEAmj300XSSMiY1AvjOSXyeNVje7kX6m5vmsLAfjjq6pGPfBkhQm8HAmnCNMI4nGa9z7buweFclU7q+84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1qTOcz3CnzFlpC2VbOwpb36YyFcV2VZ3CFWkHbNUZc=;
 b=Imr7ZFYU4RpR5gTV0qufUwHcAX7cTsxbF6+9p1579XpVFJfmYvOrMWK++MdPLoUkSKXAWMSweRk5wA86x9PGq0lqm2Xm0wtxg3um6BbZmG1/ZEQekzLE/QUqPGoISC4yNcLsaFHjNR6KVZEiDNKNWGsbJ/OzgIR60+Nf+p+F0Xw=
Received: from DM6PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:40::39) by
 IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:39:14 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::e2) by DM6PR03CA0026.outlook.office365.com
 (2603:10b6:5:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 21:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 21:39:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 16:39:11 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.0.0-rc2 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 16:38:53 -0500
Message-ID: <171209393394.615176.17758186871788881381@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: bb204d2a-aa90-4f5e-14f1-08dc535d5732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fUXzLzIAa/Z2Lp3wOnGGIPONes49ZTMGIprO7u+w0lr2zMom/wFfVZPTMllTvvgtLrLGpSKpxSiMA6liXwImN9+8MdZoIzamtVgCGEdV4TttAyb9tJspDlfPjT4OK3zMBMJCuy+bMDGQw+2Ox25Ql6xVmMcl1GdMYZ5CoStXNnLIw+7djmL4w9DVcRGsjXfGvMFZwH4J8744rX6i4ruyLzBw0wMb/wc01RYHIuBuP54plBc95/H0dhzUHupHm/mcSQtz3z3wCf4oR4w6qqgCg7xiqNqj+h0nFfYKAZgZVUFRrkITTfWglTNF2RsKuZvmTg2UrTCbY49vC46ykLYLiqlEPVqaTyQTOZk7NDCgf722nSE4bwNt8wwlgDGsebe6CKE9h1bgENiqwD7T3ubWwvCwN5y8ERsOJJ2spv4IRAublQF55FUh56l4MOCbHRugVW26I042LmcAx057+UxfO4QZOx+RHXL1yOI/LgQxby7M9Js2FWuf6Q/a0VHSs0eR3HBy2BUXYzY1xxB49deCPL5cJG4zraml4Grj+vG1qasBSoa1J+wLYRr/oKdKjlTSwZdD2egvNEl3R89XSIgkQrQTna+Zfk7BheNOwoz4J31B72ZQYBqSm9hAWx2RhMA8AhRM5KYSBb7qbwdoGMIqV3LS8mWv74Nj1TxPWZDiIyoVGj4leeUGbrqJ3cJVLdf5b8LKAAO9qexdPl82fjScw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:39:13.8950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb204d2a-aa90-4f5e-14f1-08dc535d5732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
Received-SPF: permerror client-ip=40.107.220.87;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
third release candidate for the QEMU 9.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.0.0-rc2.tar.xz
  http://download.qemu.org/qemu-9.0.0-rc2.tar.xz.sig

  http://download.qemu.org/qemu-9.0.0-rc2.tar.bz2
  http://download.qemu.org/qemu-9.0.0-rc2.tar.bz2.sig

You can help improve the quality of the QEMU 9.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/11

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.0

Please add entries to the ChangeLog for the 9.0 release below:

  http://wiki.qemu.org/ChangeLog/9.0

Thank you to everyone involved!

Changes since rc1:

e5c6528dce: Update version for v9.0.0-rc2 release (Peter Maydell)
4c54f5bc8e: hw/net/virtio-net: fix qemu set used ring flag even vhost start=
ed (Yajun Wu)
95a3645527: hw/xen_evtchn: Initialize flush_kvm_routes (Artem Chernyshev)
0fa5eefa16: gpio/pca955x: Update maintainer email address (Glenn Miles)
8cdb368d19: hw/nvme: fix -Werror=3Dmaybe-uninitialized (Marc-Andr=C3=A9 Lur=
eau)
c65288de4d: plugins: fix -Werror=3Dmaybe-uninitialized false-positive (Marc=
-Andr=C3=A9 Lureau)
e193d4bdb8: block: Remove unnecessary NULL check in bdrv_pad_request() (Kev=
in Wolf)
aab1b3eeb4: hw/i386/pc: Restrict CXL to PCI-based machines (Philippe Mathie=
u-Daud=C3=A9)
3325af5355: MAINTAINERS: Fix error-report.c entry (Zhao Liu)
4fbb7687cf: qtest/libqos: Reduce size_to_prdtl() declaration scope (Philipp=
e Mathieu-Daud=C3=A9)
d6fd5d8346: accel/hvf: Un-inline hvf_arch_supports_guest_debug() (Philippe =
Mathieu-Daud=C3=A9)
0b796f3810: hw/arm/smmu: Avoid using inlined functions with external linkag=
e again (Philippe Mathieu-Daud=C3=A9)
870120b467: target/ppc: Rename init_excp_4xx_softmmu() -> init_excp_4xx() (=
Philippe Mathieu-Daud=C3=A9)
0eaf7fb9a8: gdbstub/system: Rename 'user_ctx' argument as 'ctx' (Philippe M=
athieu-Daud=C3=A9)
25f34eb708: gdbstub: Correct invalid mentions of 'softmmu' by 'system' (Phi=
lippe Mathieu-Daud=C3=A9)
93019696aa: accel/tcg/plugin: Remove CONFIG_SOFTMMU_GATE definition (Philip=
pe Mathieu-Daud=C3=A9)
7805132bc3: hmp: Add help information for watchdog action: inject-nmi (Dayu=
 Liu)
f6822fee96: Fix some typos in documentation (found by codespell) (Stefan We=
il)
393770d7a0: raspi4b: Reduce RAM to 1Gb on 32-bit hosts (C=C3=A9dric Le Goat=
er)
27c335a464: tests/qtest: Fix STM32L4x5 GPIO test on 32-bit (C=C3=A9dric Le =
Goater)
44e25fbc19: hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is d=
isabled (Peter Maydell)
aaaae12055: docs: sbsa: update specs, add dt note (Marcin Juszkiewicz)
fbe5ac5671: target/arm: take HSTR traps of cp15 accesses to EL2, not EL1 (P=
eter Maydell)
9988c7b50e: fpu/softfloat: Remove mention of TILE-Gx target (Philippe Mathi=
eu-Daud=C3=A9)
8e0cd23f71: usb-audio: Fix invalid values in AudioControl descriptors (Joon=
as Kankaala)
1d2f2b35bc: gitlab-ci/cirrus: switch from 'master' to 'latest' (Michael Tok=
arev)
d0ad271a76: migration/postcopy: Ensure postcopy_start() sets errp if it fai=
ls (Avihai Horon)
30158d8850: migration: Set migration error in migration_completion() (Aviha=
i Horon)
b07a5bb736: tests/avocado: ppc_hv_tests.py set alpine time before setup-alp=
ine (Nicholas Piggin)
74eb04af18: tests/avocado: Fix ppc_hv_tests.py xorriso dependency guard (Ni=
cholas Piggin)
434531619f: target/ppc: Do not clear MSR[ME] on MCE interrupts to superviso=
r (Nicholas Piggin)
ed399ade3c: target/ppc: Fix GDB register indexing on secondary CPUs (Benjam=
in Gray)
978897a572: target/ppc: Restore [H]DEXCR to 64-bits (Benjamin Gray)
d7d9c6071e: target/ppc/mmu-radix64: Use correct string format in walk_tree(=
) (Philippe Mathieu-Daud=C3=A9)
beb0b62c3e: hw/ppc/spapr: Include missing 'sysemu/tcg.h' header (Philippe M=
athieu-Daud=C3=A9)
58cb91b34d: spapr: nested: use bitwise NOT operator for flags check (Harsh =
Prateek Bora)
dafa0ecc97: accel/tcg: Use CPUState.get_pc in cpu_io_recompile (Richard Hen=
derson)
13af3af196: disas: Show opcodes for target_disas and monitor_disas (Richard=
 Henderson)
2911e9b95f: tcg/optimize: Fix sign_mask for logical right-shift (Richard He=
nderson)
4a3aa11e1f: target/hppa: Clear psw_n for BE on use_nullify_skip path (Richa=
rd Henderson)
3bdf20819e: target/hppa: Add diag instructions to set/restore shadow regist=
ers (Helge Deller)
381931275a: target/hppa: Move diag argument handling to decodetree (Richard=
 Henderson)
558c09bef8: target/hppa: Generate getshadowregs inline (Richard Henderson)
d9b33018a0: Revert "tap: setting error appropriately when calling net_init_=
tap_one()" (Akihiko Odaki)
decfde6b0e: tap-win32: Remove unnecessary stubs (Akihiko Odaki)
89a8de364b: hw/net/net_tx_pkt: Fix virtio header without checksum offloadin=
g (Akihiko Odaki)
ba6bb2ec95: ebpf: Fix indirections table setting (Akihiko Odaki)
1c188fc8cb: virtio-net: Fix vhost virtqueue notifiers for RSS (Akihiko Odak=
i)
dcae75fba1: qtest/virtio-9p-test.c: remove g_test_slow() gate (Daniel Henri=
que Barboza)
981eb10603: qtest/virtio-9p-test.c: create/remove temp dirs after each test=
 (Daniel Henrique Barboza)
f8f5986edc: target/hppa: Fix overflow computation for shladd (Richard Hende=
rson)
fe2d066a9e: target/hppa: Replace c with uv in do_cond (Richard Henderson)
82d0c831ce: target/hppa: Squash d for pa1.x during decode (Richard Henderso=
n)
46bb3d467c: target/hppa: Fix unit carry conditions (Richard Henderson)
ababac165b: target/hppa: Optimize UADDCM with no condition (Richard Henders=
on)
d0ae87a27c: target/hppa: Fix DCOR reconstruction of carry bits (Richard Hen=
derson)
7d50b69660: target/hppa: Use gva_offset_mask() everywhere (Sven Schnelle)
6ebebea758: target/hppa: Fix EIRR, EIEM versus icount (Richard Henderson)
0c58c1bc1c: target/hppa: Tidy read of interval timer (Richard Henderson)
104281c10e: target/hppa: Mark interval timer write as io (Richard Henderson)
bd1ad92ccf: target/hppa: Fix ADD/SUB trap on overflow for narrow mode (Sven=
 Schnelle)
578b8132b2: target/hppa: Handle unit conditions for wide mode (Sven Schnell=
e)
2f48ba7b94: target/hppa: Fix B,GATE for wide mode (Richard Henderson)
7fb7c9da34: target/hppa: Fix BE,L set of sr0 (Richard Henderson)
889cd5a8e2: tests/tcg: Test shmat(NULL) (Ilya Leoshkevich)
fa527b44c2: linux-user: Fix shmat(NULL) for h !=3D g (Ilya Leoshkevich)
e6763d7dfc: linux-user: Fix shmat() strace (Ilya Leoshkevich)
b9f38374ac: linux-user: Fix semctl() strace (Ilya Leoshkevich)

