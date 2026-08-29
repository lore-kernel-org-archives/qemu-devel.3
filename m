Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC540C61DB9
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09W1-0000He-JA; Fri, 28 Aug 2026 23:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Vy-0000AA-Rq; Fri, 28 Aug 2026 23:13:54 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Vv-0006Tn-Hd; Fri, 28 Aug 2026 23:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7UvozfSwYbi3QoHNgJ2s162RjI2wUr8ZFlZQIPQWYe4B282QDxrXwR16U5mUXwrNbplEAZGfHjxjskv8aJNSMacKB78GZj4xqz30qh25WcpnK2Ieq2VRPCmpZlu4PdGU8DrKzOiYmLqYOcgLxSRSgKg9gX0u8h8/okYEHN4/diTWDbUJNqI7tEzOD3mzNxw4gj6QHrtnghYPe7AmR9V7h+RNTnHxTJX0N96xvTjfeuVIArcSRiImVc1qEnXuXZccSsedLIVnz9vNGHW8BNpLm9Q6dqZtoz1f94PR/ROHr19dwQkmt2MVCwPoRlKAqh6XJQWgqbkDlO7OkZh4pCs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3ZnwIFrwDjxcr6Xas+ZgIIzIkY/gVFyCLdy0jN8tPg=;
 b=KaqwiqTfKwrsPn/DkL4jymZL4qBarIN4bb/xw6muUI35Wub5w/pW/aJiMeBGnmUtmAJQEsTEthyQlgaBNbGpCUHfDJl6WzQ69TmiQw1Qqjmk5nMTSJ4X+GHY204ArcIdZm1/fR4QgSNSH5xfX7lbr5nyABlaCkZpKkvUQvb+itf8/Vlo8na340vgCoeqBhlxIa7kRWjwoRSOTFe02N155Lo3hIs0v5Fw6UEpxPbUYefjQ12FcPIgJCGDrmHVgEPcPAnZlEgxgcgWPZFAnBiipmGGfwhiNsgObvOaBOCVa4tL0RJ7MCC43MxWV80UUnJQKMmhtBqJqWyE0YnmEnghiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3ZnwIFrwDjxcr6Xas+ZgIIzIkY/gVFyCLdy0jN8tPg=;
 b=FfuIL7GZluAemalniQHKZzUsn1tcXXmS/kOTFdRJe1/HtXFG8NFee3uQek0p/Lwf2/r9WDr+Wc7Gzs2T5A5zVb7OFTd2EK0SH1DhXRlneaUJXkg5M4tocVO67PShAlZDwE36+uldcdB7OMxMW83rBib6V7KjvqEyRF5t2CDE7RlCWrsPmD+zjNCNzSEMwTqFaXDBN6qiLERWU2vJGc3HjUCuXmWIHxLbxkzIZDE52M45NQF4h0ipChaGCwi+Zuvwl9QYiy8DCJWEdIAh0cRhgmF4HeX4cuz0Mx7/cDlqc46n/RgkVlNDoCvRPQHBMzmIr01pk52ZzHqOXhyvCil0Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:13:47 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:13:47 +0000
Date: Sat, 29 Aug 2026 11:13:41 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 15/15] hw/riscv/riscv-iommu-sys.c, virt.c: add
 riscv_create_iommu_sys()
Message-ID: <apJOXTWS9j2AnuhN@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-16-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-16-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH7P220CA0053.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::15) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5744a270-3a43-465f-86f0-08df057b8a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XXrr03+ab6h7BwDWV8I2R9c35PPmIobbUnMVfoRfoMdfloOQ8azsyk4yUJc4UGweCaXYZv5UduHLrHcmXpnGHKdXiN2S8uoqhoe+I6idgwzDbjxau0aKDJd1KJoUS0fKPejh9L04lK9guEZYIpXUPR505J2zMj5tGO/m4UDXOUojVZE+xP3jLYiK3gMVH427swDEog8Tvl4BVrCCIt7/3gVa6Y/C2VJtYg0j61QCvG+HWvwEchwo9sbYSQsqUyiBVYHQ6zpXwWUnujDfcV3VYsd69OBrWElnvAH/GrwPYChOBeppvak+P7p1mWZMB3ojw2HBfkMlZ9IquaFr5ImnUal9Lr4TgplW2hWqc78Xav3eKfhYOLrXxkuDlekvmAbFYswcFP+ZB+OK29WBvEIg5jAqyZ/nHtu2zU72C1O9vh5N/5cx8557nqtyD/jkdUeTiprnv8Txd8RyBq7owVzfKUVHPdAAHlIiaSBBrUgZrplzTaUENJiY04+Ry8daIXEw2nzdUnUFIKZ8BesERZRipFgjBMefxzsqMBvkzuteZdNYYYMj7tpKESEGREO46kyB8Qjp9EphZzVyKW/t82vWFDFROzV/2uVhl23tVHr+x4MkhdMUkVH5dwYnbaWrOlRSUxOJ6yqM+5lLx2gQ1I75/7qzlpA8jV1dOwLAoTL3NXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HbAzpJ+Z6b19U2LqIFVOeTaLB5ckE8YVOzDEdki9vB36j8PXDRebF0SzRL?=
 =?iso-8859-1?Q?8CLAW70RaQcqttPh/5HLJCG+oJ9A0I01KIrmbOebrw4bqLO80XF4E/OsEx?=
 =?iso-8859-1?Q?FompMnYlTp5lB5QWXhk+1Azfel+1vN/uf3xzMNeYpiyKShDyTA1cHeGd7u?=
 =?iso-8859-1?Q?Cp3eWINRyyj90KXa7v/6EWLvDYa6JXWU6j9NIy/alIj3I6kWryPtvGE+26?=
 =?iso-8859-1?Q?v0xTKS26gHZfrsGrfEOoF/Aqt1m2OotLowzkThQkXfaByAmfZzgZBNFd7H?=
 =?iso-8859-1?Q?JjLUSyx9ECBacVuZMjCsb6BpwVAaYV+N3/bXzAnsOtEm8+HP5gKO5QWxNe?=
 =?iso-8859-1?Q?sS3HNBoNhp54HCICOrez2aXnCv9MZAf8PM0l9ftPC+J2LVs4VsMsY7tdCa?=
 =?iso-8859-1?Q?nB/YxXLiskeswm/wQz0zYTfbm5vhJ1WnugGx4k5rZh0OsVVIY1e3uN9swa?=
 =?iso-8859-1?Q?Z3mCagavTWZuD5Pxr2aTVByZa9ifYw9fD6/rFNjxx0IDdyTB46DFAEW8Xt?=
 =?iso-8859-1?Q?0IVFANAz8q874t6vlZUVwoZtl/Xf3cG6MjANX8tTKzwYpegfc6320V0YGl?=
 =?iso-8859-1?Q?8Di3wukg+sKOWQ4tWn1sf+q6sSGJ8Co5llRjq+qlehm5Un65lKEiqwH/Mc?=
 =?iso-8859-1?Q?7fXKI6sCharCuAj+5k4cPjWGz4mBlAccs5D7kVu3TEUKDqa3f09NXayVNy?=
 =?iso-8859-1?Q?r1LMz7WeGPS3b90lyFi2ot2jmMGOJvdas0TW8E+tTa9RG0T3JDN8Zn9CK/?=
 =?iso-8859-1?Q?BXR3pbJTr3zuhi88x2LsErw3rJsP0F03xbqB7u/2kC/hnU0nq/VacMaHUz?=
 =?iso-8859-1?Q?TaKGegef02lPnOUP7uYxizl05WIIeRYlPx4aZzL3tLcvNz7JDhjKhHEfN5?=
 =?iso-8859-1?Q?KD3i38q+JcebCKe7sOIUVBVOsIUZQT1qexIMupwnQ//iKlcTs3UPjIZEXw?=
 =?iso-8859-1?Q?rgwDpA/vkmRIGckQdDur4AWcbv04shZ4eI2/isCoPYp2txP6y+vSnAFsJl?=
 =?iso-8859-1?Q?OlMA10Ah3M6F2YBSozHVuxXcxQF6Kaqbwcgmyz2NKA+dAvwHHAcRhDlkn0?=
 =?iso-8859-1?Q?buQI+S9nQwqmxANdIbuZTconbwv64DTlJsH2VT4IWWDkrbAtLnRs1SoEAH?=
 =?iso-8859-1?Q?k3sRQElps9/RiyzCDKgVZoktfz69KtOl4Bwc8mVInwyVkDdJwOCdEuvyml?=
 =?iso-8859-1?Q?UXeQLWRIEXuJ+Wd2n6/F0HXUlH5jaDjJde0nvVKvlE28ThP0PFtEu4XPpF?=
 =?iso-8859-1?Q?6AaLFEAAL7CRfLRVgfEG9qIHRQmaqRuJoGod8VA+oQ1vTGyKcvcJ6mBiQ5?=
 =?iso-8859-1?Q?7MptuxwkdFeJzq4W0tv4XZ68OzJfRnsWc+U1DoWZKwfjRYNlA6REvWa5/E?=
 =?iso-8859-1?Q?b53U1e/Ca2wkbe6bILYWvrZCdo45/VBjEeenk/xYZtpjy0r1fKxSbJ8eBX?=
 =?iso-8859-1?Q?016PablC+lWsXLYgheC6yHIjiQhSbg9C0xGUSXNJ/PIVWAcYPpgNFZY4/J?=
 =?iso-8859-1?Q?h9TulNMa2LfteuQEHGnFs4Y6rDCIYiv5XL3sQDAHeCLURVVeZZ52qoWuax?=
 =?iso-8859-1?Q?F7Yi7D16DcjxESDbqFSchXZ80LjUVea6OHOMfrffkGy3pznf9GFlmF3j9Q?=
 =?iso-8859-1?Q?GijkCHaa40Hen+h3og0NRnmpLxfWC9fc1XV/gBzlsKbJwBABgp8no6sTVv?=
 =?iso-8859-1?Q?bEqQ+geXUrrcIBVsycqM4UDh9spho80or49QMN+W628kCYojzyTDaHse5d?=
 =?iso-8859-1?Q?OPuaZDex9wU50IfJ9rhl2We4VZKdaYDwokoV5dTw+1JkNv5KjMz1bz2Hrb?=
 =?iso-8859-1?Q?7zOfJA6IcTpv+2JrqatVSNf5/Sjuc2M=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5744a270-3a43-465f-86f0-08df057b8a49
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:13:47.0567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwcIU4a/jVDGMiVCyoUlqZhEpSwPdf4iK0t949EA7Uu0oqyr2ZwL8+eESLBIJ+ib4nzqd539Iw7T0ey7XCH+ezeIpzYQvqX1txuUgPUZXBg=
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

On Fri, Aug 28, 2026 at 05:39:17PM +0800, Daniel Henrique Barboza wrote:
> Move the creation of riscv-iommu-sys to its own file instead of open
> coding it in the 'virt' board.  Other boards in the future might want to
> use this device and we want to avoid code duplication.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/riscv-iommu-sys.c | 25 +++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h     |  3 +++
>  hw/riscv/virt.c            | 23 +++--------------------
>  3 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 3314adeed2..258c171efd 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -217,6 +217,31 @@ static void riscv_iommu_sys_init(Object *obj)
>      riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_BOTH);
>  }
>  
> +DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
> +                                    hwaddr addr, int base_irq,
> +                                    bool is_32_bit)
> +{
> +    DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
> +
> +    object_property_set_uint(OBJECT(iommu_sys), "addr", addr, &error_fatal);
> +    object_property_set_uint(OBJECT(iommu_sys), "base-irq",
> +                             base_irq, &error_fatal);
> +    object_property_set_link(OBJECT(iommu_sys), "irqchip",
> +                             OBJECT(mmio_irqchip),
> +                             &error_fatal);
> +    /*
> +     * For riscv64 use a physical address size of 56 bits (44 bit PPN),
> +     * and for riscv32 use 34 bits (22 bit PPN).
> +     */
> +    object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
> +                             is_32_bit ? 34 : 56,
> +                             &error_fatal);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
> +
> +    return iommu_sys;
> +}
> +
>  static const Property riscv_iommu_sys_properties[] = {
>      DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
>      DEFINE_PROP_UINT32("base-irq", RISCVIOMMUStateSys, base_irq, 0),
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index da70e8bfa8..7c470ba084 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -104,6 +104,9 @@ void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
>  void riscv_iommu_reset(RISCVIOMMUState *s);
>  void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
>  void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
> +DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
> +                                    hwaddr addr, int base_irq,
> +                                    bool is_32_bit);
>  
>  typedef struct RISCVIOMMUContext RISCVIOMMUContext;
>  /* Device translation context state. */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d75dec2dd2..de7b99c6a5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -32,6 +32,7 @@
>  #include "hw/core/sysbus-fdt.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/iommu.h"
> +#include "hw/riscv/riscv-iommu.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
> @@ -933,26 +934,8 @@ static void virt_machine_init(MachineState *machine)
>      }
>  
>      if (virt_is_iommu_sys_enabled(s)) {
> -        DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
> -
> -        object_property_set_uint(OBJECT(iommu_sys), "addr",
> -                                 s->memmap[VIRT_IOMMU_SYS].base,
> -                                 &error_fatal);
> -        object_property_set_uint(OBJECT(iommu_sys), "base-irq",
> -                                 IOMMU_SYS_IRQ,
> -                                 &error_fatal);
> -        object_property_set_link(OBJECT(iommu_sys), "irqchip",
> -                                 OBJECT(mmio_irqchip),
> -                                 &error_fatal);
> -        /*
> -         * For riscv64 use a physical address size of 56 bits (44 bit PPN),
> -         * and for riscv32 use 34 bits (22 bit PPN).
> -         */
> -        object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
> -                                 riscv_is_32bit(&s->soc[0]) ? 34 : 56,
> -                                 &error_fatal);
> -
> -        sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
> +        riscv_create_iommu_sys(mmio_irqchip, s->memmap[VIRT_IOMMU_SYS].base,
> +                               IOMMU_SYS_IRQ, riscv_is_32bit(&s->soc[0]));
>      }
>  
>      s->machine_done.notify = virt_machine_done;
> -- 
> 2.43.0
> 

