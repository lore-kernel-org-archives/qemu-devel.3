Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B63CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 17:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux7UV-0005pC-03; Fri, 12 Sep 2025 13:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7UT-0005od-BT; Fri, 12 Sep 2025 13:23:17 -0400
Received: from mail-dm6nam11on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2415::60b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1ux7UO-0004uy-IT; Fri, 12 Sep 2025 13:23:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o89dCALxrJUYACgQp53cgtPj39KNqECEhPIvgHpSUye9N5LQhesxEZ92XIp+lKC5jiHhajNZzUp8eVzjCfA6ESjOZ/vSCUiWbL8/FMl5Pe/Y7jroLnF0Q66+QxRmwBX/nwtO8uMQ2HltDRFwuFYQ4Iw1YfMgwF7+QKCKJk6aRCDdJw4trp06oY93hSBRA7QSIg3FDdQ7Dd5e2G9qBRQc8ZGsq9GHhFCQ5VBAt1HQw0sT2P1SwfjBI57hlORVxb08uq8d/v9XcD7+sLA2m2cqSC6mHtN3n3DOsNUcP4oVwish3XbFMUz0JNkMuRgO98kMMkNeG6yE0Q28kK11j/Q+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VORKg/I3oDa5DV7+pQxoOaN1eryXDbaHkUfwn2PJZrs=;
 b=a+9IaPsKxUiJfn2Xmv3S7gEgG/75fmQ7mN4TtlVxDPCrUxdafDOP4yQ7xapSpoQzTGESOxZAsBkR3blhJ0ks7C0xKK0bvZnA3nFt9400X2esj6Bjn/Nfpw29bNZHeTJc+GDHk/W6plst/i2jnZrLek46c4rdZoRpkD62DPOS08pMxEVGkl4tD0epyamSE309fl1PivGma3v/c1i+MPbTPV2tXCRWW0j7iyg7yClHJzEUnigy2h4wuDb/khzlgFWV1xqdoWR+abGmLhRJbdqGuwJTjiSEjfuO0NFUcyIF96ByOseUojVL4zDu+ikfUTpVOmh7G89tWzg5wAR3St6RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VORKg/I3oDa5DV7+pQxoOaN1eryXDbaHkUfwn2PJZrs=;
 b=vA+pXaOGzg4VWCoKDisOnR9uIB/XW+FpeXPAQ4CDkyAckq2BGdXccUGWzQaPVWC9TixJCsFH4lfjPk1xX1C28AeIIFBPCHGATRzT4xO6JQbRtXAaZIe57MgOqArfenC1OE1MJ315SmjSRXTUs9GBXU3lefqUBvi5q56PDMTEGXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 17:23:01 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 17:23:00 +0000
Date: Fri, 12 Sep 2025 19:22:58 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 03/47] hw/arm/xlnx-versal: uart: refactor creation
Message-ID: <aMRW8kORytDzLfRx@zapote>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-4-luc.michel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912100059.103997-4-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BN9PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:408:f7::35) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fe6fd7-bc86-47f9-02f0-08ddf2210602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NF7+DKXxmrnLpl2dPagkUIz65sozkSImN5fgf5g4Z06yuwNQrevxBPBLw7u6?=
 =?us-ascii?Q?/Yfn4F5nGvQNhmoxvXFfzpB2iD1CJo3xyUyzc00hnVTYmtQP264PY4wBoki2?=
 =?us-ascii?Q?/1T2KNiyTDtjbyD2SicZyiCa4GFQjiA7gOey3HwB097qLFxoEsqpycn53fEZ?=
 =?us-ascii?Q?6ARO4YjZlDUU5singOlA7llazVnnWnSgncSnzUERnJJtA1fjnzYnAEaIgfbU?=
 =?us-ascii?Q?hhOfBR4Lx23y+jmVhvo5YiNeGJLZusg17K4uawmUvNgB6XoCdPcxEUwjXBys?=
 =?us-ascii?Q?k26YUSCB7sBkSInUXisCEQCGSyY5Q9+v/JMTB5udf3+plmnyBZK+3OAnb3dU?=
 =?us-ascii?Q?KKn2BWU3ykngoIZoIjXeja39BL7YtiKQtfbMT8osnlz3GPHVY2bUK1DwVIq3?=
 =?us-ascii?Q?rAx845az+nqpAK78CHlF80likeynRJsUn4tHY3h2yUbriH9qdU+s0OnSgqbI?=
 =?us-ascii?Q?AxdkDeHL/RmKicRR+PVYoIjqwdmVwTYQCqkVs8BjtRZedg7QO9FyYPRQ6ilO?=
 =?us-ascii?Q?HZytwrtfBXkCzyPsNFqv1KrK34gQ4d01PM28e/5BWmgFn7dXdPmlGO92SkQ/?=
 =?us-ascii?Q?852yhEIvGfFJR9eIt4rLCH9R703yqKU4aNFYwMxJI0lzsKUNUCnKJHbUtkjr?=
 =?us-ascii?Q?Ofpl2rmGEz6vND4/VVri0RrPaXtoci/FGuPsJm5cgutxI8xP2UEF24HvEBKN?=
 =?us-ascii?Q?d5DKecIV2Mgl0fgmW9JWgnxGPGci0XOB8Hf3/bbZMjBsWy6G/Q5Uf/4+ZPSJ?=
 =?us-ascii?Q?N2ClUi1NrB5q1PqbXUxh7tHKxYzeIH7urBZET/3qh9GoNH5ZcpwbpxFbco7q?=
 =?us-ascii?Q?ffekV8Us5D8r2WUARDVn1R14XnNieiHomu1xbzxdDOnE1b8AxKpMtBcX+tYm?=
 =?us-ascii?Q?4pW0vHtv1a6QCeh+l/PIse9DJVoPpi0uGpgSM9gafjUsFygk4aLD18hJTaYF?=
 =?us-ascii?Q?T3ZUdKTBzNkvJC8IaX8/IM8pOHgFdfldZFKJ8yZvejCSp21YBcN833WdubAk?=
 =?us-ascii?Q?QCepQVfdTPrl2P3zl/ZuW0pki/cf03ME4j1vkte/f8cEZgm3smhdRk9V+M88?=
 =?us-ascii?Q?ObCYaYyt+DbZKSnfPaXUJhbSBnbh72Dg904s/NfYt8McMHRGT3Zyrrjk3Lop?=
 =?us-ascii?Q?f4MQJGcvrludlW84DnFTMVhuppfM+6i7ZYeqxu7TCsxXfbaagvNeNjcXxGCe?=
 =?us-ascii?Q?WNuPmZbeDEdPLxGGR3Pf5GAZDOiuVxiw1vMhJ4/3/E2DmFQqglGK80BB/725?=
 =?us-ascii?Q?sM4YHWTBto55G9DJOW1zrDTDq9zHyySOJBk3Y9C5ERvD+lxnM6R62MUX21Y5?=
 =?us-ascii?Q?DWEC0D2lrNNKH6rC9hgZ1+fOzQGKMhMTQLXKuYsHLUdF+N3XZCIPOAh4dfyx?=
 =?us-ascii?Q?J4JzuqLBoxS8JsSISm0/Qj+GdvhaM8TvpFhi0VfxgplJzJ40FxftggwyLl2d?=
 =?us-ascii?Q?0KzvgMSQrYg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ci2w58c4M33Srq7LSvts/9iDTWpZpaq2qPqZRfLVpe57ZoY8odIKf7sx+3u?=
 =?us-ascii?Q?KebmxOUJ8V/3l3ebfWwoJT9wLng5qNo17QNqgHZlwnBaK6M7ENKGV3kXSNFj?=
 =?us-ascii?Q?wmsjq7JtgUGIv1XdyDJFVMfR2dAcB9kvEgOp7TjqxkYOHFw+dswSvcioQ3Zp?=
 =?us-ascii?Q?C2uKq2DpiEPG+IhkNuMwZ9TWKphqn+JQSC1tJjZGuJOOhROib+bs9xQvUDVr?=
 =?us-ascii?Q?aW0glDsTFmACTu33m/HCBe02zqWXiv2JFEWH0yiyEQn86UaVGsI09g/I11Yt?=
 =?us-ascii?Q?4fpqYl4YlHEDn33uggGWuLRJ6YvWNtWldgAXpxIsVByXiBkOtQ6ENewKT8ZV?=
 =?us-ascii?Q?yp/LhW62SgFF9xQXWb7IGW9U+/F+CcPBoVDXN2Ni7Cr4TtdTFv3E7tzljw+y?=
 =?us-ascii?Q?0aPk/O+Wzl59rF8riUBcAQIDe9BAzqVO3tRnqDZqR0jdqKgLu2OW8Lggky4I?=
 =?us-ascii?Q?PWKcMDekQLNbGWRM2iM2Mg4wg2zUrQutyYO7aNZMfhThaeqFr/XliwADykSe?=
 =?us-ascii?Q?xdVtvCtORS0DdKWg37+tm2vwekuJpeWbP5PDv4LeVK2WBccG9lSVKwox+Mch?=
 =?us-ascii?Q?BV8LXW0WG8B/eK4VWmjYvYFLZL7cAULGwMmyzgWQyFs0fUX0giWeMMhtD9Qq?=
 =?us-ascii?Q?KDopSz2l5Y7AOAyT4J8W7uN2xH/gsjxcUmlOraHzNRN63NDXPig5pA1ETGDU?=
 =?us-ascii?Q?M4unl0N6JeALyfOpsGxN4MuLcXmgBmNWOgtHZ0cFePJFtSp61QF2wW1BYG6J?=
 =?us-ascii?Q?QUfh3GGjjKB6QBKBXBFSxUe60m1nZ0nT3lgc0AUDVH9LzJy7GuafhqKgaQmj?=
 =?us-ascii?Q?jrtu+uqrziuMBQFiGS6L2BZGExhXhUokL4lCHhk2Pspp4IiYk9YnT1fzafi9?=
 =?us-ascii?Q?7xculBFkQQ0DsO1Jf6h7MMPNm5HTSM1/stPJp0AwEqqgGu3cOMrbxrXimZUB?=
 =?us-ascii?Q?WW/Eido7uZBrpEZzVzHZzGM1yjZf8HKOJq0HBbIIDAPOPBh+QRiF9F3lXUqw?=
 =?us-ascii?Q?X3mpPSzmFvr3n//H6awe3uw/7dIo+U8WOVvjTRs3WYAe3stvkkFfR7PoEPSq?=
 =?us-ascii?Q?xJ++bNPANp/syZy/zujDa2bBG//9mIOHB/yIVkxt497Q0OjGRqcM1tN03JOe?=
 =?us-ascii?Q?Pw0jz4ATTjsioLC7N6QFnXxA/8khXrtLP3I+LI/l7kgKeoBr1YEtWRS7Snoy?=
 =?us-ascii?Q?VOoC6M7TKO/gKodE8gM9yQ96dCWORNVtdxFCapFVapJay+aI9ResHhsmLfFP?=
 =?us-ascii?Q?1r3i2U1ndF8RmekHa9LCOsFHEKOEg/ANaj46LSfKMlXrNI4ILMDv5Dz4C4Ng?=
 =?us-ascii?Q?osIXFw9vBWj1wMIr8gMtqFm/DLG9CpuMipjSybqe5Nq8grH1EkqkZvhnotnl?=
 =?us-ascii?Q?OGqYkdtC10fpIcz1O6W7e2w+jvDCFkfqj7wYFN1p8h2UPhv7YzwnzsLY2njW?=
 =?us-ascii?Q?UM/elhTHjaw0y+hivU0d4xnsl8yQAsD4vy+Pm439913HU1VdnGE5nxaDD7eG?=
 =?us-ascii?Q?SE7VXi9QfUlDRkQmdkOMiPj9grbBb99ddWD8hHA5H+8VbsV/6pLoC1e+33ZT?=
 =?us-ascii?Q?6vrLwH6seKVymH4kRqhM2Oq5YoNLlSmErTKd35/H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fe6fd7-bc86-47f9-02f0-08ddf2210602
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 17:23:00.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VMUb1bNLVkr3SQkjqjOLCevBdRsBLjljN6+tEtfPCKD7Mecc8BMtbOYfje4V/Gx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851
Received-SPF: permerror client-ip=2a01:111:f403:2415::60b;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 12, 2025 at 12:00:12PM +0200, Luc Michel wrote:
> Refactor the UARTs creations. The VersalMap struct is now used to
> describe the SoC and its peripherals. For now it contains the two UARTs
> mapping information. The creation function now embeds the FDT creation
> logic as well. The devices are now created dynamically using qdev_new
> and (qdev|sysbus)_realize_and_unref.
> 
> This will allow to rely entirely on the VersalMap structure to create
> the SoC and allow easy addition of new SoCs of the same family (like
> versal2 coming with next commits).
> 
> Note that the connection to the CRL is removed for now and will be
> re-added by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  include/hw/arm/xlnx-versal.h |   2 -
>  hw/arm/xlnx-versal-virt.c    |  36 +--------
>  hw/arm/xlnx-versal.c         | 144 ++++++++++++++++++++++++++++-------
>  3 files changed, 119 insertions(+), 63 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index f2a62b43552..b01ddeb1423 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -16,11 +16,10 @@
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/intc/arm_gicv3.h"
> -#include "hw/char/pl011.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
> @@ -78,11 +77,10 @@ struct Versal {
>  
>      struct {
>          MemoryRegion mr_ocm;
>  
>          struct {
> -            PL011State uart[XLNX_VERSAL_NR_UARTS];
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
>              CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index d1c65afa2ac..e1deae11317 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -75,10 +75,11 @@ static void fdt_create(VersalVirt *s)
>  
>      s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
> +    qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
>      qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
>      qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
> @@ -206,44 +207,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
>      qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
>      qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
>      g_free(name);
>  }
>  
> -static void fdt_add_uart_nodes(VersalVirt *s)
> -{
> -    uint64_t addrs[] = { MM_UART1, MM_UART0 };
> -    unsigned int irqs[] = { VERSAL_UART1_IRQ_0, VERSAL_UART0_IRQ_0 };
> -    const char compat[] = "arm,pl011\0arm,sbsa-uart";
> -    const char clocknames[] = "uartclk\0apb_pclk";
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
> -        char *name = g_strdup_printf("/uart@%" PRIx64, addrs[i]);
> -        qemu_fdt_add_subnode(s->fdt, name);
> -        qemu_fdt_setprop_cell(s->fdt, name, "current-speed", 115200);
> -        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
> -        qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                     2, addrs[i], 2, 0x1000);
> -        qemu_fdt_setprop(s->fdt, name, "compatible",
> -                         compat, sizeof(compat));
> -        qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
> -
> -        if (addrs[i] == MM_UART0) {
> -            /* Select UART0.  */
> -            qemu_fdt_setprop_string(s->fdt, "/chosen", "stdout-path", name);
> -        }
> -        g_free(name);
> -    }
> -}
> -
>  static void fdt_add_canfd_nodes(VersalVirt *s)
>  {
>      uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
>      uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
>      unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
> @@ -703,11 +670,10 @@ static void versal_virt_init(MachineState *machine)
>      versal_set_fdt(&s->soc, s->fdt);
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>      create_virtio_regions(s);
>  
>      fdt_add_gem_nodes(s);
> -    fdt_add_uart_nodes(s);
>      fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
>      fdt_add_usb_xhci_nodes(s);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index fda8fdf786a..87468cbc291 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -24,18 +24,96 @@
>  #include "qemu/log.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
>  #include "system/device_tree.h"
>  #include "hw/arm/fdt.h"
> +#include "hw/char/pl011.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
>  #define VERSAL_NUM_PMC_APB_IRQS 18
>  #define NUM_OSPI_IRQ_LINES 3
>  
> +typedef struct VersalSimplePeriphMap {
> +    uint64_t addr;
> +    int irq;
> +} VersalSimplePeriphMap;
> +
> +typedef struct VersalMap {
> +    VersalSimplePeriphMap uart[2];
> +    size_t num_uart;
> +} VersalMap;
> +
> +static const VersalMap VERSAL_MAP = {
> +    .uart[0] = { 0xff000000, 18 },
> +    .uart[1] = { 0xff010000, 19 },
> +    .num_uart = 2,
> +};
> +
> +static const VersalMap *VERSION_TO_MAP[] = {
> +    [VERSAL_VER_VERSAL] = &VERSAL_MAP,
> +};
> +
> +static inline VersalVersion versal_get_version(Versal *s)
> +{
> +    return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
> +}
> +
> +static inline const VersalMap *versal_get_map(Versal *s)
> +{
> +    return VERSION_TO_MAP[versal_get_version(s)];
> +}
> +
> +
> +static qemu_irq versal_get_irq(Versal *s, int irq_idx)
> +{
> +    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
> +}
> +
> +static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
> +                                      int sbd_idx, int irq_idx)
> +{
> +    qemu_irq irq = versal_get_irq(s, irq_idx);
> +
> +    if (irq == NULL) {
> +        return;
> +    }
> +
> +    sysbus_connect_irq(sbd, sbd_idx, irq);
> +}
> +
> +static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
> +                                           uint64_t at, const char *compat,
> +                                           size_t compat_sz)
> +{
> +    char *p;
> +
> +    p = g_strdup_printf("%s@%" PRIx64, path, at);
> +    qemu_fdt_add_subnode(s->cfg.fdt, p);
> +
> +    if (!strncmp(compat, "memory", compat_sz)) {
> +        qemu_fdt_setprop(s->cfg.fdt, p, "device_type", compat, compat_sz);
> +    } else {
> +        qemu_fdt_setprop(s->cfg.fdt, p, "compatible", compat, compat_sz);
> +    }
> +
> +    return p;
> +}
> +
> +static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
> +                                                  uint64_t addr, uint64_t len,
> +                                                  const char *compat,
> +                                                  size_t compat_sz)
> +{
> +    char *p = versal_fdt_add_subnode(s, path, addr, compat, compat_sz);
> +
> +    qemu_fdt_setprop_sized_cells(s->cfg.fdt, p, "reg", 2, addr, 2, len);
> +    return p;
> +}
> +
>  static void versal_create_apu_cpus(Versal *s)
>  {
>      int i;
>  
>      object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
> @@ -165,32 +243,48 @@ static void versal_create_rpu_cpus(Versal *s)
>      }
>  
>      qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
>  }
>  
> -static void versal_create_uarts(Versal *s, qemu_irq *pic)
> +static void versal_create_uart(Versal *s,
> +                               const VersalSimplePeriphMap *map,
> +                               int chardev_idx)
>  {
> -    int i;
> +    DeviceState *dev;
> +    MemoryRegion *mr;
> +    g_autofree char *node;
> +    g_autofree char *alias;
> +    const char compatible[] = "arm,pl011\0arm,sbsa-uart";
> +    const char clocknames[] = "uartclk\0apb_pclk";
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
> -        static const int irqs[] = { VERSAL_UART0_IRQ_0, VERSAL_UART1_IRQ_0};
> -        static const uint64_t addrs[] = { MM_UART0, MM_UART1 };
> -        char *name = g_strdup_printf("uart%d", i);
> -        DeviceState *dev;
> -        MemoryRegion *mr;
> +    dev = qdev_new(TYPE_PL011);
> +    object_property_add_child(OBJECT(s), "uart[*]", OBJECT(dev));
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(chardev_idx));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
> -        object_initialize_child(OBJECT(s), name, &s->lpd.iou.uart[i],
> -                                TYPE_PL011);
> -        dev = DEVICE(&s->lpd.iou.uart[i]);
> -        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> -        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
>  
> -        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
> +    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
>  
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
> -        g_free(name);
> +    node = versal_fdt_add_simple_subnode(s, "/uart", map->addr, 0x1000,
> +                                         compatible, sizeof(compatible));
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "current-speed", 115200);
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names", clocknames,
> +                     sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "u-boot,dm-pre-reloc", NULL, 0);
> +
> +    alias = g_strdup_printf("serial%d", chardev_idx);
> +    qemu_fdt_setprop_string(s->cfg.fdt, "/aliases", alias, node);
> +
> +    if (chardev_idx == 0) {
> +        qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
>      }

Hi Luc,

It looks like we're creating objects and then uncoditionally adding fdt
nodes to the device-tree. How does this work if the user passes a custom
dtb?




>  }
>  
>  static void versal_create_canfds(Versal *s, qemu_irq *pic)
>  {
> @@ -781,18 +875,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
>          object_property_set_link(OBJECT(&s->lpd.crl),
>                                   name, OBJECT(&s->lpd.iou.adma[i]),
>                                   &error_abort);
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
> -        g_autofree gchar *name = g_strdup_printf("uart[%d]", i);
> -
> -        object_property_set_link(OBJECT(&s->lpd.crl),
> -                                 name, OBJECT(&s->lpd.iou.uart[i]),
> -                                 &error_abort);
> -    }
> -
>      object_property_set_link(OBJECT(&s->lpd.crl),
>                               "usb", OBJECT(&s->lpd.iou.usb),
>                               &error_abort);
>  
>      sysbus_realize(sbd, &error_fatal);
> @@ -940,10 +1026,12 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>  
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> +    const VersalMap *map = versal_get_map(s);
> +    size_t i;
>  
>      if (s->cfg.fdt == NULL) {
>          int fdt_size;
>  
>          s->cfg.fdt = create_device_tree(&fdt_size);
> @@ -953,11 +1041,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
> -    versal_create_uarts(s, pic);
> +
> +    for (i = 0; i < map->num_uart; i++) {
> +        versal_create_uart(s, &map->uart[i], i);
> +    }
> +
>      versal_create_canfds(s, pic);
>      versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
> -- 
> 2.50.1
> 

