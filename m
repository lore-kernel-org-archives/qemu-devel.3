Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B71C61DD9
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09Qq-0004GB-3v; Fri, 28 Aug 2026 23:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Ql-0004FX-Mr; Fri, 28 Aug 2026 23:08:33 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Qi-0005l9-Vp; Fri, 28 Aug 2026 23:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbsdm33s/Po6NolxCDdYo6sd98dOmPtZ3Rpe+6H/8cDWKY/nHdNu4a0z1BV1VRV7IBwzNMG2xsDQnk1C69EIAYbMxkJrnJNU1S1q7I5ZabXkAU/XYnHETZvuOoNUJDhKXPSxUSd35lUyUIas53xNouWBUAu+w+zPW7ryMfIN0SimfsI0bY8sWXtOTy/6OU+pNBPhKjID/q6EWZymenLjVMpEdaU4A1HYk2KRhsHpf4lbooG0O8KzVwsZP0fJikgpJX35N5Ejueaweq+i3DAoMbR+za8t8Ljx1Ka/Xp6VQ+ClZbnUXzqoSGLYQMEY1JXNApc+rQiIx2shCtE8wELq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLp780rIOmvclHWdmQJv3OUsSnRhIuRdWTOX+I1FpUw=;
 b=xh/ubSN5jykk04sjMgRGYkCWzn/YLlA1m8/0TuiSIBPwYRdjOv8rCKR/VZxUVOTAwgU/8ctFXThTPAciOqGA1eBHUm3tQVxTaXjmRcJzCyUHqiki+53I610RMLNdk2bP4xLOBqNKCbM9jr1bB8mf/gbiKly7FYHBB4tScflpQAQluFOyA6QigckZtZHzKtr1rdMWg6W9/6Qy4wqizpx8l0J0lDEjpkS1h7m2RnuHQLIAErSF1xojXk/0n+sMVydBI9AsoLPgtnpcaqK5RXOVeOZoo0oM51+uuVF+WqcugvJaovj2aOA0WorQMDj5hhNRzVdwatiULQdVL0BH98ao/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLp780rIOmvclHWdmQJv3OUsSnRhIuRdWTOX+I1FpUw=;
 b=qdFwjlqRKAwtpR3k+lW1e95pHWHwOHzDwo5D3rfBX0YhSzWJ13Bg5M1AC8ab+Gd6DagdReJZgcuv9vjGtnWvYMP2XLaFRRILz48poV0iAsujh0db8U83wz9/jkt8GnazhjI6sxJnBYUQa5NHDzIOGRPI0wfZ2MR2AMBgWS8Op6xUj5D4LjP1BM7fVaOb1JHphBQnFNMDJJDW8a0CDRQq/teq/Y0paWJhQt+zwud8mZa4wiyeW9yF68CRIVbpt3VjJ1+ZK3OMZwDz3q3E7n+9wYBdzV+lYkwZ1SNCCYsWXJ1MK5RC5z+VGqlPqqLnlKp6OLcjhgEi7OK/ntN2LMBy7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:08:18 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:08:18 +0000
Date: Sat, 29 Aug 2026 11:08:13 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 05/15] hw/riscv/fdt_common, virt.c: add
 riscv_create_fdt_pcie()
Message-ID: <apJNESqYK3PiNVCi@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-6-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-6-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::9) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: a42bb8a0-64ac-4d70-b059-08df057ac637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NZy8SsZfTLir2zBLD88m6gVocaka+muyhk837jJMGFn4kPzUadfbAP1ilxB9X67huD29opbXE0xidZKn0lbFPz/TPto1CG7mHU8al98WLN26B9ouV8X1JTSpiY/0LvPpHCHrXhlaD8C4nI81TR8jpg6EJ289WQFKJkDgBIj/x4Pt7z7bJSnbqogYrqU7YsKWN4UZabuQ7rLV2/dKl5Nl25ser+rIH/kFpGQPQiiJWS9OAcXRoUhpV/12NcgO6RNEtul0VdkJwbusnDFTdhrMBRNDlOz+MqKe64B/bqP82pggqX5WDBQTs8XQ1E8rI/YUmMalHL/MBZibtj787/bZJJueShREFj1e7owCWG/A7xJhSE0T7S78oYJbQmbvmfq3eZkuu180F4iASDNWFbO20z+Km7QnrrHthgOrgsYPeQm5BtuGsAXWVCIFEhkwPvorfSir6odHQk81pdIaKj+w2d/ApGXx6Y66u8+ttFV0sixcM2DX9nF7Wz5dsJxrdXqcWt9ZVlJNJXvcoC4DPgwRkwhQt1Lvl9xscNkopF2g9si87aqfGv42ZPLkXd/0yjOm+rIPWrvicckGqcAYfAnySobsHZPZgoo3Xf6Cv7DQG0P+Q0NTKYWvgq/QNrpwpbDFLxBOglDbvi4iYOshPMdig7q4Lsj2NJpljb0sok2l9bQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yhWVK87hjRVR96Sn75xrGcFScPLJKB1dRlyYp0g+0e/682TRw7f9bqUpsV?=
 =?iso-8859-1?Q?3Raki2zyi9T0hOy9VP2ye+4/YzaJNqJtIMRCs/qEYKd5uPyMVxEWn4Vf5b?=
 =?iso-8859-1?Q?5fZPoqjGEwvsAOUXvwStpRRJ8R5MzOHE5ewiSpemKoLirw8uAk0/pH3YDa?=
 =?iso-8859-1?Q?lTrskcRQIQmTTzlF55Ipk+za5KyNsxEjam1ESLGVZXIlkjpqFE8ELZ7o6S?=
 =?iso-8859-1?Q?6zZ/q5Aj34Dm+cDT8S5faeGRePRPKH9jytWJ4rJG+Pn0LeaddfUFkp43cp?=
 =?iso-8859-1?Q?NYXTXU86VbQ7FK5hiFZKlH6Dg/CWwKVYuOZMC52qhDGNZhv/L9htgNAid1?=
 =?iso-8859-1?Q?ijGBYGahnBByN2HFY+MvvZsOFDJY6X0IeWeFODEtnCCChR6PqyyCSp9h85?=
 =?iso-8859-1?Q?V4j0Qzhck4m3/PPBcNb/i/JNdQypjkgyz0iiWmB1wO62XtJV40G7nXuear?=
 =?iso-8859-1?Q?hxA4nsC8lvUVyFZpTWCiY3M6l7llLY8ARmNy29Q7mkCp18zl5Z8ahY9UqO?=
 =?iso-8859-1?Q?Blq2PE7xR5/9P+04DSUl3ao6YnXVrv2tH20LSAw3D5Wx3/f/ZfVU0knpOb?=
 =?iso-8859-1?Q?A7RXz4zqhhqPsuWbyeUCmn85BCpOdlvcLLmUYnXUxzUtQta97gTFQN8LQy?=
 =?iso-8859-1?Q?T61YzFYhk/mvJDG+kaBKCpNaZZdIiIzwFNRgFd06IQ1CeLvdn/6j0xJnt1?=
 =?iso-8859-1?Q?6NmLp3sy85NgRxZwRy4Fb3RSwEEAlDvVH5mApmu2CXlh19lJrdcg1KdLFG?=
 =?iso-8859-1?Q?VqhpnfbXuUHNobRyg8DJqdLGXodrCxolbdBB30CIX7NdZsjOjbYQVm+AWB?=
 =?iso-8859-1?Q?sC00Toqrx7w+cufA8Mw8l0CAzAHeYWF/PWfLuuaM+1KNVkySgjCXRKHkXW?=
 =?iso-8859-1?Q?qCUcx9zMPFaTBv0z2eJibVsaaH9p68ueH5mDsUgepI6OkWPgVmGXIPiRyS?=
 =?iso-8859-1?Q?YGh93653zuDhrFE0L8GJrsPE+ToMfZ2tDrNdRZwBHwbTVyewNlfMVKwgV7?=
 =?iso-8859-1?Q?amZgmGOhYoyMvKyHryZ9WMgv32Yo1jnFBxjqeBu/T6vo+qX4cfUnKCJSjw?=
 =?iso-8859-1?Q?C1Ik+VOKP490hr+BZvHLE6Nl7lUshQ9ldX683RPbNtTyUFPrLlCtMfIuC2?=
 =?iso-8859-1?Q?zLqLsCz6c83o6n1uZ1i/p8Ve2XUa/RFVE1Nki4VRaNj21r2IXpNXb0SPTm?=
 =?iso-8859-1?Q?eM8pNE6nCOrugnHkWzicG0rfdcjHCfRuNKdj5rbNv1NTdx2cGAWz/jhoTl?=
 =?iso-8859-1?Q?48uEKaO2Rwf+RO2TqXK9TKx8CwkkHY72eOwZBxqKyg5v0OW7uzF58jsv0a?=
 =?iso-8859-1?Q?+KnJJYGC8bIWlSJc3XDBleaE/fDQLOJXGeRQp1wrUpJlYHhVqhG1D8t4wE?=
 =?iso-8859-1?Q?BkHtKWqE48FTWdAKKg82GbZDpat3OkuPzncT/K8A8ARyWbL1avr0sVAEPh?=
 =?iso-8859-1?Q?m6ZP39WemswT6B6T+QQPBEipLboTdypkF0sUElGRUMf4ZffSisgcMLmU1e?=
 =?iso-8859-1?Q?hzhlE9gfeszWWA5OV3/KIbZ41i1dFuUgHdHB0naJk3AePteIt4RoEZW4yz?=
 =?iso-8859-1?Q?/foTXbIvLPt9p5RcHdh4Kk3w/gXf5+j0NPL3OtqHIwAFc6RYGbBoHbidV9?=
 =?iso-8859-1?Q?5kVnrQ2Zt0A+qmFrgRTbFrWdBpolZw4lwiiehzoauu58xfuT11iI3jzkKn?=
 =?iso-8859-1?Q?Za07+wvMe/nv4CPH0dl2bPQqYR1DNN+naguZQUkzRQf7rCpFk1qCC+FYMY?=
 =?iso-8859-1?Q?fZAsHcbDqgi1/Vs2Bf/QTwkxow5pwnFwGL+czXUGGxULxObCG487cAqFvR?=
 =?iso-8859-1?Q?hwMqZ1rOQZm3fYPk9t+yxaB4pUDPA4I=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42bb8a0-64ac-4d70-b059-08df057ac637
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:08:18.1649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZfD9GDbBvNwbrMd1skxq1vZ4edLf+ISst7wE82njN/3yLIt/uaA/Cl32NS3pxTZ6Z8qpHytiNBEuYh7lXWfpW2kfo1Q9B7tSCDGadWEfn0=
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

On Fri, Aug 28, 2026 at 05:39:07PM +0800, Daniel Henrique Barboza wrote:
> The pcie FDT is quite tedious but can be parametrized into a helper.
> This is going to benefit only the 'virt' board for now but it will be
> used by the 'riscv-server-ref' board in the near future too.
> 
> Some other changes made:
> 
> - FDT related macros are moved to fdt-common.h.  Only a couple are being
>   used by the helper ATM but more will be added in the next patches;
> - an RISCVAIAType enum is created.  There are several FDTs that depends
>   on the active AIA type being used, and we want a way to represent the
>   different AIA modes that doesn't re-use the 'virt' specific VIRT_AIA_*
>   macros.  The enum vals are equivalent by design - we want "s->aia_type"
>   to be used by 'virt' when calling the fdt helpers, and other boards
>   will use "AIA_*" macros in their code.
> 
> No FDT changes made.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 111 ++++++++++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 111 +++-------------------------------
>  include/hw/riscv/fdt-common.h |  29 +++++++++
>  include/hw/riscv/virt.h       |  15 -----
>  4 files changed, 149 insertions(+), 117 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 88589330fb..38813b6aa7 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -15,6 +15,8 @@
>  #include "target/riscv/cpu_bits.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
>  #include "hw/riscv/iommu.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pcie_host.h"
>  
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size)
> @@ -384,3 +386,112 @@ uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
>  
>      return iommu_phandle;
>  }
> +
> +static void create_pcie_irq_map(void *fdt, char *nodename,
> +                                uint32_t irqchip_phandle,
> +                                RISCVAIAType aia_type, uint32_t pcie_irq)
> +{
> +    int pin, dev;
> +    uint32_t irq_map_stride = 0;
> +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
> +                          FDT_MAX_INT_MAP_WIDTH] = {};
> +    uint32_t *irq_map = full_irq_map;
> +
> +    /*
> +     * This code creates a standard swizzle of interrupts such that
> +     * each device's first interrupt is based on it's PCI_SLOT number.
> +     * (See pci_swizzle_map_irq_fn())
> +     *
> +     * We only need one entry per interrupt in the table (not one per
> +     * possible slot) seeing the interrupt-map-mask will allow the table
> +     * to wrap to any number of devices.
> +     */
> +    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
> +        int devfn = dev * 0x8;
> +
> +        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
> +            int irq_nr = pcie_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
> +            int i = 0;
> +
> +            /* Fill PCI address cells */
> +            irq_map[i] = cpu_to_be32(devfn << 8);
> +            i += FDT_PCI_ADDR_CELLS;
> +
> +            /* Fill PCI Interrupt cells */
> +            irq_map[i] = cpu_to_be32(pin + 1);
> +            i += FDT_PCI_INT_CELLS;
> +
> +            /* Fill interrupt controller phandle and cells */
> +            irq_map[i++] = cpu_to_be32(irqchip_phandle);
> +            irq_map[i++] = cpu_to_be32(irq_nr);
> +
> +            if (aia_type != AIA_TYPE_NONE) {
> +                irq_map[i++] = cpu_to_be32(0x4);
> +            }
> +
> +            if (!irq_map_stride) {
> +                irq_map_stride = i;
> +            }
> +            irq_map += irq_map_stride;
> +        }
> +    }
> +
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> +                     PCI_NUM_PINS * PCI_NUM_PINS *
> +                     irq_map_stride * sizeof(uint32_t));
> +
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> +                           0x1800, 0, 0, 0x7);
> +}
> +
> +/*
> + * NOTE: this function uses a "/soc/pci@..." FDT subnode that
> + * should be created beforehand.
> + */
> +void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
> +                           const MemMapEntry *pcie_ecam,
> +                           const MemMapEntry *pcie_pio,
> +                           const MemMapEntry *pcie_mmio,
> +                           const MemMapEntry *high_pcie,
> +                           uint32_t irq_pcie_phandle,
> +                           uint32_t msi_pcie_phandle,
> +                           uint32_t iommu_sys_phandle, uint32_t pcie_irq)
> +{
> +    g_autofree char *name = NULL;
> +
> +    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx, pcie_ecam->base);
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
> +    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
> +    qemu_fdt_setprop_cell(fdt, name, "linux,pci-domain", 0);
> +
> +    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
> +                           pcie_ecam->size / PCIE_MMCFG_SIZE_MIN - 1);
> +    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
> +
> +    if (aia_type == AIA_TYPE_APLIC_IMSIC) {
> +        qemu_fdt_setprop_cell(fdt, name, "msi-parent", msi_pcie_phandle);
> +    }
> +
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2,
> +                                 pcie_ecam->base, 2, pcie_ecam->size);
> +
> +    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
> +        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> +        2, pcie_pio->base, 2, pcie_pio->size,
> +        1, FDT_PCI_RANGE_MMIO,
> +        2, pcie_mmio->base,
> +        2, pcie_mmio->base, 2, pcie_mmio->size,
> +        1, FDT_PCI_RANGE_MMIO_64BIT,
> +        2, high_pcie->base,
> +        2, high_pcie->base, 2, high_pcie->size);
> +
> +    if (has_iommu_sys) {
> +        qemu_fdt_setprop_cells(fdt, name, "iommu-map",
> +                               0, iommu_sys_phandle, 0, 0x10000);
> +    }
> +
> +    create_pcie_irq_map(fdt, name, irq_pcie_phandle, aia_type, pcie_irq);
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 8a165f4d9e..a28e6d200a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -180,61 +180,6 @@ static void virt_flash_map(RISCVVirtState *s,
>                      sysmem);
>  }
>  
> -static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
> -                                uint32_t irqchip_phandle)
> -{
> -    int pin, dev;
> -    uint32_t irq_map_stride = 0;
> -    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
> -                          FDT_MAX_INT_MAP_WIDTH] = {};
> -    uint32_t *irq_map = full_irq_map;
> -
> -    /*
> -     * This code creates a standard swizzle of interrupts such that
> -     * each device's first interrupt is based on it's PCI_SLOT number.
> -     * (See pci_swizzle_map_irq_fn())
> -     *
> -     * We only need one entry per interrupt in the table (not one per
> -     * possible slot) seeing the interrupt-map-mask will allow the table
> -     * to wrap to any number of devices.
> -     */
> -    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
> -        int devfn = dev * 0x8;
> -
> -        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
> -            int irq_nr = PCIE_IRQ + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
> -            int i = 0;
> -
> -            /* Fill PCI address cells */
> -            irq_map[i] = cpu_to_be32(devfn << 8);
> -            i += FDT_PCI_ADDR_CELLS;
> -
> -            /* Fill PCI Interrupt cells */
> -            irq_map[i] = cpu_to_be32(pin + 1);
> -            i += FDT_PCI_INT_CELLS;
> -
> -            /* Fill interrupt controller phandle and cells */
> -            irq_map[i++] = cpu_to_be32(irqchip_phandle);
> -            irq_map[i++] = cpu_to_be32(irq_nr);
> -            if (s->aia_type != VIRT_AIA_TYPE_NONE) {
> -                irq_map[i++] = cpu_to_be32(0x4);
> -            }
> -
> -            if (!irq_map_stride) {
> -                irq_map_stride = i;
> -            }
> -            irq_map += irq_map_stride;
> -        }
> -    }
> -
> -    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> -                     PCI_NUM_PINS * PCI_NUM_PINS *
> -                     irq_map_stride * sizeof(uint32_t));
> -
> -    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> -                           0x1800, 0, 0, 0x7);
> -}
> -
>  static void create_fdt_socket_aclint(RISCVVirtState *s,
>                                       int socket,
>                                       uint32_t *intc_phandles)
> @@ -723,51 +668,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
>      }
>  }
>  
> -static void create_fdt_pcie(RISCVVirtState *s,
> -                            uint32_t irq_pcie_phandle,
> -                            uint32_t msi_pcie_phandle,
> -                            uint32_t iommu_sys_phandle)
> -{
> -    g_autofree char *name = NULL;
> -    MachineState *ms = MACHINE(s);
> -
> -    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
> -                           s->memmap[VIRT_PCIE_ECAM].base);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
> -        FDT_PCI_ADDR_CELLS);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
> -        FDT_PCI_INT_CELLS);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "#size-cells", 0x2);
> -    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> -        "pci-host-ecam-generic");
> -    qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
> -    qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
> -    qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
> -        s->memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
> -    qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
> -    if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
> -    }
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
> -        s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> -        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> -        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
> -        1, FDT_PCI_RANGE_MMIO,
> -        2, s->memmap[VIRT_PCIE_MMIO].base,
> -        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
> -        1, FDT_PCI_RANGE_MMIO_64BIT,
> -        2, virt_high_pcie_memmap.base,
> -        2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
> -
> -    if (virt_is_iommu_sys_enabled(s)) {
> -        qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> -                               0, iommu_sys_phandle, 0, 0x10000);
> -    }
> -
> -    create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
> -}
> -
>  static void create_fdt_uart(RISCVVirtState *s,
>                              uint32_t irq_mmio_phandle, int memId, int irqNo)
>  {
> @@ -916,8 +816,15 @@ static void finalize_fdt(RISCVVirtState *s)
>                                               msi_pcie_phandle,
>                                               IOMMU_SYS_IRQ);
>      }
> -    create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
> -                    iommu_sys_phandle);
> +
> +    riscv_create_fdt_pcie(MACHINE(s)->fdt, s->aia_type,
> +                          virt_is_iommu_sys_enabled(s),
> +                          &s->memmap[VIRT_PCIE_ECAM],
> +                          &s->memmap[VIRT_PCIE_PIO],
> +                          &s->memmap[VIRT_PCIE_MMIO],
> +                          &virt_high_pcie_memmap,
> +                          irq_pcie_phandle, msi_pcie_phandle,
> +                          iommu_sys_phandle, PCIE_IRQ);
>  
>      riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
>                              s->memmap[VIRT_TEST].base,
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 65711468b8..3750230865 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -11,6 +11,27 @@
>  
>  #include "target/riscv/cpu.h"
>  
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_PLIC_ADDR_CELLS   0
> +#define FDT_PLIC_INT_CELLS    1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_APLIC_ADDR_CELLS  0
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_PLIC_INT_MAP_WIDTH  (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_PLIC_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_APLIC_INT_CELLS)
> +
> +typedef enum RISCVAIAType {
> +    AIA_TYPE_NONE = 0,
> +    AIA_TYPE_APLIC,
> +    AIA_TYPE_APLIC_IMSIC,
> +} RISCVAIAType;
> +
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size);
>  void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> @@ -48,4 +69,12 @@ uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
>                                            uint32_t irq_chip,
>                                            uint32_t msi_phandle,
>                                            uint32_t iommu_sys_irq);
> +void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
> +                           const MemMapEntry *pcie_ecam,
> +                           const MemMapEntry *pcie_pio,
> +                           const MemMapEntry *pcie_mmio,
> +                           const MemMapEntry *high_pcie,
> +                           uint32_t irq_pcie_phandle,
> +                           uint32_t msi_pcie_phandle,
> +                           uint32_t iommu_sys_phandle, uint32_t pcie_irq);
>  #endif
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 7c862b0da2..e516898f9a 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -121,21 +121,6 @@ enum {
>  #define VIRT_PLIC_SIZE(__num_context) \
>      (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
>  
> -#define FDT_PCI_ADDR_CELLS    3
> -#define FDT_PCI_INT_CELLS     1
> -#define FDT_PLIC_ADDR_CELLS   0
> -#define FDT_PLIC_INT_CELLS    1
> -#define FDT_APLIC_INT_CELLS   2
> -#define FDT_APLIC_ADDR_CELLS  0
> -#define FDT_IMSIC_INT_CELLS   0
> -#define FDT_MAX_INT_CELLS     2
> -#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> -                                 1 + FDT_MAX_INT_CELLS)
> -#define FDT_PLIC_INT_MAP_WIDTH  (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> -                                 1 + FDT_PLIC_INT_CELLS)
> -#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> -                                 1 + FDT_APLIC_INT_CELLS)
> -
>  bool virt_is_acpi_enabled(RISCVVirtState *s);
>  bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
>  void virt_acpi_setup(RISCVVirtState *vms);
> -- 
> 2.43.0
> 

