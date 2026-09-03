Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3810BC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20bN-00071U-CM; Thu, 03 Sep 2026 02:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x20b4-0006zJ-QY; Thu, 03 Sep 2026 02:06:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x20b1-0007yC-17; Thu, 03 Sep 2026 02:06:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcfWzVSrQACIfeTncj8D9QDnyGmch1rmGM0010IJ1Vgj2B1fvzXtSXxPgEL3RJbJcfxHjbUZbuGaTSHluEgV2XApaxLCtBzeaXetaPtwOzP/Hmkb6hDiq1WbG5OdsUYR2hHg5TKwbZ+INnr8jF5YEa8+1hDoBakcllLWKYZvFXGpRz/thdzHVsOHcqH2b9hPzEwX5VtgQoBCK+QlXxzPQ1GehwoQlxJWmlW1gxHQ/mwJqeO5sRWCX4XeczxvhS+B78vruT/yO2wbK9IjxP6dqSYHX6qwYSEvv0QztPQ8fTDPjnuDmXcfh3qGy93U+t6sKw1mfaLGDak1M/xhv51BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvj2Lt1XssfDaeZEWE98ix37Mxk3DQQaBJvyNbVikWE=;
 b=PrllvEX50IjVYrWjwm8j8JGLV08ka6Co8OR3yCnnkPeuX2WYCs835wBbnUYV+1y5MGYDr2sNmIMdeR1wI1gkeygxnSMp1Ptyjga8k8MsKv4EyTTWE5XrKJ/qL47sAwH95Z3ZE2zd/Y8nfPMzVuM4j4JB5lfrhN/fajcTVxmCrYqcRBBYDtHS051alMjHmwKgGlWVi3p5c/5if2aTLIxrdfd+aWakR+d22xhY+sLXX22GrmSjqnfsYEFFmPuW+CTO3QWQwqob3tX2JrdqD2a+NMDaAsbIcUL75s2OZUGmutIFFARAHzu2EvI53hRL8k22Slccoa920aTK6fOKEf+LLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvj2Lt1XssfDaeZEWE98ix37Mxk3DQQaBJvyNbVikWE=;
 b=Dt0gYRX9dIwcd/SYbe7Q/umrOLwRaHVvrTz0zWXVyhRS94MdlKRuygt9cpbrvuc0pbOILu6pJXMd0vZ2dtrOXIAZEWPxyFrBEsfI1VPPbI9mmPvpxws6zXm8GSFYx4KYoWXx8hVwVuHqNyvQuIB9UQGtuHrTO+UCmKVx/AeX948nnFcT1GI2LxAs0ik44qZtCvNrmpo5FYMVJD/AXwt5pgt111l+O1IUXUrxhczNETfp0zKYeaqgtX2fmg6U4A3RUazdhyWMO2uyDTQeUleqH2+sUOzfDATBEGb+G/I36PmJ42svBOgdFqY/9kiRoyTjwsbiVIRbXEIP9ObRRqQTZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB9348.apcprd02.prod.outlook.com (2603:1096:101:32e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 06:06:38 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 06:06:38 +0000
Date: Thu, 3 Sep 2026 14:06:32 +0800
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 01/16] hw/riscv/aia: Take a MemoryRegion for the
 created devices
Message-ID: <apkOXiEq1Sh4HSwZ@ChaodeMacBook-Pro.local>
References: <20260903055131.257903-1-joel@jms.id.au>
 <20260903055131.257903-2-joel@jms.id.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903055131.257903-2-joel@jms.id.au>
X-ClientProxiedBy: PH7P221CA0087.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::23) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 1becad25-a10b-4579-3744-08df0981842e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: K7TOyUJBEXToVNB3Va/Hp21BJXLv1xjDO+91LMOpZSRoFutGV+9kUkZMu+B4f1igEv1iLAS9YgEOBzbmMHKYK+jaMG1Z8WxKuM8aNd0UGzs28zm6++2s4jTjWHk4U8JWMvsY57vN+Jl3WCIL+oS3Y+PDlwv1qTQxW1liepCcADY6MbQ38AoRtBHS9FQZPUouOAR3Yb41WQ1lrGwB64lo4B/U/zO4JdgjUfAaHEd4nMnUBQZtl1ymdqwCH1xA//lDohrKBJhduM2Nzq7HCbWCZX5TTMXM0zzAkmmZ6fZC7+StAcA7CBUB649JMzkCwwwxmirEIML3v9xVLTq56QFbYBRaeTTL5y5L9OWc2GhsMGLDZUz7G88cTV4uIIGx5oQ4xRNLyxG5h4ariEdRFY/e7m4kfcQc2/yURw8ozW9zrPml9pWbwCesqajV5g0LtxiyiNVumLDT8XJLF+pnfNgGWjVisf3Xed8QdH2qiJw4EsZV2GdLXJMhuRSlzRNxyQfvLi2K8c8E/cbTN0WFdYjNPWmFxvizNnE/mzOyZgCNn7bJln2gGBOsIudSGvzZoUbB5IgxTRDaSowzOAwv90i7W0NmvjqN6t2ugrjSz6NbXdcnv13X9Q3ILy38fYSvhXXHPEjBzKKtEX9YaRPKf0BBIzhL6+B5Qb6OYjK76RC0eOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Gu2lS3gswP4ECbR7li59kSZZP7olydsQPtyay2MPlD6aToM8eVCBH/a6Zk?=
 =?iso-8859-1?Q?C+eC6lrcn2FR5YBr2il45G9twSiAfVZ0uZQWYiXKoB3l07DLOlYW33GcQm?=
 =?iso-8859-1?Q?nhWBhCG+iw+0QGv6c7MPkMLnPxSTmlQ4BJ2xD6PX9t0cmmkppInYRnDHLN?=
 =?iso-8859-1?Q?/WRCZaQp9pdtngz/eguQZJKQlS090yXs9t+5n4eDQLcc6vHA96asEBUV1i?=
 =?iso-8859-1?Q?sIaooUTI1ydIFwiY/wx6F23tzPZTnw6MLSITqzuQRdQ/CsA3D654bc9Hmn?=
 =?iso-8859-1?Q?hU2LmzqeaF12IygUB0A7KpZPen91vcMrNkJqfP+60dUWTXD97d6RvvzjRP?=
 =?iso-8859-1?Q?79qtHazrkmMtRvCE+/bIhO069tKqLYj+rMvjXakdc5muBQ/qJwnZh59auA?=
 =?iso-8859-1?Q?1JbGlldS5cPZuWJYB3nn1qm9DyXUUTZeh8todr22NCrTq60cZr7qjB/8hD?=
 =?iso-8859-1?Q?cGTF0HtvM/rGVLg/pD9fFyFR47Bxu1VqWDPaMaBC9n0pMQBw1w0Cg+J5yU?=
 =?iso-8859-1?Q?+Jrb3RtuvwC+l50fLaxTPFN5w5SjcPHfAxAATnPT7zp4mDvpA6a2vjgYL5?=
 =?iso-8859-1?Q?a3II/Gy2A0jxqxMrH7L8qaf+Cg2vmm+GGasxXgaFBmIHoc9GiSSsl/Psuh?=
 =?iso-8859-1?Q?Ipb5kDrL8pZIx5SbCguvf1lYpv3aR7a2M2n7BEIOU++aTbzQcGwy/K3VNN?=
 =?iso-8859-1?Q?GwwuYqyHiW0Q0zx+9jqjQ4XMz67zCJh+iqpKoZRQpO+IKDwmfboGyIWgl0?=
 =?iso-8859-1?Q?q6yMt5iH2bHg1b9GD4bE8tf1Z7609jMKwEaVXVyEylro4AAPWlh5UTJ9Vp?=
 =?iso-8859-1?Q?a+ouY2rZ30pyey89qzHWFkzJlwalrGWlF/WJ52UAqJ5/UCH6aHyEc5nAD3?=
 =?iso-8859-1?Q?srJ0Oktflb+cyilzx9k5cZhrT1NqCoFvEZir7hqZm6Z4C8VfX40PVsrO2G?=
 =?iso-8859-1?Q?hxZY7kUohBbA5VbgzmwCjIQ8JqaqD6ObGd/p9MZd+bhEk5meGI3eENG9bG?=
 =?iso-8859-1?Q?rPgphrenuYhzsVfgktrFeDXCgB/557dXvDq25WRZAfaWEjqZwIfnXyDuJD?=
 =?iso-8859-1?Q?gWL4A9tGz7T399V+ieZ0p0XTLrI1pILpNejGyKtykE1E8Y1LOss9cxv7Ip?=
 =?iso-8859-1?Q?Hfummhc6hADVnRl6cfTZzWNPxvxoAmkpgcgR4R/27QpJBBB3w5e39m2V0f?=
 =?iso-8859-1?Q?CKR4mmabn48mDCFBiSEajV4CmVK9W0QW4bFUf8EEUoWdF6H2vw59Dij6wU?=
 =?iso-8859-1?Q?JBqhNeWqfUMLkQQ/REisSGbauiH7utQUkhGtgD7QRNW97lW1YH/YTT7R7u?=
 =?iso-8859-1?Q?23iLw+2h4eFBdsGBVzVdal3Ink8OI+8uWMo2hwX37TV8ZJijrbxhMFCBrp?=
 =?iso-8859-1?Q?ihITvkHYN55Ur3gm7eVlme5Tz3XGVGle+q0icLBT1DRafD7XpH0lLn6nw5?=
 =?iso-8859-1?Q?frNlkjbl5Crh3iqf7/OU4UffAREPWXRS14fljxU9DcZsUZdy6LwruDiLpu?=
 =?iso-8859-1?Q?A1lQ6oeDtl4Y9gqpuKyW5NsLWxRil6R2QXbmWqpJktsn5X2QClUX2eKVmL?=
 =?iso-8859-1?Q?5asNEv3OqOgMJeuU5HMXEM2rxTQXkgWoOpkoh6ra5A21zSZqTai453oxpr?=
 =?iso-8859-1?Q?KNM1GBa0N2aHXwgaQXylYbGHo0dOOEeuSxrH3t1TTd5R/ee/BsfKeJgP6k?=
 =?iso-8859-1?Q?GgFFm48nWvyhpL7Olj+BlxAZxnZhjnZpzexRzO7FL0rYS9zuKofdnlz4CM?=
 =?iso-8859-1?Q?H7sublDZ74CVUgeZgzBES7FzCzeg0f14InQtooefpWKnRK5FmEy5Rq/gno?=
 =?iso-8859-1?Q?qoPS6BkEw2Mw1XXQweICzH8/NJigjYY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1becad25-a10b-4579-3744-08df0981842e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 06:06:38.4637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZUeKIkw4MUU0YWxECMaOo8ZGvc+zOGEdryexU+UHVF2Tnw3inAUBc1yCOtHg+TJwtx4Jw38KXuKHa6eCelKHclzoZCFFpnRHTakxZid5Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB9348
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 03, 2026 at 03:21:15PM +0800, Joel Stanley wrote:
> Add a MemoryRegion parameter to riscv_create_aia(), to be passed on to
> the IMSIC and APLIC helpers so a SoC can have the controllers mapped
> into its own memory container. Both callers pass system_memory, so there
> is no change in behaviour.
> 
> As the controllers don't yet take a MemoryRegion the parameter is not
> yet passed on. Changing riscv_create_aia first avoids churn in the
> intermediate commits.
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/aia.h         | 3 ++-
>  hw/riscv/aia.c         | 3 ++-
>  hw/riscv/tt_atlantis.c | 3 ++-
>  hw/riscv/virt.c        | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 3b6d7f962506..5df3292610e9 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -13,7 +13,8 @@
>  
>  uint32_t imsic_num_bits(uint32_t count);
>  
> -DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +DeviceState *riscv_create_aia(MemoryRegion *container,
> +                             bool msimode, int aia_guests,
>                               uint32_t m_imsic_stride,
>                               uint32_t s_imsic_stride,
>                               uint16_t num_sources,
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index c1a5982856c5..e11382e512da 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -24,7 +24,8 @@ uint32_t imsic_num_bits(uint32_t count)
>      return ret;
>  }
>  
> -DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +DeviceState *riscv_create_aia(MemoryRegion *container,
> +                             bool msimode, int aia_guests,
>                               uint32_t m_imsic_stride,
>                               uint32_t s_imsic_stride,
>                               uint16_t num_sources,
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 812051a11fd4..f395236d88ab 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -498,7 +498,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                              &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>  
> -    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
> +    s->irqchip = riscv_create_aia(system_memory,
> +                                  true, TT_IMSIC_GUESTS,
>                                    TT_IMSIC_STRIDE,
>                                    TT_IMSIC_STRIDE,
>                                    TT_IRQCHIP_NUM_SOURCES,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index de7b99c6a51e..6480a3f0a9c0 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -809,8 +809,9 @@ static void virt_machine_init(MachineState *machine)
>              s->irqchip[i] = virt_create_plic(s->memmap, i,
>                                               base_hartid, hart_count);
>          } else {
> +            bool msimode = s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
>              int imsic_bits = imsic_num_bits(s->aia_guests + 1);
> -            s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
> +            s->irqchip[i] = riscv_create_aia(system_memory, msimode,
>                                               s->aia_guests,
>                                               IMSIC_HART_SIZE(0),
>                                               IMSIC_HART_SIZE(imsic_bits),
> -- 
> 2.47.3
> 

