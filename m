Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38711E69EBD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 22:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIb5d-0001WF-L7; Tue, 03 Dec 2024 17:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tIb5b-0001Vr-Tf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 17:09:51 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com
 ([40.107.92.44] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tIb5Z-00015P-1u
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 17:09:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPIS5M4QPo5ckSob9C3bS0EeKUJHfRHQ2YUFBlT9ibahLj/oeYyvelcUc+LD1GolSqFaMXK1Ea0hX0dcJePXZ18RcrY5v2Z526MqcdoXfHCULLbp/eLWIYo8wzfrF67YbD7l9ohUf8v2imy9fRL6wgVSQU2BzRzzF6g8peshkpY8Wx+S99Ax2nmqL2/ajxHxnCvNJWMM+/SXnB6zbrQHfuNmpRvhESVdH9Xfw/bsxlCN4fw8YGzkHo9/sdwML5fUtLtZPpauoWQlgmz5vP5WXt82d9Cs08bq3lTDHUY7s/x2hy+l9o1kr1SWLHWZqMGlA2m+G/kjoim+b6yZ1Jt48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFFmBkQHM5vYjJm3tv9X+a34ohEdTRBqROtz/k6HULA=;
 b=ds0Fbis7EqStlxUAWOr10W3+PiJMhIgPpV+SUy2Av/Z0OobSQFRxPd0sR1etBjtY8PLCVTGe7d69dgWZFgE5i7M7NTeZkKp3uUj4OVN7yF+/efFa5Z/gjX2Dpsn76tQB9H1miVKWF7Bq2oQt00sxAdTAtrCgt3GkNyU22K9EENWMcx9BgAWN+ZH/2ex7WDIT5ptUApPBOqJh3Ac/U+eOiqGC9fEAsXtqNMbfGeWB9Vy/DAoT4pLfUIeck1lswJY0CnKYnkPJGyA5O7P7nlg2KA2XlFxe5AgMzpJgpUsMDzivWcbc1dG1SuI0ZQLo6lZH7LEFgQYgzdnfCiu/9T6Owg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFFmBkQHM5vYjJm3tv9X+a34ohEdTRBqROtz/k6HULA=;
 b=fXf3/nptv6mfMxDCdD9V5PBmghcY49EI4aZIeLScZrNrJEJGoA1ikEIJo/GtInky3CaLktaK3YBIwYkU/NJ+kd5FUJzGTSBwIsMlnMXc1E9i/cgcINMntesPsKwhwJYF0NumllZJJGLQcdLGQrvIZvJ6pPMfCTKlzMX+85pSeGY=
Received: from BN1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:408:e2::9)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 22:04:39 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::fc) by BN1PR13CA0004.outlook.office365.com
 (2603:10b6:408:e2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 22:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:04:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 16:04:37 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.2.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 16:04:21 -0600
Message-ID: <173326346108.244154.2360532856451368091@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e9947d-0d80-4e82-61f4-08dd13e67b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0VXMW1TNWgxN01iTDlENFEzSXZDV0tCYm5hMTU5WkRSOWVEUkYwYzVxRzF0?=
 =?utf-8?B?RUc4d3NraVFaNmRIVVo5UkpyU1VKNFJyTUxlUkJZcHc3YXlQMXpnKzJoaXFQ?=
 =?utf-8?B?c1BvZG0vSHRrSnFRRy96Ym55dkt0RzVDNEhCZDBhRFV5NVlnNWpqWGlmbGF3?=
 =?utf-8?B?WGZDYUZQTUJQclhpYUpQamtnTEM3bHBoNUxnV1M0Q0VWYWJZY0pTeFdIQUhD?=
 =?utf-8?B?eXRxNnJkeEo2UnduWnE4WFVXTTFrTlRKdW1aaHF5VFAzcFY0RXk1dmdCV0Nr?=
 =?utf-8?B?QjRreHRndEtyMWNqaDJ4aTJkVG85MWdvZjZoa010TUtzQ2h1SjRrU1Y5RVhM?=
 =?utf-8?B?OHllMXRsN0ZSSkpLcElLSUZ0YjdSVjYvaTVyc0NmdTJxenJxV213MXd6cnI2?=
 =?utf-8?B?Yk5SSnlxeWFFY3pMTFZtY0tVdTVzNlAxS1pWeGgrbEQwYkpjY01kR3NSajNJ?=
 =?utf-8?B?MzNVQko0eloreEUxUHMrM2lLa0hFMDNybmlwYXNoRkI5a0NmMGlUandTenFl?=
 =?utf-8?B?a1l4YjJzY0lNNDRmWlRJUVFMWWlXdmpPcm5MQ0ZEWHR4Q1hhWFVoUVZLb0NW?=
 =?utf-8?B?NnhycERhRElFbUNkMEp2MDJ5d1puVDJZZEtrV285YWdDdWR4cU0rSnhSU1Nt?=
 =?utf-8?B?SWRibzRKRVhMbzcycDM1R3VabWl6OFIxL2RTS1BNZDNRQlcrbFo4M1pzTE1T?=
 =?utf-8?B?VU5pWDNsQ1BnZEFtUmowTHRLSzExUTVzN2pjMHhXV01BdlBRK3ZRc0YyYTcw?=
 =?utf-8?B?NUx5eEgzR2lSYzlKY0JFd1NheEFyOENpQnVWd25oTXJWOFlGYlZmRGZWQytL?=
 =?utf-8?B?elh1S2hUQi9pVUZ2TzVCTEtOczlNMkxlaWFsNU1XSmtYN1poOXdYa3Ftejkz?=
 =?utf-8?B?WHNrWmpFRlNvNXMyTWNFNUJDbE9acU0wNERJeHEyM3RNT2JNSDNpVDhVUEpS?=
 =?utf-8?B?YkxRWHpWQ2h4M0FPQW9wNWI1UTBjd3dsaS94VzMwK09VNWJ3SXUrY051WW5t?=
 =?utf-8?B?RGVTY0FiRHJ3SWZJTko2akQ0U3RUVzdJWUpXekJUSUlDaXFka2U0V3VBcndG?=
 =?utf-8?B?VmQ4TE90RlI3eWlQWEszdThaWHNnaWUweXBKdjdrQkFTK1NGbGdsOVhsTkxU?=
 =?utf-8?B?WktEdzVQVE1wajYxRDk4K00xeVJ4WHNxOFY0SmNncXdibUhvU1J4OEFYM0hX?=
 =?utf-8?B?WWQyLy9nR3E5V3hFWVhIcXE0NWpsSjJxTTBrOFNQRXE1R1lwZk1XSGhTL0RM?=
 =?utf-8?B?Q1VCSGZVMndiNGo5Y0hZUHhISzNEVnpnbC9wV0hUT2I0OFQ0d3dwUm1MTlR3?=
 =?utf-8?B?TE1TZVkwdzJsVXhLRjBtK2lGeEEzZ2k1eGhYN28xeXNPdnFPeHBMdGg3U2FC?=
 =?utf-8?B?R3dvMjdjWVdxUnJyd1VJVUJ0NisvcjQvNmtJSUo5REczSmEySE5MbUx3U3ZN?=
 =?utf-8?B?Y05LTDloa2E3dDI2R1ZRVnpyakwxT1VqK2xubXlOZDBWeHUwZzd2MEpEeFdm?=
 =?utf-8?B?d2VBRWQ1d3ByR0xYUVllU0hIVy9RUS9PVWNqZWZMYXV6OEpQV09Va0JQTjBv?=
 =?utf-8?B?emt3NnQvanRvbDllSFBSbk5lSzZUMWNqZ0w1V3RFY0huUDFXcHdNWXhsWVpE?=
 =?utf-8?B?Nnd0RHdxdlNWU0s3RDZrS05zeWdXNGRIajgzZDdjR3RTU3F1UlJnU1lXc1Ft?=
 =?utf-8?B?NHR1OGk4WDNJUDdWaVlDbnZlN2pJTXB3ZGhZTi9rYm1DNVIxck44OFRVcTZ3?=
 =?utf-8?B?TUpBN1ljbHBMc0ZaNk9EZllCWGpuRzVDVGtoblJ0RHZwS3JQcndrNW9ITnhI?=
 =?utf-8?B?V0QzKytBRWpmUWpBTis3c3A3bGdQKzB5WDRhcE5xNjNKQjZNc0tuck5XVVU0?=
 =?utf-8?B?b0thNWU5OUI5ZlhjZlFGNEdtaTNCV0NoWlJpL2Y1RXh0Q0E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:04:38.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e9947d-0d80-4e82-61f4-08dd13e67b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
Received-SPF: permerror client-ip=40.107.92.44;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
fourth release candidate for the QEMU 9.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.2.0-rc3.tar.xz
  http://download.qemu.org/qemu-9.2.0-rc3.tar.xz.sig

A note from the maintainer:

  Hopefully rc3 will be the last release candidate before we release
  QEMU 9.2. If all goes well, we will make the release next week on
  the 10th of December. If we need to fix any last release-critical
  bugs, we'll make an rc4 on the 10th and the final release the week
  after that.

You can help improve the quality of the QEMU 9.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/14

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.2

Please add entries to the ChangeLog for the 9.2 release below:

  http://wiki.qemu.org/ChangeLog/9.2

Thank you to everyone involved!

Changes since rc2:

1cf9bc6eba: Update version for v9.2.0-rc3 release (Peter Maydell)
3c8ab23fb3: chardev: Remove __-prefixed names (Nicholas Piggin)
651b386205: chardev: Fix record/replay error path NULL deref in device crea=
tion (Nicholas Piggin)
964d2a0cf8: system: Select HVF by default when no other accelerator is avai=
lable (Philippe Mathieu-Daud=C3=A9)
d65c890a58: tests/qtest: add test for querying balloon guest stats (Daniel =
P. Berrang=C3=A9)
8460459529: tests/qtest: drop 'fuzz-' prefix from virtio-balloon test (Dani=
el P. Berrang=C3=A9)
bff1050a56: hw/virtio: fix crash in processing balloon stats (Daniel P. Ber=
rang=C3=A9)
302075f85e: hw/display/vga: Do not reset 'big_endian_fb' in vga_common_rese=
t() (Philippe Mathieu-Daud=C3=A9)
5311599cdc: target/riscv: Avoid bad shift in riscv_cpu_do_interrupt() (Pete=
r Maydell)
235560b3a7: hw/core/machine: diagnose wrapping of maxmem (Daniel P. Berrang=
=C3=A9)
2dfe93699c: MAINTAINERS: update email addr for Brian Cain (Brian Cain)
5162557574: meson: Add missing SDL dependency to system/main.c (Philippe Ma=
thieu-Daud=C3=A9)
9c3934b33c: MAINTAINERS: add myself as the maintainer for LoongArch VirtMac=
hine (Bibo Mao)
9cf6e41fe2: ui/cocoa: Temporarily ignore annoying deprecated declaration wa=
rnings (Philippe Mathieu-Daud=C3=A9)
5d8a250f90: hw/openrisc/openrisc_sim: keep serial@90000000 as default (Ahma=
d Fatoum)
79b38d61b5: hw/openrisc: Fixed undercounting of TTCR in continuous mode (Jo=
el Holdsworth)
3eb43aeb16: hw/openrisc: Fixed undercounting of TTCR in continuous mode (Jo=
el Holdsworth)
26dcf2be7e: hw/openrisc/openrisc_sim: keep serial@90000000 as default (Ahma=
d Fatoum)
6651f8f2e5: hw/nvme: take a reference on the subsystem on vf realization (K=
laus Jensen)
e85987786d: hw/nvme: SR-IOV VFs must hardwire pci interrupt pin register to=
 zero (Klaus Jensen)
149f6e90b5: hw/nvme: fix use/unuse of msix vectors (Klaus Jensen)
9162f10125: hw/nvme: fix msix_uninit with exclusive bar (Klaus Jensen)
3b83e66361: migration: correct multifd receive thread name (Prasad Pandit)
92ee59bf56: tests/functional: increase timeouts for arm sx1 test (Daniel P.=
 Berrang=C3=A9)
c78ba4341c: tests/functional/test_virtio_version: Check for the availabilit=
y of the machine (Thomas Huth)
fe455260b0: tests/functional/test_acpi_bits: Turn the test into a QemuSyste=
mTest (Thomas Huth)
e6214fd6d4: chardev/char-mux: make boolean bit check instead of find_next_b=
it() (Roman Penyaev)
188df56eab: chardev/char-mux: shift unsigned long to avoid 32-bit overflow =
(Roman Penyaev)
eaab44ccc5: tests/9p: also check 'Tgetattr' in 'use-after-unlink' test (Chr=
istian Schoenebeck)
c81e7219e0: 9pfs: fix 'Tgetattr' after unlink (Christian Schoenebeck)
3bc4db4443: 9pfs: remove obsolete comment in v9fs_getattr() (Christian Scho=
enebeck)
4ec9849650: tests/9p: add missing Rgetattr response name (Christian Schoene=
beck)
abf0f092c1: tests/9p: fix Rreaddir response name (Christian Schoenebeck)
462db8fb1d: tests/9p: add 'use-after-unlink' test (Christian Schoenebeck)
f2db23ede5: 9pfs: cleanup V9fsFidState (Christian Schoenebeck)
3abb67323a: scsi: megasas: Internal cdbs have 16-byte length (Guenter Roeck)
654076bc20: hvf: complete 1G page support (Alexander Graf)
0266aef8cd: amd_iommu: Fix kvm_enable_x2apic link error with clang in non-K=
VM builds (Sairaj Kodilkar)
ef45f46f38: hw/pci: Remove unused pci_irq_pulse() method (Philippe Mathieu-=
Daud=C3=A9)
c00989aae8: tests/functional: Remove sleep workarounds from sh4 test (C=C3=
=A9dric Le Goater)
0218f6c3b3: .gitlab-ci.d/cirrus: Remove the wrong CPU and RAM settings from=
 the macOS job (Thomas Huth)
4e035201b9: meson.build: Refuse XCode versions < v15.0 (Thomas Huth)
8046759201: tests/functional: Fix the running test case causes loongarch64 =
to hang (Xianglai Li)
16595bcd0e: docs: Document that hvf on Arm is supported (Akihiko Odaki)
4a722d2e8e: docs/devel/testing/functional: Clarify that we have to use the =
build folder (Thomas Huth)
571bdc97b8: vhost: fail device start if iotlb update fails (Prasad Pandit)
5d52529462: bios-tables-test: Add data for complex numa test (GI, GP etc) (=
Jonathan Cameron)
18afed7402: bios-tables-test: Add complex SRAT / HMAT test for GI GP (Jonat=
han Cameron)
2cb740932c: bios-tables-test: Allow for new acpihmat-generic-x test data. (=
Jonathan Cameron)
37a14f24b4: qapi/qom: Change Since entry for AcpiGenericPortProperties to 9=
.2 (Jonathan Cameron)
13a4a6ba2b: hw/acpi: Fix size of HID in build_append_srat_acpi_device_handl=
e() (Jonathan Cameron)
e069c115e0: qapi: fix device-sync-config since-version (Vladimir Sementsov-=
Ogievskiy)
c5e36a5a6a: hw/cxl: Check for zero length features in cmd_features_set_feat=
ure() (Jonathan Cameron)
e50a24ead1: tests/acpi: update expected blobs (Igor Mammedov)
f2ba6ab621: Revert "hw/acpi: Make CPUs ACPI `presence` conditional during v=
CPU hot-unplug" (Igor Mammedov)
cb36e2573a: Revert "hw/acpi: Update ACPI `_STA` method with QOM vCPU ACPI H=
otplug states" (Igor Mammedov)
ef5e7aeaa6: qtest: allow ACPI DSDT Table changes (Salil Mehta)
16f6804c46: vhost_net: fix assertion triggered by batch of host notifiers p=
rocessing (zuoboqun)

