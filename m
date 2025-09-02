Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCD4CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLL6-0005uO-2f; Tue, 02 Sep 2025 03:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1utLKt-0005se-M8; Tue, 02 Sep 2025 03:21:47 -0400
Received: from mail-co1nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1utLKr-00061G-46; Tue, 02 Sep 2025 03:21:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLLXbgq8fgL2fHHlXwzGNb/kvIdP/Bxt4M5MCSQQDvgYnTT8aS8IW5Sqwvnq+t1FhEhaFHHu1tP2BbEJ4TEBN4ZqT71n3eiY8utE5k0I0zd8hQErVWMXv4+IeKAqcl4La43S5CFxeXp/9kNUR7S8g5xDXKW2JaUUCqNesa79GUhZQlbavedW1KaFYC0F8AgZC+sYBdOCvuim/2Zvyt6tq+D5Eb0bNPnULKm/2lg5lj9D8nL/boxwzLOSCPcgE4pZ1WQj6znCELwUyHr4M7O5uJIIDSFWk2bG4SZUhlDNoDfpXKjdNJTgJbGIdq1q3erORsk8xxoY6+DwMmJCQfkghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyI+PlBQkrEMumjXLGRtY1g5bEqMa+XhTtXcxX31qH8=;
 b=wYi+BmM3EqzTnffuTjcMj2Rh1AMM/h161cJR3tHcbU8NThpW81vfcQitjmEsTbjko9Acq1Jzy4UjCh4SfgaHDV69AOnIb0XL32lECyyWgTY5Fsm+hPpgwD3MRyb9TtfNg6R0kApPezDZJAKHA6QfTduyajYAQbv6UpeE/OhC44CfNWoBnzIHzj06+A3DmXZ7+jMOao73lj7DelRt2VFL/EgFV4UKdw1z5HIO1OTMNSWnXAfw3CA2j4QKbmusvRv0cx7ysLVVr/+2+3c0KVFbvbpW4iV68N463R+L8OxHgI/5CkrGdO4/GI6EV03kWvPYbiGGH/yv3MWNUOk2yt/DSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyI+PlBQkrEMumjXLGRtY1g5bEqMa+XhTtXcxX31qH8=;
 b=BC22qXlef1qdlLqx97zJzx1JuBCEBJuyyvP6vvF3qBup8I0JbAQQ7LQdRpVLVBhCjfH6aqbaCzxsiQ+QoGTKKsxft+FjwZzAbMlgg2D73j9H/ddDfWoMxqfvdvbzzEm3nEbotAWZKU78Seacj8huqG2XXC0+WIndjgrROw/bdfA=
Received: from BYAPR07CA0044.namprd07.prod.outlook.com (2603:10b6:a03:60::21)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:21:36 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:60:cafe::86) by BYAPR07CA0044.outlook.office365.com
 (2603:10b6:a03:60::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 07:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 07:21:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 02:21:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 00:21:34 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 02:21:33 -0500
Date: Tue, 2 Sep 2025 09:21:31 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v4 36/47] hw/misc/xlnx-versal-crl: add the versal2 version
Message-ID: <aLaa-xuqqa-iNgay@XFR-LUMICHEL-L2.amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-37-luc.michel@amd.com>
 <f5aeb950-47b6-47e2-8b6d-cdd01004f1f6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5aeb950-47b6-47e2-8b6d-cdd01004f1f6@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f1f4d6-3d83-4093-9c3f-08dde9f159cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXNmUkZUVzk5OFcwV25IZ0pNZFFYMTRYeHVkUUFHVml1R3BUUjdYUG1kM3Fw?=
 =?utf-8?B?OEEwMlNZbVlXTFZ6WDhEWUsxNWRXWDYvaFM4NzhWbHJQLzNRQ0VDRXJVQTYr?=
 =?utf-8?B?Uno5ZXl6WDQxVmtjMUVUTStGNnBOVXNyMEx3RTZiazJNNkIwUnIrZ1gwbi92?=
 =?utf-8?B?NE11MHdZL3dFc2tzSzU3aFVoeGltRzZjUStyWENzTStNSzFKZFJ5TDVXclk3?=
 =?utf-8?B?WVZFeXNRWWtiN2t5WGRaNUNUWGk1aHkvZUpoZG53cmIzN3NNNUZpUmdWZmxJ?=
 =?utf-8?B?K05DdVUzUTB2Wm9ibFhKMFh2dVVQcklLMGtCeExrQjYvbkcyNzFKSldkVzFL?=
 =?utf-8?B?QTNIV2pWRnJtM3NxV01XYTFQbngzcWtvQ1k0c2QwWXZGMVAzZ1dOTUZVQ2Ry?=
 =?utf-8?B?U2xOZFBkV3ZMbmZ3Z1hCZTlQLzIyRXJzUkdFUTZaQnBjSXl3NEY5V0pTTGUv?=
 =?utf-8?B?Q25WYVZsNWJNdHpFWDQ2OWZ0K1hDN01PbjdCZXJyNDB5SjJJdFlvL3NHVm05?=
 =?utf-8?B?SkZucW04OERGVnRYeE1wN3hCK2lKQlJsSFBkOXUyRm54S2VFclIvMTVxbU5l?=
 =?utf-8?B?UzJGVDNSelM2bHUwUG9KYVJmbENjMExiOTJoeUNhRVJ4RmNPNW82Mm53TDFq?=
 =?utf-8?B?Z3g5TFdJK3BrbHFMeFlJTXpBcU5ocS9TZ2JNaGtpVXYyeUp6RFZlUnFQVS83?=
 =?utf-8?B?enlKZzF4dkEwSjc4eDRUTENwK1BFcWpmNkNQUm44K2oyWmltR2VYVFN1dHJT?=
 =?utf-8?B?WlBaWHNMS1RqRDhuL3hBNnM1TElFMlpuUGhySzF3Y3d0OXRlQU42TmkvVTRs?=
 =?utf-8?B?MFRUTTk4c2ltRHpZcEh0WUV3WUkzczVrQWhmK1BlazdGa0dtZjJVdE04WWJr?=
 =?utf-8?B?bWpEYk5SdHprRTF2ZU1kT0dlN0dvL3Zka0ZoOVJxSkxZM2c2Qmxpb0tIY2pk?=
 =?utf-8?B?cVBkekRJY0hRalRlbXhZY3lwSGV5RDRzN3NGaFB5NUdrckRuNnJEOWhYV2Na?=
 =?utf-8?B?NHgydlRsV3VpQ0J3bmNYZWR3MkxjMk1QOCtxNTVuQ3luZXMrdG03UjFqUWww?=
 =?utf-8?B?cmNnTzV4YTh4RHlkdmppRXp2bHVxZjhhQ051WmxQRm9IcXZnWlFJU01KM2sr?=
 =?utf-8?B?RjJqSFdlZWFvblFQVDFRN0p4OU9tNXRTdmdrcHFZWHJrNTdnRjF1aE9EcDAz?=
 =?utf-8?B?UFFSQmc4MFpDVmNkNUVXWTduL0F2N1F5RGN6MlRqN2g3andraG0yK0lnM3hZ?=
 =?utf-8?B?dlJzaWxPdzFxWklLWUgxSkg4cFBnMFA2bVZJZHBDSUdqNGxSL3pDdkZvZ01h?=
 =?utf-8?B?OFZSaUhxQlhFVzBmLzJYaUtlNlFNZkpwa1pWN1BOU3RkMWNERHpmRXJjT0Zl?=
 =?utf-8?B?bXJkU2R2dnEvNHNUSVJYczRQMitEUmNoZWFLa1NJcUcwTnY0elYzY1JYZDVM?=
 =?utf-8?B?cG95TENLZjZKOU1VcTFoQ3o1clVPaHRqMDBJaUhvOEkxSGQ0c2UwcHlGTEVj?=
 =?utf-8?B?clJ6U1BFWm8yVnhSdUkvSTNBT2pUL3FxSW9kbUI3UzdiZkZTWlBwVUpNU01Z?=
 =?utf-8?B?enpYRENDaUF6M3R2YkR3SnE5eEhGVXpRay9aL0srWEYyc1lYKzJIQUFZZ2Fj?=
 =?utf-8?B?UE5qTFk2ZWNESkZ2SkhXRGdtSmFyTzBjMU9vOFZaZVBpQ2hFODlva2RPS08x?=
 =?utf-8?B?SXdtL09NMHVTUHJFTVdJY3RUczhIb1JJejJuNU1IT1JoMGZEK1NnK3MreVhS?=
 =?utf-8?B?elhKUTJpRStqa3docG5seG1lTklzb0x4REsydmZaOWtjOThhdzNPMzdOeGVV?=
 =?utf-8?B?WER1SmxVWWd6S1pIOXFaYVAranV1dmxja2FFRFBIUnN0WXdtSWRldXhoUG5D?=
 =?utf-8?B?cUo4aGFIWmV1bVNodVJTd2VRMGVqV1h4SVg2ak9NREt3clFIUjNjYm11c2U1?=
 =?utf-8?B?bXdvTUsvdjZYREtGZ0FwWVBxaVlkSFNHVlRvQ1pZWTR1MUlqVXVMcUpWeitZ?=
 =?utf-8?B?RnNDUk94aHVXdlF6NHd4NTBnMnEyakhkRkcrVkxoN0lobUsyREpNK3VGNlJ5?=
 =?utf-8?Q?ZbeaLM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:21:35.8043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f1f4d6-3d83-4093-9c3f-08dde9f159cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
Received-SPF: permerror client-ip=2a01:111:f403:2416::62a;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On 00:22 Fri 29 Aug     , Philippe Mathieu-Daudé wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On 22/8/25 17:16, Luc Michel wrote:
> > Add the versal2 version of the CRL device. For the implemented part, it
> > is similar to the versal version but drives reset line of more devices.
> > 
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> > ---
> >   include/hw/arm/xlnx-versal-version.h |   1 +
> >   include/hw/misc/xlnx-versal-crl.h    | 329 ++++++++++++++++++++++
> >   hw/misc/xlnx-versal-crl.c            | 392 +++++++++++++++++++++++++++
> >   3 files changed, 722 insertions(+)
> 
> 
> > +static DeviceState **versal2_decode_periph_rst(XlnxVersalCRLBase *s,
> > +                                               hwaddr addr, size_t *count)
> > +{
> > +    size_t idx;
> > +    XlnxVersal2CRL *xvc = XLNX_VERSAL2_CRL(s);
> > +
> > +    *count = 1;
> > +
> > +    switch (addr) {
> > +    case A_VERSAL2_RST_RPU_A ... A_VERSAL2_RST_RPU_E:
> > +        idx = (addr - A_VERSAL2_RST_RPU_A) / sizeof(uint32_t);
> > +        idx *= 2; /* two RPUs per RST_RPU_x registers */
> > +        return xvc->cfg.rpu + idx;
> > +
> > +    case A_VERSAL2_RST_ADMA:
> > +        /* A single register fans out to all DMA reset inputs */
> > +        *count = ARRAY_SIZE(xvc->cfg.adma);
> > +        return xvc->cfg.adma;
> > +
> > +    case A_VERSAL2_RST_SDMA:
> > +        *count = ARRAY_SIZE(xvc->cfg.sdma);
> > +        return xvc->cfg.sdma;
> > +
> > +    case A_VERSAL2_RST_UART0 ... A_VERSAL2_RST_UART1:
> > +        idx = (addr - A_VERSAL2_RST_UART0) / sizeof(uint32_t);
> > +        return xvc->cfg.uart + idx;
> > +
> > +    case A_VERSAL2_RST_GEM0 ... A_VERSAL2_RST_GEM1:
> > +        idx = (addr - A_VERSAL2_RST_GEM0) / sizeof(uint32_t);
> > +        return xvc->cfg.gem + idx;
> > +
> > +    case A_VERSAL2_RST_USB0 ... A_VERSAL2_RST_USB1:
> > +        idx = (addr - A_VERSAL2_RST_USB0) / sizeof(uint32_t);
> > +        return xvc->cfg.usb + idx;
> > +
> > +    case A_VERSAL2_RST_CAN0 ... A_VERSAL2_RST_CAN3:
> > +        idx = (addr - A_VERSAL2_RST_CAN0) / sizeof(uint32_t);
> > +        return xvc->cfg.can + idx;
> > +
> > +    default:
> > +        /* invalid or unimplemented */
> > +        return NULL;
> 
> Can that happen?

Not in the current state because I connected the crl_rst_dev_prew
callback only on implemented registers. One could hit this when iterating
on the code for e.g., a futur version of the SoC. A
g_assert_not_reached() would be a good fit here.

> 
> Note count=1 when returning. Should we set to 0?
> 
> > +    }
> > +}
> 
> Otherwise,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

-- 

