Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4E7C61DD3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09UW-00071B-FS; Fri, 28 Aug 2026 23:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09UU-00070p-Cz; Fri, 28 Aug 2026 23:12:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09US-0006MS-U4; Fri, 28 Aug 2026 23:12:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdgvkOAkRZDiTEv63Ji1BxX5JKq2aTcG0I5VZCzTWs/qnxr+4tRRaQTFoXw5vCzoKFIZInsiAKlT9363itACrXBg+WnZsOqdg5cnTAAm4oaZuvxeWgUgCDMjOcSD3WEHqgDNpBP64HJPLqV5s4cFEJyBYzrZbywEVMw7V7uAerJNNNLpHq9+BCXvZngHBNUV+nXFM1qOCzsu7mxZUjuvMTcKxWv8r8ecah9I6SziOB6O78So6O6WE0M21qVNoTXPVEPsAuKA9m7QZQZVhxkoNLAEexbdoGyxokGGRFsa9XEwcVOl7QBMJMvRRR+fRPWoy+eHHFlNHDoe4w9hhE9zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7viUqB7T2NdTcNqx0HDd/Lc+VmpFAyIFFuQta93tpU=;
 b=Y/2p8UdLUXTPyKdaiwGJkTsn5yy5GSoI8vhFFqK5cO9HwAFC/UdzFodPghQ5AW/6sTAzZOSzRMMzh9Gf5T9/9oWjHobVD5c5+IftjE1QWy72ubDw44uOYNtJnCDF2kAwdG3IXrsd7//kjpU6df/QK3yujLGoDxxBjbM/rJMo5ZOknnH5VLu8WU8XMXB0Cd9++RSu6sbMfiv/G5Hk02pgtEeXLBF8PamhcR+tbQTWVNeoJYa7LseCazn15cLHBNP6KTJj9DXAqhhbAneg4C+pqEAZP8AV3FIb20rIQbr2gAtIlnLWfAI5KM2D/ljMfYguG1zel3EFxjV6YQWUPJFO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7viUqB7T2NdTcNqx0HDd/Lc+VmpFAyIFFuQta93tpU=;
 b=DwDnq9bPmr3C7YtLODqnbknrUtFKcp7ZErWVRPzH2UP6+ffE079J6ZHcDUG5EMQcfFdF9Ws/UlGgDpvwNKsiqNLOyXOGGV1f4/KGUUCtbEIkg4LKmpWKJ6I43cMuBjhTQEAVHWUThRuY4cuRv04R1S83tFjlSyrWNWBC2TMlD2xwd2v4VvwY7urA4xoQd7jD3yIW0naYgt5cWuwHMFze+tuvAEFrFqFa+O9qK8bzTgihTtEyMVQnPCjWiqQb6V3AjWoLAnrIFhFt2pdT0GIJ/OOchJIKfGiobfToAdpoR+PlpNjBzrzWEsvkDSGseVUWzCMqseRwf1+4n9p7VznmRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:12:17 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:12:17 +0000
Date: Sat, 29 Aug 2026 11:12:12 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 11/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_rtc()
Message-ID: <apJOA-ooEmsjj77P@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-12-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-12-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH7P221CA0045.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a244807-b4df-4c31-cc40-08df057b54f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L/4Ek1iWPK4lAQlI1agOZvq1g8/LvzWdNZlDnTFc045Ea9EM0L+Ag33fTPmBLmO6S7yuSAs4oCoskxgyYjAfnhUxseaPLal/5sXBoIbcX1GiVS6xOwzjxXRoAnhDFvhRdvPTActdw4z1Y+msYQmP6q2BmGh/sOzJcMADyADie5FYoIIX+fuUbwos3RJkGUZiZiQMsplctolxyPpbfEhFSqZI3HOzWBDKvRTsVesnZJG9o4K0SYF1eM13ho2xhOs+jDEqtAeAZY8r1aP9gnVBK6FHSr00fjcp2SVkS3nzJubqyt83xpfM7FXuBojP6nz0u463xTnnPiVk6so86Txu8JPHIgmXxwAB56hwtIPav/PIrvyMKL6uIttqLvgHP3xNQDoWD08D2rrmsEdI4S63/ewxjAXjBipu57nqTnSmNUR0KCkpnR5wdU9HarVubLx+d+ROuatgL6a2pzjlfzHoigArfmN9SXFdbXA8ep9sKPuSuo7oVxzpIv/R6FjsxsJFJRB8oO+okAUdM2+a01hLXFnOCeZhxeI9xPQKHSD6fM8dW9fdOAXaHelriIHvy7Ej32xZYE9DRdnd35dixCbgkBrK7LrAsEGwqG0pSmc4DiOvQy1sEcP5/Dlxyxq4070XF2Ca1n2hf5VPLb+T6+Ke55mpZfbWWE5EuFJXG/0V5KA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MqkV52smvcNhK6AvR7H44iyqlR4xVD1u3sUd+z5pJ/djUmCt+6bU1DmwRW?=
 =?iso-8859-1?Q?R5+KlUN9D2PDmNwPv3QmQlmP+/0dUQzZdDDo0pQJESswpAm0DBkGIOopVt?=
 =?iso-8859-1?Q?g5Eyaix+5oyrM+BUImc+VLfjmXr6UAGrkW+cWcdBJnHxCHZFcbcXE9B2pI?=
 =?iso-8859-1?Q?ZzNHf3424Aes7dj1Z7xZ3sJNfPhrNy9DLt3vrvSCUyejmYIqf3CUsdoStq?=
 =?iso-8859-1?Q?2GHky7F7T9P+KRqRQiiJQqL/Sum+69FoH6C5uBODykDYKmDMqKnt11Szth?=
 =?iso-8859-1?Q?Yl0azWCiZZOk/iPF1M/bNpUsgOjVveni1yL0V71kyT6OgA4K2Nh2XHsWSn?=
 =?iso-8859-1?Q?k8hKhUjDvQeMxz4ice8jNrWT+Ma8xkGRyO97r+Qw1VI3pmLK4xq3YwohPE?=
 =?iso-8859-1?Q?OIh+9GeJNwwbuehe5zROxPPX6LXREcJr9MDliN66VoxdJR3W9RZD4Bw9Y5?=
 =?iso-8859-1?Q?7wN1mmRWmOHKyjNAblKhwbm9p05touqfmch48Kl/VoJKjumOhEHte7rI+W?=
 =?iso-8859-1?Q?mYh4FmdV9DLPnkkw/Wsu/Iji1ftFlJDNeeFsuh609av6jgfLhouwZ2xWnF?=
 =?iso-8859-1?Q?XjyyodCrbblGWwrxwYHvNMasURB4kjofe2ZUZ/yUFobakWR16ZCNg2EXxT?=
 =?iso-8859-1?Q?A+To+XtRRZrL4P5ncDO4LoucD47Exva6qY71vPMPR5CcsSAwAEkZG8uJuP?=
 =?iso-8859-1?Q?BoIEqyuy5NsS5VAYu/dyAJv7B1M+dVltr8k2umCvXuDMS5dsZWSvFlzRYJ?=
 =?iso-8859-1?Q?1YSqz3/wLh/ujb+EwTUZptK92SPHuFkwmHxHrMgkG/wDSXExsdVEyd8CyZ?=
 =?iso-8859-1?Q?I7m1lMAUZgMzVWTMCAJuoP/JJi0W5FGkcbFY5Pxt6qPIc04SoMmOaKtctC?=
 =?iso-8859-1?Q?rDEm1mdgA0WEEAhAPv3eP5eExznVUYX2de8reIOiVn7JAldkpHZ3Rj6bYZ?=
 =?iso-8859-1?Q?aZqiRY8CeMUA0OWKLmDmTw74FFzTY9w1LdRhu8VhMQbel42V5MsCcUUmrv?=
 =?iso-8859-1?Q?FFP2gTaGUZ035Z0+X+dmQbAMTuKR8gHNa14+KbI0yF0y9DFBEkJUJTXmx3?=
 =?iso-8859-1?Q?JAtd4S2LqT1FrKuzwdSUP9lur/jDVdmbrrdYdXVQhWn8C03qMboYERysCV?=
 =?iso-8859-1?Q?hBDyoD90GT2wDzyFjum9eKlab1u7PaVKvK+bCXccFFLS+lZX5pmWhF2hx6?=
 =?iso-8859-1?Q?jk8m3VQ5xdfNHwi74Masf4ShoaIdKEbdC6Fwv59jkJhZ0T3pnTzVtPvNWm?=
 =?iso-8859-1?Q?a1mKpk74f/KmDlfNh05j15i1XZ4KSeBIA5eLHzljaGyUSsjmugVf8L7oh+?=
 =?iso-8859-1?Q?KQ/ZdqpNc6+Dsznd/JpChnwamWZy90R5YikFGVtedWjYkl8hMIOYxuZ4kk?=
 =?iso-8859-1?Q?suJ44joOWNQviYqagg7icZsso1Xty1azYGzQu5/i3u5qq1sKg/o2SkxDui?=
 =?iso-8859-1?Q?Pqi8VdG5+p9dpKrZOL8qEgZvRq4LCDg+3mCHqWgUlPZiPjzCjdcocJin61?=
 =?iso-8859-1?Q?e7u4/N5s7GOL6Dou+Ey5iiTcfSFmkPmDCyGR0KhtOK6ooxjLZ4GpWOp1u6?=
 =?iso-8859-1?Q?J2pC9PeMUL6lkLdOv8PGJUXwBC22ymXKKwkRFuqbbIXEOoL7xSEMDq9US/?=
 =?iso-8859-1?Q?gGdA7kalUCBi6McgIlPZMgq5uBAEaI27Pv45HpT5kaMf8gahAZAAbXU8zn?=
 =?iso-8859-1?Q?rTdgnxkWpiK9kDL/Y93ur+3iIGM8TVnFJvGb6pzFAwnPi/0d+u2LYnVoUX?=
 =?iso-8859-1?Q?mZP7rbthelHM2X32bigV+sU0r5aEqed0XWPCaLyE1yciidSFeO/gq9w/c4?=
 =?iso-8859-1?Q?KCsCvY9FeL6TTzegZhnczrWpo4DpuK0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a244807-b4df-4c31-cc40-08df057b54f6
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:12:17.6083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ56NtAyE5y/jOIthty9HbU6kgwjQ4DMFiDQ3tBmnk+Lff/kpTvAWAflLxqHLTHcR6PqbJgR8qxTE/ch4YzJ2tQE1Q+QcWij/4/uCeZpNRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5574
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Chao Liu <chao.liu@processmission.com>
From:  Chao Liu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 28, 2026 at 05:39:13PM +0800, Daniel Henrique Barboza wrote:
> The soon to be added 'riscv-server-ref' board will add a rtc FDT subnode
> that is similar to what the 'virt' board users.  Put it into a helper to
> avoid copy/pasting code.
> 
> No FDT changes intended.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 21 +++++++++++++++++++++
>  hw/riscv/virt.c               | 26 ++------------------------
>  include/hw/riscv/fdt-common.h |  3 +++
>  3 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 0107aadaad..ce2dcb43b4 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -828,3 +828,24 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>          qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
>      }
>  }
> +
> +void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
> +                          int rtc_irq, int aia_type,
> +                          uint32_t irq_phandle)
> +{
> +    g_autofree char *name = NULL;
> +
> +    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
> +                           rtc_mem->base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "google,goldfish-rtc");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, rtc_mem->base,
> +                                 2, rtc_mem->size);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
> +    if (aia_type == AIA_TYPE_NONE) {
> +        qemu_fdt_setprop_cell(fdt, name, "interrupts", rtc_irq);
> +    } else {
> +        qemu_fdt_setprop_cells(fdt, name, "interrupts", rtc_irq, 0x4);
> +    }
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 3e40513dc1..ccea5784f0 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -436,29 +436,6 @@ static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
>      qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>  }
>  
> -static void create_fdt_rtc(RISCVVirtState *s,
> -                           uint32_t irq_mmio_phandle)
> -{
> -    g_autofree char *name = NULL;
> -    MachineState *ms = MACHINE(s);
> -
> -    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
> -                           s->memmap[VIRT_RTC].base);
> -    qemu_fdt_add_subnode(ms->fdt, name);
> -    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> -        "google,goldfish-rtc");
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -                                 2, s->memmap[VIRT_RTC].base,
> -                                 2, s->memmap[VIRT_RTC].size);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> -        irq_mmio_phandle);
> -    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> -        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", RTC_IRQ);
> -    } else {
> -        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RTC_IRQ, 0x4);
> -    }
> -}
> -
>  static void create_fdt_fw_cfg(RISCVVirtState *s)
>  {
>      MachineState *ms = MACHINE(s);
> @@ -566,7 +543,8 @@ static void finalize_fdt(RISCVVirtState *s)
>  
>      create_fdt_uarts(s, irq_mmio_phandle);
>  
> -    create_fdt_rtc(s, irq_mmio_phandle);
> +    riscv_create_fdt_rtc(MACHINE(s)->fdt, &s->memmap[VIRT_RTC], RTC_IRQ,
> +                         s->aia_type, irq_mmio_phandle);
>  }
>  
>  static void create_fdt(RISCVVirtState *s)
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index c8b25348bd..eb9db8278d 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -133,4 +133,7 @@ char *riscv_fdt_get_uart_nodename(hwaddr addr);
>  void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>                             int uart_irq, int aia_type,
>                             uint32_t irq_phandle);
> +void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
> +                          int rtc_irq, int aia_type,
> +                          uint32_t irq_phandle);
>  #endif
> -- 
> 2.43.0
> 

