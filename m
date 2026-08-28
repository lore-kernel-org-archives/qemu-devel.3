Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C88CC61DC4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzmn6-0004Gy-Ec; Thu, 27 Aug 2026 22:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmn5-0004Ga-0u; Thu, 27 Aug 2026 22:58:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmn3-00087b-5j; Thu, 27 Aug 2026 22:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9qcC71uDWysg8pW7mW8l4QFBx2Q+CSwGII6vuPfQ8QEsvL8Ncx8qeRfd0aDQxkWfAc6zn2yEkWLq4Wh00pCuDgGApOTLilZenpye3nGcFr0N+5r3uMfG+aIjDjxe3ulau2gtpL/3oA2SWUplurpIWRIiB9eYazVkqJZAQzpIfdQbj/wfaW1/rt5cEgMSBlbock20lEqnpTcc/7AhnLunIODtdeHbyhPRHIEE2k0HXQvCOqVPC9+FiVc0auwbCHMeJb9PmsuPvJBp9VM8oZWltqizgLPpkHQ12aZGnkEivNp3uxXgCsvfOfmnD27jORvvEjQvSVxin+tOMgOewEZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXQsuBRLFK6EvuiSpr+Pmk4HhU7lDjeW2J2Es7E4yc4=;
 b=wukthAge35eIlD1zfRW61qinoOlkJiFWsueI2DF6vOAQejS06ZU4uZIe+JB8BG7tMKx4pGX11Z7gHU6/E0EO/pX27Jc8M6et3A19LWIU3xggnIkZqmF0s69EQWhsD7YSctwx9C5GMORPzA+uqYQRZn20U9oCqokXmNWTI3h0IYqdJE0XtJ+di+N0aPastKyz7LhKDx1mPhEgSUzB+oAjUJP9EA0q6f1ifGHk9IDwCtuwcFKbSqr3BgFNb9syGouHOwpJuWGOOLaTR2Czg+yGrzwjhD564Gpdfp6H1TdX2WwObe9UQ6mbOc7kOqh/x06/ZQkTT3kdcZeEhrB/hloQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXQsuBRLFK6EvuiSpr+Pmk4HhU7lDjeW2J2Es7E4yc4=;
 b=JffzQU2j8ecMXZT5QphJQEtd9PY7Y/PXxkDDkDMa5uGE5OJLQwUmZu+pzEzj+c+SjrRSjuwrgG7bFPcbdXM8fPLSo9LLaNqUVPd9W9D3+JSSxRIL2b4OQdS67yRMcDTOCkgnUZAfDW0FZ/17HZIwrmlCkGjSXaCE8f48/GBFH14cK296aNRMlqxgTeryFSN1hYivk3STqWBfEw3Fio1y2i+L6XMJV9QUof/8Ti74uZXMIp8appkxmOizWMVRZfUZIfoqwi60Hdymftkc2yKFR9gWyTotBepLsZpUShhJfF9S1QDP7fjORKIxNDzxQOvnKS+64Apw1NkVscfFsAdTJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB5578.apcprd02.prod.outlook.com (2603:1096:4:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:57:56 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:57:56 +0000
Date: Fri, 28 Aug 2026 10:57:51 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v4 04/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_riscv_iommu_sys()
Message-ID: <apD5JQH3Q2L4WJ27@ChaodeMacBook-Pro.local>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-5-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827222608.329788-5-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH3PEPF000040A1.namprd05.prod.outlook.com
 (2603:10b6:518:1::52) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e12f6d-c8e7-4322-ef96-08df04b0294a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VbzjUUpBabld7S3QQ9LaOsqQugBhpfkrMYSNEDgc4r6TnEWvSBFaDh9vwNlyoQYAsOpdmV6RIS+mZVgHvib/dGxUjVkSbQmskwd4hxvGoJ9kzhuFuXBKPRm8wbFnqxQgBEtI/JGpQUEWDEGrSsgJBWL9vbb4jykwtx5+h3tZ16xP6+v0QMimvHwB3uaXbceB47eHYPplCC/l1kLMBR37yszE+K2CMS3VZJVp+qGD9oVNOFoCr7ky3Szt5o06mt+GskoRINkVjXrEyHvUROP7nF/9beJYGZ+RAGGAPhQTUPCLwbmoL+TuKYYc8+y9pAK+0d8+HjgxchZUJjor60628ZiRW2J5zjDe8j5j3a+PYQN29VATAzm+G4XdKLVBnvPhZ1/rv1NfPZK9gGvlWb4BbtmVie1AGjdif6ofrOrZNBqrRKTsAiC8qHe4dtUqbCpBmba1VIakR5ZFEBj48dp/0J+YTtIqKRHtHLmuYYkGmRJBf/tcAgLSrEWLfO1U9YQFnQi6DZIXeX4sPbQyktAq5nd9KVMysVAfdGwyL2iBv22n4lkTmzNWfEvgPl2+xn84E/r3WflvifUbwYXY6MYfNhV8/9V+KxHbcRUdoYr7el23ZVkwoo8ssULtzQ4/2UEKn8diMh8fyVnXlFuju/I2n10FWJ1e8CrCna4VBa+A9tI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?12cw5GnWk0K8d7+cgJOmxoi9+sAM5TV4OiLNqUI2NIQQlgEQ9ibAma//Bd?=
 =?iso-8859-1?Q?bsTw9Oizp2SdZWQPGh/pNwtYTzdX+CYGAyVOMuTo5qgGR9YU3s5DI03JIp?=
 =?iso-8859-1?Q?OGxNk0Kt/k110AI8tFEntwqtkmqQn/tVGfDIIpWud38u3H+/qh7WoEV/0B?=
 =?iso-8859-1?Q?lVPAbuGKImRJdDENnjDS5updp/mmhBqcJYHC3+xFQGpeRRqH4og+mI519u?=
 =?iso-8859-1?Q?K3K74JeOj+zV/0v5IMpZQ4nJtDpAAq3Ctq7Csj53aS30EWAhUrC3laCD3W?=
 =?iso-8859-1?Q?Wgy8tSffOFiM4MiJr7pe5rvXqCH2xnM6SP1FRsrfdjr8hRc1x5nT0+thl5?=
 =?iso-8859-1?Q?40YjmYSpvZwF7GLybLIPurVNy60NnTmPLhpJ1eKpfVstrl2e+rCO4AdpUb?=
 =?iso-8859-1?Q?fvakb9cqg6nYCwUmYZ1SLN/GSQ8tddZOs3+mpmrVbwE2WaVKqms4ViPpvF?=
 =?iso-8859-1?Q?nyyFQyo3TY4ua/QC7VnVw/RyG68huasMkpJ6nvWPdtZuxW5udQzweohJ4c?=
 =?iso-8859-1?Q?8PuXYvspJqLd1JEV2fDrDfCHbjtmXDCVhylqCZ9O2us6oAgQQs2RlxIn5M?=
 =?iso-8859-1?Q?zhATQuMQm7HfpN/Xmk6zND3U/J5OPlF7nRusPnf+nCIgnpUxrbKVKBbm5X?=
 =?iso-8859-1?Q?NTV89ViRypng6czyQjUWWLRx4bWLN1cjQLdk4qKV8Pxw4VUgg3dvbXXZQx?=
 =?iso-8859-1?Q?575S6FOxS9H7ygHfePLDpgKTStlAW8Nni2exNto+hRmmN9E1gkFItW6AjJ?=
 =?iso-8859-1?Q?nPIU9mcAIz44cUPP5KwRD0Ip9midLdY0Mbnhu02q9yB+Ak4ei84/F8DY+Q?=
 =?iso-8859-1?Q?B7kt6YgAtMW6OhRLFDow9F1xIgk+VoRAX4Y8iME/yv9ucor+Ce1viiMeGY?=
 =?iso-8859-1?Q?pAnohl1KSuh/Ps/sT3g7vdjNxeXlq+ltY8zFo5kk5BVllH5cgGpG1WTDBS?=
 =?iso-8859-1?Q?5yfjmhxy5/zb/Kri2fHiaRhhHjqYel2NUZsDimTOeTd+d19wxFV5MBs1eZ?=
 =?iso-8859-1?Q?YeymINGsB7pTOkAFxgpCD32Lhem74quaihw+AVHDPgkBQH4kZXIrWwOEES?=
 =?iso-8859-1?Q?+aNL9097nDU3zNPNwx9fQ57zTuiR+0XUuoJhi6Q+AP/tnEn+qhvfoksufO?=
 =?iso-8859-1?Q?xsFsbXpzMe3OgSqFX6UInVuAL49az4hkIRGcPWaba3x1YcxH4nCJEhsUhY?=
 =?iso-8859-1?Q?buOB9NrZ78b1yGyUf1tDgC7+OXTz6pR+Q9F7j48bZEPF6Ggr83mXWicg2s?=
 =?iso-8859-1?Q?CBIjySvm0E8VBWfgtRuLFbvjlIDAQzZ+Q2SLpLNbkey7WqyZZ/lOE8heQ3?=
 =?iso-8859-1?Q?i78NCIRZaXpRYtgt13G1B+fgM24l8BzZ44DWBgpcV4x2muA/q5pSdemb1L?=
 =?iso-8859-1?Q?NNdOmEX1ZOmY+Nco3NiR3CMz6pSq4U9YvN2PCbAJVMT0+s0JyXfwj4WvUd?=
 =?iso-8859-1?Q?HlZt/Oi421F8dEQHBFNsIXamUCEhl86fP3vz0+czhxgTtOkEMGDbao5r9i?=
 =?iso-8859-1?Q?q/WR3H4t8QkVS2yOYHNSsc/Z/1EWLji0UCApt5I6SHg4zqpc81oShZbrvK?=
 =?iso-8859-1?Q?u3eGgFfCSpolCaUclM+spHRbwVsz2eD9fOAXGGydxL1/zImKR1g/OcpW0p?=
 =?iso-8859-1?Q?w5TLK2eXnOeYCtjonK1hOP8FMkiPFpZuZtGjjRaJAFphBOGignThnQPdVq?=
 =?iso-8859-1?Q?p9p6j/wHPjgZgtdss4A1PgRdNWel65udCDwvkDqLMBIoKrZX1OdVneOxOE?=
 =?iso-8859-1?Q?my3m/cuKFkdCdBiJnnPAakE+7XZ7BUEyhde7AiaX/eFLGaN97xwJJWmYcO?=
 =?iso-8859-1?Q?lZxZILpl/Yta9MvAD6eyZToSM/zpioc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e12f6d-c8e7-4322-ef96-08df04b0294a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:57:56.4966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CT6FCLs42Q0AsQFXoNx0QTMzwy16f1XZf1iHQgny40R9oGXvHs/iK+yRzUgRyddGESIlIKdIWEAB83YdR9O/JP/FewQXjEYa8rSIe/0th/E=
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

On Thu, Aug 27, 2026 at 07:25:57PM +0800, Daniel Henrique Barboza wrote:
> Both the 'virt' board and the future 'riscv-server-ref' boards uses an
> iommu-sys device that is declared in the DT.  Create a helper to
> encapsulate the logic and avoid copy/pasting stuff between boards.
> 
> The helper will return the iommu phandle value instead of returning void
> and writing the used phandle in an extra argument.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 35 ++++++++++++++++++++++++
>  hw/riscv/virt.c               | 50 ++++++-----------------------------
>  include/hw/riscv/fdt-common.h |  5 ++++
>  3 files changed, 48 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index eac5ca9322..88589330fb 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -13,6 +13,8 @@
>  #include "hw/core/boards.h"
>  #include "hw/riscv/fdt-common.h"
>  #include "target/riscv/cpu_bits.h"
> +#include "hw/riscv/riscv-iommu-bits.h"
> +#include "hw/riscv/iommu.h"
>  
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size)
> @@ -349,3 +351,36 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
>      qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
>      g_free(name);
>  }
> +
> +uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
> +                                          uint32_t *next_phandle,
> +                                          uint32_t irq_chip,
> +                                          uint32_t msi_phandle,
> +                                          uint32_t iommu_sys_irq)
> +{
> +    const char comp[] = "riscv,iommu";
> +    g_autofree char *iommu_node = NULL;
> +    uint32_t iommu_phandle;
> +
> +    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(fdt, iommu_node);
> +
> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> +
> +    iommu_phandle = next_phandle ? (*next_phandle)++ : qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> +
> +    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
> +
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
> +        iommu_sys_irq + RISCV_IOMMU_INTR_CQ, FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_sys_irq + RISCV_IOMMU_INTR_FQ, FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_sys_irq + RISCV_IOMMU_INTR_PM, FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_sys_irq + RISCV_IOMMU_INTR_PQ, FDT_IRQ_TYPE_EDGE_LOW);
> +
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
> +
> +    return iommu_phandle;
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ab6c53c78a..8a165f4d9e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -869,46 +869,6 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
>                             bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
>  }
>  
> -static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
> -                                 uint32_t msi_phandle,
> -                                 uint32_t *iommu_sys_phandle)
> -{
> -    const char comp[] = "riscv,iommu";
> -    void *fdt = MACHINE(s)->fdt;
> -    uint32_t iommu_phandle;
> -    g_autofree char *iommu_node = NULL;
> -    hwaddr addr = s->memmap[VIRT_IOMMU_SYS].base;
> -    hwaddr size = s->memmap[VIRT_IOMMU_SYS].size;
> -    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
> -        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
> -        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
> -        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
> -        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
> -    };
> -
> -    iommu_node = g_strdup_printf("/soc/iommu@%x",
> -                               (unsigned int) s->memmap[VIRT_IOMMU_SYS].base);
> -    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
> -    qemu_fdt_add_subnode(fdt, iommu_node);
> -
> -    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> -    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> -    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> -
> -    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
> -    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
> -
> -    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
> -        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
> -        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
> -        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
> -        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
> -
> -    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
> -
> -    *iommu_sys_phandle = iommu_phandle;
> -}
> -
>  static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
>  {
>      const char comp[] = "riscv,pci-iommu";
> @@ -947,8 +907,14 @@ static void finalize_fdt(RISCVVirtState *s)
>      create_fdt_virtio(s, irq_virtio_phandle);
>  
>      if (virt_is_iommu_sys_enabled(s)) {
> -        create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
> -                             &iommu_sys_phandle);
> +        iommu_sys_phandle =
> +            riscv_create_fdt_riscv_iommu_sys(MACHINE(s)->fdt,
> +                                             s->memmap[VIRT_IOMMU_SYS].base,
> +                                             s->memmap[VIRT_IOMMU_SYS].size,
> +                                             &phandle,
> +                                             irq_mmio_phandle,
> +                                             msi_pcie_phandle,
> +                                             IOMMU_SYS_IRQ);
>      }
>      create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
>                      iommu_sys_phandle);
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index e377682b32..65711468b8 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -43,4 +43,9 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
>                               hwaddr addr, hwaddr size,
>                               uint32_t reboot, uint32_t poweroff,
>                               bool sifive_test_compat);
> +uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
> +                                          uint32_t *next_phandle,
> +                                          uint32_t irq_chip,
> +                                          uint32_t msi_phandle,
> +                                          uint32_t iommu_sys_irq);
>  #endif
> -- 
> 2.43.0
> 

