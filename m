Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0417C61DD3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09Vd-00086S-1Y; Fri, 28 Aug 2026 23:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Va-00082W-MI; Fri, 28 Aug 2026 23:13:31 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09VW-0006S8-GX; Fri, 28 Aug 2026 23:13:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX6PzDbZUj5JU+IvzvBcLD4Ha5BCcl7HYwsCuWwKUT/HRPA38jWyG0v+5V0cQNDu7fczfku/srGyBJvwhSj2Rkkaaktj2OCKP54+B0WZRlgIE+7h+U+OdYwShOBOJJNQt37vUpOdng2qY3nYz1cyglHZVeFkEjPDrdH0zzCyP8qOHnhZMnGWG3kIlrtPcBeavw4gJ7Eb+LkKrbIPRvisHRxWkvwZIruXq/Rt9v3LG2SIOzGy7ZQCMI0rZWGinbTwNJN2wjzrqILgUQS0Ct/8SmLxdCL+UdRve2SWNqRfIMKR7+z6tG8W0HURGSuSTE98ugj2k7ivy60PSD+JDma21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJCE+LHSV3sYLlhrt9BG+yk8SS47M/Stt3v2cE0fr8I=;
 b=U0XW7JLNTY1KgorPg7iJ+LIy/Gr7riLBfzUHLhq+3dPdSaefyhDHvxIi0QuVjiqvxCUyRC1IB+MBVNkGOUJBVUnDbdumGy2Sr7CaWg4pfSZV/jm+5p+ljt0SCsQ4+QiA2oFpShq/eCOjyrw2dihIkExJdEhQbtbL5rnsGb1aQ9azHtJLXtV1uXTYWF9/tj6kuM4i1sxprkQaWPKuNAvYxESOcNVVDxTcbE0ngnpTn0GJ2gQRDE6j2IxL8/yc0G8S7YNDnl/Wl4n6cgTXXS6jbsJklUWEAG7Cj0E4l0VVwP9eETl8LTvpNQ9s2yfC0TT5gm6hmTF0xgTqqp391gmMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJCE+LHSV3sYLlhrt9BG+yk8SS47M/Stt3v2cE0fr8I=;
 b=PvOYe9Ydjbftt9OhFGWeS90kz7zGgeGSkq8rQOeo+rtwpt5LRBeV72G4FH6OzW3VJm5Aueua7VFWgy1fMXGaOU5YcyDPCAZe7mqZp+mo7xQcrmw2tF74Jo0DIhsVHGxhwki+uhh4f6N9AcKMbAyIK2xnSMRwtmGI8AnPE48xvYGwM5cj8qGhPR1EhZtE/gOP/HNZl4nFqF/hmZTH0DMnaNDcuuWwZYYZ00EWAAiNwcUARwoESfE23/tkgF1PIAcGk/j8eOfoub553XHHDNYeuPy6WMy3oqTF1EX+pZDUR8AyVwnq5LEuO50uFHgzuSjkcY5BB4xp0+FsPCmkWqLpBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:13:23 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:13:23 +0000
Date: Sat, 29 Aug 2026 11:13:16 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 14/15] hw/riscv/device-common, virt.c: add
 riscv_gpex_pcie_init()
Message-ID: <apJORZiOB9j1r238@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-15-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-15-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH7P221CA0078.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::9) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: dd154c71-2f33-4451-d5fa-08df057b7bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eSxOUomaIVOIPA9V+XoTITtOBQHTvWMOtuI6i0NmVHenxksvq3+FMo0u/dSx5JIBckOUBr0V+tsuLhHqTGMDjY29hNrjMnHnfeNvw6PZG5AbPPuBLd7RiVNRi9CUyoOIOUSp/B2s1qzFv16HolpMvzY27TbNTyUpUpWc8APESO3sFZbs+zUiKnlfZQiT8OXsknd/iHltlayK6fOOk9URiCGm+QudgMiEvlSdhyV1EOw8aRJFmCB6fIGqPv3sTUfZ78nYVNXyBF4Rggpflzz43arO0SaRIhFIwQLBM1kl1yKUXVETiLn79it+akNTA1Z92WPUq4Zv1zpmTvWUKCwqVfeQsvKJ0BLdLpJlhtA8MOp24eYBCry/ozg3dB/2awQcMmJ5k0J/iZp2xc0z3lfP3h3SllGveqP8TzNuXqR4jOeKSa4Py8Zvr75Y5+2chYHXD70R31H2ZtZSV6aSTto7iB3ywDTkMdrVNalcYg5Ma/jIAn/eTyyUtqX2mgqa7d1f4vwh4KlJLRBuhbuCIzXAI+wxhYepE6GJrJbjMVUnSEBVBLmYKCE9UG47nbk4tl+7KD+L4LwUaRHYU8FIDgHazV/S3JGU4GW5SQ1Dc9xFK2+hgkZDJ3x/tgehsbnm3eCtpoWdYrLnwNeQJDm4n19eE9U04ojRdWFYfZVpsotYzZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lc6QbfMPtqZKeqV9RMQdjz+8VcOnwgUgvqD5PZ6e0OYc/MlzeWwbD+0qAX?=
 =?iso-8859-1?Q?OtalT0Hns34BaD7RezHaNxqlUlhM5dAZgSGwAvuKvZYv2BTvvMl/UXUJ5X?=
 =?iso-8859-1?Q?FzziGGWf/A0I+cp0AcZmhRn4pkUHvB1q9QgFt6786Mb69exeQhv9vimBC+?=
 =?iso-8859-1?Q?SaRid7Mn/q7bEnF4wKGH/orAPYTlUFf1qkdLEJ8WMN0IkoP9oxetVkF6YI?=
 =?iso-8859-1?Q?BQQquXpiCDJXb+xj0p4UK4KusSO3fOTWV0TZKayK1I0CCIEb2vSzFt+JvG?=
 =?iso-8859-1?Q?ReuMCVEsmyK7vjVcvkiRFP9cxMRbSa2pGk540pT1B6zQF8Ff37reIABCTE?=
 =?iso-8859-1?Q?i581fLDOGB1+2wvcm5RJ93aTvwsrfMLPDiI4P0z9dHPuBWrUG7QlPpRwRN?=
 =?iso-8859-1?Q?cRi8VMntQ/isBFVZD5xwUDaAlKiXXJYzhRcVE1gFT4y3YkYiXWwJrkCf3Z?=
 =?iso-8859-1?Q?3F7fOeXPVuHSbjW0OHptHzEaWfMWugYpTZYNVFGI1weI8uJ/QTrPDLmUdi?=
 =?iso-8859-1?Q?5czVwVuQvu6YJ70tpqLvD7wARWzn1ETzjyASs+rUg6FYaENTDOp5MUqDR5?=
 =?iso-8859-1?Q?yvqYxD6DHNZ/WTC4iL6cnR4gT5k5RoxKaL4YxsqhI7thoBSoO28gSIgNen?=
 =?iso-8859-1?Q?7Av90EptCAmiF3cdIGlRJLkJfTUsOuCl8NMsoeQ3hi6YWEB4KCgqExuOX9?=
 =?iso-8859-1?Q?hI6XFfsmAF0p2FhQvmABDm1o51UwHahaQhQWOEIKfdWMU3fkFbrl9ZOTVT?=
 =?iso-8859-1?Q?YVJQ4g8Rg0zWKYCaR1ZfcWaO6th0ecEojkXM09zEPODXFL8cIuyNrSQEh+?=
 =?iso-8859-1?Q?LJLctCkSzakoo3tLrXpj42Afq3EVoDKknZLuHGtJC2J+hYJPrNofsPXorL?=
 =?iso-8859-1?Q?CtvkHOrPRzka9AhRhOwJ4ImwBxx0dtd6ZNJRqSJACq03fIdjV5EOdg44Ke?=
 =?iso-8859-1?Q?Zf8XFoJeqyGQwfkZIdL0HjPSyNkFO4HmRqQmmfyZt0ivUvkmvJoC4nMPey?=
 =?iso-8859-1?Q?yoFUwHuImF3uOjzb8yAGVX7NDo8np91fVaTdxIt8NPg/Uo4kPTmSfA+1KA?=
 =?iso-8859-1?Q?/ELYqMe/umaT8igvpFQEs1iWz+7bYEfLLk8+En+5nwRdcinANGdMRSiDmd?=
 =?iso-8859-1?Q?7kze16y0kpJiDlSsOoy6vNX86olDgDg1fAo596kpkpraH7bosAuACfqnF4?=
 =?iso-8859-1?Q?n0Jideed0R0lYd3Id1G/HqwX3NdhjkPMd0ds1MpT0ov+tN6y6menEj1muL?=
 =?iso-8859-1?Q?sFU+42PAzIwbLcSi2YrI/ti4xSgDqJIc1iPRehW5lZwTfXYg5Xm03xkU2v?=
 =?iso-8859-1?Q?qUacRciwP6DAjKlTH2hB/3QkT7myX/QTCYAyU1YF07X5kE5SpfmvCpnuuw?=
 =?iso-8859-1?Q?5oC6PqeI1iy8YIZQgJVdymkhjSQHUNnozRcemTFLqkWjrZTu1vAtVUjQ05?=
 =?iso-8859-1?Q?ZwanB5GX7khHz6ZT4PkCH3tLFEYkl/jZrzfdPh8BqEq9AIrKjYQXN6JvI9?=
 =?iso-8859-1?Q?F55xVu7PiC9UX9sFA/JonNs7oVxTs/X/VLENx0VbFywCc5C8mdvOL9WG7g?=
 =?iso-8859-1?Q?mXykAksrapc8qvu5FlGbgeUhITj18hjole6voEZ53RL2QbDwwkbd5W1QsQ?=
 =?iso-8859-1?Q?6hnnvmkn1bBpHX5O5jYpDP1h0L/T40ubzTIfDYm6bCEw803jMcoI7X2IMH?=
 =?iso-8859-1?Q?zep3NVBlbyPJ9cMQM8OXJ9ZWAs5IpeybgRIGivDxzPKHkf/RZLO0v6Tees?=
 =?iso-8859-1?Q?nFx5HAXO3/Tqlw5FgauWLgHk14ZP5R/aIBiyh5Y/1Q8iR6Cu5TkBJTpvqG?=
 =?iso-8859-1?Q?Pa4qcyRGlvHhMyd0TEra+mNs6WX4N8c=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd154c71-2f33-4451-d5fa-08df057b7bdd
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:13:23.0105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDNpPttEvS+A1jAH7dXLmWc03PcpnT70jSmCRLsvsjcPdHswFbhm3fU8sWTivrgH3mA717aUrvPNkBWEFkp5ckgWlWuZPJlhwlVXjuOc2+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5574
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 28, 2026 at 05:39:16PM +0800, Daniel Henrique Barboza wrote:
> The GPEX_HOST initialization in 'virt' can be moved to device-common.c
> and be re-used later for other boards, namely the future
> 'riscv-server-ref' emulation.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/device-common.c         | 76 +++++++++++++++++++++++++++++++
>  hw/riscv/virt.c                  | 77 ++------------------------------
>  include/hw/riscv/device-common.h |  7 +++
>  3 files changed, 87 insertions(+), 73 deletions(-)
> 
> diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
> index a054cd7114..d1a6814f87 100644
> --- a/hw/riscv/device-common.c
> +++ b/hw/riscv/device-common.c
> @@ -15,6 +15,8 @@
>  #include "hw/core/qdev.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci-host/gpex.h"
>  #include "qapi/error.h"
>  #include "qom/object.h"
>  #include "system/address-spaces.h"
> @@ -90,3 +92,77 @@ void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
>      memory_region_add_subregion(sysmem, base,
>                              sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>  }
> +
> +DeviceState *riscv_gpex_pcie_init(MemoryRegion *sys_mem,
> +                                  DeviceState *irqchip,
> +                                  const MemMapEntry *pcie_ecam_mem,
> +                                  const MemMapEntry *pcie_mmio_mem,
> +                                  const MemMapEntry *high_pcie_mmio_mem,
> +                                  const MemMapEntry *pcie_pio_mem,
> +                                  int pcie_irq)
> +{
> +    DeviceState *dev;
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
> +    hwaddr ecam_base = pcie_ecam_mem->base;
> +    hwaddr ecam_size = pcie_ecam_mem->size;
> +    hwaddr mmio_base = pcie_mmio_mem->base;
> +    hwaddr mmio_size = pcie_mmio_mem->size;
> +    hwaddr high_mmio_base = high_pcie_mmio_mem->base;
> +    hwaddr high_mmio_size = high_pcie_mmio_mem->size;
> +    hwaddr pio_base = pcie_pio_mem->base;
> +    hwaddr pio_size = pcie_pio_mem->size;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +
> +    /* Set GPEX object properties for the virt machine */
> +    object_property_set_uint(OBJECT(dev), PCI_HOST_ECAM_BASE,
> +                            ecam_base, NULL);
> +    object_property_set_int(OBJECT(dev), PCI_HOST_ECAM_SIZE,
> +                            ecam_size, NULL);
> +    object_property_set_uint(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_BASE,
> +                             mmio_base, NULL);
> +    object_property_set_int(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_SIZE,
> +                            mmio_size, NULL);
> +    object_property_set_uint(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_BASE,
> +                             high_mmio_base, NULL);
> +    object_property_set_int(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_SIZE,
> +                            high_mmio_size, NULL);
> +    object_property_set_uint(OBJECT(dev), PCI_HOST_PIO_BASE,
> +                            pio_base, NULL);
> +    object_property_set_int(OBJECT(dev), PCI_HOST_PIO_SIZE,
> +                            pio_size, NULL);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, ecam_size);
> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
> +
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, mmio_base, mmio_size);
> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
> +
> +    /* Map high MMIO space */
> +    high_mmio_alias = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
> +                             mmio_reg, high_mmio_base, high_mmio_size);
> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
> +                                high_mmio_alias);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> +
> +    for (int i = 0; i < PCI_NUM_PINS; i++) {
> +        qemu_irq irq = qdev_get_gpio_in(irqchip, pcie_irq + i);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, pcie_irq + i);
> +    }
> +
> +    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
> +    return dev;
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 9ff5beae77..d75dec2dd2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -540,78 +540,6 @@ static void create_fdt(RISCVVirtState *s)
>      create_fdt_pmu(s);
>  }
>  
> -static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
> -                                          DeviceState *irqchip,
> -                                          RISCVVirtState *s)
> -{
> -    DeviceState *dev;
> -    MemoryRegion *ecam_alias, *ecam_reg;
> -    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
> -    hwaddr ecam_base = s->memmap[VIRT_PCIE_ECAM].base;
> -    hwaddr ecam_size = s->memmap[VIRT_PCIE_ECAM].size;
> -    hwaddr mmio_base = s->memmap[VIRT_PCIE_MMIO].base;
> -    hwaddr mmio_size = s->memmap[VIRT_PCIE_MMIO].size;
> -    hwaddr high_mmio_base = virt_high_pcie_memmap.base;
> -    hwaddr high_mmio_size = virt_high_pcie_memmap.size;
> -    hwaddr pio_base = s->memmap[VIRT_PCIE_PIO].base;
> -    hwaddr pio_size = s->memmap[VIRT_PCIE_PIO].size;
> -    qemu_irq irq;
> -    int i;
> -
> -    dev = qdev_new(TYPE_GPEX_HOST);
> -
> -    /* Set GPEX object properties for the virt machine */
> -    object_property_set_uint(OBJECT(dev), PCI_HOST_ECAM_BASE,
> -                            ecam_base, NULL);
> -    object_property_set_int(OBJECT(dev), PCI_HOST_ECAM_SIZE,
> -                            ecam_size, NULL);
> -    object_property_set_uint(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_BASE,
> -                             mmio_base, NULL);
> -    object_property_set_int(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_SIZE,
> -                            mmio_size, NULL);
> -    object_property_set_uint(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_BASE,
> -                             high_mmio_base, NULL);
> -    object_property_set_int(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_SIZE,
> -                            high_mmio_size, NULL);
> -    object_property_set_uint(OBJECT(dev), PCI_HOST_PIO_BASE,
> -                            pio_base, NULL);
> -    object_property_set_int(OBJECT(dev), PCI_HOST_PIO_SIZE,
> -                            pio_size, NULL);
> -
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -
> -    ecam_alias = g_new0(MemoryRegion, 1);
> -    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> -                             ecam_reg, 0, ecam_size);
> -    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
> -
> -    mmio_alias = g_new0(MemoryRegion, 1);
> -    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> -    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> -                             mmio_reg, mmio_base, mmio_size);
> -    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
> -
> -    /* Map high MMIO space */
> -    high_mmio_alias = g_new0(MemoryRegion, 1);
> -    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
> -                             mmio_reg, high_mmio_base, high_mmio_size);
> -    memory_region_add_subregion(get_system_memory(), high_mmio_base,
> -                                high_mmio_alias);
> -
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> -
> -    for (i = 0; i < PCI_NUM_PINS; i++) {
> -        irq = qdev_get_gpio_in(irqchip, PCIE_IRQ + i);
> -
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> -        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ + i);
> -    }
> -
> -    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
> -    return dev;
> -}
> -
>  static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>  {
>      FWCfgState *fw_cfg;
> @@ -963,7 +891,10 @@ static void virt_machine_init(MachineState *machine)
>              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>      }
>  
> -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +    riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> +                   &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_MMIO],
> +                   &virt_high_pcie_memmap, &s->memmap[VIRT_PCIE_PIO],
> +                   PCIE_IRQ);
>  
>      s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
>          &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
> diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
> index 9f8bc67a1d..572912ec36 100644
> --- a/include/hw/riscv/device-common.h
> +++ b/include/hw/riscv/device-common.h
> @@ -22,4 +22,11 @@ PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
>                                  int flash_sector_size);
>  void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
>                            MemoryRegion *sysmem, int flash_sector_size);
> +DeviceState *riscv_gpex_pcie_init(MemoryRegion *sys_mem,
> +                                  DeviceState *irqchip,
> +                                  const MemMapEntry *pcie_ecam_mem,
> +                                  const MemMapEntry *pcie_mmio_mem,
> +                                  const MemMapEntry *high_pcie_mmio_mem,
> +                                  const MemMapEntry *pcie_pio_mem,
> +                                  int pcie_irq);
>  #endif
> -- 
> 2.43.0
> 

