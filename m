Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD44E7DEFC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmwTa-0005n2-Kc; Mon, 02 Feb 2026 11:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vmwTQ-0005mj-Vf
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:08:25 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vmwTN-0002Ej-RG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:08:24 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6129o74G306374; Mon, 2 Feb 2026 08:08:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=g0P76Nte5Z9w2QIYtuWq96aaZj4kdrgL5kz1gWNyK
 AY=; b=WjluBuGKFamZTPhwnzHLOlr75Hbn7jO4HcQAsECLpu/hfsAnPOY6BPuYb
 AT0yZqQ9DlHCAN3KSS6uijRmtr2a06qJTcBED77mcFAMLcfbXiNhRcB5BA/LmuTo
 4i8gy8/4pGqkCpVnT4TaUskAHLG7Dk0+D7cDD5KnBfyCg06/SwG6M6jdBaY5xClC
 WtvatxRcxdArHGQN1xeToPmDRutRW0cwHcT5JKUWr4zvMWAespjT116S+sSBNJZk
 IENZhc9aQ/iF9FDIZesJdVSSuDwwb/qYGHemlU9TJKxSQzLyZdqH/a6rz5glGd0j
 E9ln/3Ozh6KHkJe10A7NnJnyYEwTw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021123.outbound.protection.outlook.com [52.101.62.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1j5x40gr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 08:08:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFlbQKP+tkUKZna80WL89EkBx+Vs6GtMEjSYA7x38t1U8qV4RWYeJfyORHt98I6afyROJ9vrAQqeyyWnT/+3+ZaGHhow8PT+VeG/2tq4CMGfNIcb5Bg8P0GE14+iWlQ4QyggfEjJWJwu7nMowqwEX6TDlXwjbXKdocDA7XX7kX7Pbb91kto4y/XQAgNxc4UN+TNnatWRhrMemxx3CahPgOSuy0MK1cvwaunSGWxSPPJ/7i/HJTyuEafFMOeRlFgLm6BdxXZ+70MKoKpXLbz/JD+4RKA9fT90ZaT+FPz/7GXfWT643rYFDw9v0fmkAdvOcIrYv2vWksAHDnPvms4L0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0P76Nte5Z9w2QIYtuWq96aaZj4kdrgL5kz1gWNyKAY=;
 b=a7J69SqPOMtuuID/14sJirgkoH1Q44xYA4QnWXE8sfMHzTAqqwpJbrScOihomAL5pjSSfQeCwN3Ed6otJ1Ay1mj5c2CGkc/ikJDGqnY3qwd8lTjOFUpUw8xRRgJCjcI8sVY3rnkmvcwVzFXfasIMgYVHCYoey1EscTZywLgU9Qa0iP30RCkZWDtCoaXyQDue22o6RCecE0HSpFZvLC4z8Dh4eaAnBIX0oDa7MiS4zpDRxrgqT+JHKxXs3rfaseNuZUp06k28D04NfDZHcmhMIqQ0HUCSvXMxicQvvud5sUp8LYHPmR/t3A5ZqajdXgqeGPSq2m7RxgxNpg/Y1a8FpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0P76Nte5Z9w2QIYtuWq96aaZj4kdrgL5kz1gWNyKAY=;
 b=Z6ipDdOwIdSCb+YAqYBQKx/306jInNriaOB5CDkuzwG8b4SedrZtcVHZy1ps/Nhb77+cxIzlP7cE8H/jXNRrGN/m6j21XRLMrNiR4hLC6YrkOG7ParEjwNfRIlIb1ApDlazZzsXi66k86QfbORDffjmUXWTZ8WKlMGqYJPruilIrnW38bfwDHBzdRgFXwVIOQlvaTYLeok4zd1wmCXBUA4N9ePvdwVduNKZbDJIZ7TE1Siu3EIyGjxvBg2hAY5GfM54euZgkQHEEj1aWv6VtJtp6kNEhlEwRIxNahkG4LJVsdmaLItPFxUOoipFRmtLRyJdQZKxJk4W4wHW+Rhhufw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7311.namprd02.prod.outlook.com (2603:10b6:a03:29f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Mon, 2 Feb
 2026 16:08:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:08:06 +0000
Message-ID: <d2bdcfa5-11a9-41c3-81cf-75f553857227@nutanix.com>
Date: Mon, 2 Feb 2026 16:08:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/37] audio: add QOM module-objects for each backend
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-22-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:806:d2::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e23f02a-ca4c-43a6-e62d-08de6275408b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0FUcHJaQ3FZYUVDV3VlNkIwcEpwRWFyd1V3MjBuTDdxQTBPMG9PVHBJYkVK?=
 =?utf-8?B?alRxdXVJRFJFcHF6VUNkNFR4N0x3QTNZdVVsMzE1b09XcWRsSmIwL3B0MEF6?=
 =?utf-8?B?V0pMdGxNQzFlQlk4TE52OE83NnhlNU1RKzhuOGdSM2NRR3hna1ltK01ESFhn?=
 =?utf-8?B?RFFjdzExa1h3U1lYY1psUitybWdsWmlzclo1NzJMT3Q5bzllMmNpdG5uVzJq?=
 =?utf-8?B?TlRJV0l5ZlhjdFVhQy94QnkvSEhIcDZwMjFvNG9vdUZNMGZCN1Q4WVN0cExW?=
 =?utf-8?B?TWtTRkNucW1iNzVrSzNaL1F6TVF2OVBRUllGNXNKekFTMzlUbGRiTzBTUDlS?=
 =?utf-8?B?ZFc1NXB4U2wzQ0cycEpSNU94L3lNa0pPcUtRZFBNMTVyUXpWK2pydmVnUkhK?=
 =?utf-8?B?Zzh0NzVQYjk4em9EdmdSNGZFUGF2NmtmWVFvTXQ1N1lRK0lHVGxUcXBZOU16?=
 =?utf-8?B?NEdZc09ETzFab21nRFY4Q3BSSkJoTWNZUGRhcXNwK3BnaHU4dG5FV000OCtO?=
 =?utf-8?B?NllqRTlXaTBWcFozaWp3dm10SlIrZ3J5UnF4eUl6cHF0Nzl4Z3JFanc3Z0JC?=
 =?utf-8?B?ZWNvVWNWTXZFM2dCanJsVGFBcTlqWGhTdnVMamo1d1lmMHRQb2pRa2hqeG0z?=
 =?utf-8?B?R1B2N1dUTWwvNWh5b0JTaHpReGJUS0NidTZlVDFNd1I5Ui96VjB2c3I1Yjhw?=
 =?utf-8?B?eG9DV0h3d3F0V0RyazMvMXpmeHEzTy9FVWlnN0NlRm5ibDg4TUVZcWpZeVZZ?=
 =?utf-8?B?eEdxbTJ3Tkp3VVZpL0tqbVpHZ3QwL05xbExPOEVPYnJaNHF5MUJmRkJJbUd0?=
 =?utf-8?B?T2t3MnB5akFTdVY4NjcxSUhlOUUxQytMcjJFWWF1MlpNSmFWamhkYzl2OHZM?=
 =?utf-8?B?RmQvMzRTSXpXcjV3RTkvQ2lHalpkY2xVUkkzMnhodklKNU5NeFN3alNMSGRz?=
 =?utf-8?B?VUN3SGhXbWdoVVQxbTlQMXp2bndpU0hBV1ZTV1pjbGxMOThFYnVxUDFiWG9a?=
 =?utf-8?B?YmZLT0pnWGJKeXd0Q2RmbFhtaURJV1hUYU9uaWN0Qlk3VzEzbFE0aXJuenNY?=
 =?utf-8?B?OVk0SEN3d2RpYzNyaWd0NEphMFVia1RuZUtZYWlHQ0w5VjJMWjdsVVRYVjQy?=
 =?utf-8?B?Q3lmQXZZTUI0WGR2OC9ZeFF5MHk0clYwVGJGdFZLRHhYbWpMQlJVd2dvRUJp?=
 =?utf-8?B?cXcreGhGeENTZS9WOXhRYVB6c2V3VTNrVHpzVW14ZS9naDQydUd4Rm1jZ1Bj?=
 =?utf-8?B?bHliYWFKUk1OWVFwNHh3OVRTeCtLNGE0NTJxUFpHZWxEYWc1NFd2RHBTRjQx?=
 =?utf-8?B?eXljK3FHK3lvQTZSczQvOEJnUTJqbnRFUnZQTVlQWUdsdDZCQmVubXJ4YlZz?=
 =?utf-8?B?Zm9HRXF2OGk1RWVDa042NGx3U3hVM1g0S2FCcStrdFlCa2t3ZUxDaFZLeUtn?=
 =?utf-8?B?WDVqbjBPNHBZSlRDeW9JQ1UyZEJTOENwT3NSVkRQWHpneWtFV3Q1a2lnOVZL?=
 =?utf-8?B?UGR3cEpPM3A5elo5TWJ5UkxDUkZQeGVma3lvSnhpYTk2N1dibTRxTmU5VGlv?=
 =?utf-8?B?d3l2ZXJSS2dmaWc4Um90VkRDNHJRKzNjcGpXZEJ0Wm1PV1JrREs2RmhQd2xQ?=
 =?utf-8?B?YnFqKzBqQ25kWGx2TUJ1RWtPQWdKS0ZZQjFqbitxZ1BSSXA2RkFoNHBjNS9U?=
 =?utf-8?B?a25xUk0vZmdPaXFBSGtQUzdGeDluTFdjREJRNXlCd1NBYWtmeHg3V3hKMFMr?=
 =?utf-8?B?bFprUFZ3U3MxK0Y4NDJhS1dwYmh6UllHTnhXRGt6YmJ4eFNkMFRnMHpvOWpx?=
 =?utf-8?B?NG9ZaFo1bGphSG4wWkhZcjhzVXY0MjR6SStBMUVGOHAvNlVWZEdrTW1ESk5Q?=
 =?utf-8?B?ZVdSQUZob0RNL1BBZWtEaFRwVnJ1RU15YTE2Sk1sa3FVOXIwZUFkK0xMYWY3?=
 =?utf-8?B?MUpDTlRzdG42NExXaVk1RS85ZWVUOHdIWFZERzlWbTZqZk9aRzRReE9WYkFO?=
 =?utf-8?B?ZVVnK0VqR05XL1hZdDFpUlZ3c0JBWGxJUWxDNDlWaFc2eGlJWTluSVV2bWNy?=
 =?utf-8?Q?xBz5hH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBKekEzc3VseW9BRWF1bm9aTzUveG5ycFNOTTUzeUxNL2ZnUVozMU5yN2ti?=
 =?utf-8?B?YTFXWDFuSmEwc1QwalpXaUtpWUZZNVFPUGowaWZwZWxCbGwrRTZKSlBucklt?=
 =?utf-8?B?ckVpKzVLUlAwVWt2alNpRGtWdkJ0OGpvdFRNYjh1L1BIZVlvV2lSeWo1S2dU?=
 =?utf-8?B?YVdrOUNKU3pmdVRPYmRXT0tpN1NzK3l6TjE3YTF0Uktrd1FaZ0lRNFNlMEVB?=
 =?utf-8?B?UmF0b21HQ1lYR0VFamZYM2QxeUk4L3FYQ0cvT1VqTEFQTGlzVHdQMXlabDJL?=
 =?utf-8?B?M0pYTVRqSjhpZjN2RVZGZFZJNHUxSTBsY2d1R1ZSd0orL29mRFpiUUk1bzB0?=
 =?utf-8?B?bjRoVFRzTUNadFZNNUdWVXVHSnovbXpyMy93SWV3K2V4enJ5VHJsSStNRVVD?=
 =?utf-8?B?dFcrdCtkWkNDb2JMQmp6UnlTNDlQSWNZZ216dkt1a0tQbEQwSzFIZnhBQkZi?=
 =?utf-8?B?dTQ4NTJ6dzA4UUtFMEE1SDFidkdxVEc3bm51YkZzNkhocFFJRVgvUzZPUVkz?=
 =?utf-8?B?WktnUUJZaUpVNWl5QThkZTB6RmxLc2YzSG9uTlJYemN5ckdMdUtvWHpZY05B?=
 =?utf-8?B?dmhmS3krWDdLcGlmSDBpbHd5YmhtZW5KSTNuU3Z6VDRlSU1ZMnA0YktKNlJm?=
 =?utf-8?B?R1ZFV2hnMW0zbkFNWUNJVWI3eDVoaTJCWWFaZUdDS3VGa2lZczRWeUJrbFdG?=
 =?utf-8?B?YkhTSDJTWVMvYzRWQ0xZK3NxNzNrWXRhYkVTZWltWXNadXhZSG9oaWtvL05C?=
 =?utf-8?B?eGRpRnhIWFF3allRMHlqRzBFRzVvOTc2aGNPN0hZdWJ6K3RlYk9qTkd6VDFN?=
 =?utf-8?B?OEZEOW8xVWkrcksrNjdVT051S3VDbWdGd3pNb2cvWTM5Q2ZEb1c5MnJzYTd6?=
 =?utf-8?B?TXFsNTN3OXVHREo3NnBTeWk1RnZKSU1UVDZISjUrMVppT0hJY09ZMVp3bGF6?=
 =?utf-8?B?RytuZCt6bXZER1hoRE5McmVNVzN3L0FhSU1SZ24vbWhNRER4c25DZDVtbGlN?=
 =?utf-8?B?RE0wRmV4ZUtiNEkwcDZFMlF4MVdJT0pTeSswUGt6NzcvWHo4Z1V1L01LR1I4?=
 =?utf-8?B?RW84dDg3ME5ib0VLYjR1NkJUS0VhN1A1eitlYTU1N2lKMlE2ZDJkeTJDMVpu?=
 =?utf-8?B?TW4yVkdOSy9FZU9WZkJxZEgvQ2xWbnZ1Nk1xMk1neE8vZU9mS2crZE5hcGll?=
 =?utf-8?B?cVdVa2RPZm11ckd3MHQvVGorS1NObTdGNjd4UWh3cWFORTV6a2R2RUl5akR1?=
 =?utf-8?B?bVlmMFNTNVJWWmN0N2tlTWxJc0hxcTdDTmRHdTFISER5dElpeVA0MlNXS0hN?=
 =?utf-8?B?ZFpGemdIQys1TERBaHpHZHMzQTg0NytsdWR1N0JDdFIvRFBtVUpxOE5hcGpp?=
 =?utf-8?B?bmNOSWYvaVRYcFFCVTRwK2hHbW9Zak54UGRJc3Y4SVJ3ek1NMWlnb0hBTXRi?=
 =?utf-8?B?LzdrRFpMSmZ6WmxXcDhITm5GYXhqZWtyWU9MNkQ4K0VXczdoamx3bUZjTERY?=
 =?utf-8?B?QTRWN1BUZlBLRHJBWGFneFRaSTgvSm1mVXE3VWRsMnlEa2VUU1hOV29rYVds?=
 =?utf-8?B?VzNIUXNJVWlyU05oTjZtdG93bHY0b2M2NGd1RkVydzA5NmVVQ1NGNHZMMm1z?=
 =?utf-8?B?SndHbk5scnRaeVU5cU5qVlY4V1loQXFjVmFQMXF0SFN3RFhtM2wyRFVtUEpS?=
 =?utf-8?B?cnBmWndsUWpaVE52aGxMLy81T3FVZ3BOdSs1Z09DRWM0a3hmbTdMZ2JVeTZD?=
 =?utf-8?B?a1lxNEhEeHJwdWRoQ3kzb3hXaUJ1QzRrQndVdUY0OFE0blpqR3BGU0IrVEV0?=
 =?utf-8?B?SmNGR29GS2dyc2NZMXpLYy9qK1ZkVEtaOW5qa1NYNkx6M1paOTcrL0hHZmJm?=
 =?utf-8?B?TVQ1SnlIcVE4YjVOeUloaE1RTmNJR1gwaU5USFRkN2ExWkREOEJpQ1kvZ2NC?=
 =?utf-8?B?TStjZk5lREdiVG03Yy9YTlJ0bi9BcG5mNDJENmtxaXN4R1pvU3I5SUZjRW5k?=
 =?utf-8?B?d1oyTDJhekZoemZhZUtzeTc5blNpYmVVVWY1NE52Ujl5TDhyazJRMUF1bHNx?=
 =?utf-8?B?SUo4UTVnclVtUzZ3bmJUbkxyeS8wdG9HSHlpZHozam91ZDVJUDk4SG93NWhL?=
 =?utf-8?B?TXR1bm0wSGhJV0o0SStTK0ozMTRBQXphSW5TdG9sb0pvOHl4WWYvTGYwaDFW?=
 =?utf-8?B?dXIvYkRvZkt4QUhuU1FtMjl2WktvVTd0Kzhvd1ZORXd6aDhGbDQyWGdLYmhq?=
 =?utf-8?B?Mk5HT1oxU3lVQUZlYnBEbHRuOVRsdFVnQWRSbW9DVktKMy8zTHlBMDNwSEI1?=
 =?utf-8?B?bnJBZ1RsemFMNTQzd0t3T3Qza0NqeXgzWUNFcHdsb1Q1YXAxSE1VakdQMW85?=
 =?utf-8?Q?3oBPdF+H17fUS9oA=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e23f02a-ca4c-43a6-e62d-08de6275408b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:08:06.7981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJ/516oD+Mi7kkN59HY6VoSnHqAHGvzvzqwQ4jl+6IpOE38Z0PZMAwWKs+bPW/qMj6PkbMQUmNtDF/L26OSEX4JtsCnSNIBgEl5cRipX6m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7311
X-Proofpoint-ORIG-GUID: _WJqn63qi1LyUE3086182WFKsLqA5EiZ
X-Authority-Analysis: v=2.4 cv=HfQZjyE8 c=1 sm=1 tr=0 ts=6980cbea cx=c_pps
 a=rsLAoTD1kIcpcG7DHw0aAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UXIAUNObAAAA:8 a=20KFwNOVAAAA:8
 a=JndJuqGLg7OoDiO99PwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=8oZcqNQYT1QA:10 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-GUID: _WJqn63qi1LyUE3086182WFKsLqA5EiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyNyBTYWx0ZWRfX6wRlg03DmLQS
 +b2HhvKutEqHAj0JSLV2QuMqMi60kzGwbfUqSs/Hm6O76MINX6MVMQk2C+8qvOSUz/xxKghTSaw
 zGpfAtXmUXHCozan9XnxpQDfAES3iApOiGyJ/sMIHNiwQ7Fn+nQFhwjRJrctA5qVDvb7YT/12iW
 /eUPKj/KRtLupc9uVVEXrX6Hg4+9Op6thL2a78zQtBQeIubu6SJ4paUT4SZuxm3pUvrADii2Pq6
 INeB+oGJfIMjI/eh7PTLC01wU9MyZ1/UPRWZsuEEDPoUw2JSU9yt7JE+KAh+YQ+hiwX65NkuiZs
 GjQK58ZxYCg/kXKiyp7CZPQKBpoAmOQa+jHCnKZvR7Ji3VUZ0RLeoPqXv/lyyLBngul/rkLzw3z
 GA12j3+5sM3fpclsNM21BIQKIn6pYKvEH+H9KMGL+Lsoh9qamE91GSaJW6KEoMi1VXJD1bqTJiT
 i5gfoN5ErNvZNBx4N4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to use QOM and the dynamic object module loading.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h   |  2 ++
>   audio/alsaaudio.c   | 27 +++++++++++++++++++++++++++
>   audio/dbusaudio.c   | 26 ++++++++++++++++++++++++++
>   audio/dsoundaudio.c | 26 ++++++++++++++++++++++++++
>   audio/jackaudio.c   | 26 ++++++++++++++++++++++++++
>   audio/noaudio.c     | 26 ++++++++++++++++++++++++++
>   audio/ossaudio.c    | 26 ++++++++++++++++++++++++++
>   audio/paaudio.c     | 26 ++++++++++++++++++++++++++
>   audio/pwaudio.c     | 26 ++++++++++++++++++++++++++
>   audio/sdlaudio.c    | 26 ++++++++++++++++++++++++++
>   audio/sndioaudio.c  | 26 ++++++++++++++++++++++++++
>   audio/spiceaudio.c  | 26 ++++++++++++++++++++++++++
>   audio/wavaudio.c    | 26 ++++++++++++++++++++++++++
>   audio/coreaudio.m   | 26 ++++++++++++++++++++++++++
>   14 files changed, 341 insertions(+)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 06f5160e8df..29f5864be69 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -241,6 +241,8 @@ struct SWVoiceCap {
>   
>   struct AudioMixengBackendClass {
>       AudioBackendClass parent_class;
> +
> +    audio_driver *driver;
>   };
>   
>   struct AudioMixengBackend {
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 814820e2864..881f3d0349d 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -27,6 +27,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   #include "trace.h"
>   
>   #pragma GCC diagnostic ignored "-Waddress"
> @@ -36,6 +37,22 @@
>   
>   #define DEBUG_ALSA 0
>   
> +#define TYPE_AUDIO_ALSA "audio-alsa"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
> +
> +struct AudioALSA {
> +    AudioMixengBackend parent;
> +};

This should be parent_obj as per our style guidelines at 
https://qemu.readthedocs.io/en/v10.0.3/devel/style.html#qemu-specific-idioms.

It looks like this pattern is repeated further through the file, but it 
should be trivial to fix up.

> +static struct audio_driver alsa_audio_driver;
> +
> +static void audio_alsa_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &alsa_audio_driver;
> +}
> +
>   struct pollhlp {
>       snd_pcm_t *handle;
>       struct pollfd *pfds;
> @@ -945,8 +962,18 @@ static struct audio_driver alsa_audio_driver = {
>       .voice_size_in  = sizeof (ALSAVoiceIn)
>   };
>   
> +static const TypeInfo audio_alsa_info = {
> +    .name = TYPE_AUDIO_ALSA,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioALSA),
> +    .class_init = audio_alsa_class_init,
> +};
> +
> +
>   static void register_audio_alsa(void)
>   {
>       audio_driver_register(&alsa_audio_driver);
> +    type_register_static(&audio_alsa_info);
>   }
>   type_init(register_audio_alsa);
> +module_obj(TYPE_AUDIO_ALSA);
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 96d4fa3f471..789d72f6903 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -26,6 +26,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   #include "qemu/dbus.h"
> +#include "qom/object.h"
>   
>   #ifdef G_OS_UNIX
>   #include <gio/gunixfdlist.h>
> @@ -44,6 +45,22 @@
>   
>   #define DBUS_DEFAULT_AUDIO_NSAMPLES 480
>   
> +#define TYPE_AUDIO_DBUS "audio-dbus"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioDbus, AUDIO_DBUS)
> +
> +struct AudioDbus {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver dbus_audio_driver;
> +
> +static void audio_dbus_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &dbus_audio_driver;
> +}
> +
>   typedef struct DBusAudio {
>       Audiodev *dev;
>       GDBusObjectManagerServer *server;
> @@ -711,10 +728,19 @@ static struct audio_driver dbus_audio_driver = {
>       .voice_size_in   = sizeof(DBusVoiceIn)
>   };
>   
> +static const TypeInfo audio_dbus_info = {
> +    .name = TYPE_AUDIO_DBUS,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioDbus),
> +    .class_init = audio_dbus_class_init,
> +};
> +
>   static void register_audio_dbus(void)
>   {
>       audio_driver_register(&dbus_audio_driver);
> +    type_register_static(&audio_dbus_info);
>   }
>   type_init(register_audio_dbus);
>   
>   module_dep("ui-dbus")
> +module_obj(TYPE_AUDIO_DBUS)
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index 7a03d1dad86..f1902e55262 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -33,6 +33,7 @@
>   #include "audio_int.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> +#include "qom/object.h"
>   
>   #include <windows.h>
>   #include <mmsystem.h>
> @@ -41,6 +42,22 @@
>   
>   #include "audio_win_int.h"
>   
> +#define TYPE_AUDIO_DSOUND "audio-dsound"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioDsound, AUDIO_DSOUND)
> +
> +struct AudioDsound {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver dsound_audio_driver;
> +
> +static void audio_dsound_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &dsound_audio_driver;
> +}
> +
>   /* #define DEBUG_DSOUND */
>   
>   typedef struct {
> @@ -694,8 +711,17 @@ static struct audio_driver dsound_audio_driver = {
>       .voice_size_in  = sizeof (DSoundVoiceIn)
>   };
>   
> +static const TypeInfo audio_dsound_info = {
> +    .name = TYPE_AUDIO_DSOUND,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioDsound),
> +    .class_init = audio_dsound_class_init,
> +};
> +
>   static void register_audio_dsound(void)
>   {
>       audio_driver_register(&dsound_audio_driver);
> +    type_register_static(&audio_dsound_info);
>   }
>   type_init(register_audio_dsound);
> +module_obj(TYPE_AUDIO_DSOUND);
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 7a3fcaedbae..48a466ed532 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -27,6 +27,7 @@
>   #include "qemu/atomic.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "jack"
>   #include "audio_int.h"
> @@ -34,6 +35,22 @@
>   #include <jack/jack.h>
>   #include <jack/thread.h>
>   
> +#define TYPE_AUDIO_JACK "audio-jack"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioJack, AUDIO_JACK)
> +
> +struct AudioJack {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver jack_driver;
> +
> +static void audio_jack_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &jack_driver;
> +}
> +
>   struct QJack;
>   
>   typedef enum QJackState {
> @@ -691,10 +708,18 @@ static void qjack_info(const char *msg)
>       dolog("I: %s\n", msg);
>   }
>   
> +static const TypeInfo audio_jack_info = {
> +    .name = TYPE_AUDIO_JACK,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioJack),
> +    .class_init = audio_jack_class_init,
> +};
> +
>   static void register_audio_jack(void)
>   {
>       qemu_mutex_init(&qjack_shutdown_lock);
>       audio_driver_register(&jack_driver);
> +    type_register_static(&audio_jack_info);
>   #if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
>       jack_set_thread_creator(qjack_thread_creator);
>   #endif
> @@ -702,3 +727,4 @@ static void register_audio_jack(void)
>       jack_set_info_function(qjack_info);
>   }
>   type_init(register_audio_jack);
> +module_obj(TYPE_AUDIO_JACK);
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index 4ed9d2156c5..e6e8bfd3323 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -25,10 +25,27 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "noaudio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_NONE "audio-none"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioNone, AUDIO_NONE)
> +
> +struct AudioNone {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver no_audio_driver;
> +
> +static void audio_none_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &no_audio_driver;
> +}
> +
>   typedef struct NoVoiceOut {
>       HWVoiceOut hw;
>       RateCtl rate;
> @@ -138,8 +155,17 @@ static struct audio_driver no_audio_driver = {
>       .voice_size_in  = sizeof (NoVoiceIn)
>   };
>   
> +static const TypeInfo audio_none_info = {
> +    .name = TYPE_AUDIO_NONE,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioNone),
> +    .class_init = audio_none_class_init,
> +};
> +
>   static void register_audio_none(void)
>   {
>       audio_driver_register(&no_audio_driver);
> +    type_register_static(&audio_none_info);
>   }
>   type_init(register_audio_none);
> +module_obj(TYPE_AUDIO_NONE);
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 6ad20ab1876..eb98cc62e9c 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -30,11 +30,28 @@
>   #include "qemu/host-utils.h"
>   #include "qapi/error.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   #include "trace.h"
>   
>   #define AUDIO_CAP "oss"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_OSS "audio-oss"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
> +
> +struct AudioOss {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver oss_audio_driver;
> +
> +static void audio_oss_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &oss_audio_driver;
> +}
> +
>   #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
>   #define USE_DSP_POLICY
>   #endif
> @@ -772,8 +789,17 @@ static struct audio_driver oss_audio_driver = {
>       .voice_size_in  = sizeof (OSSVoiceIn)
>   };
>   
> +static const TypeInfo audio_oss_info = {
> +    .name = TYPE_AUDIO_OSS,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioOss),
> +    .class_init = audio_oss_class_init,
> +};
> +
>   static void register_audio_oss(void)
>   {
>       audio_driver_register(&oss_audio_driver);
> +    type_register_static(&audio_oss_info);
>   }
>   type_init(register_audio_oss);
> +module_obj(TYPE_AUDIO_OSS);
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 0c06a397195..cf67a9f7593 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -4,12 +4,29 @@
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
>   #include "qapi/error.h"
> +#include "qom/object.h"
>   
>   #include <pulse/pulseaudio.h>
>   
>   #define AUDIO_CAP "pulseaudio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_PA "audio-pa"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
> +
> +struct AudioPa {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver pa_audio_driver;
> +
> +static void audio_pa_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &pa_audio_driver;
> +}
> +
>   typedef struct PAConnection {
>       char *server;
>       int refcount;
> @@ -931,8 +948,17 @@ static struct audio_driver pa_audio_driver = {
>       .voice_size_in  = sizeof (PAVoiceIn),
>   };
>   
> +static const TypeInfo audio_pa_info = {
> +    .name = TYPE_AUDIO_PA,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioPa),
> +    .class_init = audio_pa_class_init,
> +};
> +
>   static void register_audio_pa(void)
>   {
>       audio_driver_register(&pa_audio_driver);
> +    type_register_static(&audio_pa_info);
>   }
>   type_init(register_audio_pa);
> +module_obj(TYPE_AUDIO_PA);
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 30f717ccacf..3c2fbccaea4 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -13,6 +13,7 @@
>   #include "qemu/audio.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> +#include "qom/object.h"
>   #include <spa/param/audio/format-utils.h>
>   #include <spa/utils/ringbuffer.h>
>   #include <spa/utils/result.h>
> @@ -27,6 +28,22 @@
>   
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_PW "audio-pipewire"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
> +
> +struct AudioPw {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver pw_audio_driver;
> +
> +static void audio_pw_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &pw_audio_driver;
> +}
> +
>   typedef struct pwvolume {
>       uint32_t channels;
>       float values[SPA_AUDIO_MAX_CHANNELS];
> @@ -847,10 +864,19 @@ static struct audio_driver pw_audio_driver = {
>       .voice_size_in = sizeof(PWVoiceIn),
>   };
>   
> +static const TypeInfo audio_pw_info = {
> +    .name = TYPE_AUDIO_PW,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioPw),
> +    .class_init = audio_pw_class_init,
> +};
> +
>   static void
>   register_audio_pw(void)
>   {
>       audio_driver_register(&pw_audio_driver);
> +    type_register_static(&audio_pw_info);
>   }
>   
>   type_init(register_audio_pw);
> +module_obj(TYPE_AUDIO_PW);
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 707110973ac..cc05c1d4531 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -28,6 +28,7 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #ifndef _WIN32
>   #ifdef __sun__
> @@ -40,6 +41,22 @@
>   #define AUDIO_CAP "sdl"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_SDL "audio-sdl"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioSdl, AUDIO_SDL)
> +
> +struct AudioSdl {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver sdl_audio_driver;
> +
> +static void audio_sdl_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &sdl_audio_driver;
> +}
> +
>   typedef struct SDLVoiceOut {
>       HWVoiceOut hw;
>       int exit;
> @@ -491,8 +508,17 @@ static struct audio_driver sdl_audio_driver = {
>       .voice_size_in  = sizeof(SDLVoiceIn),
>   };
>   
> +static const TypeInfo audio_sdl_info = {
> +    .name = TYPE_AUDIO_SDL,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioSdl),
> +    .class_init = audio_sdl_class_init,
> +};
> +
>   static void register_audio_sdl(void)
>   {
>       audio_driver_register(&sdl_audio_driver);
> +    type_register_static(&audio_sdl_info);
>   }
>   type_init(register_audio_sdl);
> +module_obj(TYPE_AUDIO_SDL);
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index 8197b8b0b47..6a3d93efd51 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -20,10 +20,27 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/audio.h"
>   #include "trace.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "sndio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_SNDIO "audio-sndio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioSndio, AUDIO_SNDIO)
> +
> +struct AudioSndio {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver sndio_audio_driver;
> +
> +static void audio_sndio_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &sndio_audio_driver;
> +}
> +
>   /* default latency in microseconds if no option is set */
>   #define SNDIO_LATENCY_US   50000
>   
> @@ -555,9 +572,18 @@ static struct audio_driver sndio_audio_driver = {
>       .voice_size_in  = sizeof(SndioVoice)
>   };
>   
> +static const TypeInfo audio_sndio_info = {
> +    .name = TYPE_AUDIO_SNDIO,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioSndio),
> +    .class_init = audio_sndio_class_init,
> +};
> +
>   static void register_audio_sndio(void)
>   {
>       audio_driver_register(&sndio_audio_driver);
> +    type_register_static(&audio_sndio_info);
>   }
>   
>   type_init(register_audio_sndio);
> +module_obj(TYPE_AUDIO_SNDIO);
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index 7db2d1f0dfd..bfa249b18c4 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -24,11 +24,28 @@
>   #include "qemu/timer.h"
>   #include "qapi/error.h"
>   #include "ui/qemu-spice.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "spice"
>   #include "qemu/audio.h"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_SPICE "audio-spice"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioSpice, AUDIO_SPICE)
> +
> +struct AudioSpice {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver spice_audio_driver;
> +
> +static void audio_spice_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &spice_audio_driver;
> +}
> +
>   #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
>   #define LINE_OUT_SAMPLES (480 * 4)
>   #else
> @@ -325,10 +342,19 @@ static struct audio_driver spice_audio_driver = {
>       .voice_size_in  = sizeof (SpiceVoiceIn),
>   };
>   
> +static const TypeInfo audio_spice_info = {
> +    .name = TYPE_AUDIO_SPICE,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioSpice),
> +    .class_init = audio_spice_class_init,
> +};
> +
>   static void register_audio_spice(void)
>   {
>       audio_driver_register(&spice_audio_driver);
> +    type_register_static(&audio_spice_info);
>   }
>   type_init(register_audio_spice);
> +module_obj(TYPE_AUDIO_SPICE);
>   
>   module_dep("ui-spice-core");
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 46460a5d573..480da5048fa 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -25,10 +25,27 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "wav"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_WAV "audio-wav"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioWav, AUDIO_WAV)
> +
> +struct AudioWav {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver wav_audio_driver;
> +
> +static void audio_wav_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &wav_audio_driver;
> +}
> +
>   typedef struct WAVVoiceOut {
>       HWVoiceOut hw;
>       FILE *f;
> @@ -214,8 +231,17 @@ static struct audio_driver wav_audio_driver = {
>       .voice_size_in  = 0
>   };
>   
> +static const TypeInfo audio_wav_info = {
> +    .name = TYPE_AUDIO_WAV,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioWav),
> +    .class_init = audio_wav_class_init,
> +};
> +
>   static void register_audio_wav(void)
>   {
>       audio_driver_register(&wav_audio_driver);
> +    type_register_static(&audio_wav_info);
>   }
>   type_init(register_audio_wav);
> +module_obj(TYPE_AUDIO_WAV);
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 997017a1e96..882e47f8c25 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -29,10 +29,27 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qom/object.h"
>   
>   #define AUDIO_CAP "coreaudio"
>   #include "audio_int.h"
>   
> +#define TYPE_AUDIO_COREAUDIO "audio-coreaudio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AudioCoreaudio, AUDIO_COREAUDIO)
> +
> +struct AudioCoreaudio {
> +    AudioMixengBackend parent;
> +};
> +
> +static struct audio_driver coreaudio_audio_driver;
> +
> +static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    k->driver = &coreaudio_audio_driver;
> +}
> +
>   typedef struct coreaudioVoiceOut {
>       HWVoiceOut hw;
>       pthread_mutex_t buf_mutex;
> @@ -673,8 +690,17 @@ static void coreaudio_audio_fini (void *opaque)
>       .voice_size_in  = 0
>   };
>   
> +static const TypeInfo audio_coreaudio_info = {
> +    .name = TYPE_AUDIO_COREAUDIO,
> +    .parent = TYPE_AUDIO_MIXENG_BACKEND,
> +    .instance_size = sizeof(AudioCoreaudio),
> +    .class_init = audio_coreaudio_class_init,
> +};
> +
>   static void register_audio_coreaudio(void)
>   {
>       audio_driver_register(&coreaudio_audio_driver);
> +    type_register_static(&audio_coreaudio_info);
>   }
>   type_init(register_audio_coreaudio);
> +module_obj(TYPE_AUDIO_COREAUDIO);


ATB,

Mark.


