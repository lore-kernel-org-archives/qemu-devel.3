Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13487C61DB9
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09TA-0006Bl-VM; Fri, 28 Aug 2026 23:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09T9-0006BZ-DD; Fri, 28 Aug 2026 23:10:59 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09T7-0006D4-5L; Fri, 28 Aug 2026 23:10:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq3namBoNO+WS6XhwV9eoLXra/WIUEeQQ36XxYUYewrtt884xKOss/BPyFd5jXwYhLuDHpBEwr+jMTsVB45qU84XxMFb4CgYvpJjq7zd35Fu9b7DVhnEGReA3J3+vIurxnM1rf+PPk9rm/QHZhhidRj2hPh7WWE2+Zs69pVI1y1CW4MzbJZnqCByLVFGs96cQqWMkRC71OnbwAKaKk0f7im66mK3KnYFvUfJ0bAIIcOjeAafS2dsZKL97o6mH/fPh/Ky1gC9G3+VG+vzZZK2CWeU/WA/eDbJmoJamYI1+pkl13Yx1r89KeIHmAjcz2wr7W+cn3HxUW1ppHmwByw24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxQ4JQnzepLWBthakPYKSzD/nUWHGzdj/vlcCUYF6qY=;
 b=U85iNJNkzTL66LdknBEgfUxm+O5WsS4G9jxEugAkQmCTDB0gCkUFTHtxN4CYUS/LFQ+rLOkcN3k8rOKOHVlFrY5sDoE6IMwK+kEz3CS7MoTpzfo7NNdYQAiuSZcOYsrO4tnknbcebbFy2Kjc//1knFcNNtCRa+X9PC/kLT8CIHuRelC+5r6w/WQ3ewSs5Mw0lw63pl7bZxrDXNHJ1ynN4GfLw6fAtVxIS7aXERb8J23v3XmjTrvqp7TwCXuI5jaC56nnzoubcpO+zIHE7hlYo+veDuqCRmLtb/+DOlz9r03hWFoAl+0EG5vvA4CXyib+2t9jjYyMD5x0Cm8CPE4VwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxQ4JQnzepLWBthakPYKSzD/nUWHGzdj/vlcCUYF6qY=;
 b=eGvsJJBBlNha6h39U5C1UrlEfykVSVtnVDcO1miz5jOz3CvoXSdpurybaHfp5XI4tc55xQRElXY04fr9Ld9K9OsjcPN0hqPjrmRUTx171LOftRwvFfYG71Z681XycXOR3e2mNkcsqTWox1ojL2SLz8UyQ3j4jh4Ua90yu4IgvNgNtELwESDaiZWP3YsaLoS6Mx9If5EebfpRbZN63VukqFYQXLSC9MpmBjLlTVFPSXyodXZUaumQYV4sjGie+U6UOJqdvPiiZybvsqLl3/PBz7I22QrAnkO2T+DGHxo6Vuc9GpiMnpzDIKvdfW9ThPX1R5S1yc4ofO6/lfNZCqjvKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:10:52 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:10:52 +0000
Date: Sat, 29 Aug 2026 11:10:47 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 09/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_socket_aclint()
Message-ID: <apJNsIEg5-S-votC@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-10-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-10-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4ebb19-8a09-4c6c-f073-08df057b221e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yH4T7oklykRnkZFqHtFWrGu5AuqzDx1XIqPfWJhOsvSttJqmbfcRdtBhuFPb7qEl9QcuSRfeIF/oQ/0UcmrftcwUPnPHn6A2MhPmd1XO2NeBsBgzwqBGSCd72B5b1VQE7Vyv8sl8abLJocGRpdzY5JgnotK5XMp7xryNYo/OYFP3HQEGha7Ih5odJi8C2xo01eIimgydZCA4uN8ksrl3n/DW5NKsrqnxEwvjSvXpfqp0DGhtGN5x8ngIZB0SxNDhKWInEa1VHg4orLmAx3vD021LbmXshqH2jWM86sAxFkPrK8EJvV5fZ42Mws6VwuQGXGl9Y3+HRdGrHpgaM7SADcjTVsydB9N5KSL7nA8Nqh9bUgIJkCcG1lLGLHjPSMsWK22+On8wvGoLxIxChfT8zrnoOSNBeSnFBH9wrDr6A1z5cefRLK4iQS0Kps/P/8IZA74pP2S476NpExjanU3Szi+20ZiOLhXgTufJ5jJfUFHRHBINmo10pljkopI9kms8FAILmvC/DUfqDwf04yHuoHew4WmkYAcrOznI1ZKqZgwOrYNvLHQhnhSLnCGDaBfTRRa1HBGakIJnF9XnFFXB6UlE3mWq4VsQosYD4tuO0advW8Ugy1Pti1h46ZBhH+znoug9LOJof99M2VSowHPo856J82Ccp+GpanPcR8cT4vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sRrvAYjX+9WWOJ+7oQZycLNvgqjWjlxglEzMfpJoxstkLSOsvi0qamKaRc?=
 =?iso-8859-1?Q?66TK/rSg5IIJrL000+IcV7j7WL80hOwKi5KT7MTVLqy2xRHMgmHA7SbK1h?=
 =?iso-8859-1?Q?dS0lw4t4a1XLDA73HEt9FSbITQiUaEYY2ZcD0HpZWMQk3+1xpXEq+9Yv1O?=
 =?iso-8859-1?Q?BxMqYnhmGttz5weREMBIbIjXhw/ATtrKW0rtSqyglUFjlNs2cnwNtOJCoh?=
 =?iso-8859-1?Q?wuBGu/F1WTsG0hg07PkIGSSH1xkTOyKMI0O9AV67tRO/quX1jXmXAH/3AQ?=
 =?iso-8859-1?Q?xDXyaIJr8RuCs26+1tmZcI7wf8D1iLJ9RMUVZ/BOJ+sxt80fsJir9KKWig?=
 =?iso-8859-1?Q?v7YxL7I+JOMJbPChVIoOoOqBlQa/Zp6PaATe+5HIgjqKtFo4aUnBPH1jyW?=
 =?iso-8859-1?Q?842nR8fj5J2DRgGr/RWYIUTdK1KYOtbBFOo8G6klEDY8Cki8wbXbZW4e1S?=
 =?iso-8859-1?Q?kbrG4yR3NH2u8lZb2t+8YZMbwT9h+ppNlW4TkqLpPH7+RgJFq+/V07k0DF?=
 =?iso-8859-1?Q?YwTWX424fIW/dgXmTki8DddifSBOxT8sGudSY/NyOA2AKFdnNzzrsiM8/g?=
 =?iso-8859-1?Q?TYg5T9Pbl0GQx6dtZLT1vbOt2FUPrQUBAtQBvBBGc7/AVOG3skyWy6OaMN?=
 =?iso-8859-1?Q?DZGND0jw2nJM/T+9UpPwnom/3cUQgyvd/QP7HbHyCgL11VinaQWqRCBbnm?=
 =?iso-8859-1?Q?uwwlAFAqgWbCINHGFLNkCRx8HUBfkgArHVMm/79rbUhy5u/QnIa7GnmNJx?=
 =?iso-8859-1?Q?RnXfKLLbP6+0F81zIt9ruY2Md9+DZHw0/jiBimCQ2U4mpUNGmOQQF5kHZt?=
 =?iso-8859-1?Q?qlX+3QHN/gDaIa6bj0XOxcGj41EgPdzrtOwspj+TNQZKdS4BBARQPRzdgc?=
 =?iso-8859-1?Q?2CLYROIqGQWUQzooR4YrvaNlSvr9LwhyAXpQmdWWYTg1XdU7BFcNUcOftE?=
 =?iso-8859-1?Q?IiBJV1i3mT8cDmeCie2nh1rlhID8zxHPcKfcXtO1N3sVSUKZUeDxDGe+eJ?=
 =?iso-8859-1?Q?DsERygmplmkXWzkpRCARnWAG0hxVmIWSVkgSQNfD0CqgsKjrHnCa5AT6vG?=
 =?iso-8859-1?Q?fWoR3aIWjZyCbegrR81zlLHVLGAS4A6+BtXJQST2CPL+821TrAkMFzlP4m?=
 =?iso-8859-1?Q?MNbBGewTxaDQviwPsDPUQWJ9EvlvJ0JCkL/lpGw8tEc1q8XesvLfmhIndJ?=
 =?iso-8859-1?Q?ZOW10Ejtp54PwP4dlx7cg+0zSVPaklxNQp5313YEoppNocFGnRRMqXc0oE?=
 =?iso-8859-1?Q?2mduQKkEpm2YVh4IcRvnrgZGYozw6wod1qmqtLmiTqlJdcLM4steHi6VxH?=
 =?iso-8859-1?Q?T+pOmHXn/pawMxWtL8j4VJgC1ZaiXJ2+lBhi1wMYO3eKs9aEBH+edgndgf?=
 =?iso-8859-1?Q?WM8927BUaplpiPE0v/7rIhmN821EZYnur34L7Q4vU39xhafIiaxXZv5RVD?=
 =?iso-8859-1?Q?bpMMNirq1Z79n+U20IgiK1Q3XWXUl1vCvXK99UXhvkWzAhG/Ai20Phe49M?=
 =?iso-8859-1?Q?HbHfi/LeRkQg5lupUdnZgWp9DuBFGv6khrg9BxVv/FXnTg9NUVUBQRrs2F?=
 =?iso-8859-1?Q?03Hudv0GkdpkqHdZApusCaSX/RVoKnkueIIc3R0kHkrR4ROvm8ckyk1OHX?=
 =?iso-8859-1?Q?dQ0GsGEmuwIVHxx9h4NB4XKinJfrj3YI3HLtJdrbDjgmLunHmQAufkw6Ln?=
 =?iso-8859-1?Q?3njHCshvUC2sRc4UESLr1LoVNM8D8q7RTVudkpTWmJ+egMqXP82wxzcxzv?=
 =?iso-8859-1?Q?LzbqsqdN7wC21KC/Iy/ZDNMqZOgBFz7elSmQlUN4sKEGrbPL8DESSd3rb3?=
 =?iso-8859-1?Q?vgNJFXxxcKGm/ECM5iiefpbH3vutEAw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4ebb19-8a09-4c6c-f073-08df057b221e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:10:52.3587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGqU1KHVdK8aL3vXnLIxAgAhju5E0ATHjeCi/f6koYDiNbih92XB5B+HJuRylnYLIRSRy6qApRq/JHFprT92MMGZ4NY76Km4UPDJiBWIkUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5574
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

On Fri, Aug 28, 2026 at 05:39:11PM +0800, Daniel Henrique Barboza wrote:
> Yet another FDT that we want to move to a helper to avoid copy/pasting
> code to other boards that will use a mtimer.  In particular the future
> 'riscv-server-ref' board.
> 
> No FDT changes made.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         |  97 ++++++++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 102 ++++------------------------------
>  include/hw/riscv/fdt-common.h |  11 ++++
>  3 files changed, 120 insertions(+), 90 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index d815c5adff..d2ce93ad28 100644
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
> @@ -702,3 +703,99 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
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
> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
> +                           addr + RISCV_ACLINT_DEFAULT_MTIME);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible",
> +                            "riscv,aclint-mtimer");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
> +        2, size - RISCV_ACLINT_DEFAULT_MTIME,
> +        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> +        2, RISCV_ACLINT_DEFAULT_MTIME);
> +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
> +                     aclint_mtimer_cells, aclint_cells_size);
> +
> +    if (props->numa_enabled) {
> +        qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
> +    }
> +
> +    g_free(name);
> +
> +    if (props->aia_type != AIA_TYPE_APLIC_IMSIC) {
> +        addr = props->aclint_sswi->base
> +               + (props->aclint_sswi->size * props->socket);
> +
> +        name = g_strdup_printf("/soc/sswi@%"HWADDR_PRIx, addr);
> +        qemu_fdt_add_subnode(fdt, name);
> +        qemu_fdt_setprop_string(fdt, name, "compatible",
> +            "riscv,aclint-sswi");
> +        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                     2, addr, 2, props->aclint_sswi->size);
> +        qemu_fdt_setprop(fdt, name, "interrupts-extended",
> +                         aclint_sswi_cells, aclint_cells_size);
> +        qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
> +        qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
> +
> +        if (props->numa_enabled) {
> +            qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
> +        }
> +
> +        g_free(name);
> +    }
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 83a4b7710d..717a01da8d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -180,94 +180,6 @@ static void virt_flash_map(RISCVVirtState *s,
>                      sysmem);
>  }
>  
> -static void create_fdt_socket_aclint(RISCVVirtState *s,
> -                                     int socket,
> -                                     uint32_t *intc_phandles)
> -{
> -    int cpu;
> -    char *name;
> -    unsigned long addr, size;
> -    uint32_t aclint_cells_size;
> -    g_autofree uint32_t *aclint_mswi_cells = NULL;
> -    g_autofree uint32_t *aclint_sswi_cells = NULL;
> -    g_autofree uint32_t *aclint_mtimer_cells = NULL;
> -    MachineState *ms = MACHINE(s);
> -
> -    aclint_mswi_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
> -    aclint_mtimer_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
> -    aclint_sswi_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
> -
> -    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> -        aclint_mswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -        aclint_mswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_SOFT);
> -        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
> -        aclint_sswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -        aclint_sswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_SOFT);
> -    }
> -    aclint_cells_size = s->soc[socket].num_harts * sizeof(uint32_t) * 2;
> -
> -    if (s->aia_type != VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        addr = s->memmap[VIRT_CLINT].base +
> -               (s->memmap[VIRT_CLINT].size * socket);
> -        name = g_strdup_printf("/soc/mswi@%lx", addr);
> -
> -        qemu_fdt_add_subnode(ms->fdt, name);
> -        qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> -            "riscv,aclint-mswi");
> -        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -            2, addr, 2, RISCV_ACLINT_SWI_SIZE);
> -        qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
> -            aclint_mswi_cells, aclint_cells_size);
> -        qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
> -        qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells", 0);
> -        riscv_socket_fdt_write_id(ms, name, socket);
> -        g_free(name);
> -    }
> -
> -    if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        addr = s->memmap[VIRT_CLINT].base +
> -               (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket);
> -        size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
> -    } else {
> -        addr = s->memmap[VIRT_CLINT].base + RISCV_ACLINT_SWI_SIZE +
> -               (s->memmap[VIRT_CLINT].size * socket);
> -        size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
> -    }
> -    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
> -                           addr + RISCV_ACLINT_DEFAULT_MTIME);
> -    qemu_fdt_add_subnode(ms->fdt, name);
> -    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> -        "riscv,aclint-mtimer");
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
> -        2, size - RISCV_ACLINT_DEFAULT_MTIME,
> -        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> -        2, RISCV_ACLINT_DEFAULT_MTIME);
> -    qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
> -        aclint_mtimer_cells, aclint_cells_size);
> -    riscv_socket_fdt_write_id(ms, name, socket);
> -    g_free(name);
> -
> -    if (s->aia_type != VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        addr = s->memmap[VIRT_ACLINT_SSWI].base +
> -               (s->memmap[VIRT_ACLINT_SSWI].size * socket);
> -
> -        name = g_strdup_printf("/soc/sswi@%lx", addr);
> -        qemu_fdt_add_subnode(ms->fdt, name);
> -        qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> -            "riscv,aclint-sswi");
> -        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -            2, addr, 2, s->memmap[VIRT_ACLINT_SSWI].size);
> -        qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
> -            aclint_sswi_cells, aclint_cells_size);
> -        qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
> -        qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells", 0);
> -        riscv_socket_fdt_write_id(ms, name, socket);
> -        g_free(name);
> -    }
> -}
> -
>  static void create_fdt_socket_plic(RISCVVirtState *s,
>                                     int socket,
>                                     uint32_t *phandle, uint32_t *intc_phandles,
> @@ -348,6 +260,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      bool numa_enabled = riscv_numa_enabled(ms);
>      bool is_32_bit = riscv_is_32bit(&s->soc[0]);
>      APLICFdtProps aplic_props;
> +    ACLINTFdtProps aclint_props;
>  
>      riscv_fdt_create_cpu_socket_subnode(ms->fdt,
>          kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
> @@ -355,6 +268,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
>  
>      intc_phandles = g_new0(uint32_t, ms->smp.cpus);
>  
> +    if (virt_aclint_allowed() && s->have_aclint) {
> +        aclint_props.clint = &s->memmap[VIRT_CLINT];
> +        aclint_props.aclint_sswi = &s->memmap[VIRT_ACLINT_SSWI];
> +        aclint_props.aia_type = s->aia_type;
> +        aclint_props.numa_enabled = numa_enabled;
> +    }
> +
>      phandle_pos = ms->smp.cpus;
>      for (socket = (socket_count - 1); socket >= 0; socket--) {
>          hwaddr memaddr = s->memmap[VIRT_DRAM].base +
> @@ -373,8 +293,10 @@ static void create_fdt_sockets(RISCVVirtState *s,
>                                         socket, riscv_numa_enabled(ms));
>  
>          if (virt_aclint_allowed() && s->have_aclint) {
> -            create_fdt_socket_aclint(s, socket,
> -                                     &intc_phandles[phandle_pos]);
> +            aclint_props.socket = socket;
> +            aclint_props.num_harts = s->soc[socket].num_harts;
> +            riscv_create_fdt_socket_aclint(ms->fdt, &aclint_props,
> +                                           &intc_phandles[phandle_pos]);
>          } else if (tcg_enabled()) {
>              hwaddr clintaddr = s->memmap[VIRT_CLINT].base +
>                                 s->memmap[VIRT_CLINT].size * socket;
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 8207cfee7b..a45b063f66 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -63,6 +63,15 @@ typedef struct APLICFdtProps {
>      int aia_type;
>  } APLICFdtProps;
>  
> +typedef struct ACLINTFdtProps {
> +    const MemMapEntry *clint;
> +    const MemMapEntry *aclint_sswi;
> +    int socket;
> +    int num_harts;
> +    int aia_type;
> +    bool numa_enabled;
> +} ACLINTFdtProps;
> +
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size);
>  void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> @@ -117,4 +126,6 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>                                     uint32_t *next_phandle,
>                                     uint32_t *intc_phandles,
>                                     uint32_t *aplic_phandles);
> +void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
> +                                    uint32_t *intc_phandles);
>  #endif
> -- 
> 2.43.0
> 

