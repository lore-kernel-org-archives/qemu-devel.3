Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2600C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 20:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whvlD-0000cF-4w; Thu, 09 Jul 2026 16:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whvlB-0000bh-GH; Thu, 09 Jul 2026 16:54:17 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whvl9-0002br-ON; Thu, 09 Jul 2026 16:54:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG8+DVy6Gf1vaMZWXCOdOSTlRHIkZK82iZJOnfnhlV3E0giFI/BhfFdKgED7hc2sdgrf6jH2CfRpwSxrwN4LsOhBQiboLgivqhUoiQTdsaYvdlKIbLbmhixraJGvvZBLceoGi+bStaMU70BbhGjPImdsIkG0NxWX7Hgn83gxdqEt5UywmXxloEThJ5LVf8q/zw+3A5SCjcZiBx/w99UcJ5GvIMsrQTUEBzKHHfQtzdVFvchUkPR/e9wicPzjQNS3mukHv5kd23MNr9REqphTwnGWCkBSCYSl2DdXh4BCANUAxWjL30tb0h3Po730LEcjyU6eJYVV2fe0ZIX/5D355A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rph9F8cw/z19pO0AB0EzGZbZnMgmwpFwYXA0dEB1LoY=;
 b=YXt5+g8lV37RskDCqvR2pwR1Q7wMXKZS0RpJB0zhMLYcHnF2sWYSub1ktiGJqlVzh91DAvJMEcA+wpf+3u/LePM9ZSCMzb9uxJfjE/TOULbGXnRf+8RO3NJ08WCuOeX7ybI4YOkbU80C3yWDhXFhEcrSve/nkMRdJX7DerkGsvnwwM6kgs7aXUGsZEe9VryzhQWsO56vkV8hzXnFUWkm0jRXG0x/JylgBWXk4Pw3ubH8n4aikx0r2ePMBZzOvHmtIY4sZjw+UaN/kGKXAHnaGQqdLfA8fejgZNMjj+3vNh7CaPo264ZTpMzkNJZJ+sZZZ1Xo9YakbX+jN+5gf/zH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rph9F8cw/z19pO0AB0EzGZbZnMgmwpFwYXA0dEB1LoY=;
 b=tJvfdzO6OSaPBV8xhsLyG1+XJTgb4wIcoFnofdn7xC3kDBIkooi/mzJ1c+gOZtcvszR1te0hIkuYlF/YIm3gX0ukgCf1qF7RPllWSJixNLGIiFXs2It2FOYfgdw7buBymi8z3dELko8EhslKp7VrZaTJBJfbL7+nBcyUWxR9ZHYB0h6P3bi7CcidP5/zYl0J+GMPa42/lf83QLX76wO85h4GzTaS7TzKBasXkuXHtK3kTuP/QRuicWFuuwH6eE1sKPstJLJ8HvgXsXldnvfzRYbDBPxf6fSTPtuoNDpQ/SHuZ7Jk9N5lpOMWU9/YKGSNCwO8nkVWt8xjhyShvze7jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB5PR08MB10021.eurprd08.prod.outlook.com (2603:10a6:10:48e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 20:54:09 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:54:07 +0000
Message-ID: <c4508a92-4368-4807-9a4e-9754a1107b92@virtuozzo.com>
Date: Thu, 9 Jul 2026 22:54:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: Peter Xu <peterx@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260610115850.2410566-1-den@openvz.org>
 <20260610115850.2410566-2-den@openvz.org>
 <b87db62f-6c9c-4da5-8382-500adc29b828@oss.qualcomm.com>
 <9cbdce55-83a7-4b43-b3b6-8123d85ab9c8@virtuozzo.com>
 <ak_5zULusWIPrOBH@x1.local>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ak_5zULusWIPrOBH@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0253.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::26) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB5PR08MB10021:EE_
X-MS-Office365-Filtering-Correlation-Id: 24072010-6d4f-4ed4-c883-08deddfc3782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: PdlOzh+Loentl287ZoINejRO//XomU5XPnlsUU5wXBAo3lqZ0vNBTPoqbm6lXOfLFgOvGtD54e5LJVcvo91tWZzn1v6pZcxU/IEBod4YIAmntX2T9AF4xlV0T+4g6ccLkZi449ryhjKZC5qPnPm78GRSJO23Z2lXtho75xkVlOvL8WmQbEIrtFyqhpfZoacEEubiIMMwJ4p+OIGqRXaUc8lSRNBOQFSgbg7FNMElUQoplYA6FX5lXI3a7fgc83l/XmyhYB72objahHpN53p1zJRCzJZ5NNNrHLnGW3CueLq1e0fpVqjf3mVDupXKJrA5Ahi90LXaZ2KYqg/Ozk8rbflFt8MBnGK4cti9a/re2/BRz9JY3nWoIIyXSUWRpp0Gzd5sF6BfV8vqJ4q226+q3XiOUDlPBTjTXAfOhO1nZM0RNJnpDr8nekGbbuL/Q6/Te3YpEdnIFtolPPhhq1tn8jB/XpRhsnsWOX2A0PCFdThT7c+iJxSBkQfgjO0OaZM+V2aTtZuGn+dfK8gniha8GcJDWavv7D8bSauih7BoMb9kgXaTZ5tcouPT2pqzqvyBlNriVJdSZRGnGzeAUWUpRYgbL7/fzWcRBKO1wNLmPeV72eObqbGMoJPlLM5tj/7jSiPXmmrHwQ+MnVkBMSB/OM+TMjmDXUFZCOe4hVFwmcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9PdjlacGt5d1FFNkMvSkhGVFZVaUtYUVdYM3NsbklCK0hrVWUrWDhCTFl3?=
 =?utf-8?B?ZDJHcTkzRzRCRE9rWG1LMHRHT1pzdURYSmtiQW5tYU5iY2NJRFBzWFhEVWJX?=
 =?utf-8?B?LzAwa1NXOUpLVXpMNzRyQWE1WWRDNnR0YXFURS8vV1RFMTJwc3NHV2tMckYy?=
 =?utf-8?B?Wmo5T2lMa05yOXdsNUNZWE16ME5jbzEvOVIySkNRNGs2OEd4Y1lzMXI5TGsv?=
 =?utf-8?B?aXptN0QxSUcvdVY4QnA5VlNDTnVqeGJyNmsvSldWTitJcVo1c3NVdDdHODhk?=
 =?utf-8?B?ak51SElvbmcwK2tNSTY5YjdxSWpGQ3hWTVllQURIYUl4WEtnYVZqek9NaTRl?=
 =?utf-8?B?a294bkZpbjdDQ2dFQzFsMmQxYXBpZVVoNERiRnNmRk5YM1Z0VTQzVC9JUGgx?=
 =?utf-8?B?UE90WldXL2x4RXBOQXN2eVJXMDZVdFBRNDZIYWlrTnN2QlJ5UjQ5b29DQWZK?=
 =?utf-8?B?YVh5UEIvdUJqeWNpTkVFNHJrSWp2RjRwajJLTlRjMGhvS0F2NUZWKzE0ZjND?=
 =?utf-8?B?TndxNmw4WmdSdFRSTEVMeUZwM1VBU0t5dHFZd3FaV3M1bGdodFVaOGtvMWFt?=
 =?utf-8?B?amhLMDZLYnFHWFZEWTRKaHNlSWd6RStOeGM2UHlCeUR4ejhHaXNxZTN3bEds?=
 =?utf-8?B?ZUxmTDhzbmdPc2VTUGRXMGJMZzRsWEsxY3NOQ2RhNDRjN1JXcW85QzUvTEor?=
 =?utf-8?B?SExqb3kwWjBmUzBpOWFLcDQ2dm1HUkI2Z2lzWktadS95Q3FTL01YZjB1Q3BT?=
 =?utf-8?B?MUNkSDBXSHlsa0J1UnpFeHRWaWhUQjdxb1FrWm9RZDNKSHVxVEl1S1R1dDFx?=
 =?utf-8?B?UTk3bmFjOGVvRDJxekdyT0xTY0dpcDQ3cUpTZkxwYm9NcmdMVDdXYlFGcGlP?=
 =?utf-8?B?dVBCVFlhLzM2THdweklRODA3NDFCcTVxSEN2dC9IV2FsY1F3cElyakFnVXJR?=
 =?utf-8?B?c3BrSWYzUkt1T1hDakJ3YUxCUFZhRytzUFB2MjkySXpzUnZKY0ltNHpNZUpa?=
 =?utf-8?B?SlpxbitXb2t3aExPd0ZoSkFPZW9tVkR5aU96enJ1c3gxbzJqcUIwbEpxS2xG?=
 =?utf-8?B?ZHArbUR0WEZJMjlOLzUxUWFiSEc5QlN5cEhrKzBPSERqWnZHcnduQTR2NUc0?=
 =?utf-8?B?UDFXdTdOdWo0VjFqS2w4QWxicUFlQXZDUkpqSHRSZy90Nk96WGhVYm91OTJZ?=
 =?utf-8?B?TmIvRTJ0MGVYa05GUXc3WkgvT1BnbHA4b1JGckNJUCt6WUlYUE1GdUtsdG1U?=
 =?utf-8?B?ejNNSEkxa05hUkE3ajlvV1d5aUNUUlh6NGRFNHJBQ3pzU0U2c0hlUkVsd3lJ?=
 =?utf-8?B?MHZMM0QvSTlBbWRRUWlXRWpscDh1RXpYWEZMRVFPclVlR0dtbEtUM09vWnh3?=
 =?utf-8?B?bXlFQ2JtaURaNUVkV1BxZUtUcDRXVEhDY0VqR2w4dENURlNlQUw1WWlpSjJy?=
 =?utf-8?B?N0pxUzAvU3ZCYjhJeGlTYlpiVFIzR21QWFVtV2hMeDM5NWFjejZLZUs1V1J6?=
 =?utf-8?B?dzFzRlI4RUx0RUFGRG1iWGZPRkFuais4aG9xc21Fd3NBQUM1SnNmYnIxbGlW?=
 =?utf-8?B?c2J3SmYwbWNnSVBYamJjRTVzWHdSNWdTU2QvVm9WV1hzOTRFa2NieWFqaUl4?=
 =?utf-8?B?MjVRRFRRU3dVckxXLy9WZnh1UVJaWnQxcHlyOWowck1XL2ZlOU1PN1RISkky?=
 =?utf-8?B?dG1rMWZkbXBzSnc4YWNwQm9KM1dpYzV4N1FTVlFqN281eHkwQk5UMjVQYWdv?=
 =?utf-8?B?ZSs2bmlqVmY4N3dLQ0x0ZEVoNUdKaVJqSDFodUNoNmJkSlYrOWxOaVVJSDVS?=
 =?utf-8?B?UU1oOWVKakY5c3plNWlQakJmeWVBM0MvNGE3Uzg1dCtBR2ZkQ29XYi9WenVh?=
 =?utf-8?B?bFp3R0ViZDhVWllWaGxxeW0yMEFOU25FMTRnZWFINitqckNhR092bWxSWnI3?=
 =?utf-8?B?MU93czBaVmh5RCt4Y2JxT1Zkc2FxVEhRWGRWVE5zZVQ5TG82eGx2NGI0OHdK?=
 =?utf-8?B?TEwyQzJCQ0Jjd0txZVdvQlY1NlhTTnNPOFRoVDJIVnMvazZWc3RHL2V2WjFx?=
 =?utf-8?B?TWZDY1JwelNnam04RDQ4dnEyZjhEMjlESWh4ZFBsRkg0Q211dGRiZ2I0aStv?=
 =?utf-8?B?KzN4aUpNbTNqM1JsRVdhTTJTbXU3SHgzV04wbVUxK1h0YVFVV3RuZHZMMGxW?=
 =?utf-8?B?aE0wdnNCUG1LM3llZ01xOHlOUWpTZFVXTCtqbXpSNmRKbUZiNVVBamVsd1Vs?=
 =?utf-8?B?TmNNYWp3S0gzbXIxOHpqdkt0RVlEMUtXcWJRUlloRWZVVzV3RU9BVFlSem9i?=
 =?utf-8?B?OVh5WmFJbXlVc1FyTUJHRG5uOGFwdGtKalladkpvb0dlRW44RVNEdzA0Tnda?=
 =?utf-8?Q?JC51YYaH+604cHEb8MrLa5E2UmXAwjsh7RN3gHDSNwgA+?=
X-MS-Exchange-AntiSpam-MessageData-1: 0glE4nHxvV4/LQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24072010-6d4f-4ed4-c883-08deddfc3782
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:54:06.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOQcYsTZtUUie6n2aTajH2g7B9WfprWk2K32w8MTNmxuiClVryWfAZDPYwLkjTY+C3IkvbDqeQ67Vh2zqQHqMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10021
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=den@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 7/9/26 21:43, Peter Xu wrote:
> On Thu, Jul 09, 2026 at 09:00:52PM +0200, Denis V. Lunev wrote:
>> On 7/9/26 20:55, Philippe Mathieu-Daudé wrote:
>>> Hi Denis,
>>>
>>> I tried to review, but not my area and way out of my confort zone...
>>> Cc'ing Akihiko & Peter who might have more familiarity :)
> I'm always scared to work on coroutines.. :)
>
>> I thought that v3 should go fast, this is v3. Not too much
>> changes + unit test. I was wrong :(
> This does look like to fix a real issue. I'm also surprised it got
> overlooked until now.  Said that, I still think some block people should
> look at this..
>
> Kevin and Stefan are both on PTO, getting back either in 1 or 2 weeks.
> Let's see if Hanna will start to notice?  If there's still no update in 2
> weeks, I can help to reach out to them.
>
> PS: I copied Paolo too; normally he's flooded, but sometimes he'll reply.
>
> Thanks,
>
me too. We have got a bunch of scare issues once tried to
reproduce disc corruption with discard and faced several
real hangs. This one is the last of them and I was able
to repro one before and not able to repro one with the
patch.

Though I could be definitely wrong here :-)

Den

