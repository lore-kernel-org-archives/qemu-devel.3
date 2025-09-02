Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DA9CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLE1-0008E2-P3; Tue, 02 Sep 2025 03:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1utLDz-0008De-1D; Tue, 02 Sep 2025 03:14:39 -0400
Received: from mail-mw2nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1utLDv-0004rG-UY; Tue, 02 Sep 2025 03:14:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAorJ1eUlqCjGXzE4eJRMnACP6wZd262Jz797UlSojSY016aFuRiPCcvHGyECg6KFsIr0OotZt+66GgbTu1Q/Y0y93+liFqxneqvEHum/cpqmXRoHsFbRtDbm0KiMYZHq5Pzzvy7cUqdOtSMULBHKGPJLqG5m2uBLu3TrbYMlirybFZap8HS2Cx+KON+Fymxgg4QF1ymnXcwZqY2AQmneA0OsJcTAYvt+mjb6+ZheaI9eMoWd/dT4DA8O4EwRFHGXXtqlaXO7W0jD04AoBfNbBlNi6qsGvonAV05/fjQUQwtzByYwZac9KVVvFBeHP8RTBibQKg9kKcxBaO8R68now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/4NDiDyyKdbiCqKl7x0Qpv3a6e4YVd4EE4tNZdPXsc=;
 b=GKMOk2ZxfNRyWxNLFgDUVlOVJ9IhYijiXIC+t2mOaHVm5QMP8nOOEcLb+c44KpkkD6We5kz/IRx2Wzgo3g4wgvBqZcFvsHWcw3Y+kGQxz86CFebHoALyCgR1qVkA6Vh/Zms94S0d6KaO5uen4hRk+mzMfbmXcqu39OQ8zT43F0aWwvPaCujdImZY/gnlYv6zCbkIRz8cPjn7wsfGrwwXn7EzF1SWTffkBCFYFYYiWpkq9o3iJXj+znYCRzcKeGOfAu+geXz1XNfcBPB+A7VdnbprxIu8vhAdx2NUYJgWWHK3WEExp69OOil6bsh1BtoT50BF1qlC3ZzOQ+55gTkIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/4NDiDyyKdbiCqKl7x0Qpv3a6e4YVd4EE4tNZdPXsc=;
 b=hPA03WTNorrt9QA78k7/3NnlF4fn+goNA2//gpiY4p1C/v4vKHCfrpVVtpbdm9llE2kwe7eb0IKpsHrr8hOvrseEk8rNDO0F3L3yeBLF5OuOyu2haYDYe6FvNNlusxix1dk44kx/buF6ojx/CjL1wTPI9HcykD7FupNy2m2Ggnc=
Received: from CH2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610::21) by
 LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:14:18 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::7a) by CH2PR05CA0008.outlook.office365.com
 (2603:10b6:610::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 07:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 2 Sep 2025 07:14:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 02:14:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 00:14:17 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 02:14:16 -0500
Date: Tue, 2 Sep 2025 09:14:09 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v4 05/47] hw/arm/xlnx-versal: sdhci: refactor creation
Message-ID: <aLaZARva5o0Z4jDU@XFR-LUMICHEL-L2.amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-6-luc.michel@amd.com>
 <88966d75-2947-4fd7-999d-9b94250a9033@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88966d75-2947-4fd7-999d-9b94250a9033@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: a3370297-bf2e-432f-5bc2-08dde9f05514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVFBY1U4ckxvanVLVjRqakdhamtWaFVKNi81ZGtLSGQ2UzlZbkFIWkhqa0VD?=
 =?utf-8?B?S1RURkh1aXlBTWl2c1lsdXNLQjBRZDBYajVPbHQ5d25scE9oemJKajBHMzJa?=
 =?utf-8?B?elpQMjdaeDRMZm8yc0ZBVW1jNUFvZklRQi8rRTNmWitFU0NrMkFMcXk0ZktF?=
 =?utf-8?B?U3pMdVVVYS9BVnZrakxyQlFQMGE1Vkl5TzduT1JpbXUxM2RJdzNlU0J6U1hM?=
 =?utf-8?B?Q3RDK01hMUluQzJlQnBERk1aQ2ZISE40VnpJY3JwckNvdm9MYXdNWitDQ0VF?=
 =?utf-8?B?WDVQcHMrWUs2V2R2U2V2SGtkb29nM0p4bm52QVRCQXdvajFBS0xSVDhBYTRI?=
 =?utf-8?B?UFpwa1lxdWtKQy9mUktPbEl5V2NFRTNRR1lEOG54NUdrdnFicUFkUEgvRzV1?=
 =?utf-8?B?elpjUjFvK21rMFVzdVIrNE0vMnplZUs3c2xpNTA3Y2lYa1JMeW1iemNZcnVO?=
 =?utf-8?B?eU56QVRnOVh6TTNIWnVoZmNqaUJIN1RTQkxvMlE1WHlEZlMrc25iVVoxZ1Iv?=
 =?utf-8?B?am1UOVdIeUF5UWZDZ0l6WGlCTzZlcVF5VEV2UDVBVlZIcVFRdC9iL256M2Y3?=
 =?utf-8?B?amwrcVdNaWVva2JNSlUrT3VSOUNXQytyajNlblpWM3FaQmExazhHZzN2bk1v?=
 =?utf-8?B?NzhxTnVPYWJFOUhLODdrRWh4Z2IxalBYQnVuZHpISSs3VTRtTUNVcS96a0wr?=
 =?utf-8?B?djlTY2JVRVNrR29haldMZlorZGNla3JTMzR1SzJlcHZLU1ZJNFo3KzEyQjJ4?=
 =?utf-8?B?NkZMUi9DRmpDNmFCNUMvTmM4RlQreTV1aUhZaEp4Q3puQkdxTlg4elgrL2lm?=
 =?utf-8?B?Z20xaW9laUdrb1R3TmJHK09kRGVBVHdzak9qWUxwWlNoeG5FUXJHcUVJR3No?=
 =?utf-8?B?WUdvLzg5M1hJV0JyTmdaeUtUa0dCNm9GRmpDWXlRbG9yb1N4TS9lZURmV0Nt?=
 =?utf-8?B?UXVRdHk1V296QjRmNE9kanI4WXA4WmlGZ3cwRklNK1hCa1RsdVYvY1o2bTZF?=
 =?utf-8?B?T1YxeFg2bzZRMUo5cXhjZkF3SngzcEFrbVFWUm1EMktXTEZweVl4aEtvdUNz?=
 =?utf-8?B?NGVGeHhya3EvZHR5WnRrZytsSGhWWEdjWWp3OFdmT2ptME5aSjl0dUxiaWNO?=
 =?utf-8?B?a1VMT0dWMlR0QVBsWVR4Y1ZaUEJGSDYrY1J5RGVjOFp4NE5YQTVEckRMVmVq?=
 =?utf-8?B?YzEzSUhZYlE4dTByR3RvdEtGdTlERy9WUUVTZ3VhQzVGOHpPRXZFVVR0dUdB?=
 =?utf-8?B?eUxrSkVJcnRpY0xueGtUV3dEdmR0U3pNM3pBODhaVmNGNkRSUGhvaEZnYkJp?=
 =?utf-8?B?Y29NTG1LRi9IaWJjVkx1RUxENG05WVZEbGNkcHJvSTZkODhRamEzNVZ1ekw1?=
 =?utf-8?B?Z09SNGEyL2xLTHFia1hlakdQb0dUZ0M3bS91aUVEMnFKQjhCZngveG5kR1ha?=
 =?utf-8?B?QWpCbHYxaDdUdTBucmw5TnpLT0JMTXpuNzc3d1RlTFdFOFZWeng4VVc0SFZ2?=
 =?utf-8?B?NE82TDNzNDdpMVZyenNNc1owREZ3Y05oRXJvVFpqZlR6dVZFZTBwbTdmWnVn?=
 =?utf-8?B?bWtrTk8vbisrMmRNQnQzRjVjcmp1WmRLS2dSUm5uSjA3Wi9aZUtROXpGQzdG?=
 =?utf-8?B?c1NnOHoyQVgwUFc4YVdMaE8rQzlTSnRsSGNNeW1LQTFXbStqNmtJYUVJcm0z?=
 =?utf-8?B?OUs5QlltRVNvM2dtYmJHTnNIUzY4TUQ4STN6Sy9XckxDZG4xM1E4b3F4Mmx0?=
 =?utf-8?B?MnNxMlF1ZTFSbm1GUDVCVDY3cmdUTXp0cGpWSkc4dGhSKzJZalllYUFqQVZU?=
 =?utf-8?B?TFJyY0JIcnY3MEx1R0JXcmM5ZmdSd1MrR29IVmpHVVVNdXlhbWs4aklyN2Fm?=
 =?utf-8?B?K2IzVWJ6ZEJORm5jeE02WkdOSlFlaFAvWGhOYzhrcm15Q3lCamZpNEhFM0JB?=
 =?utf-8?B?T2dLZXRnbUxhaENkbjUvMW0zTG45VGh1VUE1TUdoaWtWSUd4aGRxVDhYT2Va?=
 =?utf-8?B?NC9XL3RLRUVFczRFeENJbkxMOERXSno4cmhsZnE1Wko4U2t5MGkwVzhnaytQ?=
 =?utf-8?Q?olHjna?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:14:18.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3370297-bf2e-432f-5bc2-08dde9f05514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
Received-SPF: permerror client-ip=2a01:111:f403:200a::61b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On 00:19 Fri 29 Aug     , Philippe Mathieu-Daudé wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On 22/8/25 17:15, Luc Michel wrote:
> > Refactor the SDHCI controllers creation using the VersalMap structure.
> > 
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> > ---
> >   include/hw/arm/xlnx-versal.h |  5 +-
> >   hw/arm/xlnx-versal-virt.c    | 43 ++--------------
> >   hw/arm/xlnx-versal.c         | 96 ++++++++++++++++++++++++++++--------
> >   3 files changed, 83 insertions(+), 61 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> > +void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
> > +{
> > +    DeviceState *sdhci, *card;
> > +
> > +    sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
> > +
> > +    if (sdhci == NULL) {
> 
> Can that happen?

If sd_idx is out-of-range. It should not if the SoC user correctly use
the interface (querying the number of SDHCI controllers using
versal_get_num_sdhci()). I agree I could have put a g_assert() or report
an error.

Luc

> 
> > +        return;
> > +    }
> > +
> > +    card = qdev_new(TYPE_SD_CARD);
> > +    object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
> > +    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
> > +    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
> > +                           &error_fatal);
> > +}
> 

-- 

