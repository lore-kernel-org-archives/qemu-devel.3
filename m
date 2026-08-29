Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CF7C61DD3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09Tt-0006az-7L; Fri, 28 Aug 2026 23:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Tn-0006ad-My; Fri, 28 Aug 2026 23:11:40 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Tl-0006Fn-SW; Fri, 28 Aug 2026 23:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdWkATfvthsnmU4/4r1xwIXBhRKmFyQ/6gRtb19mBQR5efTFfGEt0M0VBXVXkbm74BUhIlrYPdAD5uZr0JV/SotJ3IbuvRne0rBB4Ga6tH/FG3WMQjrwL3+P/RyIhn7rPDvsGP90yAb3XLFImS2dG6yH9V7+FdtGcc+rbaW05npzdp4wEKQ7dy+lEM5V2MXynYX+srBavaxCWR5LcNkjN/IOkLkthMCEg4treuiskHy8+6wA0486qMC++2q9kMkCe1vnOSEO8JbUOOWfrqEHsrVONLoSQGm+FyU3/+KzMdQRwnEfhvWs7bUK/8O1ocCn6nBDIh3iorc6GXHAMIP+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H93PXlygdLm2mSYnzOTDIE5CMBiMhTEo/OqYX4CTpHg=;
 b=BbmygmFuxvWJHc6tMXeXKpE4u+w0ZHL4Q76KZXajZ1eyCoeF3t8dJixKnYKBZyXA/Yz/sVi91AXqQYqiWTNuPfbnRQLeVdcxZPyZEHaKr3TV7pOtDCTSBNXpntbYS8oIa60tZrfs7Fq/eafZ8vODSCaQWW8SQnhw+rPR/u6L7L7xrqeT2HV9LKpHZ4F6TFpvH26OTi9VrivMM402b6K8zollU89YvCwVWVwMKfFPGeQl+l/klu41A29uWegO8b5qnmRYKg8YDYtaJCEkGtLvpKQCz/6mN+e7fNNYm7NZCxz5BmGsVh2l2DPwFI27UByCctKK84YiCzVT2aJjy9zLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H93PXlygdLm2mSYnzOTDIE5CMBiMhTEo/OqYX4CTpHg=;
 b=jHMyGdL5EAJq103oWNX0iPnHVi5JlxSrQfCbaetqg6JnVPqPN9wL+Gm4VWHjSxYY+lglyzGngbJhZbD3T9XQGMstUbQVS7UXWYMu6KA925Ddqc0aqB4gC9/WOdzlouwpkMEtxzGj3eeVhaBskW1NgG0gzZ1Kdgy0SkeAsBcCD/3uND48+cjh9titmRBKzCcESRVci3YbSJBZm8TWq69jzjBdmYvRfEJTQviAhLHMBI3ogdcP1GA1+kEYQZnknjJH1qHANluqrh3e+q1vITb9oEZ0aE2rAKXbtyTqH6IRBL8mPDxwJNYiCWP1+4mMaUVbgGfyhtUP6/bDCT7JQDC4Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:11:32 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:11:32 +0000
Date: Sat, 29 Aug 2026 11:11:27 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 10/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_uart()
Message-ID: <apJN1i_JBCjDWfSR@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-11-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-11-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH8PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::16) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: af233bef-3d44-446c-42ed-08df057b3a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 94sE4W25oxwIiArLXya+SOyiTRR3lWPwjUPxRzEFcJ0t+f/SQMolxrrz0t5zs5DY0fPwYqYdTVa9+J7ri395jQ94qAdc++dDRcUKR9Ryhf/GqNi1B4w6fHx/WyKtkQVMD6m6nRQAgc7NAozhgNVAxjKJzUyxouTAfh7qYQx0Okyu+PKbspG+GYtxkPWRItGtGgFGlO7AoCxJpXsm5oDtvQtLBIT//8bJXynMw448f21O7hUb8V8ivpz/Q+3Ax6IgpPinFMsfyxHb/43R5iwDCtgB2jEdhp094RABxgq42ha0LA8EEl5rpqMZ0Lfl/LQEtSuN++DQ6qeuFTOSdGmU1GVSVypUil5PuwJdhI9vMsDX0w6ok90yqigaQJ47lXFSY6/TxE4sDeTN5zk+UxHCb6WgVZm9e2xpEBaQYbqUtVe207itqAt43gJS1KT3xC0LxnkYn4lC82LByX/+ALSyjILfiv6JONsqGx/rWepkCTkwWETb5YC0vPey9UUzZy5vs69Yo44vjgO5KhzaomPR52IohDfKy907BYms+uAziq7gkkuoUCuSWdAwY5fy7giSzcaOkcmErD5xkBbc/syo8i88+JC/4IEIuYULs4oQkgj2vHPCBhBSpocpWU3tVrvZjMqO8VlhEPEPGu0nqVnWbchB9AZdobI+hCHezoUYAV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FBmnkzdhbVeYWTdpfgRNZmCE9dQNm8hUYd2RXe4nVhqByoImn8MF5udU1D?=
 =?iso-8859-1?Q?MFfPjwyaioV3X0RsPUtAI+rduQCvYK/BY6ODVg0iZmZikAuTpxRevESJHD?=
 =?iso-8859-1?Q?dwYkno5MvefghkmpBT1cOu0o57WmTl2U5mHL1CewEDGhw/KEX8KAIw9mKV?=
 =?iso-8859-1?Q?8H92+kyHu472gITUZeri2Vx3BrwiyUIvYGR79S1tjL/DYY8BSYxjqNj/th?=
 =?iso-8859-1?Q?mRKFxYdRuZY+ZC15EKLLHFifGV1RJ6/3eJlk1CgNT6YgI04fQRJtO8CIVo?=
 =?iso-8859-1?Q?ApfSb5p4EQ9djRDs6yvdu5zSC6x0QpoT7Mxt1FQbqOl74GIzCkx0cfvwv1?=
 =?iso-8859-1?Q?lWzA6zWgaMe9Y8oJSzw3914WSLL4pValf9e7kKkfKN+QkuHzjs8+EJxt69?=
 =?iso-8859-1?Q?jf/WwBOV6uGLCKBiKjE61eBLmH4jFwRKmsV9Lr6APuctvYoCdNHsQLX8wv?=
 =?iso-8859-1?Q?YsO2it2qkSQUSGdShAesM9Qd8ITLHgNuc/nNgWZBhCLPemDg+QQvD00crW?=
 =?iso-8859-1?Q?cI7sN626H6IknFrlw9gm1oTzJCXnkfPJIBW3PtfmFTOf3wPctj/RdhyYdL?=
 =?iso-8859-1?Q?Lbqd7oyvgBMAYtQrjamBG+P5ZjmcIedcfAOro8CVHzfOryt1bqU7zU4bkA?=
 =?iso-8859-1?Q?KjWDIbLp2shkLre3sM8DOl7tvOIe0DKWbg2oOtgAVWBRG/wqCfOJEvupmE?=
 =?iso-8859-1?Q?unkrZEkMeRYUvoH0AcczTHKthXKLPrGAfancTrXVF+U2OoH70r9qPiZmzr?=
 =?iso-8859-1?Q?XW+3K39N1DxDiXslwte7YSqInmc9hLNFLGX1tPDmwMfyTDaO+nLGxYZUTT?=
 =?iso-8859-1?Q?kSO1dcibpLB7N2mDjEi5lPaRZ1rGWKByGNopZTRHXd2aouXkpFeD2FNwdz?=
 =?iso-8859-1?Q?inU6jCDI57MdWg9o+w8RjrtyJIxFE5CbQCmYWqGJIUVUiQzLZq1bNvCeB1?=
 =?iso-8859-1?Q?YH4bjF82hALWtT4bmkDffmHItSWMn9g7dZfGwS2lrDSSzMisb7UhmL7QHd?=
 =?iso-8859-1?Q?hho6j204d78oTS701dDRMdRT5KLtFPqqbvtrzWcdZVp7eGhGyTTjdH4UmW?=
 =?iso-8859-1?Q?IkWDjOIwDMmMRpqDSzP2zq4O1FELdne7VWbZ5Hu7/ZtdAT6WQd56pSOn7t?=
 =?iso-8859-1?Q?EWOoKP7GdKTArrqZwizu0VV9zACBx/HltpmO5EpUc56Q1pvQGjfqJZ7qTU?=
 =?iso-8859-1?Q?V/u0nPc1XmMTxvbHw0+vkOxiWWpkrmOtYXLjOkQRIYHWAtIP/4gEORN5cw?=
 =?iso-8859-1?Q?j0W8UKRu7XPmnPX29WQnSlwL7l0vNIeyh+yNdDkcBZ0IBBfkqD6GUkkHjz?=
 =?iso-8859-1?Q?G1T+Rlj0nDHb2wyFIryokVikpyj5BiErUOgQ9Gw4mgcNXGqL+LkTxbJXQ5?=
 =?iso-8859-1?Q?teLzNWf6xR3Kl/Xtc/RZjBIFDtIsIMy5uAdp9v+V0JeyMZN6w5teKwYQnC?=
 =?iso-8859-1?Q?+tumZn44g4MtSV/3zMJo3V1GpPBrHEKiJl7BwBU/WwOT1AllXtDPeBqJmE?=
 =?iso-8859-1?Q?UUKkPDi5GT5fcNqE2TVtH6S1f+x3NX7/Db83ein3w8ouFS5tlD0jxA4Jza?=
 =?iso-8859-1?Q?J5q1hBgpoqz0Z9KBcAcHo+diMaV5/T3ozd4j/uMHl3ZjvDRWfRGIjKTu/F?=
 =?iso-8859-1?Q?SmPCE2z315hQgn0gQrsFtbKF3C9sIG7RL7c6p511ZBwVNPd1lCeOEAFNGt?=
 =?iso-8859-1?Q?YOdX45mMZzZgL2oRMMZ826LkhstGOylpPSPhfkiXnmBE6V85Wbjdr77zgj?=
 =?iso-8859-1?Q?Da9t4fXVSQPriLnsxmPusyGhHiE7XxhX52ihsqePDY42Igqq5b/OzEWRjO?=
 =?iso-8859-1?Q?SRxDyAnIT6EDTD7t5KlTZqmaXkvM1V0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af233bef-3d44-446c-42ed-08df057b3a4c
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:11:32.7594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcDRmzMC+EHRS6cCeZg2fCgcXx7t9l2DAnA/RL792+FEeEWeps37M1NTpD+ZWWSW7QsOqvGZ+zCm4VdeW1rpUvySneuox4eSfnW03pOjApU=
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

On Fri, Aug 28, 2026 at 05:39:12PM +0800, Daniel Henrique Barboza wrote:
> Add a common uart FDT helper to be used by 'virt' and the future
> 'riscv-server-ref' board.
> 
> The 'tt-atlantis' board is left out of this patch because it's going
> through UART related changes and its FDT might change soon, thus it's
> better to wait for the final DT to be determined and then we can
> evaluate whether it can share a common helper.
> 
> The "/chosen" and "/alias" changes are UART0 only so we're keeping them
> out of the common helper.  The board can set both manually as
> appropriate.
> 
> No FDT changes intended.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 29 +++++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 35 +++++++++--------------------------
>  include/hw/riscv/fdt-common.h |  5 +++++
>  3 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index d2ce93ad28..0107aadaad 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -22,6 +22,8 @@
>  #include "hw/pci/pcie_host.h"
>  #include "hw/riscv/aia.h"
>  
> +#define UART_STD_CLOCK_FREQ 3686400 /* 3.6864 MHz */
> +
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size)
>  {
> @@ -799,3 +801,30 @@ void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
>          g_free(name);
>      }
>  }
> +
> +char *riscv_fdt_get_uart_nodename(hwaddr addr)
> +{
> +    return g_strdup_printf("/soc/serial@%"HWADDR_PRIx, addr);
> +}
> +
> +void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
> +                           int uart_irq, int aia_type,
> +                           uint32_t irq_phandle)
> +{
> +    g_autofree char *name = riscv_fdt_get_uart_nodename(uart_mem->base);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, uart_mem->base,
> +                                 2, uart_mem->size);
> +
> +    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", UART_STD_CLOCK_FREQ);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
> +
> +    if (aia_type == AIA_TYPE_NONE) {
> +        qemu_fdt_setprop_cell(fdt, name, "interrupts", uart_irq);
> +    } else {
> +        qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
> +    }
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 717a01da8d..3e40513dc1 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -418,39 +418,22 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
>      }
>  }
>  
> -static void create_fdt_uart(RISCVVirtState *s,
> -                            uint32_t irq_mmio_phandle, int memId, int irqNo)
> +static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
>  {
>      g_autofree char *name = NULL;
>      MachineState *ms = MACHINE(s);
>  
> -    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
> -                           s->memmap[memId].base);
> -    qemu_fdt_add_subnode(ms->fdt, name);
> -    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -                                 2, s->memmap[memId].base,
> -                                 2, s->memmap[memId].size);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
> -    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> -        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
> -    } else {
> -        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo, 0x4);
> +    if (s->uart1_present) {
> +        riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART1],
> +                              UART1_IRQ, s->aia_type, irq_mmio_phandle);
>      }
>  
> -    if (VIRT_UART0 == memId) {
> -        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> -        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
> -    }
> -}
> +    riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
> +                          s->aia_type, irq_mmio_phandle);
>  
> -static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
> -{
> -    if (s->uart1_present) {
> -        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
> -    }
> -    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
> +    name = riscv_fdt_get_uart_nodename(s->memmap[VIRT_UART0].base);
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>  }
>  
>  static void create_fdt_rtc(RISCVVirtState *s,
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index a45b063f66..c8b25348bd 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -128,4 +128,9 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>                                     uint32_t *aplic_phandles);
>  void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
>                                      uint32_t *intc_phandles);
> +/* Caller must free the returned string.  */
> +char *riscv_fdt_get_uart_nodename(hwaddr addr);
> +void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
> +                           int uart_irq, int aia_type,
> +                           uint32_t irq_phandle);
>  #endif
> -- 
> 2.43.0
> 

