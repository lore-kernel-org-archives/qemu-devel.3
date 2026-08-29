Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771C3C61DB9
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09Uu-0007FE-KU; Fri, 28 Aug 2026 23:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Ur-0007B7-9a; Fri, 28 Aug 2026 23:12:45 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09Up-0006OT-Er; Fri, 28 Aug 2026 23:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce15sI2qrapf9qpu9L4FcNCKsxe5q7ZG34+5Cpn4pK5Ydc7MZHgL7p0bpeespxW9dsTydXgLOSSLuNtF+CXIN50c0zETFkcM0bh8fI5qCCP3cWakYRugJdxHdmV9x8rqigLDCnfo6e5W0d4uv7qumviT9cXmMOWWNA4Zo7Ihv3UAWOQIDl7rb3k4xrgj4M6ONOgR5ehbJFIE7UiyPN9OxVKdi2iNgIKDYtQ6THNczlAi+9tounsyXUm3X2lWomfktoBV3gX7l2S9KsYTAjuIQH3XxdcmsO/DWgZ5e4r0W8f+pUeJT5i61dlDtFf8ZruUU80O24t6NLgDxM9uQfpeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5IVa1iR3X0QgLxt5/0wWmHj4HIEf79kUqC8uQrI06k=;
 b=iU3X6Bh0PXu0tDtnmCaZcDHy05OUTYVcUMBkpQrAjJPsk4GVBLEhclF2IZlEY9jid+aiI701smMxBI1ji+4bdjzP00HzkZtPTAbBBE1xkVWfqr8BgzDPBvv/2rVVj19jmfQtlJwdA7c0NWmY+3lNwjnHo+nYUwmq+U9zXL0GljbkbF4Kl/o7WouNiZsaPYOlqRTggKZTjQi4qgf7gAf3Wkzl8dpVWJuDmrt8wTquTvipScBarkVEWWdSe2svFVkpyW5TbAeOb+yV6ujDFZ8n6hXfDBfU8NOU8Th4G/PjDz3TS9SgzBhXbSjasW/hlbq5L6Au6phGqu/BY5UzUR/YrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5IVa1iR3X0QgLxt5/0wWmHj4HIEf79kUqC8uQrI06k=;
 b=vzpqrJO/weDrAuTyR/BJ7EceiEsyBL/Ucy28J9SezOwlFYyyYnAgcoEP8jfxVzV2pvYjv4Xln4VM3L6ZkRY4R8LpH+lnvnt7vq7VzCxscDFhFqJ/OtdR+Lcx2La6QcwEu4cAyB9+HkK71zdl2lV7I6UDeL1ncQIJemU8FTTEw3XFfIH6ilBCUfPmwKvLbaThEzVDICnE+Oh63Yy6hDjfWG5NsLnUG42bT30TsCl5t0wFkySrFhuZ+Oyp9uKRRoibqYU+16Qz+b/ZJfNWNtXb1NGWGQhDzPpQHeFoNzr+5xwaiqu1pH4QOjTp9nh5RiG1QOCvDIi8Psd8U1ygoU7mmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:12:40 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:12:40 +0000
Date: Sat, 29 Aug 2026 11:12:35 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 12/15] hw/riscv/device-common, virt.c: add
 riscv_create_platform_bus()
Message-ID: <apJOGGsA8mm1XRo8@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-13-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-13-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH7PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:510:23d::18) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: abfe61a8-8caa-4cf5-5a95-08df057b626d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1KMrCR7vyr/l57jVwrGGvDEmGsoEHCwrBEXhdvFUX4ukTP7d+y1I7s1P+MpOYK3jdnoVfVNgcX6wlP8fTH3t7ghpGUiLtBocC5rZ8H6cFU/TTbFyVSSWGfGhwJjtU/1xDsB+KNUFqE3q9KpuKNTq9EaScOw1j+HajTVGA/7h+aZOKSxW8RFN4HyHU8mM3rkfWZWcyA6U87A+opcM7WvC+NI7ebqhX80IA47tIQMsZwx4neMfiVfsqPAh7Cxg6kZgXxWPwyUgpjKFJ6uPm4BfhG7R0UNLVDzitbiOpMPzN18XvX+O6xC9jtU0jMLgyzd6MQ+0tINPHagUrq1M+HCkcjZz2EUtA1KB1Sk/64TqisnY2cCfIrQnW9MK5A9ttnNVULIPPXOjeYPkUCSQEw7Z932LhejpczT9T6wy5Dgu1iypuzXj8uXw42ccTHlSF+rXGu5k7JfKPRIaDgj8GQI2ytsrShmL7c4VIvaJeINhAo9fw1zccRRzuuy1afV9kD32IBvPgaodMX2AYCbl1vvwRtd/RY8vorf6Wg5H54alNnecjlfExCIx7C7dgodQusWq6qqLv3Yw+s8EYEcXLYy/HhXA/rAU9L88cnnFi1ni2q2kJOYzWpEQJadjmpdvPoPijVzKsgg+OGVglMXRHl/kr9M4E4O/3RH5BDt1FxIznF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QScWBDIyWQMTs+JJaGk1sBnIg1iizchPo8Ff5lAizZyF43sSjt9qCFfHht?=
 =?iso-8859-1?Q?uqyM5TxsB+Q691J5eGFEWGblaEY9VBFSzad1+yhfhoWGKaXvZP39lNrhhp?=
 =?iso-8859-1?Q?cOBnU9eYTPQ7S3mwRuCaiUwaPK9ES5AtB4oyhmuvFkvESz3j+NIHpqZ+Qk?=
 =?iso-8859-1?Q?jyYgbeZVrGry80DaCjmEuPBk0ApBNM0dNiVTtWMXs1cmUS4cxTUAwaIznR?=
 =?iso-8859-1?Q?WAIprZt8gAgtR0gd4QowHxnXu4i/ylUvvA1jyFDbOaiTncq+ikEGx1PDQy?=
 =?iso-8859-1?Q?5B+vRwfjjYB5IgrCYizcKIKTIzDFPdjKDGghfTYfCmfY4hknHo10NL/SQq?=
 =?iso-8859-1?Q?HMTrDxK4sQuBtqdfIh/FhOaspxGX25Ahvzb3evsNWTdxGnIe4/yDJPYxj+?=
 =?iso-8859-1?Q?adhB3geyU7PX9+MF9i5UNXOrFsJB2ywWcAiNkU+ZY637DCnoonDuG6yKKE?=
 =?iso-8859-1?Q?YuU9h0yp+ckqmiVrqJ5OSAYJ5bXE8M2b9f+7wNAycohfe6zn/DV7KxbLAP?=
 =?iso-8859-1?Q?ciLzeJsgXuJjTPUkPxt3aML6dd2vWi9y0IAumeHMdHdIYD2KDaZboxd7E1?=
 =?iso-8859-1?Q?Y16EIQcsYrZx0a0XBh/y3Q91ANYglLF30b/xQDPjJLzMX1bfWQo68JQmkd?=
 =?iso-8859-1?Q?AafvMZhzrUBHZuXzLCh8TPENYPxniQaj3XhISU3T3mIiln6VprFsVRgC4Z?=
 =?iso-8859-1?Q?0upEeesYvAEME7pCgXjo0miA7fFP9yTlmgdteSXZbROHGbCh9Yoz5wWFAt?=
 =?iso-8859-1?Q?gPqPPhKkc6XPPKb2MHomGWjoLJ+tnL7dt5L4TaHn4AccmQQU2IvrBtv7jk?=
 =?iso-8859-1?Q?Y4/nCqB4QSgOYHw/qVC2uD31Zmiq8wa02pEkTopijwtWL1FLAHuNXgVQr4?=
 =?iso-8859-1?Q?z/oVZRsMutmVK5E/dvcVXkuuIg7jh1Zdw4ig1NZkuCpEZc9Ly+6N9PIfNZ?=
 =?iso-8859-1?Q?mqF3h/FvbBrunlwqnTJ8F73XSWhAthS1cOaqWnOJtO5Jqxa2v1GYk5pvuT?=
 =?iso-8859-1?Q?u4VVpE9xbSq8JxKyNE97vPpbwp8FM22/yN+P7heSHR/033fSIlFZVaXMuo?=
 =?iso-8859-1?Q?Tr4J4Qm2ooC2mKrlMmPO1ZIlb1wrtb9kOrj2mjFlBrRRvQjpZGietyB4b8?=
 =?iso-8859-1?Q?iDd938LyYwIH1tUgmB4cdhNZ/erBWS/8G4oN6SrPJeJVidIguXSsqrxxAo?=
 =?iso-8859-1?Q?dtIvPqHA5vYaUBPDX3IDrexjMQX3L9YITZP6ey8ZC+V4L/d3PsD0n5HxO4?=
 =?iso-8859-1?Q?7Sjk7gy4nXmjTunwt9Sc6K8hFD0nm033gflz1B4hRqm4HOmEsS5JODTqZR?=
 =?iso-8859-1?Q?IU0i5YQeV0mh2K6nGvMPH+wp8hZt9LzDQKD7DBNah83g/7H2jPOz4eNUv9?=
 =?iso-8859-1?Q?3dfNbn5q2ldEkqhV/GU5lGt2dWL2CzU7vJtcYzGPv8ysPdb7U5wmeLoV6l?=
 =?iso-8859-1?Q?eV3JZoa5vUwCkc7y9DPEbKTSpvceXduDAEixbl2Pe2xSTUOIGXJTn31+Ib?=
 =?iso-8859-1?Q?tsmgyCebnuOfLsHFNXWikw+rP0zKBUtaJ6zM8qNqKtxslJFCNSH/6XH0zu?=
 =?iso-8859-1?Q?Al+1RzKisxZprx/YktqGFAlH2GYBFT58LjvyJNCuWq9BbhPk4ejT8N/AN/?=
 =?iso-8859-1?Q?nI2FC9w2pB/EAh3Rldz6cQKfGANJEcXJxGyv3zXGRXORpZC5woCXs8itVS?=
 =?iso-8859-1?Q?63HbmQvMPVxnh7CL3oOC2hnD5kOIWGpzigU5uHcB/RpjQBgMeWTXFnqYNC?=
 =?iso-8859-1?Q?WPr7VWnndsp6G+u5Us35g6BsgIdIRwRYIy3yoaHP7Zu93VNEe8KoriQuxp?=
 =?iso-8859-1?Q?uuRPKCa4+DTyFonX4CBEMiry19qkI10=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe61a8-8caa-4cf5-5a95-08df057b626d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:12:40.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LuRQhnSgn2T9xmGFGhOw8irFdP/NgtWWdTtzNjoPAvZbGobZZaHRKg+J81q6AU//TnpBjX5P9ssVp92I3eDLkXqDaYCMTAV2Lye5bOPNsM=
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

On Fri, Aug 28, 2026 at 05:39:14PM +0800, Daniel Henrique Barboza wrote:
> There will be code repetition instances added by the 'riscv-server-ref'
> board w.r.t device creation and initialization.  Instead of waiting for
> that code to land we're adding helpers beforehand.  The idea is to make
> the new board code shorter and more palatable for reviewers.
> 
> A new 'device-common' file is created for such helpers.  We'll start
> with the platform bus, a nice piece of software that only the 'virt'
> board uses so far, and the 'riscv-server-ref' will use to support TPM
> devices.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/device-common.c         | 48 ++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build             |  1 +
>  hw/riscv/virt.c                  | 30 +++-----------------
>  include/hw/riscv/device-common.h | 19 +++++++++++++
>  4 files changed, 72 insertions(+), 26 deletions(-)
>  create mode 100644 hw/riscv/device-common.c
>  create mode 100644 include/hw/riscv/device-common.h
> 
> diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
> new file mode 100644
> index 0000000000..d3c68a9e71
> --- /dev/null
> +++ b/hw/riscv/device-common.c
> @@ -0,0 +1,48 @@
> +/*
> + * RISC-V board helpers for FDT generation.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/riscv/device-common.h"
> +
> +#include "hw/core/platform-bus.h"
> +#include "hw/core/qdev.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/sysbus.h"
> +#include "qapi/error.h"
> +#include "system/address-spaces.h"
> +#include "system/memory.h"
> +
> +
> +DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
> +                                       const MemMapEntry *platform_bus_mem,
> +                                       int platform_bus_base_irq,
> +                                       int platform_bus_num_irqs)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    DeviceState *dev;
> +    SysBusDevice *sysbus;
> +
> +    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
> +    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
> +    qdev_prop_set_uint32(dev, "num_irqs", platform_bus_num_irqs);
> +    qdev_prop_set_uint32(dev, "mmio_size", platform_bus_mem->size);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    sysbus = SYS_BUS_DEVICE(dev);
> +    for (int i = 0; i < platform_bus_num_irqs; i++) {
> +        int irq = platform_bus_base_irq + i;
> +        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
> +    }
> +
> +    memory_region_add_subregion(sysmem,
> +                                platform_bus_mem->base,
> +                                sysbus_mmio_get_region(sysbus, 0));
> +
> +    return dev;
> +}
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 0d82ceacc4..7aa3c1578d 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -1,6 +1,7 @@
>  riscv_ss = ss.source_set()
>  riscv_ss.add(files('aia.c'))
>  riscv_ss.add(files('boot.c'))
> +riscv_ss.add(files('device-common.c'))
>  riscv_ss.add(files('fdt-common.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>  riscv_ss.add(files('riscv_hart.c'))
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ccea5784f0..a2671ae341 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -35,6 +35,7 @@
>  #include "hw/riscv/riscv-iommu-bits.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
> +#include "hw/riscv/device-common.h"
>  #include "hw/riscv/fdt-common.h"
>  #include "hw/riscv/machines-qom.h"
>  #include "hw/riscv/numa.h"
> @@ -683,31 +684,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
>               memmap[VIRT_PLIC].size);
>  }
>  
> -static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *sysbus;
> -    int i;
> -    MemoryRegion *sysmem = get_system_memory();
> -
> -    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
> -    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
> -    qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
> -    qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].size);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    s->platform_bus_dev = dev;
> -
> -    sysbus = SYS_BUS_DEVICE(dev);
> -    for (i = 0; i < VIRT_PLATFORM_BUS_NUM_IRQS; i++) {
> -        int irq = VIRT_PLATFORM_BUS_IRQ + i;
> -        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
> -    }
> -
> -    memory_region_add_subregion(sysmem,
> -                                s->memmap[VIRT_PLATFORM_BUS].base,
> -                                sysbus_mmio_get_region(sysbus, 0));
> -}
> -
>  static void virt_build_smbios(RISCVVirtState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(s);
> @@ -1030,7 +1006,9 @@ static void virt_machine_init(MachineState *machine)
>  
>      gpex_pcie_init(system_memory, pcie_irqchip, s);
>  
> -    create_platform_bus(s, mmio_irqchip);
> +    s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
> +        &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
> +        VIRT_PLATFORM_BUS_NUM_IRQS);
>  
>      serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
>          0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
> diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
> new file mode 100644
> index 0000000000..12af031bbf
> --- /dev/null
> +++ b/include/hw/riscv/device-common.h
> @@ -0,0 +1,19 @@
> +/*
> + * RISC-V board helpers for FDT generation.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_DEVICE_COMMON_H
> +#define RISCV_DEVICE_COMMON_H
> +
> +#include "exec/hwaddr.h"
> +#include "hw/core/qdev.h"
> +
> +DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
> +                                       const MemMapEntry *platform_bus_mem,
> +                                       int platform_bus_base_irq,
> +                                       int platform_bus_num_irqs);
> +#endif
> -- 
> 2.43.0
> 

