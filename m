Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA34CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 07:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQ9i-0001Wv-FA; Tue, 16 Sep 2025 03:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyQ9g-0001WO-I0; Tue, 16 Sep 2025 03:31:12 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyQ9a-0006iH-QR; Tue, 16 Sep 2025 03:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVo61+HHie1l3GdA/ywK1mTfThPqd3sPjzpoHLBlJI0x2oinonjNx9nuOUctewt3mmo0H3wH/gUxpMXx+v1FH+YCnA8XdyRwVWlLiMzidFWgntRtxGbRJA7jVL7v42/rxJcyBOxOynI/TJQsXkj/j39aCZgsaamKBcS4x3xGYH5bIA4D8e8vGYcTTqJvT6rAwCBaSA6RKJyHlcOK/wIKik2i1y2MzvVZ8lvDTBXMTg611JroSVWbIc9goh0/kcLpv6ilr3jQuwA3key9h0dbHyapKEuPA10JC7BxmQTMHofMbQowWOpSpg8lRKNkVlxMnBVDwd9UL3H+z68mfPp7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPRjjKtgL+xnUvNvda5Z6JRue8R8YgTL2LkqKAsPZJE=;
 b=p7F4gfPW/PsxYuBCZeMgPF9D0gP+/gRSJp3Hur/wykJdiNWUrzBhaL+x/zonkdPh955bHmTDLSyxiay41kFD/NRKvmO4SR4ie5epD1bEbzfn/5WDdasQEdpDFW+CqQFyeG4fvrAm0mhq6w9iz06QWqD/WBwIZGpxk+BPGXiaDWIPH9n5yfk1L/y8uoiRpKN7nzDD2ebKRaYD1PzRtOX+/NRq4VOGF7fC7CFQNSQAPRswB1eu8ymiNBrg3OURMSyMaTnKc4WK/vaL2B2M1AEobr1hzYerTkSkcJ1D4QtIaQAofUeJTKrnBB8PQKh5DlmCbqGPIm7oSfPMFMhdQy6lrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPRjjKtgL+xnUvNvda5Z6JRue8R8YgTL2LkqKAsPZJE=;
 b=qlaiXQ5JF55mY4KCvONNZqLgXVRobNJtl+Wh/zFhM+HWGZdnDIiZJ7TDx0iCg/hFx8PpndtjdENu+UpG+v8MQFUI+2rq4Hc0e8yL+bvpgNT8bf6+H75LUcpQZnqcopNpWxzxDMKRfyKwp5mXN3cvqPDpVcVSGw6GIdZKZXwzhqs=
Received: from BN9PR03CA0705.namprd03.prod.outlook.com (2603:10b6:408:ef::20)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 07:30:54 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::78) by BN9PR03CA0705.outlook.office365.com
 (2603:10b6:408:ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 07:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 07:30:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 00:30:53 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 00:30:53 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 00:30:52 -0700
Date: Tue, 16 Sep 2025 09:30:46 +0200
From: Luc Michel <luc.michel@amd.com>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Message-ID: <aMkR9fr7ITfggWV7@XFR-LUMICHEL-L2.amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-3-luc.michel@amd.com>
 <aMRVsn6cbN7fjPuq@zapote>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aMRVsn6cbN7fjPuq@zapote>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca206ba-1510-4aad-52f8-08ddf4f2f83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SNzxSAO9/fFV7RVgm8Z+JJrYpCTGrV1Lb8OvQ5d1cuJQtAIad2VrWGKj4ebv?=
 =?us-ascii?Q?jGaO3vB6grJxExF88KkJwihS74a0CfcuoatwKVZJ2M+4yLAcI8wYWCcrG/dr?=
 =?us-ascii?Q?MEtgkDTxIRo3mD7Kge8jQhWz7UMQqB40A/MHeIaZN08WQupTkEdRVIbioFfw?=
 =?us-ascii?Q?q+uFyRmj6qHvtc6xT6wpMUhCvGI0zzcKayhuNrziOsset8GD2Uj6jNugt5KP?=
 =?us-ascii?Q?jGbBuDfrPKfMs5nOUzT+cA5VE7c6gND/ICH5MiuauUUw09ype3KYa+gFxHoz?=
 =?us-ascii?Q?/q7lA5/0/gxq39kI2addHvYGK0uRo1BaKCkzQ65ECS+66fjgsvVrNJU4nzwE?=
 =?us-ascii?Q?sSMqq6VEJfdQaiofPhWASSp7/golOk72ic0E1coAEUZCNKB5AolcT6F+3sor?=
 =?us-ascii?Q?3rEAgtYzkezqWfUuN5L7++hZRvLmojhtZmhb/tnv1gJ0MqHWkhniXQRMuURB?=
 =?us-ascii?Q?5Af/z0NWLIIBIGfObZ9hi5SOre/9iWzR7swG9z+eKqTfd9TKvWGBJwr7+7/B?=
 =?us-ascii?Q?6ghPTTEM4EToCqSPmROpRiJLbooGfWemtvQTVEoLnGmLNsQuPE1t/LaxkERa?=
 =?us-ascii?Q?fd/KRQSnWWTG+5cu0UMywFkxhFh0f29fRni+TWHt3tRKefOqGJtuSheDWcBK?=
 =?us-ascii?Q?HDhWd2ULZYsXFiufGcYSSJz0w2Mf9dlpymoc7gwiLLKbHbcQRkyL6Awn57Mt?=
 =?us-ascii?Q?YaquQ7ATFp5i8D30IB6W4azRfZvab5SMqHmWEsM8HtkzKpcxOdAez/aJNvk2?=
 =?us-ascii?Q?BgMy2zmopR+Fr6gW65LDGajiE3T5kZMK18BBBT/Vkeqo56XnqT0OEEYzgF/U?=
 =?us-ascii?Q?1R4kWjEW7iw+J/D23LCfVqQuukSZPhhI0HYnA/KHENZQkHi05J5G66ZPUSGL?=
 =?us-ascii?Q?rq/U2tePuyy2NfHd8kCQ7ul/Xd/uXrH1Nh2mpSCmuC1Tg+ZtFbP+IzHYgRQG?=
 =?us-ascii?Q?YY9C2a/kAUSaHtnJy4Eo4Q+R1fEPjclo5pM7Ab/pXNbxZEuR1LtlSr/hLWwD?=
 =?us-ascii?Q?vR+ustKfXMDhmsxeqoQvbQhc8i1YTbnmnxJktQSxuLIdtr2Rg1u/9W70+WKD?=
 =?us-ascii?Q?vTkAErmgqlBAfSZsejyfm+aafrH4RVkDuFtNg025yv9oHQyNkykN0ysahDhk?=
 =?us-ascii?Q?Ba+2Z8oSM6BXqeGuHLmfQnK820N/ubjyNxDbJTr57bV8q1M8aLQp+WPZm0xY?=
 =?us-ascii?Q?GIF0TCzWfZTeInkQPtch5VzKH1BcPGQ9UAeF+zR6dfejzQrw0B7r9PTMkYTi?=
 =?us-ascii?Q?OPaaWNmEUg8QRiNZuvf0E3M0h13BjDbLsq6usXRhNTq6yGHZ17Rcg7prEQu4?=
 =?us-ascii?Q?p2TW7oo99ANyltOGvXz7MkgI3lWiQjLD7r5C7CUqAT8UQQuG+hQjjUxOsWI6?=
 =?us-ascii?Q?SacNmCAYyDJ1UGiOVaFTBCstXgOmuxHLbtKWGBxpDKbafZdx1OonF7e1nibB?=
 =?us-ascii?Q?gp7Eo+ad8eZda7xRwboNnF4vr3EJtCOmxAtaL+Wqx+ghLC3Mja2pMkorTA6A?=
 =?us-ascii?Q?y2Fv/LpfPcEVrD7OWSxlC7IFw4jqSSH/XKKG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:30:53.9878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca206ba-1510-4aad-52f8-08ddf4f2f83a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Luc.Michel@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Edgar,

On 19:17 Fri 12 Sep     , Edgar E. Iglesias wrote:
> On Fri, Sep 12, 2025 at 12:00:11PM +0200, Luc Michel wrote:
> > The following commits will move FDT creation logic from the
> > xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
> > passing the FDT handle to the SoC before it is realized. If no FDT is
> > passed, a dummy one is created internally as a stub to the fdt function
> > calls.
> > 
> > For now the SoC only creates the two clock nodes. The ones from the
> > xlnx-versal virt machine are renamed with a `old-' prefix and will be
> > removed once they are not referenced anymore.
> 
> 
> Hi Luc,
> 
> 
> 
> > 
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> > ---
> >  include/hw/arm/xlnx-versal.h | 12 ++++++++++++
> >  hw/arm/xlnx-versal-virt.c    |  9 ++++++---
> >  hw/arm/xlnx-versal.c         | 28 ++++++++++++++++++++++++++++
> >  3 files changed, 46 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> > index 1f92e314d6c..f2a62b43552 100644
> > --- a/include/hw/arm/xlnx-versal.h
> > +++ b/include/hw/arm/xlnx-versal.h
> > @@ -134,21 +134,33 @@ struct Versal {
> >          XlnxVersalCFrameBcastReg cframe_bcast;
> >  
> >          OrIRQState apb_irq_orgate;
> >      } pmc;
> >  
> > +    struct {
> > +        uint32_t clk_25mhz;
> > +        uint32_t clk_125mhz;
> > +    } phandle;
> > +
> >      struct {
> >          MemoryRegion *mr_ddr;
> > +        void *fdt;
> >      } cfg;
> >  };
> >  
> >  struct VersalClass {
> >      SysBusDeviceClass parent;
> >  
> >      VersalVersion version;
> >  };
> >  
> > +static inline void versal_set_fdt(Versal *s, void *fdt)
> > +{
> > +    g_assert(!qdev_is_realized(DEVICE(s)));
> > +    s->cfg.fdt = fdt;
> > +}
> > +
> 
> Should this be a property of some sort? it looks a little odd to bypass QOM..

fdt being a void* and not an Object*, it's not directly possible AFAIK.
I don't see it being an issue here because the Versal SoC code is
tightly coupled to the versal-virt machine code (the machine is
basically the sole user of the SoC). Even if it was not the case, the
SoC interface is fully specified in xlnx-versal.h and any user can
leverage it just fine. I guess QOM/qdev abstractions are necessary when
we don't include the .h and only rely on the type name (QMP, HPM
use-cases, ...).

[snip]

> > +
> >  static void versal_realize(DeviceState *dev, Error **errp)
> >  {
> >      Versal *s = XLNX_VERSAL_BASE(dev);
> >      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> >  
> > +    if (s->cfg.fdt == NULL) {
> > +        int fdt_size;
> > +
> > +        s->cfg.fdt = create_device_tree(&fdt_size);
> > +    }
> > +
> > +    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
> > +    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
> > +
> 
> Should we be adding nodes if s->cfg.fdt wasn't created by us?
> If the user passes a dtb, I wonder if we should just assume the user
> knows what they are doing and use it as is...
> 
> Or do you have use-cases where it makes sense?

Note that the device tree created in the SoC code is just a dummy one to
avoid crashing when the SoC user does not provide one, as stated in the
commit message:

"If no FDT is passed, a dummy one is created internally as a stub to the
fdt function calls."

This code path should not be reached in normal versal-virt machine
use-case. We rely on the one given by the machine code through the
versal_set_fdt function.

Then to answer the question about the user providing a DTB, I stick to
the existing behaviour before the refactoring. s->binfo.get_dtb is still
set in the machine code and provided to the ARM virtual bootloader. The
bootloader uses it only if no DTB is provided by the user.

Thanks

-- 
Luc

