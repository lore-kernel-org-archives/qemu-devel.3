Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj8v3-0007Yv-Kq; Mon, 13 Jul 2026 01:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wj8v1-0007Yd-TJ; Mon, 13 Jul 2026 01:09:27 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wj8uw-00031Q-Nw; Mon, 13 Jul 2026 01:09:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuhyltcgXp24nYAS9YxkwNXCifzLBbAAApAobl4QnpHaio92/HJGZR/oU0wyx7Y4/0XDOOUzEj6WSgrFoS/IWeGDZiLu2kaFYiSM29hG987e6U+xZK0EriXBmYfid5MhMD2A/7FNUiV2lBxsGx9PgBCXkFPj5FKyCv8b3RgNXKgztXNLWlSnEK16W79Tur0r7E6J/q+gFNMagVNQrv3+OpNNvOKWM9jx1NmJNahjYMUVL8MI3DOKJvYCcpRwesU33Mo5gEQamQjL/+gv07ARc1j+drnSpIlkm/pc/Dorjhf2+FpubY2i+AlSYgRpd2CQ7olwmtRJvhjIelSOxt3r7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXHTstgUIMUalJZ6wDo/TXxE45to7aH1XIeR6kBmWhc=;
 b=RBdhm0hsl+pF7HhwNsbmI9GsuGYJpba7PEg3xBFV1NrZXmqU5s8Hi2SzjLrfoRTsNAVAg4IJTPh5DlA0Wj9wK9vRLpBrZaAtwmanysvqaBx6Mq3LZnUInXuGGCMf+WOMtHeAO/u4BjaAxw0nh9DMg0xPhXr9+uMndiW2xfymkpTlgz2I5MKFUUr+3+OevCUmm+/5gUoyHMgI5yaDzkzCDh36yaluZ+O1bRamsSMDarIb67mX6wOBgyvRAM2P/YDqD4GdQ02AZAyxtuGTP2eq1jyahLXX9wEfjyvkq+udPmMfHFETz98LoIilMKEX7uBHiXh/48/fdvU1bylB4zN/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXHTstgUIMUalJZ6wDo/TXxE45to7aH1XIeR6kBmWhc=;
 b=JwfHXaNfWCalFn0ITTTHu/cW+F3Dz5xdw3Ths1yKMxHQj5bumkYBUFBQkdUm1DrdbmkJX/D7O8epCf3U4Ylp4Reja5g+bWRx39w8T7Q2yPiI3rs2pMeSa7p1gnCrT5DrENIB/AXkTgbXmSvN8zBwn4VR+GAdNwwRlDdl4yu0YNonBq2omOALGO2frzTyfP73FqMRSPaTDSFyYoS2Sw6XX1bgS8x2R/kw7C6tSC+i+I5+QP9Mm7ULKK3hvKtxXzV49AE5MEUIIWAcCF+ZOSLiQS75Mx2qrmdi5acgyvLbZVWLC2OpCK8LVYU9FbQyRzJo/Ab/FUKTd3SdKVcYUsQw4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KU4PR02MB9259.apcprd02.prod.outlook.com (2603:1096:d10:79::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 05:09:13 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 05:09:13 +0000
Date: Mon, 13 Jul 2026 13:09:07 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Junze Cao <caojunze424@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 th.huth+qemu@posteo.eu
Subject: Re: [PATCH] tests/functional/riscv64: Add K230 Linux boot tests
Message-ID: <alRyubVpxE1MCoyW@ChaodeMacBook-Pro.local>
References: <20260711131834.98422-1-caojunze424@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711131834.98422-1-caojunze424@gmail.com>
X-ClientProxiedBy: PH8PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::29) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KU4PR02MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: e21a1af8-9743-4185-c994-08dee09ce151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|23010399003|376014|1800799024|13003099007|18002099003|3023799007|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZUpXrJBBrHXUd6rMxFAwKrX8rptGjnss5C9rxEvGb3xtaoteaKsWYxRI+5wcopYsXiH2xfF3bc41FiDSdgi+VkZtuag1uR9PsZgr6BwUVXoRTcqDEUFDoRltLDHUBlgpHeIwrnu4GyFIgtSOvb3CvMqcL1mVjwZ23veBXOPNrFWE+8QRRwx3XddRAUP8uK4+cP5Xa8vS/nFsxWOZL5PMdym0oq5etjVWtRI0MMs6WUOGkm8fJA8EFkfJPD9q6JQQDOlSBtOhCVLBXFObgCUl/p8iLhc8BghmSVdaqYyaX3i69fnbhSgexy9Jn0RTpCfHNtW2rngpl6jh1ptn0uCz/ZjI1JLaOmyMpwWMqvEuMk3L1GOQuMSOmCt70yYlIM+wWDwr8bCBMSK9gj4/kXfBGO4OEnQTZuCrm67kRPsYxIG4ymd89enzLxeT+yFT/2za3/LjoLZRHXsLo0rC92+wCNGkA/e2BZVWTbsKm60+lUUXD9PHarEJXBdLKcCBLnBbgSImv69UTJ6MJFzuxi+Wt+VnetwlD1Q98zjdsNwQ8dFfSrgteSfDPZ8Up/sNEuaY1NHJy6BHktI4SOzeWR2Cvi0c3Jfu4/s1Hnvi9I6ETDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(23010399003)(376014)(1800799024)(13003099007)(18002099003)(3023799007)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RoqLla1uhBNQHxEU4c21BgmzpxNVwtmPa0rbtseWxg62Bxh3QiEdQomoZPtM?=
 =?us-ascii?Q?PI23Q5ZIX8pr6PUDbeWI2QD0/jP3FzoR2PvuCAAPWxDY4v/HogJ3Y2yvgj+9?=
 =?us-ascii?Q?WDZ40ZCULk0+aGw2RoKeaR4/Jhlk9gf1cWFB29nehxFXYX8ObccACtUr+Rro?=
 =?us-ascii?Q?m42uBz2xrnA1iK9MCCe8v10fs4n3oPGB3tvXKWc9AueDbhbLmTFfsEMFGSZZ?=
 =?us-ascii?Q?wLfXKIQMqt3hvUnfoXrZOxVEcQGue0Sl/DHwhMziSfZ+DTJpYls2fTm/T1Dy?=
 =?us-ascii?Q?Ta1tLDkDTB4wAsDau0eDShSZFXCZisOJJXvP6H81utvjqRMxJsXHkBIemHYx?=
 =?us-ascii?Q?jlU1FVIEbPHTn2o4m/eLLmkKyHJ2opvnEJrr+L4erdILYKgUbzZBxVfCjihs?=
 =?us-ascii?Q?lvUAAWBn7JhWQmORaIe6nym9D213DBcD0AP/pufkUs8+xXjtHvAbDR5mF9II?=
 =?us-ascii?Q?o3X0ph6k1cI2IUAth/cTNBFWdhUkGZ1YMU3XESxL95SRyFDq1cem8F2XQFvq?=
 =?us-ascii?Q?CgouqhnLao7vdZ12RLJ1TiY6z7MMsxGVfokqOIxrrgHhn8XLzJq0NQa4KaYU?=
 =?us-ascii?Q?eTIwwUtd7OV/cvPhiIOfA6xE+Bdssqwotyh9y+3HcubxDdSyZUw+W/UppyPh?=
 =?us-ascii?Q?Ai64xzDxBeTCeC/ILrE7KsrPYw/DZJuslCREpnhNPNbYmcLCmXBEO3UmcBwH?=
 =?us-ascii?Q?rpzaHSL9D5+MiH6r631UpFf8c0ej04GPATqti+jOr6IR3zLCrF8u1ER81MLv?=
 =?us-ascii?Q?nWg+l+eLXAkkQL9X8lZo9C227IiBhLVp/t94bzxRcIDFTds6ve4yAHVTtXUD?=
 =?us-ascii?Q?PUl7MuSxGE1mTKdgDSZH5Ezrwzoqz9mjn9QNYrgD/2Ok4F7AskV8FjnDAzQC?=
 =?us-ascii?Q?/K5YqqiUW4B8cGKrmuCWnlIFX+EvfhMv9iscGZIPaggDla+2M898XlIRCN0o?=
 =?us-ascii?Q?SoqUSGq/sewLX1rqLlZYgCVNN6jeZFZR0/UWL0fvV3PFNH9Ad0yYCB8xpxgl?=
 =?us-ascii?Q?U9CZAusPvSHbbrOFJMv5tOYjIqzKJgHN5ZxbLMBbljfgAWFc//omZD7zFnE8?=
 =?us-ascii?Q?HxTslJPVa3Utyn8niPr58xnBsFWlAftDRnq10krrVyMJnqM5AuxvLgdgpNup?=
 =?us-ascii?Q?3DmN2qKs4/IU7ugRy6jlqA5PmgqVQKLqZ/s+hAyf9zFfcVk0NaUxCNHQ9m+k?=
 =?us-ascii?Q?0smBUGyRuCkX/1RZKxjH80xMTMNBh5jph5F391uBVWt/fBLmhwfad3hfo/dj?=
 =?us-ascii?Q?+XCl8mLfN0eHvoLyI/eEtw1CovcXG8GyyyGyfx46/EP+Eics9f9zFCEc2IpO?=
 =?us-ascii?Q?ZWlFtiBEnd2R76V/kOLYK718k8i4r3l5ENO7qQqUFv9I7CcmY8ahjw60Qnfz?=
 =?us-ascii?Q?2uDQ/cz3HGsQVhlWnCzOjysb0aiiA7pdhInQc2O2dq0K9zwOYqa2OF+u5fA8?=
 =?us-ascii?Q?avhRbC73kWXEhjX9WRbrZcTaLwQfyqepQMGN8O9sOzDp5owJLlRkveqWLIt1?=
 =?us-ascii?Q?dmKDl6OfFwnPT4icGOrtDiraYJwHEmYDH/7+2urFoC0AZXOpQqTV6RQXgkvu?=
 =?us-ascii?Q?vrBhrx/ij2edSR0eyD0NsPZK4o2/POtnwPJoT4koAMZp9mm1q4ljb1T2+fBN?=
 =?us-ascii?Q?vpyYfqrld0ql9pqJP0UmOq9YlRLjliWMNn/jc0qt9F8hJ7MK4pl/GNsxmzoD?=
 =?us-ascii?Q?xuYTzA/FqW9ncutucGlq5QDuaklk0vzZQ+1+Hmjq34Stlh+HH4vOTNZj1Dma?=
 =?us-ascii?Q?th75IRj8RvHFWIwVn0mwp4pukMtWvyo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21a1af8-9743-4185-c994-08dee09ce151
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 05:09:13.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYfTS3XBKLwlK2m5dytVutFHeCMfajTRXMEC42WK+sD78tNpxVILLZjY/fp9NEksOCuC7IAt600mpe84wE7OPUXDPeaZFFAy4j+A47ZzFkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR02MB9259
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

On Sat, Jul 11, 2026 at 09:18:34PM +0800, Junze Cao wrote:
> The K230 machine supports direct Linux boot and firmware boot through
> the SDK U-Boot, but neither path has functional test coverage.
> 
> Add one test for each boot path. Both tests use the Yocto initramfs
> assets and wait for the shell prompt to confirm a successful boot.
> 
> Fetch the boot assets from the k230-boot-assets repository maintained
> by Chao Liu. Pin the URLs to a repository commit and verify each asset
> with its SHA-256 digest.
> 
> Signed-off-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  MAINTAINERS                           |   1 +
>  tests/functional/riscv64/meson.build  |   2 +
>  tests/functional/riscv64/test_k230.py | 108 ++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>  create mode 100755 tests/functional/riscv64/test_k230.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..fcf87609cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1828,6 +1828,7 @@ F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
> +F: tests/functional/riscv64/test_k230.py
>  F: tests/qtest/k230-wdt-test.c
>  
>  RX Machines
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index c9d4c090fb..d1a3e6c2bf 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -2,6 +2,7 @@
>  
>  test_riscv64_timeouts = {
>    'boston' : 120,
> +  'k230' : 120,
>    'tuxrun' : 120,
>  }
>  
> @@ -13,6 +14,7 @@ tests_riscv64_system_quick = [
>  tests_riscv64_system_thorough = [
>    'endianness',
>    'boston',
> +  'k230',
>    'sifive_u',
>    'tt_atlantis',
>    'tuxrun',
> diff --git a/tests/functional/riscv64/test_k230.py b/tests/functional/riscv64/test_k230.py
> new file mode 100755
> index 0000000000..6ccbf2d581
> --- /dev/null
> +++ b/tests/functional/riscv64/test_k230.py
> @@ -0,0 +1,108 @@
> +#!/usr/bin/env python3
> +#
> +# Functional tests that boot Linux on a Kendryte K230 machine.
> +#
> +# The direct boot test lets QEMU load OpenSBI, Linux, the device tree, and the
> +# initramfs.  The firmware boot test starts the K230 SDK U-Boot and uses bootm
> +# to launch OpenSBI and Linux from images preloaded into RAM.
> +#
> +# Author:
> +#  Junze Cao
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +
> +from qemu_test import Asset, LinuxKernelTest
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import interrupt_interactive_console_until_pattern
> +
> +
> +class K230Machine(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
> +         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
> +         'yocto/direct-boot/Image'),
> +        '3a44970213fa68ad318d308518adfc0bf4bee72ed1b2926f9b468f82ef7d7829')
> +    ASSET_DTB = Asset(
> +        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
> +         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
> +         'yocto/direct-boot/k230-canmv.dtb'),
> +        '5050240b48ce0988c73eaefa73e4945a40abca503cf488d22a3adf6ef50bbe4c')
> +    ASSET_INITRD = Asset(
> +        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
> +         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
> +         'yocto/direct-boot/rootfs.cpio.gz'),
> +        '4e1869a99a232ee60324f71f3a9e84a79b03ccabb5b73f8a727c5ff5be5c0914')
> +    ASSET_UBOOT = Asset(
> +        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
> +         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/common/u-boot'),
> +        '0915b9a92a7c911846a8cf691866ef14ef050a51d04209f884ae8e9ec33f36d2')
> +    ASSET_FW_JUMP = Asset(
> +        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
> +         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
> +         'common/fw_jump.uImage'),
> +        'cf7788e470f1d6e8c85491ecdc2705518db1b6af54080e8c7a3464bad0d902b7')
> +
> +    def wait_for_linux_shell(self):
> +        self.wait_for_console_pattern('meta-k230 initramfs starting...')
> +        self.wait_for_console_pattern('~ #')
> +
> +    def test_k230_direct_boot(self):
> +        self.set_machine('k230')
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        dtb_path = self.ASSET_DTB.fetch()
> +        initrd_path = self.ASSET_INITRD.fetch()
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-initrd', initrd_path,
> +                         '-append', 'console=ttyS0,115200 earlycon=sbi',
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_linux_shell()
> +
> +    def test_k230_uboot_boot(self):
> +        self.set_machine('k230')
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        dtb_path = self.ASSET_DTB.fetch()
> +        initrd_path = self.ASSET_INITRD.fetch()
> +        uboot_path = self.ASSET_UBOOT.fetch()
> +        fw_jump_path = self.ASSET_FW_JUMP.fetch()
> +        initrd_end = 0x0a100000 + os.path.getsize(initrd_path)
> +
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            '-bios', uboot_path,
> +            '-device',
> +            f'loader,file={fw_jump_path},addr=0xc100000,force-raw=on',
> +            '-device',
> +            f'loader,file={kernel_path},addr=0x8200000,force-raw=on',
> +            '-device',
> +            f'loader,file={initrd_path},addr=0xa100000,force-raw=on',
> +            '-device',
> +            f'loader,file={dtb_path},addr=0xa000000,force-raw=on',
> +            '-no-reboot')
> +        self.vm.launch()
> +
> +        interrupt_interactive_console_until_pattern(self, 'K230#')
> +        commands = (
> +            'setenv bootargs console=ttyS0,115200 earlycon=sbi',
> +            'fdt addr 0xa000000',
> +            'fdt resize 8192',
> +            'fdt set /chosen linux,initrd-start <0x0 0xa100000>',
> +            f'fdt set /chosen linux,initrd-end <0x0 0x{initrd_end:x}>',
> +        )
> +        for command in commands:
> +            exec_command_and_wait_for_pattern(self, command, 'K230#')
> +
> +        exec_command_and_wait_for_pattern(
> +            self, 'bootm 0xc100000 - 0xa000000',
> +            'Starting kernel ...', failure_message='ERROR')
> +        self.wait_for_linux_shell()
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
> -- 
> 2.53.0
> 

