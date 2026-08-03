Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E971C55174
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 02:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqiNK-0007DR-Mv; Sun, 02 Aug 2026 22:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiNH-0007Ag-NZ; Sun, 02 Aug 2026 22:25:55 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wqiNF-0000GR-IV; Sun, 02 Aug 2026 22:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2y8UUmA4uACj/XMKwIlzMVI0Koi3VkHoGVqjfJoQ3mJUvblvcdFGZdx+X+JNPZk5dlP4AmbbyYQah8OVygguQWS1sqpy54M0FTEGK/iwuGASfR1ropnXt5+fTwdfx5JoR1KkkH6LkfEpJZMBaUwi+rxyRDXqaRY4TsHd4DndsoEyrXfP4DWJ0ytvcOvwHLoh69K0JgM8FFwGVMDB9CrIbk6+xpC10avaUGxdOkx0K9jDvXLUql5udTfGE6Az8Tn7xNppaXu/BsIc6/u/vyk55PBo4BRdD6ZxUQYvK0p2tyKhFzFCjszR0OVyXm0SBtTq/t9DYgs/g/Yzn9KBPO1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVviTAs5bTyb31PNuny1z2aOcGfI4dLGosJQZBOOcNo=;
 b=JyVPBw1OqtQ2g0wIx5Nr8iCkQAcjXl+M1Lo0ajzhkBOFmrODjNMxcvpUn3lRIUKysxIo6VblDCbWLheJU/YwiAnahE6Mj8NTX0eGWGVCUYx7Q92h+Z1IV74SdtCjx0gGEbwruFAMAHoJ3GEyT3mLNTK6hpzVqE7BxuR5ExI2qWJgS6ugqgNUxz15BzLJWPBV0EILW5xU7X4u3lGGRb+8I0U4gl6+VylrD5c6gsVqgf7JXMcMkwkoJFiOJRCILv8ImFG+HBk9PXiHkwL/nEKVNufEtRhfrRdZUOzvwtGAkucxHk93kTn8jE2AjmGZwdSFNBp6woX6clFXwwCZUEPa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVviTAs5bTyb31PNuny1z2aOcGfI4dLGosJQZBOOcNo=;
 b=bK5QCqOnMrLo706Bb84hJCTAiP8DIElyYQQBuINH1VUBTFLrzEeKsDdukH64YRmQDvBs85g3DMGHUTVwdvja09uCVbK8cvb5iFpSTHc6OE0Kxen6WllOjmYQA8Ba1OSiEzLywSuCVzghvS6vym6sDZ9wlUSEj8W6Ex/IWlDOQFarGkFcUzEchz7PCZ55qCMyILOlSsZnexgWWKD1yvZqJz2d4Dyte1b8K5XHN8cbmOsG6Yi9pHHkXZcIW0GkteUwtgxd0x1v4/gpL1MdUg+vFL8ZEDRC1VBO9LJJ4JHuWCcDmCHsQOjDEHl1fmoCvxjIeFyDLUNyrL5HBE4CZvyjCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KL1PR02MB6426.apcprd02.prod.outlook.com (2603:1096:820:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 02:25:47 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 02:25:47 +0000
Date: Mon, 3 Aug 2026 10:25:41 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis model
Message-ID: <am_8HMxTKN5fvgIm@ChaodeMacBook-Pro.local>
References: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
 <20260729-atlantis_prcm-v1-2-502882933e51@oss.tenstorrent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-atlantis_prcm-v1-2-502882933e51@oss.tenstorrent.com>
X-ClientProxiedBy: PH0PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:510:e::16) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KL1PR02MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 1588099a-ac08-43bd-f602-08def1068702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: pcBwwUfwWecCeH1dQE1Oyo+Gps5Mo8IelG/YGMLjtfbBgOa7szRgu3RWF/se3eaAxVk6JfaqXeJE1xKrLg0TRyGccEeCpVfimXEQ8AbsQN3FkD3zbV2O0L5sZsNAZyxDiGQS3lRhq0jWh3kczTgYth3SQqF6i9pulraByvA3SdHYiN3WsNd/e5mGdJMRcQSYRgO14BIF6lrJz8feByML8p56r2824FwnOZMPNMpQOuPXSfeBTIMJJz8OztaxXWLwjhojxPFI9v8HS7pQvayJNLEEZvNHtbw2++icAGOnqPolFOeBr88ue3kkUkm7rEZ7wOaCMXFrxP20HIzMCzPzxEnxgIx/iYu9wwBtH+klmLGfF4ZsSG/DISBhdViDogcfbWglgflEPwNia64OBoNKutJL6iUE5FAThFAdpCtGSvBhvtMLs8aXEw6rW5b30YIhYtWhvne6nphREGCTz/336l0Z1NYrh8/6U+CNQiwi8ZugJxOoy+mt4PzxrnxoloVJ7aBxX5R5RByu1wJ7NHB4SXARnnVUUVyeGMsjQ307kVur8hP5PYvWyZ9Dd33Pr6wu5aEkZ+YNsWp5lQhxUIpzgCXJe/X4jX7TXrRUwEb5gbvZz69dhQttpVI1XSxkufKWDqaQjjvpsKflG9AUgD3FbZBmZknihmkvha+FayWPNh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCcU+q+krqljxsPWn+mAjnuUW3j3Se/YNuwITO9uPHIqvu3n4UIxRnWnOMuy?=
 =?us-ascii?Q?VBgAYhA4Gva+YSBXvy74P/Upupp0RmlsPfejstzwyiRRL6xZCuECjKQemL6C?=
 =?us-ascii?Q?GXuaBrQlKLSVlRUndaKaHP9vz2md0VMRqfSF6bC6aS3m0CvGdwp23zzCo6ly?=
 =?us-ascii?Q?ZTL0l79Zb1Unkfnmc/WHAbwIydrcLOAHYyoHPMQze5clNE6cBkpcX194nwvg?=
 =?us-ascii?Q?ot9S8lgCpRrge8BQ++h1XwW1WiJhLUH/eEv30uTcNA0IoR/HPlMYCxkj6Lsm?=
 =?us-ascii?Q?+O8zBV5bTvSsUdI/4xmvnIa2xnDGihCiLLZ1pvTx9x+V+eHE9qJEFXuVwn/9?=
 =?us-ascii?Q?wqKXI5Xz2cA+LznVAYdPYdVg+gGaDcQNrXaGWmWlMWhJWrvSk5uafMO4Buy+?=
 =?us-ascii?Q?XBOqi/p/Fx9lA8s+6S9HHX13/Jn4TIdg7qQc0EylE2VF5f50Pks0FhkQ1uej?=
 =?us-ascii?Q?x015V3V7UzINjYYgYIzj6/84NB6y5GQnG1SFwHgDsgT4h4dhqO//2RFDuD49?=
 =?us-ascii?Q?ZYC+dPOZ2s3ysRiprI0H19Vcqhs2YT/Lq/iFDNUT5UoVdmSH1f4NlI8BQ0Wm?=
 =?us-ascii?Q?b9YbBA+1Z7WOKOUMysKjyX/fNsrBRvHcI2H8QCmGd4hSnbqUwn4Dr9g6lGVI?=
 =?us-ascii?Q?pgTleGBFTrzc9NtTpv9OLGvKfZPzkjNYAO7+N0TmM/4+m3VEitZSQkSNo195?=
 =?us-ascii?Q?vbjOiQseaGs2Dvk9kZ5LWG+lLLgo+DrNmZvGhvr7lyY8RwuN0uaT/d6qD7L5?=
 =?us-ascii?Q?K5Ykj3Lh4/pAf3R96MJ/DiCG8nmBEd+E8tDHB9DyfsnqGSCf3VakzlHSm21K?=
 =?us-ascii?Q?IK1iOehxbNvw9eLF4rRSo1vrgfloqoOzEB9Z5QszeiNBRThWoNxGfpR9afQd?=
 =?us-ascii?Q?42kUcOWUXDDv9i6MR7IEPKaGHA5w+yzmj9wXKNQOV2DtP+Xc4l1xA5VkhXX2?=
 =?us-ascii?Q?mKAhTx1Rh1M7O5OCyRnFnTiV2cxoj5zjC3INuKH33/Y8AdPBYgLkavF/6fEg?=
 =?us-ascii?Q?wI0zxH3xLWi+yRP6Mm19axcPnT8ADtHAsV24xOpLGUae5RWnVk57DvFzmqpG?=
 =?us-ascii?Q?lSgdwZjkjkggc3fmDJ1iiPcXLOtkFOUvGUcKzgkmpL0ejIR0o4gYZkAY1JgC?=
 =?us-ascii?Q?UDGJ5vAcT/mThM/rgBOLbZ26XnUc4ZTDJOuIhgKiuCTaiVNm2HTTFOfAGnjp?=
 =?us-ascii?Q?oTH22dvVbvAs8JQtYzyCFAieHTdWmb0zQigMY/5HGD5FJM74/AQ66JjQ8J+g?=
 =?us-ascii?Q?w4ei8q1FohPljuyJsr6T7Z7KSrMX24/yN/BJMShADfGXe3TQAlM3cNZST44a?=
 =?us-ascii?Q?tu9DhXUCen1PumaVpfXnZxHnITHg6it/H96x3MyxXteFpdfHhbrXFHnlWQyU?=
 =?us-ascii?Q?/sUj3LHT0Ccz58sy2Xboi9EztvK4q18wbDPg6hNHiuxbsgGFcNAa3jQZ9FQE?=
 =?us-ascii?Q?S7D6S7c/DI2VUvGs9Cyuo69Gx0nCpOtlsCTBYJiFIPGIAi92gIZ79YuiKsH7?=
 =?us-ascii?Q?k/wzvPEiu4rufbOuwuEmKT6D41CQqouiMVzr4MRxZKkYW+ZIQZCNr/0jOIfh?=
 =?us-ascii?Q?M8efr+Kwmig8LA+eIsQddK2cMzeQvxRbmIZXh4JAPunVQC8Thh5XhsHgDDIB?=
 =?us-ascii?Q?aIw9d2QGz3u/gwA9U9Hm/99xJ8ZEkOYXVFQrYlJeRCEFb3ENVontVgDzTeVQ?=
 =?us-ascii?Q?qP5kL90LOPdvHgPznxqeCrQfaM/lokeUi42obf5zl/d3A7D9sPCJsTAEPBnK?=
 =?us-ascii?Q?zW+gSuzqg7+VgwfjRG8LkTF7KKCcpFM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1588099a-ac08-43bd-f602-08def1068702
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 02:25:47.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwcBxwAx0uvIuyEdGCHj1A3QjvUWlqac2r0gZszLizOAeQr50xUS50LyTSXc/QBhlfb/J1vu2YAGLoEGf3kh4k073dLAWivkb+6Cxj1dbtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6426
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jul 29, 2026 at 10:21:35AM +0800, Anirudh Srinivasan wrote:
> Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
> (RCPU, HSIO, PCIe and MM). This commit adds these 4 PRCM blocks to the
> tt-atlantis model, along with necessary device tree nodes for them.
> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  docs/system/riscv/tt_atlantis.rst |  1 +
>  hw/riscv/tt_atlantis.c            | 92 +++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/tt_atlantis.h    | 19 ++++++++
>  3 files changed, 112 insertions(+)
> 
> diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
> index 1f2880d617..539c22354f 100644
> --- a/docs/system/riscv/tt_atlantis.rst
> +++ b/docs/system/riscv/tt_atlantis.rst
> @@ -14,6 +14,7 @@ tt-atlantis QEMU model features
>  * 8-core Ascalon-X CPU Cluster
>  * RISC-V compliant Advanced Interrupt Architecture
>  * 16550A compatible UART
> +* 4 PRCMs (Clock and Reset Controllers)
>  
>  Known limitations
>  -----------------
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index d808bcc11c..17cc5318b3 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -26,6 +26,7 @@
>  #include "hw/char/serial-mm.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/misc/unimp.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
>  
>  #include "system/system.h"
>  #include "system/device_tree.h"
> @@ -59,6 +60,10 @@ static const MemMapEntry tt_atlantis_memmap[] = {
>      [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
>      [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
>      [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
> +    [TT_ATL_PRCM_RCPU] =        { 0xd0000000,       0x10000 },
> +    [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
> +    [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
> +    [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
>      [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
>      [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
>  };
> @@ -328,11 +333,38 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
>      qemu_fdt_setprop_cell(fdt, name, "reg", addr);
>  }
>  
> +static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
> +                             const char *prcm_name, uint32_t prcm_phandle)
> +{
> +    hwaddr base = mem->base;
> +    hwaddr size = mem->size;
> +    char *name = g_strdup_printf("/soc/prcm_%s@%" PRIx64,
> +                                 prcm_name, mem->base);
> +    g_autofree char *compatible =
> +        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", prcm_phandle);
> +
> +    return name;
> +}
> +
>  static void finalize_fdt(TTAtlantisState *s)
>  {
>      uint32_t aplic_s_phandle = next_phandle();
>      uint32_t imsic_s_phandle = next_phandle();
>      uint32_t periph_clk_phandle = next_phandle();
> +    uint32_t osc_24m_phandle = next_phandle();
> +    uint32_t prcm_rcpu_phandle = next_phandle();
> +    uint32_t prcm_hsio_phandle = next_phandle();
> +    uint32_t prcm_pcie_phandle = next_phandle();
> +    uint32_t prcm_mm_phandle = next_phandle();
>      void *fdt = MACHINE(s)->fdt;
>  
>      create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> @@ -348,6 +380,33 @@ static void finalize_fdt(TTAtlantisState *s)
>                      aplic_s_phandle);
>  
>      create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
> +    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
> +
> +    g_autofree char *rcpu_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu", prcm_rcpu_phandle);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
> +
> +    g_autofree char *hsio_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_HSIO], "hsio", prcm_hsio_phandle);
> +    qemu_fdt_setprop_cells(fdt, hsio_name, "clocks", osc_24m_phandle,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_HSIO_PLL);
> +
> +    g_autofree char *pcie_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_PCIE], "pcie", prcm_pcie_phandle);
> +    qemu_fdt_setprop_cells(fdt, pcie_name, "clocks", osc_24m_phandle,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_PCIE_PLL);
> +
> +    g_autofree char *mm_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_MM], "mm", prcm_mm_phandle);
> +    qemu_fdt_setprop_cells(fdt, mm_name, "clocks", osc_24m_phandle,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
>  
>      for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
>          create_fdt_i2c(fdt,
> @@ -545,6 +604,39 @@ static void tt_atlantis_machine_init(MachineState *machine)
>      serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
>                     qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
>                     115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    /* Add rcpu prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-rcpu", &s->prcm[0],
> +                            TYPE_TT_ATLANTIS_PRCM_RCPU);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[0]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_RCPU].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[0]), 0));
> +
> +    /* Add hsio prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-hsio", &s->prcm[1],
> +                            TYPE_TT_ATLANTIS_PRCM_HSIO);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[1]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_HSIO].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[1]), 0));
> +
> +    /* Add pcie prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-pcie", &s->prcm[2],
> +                            TYPE_TT_ATLANTIS_PRCM_PCIE);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[2]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_PCIE].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[2]), 0));
> +
> +    /* Add mm prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-mm", &s->prcm[3],
> +                            TYPE_TT_ATLANTIS_PRCM_MM);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[3]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_MM].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[3]), 0));
> +
>      /*
>       * Atlantis contains a DesignWare uart while the QEMU machine
>       * uses the serial_mm model with the base ns16550 register set.
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 7f7d4a5a59..20bcdfeb52 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -13,12 +13,14 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/i2c/designware_i2c.h"
>  #include "hw/intc/riscv_imsic.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
>  #include "hw/riscv/riscv_hart.h"
>  
>  #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
>  OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
>  
>  #define TT_ATL_NUM_I2C 5
> +#define TT_ATL_NUM_PRCM 4
>  
>  struct TTAtlantisState {
>      /*< private >*/
> @@ -31,6 +33,7 @@ struct TTAtlantisState {
>      RISCVHartArrayState soc;
>      DeviceState *irqchip;
>      DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> +    TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
>  
>      int fdt_size;
>  };
> @@ -59,6 +62,22 @@ enum {
>      TT_ATL_SAPLIC,
>      TT_ATL_SIMSIC,
>      TT_ATL_UART1,
> +    TT_ATL_PRCM_RCPU,
> +    TT_ATL_PRCM_HSIO,
> +    TT_ATL_PRCM_PCIE,
> +    TT_ATL_PRCM_MM,
> +};
> +
> +/* RCPU PRCM Clock IDs */
> +enum {
> +    TT_ATL_CLK_RCPU_PLL = 0,
> +    TT_ATL_CLK_RCPU_ROOT = 1,
> +    TT_ATL_CLK_NOC_PLL = 25,
> +    TT_ATL_CLK_NOCC_CLK = 26,
> +    TT_ATL_CLK_HSIO_PLL = 54,
> +    TT_ATL_CLK_PCIE_PLL = 55,
> +    TT_ATL_CLK_MM_PLL0 = 56,
> +    TT_ATL_CLK_MM_PLL1 = 57,
>  };
>  
>  #endif
> 
> -- 
> 2.43.0
> 

