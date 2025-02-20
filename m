Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97DFC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1rY-0000Hi-G5; Thu, 20 Feb 2025 03:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1rS-0000Gf-6t; Thu, 20 Feb 2025 03:24:47 -0500
Received: from mail-dm3nam02on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2405::603]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1rO-00008u-V3; Thu, 20 Feb 2025 03:24:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdbEQ9OQebtxOkaRzYRN/n991UDdkT6FQ3AoL5Jvjtg5PEfgw76mwnEtKhwNAE5o/o2eyu97Qh9HgfNxUV+P5v83gv9MO/3DSCTN2Y6MbaZwietSSjAn6BOv12wswwegj3Hf1Nl01vneokoCP4MPG5uz2mD4Nx4ofkHwt1y6J7cCaggPKL3+dBha3PoJNA3WmleVUv4hEnHBjmXBMB8dTyBelQQH9sgleMcmwkcvrvQEe8ky/C4XHYzlxm4TkPql44+vI0NEyh+Vup5yc9vNF3Aqv+vWfQjVzRTS+kNsi1loYmnfk9XwsEVHaXF1viavlCZTnoHl+KVsgyoUN8pP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvrISlHYHxzrNPGqs14HRBEi4tmzubxjCuElFTH8sJ0=;
 b=eOPCXfg+/zayG+exlkGEedqf8piIxaECHmt/ugC3x5NpR6k9LsmcwO1lwW4Z2AWttijiit9HjimCHz8fdbKORt2DwHsjxX5xlb668vjvTD4tu/Ay3p8S7isoY/e1GdRpJGL2jwPRhTCxyOktNp85mO973SwcvFHVo0RzajJak7/sFaSJgFna6zl7fv0K6L8VhSLKW6BGSADYSnWUubqhHi9CaQeOyKx37hvIOSP4B8tS+tI4ndKoSaozoiON4QNtmvqWqFf/tp7tN6sjde/N7nCh56tcTpWRQuleRlZTQOG4rMwU5wJXLDzcY12qQ9YA34nSexRzCwBYptmFK88gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvrISlHYHxzrNPGqs14HRBEi4tmzubxjCuElFTH8sJ0=;
 b=B5/N6V5jVXoRK+I4VWVxx4Zij54X4+uis0QfENth9QnA6EgMB3uLVVGjCZyK44nUJEMavXfTRMjoW9+hDShUHHTtKsIAjRHAhXfKlsmQCj/d3blfnw7tYUCBYgFLQubcPlEbO+EeVVa2MItcirV3cDXj6wumqPP/9v4bAHDZi8c=
Received: from DM6PR02CA0066.namprd02.prod.outlook.com (2603:10b6:5:177::43)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:24:37 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::8a) by DM6PR02CA0066.outlook.office365.com
 (2603:10b6:5:177::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 08:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:24:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:24:35 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:24:35 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 02:24:33 -0600
Date: Thu, 20 Feb 2025 09:24:27 +0100
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
Subject: Re: [PATCH 7/9] hw/char/mcf_uart: Use FIFO_DEPTH definition instead
 of magic values
Message-ID: <Z7bmuy1cURsbjNZF@XFR-LUMICHEL-L2.amd.com>
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219210841.94797-8-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: d46ea832-2b0c-48c6-e185-08dd51880347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmZQUWYyUGN0V3krZnVKS052b1hPb3N5REhhaC9vYk85R3NsSGFyOVFXanFT?=
 =?utf-8?B?aTFxUG5jOEIyUmpEVkg3WHQ0RWI0TXBSSTdUS1dVdVpjOHVZZXJYbGZpMklU?=
 =?utf-8?B?V0ZzakE3elZvdm5HVncwS2FkdXVOVjlKQXpaS0dpSThXSGcyRHNNcStOTEFB?=
 =?utf-8?B?OW1hZHJyOUQxSUhJbXlHZSs0NG1MQWp1YmhDVDF3VzVBczlaT2g5TDZIK3lR?=
 =?utf-8?B?WUlsdGk4TUlaOEkxczFzVElzbUdCVXBRcjBpOE92bWhtSWxPM1d0eHZRZi9I?=
 =?utf-8?B?S2pRcThNdVE5ZVROVXRDTGlac2lJVUpqRnNiTnArSWVXaUtHREZYaXpRbjFY?=
 =?utf-8?B?aHRQOUlsUHFCVDdad0FSbGtISEJHcm5tc2pBcE1uVk1SQ29NSVQwS1k0aEJq?=
 =?utf-8?B?QXZkZy9UK0tuaWtnSFgvOHZ4MGxNNlM2WHh4R2I1ZVBsRmdVT0RvRCtZMEpp?=
 =?utf-8?B?WTN0WjEwbGUzYlJIdm52ZXRDWTNXSHpHaUszMkkwUDVHZ2FiWGtaaDk0VUhJ?=
 =?utf-8?B?cGZNY2lnYjFxKzlzZURmUWMxaTI3SW5Kd1RkVWFYaktEeTlOaEpVUHZxdi9w?=
 =?utf-8?B?czVZV281dlRER2RqMk5HdjRhTVl2a1ZvR2pIWGVrOVNUYlFPZFU3QnlVUEhR?=
 =?utf-8?B?cjJnRlRRK2kxZGx2eE94bGREWkJoandDOUlRdHdWRlplMDF4dHVqbEtUNEtT?=
 =?utf-8?B?b3BwTHh1VEpNM3V6YWVYU0xwVEhFVEJRR0xTL3V3SldtSllBUzBwQm9aaTVN?=
 =?utf-8?B?a3JhUzl2aUFJdW9hSVRGZ2tUWCttbkpoeGR1ajVQUWw5bmxTNmtPOGVndlFH?=
 =?utf-8?B?YllQOTZ2ZlFqSXhCMmloVWtQbDM4eGRtUkZqQlBSb2RxNmNCS0tJaUR4ZHRF?=
 =?utf-8?B?dkc1Rk9VdXVOdHRjZkNTZWZoSkJEalhnQnpVeGJFMlUvRlNhL1dBT2dmWmtO?=
 =?utf-8?B?K21OSmNJMktHNjVmRkwxR3dNK1N4MjlTMFZpM1psc0pib2t2U1VkdUl0eXB5?=
 =?utf-8?B?Tk9YYnc5N21aTmZ6ODVleGpLSHAvaEk2VDQwWkdEWUxoQU4rUjJPVHlaQlFI?=
 =?utf-8?B?RUg3OWdRNlp1ZXg2bDY4YkxkRHB4T0Q0alpZUExaL091eFVWc1NKK0Q1MkVs?=
 =?utf-8?B?Q050dEN1VElJaURIdHZNZXBiVDcwTW5QUXhpbTlQa1Rrd1FJd0xBSWg0NkJS?=
 =?utf-8?B?eUVJaGR1N29wd3lOVytJRDVqbUltODYxN2VlcnY5allnNGhRRUxCYjhxRnI0?=
 =?utf-8?B?em1FMko0M3hYL2g3SVFmdktFNEtyMWE1eW1DdDFnc093K0lYVXhEbnZJLytw?=
 =?utf-8?B?WFZrcnRaSEVKYXdIRFdFbG1CYjJGaXVILzJKVUk4bVhES1czbTFzOVhXbHNj?=
 =?utf-8?B?cmEwcklUcEJtVW9qS21IWmtvejcvcHkxMkc0SkpHWUZ5TW8wSVBsbEs0TmZr?=
 =?utf-8?B?bE5XZE1lUTcyV2hma1BaYUl5cFIwdE8rY3EvRHRGTk5pYzVXT0E5L2w5Q3Iv?=
 =?utf-8?B?R0V3L0RiOHVHanJianczeFdZUTIwN3pXMXpmZjBEaUFURHV6Q0ZPVGhzY3Iz?=
 =?utf-8?B?SEJBZnU1UlJremZkZTBDeVp5WkZtTTkxcTh3TkF3Ty8zZ3lNWFJEVk9UM3JS?=
 =?utf-8?B?M3pDYjZTaDZnVFFQYkZBYm03QVBvZ1ZJVk5OM3dmdWdvL3ErMURVbnlYVVYy?=
 =?utf-8?B?WWpMaWtyVWxMOVlGWHNUOThwYllsU2dFbG5KaXBPSGxNUGJBZmJjcEZ2RFNL?=
 =?utf-8?B?a3VUVlhkbDNvV2xEK1VDdzJIRExuWmthaHRQckd6Vnk2OEUvc2tkUHhqUlV0?=
 =?utf-8?B?RWxVdWQ1MmVtV2d0cWFKTGhOVzMvRG1BbXlHOXJ0aEh5S2h4MjlrMlBSQUp6?=
 =?utf-8?B?ZWp0YmxXS0xma2E1T3c4TVluZERNSzhmcW5wbjQxQy9KRHp6M01kOEQxMld5?=
 =?utf-8?B?K0lXMmxENm10TDl0ODBPVVRvWUFpem5SREZ1M2pYazZUVTBNOHZ6ODZjaXhs?=
 =?utf-8?Q?0UuOcOGg5DCeg2oxvLtdS364yoqcnI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:24:36.7360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46ea832-2b0c-48c6-e185-08dd51880347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
Received-SPF: permerror client-ip=2a01:111:f403:2405::603;
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
> Defines FIFO_DEPTH and use it, fixing coding style.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/char/mcf_uart.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index 980a12fcb7d..95f269ee9b7 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -17,6 +17,8 @@
>  #include "chardev/char-fe.h"
>  #include "qom/object.h"
> 
> +#define FIFO_DEPTH 4
> +
>  struct mcf_uart_state {
>      SysBusDevice parent_obj;
> 
> @@ -27,7 +29,7 @@ struct mcf_uart_state {
>      uint8_t imr;
>      uint8_t bg1;
>      uint8_t bg2;
> -    uint8_t fifo[4];
> +    uint8_t fifo[FIFO_DEPTH];
>      uint8_t tb;
>      int current_mr;
>      int fifo_len;
> @@ -247,14 +249,16 @@ static void mcf_uart_reset(DeviceState *dev)
>  static void mcf_uart_push_byte(mcf_uart_state *s, uint8_t data)
>  {
>      /* Break events overwrite the last byte if the fifo is full.  */
> -    if (s->fifo_len == 4)
> +    if (s->fifo_len == FIFO_DEPTH) {
>          s->fifo_len--;
> +    }
> 
>      s->fifo[s->fifo_len] = data;
>      s->fifo_len++;
>      s->sr |= MCF_UART_RxRDY;
> -    if (s->fifo_len == 4)
> +    if (s->fifo_len == FIFO_DEPTH) {
>          s->sr |= MCF_UART_FFULL;
> +    }
> 
>      mcf_uart_update(s);
>  }
> --
> 2.47.1
> 

-- 

