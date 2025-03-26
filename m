Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02A3C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 22:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txYng-0006w7-Ma; Wed, 26 Mar 2025 18:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txYnd-0006rL-KT
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 18:00:37 -0400
Received: from mail-dm6nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2413::630]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txYnZ-00076v-IP
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 18:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8sbG4q3g2LI4J5M9Z/NCbkzjcGrkOZMDhXdyKsn8fQH+C3+asXEZJc8GUSvoijplUhqegqXEBD1EukeaOSoO0G4FoFTpvNhakYSgFRB9RF34RrDaiegYRL1RmLwoJgsIKx72pZULMtqMJ0RUkXfOIXRS/CRs8CeZTJjrVoQr1mmg2jenzFGAaJ6oN+DeHfd1gZITG8+gAQlKV0j4cIcCZF87KkFZG8ruv/kxkR7bEpak5cMprJIJQ4awROnS8P8Jsi8l1qu/Po3/XGC8c8t8oR+SqyC3AdLVyeXIfS8+lpM3Iv90INZ5I9pNLSfNgY65eMKLj+jZFJm9wcyb7w0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23Qw6NMn+5f+dhQZwv2n4Zyz8FIu5urO1qvR7DO3CM8=;
 b=wUjWBizbmTbNIfbOMlacfpKoRwNC1+jiXEJ+pFxiOe0t/7qr9/sAAl64JFx63Bco0I55aX5kPAkjAoFNkg3sLrWRj4o0py7qlwHKg8Z3WdtQXQjeZjM3z1Tr3NA+//rdNnRZNnijeaFv23MNsBcbkLg/u+us/xwz5H7cth4mDDT3p1jLkvBO5dgBjVUFXRxd+P/I+8fLfLuNpq9Svs5Dzq32c3V64BwTPS1OgPeBssS6bQaUvt4z5MYhzJeZZZFqDjnybG4ybDI9vkFbRUckPVZqvOVn15zwd4pQKrdE+BS0ECp+gnYsIEmZ4tDqA0RWZCL8FsoP3Vb6rgPMU09unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23Qw6NMn+5f+dhQZwv2n4Zyz8FIu5urO1qvR7DO3CM8=;
 b=ayQYlbWAG+yeO7StdhnaGaeA2xvRUKnvmp9B0+Y4FGXnVVMgoCITlQ8rHHtYv6CkYNmjtxt3yVMV2tKUS70BEok8NEezB3QVKH9oCtcFb4Su3lE4WX2U8cMUb8iBQM1CSrc9g49c2UK171FMbGp4SdnxJG+xr0Tsk27YAh0qfOA=
Received: from CH0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:610:77::25)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 22:00:26 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::9b) by CH0PR04CA0050.outlook.office365.com
 (2603:10b6:610:77::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 22:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 22:00:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 17:00:26 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.0.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 26 Mar 2025 17:00:08 -0500
Message-ID: <174302640889.2159687.7167234085068833302@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ccff68-308f-4b27-1dd3-08dd6cb19da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzN1YTh2NkJVQzJsb05Kamw1WTQ3d1lnUmdnRVhyemw0MUpCRnpJYkt6eko2?=
 =?utf-8?B?TGdrNlRTWVp0cGJId2xHUUQ0TkIybWJEaWkzQUp0US9vaXcwbnUwTk9BQWVo?=
 =?utf-8?B?YXV1N25lYW5ZTXRWWktGYU0zMm1PMXVsdjJKenZTMjhpaEpRd3ZVSmFLcmh2?=
 =?utf-8?B?THlxVlFNYVgrYUE4amtncXRwck9xTzR5bENTQmZiTk8zY2dWY2ZCRUxWSjQ1?=
 =?utf-8?B?c0pBVVdvazg4allUQVhxN1IxdXJMdFNhOGFxVGtWTHRTSGhWWGJZYlBxZmZT?=
 =?utf-8?B?RG16cXBDYXA2TnRVWXJWUCtUNnRuSXRnNE96ajdHMUh2dGU1UW5CcHc3UkEw?=
 =?utf-8?B?b2lwbjlPS0JxVnJ2Mmxub242TUZQYkhpcFp6Y1dyL2M3d0RLYTdNOVdVWGR6?=
 =?utf-8?B?OGYyZkFraDhpNk80dXpISS9yT0dTWkQ3UDhISzI4OGpPRlM4ZXU4akEvUGo5?=
 =?utf-8?B?aHU5QnMrSHBSbzNmZVMwZURpcERuWU5pQ2ZqYUhReW94LzdLVit1T0lPWmpv?=
 =?utf-8?B?UTRTaWdiS214OTZudFFSSXZaTUc0RmdGSjk2a29RK3R1Y0JBaHRKQ0ZkbDU3?=
 =?utf-8?B?VklmVFV4RFdkN3JQb1IwWUVHYmZFZGlJTGVsamR3SjdNQXZxZHJReWZnSmpB?=
 =?utf-8?B?eFh3VGpkTTh3eGYrcUxMUHlOYkZ4NU9rMXRtN0FTeVNici9DS0orM1lmSXVB?=
 =?utf-8?B?bjFqeUpPSUp2WitMVEk2am9jdzJFcjZ4eFI0c29mcGZpbHdHamtxNE5sdXh3?=
 =?utf-8?B?TXJhOFZZYnZ6WUJaTDNudDhIMzI3b0duSEw5STJQdGJiYnNiNlhKbUEreklS?=
 =?utf-8?B?M3lGRWg0aVhXZkVwNStpZkZWZzg5Wi81OVQvMU1GYVB6NW9tTkNvZ1ZydDBN?=
 =?utf-8?B?cUd6bzJOT01tU01menZPeGdxLzdUWlF4SUdrREtNYytvVDM0QTdZMExSeVJL?=
 =?utf-8?B?RUZYc204ejlOVGNyZ21LdkJHTUlMc0UwYSttc0cyQk96NjFuQ1dQalpXeWh4?=
 =?utf-8?B?MDhaRTlEb2xGR05tYk1wdS9nTzdMaDVacEtCY0hFTHNzanI4R3RMV1ZMRnoy?=
 =?utf-8?B?bTlxck4wWkZlUDQ4bEFsYzZzS0gxbS8wRjArdEtVcDB4REFEZFByWnF6ZWRM?=
 =?utf-8?B?ZmxFek9wbVBya01qdnlqbmY1WGFpTXNPTFN3Mlh5TnBOdmNSZlcrN0EvVWVP?=
 =?utf-8?B?Z2QyT2ZVQko2d2RYTTE0dmN6bE9HeDNQVU05RW5pUGZncitWZ21vdkVwTFBq?=
 =?utf-8?B?YVVnbE0xSWc2bk0yRGZ0U0R2eDhQL3pEZDU3emwzWFhCdXpkSm9rUC9BbXk4?=
 =?utf-8?B?aWJIVDBWOTNsc1Zaa2FNRG82NERJb2MvK0F4NWZPeWx5V2hjQ0NvREhhK1Jq?=
 =?utf-8?B?WW1aR3JGY2d1TGMyajJOcVdpTEdIckVjUXA4ODlVRU1uT2VzdFByTE1OSzNB?=
 =?utf-8?B?ekxoSUI2eHpCNkY4UUFFSTI4OVdWc0hTRnM1Y1NHSUdUaVIzRzErZkkzK2g0?=
 =?utf-8?B?aExLWjhUd0h6TU1LN2F3N1B6bTlZais4MWFseFo3cnJzL05Mc3JCazNZcEx4?=
 =?utf-8?B?K1BuZWlmMmFpTlZsNG9yWUpWMjRSYnA5N2lYaEZVSGtsUVhOSE5JMWhkbG04?=
 =?utf-8?B?Y0dMRjZjQ3lmcUlua1dleFlHV1V5NUNGWjFXRlpJcERFQjV6ZFJkTGNvcHJy?=
 =?utf-8?B?WmdKMVpCZ0JsYkdZSTBVQVJsZS8vSm9TbmtyclBlUDhiTXM2ckJveDZEVXZt?=
 =?utf-8?B?bjRUcGprOXdMV3Y4QWdaV3JPWkhJenFSMjhLZitQbkg5S0x4NjVMRS8yUE4r?=
 =?utf-8?B?Z1FwTVg3QW9DNmVYc3ZGT3Iyb1lwOE9WUHp4MGxtTFd0RGVWUGRrenVlQ3I0?=
 =?utf-8?B?VzN0d1VyUi80Q2thdEtudi9ydVlWZFhHWTZ2MVRpd1pKZ21HYngwY2Y2a2pt?=
 =?utf-8?Q?DKwFAgakvSY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 22:00:26.5970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ccff68-308f-4b27-1dd3-08dd6cb19da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
Received-SPF: permerror client-ip=2a01:111:f403:2413::630;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
second release candidate for the QEMU 10.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.0.0-rc1.tar.xz
  http://download.qemu.org/qemu-10.0.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 10.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/15

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.0

Please add entries to the ChangeLog for the 10.0 release below:

  http://wiki.qemu.org/ChangeLog/10.0

Thank you to everyone involved!

Changes since rc0:

b876e721f1: Update version for v10.0.0-rc1 release (Stefan Hajnoczi)
78877b2e06: hw/misc/aspeed_hace: Fix buffer overflow in has_padding functio=
n (Jamin Lin)
7b8cbe5162: hw/intc/aspeed: Fix IRQ handler mask check (Steven Lee)
d4dfb4ffd4: aspeed: Fix maximum number of spi controller (Troy Lee)
64acc23c97: rust: hpet: fix decoding of timer registers (Paolo Bonzini)
f7b87e464c: rust/vmstate: Include complete crate path of VMStateFlags in vm=
state_clock (Zhao Liu)
9bd7e6f7f2: rust/vmstate: Add unit test for vmstate_validate (Zhao Liu)
8df1b0012a: rust/vmstate: Add unit test for pointer case (Zhao Liu)
57c327f3a0: rust/vmstate: Add unit test for vmstate_{of|struct} macro (Zhao=
 Liu)
1998502196: rust/vmstate: Add unit test for vmstate_of macro (Zhao Liu)
b131003721: rust/vmstate: Support vmstate_validate (Zhao Liu)
3baf82e0a1: rust/vmstate: Re-implement VMState trait for timer binding (Zha=
o Liu)
5006e39cfa: rust/vmstate: Relax array check when build varray in vmstate_st=
ruct (Zhao Liu)
e5655e92a8: rust/vmstate: Fix unnecessary VMState bound of with_varray_flag=
() (Zhao Liu)
42c814b139: rust/vmstate: Fix "cannot infer type" error in vmstate_struct (=
Zhao Liu)
618258256e: rust/vmstate: Fix type check for varray in vmstate_struct (Zhao=
 Liu)
20797069c7: rust/vmstate: Fix size field of VMStateField with VMS_ARRAY_OF_=
POINTER flag (Zhao Liu)
c3d80af5ec: rust/vmstate: Fix num field when varray flags are set (Zhao Liu)
6ca5c3bedf: rust/vmstate: Fix num_offset in vmstate macros (Zhao Liu)
ea8a7ceba3: rust/vmstate: Remove unnecessary unsafe (Zhao Liu)
e16354b7f2: exec/cpu-all: remove BSWAP_NEEDED (Pierrick Bouvier)
134ab17fff: load_aout: replace bswap_needed with big_endian (Paolo Bonzini)
cc3d262aa9: rust: pl011: Check size of state struct at compile time (Peter =
Maydell)
5b87a07e76: hw/char/pl011: Pad PL011State struct to same size as Rust impl =
(Peter Maydell)
9d116f42a3: rust: assertions: add static_assert (Paolo Bonzini)
5e5d18d2cc: docs/firmware: add feature flag for host uefi variable store (G=
erd Hoffmann)
e1092f765d: hw/uefi-vars-sysbus: allow for loongarch virt (Gerd Hoffmann)
5807508fad: hw/uefi-vars-sysbus: allow for riscv virt (Gerd Hoffmann)
761d0b5fb7: hw/uefi: fix error handling in uefi_vars_json_load (Gerd Hoffma=
nn)
ae24cf139b: hw/uefi: fix error handling in uefi_vars_json_save (Gerd Hoffma=
nn)
560429fd74: hw/uefi: flush variable store to disk in post load (Gerd Hoffma=
nn)
a028e04c89: mailmap: Update email address for Akihiko Odaki (Akihiko Odaki)
94a9471ceb: docs: Explain how to use passt (Laurent Vivier)
14fb6dbbc5: Makefile: "make dist" generates a .xz, not .bz2 (Michael Tokare=
v)
73c0c904fc: target/ppc: Fix e200 duplicate SPRs (Nicholas Piggin)
8defe9da08: target/ppc: Fix facility interrupt checks for VSX (Nicholas Pig=
gin)
1490d0bcdf: ppc/spapr: fix default cpu for pre-9.0 machines. (Harsh Prateek=
 Bora)
667413f5bf: ppc/amigaone: Constify default_env (BALATON Zoltan)
0cb6498b4c: ppc/amigaone: Check blk_pwrite return value (BALATON Zoltan)
b8d5503a3e: target/loongarch: fix bad shift in check_ps() (Song Gao)
1267e1ddeb: docs/system: Add entry for LoongArch system (Bibo Mao)
ca2737d6ec: host/include/loongarch64: Fix inline assembly compatibility wit=
h Clang (Yao Zi)
7bda68e8e2: qdev, rust/hpet: fix type of HPET "timers" property (Paolo Bonz=
ini)
d8b1c3eaed: ppc/pnv: Fix system symbols in HOMER structure definitions (Nic=
holas Piggin)
ce5a32d180: ppc/pnv: Move the PNOR LPC address into struct PnvPnor (Nichola=
s Piggin)
965797d19a: ppc/spapr: Fix possible pa_features memory overflow (Nicholas P=
iggin)
e0b9357337: ppc/xive2: Fix logical / bitwise comparison typo (Nicholas Pigg=
in)
344921309d: pnv/xive: Fix possible undefined shift error in group size calc=
ulation (Nicholas Piggin)
033a5649b4: ppc/xive: Fix typo in crowd block level calculation (Nicholas P=
iggin)
d1368344bc: rust: Kconfig: Factor out whether HPET is Rust or C (Peter Mayd=
ell)
f88c9cd804: rust: Kconfig: Factor out whether PL011 is Rust or C (Peter May=
dell)
a725bc970e: target/loongarch: Clean up virt_cpu_irq_init() error handling (=
Bibo Mao)
daf78a9d51: target/loongarch: Remove unnecessary temporary variable assignm=
ent (Bibo Mao)
0973b505fa: hw/loongarch/virt: Eliminate error_propagate() (Bibo Mao)
d7ffc17de7: target/loongarch: Fix error handling of KVM feature checks (Bib=
o Mao)
fb802acdc8: ppc/spapr: Fix RTAS stopped state (Nicholas Piggin)
f700abbbeb: tests/functional/test_migration: Use "ncat" instead of "nc" in =
the exec test (Thomas Huth)
6121c55db9: hw/xen: Downgrade a xen_bus_realize() non-error to warning (Mar=
kus Armbruster)
de7b18083b: hw/xen: Fix xen_bus_realize() error handling (Markus Armbruster)
ffe4db11f8: target/riscv: Add check for 16-bit aligned PC for different pri=
v versions. (Yu-Ming Chang)
1dd24ccf82: error: Strip trailing '\n' from an error string argument (Marku=
s Armbruster)
1c89dfefc4: cryptodev: Fix error handling in cryptodev_lkcf_execute_task() =
(Markus Armbruster)
1ddd4d3f6e: tests/functional/test_x86_64_kvm_xen: Remove avocado tags (Thom=
as Huth)
bcbd8c0edf: docs/devel/testing/functional: Add a section about logging (Tho=
mas Huth)
1a010d22b7: linux-user/riscv: Fix handling of cpu mask in riscv_hwprobe sys=
call (Richard Henderson)
a6836b6d49: docs/system/arm: Use "functional tests" instead of "integration=
 tests" (Thomas Huth)
cef6da5bc9: docs/system: Use the meson binary from the pyvenv (Thomas Huth)
23686dfb76: tests/functional: remove all class level fields (Daniel P. Berr=
ang=C3=A9)
6d19d09547: tests/functional/test_arm_orangepi: rename test class to 'Orang=
ePiMachine' (Niek Linnenbank)
c1a6bff276: hw/virtio: Also include md stubs in case CONFIG_VIRTIO_PCI is n=
ot set (Thomas Huth)
4e9e2478df: target/riscv: fix handling of nop for vstart >=3D vl in some ve=
ctor instruction (Chao Liu)
e83845316a: target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl a=
s a parameter (Chao Liu)
ec6411a525: target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in rmw_sctrdepth(=
) (Daniel Henrique Barboza)
3ea8fb521d: hw/riscv/riscv-iommu: Fix process directory table walk (Jason C=
hien)
d2c5759c8d: target/riscv: fixes a bug against `ssamoswap` behavior in M-mod=
e (Deepak Gupta)
86c78b2806: target/riscv: fix access permission checks for CSR_SSP (Deepak =
Gupta)
17288e38be: optimize the memory probing for vector fault-only-first loads. =
(Paolo Savini)
672cb29d1e: docs/about/emulation: Fix broken link (Santiago Monserrat Campa=
nello)

