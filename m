Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F200C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 04:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzny1-0003W6-HY; Fri, 28 Aug 2026 00:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wznxz-0003Vn-Ru; Fri, 28 Aug 2026 00:13:23 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wznxx-0001Je-Ln; Fri, 28 Aug 2026 00:13:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfoM+vzlbcKV886w9JYxEsXWCo2B2BbyQh3oyimFbikQN4J7Jsk9Zpr/Z/qeNhBFiG2KyMpGXjo5X/6OxTg6uBm20YKH+Xxt5ZMP8KM/zSGYpyGTi3TE53IdBegusaZFMjjiIwdU/rAmWV1mQnW7JH8qUbZUfPfAsU0x6KgPNmRD297YvDLI0Dii+ur9HOXxam4Bh92hG4eXRxWPCX15lBhAgJnSxkEhDzaI1Zm5LJvlebEJTj76tk5XU234ZwjbD4hXSXEfQ8T1poT1Gg3H/k8/hynD0ZMnTNTUBFLCx9tptpAycHgi0S6b89tf85l+JTtKQAgOhtkta1CRZRSOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFrPQFxVm978k+Ki8vW5PrGhc5B+DZdlIoIUB6bc344=;
 b=omBr3/yTni6siXRG/dg2JyOhP3/pMtfC/vB4VxEu3On7c3HL0Rrm0vP7qEtKXbiprjRimDfWXT73anqb3E4FVSGysYnz0kU5ZWimXB2wUN0nkwRF4/PajxltudxrlYUbGfDehVMbxDbhRISiUt41jf1oI+q/9g6gudL/uceLdXDXqy+jyHpQW7f3rMyEO7ZPMTL0xsLCYq2f2+SO/xSjApRpyP+XDkJbZf4eXEkOgF0RpISQyqA52IAzOHl+XUEqXYNiZvmGp297WuKfHx9Bep2G2OXlusovB8u0Xb1xc93nK3cqnO1ruNx589/wG7JRQlashqAdz54iX7604a1OwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFrPQFxVm978k+Ki8vW5PrGhc5B+DZdlIoIUB6bc344=;
 b=DoqRzaz3AQSmUQP7LGBWnGXd6nzZ17S4A3Ziju2QEy3SUYm/82p6RxwRP/J9AlY4mfGo9uUThFL3IDtuS6bclkLNOtJCpiuj7c1e7CfIfwj+8uH38RvpN38n3Uc4wrdd6gFSYzm1lCk3VQdaSkpK1lOpdhdWaWjUNJqRjcaJU9TH/c++ZJGckLGShEHiMGM9lFsfJ1YtNICihIVceK7jN5KpzhNpxTzx0uJsQ2iB85xlODcaqIOvd//akDiuekfj+hBLOZRxVvFngqVIfkREYzbbJvR7UhN/22LZD2qbEwHVvKX5qTX8S/AdSCAvI+IOG6FLDaUO9S86DlBIC/NqdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB7338.apcprd02.prod.outlook.com (2603:1096:405:30::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:13:14 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 04:13:13 +0000
Date: Fri, 28 Aug 2026 12:13:07 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v4 08/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_socket_aclint()
Message-ID: <apEGhbfBmPgZrT8r@ChaodeMacBook-Pro.local>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-9-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827222608.329788-9-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 698f8bc8-717e-4c9d-fd25-08df04baadc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 1kEZH2ZMVB+jW/wkl693C1yBuKd5reKbnVU565tmO8MEGyyL3CruS718dbpRsBpnI/j9AA8vS2H7bXigao5weHiIqugwrPIkW8Gk4SMeSLGOapfCev8pDE/wdG3Qa8PvSKtOPJ2xTMcpL/hvQWHIbjcMtn1kZyf54xwP8LGOrmUjgs6Tsidk+ZZNbP3cBaZujYmkrkIIH6R3MTBdkJBthVY7ydiNIvyceA8kdE/j+OVuz8dmIjBOfocG8wcEVLEkuswl0CUY9isWZqL3faKp4HpPI/k2zOf0isXGr67VBYtZrPcVnqXO/yc+oxcGrVe/nLbDCjZol1To3/jwHehGHXM3NSsN7dnyAuoSBxoAPbr1jPzItAcGXP9nSt+DCD1KIicAp/SFFhGpZkzehsvpk5T6N3Us2ArsSRRtd69E9sjcU2StQVHlYCeawPYJYu/oS6a11RF0oITyUVBDa6npkWhhqOGQ1j/GZQqTspvrIrw4ay7FDDnlvqPERtzcRLz0kVnX8f5yxYKrbjtjZ9Lm5m/JYW+4XfOKjNf6yh7Tud67zlDeGyThKx8hhQ7OYPfrQvCSDx/cYeto0H/g2GmOGH1tNDgSQ1GSDs2XjKIEaySHOMllx5ClllEKC1Qyu6mTkrkeQt+HYLOmx36S69IEw36Cga0qQowpyPb2imF0syc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?We45pho+lbZuaXiqzv385jD5tI3KnimSYTDi+uzboSUIXEDA2I4RqnBqc9?=
 =?iso-8859-1?Q?UeBgqhrmaU8Uc8nd5XKX/GSwVqSlqsa9dZXQRiew3Q1HjH0GEIcQARD+yL?=
 =?iso-8859-1?Q?MWYh6IQJLo2j/LxUSHiZU+QB5cYPr+64vxHY5OoO6JIcR1U00BrTjDlA8s?=
 =?iso-8859-1?Q?wqoRHYRqZjFRyjrDRY5W8zv/MacVHdAgchMGwz1SP/onjBrP6wR0wHHv0w?=
 =?iso-8859-1?Q?cwhrVoW85r4kShRgrarBdjFJsz3/3iMy/3DeTZWiWT41b3tmDHnSZPYKgo?=
 =?iso-8859-1?Q?yRXu1p0DxTcuwm4DW8RuNK7XBb1K06vvFr99lrOsRJ72TybhqhOrw+iWsR?=
 =?iso-8859-1?Q?xxMAeHqKcwD3nFhhU41iBODosYkQ5BQdZuYh9K05SzC7qywvzpiU3dgumv?=
 =?iso-8859-1?Q?ZZxhLXk8ZpICBbivnstfXuznoqQZv7iwjIrTG/XaUc2L/Jfr6as1wcSCKq?=
 =?iso-8859-1?Q?4KIBUXreNS8tWicbRRfR7VcnH8PgGOTPl79Zp7MSHRJbXodDiIBhLieABj?=
 =?iso-8859-1?Q?0GjSb4t9gAI92LMy0E/ebK9nvXNwflDLEzFRVndNX+t5tJRc/LYQj19Fov?=
 =?iso-8859-1?Q?ls8ubcVgA7u9W9GyYG1zqyoVmCr//819L8eJcOXAD/dXS9gzi7cbkSQthv?=
 =?iso-8859-1?Q?zJtoi/iX1A8MW1q5JAl2PdMXPtLmPWkeGPvIY5WQ1OLS8nEOKoZq986w0c?=
 =?iso-8859-1?Q?07R+Nav+0MOv0u8vZaTHN20w1eXXJN7Gk0C0XnJwtfzjgfBYJQCV8GuPcW?=
 =?iso-8859-1?Q?+X0+sX8F4BlesTYmTlx+CSmG1Jku+9SaXVbJCT/MbDrVoq3VrWKrtUoomX?=
 =?iso-8859-1?Q?SqPFPgLRB/HzUDfo+wsgt5u/3pLbNJuLZo5Yd4mNuZ5dq0pnfFR6kFr6EN?=
 =?iso-8859-1?Q?VvLaynQD6kQghDY9Bw7AjjLpR7hEeav7H+xXiO4gZVP+E7yAWuPD0utPB8?=
 =?iso-8859-1?Q?ee8zCipSS4zzoEz8S4vh6krwrkmTXIcN/VHe6CTFiJEW8bE4XOvmtEbk/+?=
 =?iso-8859-1?Q?pwSmycwToVHdWU+yDZHa0emzUlj4XSLiGs5lzK9OTGdYcBYIwEO5W5mJs5?=
 =?iso-8859-1?Q?6Pm6Yl20PBmCNpwV6UQ6guKD1s0OLh1ftCrPhGt/w40ycXSnc7LviUuHbr?=
 =?iso-8859-1?Q?uyP+AWILFYs+hbzkb5bw40HKF2JQXKEI8DamKilwM/k0NOKJpf8DlWNa+x?=
 =?iso-8859-1?Q?vSNDYDQ0wBWbQd1DQl5RjKJoL7SW4x5AAlJtEY4m+j8yXOLFFaQ+9kyQrG?=
 =?iso-8859-1?Q?KqOxI0+zmBmK811lISUdrsUeUEpSU8qzDLAD+CRNSJAX0r/EUd4PsVnW32?=
 =?iso-8859-1?Q?18hUoIhczeaL6awCuy7D5uqPItFU2VyIdY9scdoJKlomh4kZc3FeNCQToq?=
 =?iso-8859-1?Q?H01xnSYOTZTPm7t9bx2SOyRzI5wmfuUd8jKYQaM3ODYdoMt6q7J2YVztna?=
 =?iso-8859-1?Q?6sHpn3kayd/TT1tCcRQIcVKH9DHltQF+qiAyNTF4MRpn1S+STn694sBAiU?=
 =?iso-8859-1?Q?J6SOBhFzYH6vyLkFqKmLcLv7+xtfA4Gdv9wTxYgCnkC/iprOGzRcKZ+IMX?=
 =?iso-8859-1?Q?RZwQs+beqMFERNFMpvrG8v5S93GqhBjHtowWnKOJpLAuRcebHW2D0lC5Ow?=
 =?iso-8859-1?Q?ERXyyvYydJhMY7zNqzoA6Bszk95WsNS6Sj72IT4Zezg0y1kzs6OSqsp6Qe?=
 =?iso-8859-1?Q?DzLdgNi24yCyiy/f+R7tNWTQc/y84A9+fweH45U+7848FosPZLgSrMDP5T?=
 =?iso-8859-1?Q?w8JYkgy86B56SjToc1OOaC6oXWDHFZKsIrvAKmW36/6q2yVDgCQgcccjrJ?=
 =?iso-8859-1?Q?pnIx73vPy7EZw6Hg1bOoWmhLbDTS1F0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698f8bc8-717e-4c9d-fd25-08df04baadc4
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:13:13.6448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y95MLtUp+0j8nLbCQYbtNsohb2a6BhPwliD/88VEfLN0+GuIi/IjU4KoAG3Ug6A6yVHGQRmm5JEWTO0NwrA2zE/y2MkMZvBZ1opPOTL1Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7338
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

On Thu, Aug 27, 2026 at 07:26:01PM +0800, Daniel Henrique Barboza wrote:
> Yet another FDT that we want to move to a helper to avoid copy/pasting
> code to other boards that will use a mtimer.  In particular the future
> 'riscv-server-ref' board.
> 
> No FDT changes made.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  hw/riscv/fdt-common.c         |  96 ++++++++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 101 ++++------------------------------
>  include/hw/riscv/fdt-common.h |  11 ++++
>  3 files changed, 119 insertions(+), 89 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index d815c5adff..76a783709d 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -16,6 +16,7 @@
>  #include "target/riscv/cpu_bits.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
>  #include "hw/riscv/iommu.h"
> +#include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/riscv_imsic.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pcie_host.h"
> @@ -702,3 +703,98 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>  
>      aplic_phandles[props->socket] = aplic_s_phandle;
>  }
> +
> +void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
> +                                    uint32_t *intc_phandles)
> +{
> +    uint32_t aclint_cells_size = props->num_harts * sizeof(uint32_t) * 2;
> +    g_autofree uint32_t *aclint_mswi_cells = NULL;
> +    g_autofree uint32_t *aclint_sswi_cells = NULL;
> +    g_autofree uint32_t *aclint_mtimer_cells = NULL;
> +    hwaddr addr, size;
> +    char *name;
> +    int cpu;
> +
> +    aclint_mswi_cells = g_new0(uint32_t, props->num_harts * 2);
> +    aclint_mtimer_cells = g_new0(uint32_t, props->num_harts * 2);
> +    aclint_sswi_cells = g_new0(uint32_t, props->num_harts * 2);
> +
> +    for (cpu = 0; cpu < props->num_harts; cpu++) {
> +        aclint_mswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        aclint_mswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_SOFT);
> +        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
> +        aclint_sswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        aclint_sswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_SOFT);
> +    }
> +
> +    if (props->aia_type != AIA_TYPE_APLIC_IMSIC) {
> +        addr = props->clint->base + (props->clint->size * props->socket);
> +        name = g_strdup_printf("/soc/mswi@%"HWADDR_PRIx, addr);
> +
> +        qemu_fdt_add_subnode(fdt, name);
> +        qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mswi");
> +        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                     2, addr, 2, RISCV_ACLINT_SWI_SIZE);
> +        qemu_fdt_setprop(fdt, name, "interrupts-extended",
> +                         aclint_mswi_cells, aclint_cells_size);
> +        qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
> +        qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
> +
> +        if (props->numa_enabled) {
> +            qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
> +        }
> +
> +        g_free(name);
> +    }
> +
> +    if (props->aia_type == AIA_TYPE_APLIC_IMSIC) {
> +        addr = props->clint->base +
> +               (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * props->socket);
> +        size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
> +    } else {
> +        addr = props->clint->base + RISCV_ACLINT_SWI_SIZE +
> +               (props->clint->size * props->socket);
> +        size = props->clint->size - RISCV_ACLINT_SWI_SIZE;
> +    }
> +
> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible",
> +                            "riscv,aclint-mtimer");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +        2, addr,
Should be:
	   2, addr + RISCV_ACLINT_DEFAULT_MTIME,

I found an MTIMER FDT issue in the virt machine FDT.

Command:

```
  timeout 30s ./build/qemu-system-riscv64 \
    -machine virt,aia=aplic-imsic,aia-guests=5,aclint=on,dumpdtb=/tmp/virt.dtb \
    -smp 2 -display none -nodefaults

  dtc -I dtb -O dts /tmp/virt.dtb | grep -A4 mtimer@
```

The generated FDT contains:

                mtimer@2000000 {
                        interrupts-extended = <0x04 0x07 0x02 0x07>;
                        reg = <0x00 0x2000000 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
                        compatible = "riscv,aclint-mtimer";
                };

without this patches:

                  mtimer@2000000 {
                          interrupts-extended = <0x04 0x07 0x02 0x07>;
                          reg = <0x00 0x2007ff8 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
                          compatible = "riscv,aclint-mtimer";
                  };

The first address should be 0x20007ff8.

> +        2, size - RISCV_ACLINT_DEFAULT_MTIME,
> +        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> +        2, RISCV_ACLINT_DEFAULT_MTIME);

[...]

> +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
I think this is the original code that was moved here.

Thanks,
Chao
> -        2, size - RISCV_ACLINT_DEFAULT_MTIME,
> -        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> -        2, RISCV_ACLINT_DEFAULT_MTIME);


