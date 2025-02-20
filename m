Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721B3C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1x4-0003tL-Cz; Thu, 20 Feb 2025 03:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1x3-0003t4-5a; Thu, 20 Feb 2025 03:30:33 -0500
Received: from mail-dm3nam02on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2405::602]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1x0-0001Sl-Fg; Thu, 20 Feb 2025 03:30:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEW7InKDovX2uYzNc8/ssN1EZ73vHaRLy3aDlb8rBLD2WrNqwkL0S6fh9tMPra0FEfJXLLwOs6NvKH0I0vkeETbQ75goTbwxixOr1Jt1cLAXqABiocT0c8HMIJ+gv0h3olVXDTV9nxoaNGTep4z7fBi+gf98UKUOAkqvP2mbbBh2HyWZO+idMlLUMIvodHMFfWxgMkFfSl6DH1blYzhoBQ1OpRDwoPMKabP+oM86OkQX82+A56bssHVDQOD2PvZvywaD9podD3CRH1UGO1iW9ERD4fp/fF9RG9guyFKBPESAWaweyP9rHAkl8Xb6kfll62XEtBc6IezC/IiMJRlBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkJVdxt9x9eBCUlPGsnVDOoQgMqGQOKQ7tfmKg/BX8A=;
 b=NFvQzOuDTNdlPDaPVU6x84n1/eWqmuqdAKU1hgy0ueYZp5nIUt42xkBz+PLfEhIIm87zIZa0pjEyLJV8C/vmc+EcRAF41L5WiFif5TpISoifLOLxeLuwO7Z6ZPLbFo2txhABGLTKUYsCBZOPbipq3McGPdxpN8B6SmuM6+KQgXlMsKlkam+BtKXNHbAeohQ/03+q/uWYnRxM7xDmm6JTjLalGro7jIew+XCYJ1JMYP3Bg0pSbYeWD5pSwIW5RPE3YOBeS2ziaaTT0BS5c+8XewEAvR1IPNyoTVEpb5B1hKJCMWNr7K8LS59EF+pw8mo9sq/LxmupJT1K6SggaH3u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkJVdxt9x9eBCUlPGsnVDOoQgMqGQOKQ7tfmKg/BX8A=;
 b=NGCMkVGDkNLs5awz9R7W7zzYX1EFg4lllKWM6TnY1D3IZgJCcMMLB1NdBG+bKo/aSB/rL8w1TSjrtHKBJwj6quHxIdLzPAcnn2wax9a86gnJ8LDr717a+PURnyRDMZzKHvtyhstEqrVoziti1FsTazCXei+j/SJ7rPdQLr7dyBg=
Received: from MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::20)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 08:30:21 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::7e) by MW4P220CA0015.outlook.office365.com
 (2603:10b6:303:115::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Thu,
 20 Feb 2025 08:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 08:30:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:30:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:30:18 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 02:30:16 -0600
Date: Thu, 20 Feb 2025 09:30:15 +0100
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
Subject: Re: [PATCH 9/9] hw/char/sh_serial: Return correct number of empty RX
 FIFO elements
Message-ID: <Z7boF2m2KsayLsJw@XFR-LUMICHEL-L2.amd.com>
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219210841.94797-10-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: e0060e53-d772-45b5-fff9-08dd5188cfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmNHR2dsNnFWa3hKWHU0RHMyNUZieEVzbnJNblcrN0hzdXo3MVFBQkNrS0cz?=
 =?utf-8?B?ak9ucXZOWlQvUGRkSVJjQ2VxNS81cWdJKzgxeDdLajdpZFp3M2JVWjV0MHRM?=
 =?utf-8?B?YlQrTkE2L1ExVXMyazhuSm1PbzJqUVlZVWt4L3pXd0IwM3dNelhZUFY3ZmZ5?=
 =?utf-8?B?QUxOazhtakZkV1BvbytUbUR0YVlWdy9zZ2MvSFloMTNNZXZlQkZFcXdCWEdv?=
 =?utf-8?B?dWsxTkk3b2JkOGdUZml5Tm5kL2QrQVBzRDNUSi9kN21HQzJJQkVOREx4YTRh?=
 =?utf-8?B?RXcvS3JxUEpJYmRLZFduTlVnS0xSNnRhRWw3cGJRWXJaQUtVQTllbitpM0lF?=
 =?utf-8?B?RUREamd6bG03NXVRS2IzQWE5bGhkNElQNTB2RjV2SjNYUTVMSWNwZitJa09Z?=
 =?utf-8?B?SjAwMlFUUXZlVXRuUmJCd0VoTDRnbm8veFFBVW92VzlLekt4VkxvTXJGeVla?=
 =?utf-8?B?WnVwR1Y4VlFMOHlzem5jbzhqemYwMkJFQVpQSlA0bTFYMlRLVlpESTg3SUMr?=
 =?utf-8?B?c1p6S0haVHRnb015NHgxZm5mUlRGZGdiY2ovTFloOWJ3V3NuWnM4TXROdlVi?=
 =?utf-8?B?dVRkVlBsUnl2Sm9VdzBIeVhCb0pDVFY1NnFtMmhLdkF6eEpnTTJZR05teHJ5?=
 =?utf-8?B?dkJFMDhMQWRUR3ZBcTlLbVJOeDdWYXlKN0JSUDdiYXpGcm9CQVpqTjBqb1lL?=
 =?utf-8?B?Qy9rMzduZmpURDdlRGZkb1hVVXJnUXhXSWllSm56dCt6UDRNTERocVRkVWxs?=
 =?utf-8?B?Y0E5MURPQ1B6QVROVWtQYkk2bjJwUWFqYWxrK0FwKzdzdVliK3ZhcEswS3VJ?=
 =?utf-8?B?Ky80cERUd3NIS0paTWFEaWd5V3dPN21SUklPTm1hbGM2ODVmMEw2TGd2cDN2?=
 =?utf-8?B?SlhQK3FEU1Z5c1ZjMmtKNm55eDc0YWdwTndnOS9hMTVzdGYyN2lmdUNBSWRj?=
 =?utf-8?B?a3cxVFk3M3lTWFpkcVhXK1J1WmNLZ0pNa0FuMTRheERNTDdMN2MyZ1BHNU0y?=
 =?utf-8?B?cWRQY0Y2ZFpOQy9OK3k4SzkyNU8wZmxZY0M1TDVUbGdsSWNYSDk2Zk1NcDY0?=
 =?utf-8?B?bk02Zm56Q2ZYU0w5bDV5emg2R1BjVm13V3ZFMXRQWmMvQkZaRzBRZm9MR3VC?=
 =?utf-8?B?TVY5Skx2MnlPNy85VFhQY2VDTTZnekpRMCt6dkNHOUlEbjNqcjM4Ylo4Q1RH?=
 =?utf-8?B?K3VvanlWTVM4bzd6U01ld1RGRFJJYTNDdUZpYVp6c01PUlNVRnJKYU1OeWJU?=
 =?utf-8?B?b2NwWHltbmpab0ZtU1VTNm9SZGxPQVNtTyt2cFVuSW0yNXN0VEliMTNRc2Nx?=
 =?utf-8?B?Q3hUQ1VPL1VWa282bGsyMVdjcDZVcVRBVk0xMkc4eG83WmUzM1pyL29WZVlw?=
 =?utf-8?B?amM3WEtmdTBYQ2dxeExYMjNWamRWd24zOUJSTDl1NHMrSStGRjlpckgweTJI?=
 =?utf-8?B?dngrLzR5K05hSDJrNHhCaGsyNDZucGRzdUMyMFJNeGRhc1JZaHBVbmkvZnJ3?=
 =?utf-8?B?RFFxTm5tcTVJSDF2Z1A4NlBQUVk1YnhjaE4vSzR0eUF6R1JXVGJ6UUEwTzRK?=
 =?utf-8?B?WDV4by9Mc21kVy9RSHFzcldMakpObmlndEliYXhlaVBRVWRpc0lpcWxGRkdT?=
 =?utf-8?B?VWdmV25ra2gveVBiYjFoTkhrSVM3VW1zYkRBNGg4dHUwL1hzaWZZRGFVSXBp?=
 =?utf-8?B?RlVyM1RRSy85R1BOTldBc3lTZ3NjYjF3c05rZ3ZYcTJiRDYvZEhJTGdNcXNO?=
 =?utf-8?B?UWtXVHNiK0VicUl2aVFaR0VPU0pRNGIwYjNiNW1XbHpiMUhSMXBGYTR2eVVu?=
 =?utf-8?B?dWNackc0Vmw4cXoxZVJZcnh4dkNVQ29CMFdNVE82NWpaS2tjNTdvVVBxbjhu?=
 =?utf-8?B?ZVVUOFYwaTNveEJPRGE2MFFjWmdFZGp0dDJuMlExVnMwcW5Od3JLb2lqQ3Zo?=
 =?utf-8?B?UUdhN0xkQndxWG03dFQ4TzltaW8wRkcrOG1yK3F6ODBqUzRYak1pY2RxUk4y?=
 =?utf-8?Q?S2OJH0aqjO2CwRaQQFW30ZjrXpeflg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:30:19.9685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0060e53-d772-45b5-fff9-08dd5188cfdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
Received-SPF: permerror client-ip=2a01:111:f403:2405::602;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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
> In the IOCanReadHandler sh_serial_can_receive(), if the Serial
> Control Register 'Receive Enable' bit is set (bit 4), then we
> returns a size of (1 << 4) which happens to be equal to 16,
return

> so effectively SH_RX_FIFO_LENGTH.
> 
> The IOReadHandler, sh_serial_receive1() takes care to receive
> multiple chars, but if the FIFO is partly filled, we only process
> the number of free slots in the FIFO, discarding the other chars!
> 
> Fix by returning how many elements the FIFO can queue in the
> IOCanReadHandler, so we don't have to process more than that in
> the IOReadHandler, thus not discarding anything.
> 
> Remove the now unnecessary check on 's->rx_cnt < SH_RX_FIFO_LENGTH'
> in IOReadHandler, reducing the block indentation.
> 
> Fixes: 63242a007a1 ("SH4: Serial controller improvement")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

nice one :)
Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/char/sh_serial.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 247aeb071ac..41c8175a638 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -320,7 +320,7 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
> 
>  static int sh_serial_can_receive(SHSerialState *s)
>  {
> -    return s->scr & (1 << 4);
> +    return s->scr & (1 << 4) ? SH_RX_FIFO_LENGTH - s->rx_head : 0;
>  }
> 
>  static void sh_serial_receive_break(SHSerialState *s)
> @@ -353,22 +353,20 @@ static void sh_serial_receive1(void *opaque, const uint8_t *buf, int size)
>      if (s->feat & SH_SERIAL_FEAT_SCIF) {
>          int i;
>          for (i = 0; i < size; i++) {
> -            if (s->rx_cnt < SH_RX_FIFO_LENGTH) {
> -                s->rx_fifo[s->rx_head++] = buf[i];
> -                if (s->rx_head == SH_RX_FIFO_LENGTH) {
> -                    s->rx_head = 0;
> -                }
> -                s->rx_cnt++;
> -                if (s->rx_cnt >= s->rtrg) {
> -                    s->flags |= SH_SERIAL_FLAG_RDF;
> -                    if (s->scr & (1 << 6) && s->rxi) {
> -                        timer_del(&s->fifo_timeout_timer);
> -                        qemu_set_irq(s->rxi, 1);
> -                    }
> -                } else {
> -                    timer_mod(&s->fifo_timeout_timer,
> -                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
> +            s->rx_fifo[s->rx_head++] = buf[i];
> +            if (s->rx_head == SH_RX_FIFO_LENGTH) {
> +                s->rx_head = 0;
> +            }
> +            s->rx_cnt++;
> +            if (s->rx_cnt >= s->rtrg) {
> +                s->flags |= SH_SERIAL_FLAG_RDF;
> +                if (s->scr & (1 << 6) && s->rxi) {
> +                    timer_del(&s->fifo_timeout_timer);
> +                    qemu_set_irq(s->rxi, 1);
>                  }
> +            } else {
> +                timer_mod(&s->fifo_timeout_timer,
> +                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
>              }
>          }
>      } else {
> --
> 2.47.1
> 

-- 

