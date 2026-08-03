Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8549C55162
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 02:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqiDL-0003uD-KK; Sun, 02 Aug 2026 22:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiDK-0003tn-52; Sun, 02 Aug 2026 22:15:38 -0400
Received: from mail-koreacentralazon11023102.outbound.protection.outlook.com
 ([40.107.44.102] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiDF-0006xW-Va; Sun, 02 Aug 2026 22:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajQchlwtZi8ASyaQf/4bHUUzIWUVcdeFEXWQtFs28cF6X9SySwnx5EMse4OcMYuHWQvh2qtFB4Qv8WQ3Gs1bAv6aF2Z4W9L3n2mbcAKqtRtGqQxhcWSYs4X0cjl5LYB4pe+pvt3IYFuWiSZsyTr6O+LXgf9DObxmfs3L+9NOYysosQiMJ+325f4w8FH30224eegrKGhb4MlmB2Ob50mkonmmFsgMUe3yFZZlb9sJ/qjvW1klJUArIsJh/wHJSWjfnEXM3ktxRweycscO15EYNEZB0xz2/lO2AU0eXVKJt/DFwxtSBcOtCxK5oFFThhBeByEzdvg3/U+r3igrO7SP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXm5VPUIo8Lw9MbRmaWvxeAu41b+MywyABASkeqLmeA=;
 b=SfyiCcrz9rpNixfXKwSpVgc1IxGSL5qj54gfRrYFqyh9zg4CHvA+ztd2biNqsuhGewuZzcnZBD1mmZfla3JHVBFtoOSKfwAsVTU9vIs0QXX/Bwnaelt4zL6jc0u/VB3hag9BNXTqOt+Wc27vvq2J0e/WrxXHe/E8jkze2s4cBAxlalxz417A36eFbB6ddkf6f0XYlbwyOZQgOC69VYBNMXanUxGkSfnNnbMqPGPFAdtlKr5FLSjLd9Q2LT1ktLMXnRbQoThi1/0mKlbHMcCD8FwKgal5OrqFf3vxj/PKSLffJcbTFl4W7Y2pQ/iaF7vl8lmfvFfR7GIDm71dQap+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXm5VPUIo8Lw9MbRmaWvxeAu41b+MywyABASkeqLmeA=;
 b=uu0+jZqgyYIW22l+/d2wg1dzQqzN3IsUYmY8OmVrPqruOEJD5WYNLFXAs+hAtAu2T+9StDTE6e2nLQyKVcMLKiDfMyLttSTHAILnZbe+9WCwKxcirBJRR5EtYo1yTwzbWc+dVe1MJOOSC7VKGXelqjapA/VgiT3goImEIrVU5D4VE07OivFS4nInHdkYHyYfjIBmy/UiwgUSATvmuSCNWVd5NMgfp725wGFpRkt0Cq/afe9hepA/DDKQn8+R6H/HzNog0oqbTn6Bx6MKUkSMQvRytmv3q6Y0BvJ8ff3NBm9wNCOhe9yP+OkiHDD0HNpwZ/D+m5e30UeinFDG9Dv/tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB8006.apcprd02.prod.outlook.com (2603:1096:405:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 02:10:25 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 02:10:24 +0000
Date: Mon, 3 Aug 2026 10:10:18 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/5] hw/ssi: Add Synopsys DesignWare SSI standard PIO
 controller
Message-ID: <am_1N3eEBeSROBYe@ChaodeMacBook-Pro.local>
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
 <20260801192848.30606-2-flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801192848.30606-2-flamboyant.h.01@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 5386c14a-11c3-4a41-9f96-08def10460da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: d2z57s310emHNIjfGfqvKRfU/BOxjGTKBnDtuSTad6cnnKqYyFtGaMDMjhhKhMUOnyOq02rAi6OkdKp927whpHk4zTcyKJffuS+WLO2P3DnsVvD2uQc4dSwlLlCU84NLRktMWmKWJ9cQd7gIJ0KhDVxJqLhh4dUCesvBSPupGKDJNIujnP3PQ6MkUSFl83oArZDZ1h4VpEyEVzZYLc48ohMSBOCDcJenrqvdaqwoitD187cqA5I8KsOd9girAYzLz6TBtZ3Wb4EC0cUEcfA+QVRpTQjOJdNK7bgA+cC/1gcaGwkLhBkJRnDyoRogxvMv+FeQAqrLo9ZUkyYVvXscELfdtVptvCNfhR/UWoEEcf2baXHbB3mzJm92Zma3ME/gClibzLBjN/lndl2UI2jV/WqRFXkyJ53rhdfKvGCkwiug+QG8AZZX/nUo3Yomn/6HCKAztaysHi0imR0AEjFF0bYPeWmpyTuaj9uXzU9zX8ACNW4HQmIS/O8DjcHFyaAM817zhCbp/2pruQZ6J45wpxbSKf+OF6VyTrU4xMYCLP7X/4ShoF+f6HQJoAenDWysL/oMXEpBZR/CWf7msTWpzC1PYSdmILIFRtU3QbUvHQ2sBbaasFpmMKIx4i08tIJcyGEqHuJSVV3+fMUVqPYoOnsWf15Ulhuui3GyRJHvfFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3wHJHYfAe/7Cwgo0fr86b8Eec9zyFgqcrPJsqU/bXXEK6WGmnCU1TDnztLO1?=
 =?us-ascii?Q?FrOT+Rnzrr0Yj9BzDkgV5OJ7N+a2XH3pwngYEjojIK+b0FCxs/A1siHsxgyY?=
 =?us-ascii?Q?Itbw4ANycptig35KzgO8Dasxc1hb2DgBMj0xHyC4YwIYyxsc5B8Bxw0MdS3G?=
 =?us-ascii?Q?Ef8RtnyA4wMPWvnNA6prRwNDZBqMxYVnv9VTZNhBsOyoLbTXDDqfAvRqmrwP?=
 =?us-ascii?Q?/SyXU1HwEmvWtfP+ockSXNzgsT7TJbKD/Q6u/mRcJs2DEbR0VVNGabtv6E3X?=
 =?us-ascii?Q?X9NRjPAgJ6+3BFwpnFoVCeVsCFkLOlMvRdq4ZGhfcbOHZwKl/JEZQxFHdmof?=
 =?us-ascii?Q?oLLEIIjwNr08hkSdf6IXzvpime5fZ4rXziaeD/Wi3/GJhGpqQ68GCMxLLk9f?=
 =?us-ascii?Q?wTQnN42hieYQhYmyERYJyPhqJeTbo+E7NI7NTq5Gko7tf0Y0UFaYfY/VhNxT?=
 =?us-ascii?Q?7vXvQqU421d703QtKxJKR+/QnQPd7hGeBQ2KGO9NBR0VDVBMPjmw9y50AH89?=
 =?us-ascii?Q?wUZai9Vq9vDBWssZkV0K64KjKCcCEkCgXbX8O9kloZ6Yu87YqlgOwlC2AipH?=
 =?us-ascii?Q?XxyFBLy/jmKaVYFIJBKtzCF3IFoCvp1ghE+uLrBphJW9RkNbS1XwLxWfsDxC?=
 =?us-ascii?Q?O2oVLoR8YBCiuQJmlT5F5mL7j5Sbp5lBodT+56WwM0DOTYUvslvLLXUhI+pA?=
 =?us-ascii?Q?MOxh2v4gAcIX2o9i0j+62sAb7IlpU/QOApWLGbX3d66N6s9TXGpxxvdgAfYP?=
 =?us-ascii?Q?P2BUv1UhY+i66QWA1lbs6uvLGdl0rDPp2xOl5QoRV20hnfQ4paWahPUNcCdv?=
 =?us-ascii?Q?tsfqzPBFwoCIU/qAcWOt2rGnIM4oZdbCJojtVx8JDUa4wp62gchjMKKIztVO?=
 =?us-ascii?Q?ZuF+TMxHtkPzK/1rb2e7WoriLGgcH2BOfy/mXzzx2OFHENNaGHZtqnhxe65a?=
 =?us-ascii?Q?oU60C2rwPjE09AyjI4c5c8HuHRS+7leczK7E9d10yde4N0FsthX2hYmizBY+?=
 =?us-ascii?Q?hiXxxzbBAWqU7jJVXn5WSRnTfWw8j0kqumUgPb227kzGpeivXarvDP0dHSjW?=
 =?us-ascii?Q?8KpsfoPsaR5BrXcNoWZg3u1LrSMkkgSCjFrcpFqNNwi0yqL/YLwSzxjvUecD?=
 =?us-ascii?Q?oInfOItZBEDtWiUWirNT4fjWnhiQQt3cyyG6ZjuaI8ac5Ta74ZeSuLBHiEeA?=
 =?us-ascii?Q?QWgYgdTg1S94CoK1cgso8HVLhRVg31ipyltrZUPr/g8vX2jLC1FROOdONjWH?=
 =?us-ascii?Q?7hg0eh30s3bhQeYR6WwVzQ/FFXZEXBVifeMpCyhyPGeKU3kdF63FSoTd33a0?=
 =?us-ascii?Q?9sNh9sU7KL+1AyjJBimndraCRnR/HwEWpn29BKSZuvy+qxzpCZXKWsGa33pw?=
 =?us-ascii?Q?h+vyV2eaq9GmuSvIZx+m3bX3oCSOUQlG3SWYGDjwh3qdZudVNViHvVQPJ5dM?=
 =?us-ascii?Q?pmRnUthB+CvQL6eV/Dm8V76W0EuM15xbsOw3T6rzrR4bpVvb3Lzj6q0jM41x?=
 =?us-ascii?Q?0O2zHLvAPJMQuu5Hm6+RtNG6ZJQSJAHLwu2bCykkfaCV4g+zf0xd7L2yXTID?=
 =?us-ascii?Q?mOTSOj9S4hM/sIjROhF6rtiMJnVjIvxW/Gub4eswmyXafo0hHb2vRpaEm0lx?=
 =?us-ascii?Q?c2wJxTPCvuuyGQAvxo0av3vKK+StWGMi1MZw06IcuOnZK6r8pYrf5qaU4x49?=
 =?us-ascii?Q?KzWw6w/btOhnhKlArpHRhc+F2jb7EOOnXoKMz9jgqvVXW9s5LI4rHzY15mEa?=
 =?us-ascii?Q?JvmrBI7PlLuenHPZZ4HldcvrxMhCii8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5386c14a-11c3-4a41-9f96-08def10460da
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 02:10:24.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL50oNCgtdcuYsiSOvIN+F9AGwPoH7DfisCZsUYBNZfK1ndBjyOLc1kMh9mZ+pBtSm+Ii+2p5rfi1N50hWViIyZWc59OztetNu4HSdYx5OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB8006
Received-SPF: pass client-ip=40.107.44.102;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 02, 2026 at 03:28:44AM +0800, Kangjie Huang wrote:
> Add a reusable SysBus model for the Synopsys DesignWare SSI controller.
> 
> Implement the Standard SPI register subset, configurable chip-select and
> FIFO resources, the four Standard PIO transfer modes, reset handling,
> chip-select GPIOs, and RAZ/WI handling for unsupported enhanced, DMA,
> and XIP registers.
> 
> Add num-cs, fifo-depth, and imr-reset properties. Save only Standard PIO
> state in VMState and reject migration between devices with different
> resource profiles.
> 
> The controller is not instantiated by this patch.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>  hw/ssi/Kconfig          |   4 +
>  hw/ssi/dw_ssi.c         | 956 ++++++++++++++++++++++++++++++++++++++++
>  hw/ssi/meson.build      |   1 +
>  include/hw/ssi/dw_ssi.h |  62 +++
>  4 files changed, 1023 insertions(+)
>  create mode 100644 hw/ssi/dw_ssi.c
>  create mode 100644 include/hw/ssi/dw_ssi.h
> 
> diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
> index 1bd56463c1..c48cd2ff6d 100644
> --- a/hw/ssi/Kconfig
> +++ b/hw/ssi/Kconfig
> @@ -6,6 +6,10 @@ config SIFIVE_SPI
>      bool
>      select SSI
>  
> +config DW_SSI
> +    bool
> +    select SSI
> +
>  config SSI
>      bool
>  
> diff --git a/hw/ssi/dw_ssi.c b/hw/ssi/dw_ssi.c
> new file mode 100644
> index 0000000000..f9f0e23730
> --- /dev/null
> +++ b/hw/ssi/dw_ssi.c
> @@ -0,0 +1,956 @@
> +/*
> + * Synopsys DesignWare SSI
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Emulates the DesignWare SSI controller in Standard SPI mode,
> + * covering the PIO/FIFO data path and chip selects.
Could you share a stable public link to the DesignWare SSI datasheet here?

Thanks,
Chao
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/irq.h"
> +#include "hw/ssi/dw_ssi.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +/* DWC SSI 1.03 derivative (TRM v0.3.1 section 12.3). */
> +#define DW_SSI_CTRLR0_RESET            0x00004007
> +#define DW_SSI_SR_RESET                0x00000006
> +#define DW_SSI_IDR_RESET               0xa1b2c3d5
> +#define DW_SSI_VERSION                 0x3130332a
> +#define DW_SSI_PIO_TX_BATCH            64
> +
> +enum {
> +    DW_SSI_TMOD_TR,
> +    DW_SSI_TMOD_TO,
> +    DW_SSI_TMOD_RO,
> +    DW_SSI_TMOD_EEPROM_READ,
> +};
> +
> +REG32(CTRLR0, 0x000)
> +    FIELD(CTRLR0, DFS, 0, 5)
> +    FIELD(CTRLR0, FRF, 6, 2)
> +    FIELD(CTRLR0, SCPH, 8, 1)
> +    FIELD(CTRLR0, SCPOL, 9, 1)
> +    FIELD(CTRLR0, TMOD, 10, 2)
> +    FIELD(CTRLR0, SLV_OE, 12, 1)
> +    FIELD(CTRLR0, SRL, 13, 1)
> +    FIELD(CTRLR0, SSTE, 14, 1)
> +    FIELD(CTRLR0, CFS, 16, 4)
> +    FIELD(CTRLR0, SPI_FRF, 22, 2)
> +    FIELD(CTRLR0, SPI_HYPERBUS_EN, 24, 1)
> +    FIELD(CTRLR0, SPI_DWS_EN, 25, 1)
> +REG32(CTRLR1, 0x004)
> +    FIELD(CTRLR1, NDF, 0, 16)
> +REG32(SSIENR, 0x008)
> +    FIELD(SSIENR, SSIC_EN, 0, 1)
> +REG32(MWCR, 0x00c)
> +    FIELD(MWCR, MWMOD, 0, 1)
> +    FIELD(MWCR, MDD, 1, 1)
> +    FIELD(MWCR, MHS, 2, 1)
> +REG32(SER, 0x010)
> +REG32(BAUDR, 0x014)
> +    FIELD(BAUDR, SCKDV, 1, 15)
> +REG32(TXFTLR, 0x018)
> +    FIELD(TXFTLR, TFT, 0, 8)
> +    FIELD(TXFTLR, TXFTHR, 16, 11)
> +REG32(RXFTLR, 0x01c)
> +    FIELD(RXFTLR, RFT, 0, 8)
> +REG32(TXFLR, 0x020)
> +    FIELD(TXFLR, TXTFL, 0, 9)
> +REG32(RXFLR, 0x024)
> +    FIELD(RXFLR, RXTFL, 0, 9)
> +REG32(SR, 0x028)
> +    FIELD(SR, CMPLTD_DF, 15, 17)
> +    FIELD(SR, DCOL, 6, 1)
> +    FIELD(SR, TXE, 5, 1)
> +    FIELD(SR, BUSY, 0, 1)
> +    FIELD(SR, TFNF, 1, 1)
> +    FIELD(SR, TFE, 2, 1)
> +    FIELD(SR, RFNE, 3, 1)
> +    FIELD(SR, RFF, 4, 1)
> +REG32(IMR, 0x02c)
> +    FIELD(IMR, DONEM, 11, 1)
> +    FIELD(IMR, SPITEM, 10, 1)
> +    FIELD(IMR, AXIEM, 8, 1)
> +    FIELD(IMR, TXUIM, 7, 1)
> +    FIELD(IMR, XRXOIM, 6, 1)
> +    FIELD(IMR, MSTIM, 5, 1)
> +    FIELD(IMR, RXOIM, 3, 1)
> +    FIELD(IMR, RXUIM, 2, 1)
> +    FIELD(IMR, TXOIM, 1, 1)
> +    FIELD(IMR, TXEIM, 0, 1)
> +    FIELD(IMR, RXFIM, 4, 1)
> +REG32(ISR, 0x030)
> +    FIELD(ISR, DONES, 11, 1)
> +    FIELD(ISR, SPITES, 10, 1)
> +    FIELD(ISR, AXIES, 8, 1)
> +    FIELD(ISR, TXUIS, 7, 1)
> +    FIELD(ISR, XRXOIS, 6, 1)
> +    FIELD(ISR, MSTIS, 5, 1)
> +    FIELD(ISR, RXOIS, 3, 1)
> +    FIELD(ISR, RXUIS, 2, 1)
> +    FIELD(ISR, TXOIS, 1, 1)
> +    FIELD(ISR, TXEIS, 0, 1)
> +    FIELD(ISR, RXFIS, 4, 1)
> +REG32(RISR, 0x034)
> +    FIELD(RISR, DONER, 11, 1)
> +    FIELD(RISR, SPITER, 10, 1)
> +    FIELD(RISR, AXIER, 8, 1)
> +    FIELD(RISR, TXUIR, 7, 1)
> +    FIELD(RISR, XRXOIR, 6, 1)
> +    FIELD(RISR, MSTIR, 5, 1)
> +    FIELD(RISR, RXOIR, 3, 1)
> +    FIELD(RISR, RXUIR, 2, 1)
> +    FIELD(RISR, TXOIR, 1, 1)
> +    FIELD(RISR, TXEIR, 0, 1)
> +    FIELD(RISR, RXFIR, 4, 1)
> +REG32(TXEICR, 0x038)
> +    FIELD(TXEICR, TXEICR, 0, 1)
> +REG32(RXOICR, 0x03c)
> +    FIELD(RXOICR, RXOICR, 0, 1)
> +REG32(RXUICR, 0x040)
> +    FIELD(RXUICR, RXUICR, 0, 1)
> +REG32(MSTICR, 0x044)
> +    FIELD(MSTICR, MSTICR, 0, 1)
> +REG32(ICR, 0x048)
> +    FIELD(ICR, ICR, 0, 1)
> +REG32(DMACR, 0x04c)
> +    FIELD(DMACR, RDMAE, 0, 1)
> +    FIELD(DMACR, TDMAE, 1, 1)
> +    FIELD(DMACR, IDMAE, 2, 1)
> +    FIELD(DMACR, ATW, 3, 2)
> +    FIELD(DMACR, AINC, 6, 1)
> +    FIELD(DMACR, ACACHE, 8, 4)
> +    FIELD(DMACR, APROT, 12, 3)
> +    FIELD(DMACR, AID, 15, 4)
> +REG32(AXIAWLEN, 0x050)
> +    FIELD(AXIAWLEN, AWLEN, 8, 8)
> +REG32(AXIARLEN, 0x054)
> +    FIELD(AXIARLEN, ARLEN, 8, 8)
> +REG32(IDR, 0x058)
> +    FIELD(IDR, IDCODE, 0, 32)
> +REG32(SSIC_VERSION_ID, 0x05c)
> +    FIELD(SSIC_VERSION_ID, VERSION_ID, 0, 32)
> +REG32(DR0, 0x060)
> +REG32(DR_END, 0x0ec)
> +REG32(RX_SAMPLE_DELAY, 0x0f0)
> +    FIELD(RX_SAMPLE_DELAY, RSD, 0, 8)
> +    FIELD(RX_SAMPLE_DELAY, SE, 16, 1)
> +REG32(SPI_CTRLR0, 0x0f4)
> +    FIELD(SPI_CTRLR0, CLK_STRETCH_EN, 30, 1)
> +    FIELD(SPI_CTRLR0, XIP_PREFETCH_EN, 29, 1)
> +    FIELD(SPI_CTRLR0, XIP_MBL, 26, 2)
> +    FIELD(SPI_CTRLR0, SPI_RXDS_SIG_EN, 25, 1)
> +    FIELD(SPI_CTRLR0, SPI_DM_EN, 24, 1)
> +    FIELD(SPI_CTRLR0, SSIC_XIP_CONT_XFER_EN, 21, 1)
> +    FIELD(SPI_CTRLR0, XIP_INST_EN, 20, 1)
> +    FIELD(SPI_CTRLR0, XIP_DFS_HC, 19, 1)
> +    FIELD(SPI_CTRLR0, SPI_RXDS_EN, 18, 1)
> +    FIELD(SPI_CTRLR0, INST_DDR_EN, 17, 1)
> +    FIELD(SPI_CTRLR0, SPI_DDR_EN, 16, 1)
> +    FIELD(SPI_CTRLR0, WAIT_CYCLES, 11, 5)
> +    FIELD(SPI_CTRLR0, INST_L, 8, 2)
> +    FIELD(SPI_CTRLR0, XIP_MD_BIT_EN, 7, 1)
> +    FIELD(SPI_CTRLR0, ADDR_L, 2, 4)
> +    FIELD(SPI_CTRLR0, TRANS_TYPE, 0, 2)
> +REG32(DDR_DRIVE_EDGE, 0x0f8)
> +    FIELD(DDR_DRIVE_EDGE, TDE, 0, 8)
> +REG32(XIP_MODE_BITS, 0x0fc)
> +    FIELD(XIP_MODE_BITS, XIP_MD_BITS, 0, 16)
> +REG32(XIP_INCR_INST, 0x100)
> +    FIELD(XIP_INCR_INST, INCR_INST, 0, 16)
> +REG32(XIP_WRAP_INST, 0x104)
> +    FIELD(XIP_WRAP_INST, WRAP_INST, 0, 16)
> +REG32(XIP_CTRL, 0x108)
> +REG32(XIP_SER, 0x10c)
> +REG32(XRXOICR, 0x110)
> +REG32(XIP_CNT_TIME_OUT, 0x114)
> +REG32(SPI_CTRLR1, 0x118)
> +REG32(SPITECR, 0x11c)
> +REG32(SPIDR, 0x120)
> +    FIELD(SPIDR, SPI_INST, 0, 16)
> +REG32(SPIAR, 0x124)
> +    FIELD(SPIAR, SDAR, 0, 32)
> +REG32(AXIAR0, 0x128)
> +    FIELD(AXIAR0, AXIAR_0_31, 0, 32)
> +REG32(AXIAR1, 0x12c)
> +    FIELD(AXIAR1, AXIAR_32_63, 0, 32)
> +REG32(AXIECR, 0x130)
> +    FIELD(AXIECR, AXIECR, 0, 1)
> +REG32(DONECR, 0x134)
> +    FIELD(DONECR, DONECR, 0, 1)
> +REG32(RSVD_138, 0x138)
> +REG32(RSVD_13C, 0x13c)
> +REG32(XIP_WRITE_INCR_INST, 0x140)
> +REG32(XIP_WRITE_WRAP_INST, 0x144)
> +REG32(XIP_WRITE_CTRL, 0x148)
> +
> +#define DW_SSI_CTRLR0_STANDARD_WRITABLE_MASK \
> +    (R_CTRLR0_DFS_MASK | \
> +     R_CTRLR0_SCPH_MASK | \
> +     R_CTRLR0_SCPOL_MASK | \
> +     R_CTRLR0_TMOD_MASK | \
> +     R_CTRLR0_SLV_OE_MASK | \
> +     R_CTRLR0_SRL_MASK | \
> +     R_CTRLR0_SSTE_MASK | \
> +     R_CTRLR0_CFS_MASK)
> +
> +#define DW_SSI_CTRLR1_WRITABLE_MASK R_CTRLR1_NDF_MASK
> +#define DW_SSI_MWCR_WRITABLE_MASK \
> +    (R_MWCR_MWMOD_MASK | R_MWCR_MDD_MASK)
> +#define DW_SSI_BAUDR_WRITABLE_MASK R_BAUDR_SCKDV_MASK
> +#define DW_SSI_TXFTLR_WRITABLE_MASK \
> +    (R_TXFTLR_TFT_MASK | R_TXFTLR_TXFTHR_MASK)
> +#define DW_SSI_RXFTLR_WRITABLE_MASK R_RXFTLR_RFT_MASK
> +#define DW_SSI_IMR_WRITABLE_MASK \
> +    (R_IMR_TXEIM_MASK | R_IMR_TXOIM_MASK | R_IMR_RXUIM_MASK | \
> +     R_IMR_RXOIM_MASK | R_IMR_RXFIM_MASK | R_IMR_MSTIM_MASK | \
> +     R_IMR_TXUIM_MASK)
> +#define DW_SSI_RX_SAMPLE_DELAY_WRITABLE_MASK \
> +    (R_RX_SAMPLE_DELAY_RSD_MASK | R_RX_SAMPLE_DELAY_SE_MASK)
> +
> +static bool dw_ssi_validate_config(DwSsiState *s, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(s);
> +
> +    if (s->cfg.num_cs == 0 || s->cfg.num_cs > 8) {
> +        error_setg(errp, "%s: num-cs must be in range 1..8",
> +                   dev->canonical_path);
> +        return false;
> +    }
> +
> +    if (s->cfg.fifo_depth < 2 || s->cfg.fifo_depth > 256) {
> +        error_setg(errp, "%s: fifo-depth must be in range 2..256",
> +                   dev->canonical_path);
> +        return false;
> +    }
> +
> +    if (s->cfg.imr_reset & ~DW_SSI_IMR_WRITABLE_MASK) {
> +        error_setg(errp, "%s: imr-reset contains unsupported bits",
> +                   dev->canonical_path);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool dw_ssi_fifo_threshold_valid(const DwSsiState *s, uint32_t value)
> +{
> +    return value < s->cfg.fifo_depth;
> +}
> +
> +static void dw_ssi_write_masked(DwSsiState *s, unsigned int reg,
> +                                     uint32_t value, uint32_t mask)
> +{
> +    s->regs[reg] = (s->regs[reg] & ~mask) | (value & mask);
> +}
> +
> +static uint32_t dw_ssi_frame_masked(DwSsiState *s)
> +{
> +    unsigned int bits = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, DFS) + 1;
> +
> +    return bits == 32 ? UINT32_MAX : MAKE_64BIT_MASK(0, bits);
> +}
> +
> +static bool dw_ssi_is_enabled(const DwSsiState *s)
> +{
> +    return FIELD_EX32(s->regs[R_SSIENR], SSIENR, SSIC_EN);
> +}
> +
> +static void dw_ssi_deselect(DwSsiState *s)
> +{
> +    if (s->active_cs < 0) {
> +        return;
> +    }
> +
> +    qemu_irq_raise(s->cs_lines[s->active_cs]);
> +    s->active_cs = -1;
> +}
> +
> +static void dw_ssi_select(DwSsiState *s, unsigned cs)
> +{
> +    if (cs >= s->cfg.num_cs) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid chip select %u\n",
> +                      DEVICE(s)->canonical_path, cs);
> +        dw_ssi_deselect(s);
> +        return;
> +    }
> +
> +    if (s->active_cs == cs) {
> +        return;
> +    }
> +
> +    dw_ssi_deselect(s);
> +    qemu_irq_lower(s->cs_lines[cs]);
> +    s->active_cs = cs;
> +}
> +
> +static void dw_ssi_update_cs(DwSsiState *s)
> +{
> +    uint32_t ser = s->regs[R_SER];
> +
> +    if (!dw_ssi_is_enabled(s) || !ser) {
> +        dw_ssi_deselect(s);
> +        return;
> +    }
> +
> +    if (ser & (ser - 1)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: multiple chip selects enabled: 0x%x\n",
> +                      DEVICE(s)->canonical_path, ser);
> +        dw_ssi_deselect(s);
> +        return;
> +    }
> +
> +    dw_ssi_select(s, ctz32(ser));
> +}
> +
> +static void dw_ssi_abort_transfer(DwSsiState *s)
> +{
> +    dw_ssi_deselect(s);
> +    fifo32_reset(&s->tx_fifo);
> +    fifo32_reset(&s->rx_fifo);
> +    s->phase = DW_SSI_PHASE_IDLE;
> +    s->remaining_frames = 0;
> +}
> +
> +static uint32_t dw_ssi_status(DwSsiState *s)
> +{
> +    uint32_t tx_used = fifo32_num_used(&s->tx_fifo);
> +    uint32_t rx_used = fifo32_num_used(&s->rx_fifo);
> +    uint32_t sr = 0;
> +
> +    sr = FIELD_DP32(sr, SR, BUSY, s->phase != DW_SSI_PHASE_IDLE);
> +    sr = FIELD_DP32(sr, SR, TFNF, tx_used < s->cfg.fifo_depth);
> +    sr = FIELD_DP32(sr, SR, TFE, tx_used == 0);
> +    sr = FIELD_DP32(sr, SR, RFNE, rx_used != 0);
> +    sr = FIELD_DP32(sr, SR, RFF,
> +                    rx_used == s->cfg.fifo_depth);
> +
> +    return sr;
> +}
> +
> +static void dw_ssi_run_transfer(DwSsiState *s);
> +
> +static void dw_ssi_push_tx(DwSsiState *s, uint32_t tx)
> +{
> +    if (!dw_ssi_is_enabled(s)) {
> +        return;
> +    }
> +
> +    if (fifo32_is_full(&s->tx_fifo)) {
> +        return;
> +    }
> +
> +    fifo32_push(&s->tx_fifo, tx);
> +
> +    if (s->phase != DW_SSI_PHASE_STANDARD_TX_ONLY) {
> +        dw_ssi_run_transfer(s);
> +    }
> +}
> +
> +static uint32_t dw_ssi_send_frame(DwSsiState *s,
> +                                        uint32_t tx)
> +{
> +    uint32_t mask = dw_ssi_frame_masked(s);
> +    uint32_t rx;
> +
> +    tx &= mask;
> +
> +    if (FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SRL)) {
> +        rx = tx;
> +    } else {
> +        rx = ssi_transfer(s->spi, tx);
> +    }
> +
> +    return rx & mask;
> +}
> +
> +static void dw_ssi_run_transfer(DwSsiState *s)
> +{
> +    uint32_t tmod;
> +
> +    if (!dw_ssi_is_enabled(s) || s->active_cs < 0) {
> +        return;
> +    }
> +
> +    /* SCKDV=0 disables sclk_out: no transfer can start. */
> +    if (FIELD_EX32(s->regs[R_BAUDR], BAUDR, SCKDV) == 0) {
> +        return;
> +    }
> +
> +    /*
> +     * TRM: the controller starts shifting only after the TX FIFO
> +     * occupancy exceeds TXFTLR.TXFTHR.  Transfers already in flight
> +     * are not interrupted when the FIFO temporarily drops below the
> +     * level.
> +     */
> +    if (s->phase == DW_SSI_PHASE_IDLE &&
> +        fifo32_num_used(&s->tx_fifo) <=
> +            FIELD_EX32(s->regs[R_TXFTLR], TXFTLR, TXFTHR)) {
> +        return;
> +    }
> +
> +    tmod = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, TMOD);
> +
> +    switch (tmod) {
> +    case DW_SSI_TMOD_TR:
> +        if (s->phase == DW_SSI_PHASE_IDLE) {
> +            s->phase = DW_SSI_PHASE_STANDARD_TR;
> +        }
> +
> +        while (!fifo32_is_empty(&s->tx_fifo)) {
> +            uint32_t tx = fifo32_pop(&s->tx_fifo);
> +            uint32_t rx = dw_ssi_send_frame(s, tx);
> +
> +            if (!fifo32_is_full(&s->rx_fifo)) {
> +                fifo32_push(&s->rx_fifo, rx);
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: RX FIFO full, dropping frame\n",
> +                              DEVICE(s)->canonical_path);
> +                break;
> +            }
> +        }
> +
> +        if (fifo32_is_empty(&s->tx_fifo)) {
> +            s->phase = DW_SSI_PHASE_IDLE;
> +        }
> +        break;
> +    case DW_SSI_TMOD_TO: {
> +        unsigned int frames = 0;
> +
> +        if (fifo32_is_empty(&s->tx_fifo)) {
> +            s->phase = DW_SSI_PHASE_IDLE;
> +            break;
> +        }
> +
> +        s->phase = DW_SSI_PHASE_STANDARD_TX_ONLY;
> +        while (!fifo32_is_empty(&s->tx_fifo) &&
> +               frames < DW_SSI_PIO_TX_BATCH) {
> +            uint32_t tx = fifo32_pop(&s->tx_fifo);
> +
> +            dw_ssi_send_frame(s, tx);
> +            frames++;
> +        }
> +        if (fifo32_is_empty(&s->tx_fifo)) {
> +            s->phase = DW_SSI_PHASE_IDLE;
> +        }
> +        break;
> +    }
> +    case DW_SSI_TMOD_RO:
> +        switch (s->phase) {
> +        case DW_SSI_PHASE_IDLE:
> +            if (fifo32_is_empty(&s->tx_fifo)) {
> +                break;
> +            }
> +            fifo32_pop(&s->tx_fifo);
> +            s->phase = DW_SSI_PHASE_RX_ONLY;
> +            s->remaining_frames = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1,
> +                                              NDF) + 1;
> +            /* Fall through. */
> +        case DW_SSI_PHASE_RX_ONLY:
> +            while (!fifo32_is_full(&s->rx_fifo) &&
> +                   s->remaining_frames > 0) {
> +                uint32_t rx = dw_ssi_send_frame(s, 0x00);
> +
> +                fifo32_push(&s->rx_fifo, rx);
> +                s->remaining_frames--;
> +            }
> +            if (s->remaining_frames == 0) {
> +                s->phase = DW_SSI_PHASE_IDLE;
> +            }
> +            break;
> +        }
> +        break;
> +    case DW_SSI_TMOD_EEPROM_READ:
> +        switch (s->phase) {
> +        case DW_SSI_PHASE_IDLE:
> +            if (fifo32_is_empty(&s->tx_fifo)) {
> +                break;
> +            }
> +            s->phase = DW_SSI_PHASE_EEPROM_COMMAND;
> +            /* Fall through. */
> +        case DW_SSI_PHASE_EEPROM_COMMAND:
> +            if (fifo32_is_empty(&s->tx_fifo)) {
> +                break;
> +            }
> +            while (!fifo32_is_empty(&s->tx_fifo)) {
> +                uint32_t tx = fifo32_pop(&s->tx_fifo);
> +
> +                dw_ssi_send_frame(s, tx);
> +            }
> +            s->phase = DW_SSI_PHASE_EEPROM_DATA;
> +            s->remaining_frames = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1,
> +                                              NDF) + 1;
> +            /* Fall through. */
> +        case DW_SSI_PHASE_EEPROM_DATA:
> +            while (!fifo32_is_full(&s->rx_fifo) &&
> +                   s->remaining_frames > 0) {
> +                uint32_t rx = dw_ssi_send_frame(s, 0x00);
> +
> +                fifo32_push(&s->rx_fifo, rx);
> +                s->remaining_frames--;
> +            }
> +            if (s->remaining_frames == 0) {
> +                s->phase = DW_SSI_PHASE_IDLE;
> +            }
> +            break;
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static bool dw_ssi_is_dr(hwaddr addr)
> +{
> +    return addr >= A_DR0 && addr <= A_DR_END &&
> +           (addr & 0x3) == 0;
> +}
> +
> +static bool dw_ssi_is_unsupported_offset(hwaddr addr)
> +{
> +    switch (addr) {
> +    /* Enhanced SPI extensions. */
> +    case A_SPI_CTRLR0:
> +    case A_DDR_DRIVE_EDGE:
> +
> +    /* XIP extensions. */
> +    case A_XIP_MODE_BITS:
> +    case A_XIP_INCR_INST:
> +    case A_XIP_WRAP_INST:
> +    case A_XIP_CTRL:
> +    case A_XIP_SER:
> +    case A_XRXOICR:
> +    case A_XIP_CNT_TIME_OUT:
> +    case A_SPI_CTRLR1:
> +    case A_SPITECR:
> +    case A_RSVD_138:
> +    case A_RSVD_13C:
> +    case A_XIP_WRITE_INCR_INST:
> +    case A_XIP_WRITE_WRAP_INST:
> +    case A_XIP_WRITE_CTRL:
> +
> +    /* Internal-AXI DMA/IDMA extensions. */
> +    case A_DMACR:
> +    case A_AXIAWLEN:
> +    case A_AXIARLEN:
> +    case A_SPIDR:
> +    case A_SPIAR:
> +    case A_AXIAR0:
> +    case A_AXIAR1:
> +    case A_AXIECR:
> +    case A_DONECR:
> +
> +    /* SSI unsupported extensions. */
> +    case A_RX_SAMPLE_DELAY:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static bool dw_ssi_write_requires_disabled(hwaddr addr)
> +{
> +    switch (addr) {
> +    case A_CTRLR0:
> +    case A_CTRLR1:
> +    case A_MWCR:
> +    case A_BAUDR:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static uint32_t dw_ssi_unsupported_read(DwSsiState *s,
> +                                        hwaddr addr)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                  "%s: unsupported read at 0x%" HWADDR_PRIx "\n",
> +                  DEVICE(s)->canonical_path, addr);
> +    return 0;
> +}
> +
> +static void dw_ssi_unsupported_write(DwSsiState *s,
> +                                     hwaddr addr,
> +                                     uint32_t value)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                  "%s: unsupported write at 0x%" HWADDR_PRIx
> +                  " value 0x%08x\n",
> +                  DEVICE(s)->canonical_path, addr, value);
> +}
> +
> +static uint64_t dw_ssi_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    DwSsiState *s = DW_SSI(opaque);
> +    uint32_t value = 0;
> +
> +    if (dw_ssi_is_dr(addr)) {
> +        if (!fifo32_is_empty(&s->rx_fifo)) {
> +            value = fifo32_pop(&s->rx_fifo) & dw_ssi_frame_masked(s);
> +        } else {
> +            value = 0;
> +        }
> +
> +        dw_ssi_run_transfer(s);
> +        return value;
> +    }
> +
> +    if (dw_ssi_is_unsupported_offset(addr)) {
> +        value = dw_ssi_unsupported_read(s, addr);
> +        return value;
> +    }
> +
> +    switch (addr) {
> +    case A_CTRLR0:
> +    case A_CTRLR1:
> +    case A_SSIENR:
> +    case A_MWCR:
> +    case A_BAUDR:
> +    case A_TXFTLR:
> +    case A_RXFTLR:
> +    case A_IMR:
> +    case A_IDR:
> +    case A_SSIC_VERSION_ID:
> +        value = s->regs[addr / sizeof(uint32_t)];
> +        break;
> +
> +    case A_SER:
> +        value = s->regs[R_SER] & MAKE_64BIT_MASK(0, s->cfg.num_cs);
> +        break;
> +    case A_TXFLR:
> +        value = fifo32_num_used(&s->tx_fifo);
> +        if (s->phase == DW_SSI_PHASE_STANDARD_TX_ONLY) {
> +            dw_ssi_run_transfer(s);
> +        }
> +        break;
> +    case A_RXFLR:
> +        value = fifo32_num_used(&s->rx_fifo);
> +        break;
> +    case A_SR:
> +        value = dw_ssi_status(s);
> +        if (s->phase == DW_SSI_PHASE_STANDARD_TX_ONLY) {
> +            dw_ssi_run_transfer(s);
> +        }
> +        break;
> +    default:
> +        if (addr >= DW_SSI_REGS_SIZE || (addr & 0x3) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: bad read offset 0x%" HWADDR_PRIx "\n",
> +                          DEVICE(s)->canonical_path, addr);
> +        }
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +static void dw_ssi_write(void *opaque, hwaddr addr,
> +                              uint64_t value, unsigned int size)
> +{
> +    DwSsiState *s = DW_SSI(opaque);
> +
> +    if (dw_ssi_is_dr(addr)) {
> +        dw_ssi_push_tx(s, value);
> +        return;
> +    }
> +
> +    if (dw_ssi_is_unsupported_offset(addr)) {
> +        dw_ssi_unsupported_write(s, addr, value);
> +        return;
> +    }
> +
> +    if (dw_ssi_write_requires_disabled(addr) &&
> +        dw_ssi_is_enabled(s)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write to offset 0x%" HWADDR_PRIx
> +                      " while SSI is enabled\n",
> +                      DEVICE(s)->canonical_path, addr);
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case A_CTRLR0:
> +        value &= ~R_CTRLR0_SPI_FRF_MASK;
> +        dw_ssi_write_masked(s, R_CTRLR0, value,
> +                                 DW_SSI_CTRLR0_STANDARD_WRITABLE_MASK);
> +        break;
> +    case A_CTRLR1:
> +        dw_ssi_write_masked(s, R_CTRLR1, value,
> +                                 DW_SSI_CTRLR1_WRITABLE_MASK);
> +        break;
> +    case A_SSIENR: {
> +        bool old_enabled = dw_ssi_is_enabled(s);
> +        bool new_enabled = value & R_SSIENR_SSIC_EN_MASK;
> +
> +        if (old_enabled == new_enabled) {
> +            return;
> +        }
> +
> +        s->regs[R_SSIENR] = FIELD_DP32(0, SSIENR, SSIC_EN, new_enabled);
> +        if (!new_enabled) {
> +            dw_ssi_abort_transfer(s);
> +            return;
> +        }
> +
> +        dw_ssi_update_cs(s);
> +        dw_ssi_run_transfer(s);
> +        break;
> +    }
> +    case A_MWCR:
> +        dw_ssi_write_masked(s, R_MWCR, value,
> +                                 DW_SSI_MWCR_WRITABLE_MASK);
> +        break;
> +    case A_SER: {
> +        uint32_t old_ser = s->regs[R_SER];
> +        uint32_t new_ser = value & MAKE_64BIT_MASK(0, s->cfg.num_cs);
> +
> +        /*
> +         * Changing the selected slave terminates a pending transaction:
> +         * the FIFOs are flushed only by clearing SSIENR (TRM), but a
> +         * stale RO/EEPROM phase must not resume on the new chip select.
> +         */
> +        if (old_ser != new_ser && s->phase != DW_SSI_PHASE_IDLE) {
> +            s->phase = DW_SSI_PHASE_IDLE;
> +            s->remaining_frames = 0;
> +        }
> +        s->regs[R_SER] = new_ser;
> +
> +        dw_ssi_update_cs(s);
> +        dw_ssi_run_transfer(s);
> +        break;
> +    }
> +    case A_BAUDR:
> +        dw_ssi_write_masked(s, R_BAUDR, value,
> +                                 DW_SSI_BAUDR_WRITABLE_MASK);
> +        break;
> +    case A_TXFTLR:
> +        if (!dw_ssi_fifo_threshold_valid(
> +                s, FIELD_EX32(value, TXFTLR, TFT)) ||
> +            !dw_ssi_fifo_threshold_valid(
> +                s, FIELD_EX32(value, TXFTLR, TXFTHR))) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid txftlr value %x\n",
> +                          DEVICE(s)->canonical_path, (unsigned int)value);
> +            break;
> +        }
> +        dw_ssi_write_masked(s, R_TXFTLR, value,
> +                                 DW_SSI_TXFTLR_WRITABLE_MASK);
> +        dw_ssi_run_transfer(s);
> +        break;
> +    case A_RXFTLR:
> +        if (!dw_ssi_fifo_threshold_valid(
> +                s, FIELD_EX32(value, RXFTLR, RFT))) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid rxftlr value %x\n",
> +                          DEVICE(s)->canonical_path, (unsigned int)value);
> +            break;
> +        }
> +        dw_ssi_write_masked(s, R_RXFTLR, value,
> +                                 DW_SSI_RXFTLR_WRITABLE_MASK);
> +        break;
> +    case A_TXFLR:
> +    case A_RXFLR:
> +    case A_SR:
> +        break;
> +    case A_IMR:
> +        dw_ssi_write_masked(s, R_IMR, value,
> +                                 DW_SSI_IMR_WRITABLE_MASK);
> +        break;
> +    case A_IDR:
> +    case A_SSIC_VERSION_ID:
> +        break;
> +    default:
> +        if (addr >= DW_SSI_REGS_SIZE || (addr & 0x3) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: bad write offset 0x%" HWADDR_PRIx "\n",
> +                          DEVICE(s)->canonical_path, addr);
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps dw_ssi_ops = {
> +    .read = dw_ssi_read,
> +    .write = dw_ssi_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void dw_ssi_enter_reset(Object *obj, ResetType type)
> +{
> +    DwSsiState *s = DW_SSI(obj);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    fifo32_reset(&s->tx_fifo);
> +    fifo32_reset(&s->rx_fifo);
> +    s->phase = DW_SSI_PHASE_IDLE;
> +    s->remaining_frames = 0;
> +
> +    s->regs[R_CTRLR0] = DW_SSI_CTRLR0_RESET;
> +    s->regs[R_SR] = DW_SSI_SR_RESET;
> +    s->regs[R_IMR] = s->cfg.imr_reset & DW_SSI_IMR_WRITABLE_MASK;
> +    s->regs[R_IDR] = DW_SSI_IDR_RESET;
> +    s->regs[R_SSIC_VERSION_ID] = DW_SSI_VERSION;
> +}
> +
> +static void dw_ssi_hold_reset(Object *obj, ResetType type)
> +{
> +    DwSsiState *s = DW_SSI(obj);
> +    s->active_cs = -1;
> +
> +    if (s->cs_lines) {
> +        for (int i = 0; i < s->cfg.num_cs; i++) {
> +            qemu_irq_raise(s->cs_lines[i]);
> +        }
> +    }
> +}
> +
> +static int dw_ssi_post_load(void *opaque, int version_id)
> +{
> +    DwSsiState *s = opaque;
> +    uint32_t ndf = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1, NDF) + 1;
> +
> +    if (s->active_cs < -1 || s->active_cs >= (int)s->cfg.num_cs) {
> +        return -EINVAL;
> +    }
> +    if (s->phase > DW_SSI_PHASE_STANDARD_TR) {
> +        return -EINVAL;
> +    }
> +    if (s->phase == DW_SSI_PHASE_RX_ONLY ||
> +        s->phase == DW_SSI_PHASE_EEPROM_DATA) {
> +        if (s->remaining_frames == 0 || s->remaining_frames > ndf) {
> +            return -EINVAL;
> +        }
> +    } else if (s->remaining_frames != 0) {
> +        return -EINVAL;
> +    }
> +    if (s->active_cs >= 0 &&
> +        (!dw_ssi_is_enabled(s) ||
> +         s->regs[R_SER] != BIT(s->active_cs))) {
> +        return -EINVAL;
> +    }
> +
> +    for (int i = 0; i < s->cfg.num_cs; i++) {
> +        qemu_irq_raise(s->cs_lines[i]);
> +    }
> +    if (s->active_cs >= 0) {
> +        qemu_irq_lower(s->cs_lines[s->active_cs]);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_dw_ssi = {
> +    .name = TYPE_DW_SSI,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = dw_ssi_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_EQUAL(cfg.num_cs, DwSsiState),
> +        VMSTATE_UINT32_EQUAL(cfg.fifo_depth, DwSsiState),
> +        VMSTATE_UINT32_EQUAL(cfg.imr_reset, DwSsiState),
> +        VMSTATE_UINT32_ARRAY(regs, DwSsiState, DW_SSI_NUM_REGS),
> +        VMSTATE_FIFO32(tx_fifo, DwSsiState),
> +        VMSTATE_FIFO32(rx_fifo, DwSsiState),
> +        VMSTATE_UINT32(phase, DwSsiState),
> +        VMSTATE_UINT32(remaining_frames, DwSsiState),
> +        VMSTATE_INT32(active_cs, DwSsiState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void dw_ssi_init(Object *obj)
> +{
> +    DwSsiState *s = DW_SSI(obj);
> +    DeviceState *dev = DEVICE(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    s->spi = ssi_create_bus(dev, "spi");
> +
> +    memory_region_init_io(&s->mmio, obj, &dw_ssi_ops, s,
> +                          TYPE_DW_SSI, DW_SSI_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    s->active_cs = -1;
> +}
> +
> +static void dw_ssi_realize(DeviceState *dev, Error **errp)
> +{
> +    DwSsiState *s = DW_SSI(dev);
> +
> +    if (!dw_ssi_validate_config(s, errp)) {
> +        return;
> +    }
> +
> +    s->cs_lines = g_new0(qemu_irq, s->cfg.num_cs);
> +    qdev_init_gpio_out_named(dev, s->cs_lines, "cs", s->cfg.num_cs);
> +
> +    fifo32_create(&s->tx_fifo, s->cfg.fifo_depth);
> +    fifo32_create(&s->rx_fifo, s->cfg.fifo_depth);
> +}
> +
> +static void dw_ssi_finalize(Object *obj)
> +{
> +    DwSsiState *s = DW_SSI(obj);
> +
> +    fifo32_destroy(&s->tx_fifo);
> +    fifo32_destroy(&s->rx_fifo);
> +    g_free(s->cs_lines);
> +}
> +
> +static const Property dw_ssi_properties[] = {
> +    DEFINE_PROP_UINT32("num-cs", DwSsiState, cfg.num_cs, 1),
> +    DEFINE_PROP_UINT32("fifo-depth", DwSsiState, cfg.fifo_depth, 256),
> +    DEFINE_PROP_UINT32("imr-reset", DwSsiState,
> +                       cfg.imr_reset, 0x0000003f),
> +};
> +
> +static void dw_ssi_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = dw_ssi_realize;
> +    dc->vmsd = &vmstate_dw_ssi;
> +    device_class_set_props(dc, dw_ssi_properties);
> +    rc->phases.enter = dw_ssi_enter_reset;
> +    rc->phases.hold = dw_ssi_hold_reset;
> +}
> +
> +static const TypeInfo dw_ssi_info = {
> +    .name = TYPE_DW_SSI,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(DwSsiState),
> +    .instance_init = dw_ssi_init,
> +    .instance_finalize = dw_ssi_finalize,
> +    .class_init = dw_ssi_class_init,
> +};
> +
> +static void dw_ssi_register_types(void)
> +{
> +    type_register_static(&dw_ssi_info);
> +}
> +
> +type_init(dw_ssi_register_types)
> diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
> index 6afb1ea200..447780846c 100644
> --- a/hw/ssi/meson.build
> +++ b/hw/ssi/meson.build
> @@ -1,6 +1,7 @@
>  system_ss.add(when: 'CONFIG_ALLWINNER_A10_SPI', if_true: files('allwinner-a10-spi.c'))
>  system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_smc.c'))
>  system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-spi.c'))
> +system_ss.add(when: 'CONFIG_DW_SSI', if_true: files('dw_ssi.c'))
>  system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_fiu.c', 'npcm_pspi.c'))
>  system_ss.add(when: 'CONFIG_PL022', if_true: files('pl022.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_SPI', if_true: files('sifive_spi.c'))
> diff --git a/include/hw/ssi/dw_ssi.h b/include/hw/ssi/dw_ssi.h
> new file mode 100644
> index 0000000000..a74e906ef8
> --- /dev/null
> +++ b/include/hw/ssi/dw_ssi.h
> @@ -0,0 +1,62 @@
> +/*
> + * Synopsys DesignWare SSI
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Emulates the DesignWare SSI controller in Standard SPI mode,
> + * covering the PIO/FIFO data path and chip selects.
> + */
> +
> +#ifndef HW_SSI_DW_SSI_H
> +#define HW_SSI_DW_SSI_H
> +
> +#include "hw/core/sysbus.h"
> +#include "hw/ssi/ssi.h"
> +#include "qemu/fifo32.h"
> +#include "qom/object.h"
> +
> +#define TYPE_DW_SSI "designware-ssi"
> +OBJECT_DECLARE_SIMPLE_TYPE(DwSsiState, DW_SSI)
> +
> +#define DW_SSI_MMIO_SIZE 0x1000
> +#define DW_SSI_REGS_SIZE 0x14c
> +#define DW_SSI_NUM_REGS \
> +    (DW_SSI_REGS_SIZE / sizeof(uint32_t))
> +
> +typedef enum DwSsiPhase {
> +    DW_SSI_PHASE_IDLE,
> +    DW_SSI_PHASE_STANDARD_TX_ONLY,
> +    DW_SSI_PHASE_RX_ONLY,
> +    DW_SSI_PHASE_EEPROM_COMMAND,
> +    DW_SSI_PHASE_EEPROM_DATA,
> +    DW_SSI_PHASE_STANDARD_TR,
> +} DwSsiPhase;
> +
> +typedef struct DwSsiConfig {
> +    uint32_t num_cs;
> +    uint32_t fifo_depth;
> +    uint32_t imr_reset;
> +} DwSsiConfig;
> +
> +struct DwSsiState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    SSIBus *spi;
> +
> +    qemu_irq *cs_lines;
> +
> +    Fifo32 tx_fifo;
> +    Fifo32 rx_fifo;
> +    uint32_t regs[DW_SSI_NUM_REGS];
> +
> +    DwSsiConfig cfg;
> +
> +    uint32_t phase;
> +    uint32_t remaining_frames;
> +
> +    int active_cs;
> +};
> +#endif /* HW_SSI_DW_SSI_H */
> -- 
> 2.43.0
> 

