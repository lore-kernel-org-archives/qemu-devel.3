Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD6BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDwt-0007bl-KX; Mon, 27 Jul 2026 01:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDwq-0007bB-UA; Mon, 27 Jul 2026 01:32:20 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDwo-0002nU-Qr; Mon, 27 Jul 2026 01:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYC7tlCqmEsqMO3mndUjdcXX0sruWQjQ24/i/cJf3TmidOJ1VZAxkCHej1Ug+ANnch1AWBF+upMhi3wOTIrwMboxNaTC0WY+b7xuBtmZToT5Vkvn+heHIc3uLHxk3NCdFai9pxIuxv/iEzXjohP2GM++SnzsplFzSrC9OTtOoTHaC4BddwsWy5BW5LywONwLd3RqsB+6SAe1Amxb2SrZDxcrzg3h7jo8iNAX74q/Suk4Ftfj3Sb0xfH6jAhhmurh5lNh9hnjCuHwW297wzBvEbWLFCBVXuB5t4GqDs9Z+ufPV3FISedp7ag2JlxOD1cL/56ZOILCLvDrFzq1Y3hlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgQPfezqnHRW1T0aq0u1qPlstm900x0SEu+0DMC1/44=;
 b=XGK911BTEuqIK5CfLSGGu6aFWrPoXIcwLmCoz+yOaTGV9k6VnhyHT0lel6ZrBrsavy1y9Ar/aZElry0OhvOVjqb85erqBQDftfFraEUnT1rNWwGew29lq7XXYJLu1Oy4EVfU3CW7NL+X424IgLz9FyhQBConV6RQqpX3GYup1sBDHklSXRUrB2evoR2IJnUziFX30rAzWlAct9RnrDJxD9AezBC49Gw5tE0o1EAURZNRSn5Wze0wmjCKDSQiiDO55rHX5g7L3qI/7wW4onQn7NpWAa9JyQ0FGSQ2exeahhQLtxxoyJuHLpry7fQaFZFL1iXEHxBe0MIu2tCQax3UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgQPfezqnHRW1T0aq0u1qPlstm900x0SEu+0DMC1/44=;
 b=AWseaB37DpUNtRyKO9ZWTbbpiT9y5LYubtxj09l5jXIqZ4roYegX3gm9b7+YT0uQmN7DmqfaLlN7utlALtP89/v/NRaSZxJMM0yc4voNZHtlzk6gmZcZJYk94hmcBKTtieLAehgaMFJnFFtXeUmAFlBjmtrCHYewBppKq7Z46V9arkcWxnzhxaHRdSB/dA/lvLsqsV1EDdr9InDIskk/uMkAooP6YVnt/qd+54Sj4skOiaF9ItFweWdB4xowGowrjxzMUnqcBmxxf2m4mbWxU39Cpr3R0itsUX8hrGxU0TI+rEOOs4qFmIVZl4W0bjxkr0Br/3qvPQqDXJBJ4FbpSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5693.apcprd02.prod.outlook.com (2603:1096:400:1b0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:32:11 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:32:11 +0000
Date: Mon, 27 Jul 2026 13:32:05 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 19/26] hw/misc: pfsoc: Honor PolarFire service
 notification requests
Message-ID: <ambtS-BDWLw2g3Wt@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-20-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-20-bin.meng@processmission.com>
X-ClientProxiedBy: PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::8) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f2edba-d80c-4f00-7238-08deeba06828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|34096008|376014|5023799004|10067099003|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8ZKdfj2fxBDuO8AMBuCmPgJLNi4gYi6SDiKFGm5CNbTPpLr+DosiRvgumXJYoxjdULgivbkr36ajIgE4Wl+kzYy/BwF/r5iQ9/+d8ALRgPiJVVQtRYcPW8TkkC7/W8ArMvwmI/tW167Qpd//G9eM2sxHfiAjDzCTFAjO6/o+gRIA73Je/ry06c4DF8TDC/1RCvruG9E2O+VqN5qbVVXdV9dxvA9lVnL5oVmhId6RYC2zUlBpIhwfNnCOu+j7YBrFMTVElmjrIE2yzEiC0og0MiN1G7MxO/rBz4ZjFx79iNgc9Us1JKRsfKExFQ2GlRWHd76qxaSPOldwz7pvpns/F1WiaFcK6Z61s0HyFDI+EJFRciEYlPFm/csV5ROnvNCLNrQcug7nr9C3nlyByNfDm+EFwtq6umNh+wek97mMQifi62xo5EPApYY53JbIdXKiIsz3cfIzRJTeY+75oOoO3JGWpt12DR+Ps0+oWIiV7Go7XgQqppdJFjYJgfnm6CqwrHWJCgR5Tp081TB0FbN4v8L+e7lPV4WfWU/c1kPaOkLYuC1UVYQal2IhoBN5NGNZGh+Mz7MqS4HJHybGboIRxBZSwZ0LoVlZjDdWARunZsjcs1MTvb0YS5mZUkOH8QHcCSAQHVwvZL0N+dkrefAG+rU9NPybnISRs++ljazVAEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(34096008)(376014)(5023799004)(10067099003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbR1Fy8038lTeTfM6YNthVMtdXpCavxDst7x1LWF3qdbxlfd5fw62gThDPM4?=
 =?us-ascii?Q?zY65t44gv2CqmcUsGEY0/1Hy5gyJLyNlxzCy0UyOV17h3KrIRsERhiUVjqPy?=
 =?us-ascii?Q?gRt8hIBL5FXoeK3vO0DRAI9UV6mJFEZPjsHOBxH+E90yk50UF8cjtUUFu6M9?=
 =?us-ascii?Q?j+kyLnTsGpBxTWoyIBqllgN+T8LbxqwTcFdexHSfp86IhAkcm9WQH15JcFk5?=
 =?us-ascii?Q?R8Agu+HfXVGGGEubqmpx7B7EGSVySzamrbj0EMNplNNT6o0ZeePxmsTAL6mt?=
 =?us-ascii?Q?82DZpM5BV59OhKGMnkXKBmjESXqQJCfLVb1uAwjL4zO18CzKXAxo/efZXKoC?=
 =?us-ascii?Q?Y6ZeTsq/OMI9h1EL6+x8ngS1HcWshc4jmJesvhpLzAmS+3I1814f6Us5wreP?=
 =?us-ascii?Q?KIzE9B8OTxnvpHBs7HkGg9NkcuaQamno8xDIJ9Aq7wdlvLfLKYTOvS6Zq0tO?=
 =?us-ascii?Q?ZDD55eJWfYM7OyoFMuaIeTjR7JigZ1z8o5g9CQ4rVmoMcNkTdnW5pgtImnkf?=
 =?us-ascii?Q?oCE4FZcuXzfEp+grx6uMZNyfUHFTlLMihgWRHISpHsEHZ0D7E+NKJGZsOZY7?=
 =?us-ascii?Q?N65Lkkkg/c58FoApQ+SU2HqDjoAuSRzqOLqN4iDSEDBEM0vj4suED+VCODcy?=
 =?us-ascii?Q?Uil0hl6QeWfQmFletBqYI2ZG2kYRwDBFbQl7wGxvK0zDqolqpOaoSjmcvQsk?=
 =?us-ascii?Q?quJQI4Ipx+PEUtqOR1fnxeGunq1iyhkMoyHP/Wl7CmfCBjfVwHEA2bl6vPOS?=
 =?us-ascii?Q?F0ulbAK4yFG1F4B6yngfi7FPIJzdShjJItTIQww4+VGqZTatMTfJvX5K+r+m?=
 =?us-ascii?Q?wVgtRuHpC4pEQK0r6MoDO+CNKYJ5EJWA7HwXo7McaXxb3cPKba/8rCwGunr5?=
 =?us-ascii?Q?EHyN5WaRY96OpRrCk5bZQegPBGBWfPGQTHeqyfVTubb+PTsxLsvmoKdHxnea?=
 =?us-ascii?Q?bUJJFDExeYKwcd7atj6elP3KkXDBPJlKUrs5d0y6TAz+THJfyxdNI2r5xNTm?=
 =?us-ascii?Q?jjppJLtYmSWka1wSPmoMwG60B9ai+Od97AE4xmbSdn2fFdGCoVguqzq5zvlR?=
 =?us-ascii?Q?PzxtSbyJzOaJEiLiezvwUzlCyzbPew7q06WUaVI2OzmH1xOa9PH13RMioqjc?=
 =?us-ascii?Q?Y7gfMH7eLHT5G2cDG2tbo/nfmrbU/Emu9gfjYHFJmE3kDNbHzzggVEUx12Kc?=
 =?us-ascii?Q?Wh4bSTllZNDp6GzF32vjrDvG1ev2peAxp/WyqsORrLIfXXbJ05Wmt5YAfIpm?=
 =?us-ascii?Q?EqLWpZULSEb0bdRCnsTNZAvASnmEOYa7Pb3xP/fbL9YzMCRzCFHjlge1SBQJ?=
 =?us-ascii?Q?REtVCDjTwNx8cJ2PI2YhJ+gZn/mn3Lwo2wYgBJiDEKgHCep20OCGgKPD8yUh?=
 =?us-ascii?Q?Tyt6vn1kCEoC+UjvMBbnhJFk64ZwaJ+ikhz1OU1QYvAs36aqKT6ISyyWrP6j?=
 =?us-ascii?Q?dMnHKpotjW0vZ4RBOjcfhymwMifO6fIxMnBaO/9RPKFsmS2FFtrbXgQIWpV8?=
 =?us-ascii?Q?Rl50N7WyTsTYR/PMVkikj4N004GeFBc0H0jMFnugqOjEaBbUZkgs4BoYZ7yt?=
 =?us-ascii?Q?RZ2edLLpRJUjSafwNixRob8wxpno+GCpfIpgcCBHibA2SFCOYkkZXi4232T5?=
 =?us-ascii?Q?RPPMgY16gveE9REgCmelOX7qQCuM/EbWTDXbq4W9GPdKYx5+m7YXtdVPF2vt?=
 =?us-ascii?Q?4WpcQK7rWIzYXLLkd6RiipYa5EKN1NWCwoaaDyFd6LZJjJqJKwQWJJVy8mbm?=
 =?us-ascii?Q?XJ3c3uU7wd+ZyehdiFhmiTlCmoXB2g0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f2edba-d80c-4f00-7238-08deeba06828
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:32:11.1186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/B4PiMFvrb/Aj65bN2/drGxbh2HaMIojC7XqRy+qPN6JZ6tm3i/f0ynY30jwD1VeSOPADOEMeYp3iRPDOrQmVJQjTKDKh+49DO7GAfs4WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5693
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

On Thu, Jul 23, 2026 at 11:18:46PM +0800, Bin Meng wrote:
> Polling firmware requests system services without requesting an
> interrupt. The old model ignored this distinction:
> 
> 1. HSS requests the serial number with REQUEST set and NOTIFY clear.
> 2. QEMU synchronously fills the mailbox and clears REQUEST.
> 3. QEMU incorrectly asserts PLIC source 96.
> 4. HSS polls REQUEST and neither waits for nor handles the interrupt.
> 5. PLIC source 96 remains pending.
> 6. Linux registers the MPFS mailbox driver.
> 7. The stale interrupt immediately enters mpfs_mbox_inbox_isr().
> 8. Linux has not submitted a request or installed its response pointer.
> 9. The ISR dereferences that null pointer and faults near address 0x10.
> 
> Honor SERVICES_CR.NOTIFY, let IOSCB own the pending interrupt state,
> and route the SYSREG acknowledgement through an IOSCB clear input.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
>  hw/misc/mchp_pfsoc_ioscb.c         | 39 +++++++++++++++++++++++++++---
>  hw/misc/mchp_pfsoc_sysreg.c        |  9 ++++++-
>  hw/riscv/microchip_pfsoc.c         |  6 ++---
>  4 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
> index fd31427304..e39d995b64 100644
> --- a/include/hw/misc/mchp_pfsoc_ioscb.h
> +++ b/include/hw/misc/mchp_pfsoc_ioscb.h
> @@ -26,6 +26,7 @@
>  #include "hw/core/sysbus.h"
>  
>  #define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
> +#define MCHP_PFSOC_IOSCB_IRQ_CLEAR "irq-clear"
>  
>  typedef struct MchpPfSoCIoscbState {
>      SysBusDevice parent;
> @@ -53,6 +54,7 @@ typedef struct MchpPfSoCIoscbState {
>      uint32_t services_sr;
>      uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
>      char *serial_number;
> +    bool irq_pending;
>      qemu_irq irq;
>  } MchpPfSoCIoscbState;
>  
> diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> index 7c82b55986..ccc2201b7a 100644
> --- a/hw/misc/mchp_pfsoc_ioscb.c
> +++ b/hw/misc/mchp_pfsoc_ioscb.c
> @@ -192,12 +192,13 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
>  
>  #define SERVICES_CR                         0x50
>  #define SERVICES_CR_REQUEST                 BIT(0)
> +#define SERVICES_CR_NOTIFY                  BIT(3)
>  #define SERVICES_CR_COMMAND_SHIFT           16
>  #define SERVICES_CR_COMMAND_WIDTH           8
>  #define SERVICES_CR_COMMAND_MASK            \
>          MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_WIDTH)
>  #define SERVICES_CR_MASK                    \
> -        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
> +        (SERVICES_CR_REQUEST | SERVICES_CR_NOTIFY | SERVICES_CR_COMMAND_MASK)
>  #define SERVICES_SR                         0x54
>  #define SERVICES_SR_STATUS_SHIFT            16
>  #define SERVICES_COMMAND_SERIAL_NUMBER      0
> @@ -205,6 +206,21 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
>  #define SERVICES_STATUS_FAILED              1
>  #define SERVICES_MAILBOX_RESPONSE_OFFSET    0
>  
> +static void mchp_pfsoc_ioscb_update_irq(MchpPfSoCIoscbState *s)
> +{
> +    qemu_set_irq(s->irq, s->irq_pending);
> +}
> +
> +static void mchp_pfsoc_ioscb_clear_irq(void *opaque, int n, int level)
> +{
> +    MchpPfSoCIoscbState *s = opaque;
> +
> +    if (level) {
> +        s->irq_pending = false;
> +        mchp_pfsoc_ioscb_update_irq(s);
> +    }
> +}
> +
>  static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
>  {
>      uint32_t command;
> @@ -236,7 +252,15 @@ static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
>      }
>  
>      s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
> -    qemu_irq_raise(s->irq);
> +    /*
> +     * HSS and U-Boot submit polling requests with REQUEST set and NOTIFY
> +     * clear, then poll REQUEST/BUSY for completion. Linux sets both bits
> +     * and expects completion through PLIC source 96.
> +     */
> +    if (value & SERVICES_CR_NOTIFY) {
> +        s->irq_pending = true;
> +        mchp_pfsoc_ioscb_update_irq(s);
> +    }
>  }
>  
>  static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
> @@ -325,7 +349,8 @@ static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
>      s->services_cr = 0;
>      s->services_sr = 0;
>      memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
> -    qemu_irq_lower(s->irq);
> +    s->irq_pending = false;
> +    mchp_pfsoc_ioscb_update_irq(s);
>  }
>  
>  static const Property mchp_pfsoc_ioscb_properties[] = {
> @@ -333,6 +358,13 @@ static const Property mchp_pfsoc_ioscb_properties[] = {
>                         MchpPfSoCIoscbState, serial_number),
>  };
>  
> +static void mchp_pfsoc_ioscb_init(Object *obj)
> +{
> +    /* Accept service interrupt acknowledgements from SYSREG MESSAGE_INT */
> +    qdev_init_gpio_in_named(DEVICE(obj), mchp_pfsoc_ioscb_clear_irq,
> +                            MCHP_PFSOC_IOSCB_IRQ_CLEAR, 1);
> +}
> +
>  static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
>  {
>      MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
> @@ -456,6 +488,7 @@ static const TypeInfo mchp_pfsoc_ioscb_info = {
>      .name          = TYPE_MCHP_PFSOC_IOSCB,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(MchpPfSoCIoscbState),
> +    .instance_init = mchp_pfsoc_ioscb_init,
>      .class_init    = mchp_pfsoc_ioscb_class_init,
>  };
>  
> diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> index 1d9154280a..899b485da6 100644
> --- a/hw/misc/mchp_pfsoc_sysreg.c
> +++ b/hw/misc/mchp_pfsoc_sysreg.c
> @@ -77,7 +77,14 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
>          }
>          break;
>      case MESSAGE_INT:
> -        qemu_irq_lower(s->irq);
> +        /*
> +         * A MESSAGE_INT write is an acknowledgement event, not a level that
> +         * remains asserted. Model it as an active-high pulse. The rising edge
> +         * invokes IOSCB's irq-clear input with level 1, which clears
> +         * irq_pending and lowers PLIC source 96. The falling edge invokes the
> +         * input with level 0 and is ignored.
> +         */
> +        qemu_irq_pulse(s->irq);
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 63658fbeb0..f348de6fd4 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -333,9 +333,6 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
>                      memmap[MICROCHIP_PFSOC_SYSREG].base);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
> -                       qdev_get_gpio_in(DEVICE(s->plic),
> -                       MICROCHIP_PFSOC_MAILBOX_IRQ));
>  
>      /* AXISW */
>      create_unimplemented_device("microchip.pfsoc.axisw",
> @@ -489,6 +486,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioscb), 0,
>                         qdev_get_gpio_in(DEVICE(s->plic),
>                         MICROCHIP_PFSOC_MAILBOX_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s->ioscb),
> +                               MCHP_PFSOC_IOSCB_IRQ_CLEAR, 0));
>  
>      /* FPGA Fabric */
>      create_unimplemented_device("microchip.pfsoc.fabricfic3",
> -- 
> 2.34.1
> 

