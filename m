Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7972CD743CA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEBES-0001ra-8u; Thu, 21 Nov 2024 12:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tEBEO-0001r2-O5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:44:40 -0500
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com
 ([40.107.244.54] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tEBEA-00011x-Oh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:44:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPKSTK5c+SQABD6O2k3g9+y0t39KT8aWkPCS7hLPBvjzfQv6dRLxRQAa4o/P8F2fSzM+jGzkrcZnHASPpf+z6+XwR1pjuFgvPAi4MiK9uYFM9c8twmRDqwj+tBLy+nyCFcJJfOEjwUysVyGlr4esI3ba98p/8/8lzklQBCYvTJKXSnVdG49iFx8WGi6Jmb/yRhxcRweH3ZqtFt5gGcHhnm4MuoFKVnXHcOl37bfBJQi+J+QXwpk2YJZEZWyoLBrB3kpr7BASpCSXEhMBapKc5gnvfA5wsbXMSehO4OjLjKAwKXOz+p+bL9GrSVGV7DZL9QA+0olOSa+aQZNeG/2P0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZgxVGoXtZPv5b6Zlk5meSLVv/fIpvsQ6xvnNwMYazk=;
 b=q81jDELjJN0oL/rvJb8GLhZgr7P5g/MwGjau8tUzejZU6/CQZQXe5zaBHxxvWZxbRpiRPYUUW8e8hy69g1nxUgRjnzBPTQ78ND3HTyewHOVtt4CABmuOULMZa7qYQKaMOFon1aKov0SF/d2+x0JrYY19P+V7/O2OpcYRNkXJDGfeRD+ykTFCYEjA9FguldlVqwTohhIZOZJzHomUUqeiIXQTgd5rxbSeg+yXqfegBYAjJLU07/T7DtX9zEh6DA2LMEiuR/oRKERJW7Yq+XSlONzRzh9iwWZg+Z7B+Gz1MHFaw9E1FunIAWyORdIbXQpsf7MIMF+T2DdXrmU/KEV+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZgxVGoXtZPv5b6Zlk5meSLVv/fIpvsQ6xvnNwMYazk=;
 b=s+YAmqP2XtNx2/1VNqR309lBISDBFLujS6zd56NI4Znm/jS8hp1ghyXBzj2XfxNNZ3du7gy0cO2ckchD291NEpPmv7pt2L8R+RMr3R338M0gNBg8O5KolFJO77ioBDYD/Dd6ItqOaD3gbV93ByVyS62b4qO9H211sCSXKaxZfLU=
Received: from BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 17:39:07 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::23) by BN9PR03CA0756.outlook.office365.com
 (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend Transport; Thu,
 21 Nov 2024 17:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Thu, 21 Nov 2024 17:39:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 11:39:00 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.2.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2024 11:38:44 -0600
Message-ID: <173221072425.3754609.10253570250079643035@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: d439307a-dd6b-4be1-7ad7-08dd0a5363c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTB1VjQxLzdDNE84cmRaR3VETjNWUi9UeThyZnFLc2E3d2Zwb08ySEVKcmQz?=
 =?utf-8?B?b3g1WnNVS2J6d1Z2QlJHWWRMa1ZJZ0lrV3M1SkhSQ0lOeG40U3puamJialpT?=
 =?utf-8?B?Umh5YWFsUWs4WVYycytxN1lmZUh1K0hDMkdJRys0a0gzYjhNUzZXcFFMRlFW?=
 =?utf-8?B?VStCSW9CbVF5WmNNRkd2NGphbkczOFBCL3FpMlFrY0ljU3o5VlVvL24yT2tN?=
 =?utf-8?B?OHN3anI5MURDUkt2SVhzcERPNHRxK3ZKU3JtaVZ2Z0wrcERyQk9laURDVHIy?=
 =?utf-8?B?K2lnOGdnRWZGNGlvSXU5eEtqamtZZkJZbE1DZDhpU1BCUnVGWXMySkxjMVoy?=
 =?utf-8?B?dmxYc0dQWnpkSjk2WS9maEFXVFZtcEhMYUNxdjdJcUZlSVA1d0FOUGovTDlU?=
 =?utf-8?B?Wmp1VnM0a3N1bUc3blYydHd0T1k1V3ZrZjJOOEZSUy9qTHEyZzIraExGWXU2?=
 =?utf-8?B?VStOdElpM3ZNS2wrM1RlU1BteTc1Wnd0TFY3cGVBRjhjdTRvWU04L0FFa29V?=
 =?utf-8?B?bjFrWkxqUzAwTkM4dE81QUIvNWVuOWI1NzdOZGhNYzBIdlkyU2w3ZGh5Wmw4?=
 =?utf-8?B?eGh5WTFqWFR3cHEvMDBKVFZiYlNqSUU0Qk1abkhLZ1VIbnJLS2luTE5hcVBp?=
 =?utf-8?B?YWxlUHVZMXZYWTlycURGU1hvRExpZU1GQi9rUzVVamI2Z2ZFcGM0MEs5bGF0?=
 =?utf-8?B?SUtyM0doWjJraHE3bU9JVnUyb2Vzdm1Qa3U2Y0lHT3NhNjM5TzJxMzJLQ01o?=
 =?utf-8?B?VnhubVRyZVNoUzNCVzJqTFRvVm1SaDdYa3kxRG5RcjRtR3A3TFd6bDlKWHpn?=
 =?utf-8?B?UzRkOE1Bem5yZm05bGhRd1gzWWIxbXpHbG82SVRkYlpiWGhmK0N2VmtsbHow?=
 =?utf-8?B?Y2hGRUw2dDlOMFV2Z09VdXpRalFTQ1dWZzJ4OERkQ1lBc3lyTzNiQVZhakxR?=
 =?utf-8?B?WUg3cEhWMnArL21CZlRWRzVqclFiMG5jSUF5a2s5aWJVTXFhTlB5bHpYNGNU?=
 =?utf-8?B?dUZ0aVVnRUk2SkxuYWozN29oV1ZTMU9sVkNoa2p3emZDa2hZYW1DOWZiWGox?=
 =?utf-8?B?U0t6MzNObzdRY2pzdVdOUWNtaWxuM3NiUko4T1dLZ2hTUHVvbjM4cUdtZWRL?=
 =?utf-8?B?bnN2RHdNcXIzK0toTzl5TUd0ZEcyOUJlUmcwZGdqZG9JSURjc20rVzg4OHF1?=
 =?utf-8?B?QW44dS82SkNBOHd6ZDVKUUttVnlYK2luRC9ZVEEzRmRDR1BlTnQ5eHgrSktr?=
 =?utf-8?B?L29qSVRjTTc0MjJtMXRQazBEOHloV3hVblgwNzlkdHk0SFkvZ2RqUnI1QVNH?=
 =?utf-8?B?L2VSUHJIZGFRL1FpYlFmZ2FVRjhhZVhMUHVRVjZaaFljZ1FrZUlXZURIb1ZC?=
 =?utf-8?B?RXQ1WHBYb2RaUDNka3pURFpXRklra1NmQXZVakppc0JOYloyaFBmV3liZlhZ?=
 =?utf-8?B?M3RqWXNQZ3BzZk4zWG52cFpraG1wMGJ4bUUxb2hiVUlmT2xhK0JndlBRSXRM?=
 =?utf-8?B?TEM3cXhqdG1qZXJFUVdJdzJBd2VTMEpZVXJDcEJlS2p3OW5GV0lqMG5jVlVj?=
 =?utf-8?B?QnMzcjAzbm14N3RQQXBkTlpyRWp0RVYva2h1NFhzQWpzOGNpaWh3ZmdvNlVj?=
 =?utf-8?B?M2QxMEpxbmhYQkFTWHRBTE1TcDhoeTNWaytndm9qZkRRNzgxTDIrMmQ1Z2lU?=
 =?utf-8?B?NzNtUWdlQnFtaU9TeHVpQkozZkdQTzQzTkh2SWdXWS9hRTlQMEFyY0JtYng5?=
 =?utf-8?B?RHVNQmZMcEdacEpScG5zNU85aGtwaDRPL3dRT3lWVWdReWVhYWdwTzE4NDhz?=
 =?utf-8?Q?VuJiWkhys66Oacaj15QLMucWtQTZSqh1ogtFk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 17:39:02.8015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d439307a-dd6b-4be1-7ad7-08dd0a5363c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
Received-SPF: permerror client-ip=40.107.244.54;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
second release candidate for the QEMU 9.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.2.0-rc1.tar.xz
  http://download.qemu.org/qemu-9.2.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 9.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/14

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.2

Please add entries to the ChangeLog for the 9.2 release below:

  http://wiki.qemu.org/ChangeLog/9.2

Thank you to everyone involved!

Changes since rc0:

34754a3a62: Update version for v9.2.0-rc1 release (Peter Maydell)
b73d7eff1e: scsi: fix allocation for s390x loadparm (Paolo Bonzini)
9b0a36494a: docs: aspeed: Reorganize the "Boot options" section (C=C3=A9dri=
c Le Goater)
37ee17eebb: hw/core/machine-smp: Fix error message parameter (Zhao Liu)
9c2644948c: hw/core/machine-smp: Initialize caches_bitmap before reading (Z=
hao Liu)
19d542cc0b: hvf: remove unused but set variable (Pierrick Bouvier)
4a7a119b91: hw/i386/pc: Remove vmport value assertion (Kamil Szcz=C4=99k)
c5275c7342: trace: Don't include trace-root.h in control.c or control-targe=
t.c (Peter Maydell)
3de6d364b6: target/arm/hvf: Add trace.h header (Peter Maydell)
0139a4f26d: system/dma-helpers.c: Move trace events to system/trace-events =
(Peter Maydell)
335be5bc44: hw/intc/loongarch_extioi: Use set_bit32() and clear_bit32() for=
 s->isr (Peter Maydell)
e05ebbd651: hw/intc/arm_gicv3: Use bitops.h uint32_t bit array functions (P=
eter Maydell)
3d7680fb18: bitops.h: Define bit operations on 'uint32_t' arrays (Peter May=
dell)
0340cb6e31: arm/ptw: Honour WXN/UWXN and SIF in short-format descriptors (P=
avel Skripkin)
0231bdc895: arm/ptw: Make get_S1prot accept decoded AP (Pavel Skripkin)
b0a1009192: tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as counter enab=
le (Roque Arcudia Hernandez)
9a0762c132: tests/qtest/cmsdk-apb-watchdog-test: Don't abort on assertion f=
ailure (Roque Arcudia Hernandez)
583c988415: tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests (Roque =
Arcudia Hernandez)
eff9dc5660: hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues (Roque Arcudia=
 Hernandez)
3bf7dcd47a: hw/intc/openpic: Avoid taking address of out-of-bounds array in=
dex (Peter Maydell)
35ec474fd6: hw/net/rocker/rocker_of_dpa.c: Remove superfluous error check (=
Rodrigo Dias Correa)
c5d36da7ec: hw/timer/exynos4210_mct: fix possible int overflow (Dmitry Frol=
ov)
4483d98ab8: .gitlab-ci.d: Raise timeout on cross-accel build jobs to 60m (P=
eter Maydell)
8cf9190fc1: pc-bios: Update the s390 bios images with the recent fixes (Tho=
mas Huth)
6ba1f714c0: pc-bios/s390-ccw: Re-initialize receive queue index before each=
 boot attempt (Thomas Huth)
1056ca1e70: pc-bios/s390x: Initialize machine loadparm before probing IPL d=
evices (Jared Rossi)
8c79746811: pc-bios/s390x: Initialize cdrom type to false for each IPL devi=
ce (Jared Rossi)
429442e52d: hw: Add "loadparm" property to scsi disk devices for booting on=
 s390x (Thomas Huth)
d6902d7022: hw/display: check frame buffer can hold blob (Alex Benn=C3=A9e)
c873a6569f: hw/display: factor out the scanout blob to fb conversion (Alex =
Benn=C3=A9e)
cca4fc6743: MAINTAINERS: CC rust/ patches to qemu-rust list (Manos Pitsidia=
nakis)
cb241df412: tests/tcg: Stop using exit() in the gdbstub testcases (Ilya Leo=
shkevich)
efd3dda312: nbd-server: Silence server warnings on port probes (Eric Blake)
b6db70bc0a: hw/watchdog/cmsdk_apb_watchdog: Fix broken link (Roque Arcudia =
Hernandez)
f8b94b4c52: net: mark struct ip_header as QEMU_PACKED (Peter Maydell)
5814c08467: hw/net/virtio-net.c: Don't assume IP length field is aligned (P=
eter Maydell)
626b39006d: hw/audio/hda: fix memory leak on audio setup (Paolo Bonzini)
e125d9835b: Revert "hw/audio/hda: fix memory leak on audio setup" (Paolo Bo=
nzini)
c3d7c18b0d: hw/misc/mos6522: Fix bad class definition of the MOS6522 device=
 (Thomas Huth)
2df4291956: hw/sd/sdhci: Fix coding style (Jamin Lin)
ebcf886d88: configure: Use -ef to compare paths (Akihiko Odaki)
6607b77b94: target/i386: hyperv: add stub for hyperv_syndbg_query_options (=
Paolo Bonzini)
19e566162c: tests/qtest/migration: Fix indentations (Fabiano Rosas)
b2cc699979: usb-hub: Fix handling port power control messages (Guenter Roec=
k)
fdc2294ac9: MAINTAINERS: Update my email address for COLO (Zhang Chen)
7b55742254: hw/display: check frame buffer can hold blob (Alex Benn=C3=A9e)
c4e1c361b3: hw/display: factor out the scanout blob to fb conversion (Alex =
Benn=C3=A9e)
13cd9e6798: hw/i386/elfboot: allocate "header" in heap (Sergio Lopez)
a29a977640: hw/misc/nrf51_rng: Don't use BIT_MASK() when we mean BIT() (Pet=
er Maydell)
118a2991bb: vl: fix qemu_validate_options() indention (Gerd Hoffmann)
6e7c96ae61: hw/s390x: Restrict "loadparm" property to devices that can be u=
sed for booting (Thomas Huth)
b8c5fdc658: docs/system/bootindex: Make it clear that s390x can also boot f=
rom virtio-net (Thomas Huth)
0271fdc650: docs/system/s390x/bootdevices: Update loadparm documentation (J=
ared Rossi)
6dc293540e: tests/tcg/s390x: Add the floating-point multiply-and-add test (=
Ilya Leoshkevich)
e1f1ccb8f0: target/s390x: Fix the floating-point multiply-and-add NaN rules=
 (Ilya Leoshkevich)
80c80346eb: hw/usb: Use __attribute__((packed)) vs __packed (Roque Arcudia =
Hernandez)
ebbf7c60bb: vfio/container: Fix container object destruction (C=C3=A9dric L=
e Goater)
66650fd0cc: vfio/igd: fix calculation of graphics stolen memory (Corvin K=
=C3=B6hne)
aff0c39c5b: vfio/igd: add pci id for Coffee Lake (Corvin K=C3=B6hne)
8377e3fb85: tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc() (=
Peter Maydell)
95c9e2209c: linux-user/arm: Select vdso for be8 and be32 modes (Richard Hen=
derson)
180692a1a1: linux-user/ppc: Reduce vdso alignment to 4k (Richard Henderson)
399c8082ca: linux-user/loongarch64: Reduce vdso alignment to 4k (Richard He=
nderson)
f7150b2151: linux-user/arm: Reduce vdso alignment to 4k (Richard Henderson)
f19ec28ddc: linux-user/aarch64: Reduce vdso alignment to 4k (Richard Hender=
son)
dff406754e: linux-user: Drop image_info.alignment (Richard Henderson)
c81d1fafa6: linux-user: Honor elf alignment when placing images (Richard He=
nderson)
779f30a01a: cpu: ensure we don't call start_exclusive from cpu_exec (Pierri=
ck Bouvier)
7ba055b49b: target/i386: fix hang when using slow path for ptw_setl (Pierri=
ck Bouvier)
ef7e76a2cd: tests/tcg: Test that sigreturn() does not corrupt the signal ma=
sk (Ilya Leoshkevich)
fb7f3572b1: linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR (Ilya Leoshkevich)
2a339fee45: accel/tcg: Fix user-only probe_access_internal plugin check (Ri=
chard Henderson)
f275508046: target/arm: Drop user-only special case in sve_stN_r (Richard H=
enderson)
8491026a08: linux-user: Fix setreuid and setregid to use direct syscalls (H=
elge Deller)
0926c002c7: migration: fix-possible-int-overflow (Dmitry Frolov)
4daff81efb: migration: Check current_migration in migration_is_running() (P=
eter Xu)

