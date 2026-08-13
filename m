Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6AEC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 03:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuLyU-0000Pt-2M; Wed, 12 Aug 2026 23:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuLyM-0000LZ-8z; Wed, 12 Aug 2026 23:19:15 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuLyI-00054R-PC; Wed, 12 Aug 2026 23:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjuqB+ntfs/1u5LbfNYFoNczagQIUZvSQ/k5pwCWzraw7z03cMHqyZWGJHVkH7Zi5QGmO7RndqOlIecQo8L+nB3GFK1H3Cj8Os7X/uDFERXdvtkl335Y18bUEEqeBXnYm0NtUlNNQQE5LttpH9mqHf/wX9javhN9V8kPzDZv/0lagqhnt5Kx8b8qWAc8r+B+Nutbii8Fq3UHlnX4DXXbv14qJuU4IuQaBoiYbCcO7auF9qKABJ1UdQbD/0+l0JttF0XSMR7lUPPT4p1vPwp325cxsqx4TZN8ulgxMY/flWSt9VySd7CSoyOiQuyxEwZeIBMs3m1mqUSyxOXCCSj5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udraiNYJOXBOLPAPMRA3LOB9TeRjpcFe3UtGimtFwqU=;
 b=mS7EkMZcxVBlVLV75+IAKgWyUnhs8Z5VbCK8kiRZuMa7BcYY4365qGCaKUubs4wM3aO2+E4gZ3npQNQbMmoKDmf8qOCrIaqergJ02HVxToDVq5+040h4y9yf1eTHTaV6CEjyxtMNhkZAuGVATm6K9wPUKCMY4I6+tFlDyTINpoiMMILO4kVK09XzAPLRoj5KJapeUgdgvIWeAE5I+4aKsx4yZRS4az6RjFm88++YigzuHYGAR4n9la9s2SwbYWlSo++HEMcEd52ncaOb0lpneMVD2GE6i3hbNVjFynDjgTynKtUuiG2bsATM+G37fYp5LwS8ULy00ingMOJ1SwXgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udraiNYJOXBOLPAPMRA3LOB9TeRjpcFe3UtGimtFwqU=;
 b=V4dW+v2zCAi2X588/xjCCJt8RIpWQZH1SmR1UEv35q6eDR8XNP+Ghk8KXu9cZvbpnoj/N3ICrYiViO4YLAtokYRh0drObgQfDGHQd/TM0RkjuDXsfYmOdxAGO8hOo084s9Bv8tz/vsW1X7xhsos9iG0DF4S+WubJgj+33bcVUgaYv1388vrMPQx4SPWXOLuzn52bG29yeWOdYk9XdXq/7A3LqjyB07DPQmLBK/tx44+MUrLakCn94Ud/by5l420Xj+ZYEfWw14cHj6+0NlwCfk8rkncApKw1HFdgkLWUCa8rcWpYyZp1nre20QLsiF9e0ZjA1/jZQsR5UluXEQUmKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB9709.apcprd02.prod.outlook.com (2603:1096:101:338::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 03:19:07 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 03:19:07 +0000
Date: Thu, 13 Aug 2026 11:19:02 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 2/3] hw/riscv/k230: wire up the IOMUX device
Message-ID: <an03n3VEmb-Wvt0r@ChaodeMacBook-Pro.local>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
 <43e4eb64d1c29419d5803e42ad692324bde2b6c7.1784022244.git.flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e4eb64d1c29419d5803e42ad692324bde2b6c7.1784022244.git.flamboyant.h.01@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7be8f2-b785-4bae-0c32-08def8e9a270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: NjV5DQ+57q3Bach3RV2mdKar8x/eVDxI/XHySZSrjuK5OxluMtpJhZmJNZnVDZwrsNYcz6fla0ItQVw8umjVxtRZEtkdw0QSAkpgOKxRDB+3jfYZU8a5XfpodBPOGfspF1xxUIOZE+hQExoQH+ni11FJlGT+Nfo70dCe0Zmc+RL333VzONaxZIFz3sqONkdJAGkddEIZxIw1hHuegDvW+e7Hq9HTdrbAUix2wNimA8oToqZk2xQcgOCPC428Uh3uqJ26sslUftJ6BSoGAhbEDdq3I7GjrlNm8tKmO41NXNOTfjYWEATTQf4sEWgUiRCNZgQsErC9ThIZaJLVFMoKnnVbla+dRn1DsncV9zA7nb4LBYk4uF+fml2hyP0Is2FkZeb/P+JX2YD45SksfNmcRikoNwQMXxSKPwCsvBzLzfWAII4JvJgsrMndD0JjBO85LckeFpsC5i9rp+8SiJH9eUllOdkydKzPXCrTd21Y2DvvCoVukjVNrALxt0wkbXMxr0Wvgyu/dCFT8uJOzKtGxxFMiSpnwFZ1qxCKuGy4+/Z9HuUTwuWBZvbHNMFv4SDd4YzSQyknYXGluTiyn3MmV1kqEeKrO7CqFImwSnmUxB3BZwNLDAvImkF+GiIa5uND/ty/3R3Wpx4Hdsl4cTxhM+EwAPChwFnggxTSBb1MlGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+sPmCNWS/wwZ7gfau3Q4ZKLrtvffZdM+Wq/bYgPyhsA9tdO/PeKRrJ/vPmb?=
 =?us-ascii?Q?CTrNslPgv/ZeR3uJwvWqHQV6VHSBalo3vBiGtCWGswxV0Tcn+05qF52vMeNB?=
 =?us-ascii?Q?7SVkcASHKd60PqdwPRVgevfJnuuB1bAxLDQ63hjuCDP7zt5eTIRmEfdypd8s?=
 =?us-ascii?Q?WyLWVPgzBc3n68JtV9b4cZXh85jmJ2cEVQ8tkB17UjgGRwP+Q0UcppmelZH3?=
 =?us-ascii?Q?sNv8fbp6w3bp2gjCeQLX/5W98w3x+3WjG7PUJXS2/kdWQpL+c5a9NaDHQ2o2?=
 =?us-ascii?Q?wFas1pG0V19H7l5JZBJyC+25V6sf7s0bA0px9d/W5Qf9qbgqrVX+0RteuqTy?=
 =?us-ascii?Q?5ToCc/LgYJymN2D82iocyzX+yrrPLNydx07jdDJGF6CP/AfC9g25pLsdD1+2?=
 =?us-ascii?Q?gmCgLAJPTfixvrjxRIZPh87MOajwkQ6c0p55cNiVvFf9o6raCAKVgi6SpZG5?=
 =?us-ascii?Q?zQmVVlFVnFeeCt7rPZRCfgRwxNX+9j1FOR2IiDc54mYsMynfYG8CHyiLx7iJ?=
 =?us-ascii?Q?vKOP9ygTOaE5h1E4QydfvZkqJhKH1EUr0OqeiZc6ZY2OlqQuJqy2W6JD+2xd?=
 =?us-ascii?Q?TaTnTVkDFgc7Q7GL/qdY1TQtE2vSePwpuY4+1YZgA50aocdkKr16DOLcp1QH?=
 =?us-ascii?Q?lIFQlmAauW3ikPzzW0HmvNlBG5FHA3BfPrUqqnWDTTfNz6MibgH1vvlwtTIF?=
 =?us-ascii?Q?zMYSBiliT56VYQcVWGuahozzS/FBRPsifFTJwWlZDkDTKWsuiBN8l1JBrSRP?=
 =?us-ascii?Q?hJpBh7ZUEIDn/0tisJUfjPFz8IDpTobuZxchPHFIKE1NJOiq8XugkMG5shfu?=
 =?us-ascii?Q?32rscnZfZXK8MZ+JpC7xS79C8LYEjMdsF+c+aSUjEXmV4R0ThqoX0q6HmP3m?=
 =?us-ascii?Q?QrDIhcdEVlMhkVKbjkoG3MsZRHarpV3SufTF0xRwmQNSWUYbCxskF8Xhbe79?=
 =?us-ascii?Q?9LeFWcuwmgWTNaO4EHuRBqj61vqVQ7aJJSNwrZeJ405yz4p7Ee7b0+gtU+VD?=
 =?us-ascii?Q?J27YEy6C02q43JBuQDyn5nWBc2/4pTmC4jO37Xs7WPNiuDKaOrVE7qx46xSZ?=
 =?us-ascii?Q?xp8EQQeoYgrmYeAyBzHeZ9IR0QG3b3+tGXRizbxtxB8FXx5bAusb3T6TRHol?=
 =?us-ascii?Q?g70kQT9sbHfyOMbwncK7HkeLOajoSHFhjFPwG+h2SWLHkc9AaHGZYcTesGFB?=
 =?us-ascii?Q?6AemLDTWBpIatA1KMchD4D9PDLzayMh+Fxa1Vjm4sttZRJygA8DQzqNNZcDX?=
 =?us-ascii?Q?Q5rsuX+u4zdAmNaAyCQb60laCeHhro+mTwGqgHok0vdz9xcbpJfyVGzcua2l?=
 =?us-ascii?Q?bzk3iCfWHJ4+5F3RNWRBD/EHTNfmVaaptf1FL5gnxavWmOXrYtUfMBnCmXoz?=
 =?us-ascii?Q?bKnlG36pc0kCZpFZS4kNUpAXdw/TZWuPIaYtYRF1rfAoJ9DZu1mRtMCkrDRw?=
 =?us-ascii?Q?oGnopksOH838IdDma2RI2LPdHnbTCsRUEpQkxDUzbqCMGLmV53CpvuFIx0Av?=
 =?us-ascii?Q?e+PK9DjXzgxKG+WGJhw8rW+DezgW7v/Fo0cc3mZwyXVdTIR5rF8y7r0hGGD/?=
 =?us-ascii?Q?fmuYvThF715Ylov+hL4dGFXySF7iri2y47ME7wO/mNbQ6zxmb/Hs3tB25xdF?=
 =?us-ascii?Q?vlS718Fd+oEmbGaodaJUqmTM9zeHQWhlr7T+vYxVQwRL9Zbx68NCnYnNM7mO?=
 =?us-ascii?Q?GfIPc/97DDn39FF/QbHLGN2aHF93ezYOCgYJOJYsq+wELseQchB1f1+ze5Z9?=
 =?us-ascii?Q?zDqg3YARysDTS+HJN6CJtzH2WdyvTjU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7be8f2-b785-4bae-0c32-08def8e9a270
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:19:07.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkSri0d/MpPJwWmKDGYXqs7MlWSxFxQrRKpHAq2gI/damDJicMnnmzQRU9gWCQAV2ta48EGE4C/qiaTY/qtQ2IEvZvsMRaUD/dNIbDO86Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB9709
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

On Tue, Jul 14, 2026 at 06:22:01PM +0800, Kangjie Huang wrote:
> Instantiate the K230 IOMUX device and map its MMIO region at
> 0x91105000, replacing the unimplemented device covering the same SoC
> address window.
> 
> Select the model from the K230 machine configuration and document the
> newly modeled device.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  docs/system/riscv/k230.rst |  1 +
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/k230.c            | 11 ++++++++---
>  include/hw/riscv/k230.h    |  2 ++
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..b160c401fd 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
>  * Platform-Level Interrupt Controller (PLIC)
>  * 2 K230 Watchdog Timer
>  * 5 UART
> +* K230 IOMUX register block
>  
>  Boot options
>  ------------
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..4c9fc3e7ad 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>      select SERIAL_MM
>      select UNIMP
>      select K230_WDT
> +    select K230_IOMUX
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..430c1646b5 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
>      object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>      object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>      object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-iomux", &s->iomux, TYPE_K230_IOMUX);
>  
>      qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>      qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -198,6 +199,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    /* IOMUX */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->iomux), errp)) {
> +        return;
> +    }
> +
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
> @@ -206,6 +212,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
>  
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->iomux), 0, memmap[K230_DEV_IOMUX].base);
> +
>      /* unimplemented devices */
>      create_unimplemented_device("kpu.l2-cache",
>                                  memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -280,9 +288,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
>                                  memmap[K230_DEV_MAILBOX].size);
>  
> -    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
> -                                memmap[K230_DEV_IOMUX].size);
> -
>      create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
>                                  memmap[K230_DEV_TIMER].size);
>  
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..223e76b420 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/watchdog/k230_wdt.h"
> +#include "hw/misc/k230_iomux.h"
>  
>  #define C908_CPU_HARTID   (0)
>  
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>      RISCVHartArrayState c908_cpu; /* Small core */
>  
>      K230WdtState wdt[2];
> +    K230IomuxState iomux;
>      MemoryRegion sram;
>      MemoryRegion bootrom;
>  
> -- 
> 2.43.0
> 

