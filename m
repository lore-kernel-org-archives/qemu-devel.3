Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE07CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 06:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3U0N-0005BG-Kg; Tue, 30 Sep 2025 02:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v3U0J-0005B1-BB; Tue, 30 Sep 2025 02:38:27 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v3U06-0007pJ-EC; Tue, 30 Sep 2025 02:38:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4/o3sHnR2Cr13GEqyKLwOs8X/6G2IDNU0Xax+AOF42Kr3kVuhVDZ2bwc1SU0sV9lihjGe62//rT42gh0bCMwOAoVgPvP61ErLLVJU4h4IdR4SpGUsNLlaz1Aj6vbw3bNMA2JFRUrkx/iFQwDadH/Bbi9YBDNxy4oGuoyoYg2cJ0vfhIv6RcQVFXphT9YPQfd0R0pdsVoBOkOoskWO4ORa6twsnqkACftQGYemGgT/9jCVEq3oV8zPwQh2r6LjLanJVoAAr8gvkb0sVmxtHyr1NTf+0+j/gOcZemQGj6xgWgiQh26frGHzvhTSnSZN+LVW3Nd2SRCRhDm+Slp2obUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOyqLF1UgoQelcZaXPVtYhGq0nf3KAIFXaTO5oe94H8=;
 b=Z8j1//PmY8EMWP3Cuegj01G1jE2+MdtL2bOg3gl/ITyoVfK+ZgeRyCUjFpwbCcpEGwiESbqHKFGrTsswGzEQVnlHqRfji2IdHz2cAEf0ptzP/McO1NOccCbfG0XJbJeMWdz7CGDLmqsak//YJCo/0rkIPU0cOCYGmjBH/PQ5/ksxs21oi5fXCjbCrpX1hyamBAyTAkWxop1Qg+uTATEyW0dKq6KfRCMQKnwYYU8zOYbQGQkgJoHhyg9ZUrhZpiCrFVNHkgGB0yPS7Igts6NRK4jNTyq2uL6lEngQmcoNHm1ms/GERp7IrPqcCY4ZCv/oweTsUvnGtfnkWbSPlrRA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOyqLF1UgoQelcZaXPVtYhGq0nf3KAIFXaTO5oe94H8=;
 b=GFsu+b/q4AsCcEOWhe1X0vAl/jxS7B0yxxOW7iG9lU2KdPJLl6K/p9UvgJYfCh+Io+3Tdmr6uPas9+kyTpWCihItXyHPzV9U4harSgPIOwKE0ka/UVVZfkKhmYX/akQt4VcHqhFxFikWWfnuVntC1kZKcIMmcVrYbIgsiDxu4KE=
Received: from CH0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:610:32::19)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 06:37:55 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::5e) by CH0PR07CA0014.outlook.office365.com
 (2603:10b6:610:32::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 06:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 06:37:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 29 Sep
 2025 23:37:51 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Sep
 2025 01:37:50 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Sep 2025 23:37:49 -0700
Date: Tue, 30 Sep 2025 08:37:49 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v6 38/47] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Message-ID: <aNt6vez--_Len36t@XFR-LUMICHEL-L2.amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
 <20250926070806.292065-39-luc.michel@amd.com>
 <70156c9c-5559-496d-8753-99f1ba5f68d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70156c9c-5559-496d-8753-99f1ba5f68d1@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c1b963-741f-419a-67fa-08ddffebe1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmVRZEljbzkzVUN1N0Fndzc0Mk0vbXZtcFJCSDFqdy9pa042cGpCSW8zeExS?=
 =?utf-8?B?TmgzNzJ5OU1NeEV4eWVlL2FrSCszaFh3WXFkaUR1ay9NQnhMZk50cFo4blpS?=
 =?utf-8?B?NUV2UU9RN3ZXdllmS0ZqVmdnMzdhbVQzVFFXQlM2d0F0UksrSmYrdml2SWJS?=
 =?utf-8?B?K1RZbnFhRHVUSkREWHIrT2tCR0piU0M0L09obXRRek52VUlPOFZJYzhNSDdv?=
 =?utf-8?B?bGR3aWRRM3VSQVBOdTJWRE85MHFHbGgwNmVQY3hZcm1MMVhKUkhTWWpJMGd6?=
 =?utf-8?B?SDVOSEE2alZoSjNwWTZmNmk2YVJwVHh4MmxheWQzZVI2MEVJS2JkZm83QUFG?=
 =?utf-8?B?eEhmR1d5TXVQMm04WmV5ZGxZUzlRNVVvWUpNSXBoTzhPQ2ZhYk5wNC9UR01s?=
 =?utf-8?B?bEx4Ykx1WFEybFNacXpqSkd6dWVWaVJYMDI1djBBVlpaRURmUEJRM2NpcmQz?=
 =?utf-8?B?a1RXaGNGSEMxMTVvRkpYaEpWektSaW11djBldVFrakFUdE1yTmhNVFNQaDNz?=
 =?utf-8?B?TU0zR0dLd0hUUTFpenZZNXUveXZ3bjdwcmFQTkxYOXZhcEhFMnMzR3l6NURY?=
 =?utf-8?B?Wlg4b2c0U0pzd2VkcjVLa2NhdmpXdWs4OXorajdFY0syeW5SRWhjZyt6c1JY?=
 =?utf-8?B?M2NiWFY1ZzZScVVWMGJPaGJ3cS9RaUk2aWtyeW1tQnMwZ0M2b00relRxNUlU?=
 =?utf-8?B?blJ6MEc1OFlqMDVaaU1heGVzc00rYkF4cW9Zek43YWxBaGRnYmJVdm9IK2Vy?=
 =?utf-8?B?SVphS3dvNkZ4cU02SE8vbmRSMm84UmZ4MFgvQkUwQWo2alZRSmJsUksxa2l1?=
 =?utf-8?B?cm5xZFJvOS9CQldBcUxwaFNOTGhYR2o0a2xFcHhPZW5IMGczSHNkMUJXTGxI?=
 =?utf-8?B?V0s4L2xuYm5Sd0JQa0tDREp5RHZiaGZ1L1JiZlpVbFNIeUxuQ1RhRjJxejV4?=
 =?utf-8?B?NVcvR1I2VU8xKytqRzN0WStEMXVLa0dUUFI3YndzOTNHTjVzbmU5MVNlWUty?=
 =?utf-8?B?RnRtREQ5ZTFjb1ByL0Z6SCtPT1paYVA1WDM2TlV6TEVSRlNsMXlkRjVuUGFl?=
 =?utf-8?B?T2UxVzJQMTM0K1FQam9DVEVWanhCdStGQ0pGWFdzeU9CMTdZbTRLeUlrZzQ1?=
 =?utf-8?B?dUp0MktPUGRTbkU3eWIySmpwYWdNcndNQ2tJamZJVkdpRG1TSTFrc3hjVzlW?=
 =?utf-8?B?TXJsZEwrUnI0bVh5WWw2cUNqMDE2ZU9vN094TlF2YXNmaHFZZmJ6cktsYm5w?=
 =?utf-8?B?YkMreVJDdU1mVzFXQmNORzhsMzEyd2N1MlR6SW45Nmh6d0xDOGdsYTlEQlVo?=
 =?utf-8?B?dkVncU0wS002c2gxcFlVMFlTU3hHbGhHRUljVFU0RFFKN1dqRkdibTBHYlJW?=
 =?utf-8?B?QTlkUlp0NjJtU21oL3pSTVc3Sm8vR016ZUs3RU9OaGRxRERSM2svaW9lbmlT?=
 =?utf-8?B?Ums2VWNiWFZyeGhRTkhTemlGV25kZWdjMnpaVnFPMThWdWpuU3Z6RVJxY0xI?=
 =?utf-8?B?YllLTmI1cDU2Y2lLVHIwMmxmTk1oU2lVMFlCbkRCL2RUcURjMEd3V2dSaVdu?=
 =?utf-8?B?dlpiTjFvS1JXWnRSZTJ5UmsxQ3Q5RnRoeXJ5REk1WXJPR055M2pBaTA2UFRE?=
 =?utf-8?B?Ym5aVVJOdnZ6aHVyLzJ6V0VRMkNON09BdUhpYmcraS9yaStod1JGM0dLYXN6?=
 =?utf-8?B?UmtleXdzanV1UmNqeWlnWjdWeXRUS1BJZGFZcStySGRqWXRNcy9vOFdhTlFp?=
 =?utf-8?B?dDNpZERyQm9BQ0g5YW5jS2ZQSi9ZS1IrYnNHTlUyV3AxSDVZV3hZUUd1UUIy?=
 =?utf-8?B?LzI0bHU5QTFjdFkxK09kS1ZZcVB1VkgwOHliekl5VjJLR2dLQUxpT0lHSC9i?=
 =?utf-8?B?cGRFK0ZEeDhwdnY3a0JGUHo2RkU1b1JDR2xhQ3pSc3pScWhhYmFOUXVqNUNs?=
 =?utf-8?B?WklNcDhrV1lQZGpHQ1Izb1hZQkViRkRZNHVsNGtwb3k4TmhLdCtHNjd3Yngv?=
 =?utf-8?B?U2lYK1FuL1pxT2xJV3FpNmoxZXlobittcDVKUitacTY5cWE4Y1JSbDgwOWRk?=
 =?utf-8?B?bURpb054TnYxN0dlaXk1ZUIrK0J2VEcxWDRMQ3Qwa2RBRGFUdUZ5SHJTZTR5?=
 =?utf-8?Q?fvBI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:37:52.3839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c1b963-741f-419a-67fa-08ddffebe1a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Luc.Michel@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Phil,

On 12:34 Mon 29 Sep     , Philippe Mathieu-Daudé wrote:
> On 26/9/25 09:07, Luc Michel wrote:
> > Add the target field in the IRQ descriptor. This allows to target an IRQ
> > to another IRQ controller than the GIC(s). Other supported targets are
> > the PMC PPU1 CPU interrupt controller and the EAM (Error management)
> > device. Those two devices are currently not implemented so IRQs
> > targeting those will be left unconnected. This is in preparation for
> > versal2.
> > 
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >   hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> > index 3d960ed2636..64744401182 100644
> > --- a/hw/arm/xlnx-versal.c
> > +++ b/hw/arm/xlnx-versal.c
> > @@ -50,18 +50,30 @@
> >   #include "hw/cpu/cluster.h"
> >   #include "hw/arm/bsa.h"
> > 
> >   /*
> >    * IRQ descriptor to catch the following cases:
> > + *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
> >    *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
> >    */
> >   FIELD(VERSAL_IRQ, IRQ, 0, 16)
> > +FIELD(VERSAL_IRQ, TARGET, 16, 2)
> >   FIELD(VERSAL_IRQ, ORED, 18, 1)
> >   FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
> > 
> > +typedef enum VersalIrqTarget {
> > +    IRQ_TARGET_GIC,
> > +    IRQ_TARGET_PPU1,
> > +    IRQ_TARGET_EAM,
> 
> Maybe declare IRQ_TARGET_RSVD here,

I'm not convinced. In the future we may need more targets, even more
than 4. In this case we will increase the TARGET field size, probably we
will then have even more reserved fields. I feel the way it's done here
is simple enough to catch all the buggy cases thanks to the default case
in the switch below.

> 
> > +} VersalIrqTarget;
> > +
> > +#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
> > +#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
> >   #define OR_IRQ(irq, or_idx) \
> >       (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
> > +#define PPU1_OR_IRQ(irq, or_idx) \
> > +    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
> > 
> >   typedef struct VersalSimplePeriphMap {
> >       uint64_t addr;
> >       int irq;
> >   } VersalSimplePeriphMap;
> > @@ -412,19 +424,27 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
> >    * Or gates are placed under the /soc/irq-or-gates QOM container.
> >    */
> >   static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
> >                                             qemu_irq target_irq)
> >   {
> > +    static const char *TARGET_STR[] = {
> > +        [IRQ_TARGET_GIC] = "gic",
> > +        [IRQ_TARGET_PPU1] = "ppu1",
> > +        [IRQ_TARGET_EAM] = "eam",
> > +    };
> > +
> > +    VersalIrqTarget target;
> >       Object *container = versal_get_child(s, "irq-or-gates");
> >       DeviceState *dev;
> >       g_autofree char *name;
> >       int idx, or_idx;
> > 
> >       idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
> >       or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> > +    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
> 
> and assert(target != IRQ_TARGET_RSVD) here?

This is already ensured by the default case of the switch below.
versal_get_irq gets called before versal_get_irq_or_gate_in.


Thanks

-- 
Luc

> 
> > 
> > -    name = g_strdup_printf("irq[%d]", idx);
> > +    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
> >       dev = DEVICE(object_resolve_path_at(container, name));
> > 
> >       if (dev == NULL) {
> >           dev = qdev_new(TYPE_OR_IRQ);
> >           object_property_add_child(container, name, OBJECT(dev));
> > @@ -436,16 +456,33 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
> >       return qdev_get_gpio_in(dev, or_idx);
> >   }
> > 
> >   static qemu_irq versal_get_irq(Versal *s, int irq_idx)
> >   {
> > +    VersalIrqTarget target;
> >       qemu_irq irq;
> >       bool ored;
> > 
> > +    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
> >       ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
> > 
> > -    irq = versal_get_gic_irq(s, irq_idx);
> > +    switch (target) {
> > +    case IRQ_TARGET_EAM:
> > +        /* EAM not implemented */
> > +        return NULL;
> > +
> > +    case IRQ_TARGET_PPU1:
> > +        /* PPU1 CPU not implemented */
> > +        return NULL;
> > +
> > +    case IRQ_TARGET_GIC:
> > +        irq = versal_get_gic_irq(s, irq_idx);
> > +        break;
> > +
> > +    default:
> 
> And here 'case IRQ_TARGET_RSVD' instead.
> 
> > +        g_assert_not_reached();
> > +    }
> > 
> >       if (ored) {
> >           irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
> >       }
> > 
> 

-- 

