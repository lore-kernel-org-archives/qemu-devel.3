Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970B2C61DB9
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x09VG-0007mM-Uy; Fri, 28 Aug 2026 23:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09VF-0007lj-6R; Fri, 28 Aug 2026 23:13:09 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x09VD-0006QY-GN; Fri, 28 Aug 2026 23:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io/oF3C8hUbOYCUgYDz4OO1yiUwa8Sn/bC2V84Oxk4V1Jb8q/M5uT1x1w8ncqS+9m7aRIv4Xdt4WcwM6zbVXdtG8i/wgBPEytybxoyk1t/JEjK6sDBT4pMo3B/GjQqCnFGHtF84zxVdAf41xZ5WJSddbayA9E15gk6z1UM6w9qLF53vQG91fiSbge5y2RrsPiq7Bs+QYubEJFNanrmkj0Krf2q97grFlbOmlsxub/rxEk+Eslrbbc0HgT+dR/8IqBu8RKMm57Nx+oN5QnTNRa7c5jiXCQ6r7mfNixPJMqKUKXfJiZ/xmgcyU/5RJJIsgN+Qld5Tdre/8Y4/BQHW03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k50NziQM/fL7uq7IETwrKAh0jvDk/PojKpjvin5Vikk=;
 b=BAPeiPL3jvU/oIBpGoUf4tP6vcBNRWEYcu5vagOxltG8WQYv9QfTxCncnInkLu9iiJt2JnxKOebLToThAQIrthwIZ/bv/4ovXsxbG85kNMEMSAaknzwjQrVU6NCwsIW7v4ehf4CVMCwKywV+yKK5U+w3kjA9OR4CX+SU6FQKXrRpCpn7DRM0bMHaD3AEbhWg2AwGVGcsbcEX51kx7zvyQnG5wJmtsegzQ8ejmaA3JlmcjxQqT7xZ36TAW4Itpr74EoZ+/f3NrBL0jTX0McWDslU0WA5ic+eTXOf3VFDl0DDn6R1Nr4lkaxD7WuufP841eO9mE828aywg33SlvJ7OhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k50NziQM/fL7uq7IETwrKAh0jvDk/PojKpjvin5Vikk=;
 b=iGyEz+vgQmotjQW9COBz6P2OJS7IJfoc+Iw+/X7CoatZPcgByr74ycFkpZnjTovLCKCtBkZ0K69IAutTCaXA9lPq7v8K9a7O5Qw0uTJOJN4DsjYTOOa2827JEPTvcnxBL/2RFvUtx5U5drd/FoU9OO6WxWeuiWGAUJ89bWDsy+61Cd2L9v1nT3PAibK8CluNCyxrcPK10ittYBbsH2Wt20UAPzczIXEK8fHV2MD5gUHkrtrDjMO3VduPZR2wH0TR62MyAd4nbMlCVhpOTtNicIGuN0cl6YrvlDgHb8OgXUCp/yEbuszVcCtDqtv95Zp9Pp2S6+9zgpiPST+Q7Rv+Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5574.apcprd02.prod.outlook.com (2603:1096:400:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:13:04 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 03:13:03 +0000
Date: Sat, 29 Aug 2026 11:12:59 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 13/15] hw/riscv/device-common, virt.c: add flash helpers
Message-ID: <apJONFh4HiJos2Ch@ChaodeMacBook-Pro.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-14-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828203918.350131-14-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH8P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::7) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c3a51a-8b3c-4186-d0ac-08df057b7083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3e1Boe6JFl2yIqnXITQLrgvPNkv+tHJUMC5MOVJQIQqusLV5616t50RPjZmsCgncjWgm7eqtwbDYdhEVsXkWIYIOQWzomlFRJmpNheW92MA5qPfuiRQtvL/+SlQN3s7oj8QbWplxQJdGy5JuhLTYY/2A6vsdi/mrYLOvYASk+i16qeqkPkUK5DgjlShWpGkzrcj5BFiSmEJQmzZXWQIBKbodp+J3jv8O6xmowVk2DyctaFDOcKGjOeJ+I/u5XB8qVoabMdXKPf0hX9jsCu+Rwzd7g1KVKEH38cGv7ds9DGssr0BAZKnNmvv6BY8dglfrdMW1i7y84lBTlZ4d1hdWfTG7gZy8aRjDrVMNxs5NSqS7U5pUV41eXtDSzv2daeEdQYoEHcD9PubDrgl7lO1Uk8ILDlDO6BzkmreHscjRW0pSXnW5ZRKASe1jwBbHJoQGVpZSChilqBXQFqcURh0BJXIoKYMeEV56sPMmpvSPhek994TCz8W+gxq8jvJgL/ocfV4PvA9/vT7MMzDtXBpjgtYUiJmz0aq2f5nTCI8VtVScBZn8zf9lpmU5hiicvjAGWfZxbuVBuPb8wg8Q62h2lFGB4fnCZGI7d/NANSx7p3t8blCHa4zFhXDKvyB++O6XzEEdUEBFtJyhsDZxGWC/XHAuzpOZJnIOOMPfmAt8wIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nAyXXo7yesksmtsb1quBJkR4RD1jNtq44k7lQh/qvMgitC7LZo7N86GYpf?=
 =?iso-8859-1?Q?ui0goOsmlSK6YogBzB1VrddiURBYaILhkfl2+fXaxQUCRW/Ui2NIpMOvgF?=
 =?iso-8859-1?Q?K9yYHo322MfLrDrU8EK2sA09Em77rJWgyo5lRHUQY9kDIrI4ZFmKOJm8XC?=
 =?iso-8859-1?Q?yp+EIplMIt3tPMOjLyPKjGojE9j28JHozVk9HpVaEFUC0Od9zW3SZ6wAcq?=
 =?iso-8859-1?Q?yuNzdaHZlijSvZO4whrXXaxVYCgAgdfafjWLXdnwpdKjDILWNWXZVEqnSm?=
 =?iso-8859-1?Q?fj+pqYVXrEGPW6t5nfQxlvY2NjTUdpmfWK/37vG/bseCzl4OPKtU7bFwEY?=
 =?iso-8859-1?Q?dMfOachOExEe0xKpMB90AP+I69pq06MnROMaEDz9J9TZArrOOYRAFNoJiE?=
 =?iso-8859-1?Q?wpoTSyxwfpW92xSe+5pSWQTKDkXYKzN8XwiHI8bS9SJT00eM6q7OR1x+mQ?=
 =?iso-8859-1?Q?oXkbnEqUNjLRPKFdi7jgrZk/TJBFtJpuQsEUGGnzrjFYUIVajkXHKFdsUl?=
 =?iso-8859-1?Q?46aH8+2b0TTZcVldUouPTX/6j17S4n5qnNXUL+DRvLSvLDXshp8Pd0P+W8?=
 =?iso-8859-1?Q?Dd0MGIl8NMBkeOnPo27GC0kKlMGdiJkBH69pQc0XbHikOAoD5CJmmjylgt?=
 =?iso-8859-1?Q?aC2tel6VeF2wevT/ReCraHFM6ZbqQBjEmBcLzAryZlT7DQiQ9XAPNwChm9?=
 =?iso-8859-1?Q?iPRtRpIBN++FKimGTx7fbHNz65DCera7Gt3Jav96txaKjIxJv5ia8G1kZw?=
 =?iso-8859-1?Q?5KQYRC9sM5+yqA+NQ2Pgj0HoTpwMuAAc0SipLWBkOHuHyE+TCY49rTHkNz?=
 =?iso-8859-1?Q?PCMBmTqAAihBMABnqUFx6nEQq++2hXxduL5Wh+j9CYCSfXlTbDwS5j/z2C?=
 =?iso-8859-1?Q?z0YYwJAOIOfmAbJxpVipU/kWAs9GwOKlzKTx3cxb6WmvWXHat0pONgx1Se?=
 =?iso-8859-1?Q?7E/4PYymtkMZoU0Sxg+026hZuwz+6lEzhKZqI/8Y01o7ugyGsoFl/Bzi7x?=
 =?iso-8859-1?Q?V9KcqgjMeOI9RkwEtpS0Ue3j9W2dtjISFpyRfXuMFgRCwuxdTGvQ44rBP9?=
 =?iso-8859-1?Q?ta5OVItBcz/UKlTrHl4CbBlPRAbqs1LR7jsFqUbBigi7ouomMJUveQrae+?=
 =?iso-8859-1?Q?AkEOdpNpOJ9lEnkj8aRG72MOzISV3Aqx3ntpPyvcnHpSutCywC1ZVuEATd?=
 =?iso-8859-1?Q?NmtOFNvpnMw3E+HP5c5M/I5PI6XpBoaFzCg8Hw0qArZfAFZvZP9IEpcj6j?=
 =?iso-8859-1?Q?5js9Im9xWDlaZJ5ncvPQ0WXy/QhzgExprLyq37tnIMUI3dljMSBcab352X?=
 =?iso-8859-1?Q?q+KsOGI5Erm6wnckQrYPYLvsLlQQOX051WAdhyOTlhF1GH6ZBB0HeJPBi1?=
 =?iso-8859-1?Q?E91dTxaKpGwltGu1+hqRHboS7oo2OeESXhybkQb4cSY0IRjhy/Y90zS/MP?=
 =?iso-8859-1?Q?E6MKk1oQ8NYgnSLYnymeR+pZubBxI4Ns88XrPqR/DJE/kkbNnfA1cgKtFe?=
 =?iso-8859-1?Q?saNVTSreSNmEbpmMOOxfqEh90nZDyFGyHOpfO4OY/Dq8M/zT5f7W80G/7z?=
 =?iso-8859-1?Q?K62l8w7GGa68mARsbuTwXt6koyg6WUPonwIbJZdgDZVTEWn2CSqAolyoxo?=
 =?iso-8859-1?Q?9jjnJq+FWB4Oev/BFODrDc5VKkV8ApRkWeVwCKMF1+vWLxeISDkj/Md/Hp?=
 =?iso-8859-1?Q?VqOu2nRLrVT0U30HZC4T5CgEiO+z19ae8PZMT84GqaT+oMcoRerNapwaOm?=
 =?iso-8859-1?Q?NRimJdTksq+AnlOHvP3Th1ZXlxlKl8T0EPq8ej9blUqNhaR6xbjXwvEmNx?=
 =?iso-8859-1?Q?mkiY9EIFDsd4O6Uxzm9WRd00eI42VU4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c3a51a-8b3c-4186-d0ac-08df057b7083
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:13:03.8182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL4ksySxRnoeeayVK3L7DpcIfVXMHhtiBABhe9K0HgmDDODn/bg3ZpnRcdUfgs8/AF66x/dfWNzDkXEP/uHc0OqI27AgJ5gg0mu04xCeYUQ=
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

On Fri, Aug 28, 2026 at 05:39:15PM +0800, Daniel Henrique Barboza wrote:
> Move the flash device creating and flash map initialization to
> device-common.c.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/device-common.c         | 44 ++++++++++++++++++++++++
>  hw/riscv/virt.c                  | 57 +++++---------------------------
>  include/hw/riscv/device-common.h |  6 ++++
>  3 files changed, 58 insertions(+), 49 deletions(-)
> 
> diff --git a/hw/riscv/device-common.c b/hw/riscv/device-common.c
> index d3c68a9e71..a054cd7114 100644
> --- a/hw/riscv/device-common.c
> +++ b/hw/riscv/device-common.c
> @@ -10,11 +10,13 @@
>  
>  #include "hw/riscv/device-common.h"
>  
> +#include "hw/block/flash.h"
>  #include "hw/core/platform-bus.h"
>  #include "hw/core/qdev.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/sysbus.h"
>  #include "qapi/error.h"
> +#include "qom/object.h"
>  #include "system/address-spaces.h"
>  #include "system/memory.h"
>  
> @@ -46,3 +48,45 @@ DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
>  
>      return dev;
>  }
> +
> +PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
> +                                const char *alias_prop_name,
> +                                int flash_sector_size)
> +{
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the ARM virt board.
> +     */
> +    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
> +
> +    qdev_prop_set_uint64(dev, "sector-length", flash_sector_size);
> +    qdev_prop_set_uint8(dev, "width", 4);
> +    qdev_prop_set_uint8(dev, "device-width", 2);
> +    qdev_prop_set_bit(dev, "big-endian", false);
> +    qdev_prop_set_uint16(dev, "id0", 0x89);
> +    qdev_prop_set_uint16(dev, "id1", 0x18);
> +    qdev_prop_set_uint16(dev, "id2", 0x00);
> +    qdev_prop_set_uint16(dev, "id3", 0x00);
> +    qdev_prop_set_string(dev, "name", name);
> +
> +    object_property_add_child(parent, name, OBJECT(dev));
> +    object_property_add_alias(parent, alias_prop_name,
> +                              OBJECT(dev), "drive");
> +
> +    return PFLASH_CFI01(dev);
> +}
> +
> +void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
> +                          MemoryRegion *sysmem, int flash_sector_size)
> +{
> +    DeviceState *dev = DEVICE(flash);
> +
> +    assert(QEMU_IS_ALIGNED(size, flash_sector_size));
> +    assert(size / flash_sector_size <= UINT32_MAX);
> +
> +    qdev_prop_set_uint32(dev, "num-blocks", size / flash_sector_size);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a2671ae341..9ff5beae77 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -120,53 +120,12 @@ static MemMapEntry virt_high_pcie_memmap;
>  
>  #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
>  
> -static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
> -                                       const char *name,
> -                                       const char *alias_prop_name)
> -{
> -    /*
> -     * Create a single flash device.  We use the same parameters as
> -     * the flash devices on the ARM virt board.
> -     */
> -    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
> -
> -    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
> -    qdev_prop_set_uint8(dev, "width", 4);
> -    qdev_prop_set_uint8(dev, "device-width", 2);
> -    qdev_prop_set_bit(dev, "big-endian", false);
> -    qdev_prop_set_uint16(dev, "id0", 0x89);
> -    qdev_prop_set_uint16(dev, "id1", 0x18);
> -    qdev_prop_set_uint16(dev, "id2", 0x00);
> -    qdev_prop_set_uint16(dev, "id3", 0x00);
> -    qdev_prop_set_string(dev, "name", name);
> -
> -    object_property_add_child(OBJECT(s), name, OBJECT(dev));
> -    object_property_add_alias(OBJECT(s), alias_prop_name,
> -                              OBJECT(dev), "drive");
> -
> -    return PFLASH_CFI01(dev);
> -}
> -
>  static void virt_flash_create(RISCVVirtState *s)
>  {
> -    s->flash[0] = virt_flash_create1(s, "virt.flash0", "pflash0");
> -    s->flash[1] = virt_flash_create1(s, "virt.flash1", "pflash1");
> -}
> -
> -static void virt_flash_map1(PFlashCFI01 *flash,
> -                            hwaddr base, hwaddr size,
> -                            MemoryRegion *sysmem)
> -{
> -    DeviceState *dev = DEVICE(flash);
> -
> -    assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
> -    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
> -    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -
> -    memory_region_add_subregion(sysmem, base,
> -                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
> -                                                       0));
> +    s->flash[0] = riscv_flash_create(OBJECT(s), "virt.flash0", "pflash0",
> +                                     VIRT_FLASH_SECTOR_SIZE);
> +    s->flash[1] = riscv_flash_create(OBJECT(s), "virt.flash1", "pflash1",
> +                                     VIRT_FLASH_SECTOR_SIZE);
>  }
>  
>  static void virt_flash_map(RISCVVirtState *s,
> @@ -175,10 +134,10 @@ static void virt_flash_map(RISCVVirtState *s,
>      hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase = s->memmap[VIRT_FLASH].base;
>  
> -    virt_flash_map1(s->flash[0], flashbase, flashsize,
> -                    sysmem);
> -    virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
> -                    sysmem);
> +    riscv_init_flash_map(s->flash[0], flashbase, flashsize,
> +                         sysmem, VIRT_FLASH_SECTOR_SIZE);
> +    riscv_init_flash_map(s->flash[1], flashbase + flashsize, flashsize,
> +                         sysmem, VIRT_FLASH_SECTOR_SIZE);
>  }
>  
>  static void create_fdt_socket_plic(RISCVVirtState *s,
> diff --git a/include/hw/riscv/device-common.h b/include/hw/riscv/device-common.h
> index 12af031bbf..9f8bc67a1d 100644
> --- a/include/hw/riscv/device-common.h
> +++ b/include/hw/riscv/device-common.h
> @@ -10,10 +10,16 @@
>  #define RISCV_DEVICE_COMMON_H
>  
>  #include "exec/hwaddr.h"
> +#include "hw/block/flash.h"
>  #include "hw/core/qdev.h"
>  
>  DeviceState *riscv_create_platform_bus(DeviceState *irqchip,
>                                         const MemMapEntry *platform_bus_mem,
>                                         int platform_bus_base_irq,
>                                         int platform_bus_num_irqs);
> +PFlashCFI01 *riscv_flash_create(Object *parent, const char *name,
> +                                const char *alias_prop_name,
> +                                int flash_sector_size);
> +void riscv_init_flash_map(PFlashCFI01 *flash, hwaddr base, hwaddr size,
> +                          MemoryRegion *sysmem, int flash_sector_size);
>  #endif
> -- 
> 2.43.0
> 

