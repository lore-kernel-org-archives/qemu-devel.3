Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3E6C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDQZ-00017S-T0; Wed, 30 Jul 2025 16:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1uhC7A-0006eS-Pb
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 15:05:28 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com
 ([40.107.243.55] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1uhC77-00069H-08
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 15:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi6T0uDrqOK9v4Hz3CtpkWhk7F8o1alKMwy27aZUtJUZ3PJaJ9cEmdqRTboWXX7QE807VNVKxBBW98iVaV3PbpsSR8ioSU3ct5G9XQLg59DgV/fuXDslwfKXmFduo95LjxdupX/ZL0E6qp66mcRaPSSU3eQpf3M7NSmAAV8VtocbxeusctVGF38GwoW52JnWmdfb9b+yWe/uwH+cVa+nBQo3te8LbEAn5v6uyTiNSKiRVxBzsLj6wtJnOo3pZYR3z7OuDVkkKOU9oXxHRD9LplHItpCEvEOfQJYbtr1ELQEOvO9oYhwNmk3VtgmodkX6cPJ5EqLUpklInHwipBWMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT5JNxUHFvhL56K9XGQ1AhQ8F5bMa6PFC7rDgOcLm68=;
 b=ZDNXLIO388Z+Z++1R795Q+fGEeeRWa4C3ThLPyGhLZ/Aox2xNV0QFhLCcVUH6QsMaSkGEooj+BFnDus6X+5wa+91/48nWg20ay+4cCjSIb2H4s9Q0VotApHSjNmKI1ArpFbpLlPKFb4HacjZCW1BN8iiFWI1QvbwbZerWybYez9hlf/mDAuP+h2REPCm/htvVNfyaJ/mZI+OC628GGPdPYDCey3VGpHpAzIlwH6wtu4RXnuOEjS+V64tbJ1JluE+r0jN8uYYRUXJbkqLg+7OGjOjywNBqwHriGk3WMOtqyC3skw/Pz+4m0WEp9bKUNDBYshwewF9+cT8DqGU4LQCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT5JNxUHFvhL56K9XGQ1AhQ8F5bMa6PFC7rDgOcLm68=;
 b=dawb59xpE4EVC8W5Ti+hKEdKykmWf76p8G6Coh4oB6yUk5DRw9CD2Ja9Dlblk+tas6jFHf23pPElovz08vASgzDZl2ynmcXr1/n/zbnroYiRc6SGYs0UoQ9SpsPt+1PFCrIWsq5i0ysefE/YYYlBMIe+Laa78rHochW6ck5Z6NI=
Received: from BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:00:09 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::b0) by BL1PR13CA0407.outlook.office365.com
 (2603:10b6:208:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 19:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:00:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:03 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.1.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 30 Jul 2025 13:57:56 -0500
Message-ID: <175390187633.2965447.16551760674905835506@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 700392a8-d594-494c-25aa-08ddcf9b4dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d21NUjZqK3IrMmhyVWNweDdRYVNHMExCZDM5Rk1nVWJuL0FTNlRlN1lRRjBY?=
 =?utf-8?B?ckphbUZ0emhYZ0MzdTBPeUpJRHplZUIxeU04eEtuTVJRdXJaT0JjMDhMcWcy?=
 =?utf-8?B?UEJGSEdIQndBUWhzYzdJQWJrR28vNnIrUTlZdEx6NlA5TXUzVXhpM0k5cTg2?=
 =?utf-8?B?TzhaVDZxbzUvbjlKUHgwRzNlalVpUTJiejM5MnNuNkQ5c0dvMVJBU0RoMHFv?=
 =?utf-8?B?UnNPeURoTFVRMXJOR1IvSmVTd00zQlJlTWt6ZENYd0poaGxmOVZobjNnQWxu?=
 =?utf-8?B?QXRpYytncUE5NWdqbTlVMUxPZk1nckpBbFA4MHdUL3lESENKaGRUOUlOLzZ6?=
 =?utf-8?B?bFdZY21CZGxYTVBCR3hhK2JSdll5dGtTTHNhQURDZFEwZ3hveUFFWlBja0VS?=
 =?utf-8?B?NUtvUW9reXVHeE84MlRja1YvOHhrMlMxdEpsR1FhMVJQdWNoTWdWWjJzeUdw?=
 =?utf-8?B?VDJ6SVVkeGE3b3JpMUlEWkxWeUFRTkF6OFVVbnZpVktKdnk0QnFDU0lUSUc2?=
 =?utf-8?B?Q1VxWXQ1RytXQVNrcVYvTDU2VFdBSzdZV2ZEVHU1QXBmQTVGcmdKL0R2Wm5l?=
 =?utf-8?B?dmYvOFV2Y0tDdEhSZXl2UG5WVWdDTVVvUG8wQjU3NGk5NW1NWE9RQll0ZTMx?=
 =?utf-8?B?V0xKSkhtSkY3Wk4zeDFaeXh1OE1Ea3BoK0lEaTY2dWhRMzd0VnZaMEdkZDJY?=
 =?utf-8?B?OTBUYnQ3anBlcVVraE5QSi9PQ2JjR2EyUmo1YWIxaVZBVStvaVlHZXlnVHhl?=
 =?utf-8?B?T2hVSVRhRGt3MXdmT1VTTVV3VWl1UWd4TG02UnBIMVlKWFRncTB2VTIzNElI?=
 =?utf-8?B?U0NRdis1SUhMRWpBMG9URTM3MjFsd1Ezb1VibGlrT1AzVG5UOTVUZXlLeHA0?=
 =?utf-8?B?cnBRemZJMDQ2Y3Z0MVJ6K2VLL3lDZzQ1Q0JHb2ZuVkg5bVE1OEcvaFdIakgx?=
 =?utf-8?B?WEhIdU1wUlkrMkRzWWxONC9nMVgwdXdWbWI2M3hYdmZwZHNhL3B2ak1Eanpw?=
 =?utf-8?B?QnR2S0RHVVpOWmY3YmdoUXJ3UnZ2NUpqWitTLzJBbWtSZUNLOUJsclRpQkRQ?=
 =?utf-8?B?a0NtWlV4TENUc2RMdlM1TjE5WUpmNWdVYTFoYVp2RDFRaEtaRTRVWXRBOVRZ?=
 =?utf-8?B?cGlENTZaeUdlLy9XTkJ4VGk4eWRhUTB0dzIwVlp0V3JTL3lDL2lMUVBnY0dz?=
 =?utf-8?B?VWhFUktEV2xnUTN4WFd6RGZSZ3VkY1lPbzNIOWhTRTRickMyVDdqZ2J1MEFu?=
 =?utf-8?B?VHBYbEdtVkluc0RzS0tycUVCYjFadE4rQjlMZXRaUHBTRVRjR3BSMEhDdUZ4?=
 =?utf-8?B?Z0VhK096YnFVdEdVaDNuSStqR1d0dTNWbmZLb0pWL2lObXEvUDRoT3dGamJu?=
 =?utf-8?B?WUNIb1hjaU5lVENTOUM0cWVPczBmY2tUREsxdzhJakUveEpuYmtDQlB0TjZt?=
 =?utf-8?B?V0Z2eVUrSTZLWTh5MlVycWVMWjV4cnVxRDc4MUl5SFZtd0VYOFMyampMTlNO?=
 =?utf-8?B?cVpQazAwZVV2eWNOVFFoTU03dmZKR2RXd2hSdDRGWWE0eDFZbU92STVjWkVR?=
 =?utf-8?B?UGxGZ015UXBCZ2JrQjFCWEFlVWFtUmZTaStQNkxjUXFCVHltcHI3UmthOHEx?=
 =?utf-8?B?YzMwMndHYWo4eDluVTY4RGMzd3l4VzJleUF0NGVFWUQva21QbjlaQmgvQllF?=
 =?utf-8?B?dEEzbk1JZG9vNURGM1VvZ1lsUHpWdEd6cHJDaWRHeEV5bjVuTWxrN1ZjdDVB?=
 =?utf-8?B?bFoyY2wxR2lkbWY1YmN1L2xSa21RaGJmdEZvOXZOeGpIRHlRN2l1UzhHdExZ?=
 =?utf-8?B?UGJhdGRhWjZvNjJrOXYyNm51cVhhWE85dU9BcFhtTXZDS3NkWFlIYVlocllT?=
 =?utf-8?B?OXNZdTVWT1hjMERJeWZvNU9EUnlIWHZBdEkzMzBSMVVoalQ4ZWZpR05XRGRx?=
 =?utf-8?B?U0xBeTgyS2dqQyt6TTVTbEMwQU5sMzNQRFkyMDY2MkZ1ejZGL2pIREFJQUVv?=
 =?utf-8?B?a1lNRXVieE1nPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:00:08.8469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700392a8-d594-494c-25aa-08ddcf9b4dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
Received-SPF: permerror client-ip=40.107.243.55;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
second release candidate for the QEMU 10.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.1.0-rc1.tar.xz
  http://download.qemu.org/qemu-10.1.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 10.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/16

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.1

Please add entries to the ChangeLog for the 10.1 release below:

  http://wiki.qemu.org/ChangeLog/10.1

Thank you to everyone involved!

Changes since rc0:

9b80226ece: Update version for the v10.1.0-rc1 release (Stefan Hajnoczi)
a95b3c0ad8: MAINTAINERS: Cover docs/devel/qapi-domain.rst properly (Markus =
Armbruster)
a14f6d3288: docs/qapi-domain: Fix typos (Markus Armbruster)
1047cc2816: tests/qapi-schema: Bury dead test case doc-non-first-section (M=
arkus Armbruster)
a3004697f7: qapi/accelerator: Fix markup of heading (Markus Armbruster)
d4d91ed42e: qapi: Add more cross-references (Markus Armbruster)
67e4808403: hw/display/sm501: fix missing error-report.h (Cl=C3=A9ment Chig=
ot)
653a75a9d7: roms/Makefile: fix npcmNxx_bootrom build rules (Michael Tokarev)
2865bf1c57: system/physmem: fix use-after-free with dispatch (Pierrick Bouv=
ier)
014bb30d21: hw/xen/passthrough: add missing error-report include (Adam Will=
iamson)
2bfcd27e00: hw/net/cadence_gem: fix register mask initialization (Luc Miche=
l)
b496a392fe: migration: rename target.c to vfio.c (Pierrick Bouvier)
962316a6a3: hw/vfio/vfio-migration: Remove unnecessary 'qemu/typedefs.h' in=
clude (Philippe Mathieu-Daud=C3=A9)
8e8cb3b572: hw/display/qxl-render: fix qxl_unpack_chunks() chunk size calcu=
lation (Michael Tokarev)
e895095c78: target/mips: Only update MVPControl.EVP bit if executed by mast=
er VPE (Philippe Mathieu-Daud=C3=A9)
0db7e4cb62: vfio/igd: Fix VGA regions are not exposed in legacy mode (Tomit=
a Moeko)
e0b33efe2a: vfio/igd: Require host VGA decode for legacy mode (Tomita Moeko)
9751377c3a: vfio: fix sub-page bar after cpr (Steve Sistare)
1dc1220fbd: i386: Build SEV only for 64-bit target (C=C3=A9dric Le Goater)
1ebdd2d926: hw/i386: Fix 'use-legacy-x86-rom' property compatibility (C=C3=
=A9dric Le Goater)
62e1fa22f5: qga: Add cross-references (Markus Armbruster)
ef7e21964d: qga: Rephrase return docs to avoid type name (Markus Armbruster)
d27340ff8a: qga: Remove trivial "Returns:" sections (Markus Armbruster)
bb743978f0: qga: Fix guest-network-get-route return value documentation (Ma=
rkus Armbruster)
cac08383f0: tests/functional: expose sys.argv to unittest.main (Alex Benn=
=C3=A9e)
6da616bb17: tests/docker: handle host-arch selection for all-test-cross (Al=
ex Benn=C3=A9e)
408c862910: tests/docker: add --arch-only to qemu deps for all-test-cross (=
Alex Benn=C3=A9e)
25aaf0cb7f: tests/tcg: reduce the number of plugin tests combinations (Alex=
 Benn=C3=A9e)
d0aa5df775: configure: expose PYTHON to test/tcg/config-host.mak (Alex Benn=
=C3=A9e)
ab8bf8f6e4: tests/tcg: don't include multiarch tests if not supported (Alex=
 Benn=C3=A9e)
a80e2c26f1: tests/tcg: remove ADDITIONAL_PLUGINS_TESTS (Alex Benn=C3=A9e)
78029e9283: tests/tcg: skip libsyscall.so on softmmu tests (Alex Benn=C3=A9=
e)
ebbc04adbb: tests/functional: add hypervisor test for aarch64 (Alex Benn=C3=
=A9e)
f1f25eed03: docs/user: expand section on threading (Alex Benn=C3=A9e)
bd0eb9b0cd: docs/user: slightly reword section on system calls (Alex Benn=
=C3=A9e)
1ab41da6bb: docs/user: clean up headings (Alex Benn=C3=A9e)
9b6656668f: docs/system: reword the TAP notes to remove tarball ref (Alex B=
enn=C3=A9e)
8d6c7de1cc: docs/user: clarify user-mode expects the same OS (Alex Benn=C3=
=A9e)
e35215db40: linux-user/aarch64: Support ZT_MAGIC signal frame record (Peter=
 Maydell)
99870aff90: linux-user/aarch64: Support TPIDR2_MAGIC signal frame record (P=
eter Maydell)
3cdd990aa9: linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals (P=
eter Maydell)
feea87cd6b: target/i386: fix width of third operand of VINSERTx128 (Paolo B=
onzini)
fbc8fb36e3: scripts: add script to help distros use global Rust packages (P=
aolo Bonzini)
a7aa2af13e: target/arm: hvf: stubbing reads to LORC_EL1 (Mohamed Mediouni)
bd52d8bc9e: hw/arm/smmu-common: Avoid using inlined functions with external=
 linkage (JianChunfu)
7428c46c06: target/arm: Fix LD1W, LD1D to 128-bit elements (Peter Maydell)
4726be1c69: target/arm: Pass correct esize to sve_st1_z() for LD1Q, ST1Q (P=
eter Maydell)
1c6aae5efb: target/arm: LD1Q, ST1Q are vector + scalar, not scalar + vector=
 (Peter Maydell)
b79f944e09: decodetree: Infer argument set before inferring format (Richard=
 Henderson)
aba39946ba: target/arm: Pack mtedesc into upper 32 bits of descriptor (Rich=
ard Henderson)
0e171b427b: target/arm: Expand the descriptor for SME/SVE memory ops to i64=
 (Richard Henderson)
b8882becd5: hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk size cal=
culation (Michael Tokarev)
012842c075: log: make '-msg timestamp=3Don' apply to all qemu_log usage (Da=
niel P. Berrang=C3=A9)
0fb961e392: MAINTAINERS: remove myself as ppc maintainer/reviewer (Daniel H=
enrique Barboza)
cf8f0f006d: MAINTAINERS: Remove Fr=C3=A9d=C3=A9ric as reviewer (C=C3=A9dric=
 Le Goater)
076b4306f9: MAINTAINERS: Add myself as a reviewer for XIVE (Gautam Menghani)
01286ee41e: MAINTAINERS: Add myself as a reviewer of PowerNV emulation (Adi=
tya Gupta)
884216cf41: MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs (Chinm=
ay Rath)
1da3e7f863: MAINTAINERS: Adding myself as reviewer for PPC KVM cpus. (Harsh=
 Prateek Bora)
c4103b2797: MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr (Ha=
rsh Prateek Bora)
0db6f79802: crypto: add tracing & warning about GNUTLS countermeasures (Dan=
iel P. Berrang=C3=A9)
eb3618e9e2: migration: activate TLS thread safety workaround (Daniel P. Ber=
rang=C3=A9)
edea818371: io: add support for activating TLS thread safety workaround (Da=
niel P. Berrang=C3=A9)
24ad5e1995: crypto: implement workaround for GNUTLS thread safety problems =
(Daniel P. Berrang=C3=A9)
eaec556bc8: migration: show error message when postcopy fails (Daniel P. Be=
rrang=C3=A9)
fd1514cbd9: migration: HMP: Fix postcopy latency distribution label (Fabian=
o Rosas)
2251f9ac92: migration: HMP: Fix possible out-of-bounds access (Fabiano Rosa=
s)
f63000d943: rust/pl011: merge device_class.rs into device.rs (Manos Pitsidi=
anakis)
0d70c5aa1b: rust: devices are not staticlibs (Paolo Bonzini)

