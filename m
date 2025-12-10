Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB73D3B9AD
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 00:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT8Qo-0005Io-FO; Tue, 09 Dec 2025 19:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vT8Qm-0005IO-Q6
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 19:51:48 -0500
Received: from mail-westus2azon11012050.outbound.protection.outlook.com
 ([52.101.48.50] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vT8Qk-0003kz-5y
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 19:51:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldOBhY/3VwdVbpK60S13WdwhcVELc1sCJGEK4ScWALTbFePxFmncAD7x85offLhS951QNCsL0N6ztgEbRNfxFTA23rHnN0QbkfVyR3I7MBgEfjMLBjAoTrzxsN+7qHhsYurWR3CYgLumiefk15rdYPKozkF+05nsP7BHqrVYDoLCvmUToaTGhyKDNnY0R6yay/cZ+OGRJrAJlQf/pv/0QJHeuBJ2VNyBme1uMDjf299C0cHCoXiVi8/TA/VNnvHVVUJTgeCyk32SjkfxZLkmBwrOZO6VaRb4iQ2GxUbkdkO0aglSPNCqXTdod+sUJNpfp0KRfdiYoTGpL+ME3PYpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf/ZWO8u4BNCKW8o/OBo/HSLiOuV7pRxJAnFUJMzg/Y=;
 b=AnjuK1iqLa1AHsUa3xCg2znN7rO+WsrgMcn5DxeKuYdlZn6av1B4HBGFDji24CoLzg8zyKxZCcYDbXzWbN3OnFOEeq9YEca0hCRlUQGKrYW4odYp7fGiwgQBUlTsEzEStCcodm1J0H1xTFqh+Ox9VTabD+jnG+uRKY0GsNqXwGQx8CENXGqIcCsA5vfsJipQ2X7Flxv1ipAL0mFaSACzlUa1h/wDAJ4T3jOEoaLpkFuYfyQRSBPXGyfLCr2euJmR7+eFxHVJt+lxvbLT00afwRKW+rz7Pv6BybI2WU+EuoNRQjxDvsWabPjKreIcfd+RgzROZ9LJScVRM2OVqzoMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf/ZWO8u4BNCKW8o/OBo/HSLiOuV7pRxJAnFUJMzg/Y=;
 b=MPRATsBr5UfbpsE3Y4/s6miIS32WrHLb29aAq0+naLHtx6Wlw7kmnzX0b+9GTcalvOgOb6jXcNDGpPbI8l8r71kpqX/G3jVC1khGqgnCCvGET47yWo9xHUkWmUzIgv0Qum0wK3C5PVpu7LA3djKHNIbYlUN7fk9GJJs+OSv+7ME=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by BN7PPF02710D35B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Wed, 10 Dec
 2025 00:46:39 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d1) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 00:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 00:46:37 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 18:46:35 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.2.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 9 Dec 2025 18:46:16 -0600
Message-ID: <176532757628.3229411.16186291240831122508@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8860b073-c16c-45a9-f57e-08de378593a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0s2V1k0UEVscW1rMm4vdUw1a1JDZjFZMllVbWR2eGE0VWh1UFZ6azcxR2gx?=
 =?utf-8?B?b1NicDhxK1RnS3JSTEovdDQwMGI0M2FSb2FkdVlZVER6c2JkNVBqRStZSzJN?=
 =?utf-8?B?d01QQ0c2cjZLWURHYmNrWUpNNnZicUFqZUdsUzNxZlNKNk9GTnYrVnlPVFly?=
 =?utf-8?B?a21DQ0RWelQrWnYraVlHK0JBREpmaHhBZHR4NWJEaXg1TWJDM1RrSFA1MG9n?=
 =?utf-8?B?ckRuL0dJTlRtK0pKSE9md0pta3VudVpWN2Y5NjI4cG9aS2ZGVzVjY3ZxY3By?=
 =?utf-8?B?cmlYdWdKR1loNE9LWFc4VzI5RUxveTV4ZlJXTE5PM0JaZnB2akxoVXNMNmlI?=
 =?utf-8?B?ci9kSmU5N2JaeVpSd1dpb2M0eThqc2RXcGRiZWNqWFBXRHplUWw0NlhydmZO?=
 =?utf-8?B?WHBWNWlsYlVSR2FNZ2VnTUVBM2NwZHNwRlNzekp4bVZMc3psL1UxSVBjbmNT?=
 =?utf-8?B?TXBIdjVjL0JieTU2YXNSbU1zQnBpZFZDeGFpL0Rza3N6WGVSd0NqSTdZME1O?=
 =?utf-8?B?ZmYzamJQR21uaklVSHd1U0tHZitOckNLNVpzL0NCVVNqd2VEdzRHeFFHSmQ2?=
 =?utf-8?B?VGpHSHMzWFQ5K2NBaVBVa3c3bTRhajIvbTFQc2F0STJFR1dkY0craFI2VmZm?=
 =?utf-8?B?RHZVcEQ5bGRwTk9lbW51dDZQQkdIRUo1SUpUNmREbmVBU1lXWFkwK0lQaml2?=
 =?utf-8?B?NVdXYWdBM2JpSnRiVTVtdjdMZnZCUHJWTTZsdDJiNktGdGdxdlNQMmVBcTcz?=
 =?utf-8?B?Vlo5b2YrN0dHS3pqUjhOSWRTWUZ4clJMbURSN3YwSkdtdGN2Nk1qUENXRTNR?=
 =?utf-8?B?dHIzd1BwdmZPWHg5Y2p4QlcyTFpZQStMZXpuNFZRa2pVUkhaV3FQMWVqaDNX?=
 =?utf-8?B?U1BpaUdQb2VuVHE0WEUrUTBhMCtWYTU2TzlpbDdmbTdUaTRUV1FVcHI0NXJM?=
 =?utf-8?B?RUNDUDJKQ0FsODBzandJdndWSy9HK0Y5dmx2Yy9KRWUxNG5BcW5hb0s4Unhj?=
 =?utf-8?B?MEZFTWpaaURVTHhhY0E0ejJ3TmdtOW4zdnkyZGpleFphcTFCc1g3ak45OUFR?=
 =?utf-8?B?K3BBYXp1WnZuRCsxSXMzQnVYMmtUUUpNRHV6NjN6Z0ZocWtoVE8yYjQvNjRh?=
 =?utf-8?B?bU55NWVKalY3clh6c3Bmb3FRdWtFZjB2TTRwS21oYXNGQ0ZHWW5QZU0rMGZ0?=
 =?utf-8?B?bnErbWpWaXVSWHBHbFhHT2o1dTJ6WW5IWlZUV0IzTGhvWE40dkxYWHNRVXEz?=
 =?utf-8?B?ZndNK3pCdDJPWjZzUWpCc24xR1U1V2dWU09kNlpNYW9Lb2w3R0crSzNiekY4?=
 =?utf-8?B?Qm1SQUxWb0I5NUd1M2RWT2JObXlzU0RYL2JXWGl3a09KMWZBWlVGcy9DTmJh?=
 =?utf-8?B?VzF6VXphR05KVlFzQXBzSUppemhuallXMzBEeVpPSk9YQ3JFeDhpMms5NnFw?=
 =?utf-8?B?L2t3WVpEaW11ZFpRa2FhbEZWOGJnN2lPNTd0NGw5cTQ3RDZxejJTa2EvR213?=
 =?utf-8?B?OTV3S0gyRlByMEkrWjA1NUgrUFNOait3UnVnR1N3MFcrald5UEVOOHVESWJ1?=
 =?utf-8?B?S1d4eURaeGw1d3ozc3BGYjVCZS9TWG8xT3Y2L1NHZzRRWktCWXZuOG5jcU5s?=
 =?utf-8?B?anF6MEowWDBYZzRFUUhjUWdUOVBCK25DUW80Q0FFQzRGUVAvSjFsbjlLQVM4?=
 =?utf-8?B?VklGVVJSRWorNlN4MnJhRVhJandkOFRsNkxNMG8xRlZ5dHd0ZkIvSk5wejc5?=
 =?utf-8?B?RnM2MHR1akhJeG1jRm16MndyaFJ1Nmtmdk12bjZDam5oVWZTUHovc0dHampW?=
 =?utf-8?B?K3FqcFhkd3plNkxyeGE0RU1pczR1ZXFDWmZqN0dLT056eWpKL3Rod2JWTmVa?=
 =?utf-8?B?ZWpqZnljR1hEcjhZYmtENkNXb0p6S3FPbDFzdTNyWjJoaWdCYkVjak04NHVY?=
 =?utf-8?B?dEhtNi9VdHp5M0xZNWZpV2xrOGFnNGRFR1RMb3ZsZ1BrVUxJM3U5V0RxL2xL?=
 =?utf-8?B?SDhTNmFQQ2FvcFJ2NENma0NmbDNkU01PMzVGakpJcGErd01WNlZmTWlGT0xO?=
 =?utf-8?Q?/mzSke?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 00:46:37.8939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8860b073-c16c-45a9-f57e-08de378593a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B
Received-SPF: permerror client-ip=52.101.48.50;
 envelope-from=Michael.Roth@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
fourth release candidate for the QEMU 10.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.2.0-rc3.tar.xz
  http://download.qemu.org/qemu-10.2.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 10.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/17

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.2

Please add entries to the ChangeLog for the 10.2 release below:

  http://wiki.qemu.org/ChangeLog/10.2

Thank you to everyone involved!

Changes since rc2:

9c23f2a7b0: Update version for v10.2.0-rc3 release (Richard Henderson)
efd6b3d176: Revert "hw/net/virtio-net: make VirtIONet.vlans an array instea=
d of a pointer" (Philippe Mathieu-Daud=C3=A9)
0d42e48c73: Revert "migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE=
 macro" (Philippe Mathieu-Daud=C3=A9)
326e620fc0: Fix const qualifier build errors with recent glibc (C=C3=A9dric=
 Le Goater)
e742b7bdc2: scripts/nsis.py: Tell makensis that WoA is 64 bit (Stefan Weil)
4fdff25625: hw/pci: Fix typo in documentation (Stefan Weil)
0bc6fa2446: migration: Fix order of function arguments (Stefan Weil)
46228925ed: vhost: Always initialize cached vring data (Hanna Czenczek)
8062bfd517: scripts: fix broken error path in modinfo-collect.py (Denis V. =
Lunev)
93332c90bf: hw/9pfs: Correct typo (Alano Song)
df3b304605: osdep: Undefine FSCALE definition to fix Solaris builds (Philip=
pe Mathieu-Daud=C3=A9)
dd77ef99aa: target/arm: handle unaligned PC during tlb probe (Alex Benn=C3=
=A9e)
d100193724: target/arm: make HV_EXIT_REASON_CANCELED leave hvf_arch_vcpu_ex=
ec (Alex Benn=C3=A9e)
2a425aae0b: target/arm: ensure PSCI register updates are flushed (Alex Benn=
=C3=A9e)
c22e943ea1: Revert "target/arm: Re-use arm_is_psci_call() in HVF" (Alex Ben=
n=C3=A9e)
704db3e250: aspeed: Deprecate the fby35 machine (C=C3=A9dric Le Goater)
fa2580f574: contrib/plugins/uftrace_symbols.py: unbreak --no-prefix-symbols=
 (S=C3=B6nke Holz)
81c5a3f867: plugins/core: allow reading of registers during discon events (=
Alex Benn=C3=A9e)
ee6a482e9c: MAINTAINERS: update the custom runner entries (Alex Benn=C3=A9e)
23a5e2584e: docs/devel: Correct typo (Alano Song)
6f365f185a: docs/devel: update build environment setup documentation (Alex =
Benn=C3=A9e)
0b50ff0c0a: tests/docker: drop --disable-[tools|system] from all-test-cross=
 (Alex Benn=C3=A9e)
2addcefd69: tests/docker: transition debian-all-test-cross to lcitool (Alex=
 Benn=C3=A9e)
7cffc86162: tests/lcitool: add bzip2 to the minimal dependency list (Alex B=
enn=C3=A9e)
a55d610bac: tests/qemu-iotests: Check for a functional "secret" object befo=
re using it (Thomas Huth)
7242e51517: tests/tcg: honour the available QEMU binaries when running chec=
k-tcg (Alex Benn=C3=A9e)
7e71b8e7f2: gitlab-ci.d/cirrus: Update the FreeBSD job to v14.3 (Michael To=
karev)
56a4ba5f88: gitlab: drop explicit pxe-test from the build-tci job (Alex Ben=
n=C3=A9e)
ca49625616: gitlab: drop --disable-pie from aarch64-all-linux-static build =
(Alex Benn=C3=A9e)
ff633bc5d5: include/aarch64/host: Fix atomic16_fetch_{and,or} (Richard Hend=
erson)
6833615bfd: include/generic/host: Fix atomic128-cas.h.inc for Int128 struct=
ure (Richard Henderson)
8c00f56fca: tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning (Richard Hende=
rson)
93fa829344: tcg: Remove duplicate test from plugin_gen_mem_callbacks (Richa=
rd Henderson)
92cf74baf4: tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr (Richard Hende=
rson)
41706d3e72: tcg: Zero extend 32-bit addresses for TCI (Richard Henderson)
2c3165a1a6: file-posix: Handle suspended dm-multipath better for SG_IO (Kev=
in Wolf)
23c586abf2: vfio-user: recycle msg on failure (John Levon)
0df8baec95: vfio-user: simplify vfio_user_recv_one() (John Levon)
7b884e2a27: vfio-user: refactor out header handling (John Levon)
356c7b1752: vfio-user: clarify partial message handling (John Levon)
a8731f691d: vfio-user: simplify vfio_user_process() (John Levon)
1f3b34e403: docs/interop/vfio-user: update protocol specification (John Lev=
on)

