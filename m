Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625D1C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE2d-0002Wr-Fm; Mon, 27 Jul 2026 01:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woE2b-0002Ux-0Z; Mon, 27 Jul 2026 01:38:17 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woE2Z-0003OP-0m; Mon, 27 Jul 2026 01:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtAN3hbNwBl+q2oIbow+J4dVnJpQXcdqilj8Yg8UiPwBhnBqqe4HETI6JS8gDJ0BJ/aNA9Dtpds0T5hM6jrt1C+tP2il914bSTW7BTfdrXULA6mqM6DoRSx21giu70d5pxcupWELb+38lQUwWgyHxUs4YKCMu4+jOvBBW6yU+iw/cfIBeHQ0SVXiI3HsjDh39x0seizOePnDc8Sqv9J5zrB+IFmpM+xw9nKrkSPfCuHy1xuhJLJw4qi1bF794gXrYeVFBpJN4mXFfctLagXUujfKbLBUBVN+QiV40COnKptb7OKuVbcIa6g0zJXtS2+MMTbgBavblCjXl0BlNigrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7GEG1OSInmN53smv47eA4murVyHPh29HmUMYnz7Iqc=;
 b=YENh2w+Nr+T7cHFW60IzGJMUmZv50xGFHf+QkOvdWbEIWMGPhed2KlVwnrHeFlCSmh0vSJX2X5VQDnGUmJimV9pQbooZAu5ccKus33tRmBEenAYDwVZ6UJzS00uN+Yw60OzQaAR4Wj17ZT7urifSNZfMPesgYto8MCxRxwUJu/v1t1kCWRs2YN+QBA42iciLB/VKuBeKhuoHdbNB3X0gy0L1kFyiwtKxUTIuDj1fv1u2iD1Jg2UaBM6iZGFqvV6brMJwoB4A86XX/FIzibCTPMmTSJmN43pYK2McxzlWDP0P6HTTKbpUSXoEaMx56fsAPhHLA3NqS2Xewbe//aJTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7GEG1OSInmN53smv47eA4murVyHPh29HmUMYnz7Iqc=;
 b=G5QI88WwlooKSFr8C7k5FVw2zN78Q0wpXwpqsoZFAtxrnwSUJ3fb7/LFit2OgNLdlmONvOl1MwC2hUsXVGDfoDggpI/FDf8naLQgYVIesrGbiHkpb/QZiMHLXmJqbdnu54PVRBWFwuAW1t8zpqApf8r/9KmapZT6pL8fiKMaaTXBC60IAd+o0niodEvVTLXMwHJKqhQZ5olxlWyVMOmoNcoYaFCMXSzeePKr0f4NsHj2dc9k6fo8QkK2Eze/xWrt9SqziewTPrGRcYcGEVW+i5IbnFNSQw2jGGU8UwIs5XUdaVCpa/zdtYkeLkJ8GuRzdztLKwWCj7EO1sEQEaaXiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB6022.apcprd02.prod.outlook.com (2603:1096:4:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:38:09 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:38:09 +0000
Date: Mon, 27 Jul 2026 13:38:04 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 25/26] tests/functional/riscv64: Add Icicle Kit firmware
 boot test
Message-ID: <ambuq9S0x3ipH1zO@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-26-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-26-bin.meng@processmission.com>
X-ClientProxiedBy: PH7PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:510:33d::22) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: d3856e71-4a6d-4f17-0bdf-08deeba13e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: CuQ1vj70te0Pk3GMzmAoXdOSPA4hWvplRgg49AJ4Sk1Eg3pgHTGcLhs4NBZYsLfaEbtoKdLHvYdLSccmJGLcCRZLK9MQC0PnGhuQZX5B4jNxiDGqqsSZy0M7v4vE9F5n8glWT5jbaUZohUil1TNZ/cCEQqv4O08o8o1Mg3Y6srUA/JinNZFMVXld1PL8n0jXHJQ+CA0mMcZ0HsxgYV4Br8TfXwlvBgo8w2JdRwdqX/Hbh+ECxLtk1NA6dGe8hrRB7y3sf6ZNI8I8o2XggrAwBSq0yFZZoUYDmQCXBzMJkfJn7+MCy6KAIzSMLz9asMH4U7q9dj6f7tojmgC+cDH1iUIohnUchSHqS4gXHKZ8fy5kimJUdmQ9Yt+eJ6MSIdyrruEwsnQIMUmrGV+IXj1IMQAaWIjsVovUaVUNhoYg0431TtdjX2uGLGyj5EJ9Yb+n0daOfD3RkIsBNvvNQGbhmNMrO717lCssojjmksJRJzMkGewHAboG+YmHIu3yYwh8TzHHZoN7XZlOAydd7WFj9qCsmif3uzA5X/s+VWsrA8gg/c+J5eqjf4uXCn1J8yc878I2P65QOJMyH4vAruNEDXiwPEiA9z6tDSgYVuK3HkK+saJos80P0VMnk5iKSkSjMWyAV8+P6gB3zktKwouXGMaLwhLaOkGoUIl405/DG1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+5gTfQ/XNi7VNdTyhI1n4b39vet+qfN9VR7f+y7FPfr9yILhbMoLgI08O7E?=
 =?us-ascii?Q?Pwq69l+nJcjkAG6F0MF7l2hbj/6chfLB49tRvsGn8gNT4SVQ46iCGmC9stNr?=
 =?us-ascii?Q?rRxwfiz+fSDdgwDMW1e1pkETr76exMymLTGMCxR5J993r54Y4uoETzx1utbo?=
 =?us-ascii?Q?WHd2TzksLNZUWvYrIpe/WppbJrvHmXA0sXKXw0lhcDdR0Qk0Y28Vy7BSeC9n?=
 =?us-ascii?Q?MifilrVPjsg5/QePiq5VUTFuNJJ5Rfp5Dezo9l99ZiiHpPqGxoLJ4jmFKh2r?=
 =?us-ascii?Q?lABFIvoXndn3fGSqK6VFKj8T+wrHe31PBWHqnWmQ9WER1bDc8n/JQWF5aCSF?=
 =?us-ascii?Q?F/TS9HO1iLRI8xY9R45LFlUlfJocD4Ls9sc/sBAM9dDR92yhU98ji6H0T0mo?=
 =?us-ascii?Q?olgTVQjlaQz0bquZ60ihG+vJX91DlOHqMZJD6uCb5Sbf/dcbcz3BqFiMe7lv?=
 =?us-ascii?Q?PgMns5DbXji5U9VnVJJi/mMHPURgQi+3FDvGKAFgpgGKMzTmKKCib54frh0j?=
 =?us-ascii?Q?eVHqaYwa7NmiL0waFaZg4I9JAVHpMOe8zrhHOMW8ENHWRRF3wvJTpZrGa4hQ?=
 =?us-ascii?Q?90hDk4c64VJQnJlJk+dqUjqeoO25y5d9qgcdww7mWaPL//34ziELNr49TxKi?=
 =?us-ascii?Q?Pd1PP/vQzuwPKU5hVV5YeEmTUlEGB6OcVN8BBTd7V0wRIVIh2oxtNs6Kr8/j?=
 =?us-ascii?Q?I+XzttyrgT7DcYGQ2eHcnjVFiZbCGs6CbSEeoS93CjmtOiiywHxdi9A2WWth?=
 =?us-ascii?Q?XDGzW3ipLRiHsaSkOTus9Ww1g8vmudKfgkxKI08oXLBJqAN0rb3uAMnzXJKm?=
 =?us-ascii?Q?4M8bpLKelQnwrok0uN8tU+NMZUGhq0cKp0W/Vp4Y9Be8eW9YC2asKguaoqxF?=
 =?us-ascii?Q?GAYn88rgn/4vA+00zD9bnc8Pv3gSCrx4BtUtGPf70oZ82WhAu4x233iUUCiw?=
 =?us-ascii?Q?JBLYXuL75CX61qIf9M+Zf6QKz/1QR6suyvUoREGbEDtupmHJihFaEmEe24br?=
 =?us-ascii?Q?60dOON2c/omG1cuppObGR1juP4D/XPJAcQI1yUVgwmpXWsWtJo9/J3+/0sTQ?=
 =?us-ascii?Q?J1XJit592bEag1sUZMxdwBX2ladQlkMjE/Mh/ngHX2eeQAQBx99UTnm39zok?=
 =?us-ascii?Q?20iBNkZY9nmyqZj+UmvLizqSRNE7N4jdR4GGX0nwCbLX4bJE7uUGlrDCCc8O?=
 =?us-ascii?Q?G6vOiteEtTKY285stAvxdOqISQnHqxaGO2/rpBXwxMbU9cUBR0+2k/bHUSl/?=
 =?us-ascii?Q?jO+27ZUNhXIN19WbDScYEy4/Vs0IGEnPN4aa7Ovbu7lIihMoAAdIibob1wCO?=
 =?us-ascii?Q?ULYD7RN9Q8tFdHECCehnnHQmeDfTdef3oVJcFuZYIy9mK2yabDaUIrQHychm?=
 =?us-ascii?Q?/bxo5vgxg16dvRRSlKEtHqvH3j1CdgxFn2DhJWXevV2xoy5OMBgUHIa80RZP?=
 =?us-ascii?Q?ASLBkRD51U/IDxoeQKOW7TEBHyCx8Cxof4JtTHSEPp9/Mt11FmssCmx0U33t?=
 =?us-ascii?Q?3tjktvEpOjxHWOQsc08rWf3Q92qfcCithKVNqB2zxxrUL2mJB4lDwvI6X/hG?=
 =?us-ascii?Q?Zs1BUQYtwNaAisuKwn4sMPxGxzBnujHAmhUiHqVro/TuaCjlI8movWCETiN/?=
 =?us-ascii?Q?ciOnPiCTcBRCZJ9z4ybIns/XBFeYtDs5RHoN/Eu7DCvCnkha+HW8TdV20P0E?=
 =?us-ascii?Q?8U0Wzim0H55ruzV+LcFsvwYIZLFSdjWQSgK5ATQ3ROFkGGZ17HGk6z8n3KSF?=
 =?us-ascii?Q?KYskfhEDJVEvpd9GIUvCjbFRhteMCI4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3856e71-4a6d-4f17-0bdf-08deeba13e24
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:38:09.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyimJ+Mv64ax0IPRzIlxju2IhWsSGWE1WVkJsLXag9FsvewZs/PcmV/t5/2i56Mbshmhney0dGKAJNUufps7jvJ5ewqvMJx2q8xdm49vAWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB6022
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 23, 2026 at 11:18:52PM +0800, Bin Meng wrote:
> Add functional coverage using prebuilt HSS and SD card images.
> 
> Boot HSS and U-Boot with five harts and 2 GiB of RAM. Connect
> the test console to MMUART1 and let U-Boot start Linux.
> 
> The complete boot exercises the SDHCI controller in the DMA modes
> used at each stage. HSS uses Version 4 64-bit SDMA to load U-Boot.
> U-Boot uses ADMA2-64 to read the boot script and the large FIT
> image. Linux then selects 64-bit ADMA for SD card and rootfs I/O.
> 
> Check the machine identity, kernel ADMA initialization, root
> filesystem mount, and login prompt.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  MAINTAINERS                                   |  1 +
>  tests/functional/riscv64/meson.build          |  2 +
>  .../riscv64/test_microchip_icicle_kit.py      | 52 +++++++++++++++++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4bcc59f1cf..800a2f31cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1780,6 +1780,7 @@ F: include/hw/misc/mchp_pfsoc_ioscb.h
>  F: include/hw/misc/mchp_pfsoc_l2cc.h
>  F: include/hw/misc/mchp_pfsoc_sysreg.h
>  F: include/hw/rtc/mchp_pfsoc_rtc.h
> +F: tests/functional/riscv64/test_microchip_icicle_kit.py
>  F: tests/qtest/mchp_pfsoc_l2cc_test.c
>  F: tests/qtest/mchp_pfsoc_rtc_test.c
>  
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index d1a3e6c2bf..cbf61d9535 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -3,6 +3,7 @@
>  test_riscv64_timeouts = {
>    'boston' : 120,
>    'k230' : 120,
> +  'microchip_icicle_kit' : 180,
>    'tuxrun' : 120,
>  }
>  
> @@ -15,6 +16,7 @@ tests_riscv64_system_thorough = [
>    'endianness',
>    'boston',
>    'k230',
> +  'microchip_icicle_kit',
>    'sifive_u',
>    'tt_atlantis',
>    'tuxrun',
> diff --git a/tests/functional/riscv64/test_microchip_icicle_kit.py b/tests/functional/riscv64/test_microchip_icicle_kit.py
> new file mode 100644
> index 0000000000..a75803fb84
> --- /dev/null
> +++ b/tests/functional/riscv64/test_microchip_icicle_kit.py
> @@ -0,0 +1,52 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots HSS, U-Boot, and Linux on an Icicle Kit.
> +#
> +# Copyright (c) 2026 Process Mission
> +#
> +# Author:
> +#   Bin Meng <bin.meng@processmission.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset, LinuxKernelTest
> +
> +
> +class MicrochipIcicleKitMachine(LinuxKernelTest):
> +
> +    ASSET_IMAGES = Asset(
> +        ('https://github.com/processmission/qemu-machine-images/releases/'
> +         'download/v1.0.0/'
> +         'riscv64-microchip-icicle-kit-v1.0.0.tar.zst'),
> +        '8a8a831f5a1715503abf88386fca81c8e5edb303bff0265118f6ac35a725d27f')
> +
> +    def test_microchip_icicle_kit_boot(self):
> +        self.require_accelerator('tcg')
> +        self.set_machine('microchip-icicle-kit')
> +
> +        archive_path = self.uncompress(
> +            self.ASSET_IMAGES, target='microchip_icicle_kit_images.tar')
> +        self.archive_extract(archive_path, format='tar')
> +        firmware_path = self.scratch_file('images', 'hss.bin')
> +        sdcard_path = self.scratch_file('images', 'sdcard.img')
> +
> +        self.vm.set_console(console_index=1)
> +        self.vm.add_args(
> +            '-smp', '5',
> +            '-m', '2G',
> +            '-bios', firmware_path,
> +            '-drive', f'if=sd,file={sdcard_path},format=raw,snapshot=on',
> +            '-no-reboot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('U-Boot ')
> +        self.wait_for_console_pattern('Starting kernel ...')
> +        self.wait_for_console_pattern(
> +            'Machine model: Microchip PolarFire-SoC Icicle Kit')
> +        self.wait_for_console_pattern('using ADMA 64-bit')
> +        self.wait_for_console_pattern('VFS: Mounted root')
> +        self.wait_for_console_pattern('mpfs_icicle login:')
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
> -- 
> 2.34.1
> 

