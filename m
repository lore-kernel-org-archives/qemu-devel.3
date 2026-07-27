Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05017C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDvP-0006iW-0T; Mon, 27 Jul 2026 01:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDvN-0006iJ-P7; Mon, 27 Jul 2026 01:30:49 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDvL-0002fX-LT; Mon, 27 Jul 2026 01:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVThuB4TpJKqO5gRpl71/CZYn+TyPkhoNCRhrl31jkjsZl8Uppj8vFGQflOv1S7PYzzCF/V+K4gG77tVdSOMgrLJEQe1Syms2e2PDCNjVdmg2S+HCE1PxRIDyM/mEL9NDXueogtzDjWqWs9RB9y2+L5YPTmvgM7ozAOP7NbAq7idfmUpbmonaN+YSN6Mb9Kh4Yx4/dBHQtP4QeQlUtzHyM/Sd2sHvoHx2BNUvKZf06bVfNqLdQ2c5TIbZlCzIpzSwA9kpRxBnFRZ+KAxfT01glxiziVHuYw+07BOUxxYCwY1ON9nWO1CCosnwXz+rLs4JDpte0zWn71HJdjgZx6rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVmePHQDta1sp04SErUL4TL5J7lsmAlljafOeb6C02w=;
 b=Nbahcd39P8zbUtmSMksQAnzfE62gCP2XkGMp9YaqclrD2+Symx+PgPkUW0A3LJRMl3g9KuHz8xVzDxzKaUkQeE2xFtmnRcviw7WCahGzdZApN/3YpBKInGcDEsy+LdqQjTJ546fn+67dt9hwrcdKZcDTjk6mqNBM2KYcE1woc75SNbuQoLhaOMmd4rAngBcC4u3TRUgCoUnxNs3gqOBfEnpGOCZEiicpnDfopRok+pO0v9cfZLJKBZqy6OZTHpPznScIAMS2RLpt/VPajxXBLDfWiBLNB0kb1sc4RpyGBzXgZbzn3p3SHwzkrKqV2pd7qqtLeVH+qrmcT7GU9QMyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVmePHQDta1sp04SErUL4TL5J7lsmAlljafOeb6C02w=;
 b=tyJG+E4iK0EHkLgk1+UDaxqqEV3DmOirXyBCpssqUfvFr8PdxmE6YnJVoUDDHsEmbwDA3XrCkY6VfujH8VIO0qk3m+0Uk1fiEXbmwgGWFnWvMVyAbHBNZdMCOjCmipIwqUVlZ/inAtfaYDToyct6WE88Re9hJnuYVFjTEukI6FGw8xFvTmAAhVuifsL97PTiJDgtYl8zCeQpH8VoULAZegWrzml1UhW78uuP2tyteBUhR5nD7UbgiZPhiyvXq+5pdpXTv63Uc6SCbeEEwlp/ltJHwlnrFGQR+iFMeI1MufOUuirJep9xp6IoJAz3HjclPXds5GhOCKOu/Rsx+2vEpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB6022.apcprd02.prod.outlook.com (2603:1096:4:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:30:40 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:30:39 +0000
Date: Mon, 27 Jul 2026 13:30:34 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 05/26] hw/riscv: pfsoc: Couple L2CC to L2-LIM
Message-ID: <ambs8ysJgsOR7DjM@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-6-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-6-bin.meng@processmission.com>
X-ClientProxiedBy: SJ2P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::10) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9b4bc9-6ca3-4499-76c4-08deeba03151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|7416014|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: 1gb1ZWNXS56AwwR3XeKwx/BGtsjjrFJ5EphvO/BebkrDwfuSI/jGDbQGLeumoo3FyKdE96NhR47jL/nJ4HBEL49IIiUDXB8a6LD6AeWHfwDgdjqwWU6UONY2JD7x3Vz4fqTFeGedJZ2h9LxmL132k4fGbWLzN60SkQsEQlzkqymdQqXgEEaT9IyJf8H6pjvz4FfPNpd+9cox4UoTY6tL4vLoc9q4mHPk/tiQpInW3agGnXPjjPh3TiSysaIM4+QMWDJP2cWLIY3wDoMiapHkWExlgFgIEpw4qc3kqebP6/w0nyqoB2moxGnAIAcLB51mC6v3KmVQpZvjBdXAmWIhyORivF6XkJ0x/yM7IhkHqHhX3f4O4+ju7EkZyHI9lm1W0BgmdeOYLLV7Meq21pJ3uMprrjvxnYuistwkm2a7SDmjyz5OTj5P8y27H9wPUDlSPPplaZ/CAJ0tIo4o44WJmbLtOcRksfVDx3S7/8HLoIGQqgtmWinXGXJV0NypsgJsx7G8w9EIHwvV69B1fJJVi4KCnR7wqDSgqnxRBIiD4wMPofSyCxM7JdReirDblBpNcWnKUSlaxME6JG3qO3bAJuPb6Wn3hsC5U+uZ+rfAQkykEMfXUYDvFc8MyV/JUOqKNDQlvyan9DkqshNGhWk9CRsbwTDvkJVn/l89f+nz1WY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nB6wEFGcf1oOZpKvkxk2+X8B/ZY+WmrjELaBZDSgRx8sKvn21gQLKbellXr+?=
 =?us-ascii?Q?/EJwgyiG4fTEd0+YGI+viFTSM5aS91uNdO1X7S9XQ9MjMUTtdiKuAuocc5IK?=
 =?us-ascii?Q?lQCsem53hQrVbM4MzmqSTaSvE325/FF33MUKka5IEpKpP2sLHeEpzFOkzZgS?=
 =?us-ascii?Q?7LKG0yFgfr7klM1M8b5dWEM48lHI2Y5i/Ar1SIBcfa2Bzz9mQQww3T7pRMUN?=
 =?us-ascii?Q?n4kn3tLwMTmVKeg+UrB9LxU19ILDtwNOYPt77wAiewoW1OOfzmuh5OzHo++G?=
 =?us-ascii?Q?Q9ryyALBwM8kLIR/bUvPjic1+QXzeu07BaSjw7SaQej7vmQpmSg8Wd0BwBLU?=
 =?us-ascii?Q?RlCr2bvv6sd9YOQH0faseQreZdDYHNaGPSY9L1UxkS/0mjATllRe7ICYJDZY?=
 =?us-ascii?Q?jxGTa8mRfvaI8qR4Wg2DkiHFDXZsb8/A8VybBIMXyxXpevyhHFHN8bsdkfkx?=
 =?us-ascii?Q?0xsUEIO7ISb/MS9M+ggw8BzsUv5nj34UV2bcT/bqW77k7X7zkKMH938hS+Ol?=
 =?us-ascii?Q?bNBUznpUP/znZibBHr/kXa80KRqvCF7Jv5uJ4efgKrGlFGa60T7ELSV1it7Z?=
 =?us-ascii?Q?7F2ERCS0cNmgxubSd9kkVk1PaUMBJ1LMDoT5+r8iggFuvSU8rPu5mEzT43iO?=
 =?us-ascii?Q?kLFvMQ+5Egh7PyjCIC4l3ermIjGNlIcjkJsnNKW3BWwUtey5ZAEO3sfxepYp?=
 =?us-ascii?Q?Av682kW/G7Y/QySHHMtMxjoLKkOq86lutDAmGD7PxTN0sspSu+DZfPG8LjGc?=
 =?us-ascii?Q?Sxke4hZOUFHuFZRsLHGaFV6+vTk1Aq+8delXMW09zxPgqMOe/J1fpzVlmIkw?=
 =?us-ascii?Q?gng/KwID0sSdUyd9qTtE+02enTBktK9wm6zPzvRtgd7gJnMD40TV79TlUg6j?=
 =?us-ascii?Q?n94IZ4qp/3RdpAKz26uRbgIWl/WQWPG2IJzustfflK8rFzTJ+x3Mttr+KURB?=
 =?us-ascii?Q?DJzKMQB+8eM4RWMBHLANG/+Y78MHeUPZGpLKs+qn3Y8jjPL78YD7GZiaC+zB?=
 =?us-ascii?Q?nl1/ytu1MIfDIMgavaY7WG1k2qmzE+6axhORLSIkY4pPZvOCGZ0+Y1PglPgQ?=
 =?us-ascii?Q?DmH6AGNUAP6F+ZuWRipUgXNQW6AAiO00K8f4QMTzdmyR5y1Cp52UXyqCpdee?=
 =?us-ascii?Q?gC0S4j7uWCYCgkuKLgjjNNLhHO0QRIpKz3CpetvTnNIUNiRWb3d/EIMQOxjS?=
 =?us-ascii?Q?vvSfAwEu5Le1o+wcm1Pb7pJHogHS4yHB6ZF6r7gX4wUThntTnHdqtABmQ9Qg?=
 =?us-ascii?Q?VAxasmqarkN27bUynchOlx3mF5HvQ5o04fHVa7sSUoxKSUnImjljBgaxjkGF?=
 =?us-ascii?Q?iab198dixY9OpfAYTvOa0dA1+qzX5/bSUvaM+AG6tbPim5BeGUFXi1zeGCEg?=
 =?us-ascii?Q?gzY40UlcQ5ajhUeA+UvxvIRkLAKtem0L/k/wLH1x19HebcKs+i+16h0rgHsu?=
 =?us-ascii?Q?RQ792N7xtaGG2gr36a6oad/IZPVy4KOf/3lHu9LWf9svhN4NnV1UANdr+ed9?=
 =?us-ascii?Q?Hof9zJC7oelwYcU4tiuQ4mutOLy5KO5htcI1p4pm5BdGTL6yjneVjK6rT66c?=
 =?us-ascii?Q?qtos/zNBX8MpmI4GvdMJg5nuljm/1Qo1o/R11xJhWlFdbTbpeQs6606Qraz9?=
 =?us-ascii?Q?+lSDNuTcPZzjlZu3TJw63rvmj1DO2XK6huTOdnad5EUZTicqYgkF46ze5dIT?=
 =?us-ascii?Q?sTpfS5kpQ6NEBr77/pNDchLyJk0+WMbap1ddQKRfZQjevWLFgM1NQC1OgFEL?=
 =?us-ascii?Q?P+URmqbzEEDOUBHekodKn/4h2ioLr3A=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9b4bc9-6ca3-4499-76c4-08deeba03151
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:30:39.0889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs+u/wtAdMob3BrNsSFkLydm/O0q5p04N7+4YwHIoU4gcEgzq39lVFbLlPqFZwX5DWBc3OEKH15qC9rZn/tH+Y0KVi15LZS0anXs50wSPOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB6022
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, Jul 23, 2026 at 11:18:32PM +0800, Bin Meng wrote:
> Instantiate the L2CC in the PolarFire SoC machine and connect its
> WayEnable register to the L2-LIM MemoryRegion. Back the complete 2 MiB
> aperture and shrink it by 128 KiB for each cache way enabled.
> 
> Keep L2 Zero at its fixed aperture because it represents a cache
> allocation window rather than the remaining L2-LIM capacity.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  include/hw/misc/mchp_pfsoc_l2cc.h  |  1 +
>  include/hw/riscv/microchip_pfsoc.h |  2 ++
>  hw/misc/mchp_pfsoc_l2cc.c          | 50 ++++++++++++++++++++++++++++++
>  hw/riscv/microchip_pfsoc.c         | 23 +++++++-------
>  hw/riscv/Kconfig                   |  1 +
>  5 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/misc/mchp_pfsoc_l2cc.h b/include/hw/misc/mchp_pfsoc_l2cc.h
> index 1b5b3888d5..3a175a6340 100644
> --- a/include/hw/misc/mchp_pfsoc_l2cc.h
> +++ b/include/hw/misc/mchp_pfsoc_l2cc.h
> @@ -22,6 +22,7 @@ typedef struct MchpPfSoCL2ccState {
>      SysBusDevice parent;
>      uint64_t regs[MCHP_PFSOC_L2CC_REG_NUM];
>      RegisterInfo regs_info[MCHP_PFSOC_L2CC_REG_NUM];
> +    MemoryRegion *l2lim;
>  } MchpPfSoCL2ccState;
>  
>  #define TYPE_MCHP_PFSOC_L2CC "mchp.pfsoc.l2cc"
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 612fd2b69c..0aeccedf77 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -27,6 +27,7 @@
>  #include "hw/cpu/cluster.h"
>  #include "hw/dma/sifive_pdma.h"
>  #include "hw/misc/mchp_pfsoc_dmc.h"
> +#include "hw/misc/mchp_pfsoc_l2cc.h"
>  #include "hw/misc/mchp_pfsoc_ioscb.h"
>  #include "hw/misc/mchp_pfsoc_sysreg.h"
>  #include "hw/net/cadence_gem.h"
> @@ -43,6 +44,7 @@ typedef struct MicrochipPFSoCState {
>      RISCVHartArrayState e_cpus;
>      RISCVHartArrayState u_cpus;
>      DeviceState *plic;
> +    MchpPfSoCL2ccState l2cc;
>      MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
>      MchpPfSoCDdrCfgState ddr_cfg;
>      MchpPfSoCIoscbState ioscb;
> diff --git a/hw/misc/mchp_pfsoc_l2cc.c b/hw/misc/mchp_pfsoc_l2cc.c
> index b320356572..7f3c2672c3 100644
> --- a/hw/misc/mchp_pfsoc_l2cc.c
> +++ b/hw/misc/mchp_pfsoc_l2cc.c
> @@ -11,6 +11,9 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
>  #include "hw/core/register.h"
>  #include "hw/core/registerfields.h"
>  #include "hw/misc/mchp_pfsoc_l2cc.h"
> @@ -39,6 +42,25 @@ REG64(L2_WAY_MASK_HART4_DCACHE, 0x868)
>  REG64(L2_WAY_MASK_HART4_ICACHE, 0x870)
>  
>  #define L2_CONFIG_RESET         0x06091004
> +#define L2_LIM_WAY_COUNT        15
> +#define L2_WAY_SIZE             (128 * KiB)
> +
> +static void mchp_pfsoc_l2cc_update_l2lim(MchpPfSoCL2ccState *s,
> +                                         uint64_t way_enable)
> +{
> +    uint64_t l2lim_size;
> +
> +    if (way_enable >= L2_LIM_WAY_COUNT) {
> +        l2lim_size = 0;
> +    } else {
> +        l2lim_size = (L2_LIM_WAY_COUNT - way_enable) * L2_WAY_SIZE;
> +    }
> +
> +    memory_region_transaction_begin();
> +    memory_region_set_size(s->l2lim, l2lim_size);
> +    memory_region_set_enabled(s->l2lim, l2lim_size != 0);
> +    memory_region_transaction_commit();
> +}
>  
>  static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo *reg,
>                                                       uint64_t value)
> @@ -48,6 +70,14 @@ static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo *reg,
>      return MAX(current, value);
>  }
>  
> +static void mchp_pfsoc_l2cc_way_enable_post_write(RegisterInfo *reg,
> +                                                  uint64_t value)
> +{
> +    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(reg->opaque);
> +
> +    mchp_pfsoc_l2cc_update_l2lim(s, value);
> +}
> +
>  #define WAY_MASK_REGISTER(_name)                \
>      {                                           \
>          .name = "WAY_MASK_" #_name,             \
> @@ -66,6 +96,7 @@ static const RegisterAccessInfo mchp_pfsoc_l2cc_regs_info[] = {
>          .addr = A_L2_WAY_ENABLE,
>          .rsvd = ~R_L2_WAY_ENABLE_VALUE_MASK,
>          .pre_write = mchp_pfsoc_l2cc_way_enable_pre_write,
> +        .post_write = mchp_pfsoc_l2cc_way_enable_post_write,
>      },
>      WAY_MASK_REGISTER(DMA),
>      WAY_MASK_REGISTER(AXI4_PORT_0),
> @@ -157,11 +188,30 @@ static void mchp_pfsoc_l2cc_init(Object *obj)
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
>  }
>  
> +static void mchp_pfsoc_l2cc_realize(DeviceState *dev, Error **errp)
> +{
> +    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(dev);
> +
> +    if (!s->l2lim) {
> +        error_setg(errp, TYPE_MCHP_PFSOC_L2CC ": 'l2-lim' link not set");
> +        return;
> +    }
> +
> +    mchp_pfsoc_l2cc_update_l2lim(s, s->regs[R_L2_WAY_ENABLE]);
> +}
> +
> +static const Property mchp_pfsoc_l2cc_properties[] = {
> +    DEFINE_PROP_LINK("l2-lim", MchpPfSoCL2ccState, l2lim,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +};
> +
>  static void mchp_pfsoc_l2cc_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      device_class_set_legacy_reset(dc, mchp_pfsoc_l2cc_reset);
> +    device_class_set_props(dc, mchp_pfsoc_l2cc_properties);
> +    dc->realize = mchp_pfsoc_l2cc_realize;
>  }
>  
>  static const TypeInfo mchp_pfsoc_l2cc_info = {
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index fd28ee75fe..248de4d022 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -175,6 +175,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>      object_initialize_child(obj, "dma-controller", &s->dma,
>                              TYPE_SIFIVE_PDMA);
>  
> +    object_initialize_child(obj, "l2-cache-controller", &s->l2cc,
> +                            TYPE_MCHP_PFSOC_L2CC);
> +
>      object_initialize_child(obj, "sysreg", &s->sysreg,
>                              TYPE_MCHP_PFSOC_SYSREG);
>  
> @@ -260,18 +263,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>          iks->clint_timebase_freq, false);
>  
> -    /* L2 cache controller */
> -    create_unimplemented_device("microchip.pfsoc.l2cc",
> -        memmap[MICROCHIP_PFSOC_L2CC].base, memmap[MICROCHIP_PFSOC_L2CC].size);
> -
>      /*
> -     * Add L2-LIM at reset size.
> -     * This should be reduced in size as the L2 Cache Controller WayEnable
> -     * register is incremented. Unfortunately I don't see a nice (or any) way
> -     * to handle reducing or blocking out the L2 LIM while still allowing it
> -     * be re returned to all enabled after a reset. For the time being, just
> -     * leave it enabled all the time. This won't break anything, but will be
> -     * too generous to misbehaving guests.
> +     * Back the complete L2-LIM aperture. The L2 cache controller resizes
> +     * this MemoryRegion to 128 KiB for every way assigned to L2-LIM.
>       */
>      memory_region_init_ram(l2lim_mem, NULL, "microchip.pfsoc.l2lim",
>                             memmap[MICROCHIP_PFSOC_L2LIM].size, &error_fatal);
> @@ -279,6 +273,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>                                  memmap[MICROCHIP_PFSOC_L2LIM].base,
>                                  l2lim_mem);
>  
> +    /* L2 cache controller */
> +    object_property_set_link(OBJECT(&s->l2cc), "l2-lim",
> +                             OBJECT(l2lim_mem), &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->l2cc), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), 0,
> +                    memmap[MICROCHIP_PFSOC_L2CC].base);
> +
>      /*
>       * HSS decompresses into the L2 zero-device window and executes there.
>       * Model it as RAM because QEMU does not model the backing L2 cache.
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..22619481e4 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -18,6 +18,7 @@ config MICROCHIP_PFSOC
>      select DEVICE_TREE
>      select MCHP_PFSOC_DMC
>      select MCHP_PFSOC_IOSCB
> +    select MCHP_PFSOC_L2CC
>      select MCHP_PFSOC_MMUART
>      select MCHP_PFSOC_SYSREG
>      select RISCV_ACLINT
> -- 
> 2.34.1
> 

