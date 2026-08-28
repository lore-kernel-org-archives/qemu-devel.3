Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46253C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzmln-0003mO-BZ; Thu, 27 Aug 2026 22:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmlk-0003lj-Oh; Thu, 27 Aug 2026 22:56:41 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmli-0007zA-WD; Thu, 27 Aug 2026 22:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFAbsu74+iqxB5Iim2O4ZiwQ1QotZeqb4OBNWzQXMBigH/4FRHXzjIXeo57nhu10M0Q5E8GW1ist9wl7akD7l3oEll1KFU4hqZ3NmK6t9OmPgBG8EoqHSxT0ZYnYhPl6kF3QXdxZM3xQaRv5kl3C2YLACffUSVGJRGhnpQtKWq/AquPIheqTfW63oB56dRtUtN4/UwP4cDhaGLwSB4ybUspZBybyMzDjvEjySJA8fHT5g2MTYd+10DvWusvxmLOaAGk+riG1eNjs19ozKdS9Nvkrm32YgvMR0Ymb2uYfdIirUdMlfpCk/tz6J8xxb+OLTQ822lhORUOoUwD2uuNL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfIIlqbuSfoPhyoJrasasrgfIvopMzGiNl+NLqWgqAk=;
 b=y28V2aKi2wdGRDydTEhBTbBbNh0u5+12fgnjaUI5DGQKglkkV7U2GG/Mjv0fEcUxj9cm3aCdr+RHn3fIVSrgFsustj/GYD4mXnZMxUPqt9utzMvgS3psRv1et8wiH+UxtSYXLtyQarBlrGJ+x5akE4pT9AEeZE1aaoZE7CevE2yfWzO7dnRfsIh6bB11gD4tocVdXVA2YTLFb2TWEZtoZqFfJU+FbUqWb6cbNn2WNjDWBAt53H5XoQxpu6qPik91+RVmaEfKdtgQcztZBnHwajiSYcIW7qFvhHUndWR5CTvHW0Sk/6Ub+OgxEYKdB8MJJpxNn3K5gg07C9iNjxgeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfIIlqbuSfoPhyoJrasasrgfIvopMzGiNl+NLqWgqAk=;
 b=iBc7S9/egqoFLtOH45mHPiBLf8LkNpk0KYuFTCpIkgDGEM+8N47sk0bMK5MN+7X8iL4HdrQCq+ZDCs56ZPudlGAZlc/6KRZcZXNROx6h6DFqDElhLDvG9Jsxff+3h2A2vmw/O8VA3CRbAn1HU7Te3eCLjtPqMhtWKlh1Ii4NdReeDVr79qzlSpR0PFvsxFHVKWp1byHEOhV6MxFdA+rd572uVjRc2Il2TQaBApfsod+9eR+kUwMwv35eKMwHGbJZ9GYL9isIaan2cwLI8COgWY+JY3iyQp43YDvn5H5V3EcJUNNBkGhtLmDY4Zm/2m7gp1TywRIRumrTmEcgWFSpyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB5578.apcprd02.prod.outlook.com (2603:1096:4:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:56:31 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:56:30 +0000
Date: Fri, 28 Aug 2026 10:56:25 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v4 03/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_syscon()
Message-ID: <apD4zeFlT3mLdIOG@ChaodeMacBook-Pro.local>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-4-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827222608.329788-4-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH8P220CA0038.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::21) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: f694ee2d-e779-48db-6815-08df04aff654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: voUjz/C+fCn9Jl6JLAJ56HHlUs8RVuSl6rduZvFhfexaaJCt6EHoOLnp52M+gWNr51vJfBdmShhWC0/MSDb9KureBunmDuqrt7ZB3vMZqsYdeb6uZO4g2aqqqCoiiUnL4P7ARKl2s7vP4tGOZGHy/g85nMwhn+TG9nsub9A8L02tKx+ea6BFQHjhaturQtqiNv4Ih1G0KtZ2zhjhUhjQhFmsykrx+I4b6k+Bww0zOUk7nL+R0fnjiNFs7zDbEaYq4wzZhMNLaiW8fMwNjxeY4D1cHEFjyZU12a6XuiSIOSDOYj6QcOpkT1tmHJSnfev/GmRbiDKa/mXb+1tSAnhYMI01eK9Cxl4yInGZC0rma/wG8DYHdPezBvgIwNN/6d1kMQcr7QRwAVxlwEQbG55BrmC8e+SJ4OMiA4PHGMFPHqirEHJUpcOiaUZra15/zeN41w9HL1yl8LK2yc850ZhWCfJNFZ/UoK+pEqHjhRFNEUC1/z37D/+4Alcjc79BmETQDOD+Hqs6KAhiyyutQXkgFWU64vUprwyVxs5ZjGOr1sMvgoXQQzWebjPhu4iUuGnxmTlHI3Kjx5Dwv0xBQVgjbn8LXLcRHwJmeX7yR1J1lXqlIQX6FA6WhZCAjLYKyP7yA9u0LnloFqgXVmX9C9wHmtf9wbBfHWhi3jcMm5M61rM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2ZW6dB7rVwZWiLqNzaDNGj+krJfZlC/3VHZwIJt0AO/Xj4NZJLzcJqSDUP?=
 =?iso-8859-1?Q?5kHtYL79dPYhXE59hEJubZtKZaTzWGr7umQdWYaR7RGvDWzl0Q0azrWAuG?=
 =?iso-8859-1?Q?q0du3MvPY+JuZgz8jXDwyCMuod+sy2jEKS+0Y4XsME6n+j4f2CcreRwU6G?=
 =?iso-8859-1?Q?Ucm7drJy2u9btaYKSd/Qn44r72pJjnIK2UR1sF8v/VaORN2ga7H1UloOMz?=
 =?iso-8859-1?Q?DvcgduJT5uI9E+N+wZOtaPYZQ23bFhSG9gWVrJFCgFOJnGVesqFWGJmy5X?=
 =?iso-8859-1?Q?YANLvKd8xqZJcyOVy2PoVVco7iuY5XeWKIpjzwVoq7QVnOzfj7AgXnS0K9?=
 =?iso-8859-1?Q?BiwjAeHpbjna4srGafUb8cXP+Y8LKKupiHXKU+ncE7d1pMkPjp2aKiEvH9?=
 =?iso-8859-1?Q?AnbTQFOnbCjPne+bcU56Y729M4sXbzbInIqCwecjq+CoayJj12Z4KDHa92?=
 =?iso-8859-1?Q?g4GDCikurdQcOQG+RDe6ZQeRDcOeC+WzDxE29ucThv3RpEsukFVB0SfOX/?=
 =?iso-8859-1?Q?RM/orORNq+aJL843kjBQ9HtI/vncpZq3QZdC4MvMnIyUUo9jz+K09Ycc1b?=
 =?iso-8859-1?Q?JZg6IbJuT4yqp0yUbmkdrIBXbRkka4d3bJq3m60rUjegRJtJQh4CGQCTYo?=
 =?iso-8859-1?Q?DCEt2LQvYFJ6uCKVFFnp7nd9bpNzDYaDsris8kBCy1eafPuz/0CwviAYPA?=
 =?iso-8859-1?Q?7HLiczRuR7s5GP0vFOH/u+VGXS7XAUsGMxrCmCzFlSH289wuq/6Hltfsuj?=
 =?iso-8859-1?Q?gOnqwXtovnznHLCpMivkJDG7egMPummB5CfInZEZreZpofh7ohdfEzpalT?=
 =?iso-8859-1?Q?Xqh052v/ju44AdUrKrgXW4V/jtP6Ar4QR2pb8Vcdfh7hontdIdooIZGRAP?=
 =?iso-8859-1?Q?CxVTsnuI4sC+z6Bpi6jVuLlywJPZ04S3+c3I7ja0l5NdBI6EWnCyt/rpu7?=
 =?iso-8859-1?Q?PV1yPBYmA/TiXQTJA+xpH5uV7hterYVnibi64qiKyAJt4mCxsmy2R4zVQU?=
 =?iso-8859-1?Q?2PvBe7c9/AW1okOLr+rCohRYUFDqt8Mpx5PtifEEQFTclzNn0st0H8NmAA?=
 =?iso-8859-1?Q?ZY63ippfappeuj8ofpLeX0DlriShVoMomu2jPKY7Yydby9EUE+m5RbMAyo?=
 =?iso-8859-1?Q?cdEYsVM8kWP9SjBUnUpQvRLcrfhtJJFgwmSx4hHGXJgU9YeU4UiMw71t0M?=
 =?iso-8859-1?Q?F1Tninn4YTSXiGc4cbE3cP/Um5vghHSJji7dfD0velOA8a4WxETTaUvjzp?=
 =?iso-8859-1?Q?NzX4cgcH3awxzw4o64iczRSVAiE8ipJm14F0uiiid388bxgJPAJaVRGIo9?=
 =?iso-8859-1?Q?nW0llp+5HEh+aPuWhwjnn+m8HiAT1C55o4yZJwW/xZtWWwbwcQSreXco9R?=
 =?iso-8859-1?Q?iJqztUDrGLezLiFVp1Zq7RlOTICSGMzzUDIa0Dw9H9RP3eeu3DLqsW8NOP?=
 =?iso-8859-1?Q?e7Iqx8vXJNX7r6wWmqXRUhrMozC3B0Teb1EWiY29tQQRKIt/GSCGTVYHcH?=
 =?iso-8859-1?Q?I7o0S/NeJWoePdkf/X2VcgWyHM4/FHSgB+ejuIPzmUGq8XA6GVWWDF0WDQ?=
 =?iso-8859-1?Q?6BZSeaUCGS9Yrs7UVHj1+en5R37yAltgdOCfEG0tzAiV/zsNjUMRKDQTak?=
 =?iso-8859-1?Q?5lOuDNNEAxYCP+GeZksVbBoeSw/WD1gHpHl06HIX+Y5Li6GGW7iIBBmJBk?=
 =?iso-8859-1?Q?cGFwCoqtNk6u5WhxrbFT1YCC9CsF+rtriqLYg/zSFxWCmeKq3sSlHqrpw9?=
 =?iso-8859-1?Q?sDDOHVPkWvYtEX2x9Ayhv/UTvIvL9r9d95Ec1oGnbLV9IJD0Wds95yDPZg?=
 =?iso-8859-1?Q?6xPFQJmYHi1ELg+PhfsC0aDHFmvAxOU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f694ee2d-e779-48db-6815-08df04aff654
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:56:30.8923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7c0Avtebt+/u6yAEJOlrsbVJmqLnA4f0/jNbSYEeqOHd1aMqMAq0jQPwK4gh54zrcIg7WVClATc3FWytf1sJRxJCYf0ZaI9MUaGA4OIc76k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5578
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

On Thu, Aug 27, 2026 at 07:25:56PM +0800, Daniel Henrique Barboza wrote:
> The soon to be added riscv-server-ref board will declare a syscon FDT
> similar to what the 'virt' board already does.
> 
> It won't have a 'sifive,test0' and 'sifive,test1' compat string though,
> hence we'll add a flag to enable/disable these additional properties.
> 
> The FDT is slightly changed: the subnode is now named 'soc/syscon' instead
> of 'soc/test' to be compatible with the latest device-tree docs.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 54 +++++++++++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 46 +++--------------------------
>  include/hw/riscv/fdt-common.h |  4 +++
>  3 files changed, 62 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 6fcc1ce21f..eac5ca9322 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -295,3 +295,57 @@ void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
>                                   2, flashbase + flashsize, 2, flashsize);
>      qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
>  }
> +
> +/*
> + * @sifive_test_compat is used to create a FDT that declares
> + * compat with "sifive,test1" and "sifive,test0".  This happens
> + * to be the case for the 'virt' machine that also creates a
> + * 'sifive_test' syscon device.
> + */
> +void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
> +                             hwaddr addr, hwaddr size,
> +                             uint32_t reboot, uint32_t poweroff,
> +                             bool sifive_test_compat)
> +{
> +    uint32_t syscon_phandle;
> +    char *name;
> +
> +    name = g_strdup_printf("/soc/syscon@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(fdt, name);
> +
> +    if (sifive_test_compat) {
> +        static const char * const compat[3] = {
> +            "sifive,test1", "sifive,test0", "syscon"
> +        };
> +
> +        qemu_fdt_setprop_string_array(fdt, name, "compatible",
> +                                      (char **)&compat, ARRAY_SIZE(compat));
> +    } else {
> +        qemu_fdt_setprop_string(fdt, name, "compatible", "syscon");
> +    }
> +
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, addr,
> +                                 2, size);
> +
> +    syscon_phandle = next_phandle ? (*next_phandle)++ : qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", syscon_phandle);
> +
> +    g_free(name);
> +
> +    name = g_strdup_printf("/reboot");
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-reboot");
> +    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
> +    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, name, "value", reboot);
> +    g_free(name);
> +
> +    name = g_strdup_printf("/poweroff");
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-poweroff");
> +    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
> +    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
> +    g_free(name);
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e48337dfd9..ab6c53c78a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -768,47 +768,6 @@ static void create_fdt_pcie(RISCVVirtState *s,
>      create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
>  }
>  
> -static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
> -{
> -    char *name;
> -    uint32_t test_phandle;
> -    MachineState *ms = MACHINE(s);
> -
> -    test_phandle = (*phandle)++;
> -    name = g_strdup_printf("/soc/test@%"HWADDR_PRIx,
> -                           s->memmap[VIRT_TEST].base);
> -    qemu_fdt_add_subnode(ms->fdt, name);
> -    {
> -        static const char * const compat[3] = {
> -            "sifive,test1", "sifive,test0", "syscon"
> -        };
> -        qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
> -                                      (char **)&compat, ARRAY_SIZE(compat));
> -    }
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -                                 2, s->memmap[VIRT_TEST].base,
> -                                 2, s->memmap[VIRT_TEST].size);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
> -    test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
> -    g_free(name);
> -
> -    name = g_strdup_printf("/reboot");
> -    qemu_fdt_add_subnode(ms->fdt, name);
> -    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
> -    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_RESET);
> -    g_free(name);
> -
> -    name = g_strdup_printf("/poweroff");
> -    qemu_fdt_add_subnode(ms->fdt, name);
> -    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
> -    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_PASS);
> -    g_free(name);
> -}
> -
>  static void create_fdt_uart(RISCVVirtState *s,
>                              uint32_t irq_mmio_phandle, int memId, int irqNo)
>  {
> @@ -994,7 +953,10 @@ static void finalize_fdt(RISCVVirtState *s)
>      create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
>                      iommu_sys_phandle);
>  
> -    create_fdt_reset(s, &phandle);
> +    riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
> +                            s->memmap[VIRT_TEST].base,
> +                            s->memmap[VIRT_TEST].size,
> +                            FINISHER_RESET, FINISHER_PASS, true);
>  
>      create_fdt_uarts(s, irq_mmio_phandle);
>  
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index b422da6aef..e377682b32 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -39,4 +39,8 @@ void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
>                             bool numa_enabled, int socket);
>  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>  void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
> +void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
> +                             hwaddr addr, hwaddr size,
> +                             uint32_t reboot, uint32_t poweroff,
> +                             bool sifive_test_compat);
>  #endif
> -- 
> 2.43.0
> 

