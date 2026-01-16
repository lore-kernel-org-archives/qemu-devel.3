Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B02C982F0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgos1-0006PS-Up; Fri, 16 Jan 2026 13:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vgorv-0006Md-79
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:48:25 -0500
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vgort-0007NJ-A6
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD2OsmKIGo+cH+lil2d+YOnNvklYkuuyZweAqYnsY/8LY0qTmBxNtShUsCnbG1LNlSuOO5ramBTNoIghq1CalPBXCA3Mw+b+bkCnegcqIJDrLHjJgHhD/WTD++5Ww7Mu4ONtwVFDrZfJBn29bUKzjTJIE5k+/iGn41YcGkl6NpgS/w1UhG5NuZsWuEPBvBaa414yHOQAshP60ezgAAJckE9InHQJmuCxAeb2KXAbWvp+bAYLwmwLbb1T9WC7X23bvbkFYuUSVznjWBb2fkdZgeOg/LTHEhw/E4TmShHwVGJhkCSahjsfE083pS81oYqNVZEsnlW3BDdt1PLCdG+gOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQhZpMQ2rHqfuPZmBhFWp5Wd9jfkdoJmt85lGnIZpVI=;
 b=HbGNrPt2IT+cg6YMmx91yh9cwsnBYw/5my0dbzYHR6H8xNvcPAjt/BC9K2OkGTccxYA72ESzknHbbJgd7yY87mehh6g4eZ9qOB3wE7/JhFStySXANIX8rjtyaoJ+dog5UxXa0ObQgnpl8cqA5ZeWhvcRM2/X9lvoTNXxaickq3nNaoXtzAfnoPt1hSOmrx7sdP64RGf4dt7NgvU1UDLl1Tb9NPlbNWAWoWPvn2Me0ubn/7Tpnm1eh0oChQhyewHSDMo8hrY7FndW2Jg/PGZTdvPjqNlxeysadt4572ifI5RVXASr47+EhYrLiWCvgdwv+GBPylBFHC7H6zp5MR6Q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQhZpMQ2rHqfuPZmBhFWp5Wd9jfkdoJmt85lGnIZpVI=;
 b=GOd6oXHT4ul2MWlFx0j5inDuOMLZ/6dF3fWbb3JzroEKXOpPYH1PrzNH1s4Km5o1/egDvDjlp5npRJvUqkJvgG5fLBk6fINXxnt+WOYPwkyBaLoFPIT9psYvLgoUaOPaPwW8ukmMNDOL+U8C5HHN4taIGjVi0IDmn/hNqbVM2yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR4P278MB1956.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 18:48:17 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9499.005; Fri, 16 Jan 2026
 18:48:17 +0000
Message-ID: <0458a52c-b86b-43e8-84f6-ec75b012a9a2@epfl.ch>
Date: Fri, 16 Jan 2026 19:48:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
 <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::18) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR4P278MB1956:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ff9f40-a59e-4e04-dec6-08de552fcfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|786006|366016|10070799003|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXBuSm1QMyt1UG9tc2l3T1BpazJkaHZKSW5zTHo1Y3FqZWRxSGVBcnJVdmdZ?=
 =?utf-8?B?VXl4TUxsemJZTThVU3JCcDlnbFBHekRJVnVTOUZjZW1wZjdCYUI1bGRhaU5s?=
 =?utf-8?B?RGlHK3N2OHJUVjZsRTJUVmZCUFNTUS9pZUw5VXdzZDdMZ01EOW41NjBmaHRx?=
 =?utf-8?B?SVJyNDk2OWRaM011am1HV29mTE44Tk5tMjZKZHZMRk9QcE1NV3VWajZPbjhT?=
 =?utf-8?B?VkRpMi9xRDU1MVI5Mm9QR3lXdVJFNlZFZjN5bzRDR2J2VldUcGJFQ1JNZHlT?=
 =?utf-8?B?MTU2QS9mNkJyakNXN25XbE1QemVXK2w3VitMelBhZW51UnBOdUlqSHhmODRi?=
 =?utf-8?B?dXVRS2pSQ1AwSEVNN0dkL3VLeXZjUzYxekRoYjNUKzhjVjh6VThHd0YrWm5M?=
 =?utf-8?B?UkJ4V3A2azZWYlR4OXR5cHQzYXBpK2I4ODExaXBaQlJ5RjRHTit4ODFVZzN6?=
 =?utf-8?B?b3A3MWxHQnZNNDArZmtyKzlaVnlHNmoyM2VOVG9YQmJFeVFsaGtHblN0OWdi?=
 =?utf-8?B?L1hjTHFKTGs3MHBqcURnTUNWK0taUHJ6UHZsYS9sTDZNQ3RmNDI1eEF2eHRS?=
 =?utf-8?B?RjBwRzFoM0F0aTc5SEFPV29qcWx4aFozamg2K1IyY3VEd3dzc1htakEreWsx?=
 =?utf-8?B?U0o5Z2V5dnBqY3I1MHd1UDFETHpvVXVqNzZjcmFxQ0piamNOL1J5amJaZWZ6?=
 =?utf-8?B?V1IzUXBNZWhZaW54Y3ZrOU95UDA0QWttVkgxU3VsZDhZMkVRN01WWm44Nkpa?=
 =?utf-8?B?OHFhSGJwSExSNmFOeE5aK3ZhcXl3QTI1Z2VDc1c1SU5nUmJJMEdsbkI3WHdI?=
 =?utf-8?B?NHhpK2xVaWJCTHBGOFlINVI1ejMzcjRJaW9NOFB1d0hHbmREYkNsdXNyL0NM?=
 =?utf-8?B?OXZwcGpqUkNyb05DSS82Z0VmSmFzMFB4YXR4VTBFV1RSaWdqNzEzeWVGd084?=
 =?utf-8?B?QnN0ZVRSZmtURG96WFdNd0ZsS3ZkZS9KRXo3OEkzYk5sbEJEd0tUckVCZlVT?=
 =?utf-8?B?OWt3alFmMWJ4OEU1Q1N1Szd3dmd5YkJkZ0xBQU5qV2s0VE5IQnZpNXBmVll5?=
 =?utf-8?B?WXNYYWNvNVJCRVJsaXpMMXdpTHdYRkZRVUxWM2lUZ0NWVGdPTFlPRUhRY3Yv?=
 =?utf-8?B?bFpEL3IvMjdLbEEzL0x3QlA3eHR1NUV6MUZvUFJybDNaNmtBWktDWXVRWmxY?=
 =?utf-8?B?U3FsRFI0K1FkVTRrOGd4MzdsUytRUlhlNmVOTlBxenBRUnVNYzRGdWd2b2xY?=
 =?utf-8?B?WGFsWHNEaWEvNHByOVdPeWdvaTNMYk91U2dYbXhqSXVzZHE1aFFjZmF5N3pJ?=
 =?utf-8?B?SkdqQWViZXJRcEh4TEJ1Wit4cUJCbGROVUF2Q0lqczgvS0tKVVFkNzB5aDFl?=
 =?utf-8?B?SEFmUFN2dkZVbk9kbUZVa242eUNZMnVBSlFTR1YvbjFBVzBEQlB1NW1SbjVa?=
 =?utf-8?B?c1RIbmptREd6a0dVNzFYZlZidDl1ZWdtcnNhLzhUc1R6ZXJnTWliVDJDNnBP?=
 =?utf-8?B?RFZ2SUNRMksyUnFXWGtLbWFMUkdaNThSSjNJNC9Ea2pqUVZ3WGNmZXdGaS90?=
 =?utf-8?B?djdoNCtPcmhUcTRMR3BDdlVvTG5idmRCNDIwR0Q2R21hN05rT0hrMzVNZUpQ?=
 =?utf-8?B?MTFTK1N2RFJZcGJibXBaT2ppRU9tZkJRMGNBdHh6ZWdqVW90MU0rdnJoMzEz?=
 =?utf-8?B?UDJsR2RtOFJRVUo5RDBSZVVRdkZEb2J0V2t0S0c5QzE5TllqYThyZjNVTlZB?=
 =?utf-8?B?aEQ0M0tNVUlsRzNjQzJyQldqN0p5cHpyS1EyQlcrcDk0UnlBeHdTT0l5QkJX?=
 =?utf-8?B?UXQ2bHlMWnVkeTc1R3B4dnV1L3BZVC9Nb08vU2syRkROUE1lMElZRmdJWnJv?=
 =?utf-8?B?NmJTVlhYeTBwS0NUYzB0TlpORmNvY25WdUNlMUZqYkxqRnZGVGpRQ0ovVm52?=
 =?utf-8?B?YXRpbE4wUXR2NEttZkM5K1dmb2RnUXVXTjg0MlVWeCtBbFhwcFRiOTZoV2t2?=
 =?utf-8?B?MEpVc2hhaW9Vc0htRGY5bjl0RWNrOEE3Z3RJaXk3TmlmVHhPNHp6REJOQmFF?=
 =?utf-8?B?bmNTK1h4VTBhOURjZXZuSTBSanREeDkzTTVTd2kxWE9jVk9NNUhla2lJd3kr?=
 =?utf-8?Q?97fQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(786006)(366016)(10070799003)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b04wVjd5TzhKaTZrUDd2WGpReUd6a0c2Znl2aDZyRzlKRHBCVHZQRHI3cjhn?=
 =?utf-8?B?aWpnMXVaRmZvZWVOSFE0K0xUWUdCOEZRV0Vob0JEWUdTU0JmRHg0bnIxZjVN?=
 =?utf-8?B?czZFOFU1dnRKbXA0REl6V0E2d0QweWszWGhFejl5ZTNPWWt1aWtncVlmZ3FS?=
 =?utf-8?B?RE5wY211dXhGTnppM3dITGdaSk9iOFJQdHZVL2JVQVZVQkhHamJZY0ZtSmlO?=
 =?utf-8?B?RkFLZjZGZ0tMQzNWZjVoUUJ0UG4vWXZ6MnYwTkY1bjZhTldDMEtwTzg2YVlH?=
 =?utf-8?B?U2liVGtDMzlGeURGczJ0bm5XTE5JOVFpaHQ4ZUp2ME9meVVMMG1odjRGajdX?=
 =?utf-8?B?eGh0bFk2VkZhSFhHdUc2OTdILzBwR1B2UU8xUGlEUE1sVXRmUTFWdXJySDBw?=
 =?utf-8?B?ZExOeEw3TjcraituakxnK3FKczFIUlRHaFFWUjRIbHNpcldhSThLcU56d3dv?=
 =?utf-8?B?S2JjWmk3cHRIOVNDb2xyQ0VaM2pzdWtqRG4yaHBWRXd4TEpIdXh1eFJpSExN?=
 =?utf-8?B?RU0raUlFdkVwQWhlTUtXV1l4UDFMZ1lIcFpVTWhyUHkrUjNxZzY5bmttTE5z?=
 =?utf-8?B?cWt3cVZhdDhsTHZGVXBnM2g1UEx0TU5WSUNuUVU5UnFEeldPOHRkcFhFT3Zl?=
 =?utf-8?B?aDRwNnU4WEJpV3ZPTkdyZTdFT0MwdDBCMUhJUGpERU9DdkZHbmY0S2lvRmdy?=
 =?utf-8?B?d1h2bHQ4Tm1XME5TQTlaQ3ErN2pIVmhneGRFUVA3aXZpcjk0Y0RlQzRPRnIz?=
 =?utf-8?B?dTczcFhYRDQybWhwVWxNRnRBcWluS3krN0NmM1IyRXNxaXpzdkFETWlJbzB6?=
 =?utf-8?B?YjZEbkE5ejRURHYwTWtKamVKNWE5NnRpTWpmcmFJOTlXUldHZ1h2WitBWmhU?=
 =?utf-8?B?ZWhBd1JxMm9ycjZDOTVmVVpuLzJWTEJCcDY1NG5jaVUzN3d4RlhwbE1Fc2w4?=
 =?utf-8?B?MWpjcFRMQmJic3l6TEI5cTkxNGdnVEJZZzJROGtNVC9uNEc4djFsRkRuNjRh?=
 =?utf-8?B?dDR2OW4zbXpQMVZKOWpDd3p3V3pmb0UxY0NmYWlmWlkvSmE1MS9FbW9kWXQ0?=
 =?utf-8?B?TGQ5R3lvUmFIb0piWUlrUE00RGFwcjBra0dLY2ZVWDI0YVJGOStxTHgvN0VZ?=
 =?utf-8?B?dDd5N3F5N1RpeVdDdWlCeTVMWDhxT3h3aU8yZml2cmZUYVNqYXZvQWVyNG9k?=
 =?utf-8?B?MURmcXJ1a214U0sxNWQ1NmF1M3RQZGhQRnlOZlhyT0NqVklMaDR4bG1xdlZK?=
 =?utf-8?B?Ky9ZYnVDSlBsZ1BaVk1yVG82Zm83UDhGQVBYcTNUa2QyOTJZcHBBY0R5Z0lE?=
 =?utf-8?B?czFWZ1lHOFhNak1CUlN3N1hTV1V3V2ZKUldWOEJHMHJqa0YyZU5veWk3Mmph?=
 =?utf-8?B?eDNNWkI2WU5va0NQMWdWVG95TjdXNkhLZVlSL1hhVzh2c2xLUmMxemRpRVcr?=
 =?utf-8?B?QVhqeWxwMndITTNxUzlLQWFYcUZ2VThWdlNQU2ZZK3VKckFDcHJMcGJDWUhD?=
 =?utf-8?B?bmF6K2ZVa3BpSEpoTlFSVnphc3lDOG5DdkdQVmtYU2VKQ0ZHZ0pSSldUaFpZ?=
 =?utf-8?B?TnUxRzVVSjkrcldtL1FsaHlaclZjQUNzaUxpVnJOY2ZwTDRMS0xWU3ZKNkVm?=
 =?utf-8?B?RWpzWmtCSjhrOWQ0ZGNOYVlDM28vdWx0d2ZvTzdjSk9GQ2RmWVUvMGs0WUJu?=
 =?utf-8?B?azFoV3I4MlBXRkliR3dVa0FLVkRnVDlrbEFVRStuTEhZV2lCV1VIVTNZOHo3?=
 =?utf-8?B?K3dwMWVGQ0VULzVWa2I1NEpaSm44ZWFQbmZsMTMzRUx0ZDV3U2dpaFgzdHMw?=
 =?utf-8?B?anZrY09JTk5ObkMyeGdqZGlPRWFaeDY3bUpSZnFKR1VTS1Y5ZHUvWnNyd2s0?=
 =?utf-8?B?VjZQajV6RElXczBmOWlrYkQyZUZhdEhEb1ZXUDc4TWM1NjkzUGZKN3Ura1BD?=
 =?utf-8?B?REMyU1RKMWdJYmw2VFFpZXloQnhnMTF3SlhteEpMaEo1MURuejdKY2h1aFRn?=
 =?utf-8?B?eXk0dmc2VGw4MXY5T1p4NjhoTTZRelF0OFNSWnZXU0E3WGhKakRYWjlKSW9D?=
 =?utf-8?B?UDNIQnRwZFNCSXo5b2xZaXJSUXhpeDNFV0ZwbEdHWGp6UkhvNUhJdDZlbTli?=
 =?utf-8?B?M0FUaGRTZnJ2SWV6WXc2NmJOSEhxZlRXQXVBNm9mQ3FZQXZ4djBCSUFFNXZn?=
 =?utf-8?B?ZmNtZ0FvMEZ5QkVVS3cxQ1ZFQWdWV0ZHT21NZTJNUjVNMithV0Iveml2UWFF?=
 =?utf-8?B?ano4eG54SUJEd3ZrdTBKcXVBYUcweXhSbHgvaXlhWEhVWTFhVDJxRDU4NzQr?=
 =?utf-8?B?RlJLRzdtY2VpWUJ6RGhydjFOMnFIMnE5dXdhUHNzNGZGRWpTRHV3VXkxdGZO?=
 =?utf-8?Q?byn6OuSbjc/PBRUHs1vkDjBCoqqvtDqVxP++Co6ulc4Eo?=
X-MS-Exchange-AntiSpam-MessageData-1: 3qBECWz/uodUIQ==
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ff9f40-a59e-4e04-dec6-08de552fcfaf
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:48:17.0572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ks3EQlrBQ95KEIBHqjqoHsY0DCoN+sRE7GceMaq9WldWO1+AmCWvsBqS+5lK1SCmKLqhHS0drINdVUE/ypTPO9+bh0SQ/dDZjU+TPat82k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1956
Received-SPF: pass client-ip=2a01:111:f403:c213::2;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
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

On 16/01/2026 19:24, Pierrick Bouvier wrote:

> In practice, it may return anything else than 0 (see arm_cpu_gdb_write_register for instance).
> So the right (vague) description should be:
> On success returns 0.

Hmm, it seems to me as if the code is a bit inconsistent here: the
plugin API in plugins/api.c returns -1 if it detects an error directly,
and the arm_cpu_gdb_write_register() (but it's similar for other archs,
e.g., x86_cpu_gdb_write_register()) returns 0 if the register is unknown
and the number of bytes written otherwise (in the arm example: 4 for the
general-purpose registers).
That means that currently, both -1 and 0 as return value indicate an
error.

Thanks for the catch, that made me dig into the actual gdbstub code a
bit more!

In order to make this consistent, there are two options I see:
1) Change the plugin API function to return 0 on error (but then it's
inconsistent with the qemu_plugin_read_register() function which returns
-1 on error), or
2) Change the arch-specific gdbstub functions to return -1 on error
instead of 0.

What do you think? I'd be happy to prepare a patch for either option.

Best regards,
Florian

