Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825EBC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1oP-0007DM-4x; Thu, 20 Feb 2025 03:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1oN-0007Cu-If; Thu, 20 Feb 2025 03:21:35 -0500
Received: from mail-bn8nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2414::629]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1oL-0008B9-3l; Thu, 20 Feb 2025 03:21:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3GQY7JKH0Befg5az3J+8nZ7gx296A8SI5GL885cNLpgYoJXku5uroGNQd3BINbMCzg994b7wibQyImHYob4xbJefuiScNWXMucRtEOSY2lxsnlr5Arr8XpYouZQLLGJJ2MRr2bAsuEsnkKbswl5sGMwa6osvhpJ4U95O9SeN8BtBvW0e/h/VoTz9TW0Eo5cizwXwcVgo2pP7gTOXq14MNkqIyS2R6i8nFgAKly5bORneCVElTTiVwssKsi/Ngu2+IaDUl8bL1+OCxlCY4vwGXFAZ/tVO73WPnYSJ1svv8sLajdNCOEGLrwC8qS1dilDjxdOExJ2EVgw/XnuWOf8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwQuZmY1WhrO+ScNAcw91nkeQJVmwxpl7uySFAJ0FuI=;
 b=hxQ0KqiX50fL8+1o0gLy/a9A57w16xfvv+sVSmdtvN7GCjWFs5huUBjCYABRKVMnUVJ89Nt1WKkbR2y6X4V9SLjhImK2LVtJB1vmTPm8bYImuXpQ0XsVIl/eKIHvtxoExxVKknOjsGcNO6gWVIWOK8MPwgLDsHdXRPyh2t3luljPyjVntqjNeoZwg5AMnamEnKXsQllECLMrxLPlCsMYjN9jyRcZPk+2eapSi0B/FuoovHo75y3suO9EZc3sU9ZRuOWUowdzNkrrzv3gyUJ1fzOpMyMmYcJzM+tEsacWIg2urGKMYcj9T0ltper/1TtV9Vu22jBq5FA/LuLypV95ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwQuZmY1WhrO+ScNAcw91nkeQJVmwxpl7uySFAJ0FuI=;
 b=Wxz3wmaNG8g6iJwHjiD9hf8rGTpV8jHiX6ZW646IPasRBz2VTvUTCKxMZQfJGy0k4dgVEJIepBaHq/hifRv6KGXTO7hFGXhrXIF6nz/XuTZkjTbvOsy/V7EbsutFz7dX6XQY9o+O9c6KZnPbXOUbLtCalmMEKOZxqdVC/hSWYcM=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 08:21:27 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::97) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 08:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:21:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:21:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:21:25 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 02:21:23 -0600
Date: Thu, 20 Feb 2025 09:21:22 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 <qemu-devel@nongnu.org>, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Magnus Damm
 <magnus.damm@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth
 <huth@tuxfamily.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 5/9] hw/char/bcm2835_aux: Really use RX FIFO depth
Message-ID: <Z7bmAqE4z2y_kNse@XFR-LUMICHEL-L2.amd.com>
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219210841.94797-6-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 97062dae-01af-4e53-008c-08dd5187922e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGd1ZkU2YmJUcE9YMEZrTHQ2YitrMVBzeUpoMGxsanpvS0VWem1yb25zNzBY?=
 =?utf-8?B?Z0NMZFM4akkzSDduN1oxanVMcE9iakZaWUZJZVo4TDBzZXc4WDd0d1BrWm9l?=
 =?utf-8?B?L3Rxb2dnTDFPcTAyMzlZN2E4KzdDcG1hZFNhMDhJOFlOUEtDUHFOZVpOS204?=
 =?utf-8?B?YXVIUmt1SGs1T1hnUG1ZZFp0QllyNkhsSnpSeVpZakJCa1hXUm5MZllSNnVt?=
 =?utf-8?B?VnY5eVpsdFBpMmNwM1JRelVoNGVxS0h3SjhYWFlVbWhJMC9Xb0h0Y08rZXpT?=
 =?utf-8?B?SVNrVjc1RjJLeDA0U2pRN0Y3aUcyRWl3K0dZQzNGQ2srVmIvVDlyNmlzcGVJ?=
 =?utf-8?B?N1FGRU03OU9oT2ZINE5yNUtoMDR2VFpwUldYekFBRUE0alEvQ0FMVEdma1hF?=
 =?utf-8?B?cHJiK0lESEhla1NsQ2Y4UUxKYmZqcm9VTWlCRHQ0N0J2bTU1dWRRdTNqRzV5?=
 =?utf-8?B?WVh3SU1OU3ZBMFl0blM2RzBpSWd1MmUrOUp2MXYwdjIxRStoUW5saHVUbEFt?=
 =?utf-8?B?Tkw1WDFZT3c2Rmp4OWRxMzZHMHUyUzAxVEk0ekFRalU0L1FNQmplc0YzQWlr?=
 =?utf-8?B?SkhCbWphVENmbTZmcW1QQkJZcFBrazE2MXZCVERBSllWckJoa3VuajFHcWxk?=
 =?utf-8?B?SHFrS05GM3F4d1k0bzE2NmN4WnZJL3Njb1QydVZsWlF4ZStYMm10OGcxN0V0?=
 =?utf-8?B?ZFRZTGhtV1JLV3pzRThRcmpITWpZcU1Qc080STNwNE4rL1hvUUN5REh0QkdT?=
 =?utf-8?B?YzlFTFAwc0tpZDFiZ01pcTJzM25GT2hod29YTnBHa0U1OVpQVFVrV1hIMWF3?=
 =?utf-8?B?R00wWS8zUWpKbFo2ejVsWFdKY1d2VTc1eHVSRkRCd2xwVVVGSXJFQ3BGMXBy?=
 =?utf-8?B?aWVmaDRqWHRkbmtpVmd1UndNYXhkOEt2T1MvNk1QeEJidTU3NmVVajczdXN4?=
 =?utf-8?B?dVk5MGZ2bllHR0JndFVoR205aHhmR3JDZnNFTllWek9FcXJHZjNYWTdRYUVu?=
 =?utf-8?B?VlBHb2FlN04waWtKalFKR0dDVlVxajNIS3RBMmR0bkFDWWU1VjI0VDZZTFRJ?=
 =?utf-8?B?cC80VDdzL293Nkp0RHAxc21oRlkybnJ0ZGdMZjZnd0IrNVFDVWJucHhHUE13?=
 =?utf-8?B?amRzSGo4RXJBTW1LM0tRTFpWbWFhOTh0YWVwVkViczJ2b0IxV1h3Yi94NnF5?=
 =?utf-8?B?ZUY3NEkrS2p6VVpzVUNaYzMxc1dxUHlSNEdBN0U1cFkrS3YxTGE3WEtEcHE5?=
 =?utf-8?B?b2ZHcWRJQXFCR0FSckJZQUg2TUF0Y3NPNG9VWExCNk9oNnViSmVtRHhXMjUv?=
 =?utf-8?B?dTZlSEs0dFZzYnllcEt6Q2dKVnJHd0JaSEhBcTdzOW8xRzFrQ2lUTEdNUVV6?=
 =?utf-8?B?V0FDTzNBUnBDZUhETmtNbmxSR0hkRCtYNGUzeE9UaTMvNUJGM1RaZFZZS3ZQ?=
 =?utf-8?B?NDVVenVPZzNzcFF1M1FsVndmcUxObFRyMk93Z3NzSklZVnlDaUxDWDE0RFFk?=
 =?utf-8?B?UkI1c3dLZGxsUGU1YU1udVdRSHppTTNGZlp1cUdSbjJGYzJjcWNsdzdkcjY1?=
 =?utf-8?B?d0xZem5MRko5QXFvalhBelVxRWxaalcvazB1N3ZxZ1lDZ0duSllZaTVWVkpE?=
 =?utf-8?B?ZHY2VkVMTStoMk9FMWZHbHE3cUNCekczSXhNNCtRUHYyV05xR1ZwS1ZEN0dN?=
 =?utf-8?B?SnFybWp6V3FhY2NyOVNjb2YxeDFEUXBTRVMyV2d2SGdqN1czazFBdTNVWWh2?=
 =?utf-8?B?WFZOVnZQSlNzSDFJUURaNkhDV1VvejIvb0hLUWZialZ2RDY4anNFbGV5akdQ?=
 =?utf-8?B?OXNPSnZEdDMrbXBIcDNnbDJLWXRlUisxYTBrb1lPVHpMNHd0L0lTbE1za0xG?=
 =?utf-8?B?cnhTVUNJZHJ5dyt1SytxTVlaaHRIT1k2bkcrWUhvd0s1R2dGeVlDQldmUW1G?=
 =?utf-8?B?dW5mRytDQzlJeW10QVp1N1o1T3puTmNPcWhZT3YrbWI1R09aSzduMDFISXdj?=
 =?utf-8?Q?aiPZJDf/IxM2CEGq/8VTcDdgO0swiU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:21:26.9839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97062dae-01af-4e53-008c-08dd5187922e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
Received-SPF: permerror client-ip=2a01:111:f403:2414::629;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

On 22:08 Wed 19 Feb     , Philippe Mathieu-Daudé wrote:
> While we model a 8-elements RX FIFO since the PL011 model was
> introduced in commit 97398d900ca ("bcm2835_aux: add emulation
> of BCM2835 AUX block") we only read 1 char at a time!

I'm not sure I get why in this patch and the subsequent ones you keep
mentioning the PL011 model while you modify other UARTs. I guess you
mean "the BCM2835 AUX model" here?

In any case:

Reviewed-by: Luc Michel <luc.michel@amd.com>

> 
> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/char/bcm2835_aux.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index 73ad5934067..c6e7eccf7dd 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -221,7 +221,7 @@ static int bcm2835_aux_can_receive(void *opaque)
>  {
>      BCM2835AuxState *s = opaque;
> 
> -    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
> +    return BCM2835_AUX_RX_FIFO_LEN - s->read_count;
>  }
> 
>  static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
> @@ -243,7 +243,9 @@ static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
> 
>  static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
>  {
> -    bcm2835_aux_put_fifo(opaque, *buf);
> +    for (int i = 0; i < size; i++) {
> +        bcm2835_aux_put_fifo(opaque, buf[i]);
> +    }
>  }
> 
>  static const MemoryRegionOps bcm2835_aux_ops = {
> --
> 2.47.1
> 

-- 

