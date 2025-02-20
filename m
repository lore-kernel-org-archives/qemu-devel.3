Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF588C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1tj-0001mi-TK; Thu, 20 Feb 2025 03:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1ti-0001mQ-1d; Thu, 20 Feb 2025 03:27:06 -0500
Received: from mail-dm6nam10on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2413::617]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1tg-0000eH-4A; Thu, 20 Feb 2025 03:27:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM8YvW9C/OuSmn40xrVH/LvXB7u13qYYZZT4XwDzYr2YnB/EUCle54URGrnF9K/69jKoh5dphFPH1dxok4OWLeTIYwPunf9pLghwH2Bdq76T4xbWOMSk+dQr6lNxRef5/zvc8deRArlDRvvpfpUmTsuk4JuasOuhdGQKgLrQfwcddXtxE7y3SuKLyME1YHHVj7c4mDJHTQaQs1jsJzJg+04r0+az27j6LnK+KciNfjWL3I1b4U+7jdMELA11tI5K/lAyje1XHL64Igh2Ww+hEW6MfXtf+tXhSA67rxfPtFoaYFxyaajEgsHGyipTizUJ6KV/B0Q71/fX4rJA/CxrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta7V6gqRwreNtqZqvkeavRTeSB8C4bBE+/fRJtFIyVU=;
 b=SMNzTiwpmeYPJ1Eyzf390muorgUnHoWKNDdO1jY3PhmJ/LZVzFCSkjQl3RfNOaeDMOf3BEGAWayvV+wHild6v/gB/17qVDGR67QK7ejTRlni4KVs//QxER1m2fIdCcHpQJ5463QHZW8PUlpM+apx9Lmi4WYxq+QN6L09/SVRGUTvy2pq69bKC8ianjG+1pjnpnCw0sdWbKT1ltRsbAQy+6yDpjd8WJuf//wWSMZJLblibIjSkA8khyOHuumXbITuVe2aBsjyRRhGQp30PUji6bzw5XDF6HwBUMx6DCWcuRL4wRcJJ3Oq3FRV/f4dVEoWKYeW7PlbZ/o0ojeQZeTY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta7V6gqRwreNtqZqvkeavRTeSB8C4bBE+/fRJtFIyVU=;
 b=n+Eu5M49AioBS+inuO0INsdcBdoT42o+ajM9NA4phCFXQx8pqkhKuE3NayzXmZkCNCbHsnHIrOyylBoagLnCS6RaookeOhuTnz1iiOWXkVDCxt3/eAXpEbQZHkbZb7h1k67e2qu/o3P2u7EU8ciF/oria77+gCdz2CxHnct16Jo=
Received: from PH3PEPF000040A1.namprd05.prod.outlook.com (2603:10b6:518:1::52)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 08:26:58 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A1.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 08:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:26:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:26:56 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 02:26:54 -0600
Date: Thu, 20 Feb 2025 09:26:48 +0100
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
Subject: Re: [PATCH 8/9] hw/char/mcf_uart: Really use RX FIFO depth
Message-ID: <Z7bnSNJQrY2Lffiu@XFR-LUMICHEL-L2.amd.com>
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219210841.94797-9-philmd@linaro.org>
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 846b1741-40af-4e09-af73-08dd51885737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE9XcngzV0JPOExPMGJQL213bkRJblQ4UFlzeGtHMVhRVG1DRHlTWTM0U2t0?=
 =?utf-8?B?TmNQR0hKT0FRRnhEZllhRXFDMXF2K1JqcVpRVzZ0MkVCYVBKa21DU0pxMUY3?=
 =?utf-8?B?MURXR1lYTExGMm9TL3B3N0FyYW5YRGIxQ2dOVmptT25SRXhyZEtBUmszUkQ0?=
 =?utf-8?B?MHJ3WEQ0WGN6RjdnamhBMEc4OENXcUY1YXA2c2ViVCsyZWQvb2w1VE4vTktM?=
 =?utf-8?B?NWlQbjB4NFVkdys4bVRDMVRuZHlYazNXOTN3M01YTUtrWjdMZVJCODRUV1Qr?=
 =?utf-8?B?bUpEdUlpNFpiWXdtMVMyYnRzejdkZ0Z6WkQvRWMvTU1LVUJqbjhUVTV1WGtZ?=
 =?utf-8?B?UWUzdmVRZE1ReHpGcVRiMDQrMGhUdWZhTGRxQTl2Tnc2QWxPSWxGNnFsTzVF?=
 =?utf-8?B?M3lkSndQMjZlTml4bE5xLzU2bHNpTE4xbXlqS3lKYkRuOWt2cEt3UWw2T0VX?=
 =?utf-8?B?enFSWmRPQVQ2cUxPZEJER0NNOUpMZkxaUSs4ZWo4U1U1QUt3RCtLaitPT1h0?=
 =?utf-8?B?SmplWFUrMmR5Z1pPMjVWUVhrSG1jYmVSK0lnVyt1UXdUazcxSG9tb1NJNmJQ?=
 =?utf-8?B?TDZqeEM1Z1ZpTVAxaTRtR1VsYjV3TlZuSEdQVHdaMi9kcmM4cXR2eis5N1dm?=
 =?utf-8?B?NUZrSjcyMkNrL0hqSTNhWS9qdE5iS3ErQ2VkdGQrdnQwQmRiUzJjMlF3Z1Zu?=
 =?utf-8?B?RVR6SjV2N3hGMDBPUk9jSEh2cEFiSTBCUGUwSjB6T0trcWtTT0J6VDU0NDN5?=
 =?utf-8?B?d3FCSU9OY05nVmVyOTlVL2YxN1VTdDRCUlZ2clQrQWJ1dytoeW9oSmZUSU95?=
 =?utf-8?B?Mmd3amcrRjFNS05RVlRja21Zak5CdmdobHhmWEpHSGU2NVV4OHphTEF1aEhq?=
 =?utf-8?B?RFpKOW9oRnN1b2kzdDBWbkV1YUhCbjlISXRZUVM3Qmh2Q0d6TXloUTR4U0p3?=
 =?utf-8?B?M2dscjFvTEs4OW5nbWszQnhxU2VVeWEwMWpsMlhJV1pENTkycGxqMDJZU0lG?=
 =?utf-8?B?ZFJTekNUVmEwRlFqdGZRV0k1em1CMTE5VURWOEwrdy9nWHVpV2ZQMzNhREVx?=
 =?utf-8?B?S1MwMlVhV0s5MElzeFhNYVR3L0RrZTlUcWNMdzdYK3M1c0U2a0FsNiswMFNj?=
 =?utf-8?B?blRBdjdtYUJlQWdubnFES2VFaFUyODhWK2JjWWJGeWdkTCt4Z0NoVFY2dy81?=
 =?utf-8?B?bC9uaE9GQmNENCtMc3ZaVUNiZ1dQV3RNZUNIN3ZMRnBhUTQ0WUppOTRDS0Ez?=
 =?utf-8?B?Qy9BNUtmWUxYK25aenhVUG9ZcFNPVmF2WlFabUhjSU5GOUgzK1Y1aWNIR25y?=
 =?utf-8?B?djVRaVV0NmxkMjBTU0JFRkEvUWtMM1hyVHVWeGRVUEpIRGNZYXZwRHZXc0k2?=
 =?utf-8?B?c0xGSzRBSzRlS1NOZTNEdHpBcHR6VHZRYmVJYzVNRzBubDBJeGlWbkI0Nlly?=
 =?utf-8?B?TDh5ZkY5dEFMb1hDczByb2dReUhpTHlFdDIwQXVIQTNSWm93R2RVb0lVWmo3?=
 =?utf-8?B?Q2RQYTBUUFZMekpFa1hFTUNqSnZ0cEt5bnE3RnNjVmdnYmlva3FxcE5vbUV2?=
 =?utf-8?B?RGwvWDhDcFpFT2d0U2pSZENsZkJxZFZpWGd1aXRQdHNxalRyWjgvYVdUM1Y0?=
 =?utf-8?B?aTZMTUg0cmtxNkh2M3A4elI4akNsSGszamIzSnhON3BPdzdiV0FiclJvSUxV?=
 =?utf-8?B?VVpLZDFTbG8yRnRCTTlWM0RkUjR1cXpNVHBmRG9kWS9wRno3MGxvaFplVU83?=
 =?utf-8?B?UlhySzZxWVRPUEV6bTBBQU1ZMkppOFB1WllzQUlRdmk1WkZlUC9vKy9TK1NU?=
 =?utf-8?B?S29oRkhsYWwwZTVmQ05XQm5BOUJYUzVIdFNZSUVtWUlDcGdYTkxJbmM0dERv?=
 =?utf-8?B?RG1MWXpCTlBnZnFvTnBkQXpBZnNBdDdOL09ZRENZVTFBZ3FXd0hLbjhBQ3Nk?=
 =?utf-8?B?b1dWMThaMll3d0djRWpxaEdwQmpJK2ZZRnkxZmRqa3dIOXBJeElXa2tla0c2?=
 =?utf-8?Q?JMLYn0LmBjZWAmVrh8o/keQ4mynh1k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:26:57.5585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846b1741-40af-4e09-af73-08dd51885737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
Received-SPF: permerror client-ip=2a01:111:f403:2413::617;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> While we model a 4-elements RX FIFO since the PL011 model
> was introduced in commit 20dcee94833 ("MCF5208 emulation"),
> we only read 1 char at a time!

"the MCF UART model"

Reviewed-by: Luc Michel <luc.michel@amd.com>

> 
> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/char/mcf_uart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index 95f269ee9b7..529c26be93a 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -281,14 +281,16 @@ static int mcf_uart_can_receive(void *opaque)
>  {
>      mcf_uart_state *s = (mcf_uart_state *)opaque;
> 
> -    return s->rx_enabled && (s->sr & MCF_UART_FFULL) == 0;
> +    return s->rx_enabled ? FIFO_DEPTH - s->fifo_len : 0;
>  }
> 
>  static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
>  {
>      mcf_uart_state *s = (mcf_uart_state *)opaque;
> 
> -    mcf_uart_push_byte(s, buf[0]);
> +    for (int i = 0; i < size; i++) {
> +        mcf_uart_push_byte(s, buf[i]);
> +    }
>  }
> 
>  static const MemoryRegionOps mcf_uart_ops = {
> --
> 2.47.1
> 

-- 

