Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F022EC61DD3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09SC-00054V-9G; Fri, 28 Aug 2026 23:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09S8-00053u-4v; Fri, 28 Aug 2026 23:09:56 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09S5-0005sY-5W; Fri, 28 Aug 2026 23:09:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBB376IhBeMoqvFXNJOyj+qWu7G5puaUHgkWbZ6FY3PhVEVKWb4a7MkoQifIlssSlO5iOPOgxsNq0s9rs2hdkNygN08lx/2NJzPxH5gZWT+aJDTJoxx7A8oDsJhhUYynTHGVCNsLtgpiFBWmVzUCsRVwqI0L7zeRcB/QV4qXhnetsd34UUR8IEYT3JmLNznXMhKDjEEuP+8CCU3hfN8tTB1yqkX9UZRrhkzTV+wxcGKoxPGAIhyPuhAv2lI2LC+t1PsBirXMb6mvXo0zGdsuSEqRuRdIOg55PHJkDPtGrNr4O0fYc4RH4jITAcQTWIotQJhlnmZ4fohXa8vSChJjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gfPrH9L9Mu+L45vuulEh3yjVeah+KvwDJVqBFeN/io=;
 b=fbsS8ymvRjNgjh7ljpb8xiI+5h2OEdRFxWMGc+gmymfK2HbVlrwN2XalhVvPdlQjfIJMyTRm2N/+I/vFZQ/8iANrscvQifiRSiUh9R5Pr+aaBQ4vAm4OBjnd66pJ7zsUoEJUX/3UoFamZ5DpHy7tWIVVD3n5ngB9OSjohcELaZY/MIeOtVWDMSGN0u7tkbDAYuhj6P9EASr2WSMBbTe/d4A9pKUYhx5eH2bT90ly/d4j7+vGQA96KD6jR1DOCSz+AXe2qlEyQlpEcxfuqPze5q4giGn77vmuVH/W8xcT4OgQSNSr492g0Wjpgl77NCd7ca3jH4PAaO+ermUGfKJAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gfPrH9L9Mu+L45vuulEh3yjVeah+KvwDJVqBFeN/io=;
 b=wIdAx2L5oKpcjkrJKru1sIaoCIsPT4dK03lciqayIAynMmENQDnXk4H0k6xW3mkwYN5vqX4WNdC/TU2yZNEfPYKtkvYXQsaietFsLoWFjZMjNmPnT6IbQJcRpxA6bfQME4JbDyHKnb6I25fDOyAW0hEUWc4FA2Y7sUNDaKkIkajgl5KEo53Ool8GFROBfXyAeAUnbHCGr72GObWbCdFn/2Xa/o8Z95XKbouvB7sddJbWUUgBZSaUwkc1ESi3ujNjc5T4SXM5gwhBxIg33AeL+2UasHtUjlRTzgSyC/CQLBP8gv3tyqreWMQa50casrBGpcnYb4x/n2Xp++fuLukElA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:09:47 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:09:47 +0000
Date: Sat, 29 Aug 2026 11:09:41 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 07/15] hw/riscv/fdt_common, virt.c: add
 riscv_create_fdt_socket_aplic()
Message-ID: <apJNbcvaSsaFK4fG@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-8-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-8-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::11) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b128a14-8bcf-498d-b855-08df057afb37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: azWP4dKr0kKfdUdAQ6+wsIUapLEXaxxtSmG/ECuSDYTzA12XGXVqJOOfsdXRaO/LR4YD5FBnzeMulif1KQfbLPiQyn+utEQaNT/l2dTH2kimfliZREmJlTnlG31M4Xpn8jxovB9rHY6cUf7o1p4V9G20xi7xdYmzK8IFunyYoiLveWj7F+ABosIDeSGPtPOgP2K1dlG2qWiCjRThZqRyhFGvJKTNjY1Jb7X1yVBQBXRDIUsDdElijl/n+c+fR23SkZRt+MnFRA5+HYiIRuH0RYDgQiJPWq8K5pqbnxyEjC6LqG5eT9eJA+uQh3Y7weS9c7uHSSS8MkJxrU6QIYpyLZKZjDQRcG2z0/HTDHKyZgQ/gYjBfB6zDIbUJ35t04ZcjvqmHxkaM6nP8OL9QnIYOyvHoTjd+DjQxD1qE68zVC3gBsFc/HE1EEn+9mHsmxtTqg8bBA+BmdUHcm8YcAQHQGUCCAJMzkdwLX4xaYwhEVazcV0Eqd8OMz959CnwOTwfIYVaz9fzpLiAKbGH1D7IJ4nRF2sjBZeLDRSpM6gNNZoClVdy1exrtUIhyMS6brMD1UaOZdGzfG8oI4BMH7uY+MbGL9xzzyd8achdgO0ogJ0FqS4A5yuV9iGyyGLM4EHQ3jTC3ked/5c6eFCU/n2/HUk6TkvwvUHOOqyRM4XwDWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ip79ZUyar4NqNh9Cdao6giAa/GbYIskudz4DHXWEHgvv2b9nBJ2ETOwVqV?=
 =?iso-8859-1?Q?1swhwi5cgE9a/HVzi6cktZRSoZlUf1qtseExT43cHbKMh7VnnsAXk+NDtk?=
 =?iso-8859-1?Q?d4jZh0VuqR3YKwkzJsFWguqBzMWdocfClwM6WPrVGxziXykfMZSSGHc9TV?=
 =?iso-8859-1?Q?iXm+qfRiTihpWBwgLN0Vq6A0iwnD9+vQ5P01jY4zWDlPDwyAK2PH2gujPC?=
 =?iso-8859-1?Q?gS+k9ACpIW0iAaz1ZL5SnDR4/gGoBXtvXop1X5rYUwuJh07szyaHeGyvZC?=
 =?iso-8859-1?Q?aKTNMrrEodyaAuBeb17D2+Ti3kRlVwc9mFAxPNlyff3WODTsmgUkOG9UGV?=
 =?iso-8859-1?Q?Qfs+0ZGb3LpNb9i8j5SyIzn3nwgrQg6uD/mp7vHlWl32E13M8OGqNjiMLq?=
 =?iso-8859-1?Q?osYttkJ6kLB7fisEIcfE6Hz484Ge63GAPnoDBh2wIp0KY/M5T8kOGf0ZUc?=
 =?iso-8859-1?Q?mcxPgMJHdffGb4nh7tk219Ib58YEir9LrSOaC9vBvcAngV+FolYEtF1pN2?=
 =?iso-8859-1?Q?IdZ2oEkqHBHVaI1yHRr9dyFmQbNwx2pDfhwVd6p2InARv98zwB4IFWAZX5?=
 =?iso-8859-1?Q?t/04YXur1RLKDE0CqrsvlHlGyki3yXCKFjT0nQ7LGOeJQU1+AwaOhtaJ21?=
 =?iso-8859-1?Q?/ZqnF95Q28KCoIZcYaTRhZXxDq3YgC6k7LLnXUDjM/mbKGuUHb1LHc00V7?=
 =?iso-8859-1?Q?4BVZ/DDXPfh1C1UqX4GCumJ6FNY9iQSXxPQb4fM8EB4TioJhgQzD02bkpO?=
 =?iso-8859-1?Q?7vwIhSEoKaFHt0+QzJkwcjDzywwJlYi300aiyoytio/VxPfddUaDZSR9kJ?=
 =?iso-8859-1?Q?YLR4r9Og+PV1Zq89jg5W/w3FkYZzm3DYlHVR+TJt+oWKjACUbzfk5Dkkd7?=
 =?iso-8859-1?Q?wySkjtXIkiK+g4O3zW5ZTzRNbO7ifCFmm78FMK6kKERwJuM6MMQAKNoM4I?=
 =?iso-8859-1?Q?lTrrULGYwid/iwTr/rCrOAiU/DruMYBpTbhHkNv8SfRuI1oGGkaALHtoX8?=
 =?iso-8859-1?Q?887zrryEh8jFdzso0qMbZMdLb56FtfSXwg7Q7f8m5hQSIo9rahAcTtUDXy?=
 =?iso-8859-1?Q?XBlyh8v0r4IJH9DSGxysIMKyye9+kKk11PAwUTtJTFMGucazhINhEH/kjM?=
 =?iso-8859-1?Q?JrQLch7T/9AgGLrbvDO5kDg+m8FlGyVtuAOmg98zsLrtAKD0WoHh38YM0k?=
 =?iso-8859-1?Q?JMGAhwNijimCr5WsmNuWYqu/XCgpF1Nb8lLgz3ScCF0ttuKYX42uiXMAYj?=
 =?iso-8859-1?Q?NvV7TY5dqKuaXMCy97e90BOhGXC0IdfNY9rJqh3DEbxKX72XLl4xywW0vm?=
 =?iso-8859-1?Q?ASZLX5+qWL8OeEgv25YSiowJgffmiN2U+h4CYvJd3M6TrssGxdOxlr12iw?=
 =?iso-8859-1?Q?bteKgSiU+IX3muNPuE4yOy+tY+f6G5HI0LnE4XP1FIZozfJxCTexrr0zV+?=
 =?iso-8859-1?Q?hCgn36F5sSeVGV+n6bRZ0t4SBMhI7ScVJjdZLgz9j1lz9/GDya45nHkD/M?=
 =?iso-8859-1?Q?KAgkKMPKk+3f0iL6LyyxkeNnAmjO8WWS/8MILMD8WH5NpuwSRMnScob3w1?=
 =?iso-8859-1?Q?wc7P+r1HaQo0CJ1i7Xq02kFZdViQVbORl+H548T9/EDwEq8dgNoK7Hnpko?=
 =?iso-8859-1?Q?5lXmMoXiCOeom9z8tGyoVMDlmu+MrzcborMTksh9T21RFBK7hImgfBUYfZ?=
 =?iso-8859-1?Q?MjMyXlAxE9dytulYTdrdzGsSfI4S5cyTOZlVeJYYXMkNwMU/xJyIjktR6a?=
 =?iso-8859-1?Q?Y+CX9y0wtugSoETV6OB11j45lMKawU2NQU/AMcug4LvGcIk03FH6gMP0Sm?=
 =?iso-8859-1?Q?W5GDRm/4a8V5xwrA4RH7Dsgw+ilz9ic=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b128a14-8bcf-498d-b855-08df057afb37
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:09:47.1756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrwoQmV6vA+3DKeDYlSsFsHaPMdG2ZJT3iQ9CT2Ay72A6mRwhHl4wb32HGjC0oh2EW9Ur8WRH9rWfZFmO5twU59GtFz6JlNKLsXru24VA1Y=
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

On Fri, Aug 28, 2026 at 05:39:09PM +0800, Daniel Henrique Barboza wrote:
> Similar to what we did with 'imsic' in the previous patch, including
> creating a helper struct to encapsulate the extra arguments required to
> create the FDT.
> 
> TODO: I believe the tt-atlantis board can use this same helper too.  We
> just need to verify how to map the phandles used by it and what the
> helper is using (which was inherited by the 'virt' board).
> 
> No FDT changes intended.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 109 ++++++++++++++++++++++++++
>  hw/riscv/virt.c               | 139 ++++++----------------------------
>  include/hw/riscv/fdt-common.h |  19 +++++
>  3 files changed, 151 insertions(+), 116 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index ae24ad0011..d815c5adff 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -11,6 +11,7 @@
>  #include "qemu/error-report.h"
>  #include "system/device_tree.h"
>  #include "hw/core/boards.h"
> +#include "hw/core/sysbus-fdt.h"
>  #include "hw/riscv/fdt-common.h"
>  #include "target/riscv/cpu_bits.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
> @@ -593,3 +594,111 @@ void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
>                           imsic_num_bits(props->aia_guests + 1));
>  
>  }
> +
> +/* Caller must free string after use */
> +static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
> +{
> +    return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
> +                           aplic_addr);
> +}
> +
> +static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
> +                                 hwaddr aplic_addr, uint32_t aplic_size,
> +                                 uint32_t msi_phandle,
> +                                 uint32_t *intc_phandles,
> +                                 uint32_t aplic_phandle,
> +                                 uint32_t aplic_child_phandle,
> +                                 bool m_mode)
> +{
> +    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> +    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
> +    static const char * const aplic_compat[2] = {
> +        "qemu,aplic", "riscv,aplic"
> +    };
> +
> +    for (int cpu = 0; cpu < props->num_harts; cpu++) {
> +        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
> +    }
> +
> +    qemu_fdt_add_subnode(fdt, aplic_name);
> +    qemu_fdt_setprop_string_array(fdt, aplic_name, "compatible",
> +                                  (char **)&aplic_compat,
> +                                  ARRAY_SIZE(aplic_compat));
> +    qemu_fdt_setprop_cell(fdt, aplic_name, "#address-cells",
> +                          FDT_APLIC_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(fdt, aplic_name,
> +                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
> +    qemu_fdt_setprop(fdt, aplic_name, "interrupt-controller", NULL, 0);
> +
> +    if (props->aia_type == AIA_TYPE_APLIC) {
> +        qemu_fdt_setprop(fdt, aplic_name, "interrupts-extended",
> +                         aplic_cells, props->num_harts * sizeof(uint32_t) * 2);
> +    } else {
> +        qemu_fdt_setprop_cell(fdt, aplic_name, "msi-parent", msi_phandle);
> +    }
> +
> +    qemu_fdt_setprop_sized_cells(fdt, aplic_name, "reg",
> +                                 2, aplic_addr, 2, aplic_size);
> +    qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,num-sources",
> +                          props->irqchip_num_sources);
> +
> +    if (aplic_child_phandle) {
> +        qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,children",
> +                              aplic_child_phandle);
> +        qemu_fdt_setprop_cells(fdt, aplic_name, "riscv,delegation",
> +                               aplic_child_phandle, 0x1,
> +                               props->irqchip_num_sources);
> +    }
> +
> +    if (props->numa_enabled) {
> +        qemu_fdt_setprop_cell(fdt, aplic_name, "numa-node-id", props->socket);
> +    }
> +
> +    qemu_fdt_setprop_cell(fdt, aplic_name, "phandle", aplic_phandle);
> +}
> +
> +void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
> +                                   uint32_t msi_m_phandle,
> +                                   uint32_t msi_s_phandle,
> +                                   uint32_t *next_phandle,
> +                                   uint32_t *intc_phandles,
> +                                   uint32_t *aplic_phandles)
> +{
> +    uint32_t aplic_m_phandle, aplic_s_phandle;
> +    hwaddr aplic_addr;
> +
> +    if (next_phandle) {
> +        aplic_m_phandle = (*next_phandle)++;
> +        aplic_s_phandle = (*next_phandle)++;
> +    } else {
> +        aplic_m_phandle = qemu_fdt_alloc_phandle(fdt);
> +        aplic_s_phandle = qemu_fdt_alloc_phandle(fdt);
> +    }
> +
> +    if (props->aplic_m) {
> +        /* M-level APLIC node */
> +        aplic_addr = props->aplic_m->base + (props->aplic_m->size * props->socket);
> +        create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_m->size,
> +                             msi_m_phandle, intc_phandles,
> +                             aplic_m_phandle, aplic_s_phandle,
> +                             true);
> +    }
> +
> +    /* S-level APLIC node */
> +    aplic_addr = props->aplic_s->base + (props->aplic_s->size * props->socket);
> +    create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_s->size,
> +                         msi_s_phandle, intc_phandles,
> +                         aplic_s_phandle, 0,
> +                         false);
> +
> +    if (!props->socket && props->platform_bus_irq) {
> +        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> +        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
> +                                       props->platform_bus->base,
> +                                       props->platform_bus->size,
> +                                       props->platform_bus_irq);
> +    }
> +
> +    aplic_phandles[props->socket] = aplic_s_phandle;
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 468ec90696..a6ec9def16 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -320,113 +320,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>      }
>  }
>  
> -/* Caller must free string after use */
> -static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
> -{
> -    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
> -}
> -
> -static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
> -                                 unsigned long aplic_addr, uint32_t aplic_size,
> -                                 uint32_t msi_phandle,
> -                                 uint32_t *intc_phandles,
> -                                 uint32_t aplic_phandle,
> -                                 uint32_t aplic_child_phandle,
> -                                 bool m_mode, int num_harts)
> -{
> -    int cpu;
> -    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> -    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
> -    MachineState *ms = MACHINE(s);
> -    static const char * const aplic_compat[2] = {
> -        "qemu,aplic", "riscv,aplic"
> -    };
> -
> -    for (cpu = 0; cpu < num_harts; cpu++) {
> -        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
> -    }
> -
> -    qemu_fdt_add_subnode(ms->fdt, aplic_name);
> -    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
> -                                  (char **)&aplic_compat,
> -                                  ARRAY_SIZE(aplic_compat));
> -    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
> -                          FDT_APLIC_ADDR_CELLS);
> -    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
> -                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
> -    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
> -
> -    if (s->aia_type == VIRT_AIA_TYPE_APLIC) {
> -        qemu_fdt_setprop(ms->fdt, aplic_name, "interrupts-extended",
> -                         aplic_cells, num_harts * sizeof(uint32_t) * 2);
> -    } else {
> -        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
> -    }
> -
> -    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
> -                                 2, aplic_addr, 2, aplic_size);
> -    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
> -                          VIRT_IRQCHIP_NUM_SOURCES);
> -
> -    if (aplic_child_phandle) {
> -        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
> -                              aplic_child_phandle);
> -        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
> -                               aplic_child_phandle, 0x1,
> -                               VIRT_IRQCHIP_NUM_SOURCES);
> -    }
> -
> -    riscv_socket_fdt_write_id(ms, aplic_name, socket);
> -    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle);
> -}
> -
> -static void create_fdt_socket_aplic(RISCVVirtState *s,
> -                                    int socket,
> -                                    uint32_t msi_m_phandle,
> -                                    uint32_t msi_s_phandle,
> -                                    uint32_t *phandle,
> -                                    uint32_t *intc_phandles,
> -                                    uint32_t *aplic_phandles,
> -                                    int num_harts)
> -{
> -    unsigned long aplic_addr;
> -    MachineState *ms = MACHINE(s);
> -    uint32_t aplic_m_phandle, aplic_s_phandle;
> -
> -    aplic_m_phandle = (*phandle)++;
> -    aplic_s_phandle = (*phandle)++;
> -
> -    if (!kvm_enabled()) {
> -        /* M-level APLIC node */
> -        aplic_addr = s->memmap[VIRT_APLIC_M].base +
> -                     (s->memmap[VIRT_APLIC_M].size * socket);
> -        create_fdt_one_aplic(s, socket, aplic_addr,
> -                             s->memmap[VIRT_APLIC_M].size,
> -                             msi_m_phandle, intc_phandles,
> -                             aplic_m_phandle, aplic_s_phandle,
> -                             true, num_harts);
> -    }
> -
> -    /* S-level APLIC node */
> -    aplic_addr = s->memmap[VIRT_APLIC_S].base +
> -                 (s->memmap[VIRT_APLIC_S].size * socket);
> -    create_fdt_one_aplic(s, socket, aplic_addr, s->memmap[VIRT_APLIC_S].size,
> -                         msi_s_phandle, intc_phandles,
> -                         aplic_s_phandle, 0,
> -                         false, num_harts);
> -
> -    if (!socket) {
> -        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> -        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> -                                       s->memmap[VIRT_PLATFORM_BUS].base,
> -                                       s->memmap[VIRT_PLATFORM_BUS].size,
> -                                       VIRT_PLATFORM_BUS_IRQ);
> -    }
> -
> -    aplic_phandles[socket] = aplic_s_phandle;
> -}
> -
>  static void create_fdt_pmu(RISCVVirtState *s)
>  {
>      g_autofree char *pmu_name = g_strdup_printf("/pmu");
> @@ -453,6 +346,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      int socket_count = riscv_socket_count(ms);
>      bool numa_enabled = riscv_numa_enabled(ms);
>      bool is_32_bit = riscv_is_32bit(&s->soc[0]);
> +    APLICFdtProps aplic_props;
>  
>      riscv_fdt_create_cpu_socket_subnode(ms->fdt,
>          kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
> @@ -510,15 +404,26 @@ static void create_fdt_sockets(RISCVVirtState *s,
>          *msi_pcie_phandle = msi_s_phandle;
>      }
>  
> +    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
> +        aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
> +        aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
> +        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
> +        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
> +        aplic_props.socket = 0;
> +        aplic_props.num_harts = ms->smp.cpus;
> +        aplic_props.numa_enabled = numa_enabled;
> +        aplic_props.irqchip_num_sources = VIRT_IRQCHIP_NUM_SOURCES;
> +        aplic_props.aia_type = s->aia_type;
> +    }
> +
>      /*
>       * With KVM AIA aplic-imsic, using an irqchip without split
>       * mode, we'll use only one APLIC instance.
>       */
>      if (!virt_use_emulated_aplic(s->aia_type)) {
> -        create_fdt_socket_aplic(s, 0,
> -                                msi_m_phandle, msi_s_phandle, phandle,
> -                                &intc_phandles[0], xplic_phandles,
> -                                ms->smp.cpus);
> +        riscv_create_fdt_socket_aplic(ms->fdt, &aplic_props,
> +                                      msi_m_phandle, msi_s_phandle, phandle,
> +                                      &intc_phandles[0], xplic_phandles);
>  
>          *irq_mmio_phandle = xplic_phandles[0];
>          *irq_virtio_phandle = xplic_phandles[0];
> @@ -533,11 +438,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
>                                         &intc_phandles[phandle_pos],
>                                         xplic_phandles);
>              } else {
> -                create_fdt_socket_aplic(s, socket,
> -                                        msi_m_phandle, msi_s_phandle, phandle,
> -                                        &intc_phandles[phandle_pos],
> -                                        xplic_phandles,
> -                                        s->soc[socket].num_harts);
> +                aplic_props.socket = socket;
> +                aplic_props.num_harts = s->soc[socket].num_harts;
> +                riscv_create_fdt_socket_aplic(ms->fdt, &aplic_props,
> +                                              msi_m_phandle, msi_s_phandle,
> +                                              phandle,
> +                                              &intc_phandles[phandle_pos],
> +                                              xplic_phandles);
>              }
>          }
>  
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 182c03d8ce..8207cfee7b 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -12,6 +12,7 @@
>  #include "target/riscv/cpu.h"
>  #include "hw/core/boards.h"
>  #include "hw/riscv/riscv_hart.h"
> +#include "exec/hwaddr.h"
>  
>  #define FDT_PCI_ADDR_CELLS    3
>  #define FDT_PCI_INT_CELLS     1
> @@ -50,6 +51,18 @@ typedef struct IMSICFdtProps {
>      int aia_guests;
>  } IMSICFdtProps;
>  
> +typedef struct APLICFdtProps {
> +    const MemMapEntry *aplic_m;
> +    const MemMapEntry *aplic_s;
> +    const MemMapEntry *platform_bus;
> +    int platform_bus_irq;
> +    int socket;
> +    int num_harts;
> +    bool numa_enabled;
> +    int irqchip_num_sources;
> +    int aia_type;
> +} APLICFdtProps;
> +
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size);
>  void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> @@ -98,4 +111,10 @@ void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
>  void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
>                              uint32_t *next_phandle, uint32_t *intc_phandles,
>                              uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
> +void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
> +                                   uint32_t msi_m_phandle,
> +                                   uint32_t msi_s_phandle,
> +                                   uint32_t *next_phandle,
> +                                   uint32_t *intc_phandles,
> +                                   uint32_t *aplic_phandles);
>  #endif
> -- 
> 2.43.0
> 

