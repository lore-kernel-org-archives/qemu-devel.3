Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B656C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 23:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scCfW-0004xV-Ss; Thu, 08 Aug 2024 19:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1scCfV-0004pj-Cf
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 19:35:41 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com
 ([40.107.223.59] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1scCfJ-0000Kc-8f
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 19:35:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv1W0IQQvWzm4gOgqYPj9H8F0R6Pf6AY9osf6BkG9bUZMo9uMzHYD/ywybfP70k/qZJy/cvUL2g+ou59mx/NNtrIqY+biK9mtK/3eflaEI8DAsImErgh3C0ViyHOwysrzDRb/mHAjxg/LXNJX8S/5qxww4ZxzENeXsnDrRluTPzhqAQJJrGmR5vHPO/oBevzNLKkXe5d6O8X9SjQRJyJ4AKQJV8M4eMCksO5lc+juSs9InvlcVjIefiP+gcB0RBRzUbAqNlslPEDZsRPdCrYv1NwGVfefPdIOUrZ9nWCP2sTojrebghRr+tTrGJu0MDHn0t/DXZxR2JFbaTAzqx5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiymkrKzcGhj7x/sIix3DkvZH39lGp21GLuqGO2ChhY=;
 b=joz1CTT/42zZR1nXAiT+xFopC927cvrvhcox3wk4sjYCpUDaqP1Bm60Qt5mQqaQTfnKKvErbnqFCXBim4XplVDJJJ3/iGa4e6SySq58WvWtxR5+YF8ik90ETgYtdQU3quEpgXEGrHpU8ylD1Sbcn218Gx6MRUkjji7Fkv2QDrTZDn+vu7rBv2KXSto3gEbcV6bfKJur/81MqX4gczHR6r92dHOv+KOvSNCJvalkrgKYEZn7dj2+9nTPnJUQpG6Bf5vdKvWX/RgdoSyVxJPNk6aZpd37eA9NedSgKU/OfdzG7fH5ea+UQlJTrVvKGcNbgvLjXs8yomY91Usm82GPcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiymkrKzcGhj7x/sIix3DkvZH39lGp21GLuqGO2ChhY=;
 b=oonrR8fz87N/8VAEaJe9MdaRldolA48RUfxZYLmh2on+r4lQN2cTxXUpLggMMBQpd/6EiZRusHmGB7rNg+dB1FBakHYEA50X+6rjUgRfz7QWkncNDCj3hn4XBY6EyDTuQS/pe8gT3I1gGveC60anjWuAw16w4IjNyURyAY8KP8s=
Received: from CPXP152CA0007.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103::19) by
 CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Thu, 8 Aug 2024 23:30:20 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10d6:103:0:cafe::d6) by CPXP152CA0007.outlook.office365.com
 (2603:10d6:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 23:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 23:30:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 18:30:16 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.1.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 8 Aug 2024 18:29:58 -0500
Message-ID: <172315979813.1700716.2823416322089750311@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8120c75c-c9c1-4dc8-2457-08dcb8020fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0VqVTgwOWFaSGJGMG5GbzJSeU56UDdkTnBlZ3VnVmpkUlo5cnV3V1BOWWtJ?=
 =?utf-8?B?NUFtRUcxSkhRSVFmMDFjWW8xczVzU3VxUkV2NHlnM2x6aFl4dnFmeWNRRjZa?=
 =?utf-8?B?cG5EU015a1RkREt1clRoZVBYTTlNbVcwWllrTzJxL0o1VnlxVVI3cXZMMTM3?=
 =?utf-8?B?cFZqU3dRcis2RDlZSFZEQ0dRZnF2WERYK2RTb2wrMVJlV3RhditpZ3BiRkJa?=
 =?utf-8?B?RWlJQ1FZYlYyTitNQVZVVGZVNWZQYi9ScStvbEJZR2tqZnM1NTNBK29mKzRT?=
 =?utf-8?B?emtjR1RLVXpURG9VVjJlcVhlRnRVaWNxZzRONDBObEJZRld2Zk10SkpIc2VV?=
 =?utf-8?B?azRrU2FhZnBSbkVuSU5oMmViak1UdkJzdU14ZTBwS1Rwd1FMclhQSVVHdXNC?=
 =?utf-8?B?TGM5R0M4R1RIM0U4RmRhelNaWUhsNy9jRE0xSVl1RXlKL1F5aDY1KzU5TTdE?=
 =?utf-8?B?eGJkRE5zTEtuNFFwbjFLSkJOSzhCVnNpQnJBVkl2dGp2d1djUzV2R1IxWWlU?=
 =?utf-8?B?RUxwSmVBd1Y1OXZybVpGbkE0My9WRVZvNnQ2N25qSXNLSTZhMU1GL2ZSYVNL?=
 =?utf-8?B?UzROUjJDWUxIeU1ZdVNSMk5QSVdYU2hlalh0U3NBS3Fqd3d5NmRUOHp0Z21x?=
 =?utf-8?B?dHluNmExMEk2TEtDbEp5c2RlMU9teHpkMElGMzNVVnh5QnFiaHpqSkdrWWs5?=
 =?utf-8?B?K04reW5wd00rRGo5YkE0MXlYOEUwNWhLZW1sRkJZd1BaY1J3cllUbmlGUWlZ?=
 =?utf-8?B?UnRsY3NNVjhOem40RzVJZUtpZEU5UU1xQU9oaXk2WXR6UDdBMHpnaXlocWtI?=
 =?utf-8?B?L1Y0MEliUWN2V0JGUlZnbmNIbnovRVRNaTJKaFFMU2RCbXZ6SW0zRTMxTFk3?=
 =?utf-8?B?a2tPNUF1YUZHVG1rU1N3Y2dUOWVEd1hPbUhkbUdYeXlvOEgvRk9QTWs2TGlr?=
 =?utf-8?B?ZDNySEh3eSs2Qmc3TC9OTjF6WmM5azMzNVRQRVpZZUt0ckQrYkkxcDQ1VkNw?=
 =?utf-8?B?VzVjUUJFSnlnclB6VHBMbzhpTlYrRjRpSzVhMHpnbitKVUtIWS9jei9hN1FD?=
 =?utf-8?B?dEFGWDJXSEtTSXc4NTk1T0tnZ1k4WVR4cWNPaWliQzNZdzZZZ2ZuVFBJWXZy?=
 =?utf-8?B?MC9vdjFhRlVZWE5VL2NTdWZUZzBCbXNtaDRoU0ozNzdyVS9EdnJmdE5mYmhO?=
 =?utf-8?B?UlR5eVF0VXVyOFVWY3hWSEM4cy9SNzd6VEdmdXBCQ0JsODhSUFdsU2pEOHd1?=
 =?utf-8?B?cnFGNVUwNlVLOC9tOTZ1YkdWQ2JKVWFpQW9zV2hMQUI0TVE5NUd3Z1VDeVhM?=
 =?utf-8?B?dlVLQVo3dWFpM01IdklEK0NzNVhaS20xWitNcVYxc0Q0S3BoeGdyWVVKV1Jw?=
 =?utf-8?B?bEszcEl0aWp1dUZ4eUhVYURmVjZoa3BFblBxeVNrMlkrbzZyRGc5YStnQm13?=
 =?utf-8?B?NmNVYlRKYm9ZUUJIT1dkUGtZcG9YbnVka2cvZFV3UFZLbnBXMUMwNlhOSDZO?=
 =?utf-8?B?aWNhdUtVcVVzRC9JSU4wYlErQmZaZCtwU0R2eXVzV3ptN3NHZE5BT3gwN014?=
 =?utf-8?B?SmYxUm11dDF6di8rSFhMYjNWaUliZ0ljQ2xnZ3A0YTN3dVNyNGFyUDl1VXgx?=
 =?utf-8?B?UkNoQUgvcjBtUHk0YjI1NHhsLzgycTZBVWplRkFjTG9GMDFycnFhVjFIb29j?=
 =?utf-8?B?SWF0ZXlnRUc5MnRaamI5YjhoVER0QkVpNDdLanRyOE9FWGROeFFTdml1Yy9l?=
 =?utf-8?B?dnY5c1FYWHNtZVJZdWtycElZNDcwaklMcFVZK1J5ZHFJV1JZSnNBVzFhWmRp?=
 =?utf-8?B?cmhhanRYSkxQajVsWUt5MVVaTlY1enF1Mm1GSHZ0RUFZN2JCb0pSQlFPNU5U?=
 =?utf-8?Q?xCZElWCktA9VX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 23:30:17.5278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8120c75c-c9c1-4dc8-2457-08dcb8020fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
Received-SPF: permerror client-ip=40.107.223.59;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
second release candidate for the QEMU 9.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.1.0-rc1.tar.xz
  http://download.qemu.org/qemu-9.1.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 9.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/13

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.1

Please add entries to the ChangeLog for the 9.1 release below:

  http://wiki.qemu.org/ChangeLog/9.1

Thank you to everyone involved!

Changes since rc0:

0173b97a21: Update version for v9.1.0-rc1 release (Richard Henderson)
47f3361a3a: target/hexagon: switch to dc set_props() list (Brian Cain)
48ac9e885e: target/hexagon: define a v66 CPU (Brian Cain)
2442cc6eeb: MAINTAINERS: Add my hexagon git tree (Brian Cain)
f51e30ff35: target/hexagon/idef-parser: Remove self-assignment (Anton Johan=
sson)
523e45ac5b: Hexagon: lldb read/write predicate registers p0/p1/p2/p3 (Taylo=
r Simpson)
6146060a68: Hexagon: fix F2_conv_* instructions for negative zero (Matheus =
Tavares Bernardino)
682a052805: tcg/ppc: Sync tcg_out_test and constraints (Richard Henderson)
ca1dcc9138: iotests/024: exclude 'backing file format' field from the outpu=
t (Andrey Drobyshev)
c8f60bfb43: iotests: Add `vvfat` tests (Amjad Alsharafi)
5eed3db336: vvfat: Fix reading files with non-continuous clusters (Amjad Al=
sharafi)
f60a6f7e17: vvfat: Fix wrong checks for cluster mappings invariant (Amjad A=
lsharafi)
21b25a0e46: vvfat: Fix usage of `info.file.offset` (Amjad Alsharafi)
b881cf00c9: vvfat: Fix bug in writing to middle of file (Amjad Alsharafi)
9da6bd39f9: scsi-disk: Always report RESERVATION_CONFLICT to guest (Kevin W=
olf)
8a0495624f: scsi-disk: Add warning comments that host_status errors take a =
shortcut (Kevin Wolf)
622a70161a: scsi-block: Don't skip callback for sgio error status/driver_st=
atus (Kevin Wolf)
cfe0880835: scsi-disk: Use positive return value for status in dma_readv/wr=
itev (Kevin Wolf)
7e17111646: block/graph-lock: Make WITH_GRAPH_RDLOCK_GUARD() fully checked =
(Kevin Wolf)
d5f6cbb263: block-copy: Fix missing graph lock (Kevin Wolf)
f0e0c46309: qapi-block-core: Clean up blockdev-snapshot-internal-sync doc (=
Markus Armbruster)
7e7085da1f: docs/specs/pci-ids: Fix markup (George Matsumura)
6e717a7230: docs/specs/pci-ids: Add missing devices (George Matsumura)
ec70b7737f: hw/pci-host/gt64120: Reset config registers during RESET phase =
(Philippe Mathieu-Daud=C3=A9)
50a2429194: hw/pci-host/gt64120: Set PCI base address register write mask (=
Philippe Mathieu-Daud=C3=A9)
ef0a1212c9: ui/console: Note in '-display help' that some backends support =
suboptions (Peter Maydell)
7aea035a60: system/vl.c: Expand OpenGL related errors (Peter Maydell)
0fa57cbfa7: hw/display/virtio-gpu: Improve "opengl is not available" error =
message (Peter Maydell)
c1a6ae5145: hw/ide/pci: Remove dead code from bmdma_prepare_buf() (Peter Ma=
ydell)
11b4666161: hw/block/fdc-isa: Assert that isa_fdc_get_drive_max_chs() found=
 something (Peter Maydell)
f63085c85d: hw/ide/atapi: Be explicit that assigning to s->lcyl truncates (=
Peter Maydell)
8f64e7449e: hw/block/pflash_cfi01: Don't decrement pfl->counter below 0 (Pe=
ter Maydell)
ed5a159c3d: hw/sd/sdhci: Reset @data_count index on invalid ADMA transfers =
(Philippe Mathieu-Daud=C3=A9)
bd6207903e: hw/sd/sdcard: Do not abort when reading DAT lines on invalid cm=
d state (Philippe Mathieu-Daud=C3=A9)
22d5fb42a8: hw/sd/sdcard: Explicit dummy byte value (Philippe Mathieu-Daud=
=C3=A9)
3fad6db79e: hw/intc/loongson_ipi: Restrict to MIPS (Bibo Mao)
ef2f11454c: hw/loongarch/virt: Replace Loongson IPI with LoongArch IPI (Bib=
o Mao)
c403d5ff93: hw/intc/loongarch_ipi: Add loongarch IPI support (Bibo Mao)
ec8595578f: hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c=
 (Bibo Mao)
2aca564e67: hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpe=
rs (Bibo Mao)
8f4f38fd2a: hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_i=
d handler (Bibo Mao)
a81cd679d7: hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as =
handler (Bibo Mao)
ed722e0ec4: hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_d=
ata() (Bibo Mao)
6c8698a5e4: hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_co=
mmon.h (Bibo Mao)
a022e0de53: hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIStat=
e (Bibo Mao)
2252e6c94e: hw/intc/loongson_ipi: Move common definitions to loongson_ipi_c=
ommon.h (Bibo Mao)
7e555781e4: hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub (Bibo M=
ao)
530e6daf74: hw/intc/loongson_ipi: Extract loongson_ipi_common_realize() (Bi=
bo Mao)
40a0815e31: hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState (B=
ibo Mao)
b3a34eb90d: roms/opensbi: Update to v1.5.1 (Daniel Henrique Barboza)
73b0195416: target/riscv: Add asserts for out-of-bound access (Atish Patra)
5e54b439f5: target/riscv: Relax fld alignment requirement (LIU Zhiwei)
30d24145da: target/riscv: Add MXLEN check for F/D/Q applies to zama16b (LIU=
 Zhiwei)
b19bbf2cf1: target/riscv: Remove redundant insn length check for zama16b (L=
IU Zhiwei)
ac63755b20: target/i386: Fix VSIB decode (Richard Henderson)
ef71d8209f: qmp: Fix higher half vaddrs for [p]memsave (Josh Junon)
01bed0ff14: qapi: Refill doc comments to conform to conventions (Markus Arm=
bruster)
9996a35c64: net/tap: Use qemu_close_all_open_fd() (Cl=C3=A9ment L=C3=A9ger)
7532ca570a: qemu/osdep: Add excluded fd parameter to qemu_close_all_open_fd=
() (Cl=C3=A9ment L=C3=A9ger)
a9b5d6e536: net/tap: Factorize fd closing after forking (Cl=C3=A9ment L=C3=
=A9ger)
ffa28f9cf5: qemu/osdep: Split qemu_close_all_open_fd() and add fallback (Cl=
=C3=A9ment L=C3=A9ger)
4ec5ebea07: qemu/osdep: Move close_all_open_fds() to oslib-posix (Cl=C3=A9m=
ent L=C3=A9ger)
5b0c2742c8: linux-user/elfload: Fix pr_pid values in core files (Ilya Leosh=
kevich)
cb14095b3b: hvf: arm: Fix hvf_sysreg_read_cp() call (Akihiko Odaki)
0bd5b9284f: migration/multifd: Fix multifd_send_setup cleanup when channel =
creation fails (Fabiano Rosas)
84ac6fa12d: migration: Fix cleanup of iochannel in file migration (Fabiano =
Rosas)
c80e22517f: migration: Free removed SaveStateEntry (Akihiko Odaki)
d4392415c3: target/i386: SEV: fix mismatch in vcek-disabled property name (=
Paolo Bonzini)
64f75f57f9: net: Reinstate '-net nic, model=3Dhelp' output as documented in=
 man page (David Woodhouse)
f6a3158c82: net: update netdev stream man page with the reconnect parameter=
 (Laurent Vivier)
8e67680dcb: net: update netdev dgram man page with unix socket (Laurent Viv=
ier)
178413a103: net: update netdev stream man page with unix socket (Laurent Vi=
vier)
bb1326abd9: net: update netdev stream/dgram man page (Laurent Vivier)
f937309fbd: virtio-net: Fix network stall at the host side waiting for kick=
 (thomas)
f1595ceb9a: virtio-net: Ensure queue index fits with RSS (Akihiko Odaki)
9e3b9f2765: rtl8139: Fix behaviour for old kernels. (Hans)
5e8e4f098d: target/xtensa: Correct assert condition in handle_interrupt() (=
Peter Maydell)
55f9f4ee01: target/arm: Handle denormals correctly for FMOPA (widening) (Pe=
ter Maydell)
036144cff2: accel/kvm/kvm-all: Fixes the missing break in vCPU unpark logic=
 (Salil Mehta)
5a558be93a: hw/arm/mps2-tz.c: fix RX/TX interrupts order (Marco Palumbi)
515457757f: intel_iommu: Fix for IQA reg read dropped DW field (yeeli)
9a45b07616: hw/i386/amd_iommu: Don't leak memory in amdvi_update_iotlb() (P=
eter Maydell)
93829009a6: Revert "hw/pci: Rename has_power to enabled" (Michael S.  Tsirk=
in)
f1feffc4ef: Revert "hw/ppc/spapr_pci: Do not create DT for disabled PCI dev=
ice" (Michael S. Tsirkin)
47279e8afa: Revert "hw/ppc/spapr_pci: Do not reject VFs created after a PF"=
 (Michael S. Tsirkin)
b0fdaee5d1: Revert "pcie_sriov: Do not manually unrealize" (Michael S.  Tsi=
rkin)
19c45c00dc: Revert "pcie_sriov: Ensure VF function number does not overflow=
" (Michael S. Tsirkin)
b1282f1e35: Revert "pcie_sriov: Reuse SR-IOV VF device instances" (Michael =
S. Tsirkin)
9bab08da4e: Revert "pcie_sriov: Release VFs failed to realize" (Michael S. =
Tsirkin)
ae9c192de7: Revert "pcie_sriov: Remove num_vfs from PCIESriovPF" (Michael S=
. Tsirkin)
b9ba817694: Revert "pcie_sriov: Register VFs after migration" (Michael S. T=
sirkin)
558452512f: Revert "hw/pci: Fix SR-IOV VF number calculation" (Michael S. T=
sirkin)
da44479b1d: Revert "pcie_sriov: Ensure PF and VF are mutually exclusive" (M=
ichael S. Tsirkin)
c8597d3e1c: Revert "pcie_sriov: Check PCI Express for SR-IOV PF" (Michael S=
. Tsirkin)
aa01c4914e: Revert "pcie_sriov: Allow user to create SR-IOV device" (Michae=
l S. Tsirkin)
67f5b279fc: Revert "virtio-pci: Implement SR-IOV PF" (Michael S.  Tsirkin)
cc91ac0a72: Revert "virtio-net: Implement SR-IOV VF" (Michael S.  Tsirkin)
e57030e8dc: Revert "docs: Document composable SR-IOV device" (Michael S.  T=
sirkin)
024d046bf4: virtio-rng: block max-bytes=3D0 (Michael S. Tsirkin)
2a99c2ba82: qemu-vmsr-helper: implement --verbose/-v (Paolo Bonzini)
768a28394c: qemu-vmsr-helper: fix socket loop breakage (Paolo Bonzini)
6e623af301: target/i386: Clean up error cases for vmsr_read_thread_stat() (=
Anthony Harivel)
5997fbdfac: target/i386: Fix typo that assign same value twice (Anthony Har=
ivel)
ada1f3cab3: target/i386/cpu: Mask off SGX/SGX_LC feature words for non-PC m=
achine (Zhao Liu)
3722a98948: target/i386/cpu: Add dependencies of CPUID 0x12 leaves (Zhao Li=
u)
4912d6990b: target/i386/cpu: Explicitly express SGX_LC and SGX feature word=
s dependency (Zhao Liu)
eee194dd71: target/i386/cpu: Remove unnecessary SGX feature words checks (Z=
hao Liu)
39635ccd0b: target/i386: Change unavail from u32 to u64 (Xiong Zhang)
c4afcec90f: tests/vm/openbsd: Install tomli (Richard Henderson)

