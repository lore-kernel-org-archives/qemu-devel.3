Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398EED5CC95
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 09:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVRTp-0006tw-DU; Tue, 16 Dec 2025 04:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRTn-0006rA-Oc
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:36:27 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vVRTl-00080V-6V
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:36:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zslxx6tFuX27jJh5xqV2Kh3tks20sp50Wa1k1Yn1iNztJ+XHKDF8l33+fO+uhyNKU5LCWFvmzbgPR0UTV6qH7OWZbC2Q60LdcVMAEXBdfmkCldG00q+u0X28Ve99r4l9rvjS/3OvJd4PG/qeclWi9cltmiT0RS02y04/pNW8fKqPs+a2J7ao9rL0Esozc/KuMndYDehobwWGydP4gv2yM9ndvYt1MqCyAv7yJLc26mqSfkwu6722v+Ehl3/21FtiLlAqpbIRLur2e56ZhXHcypyxV0p6QGIJGDeunyJayrXMheyECD14sjC1jQXNxnFIYscvR8rCKMSXkUtnZ+3TXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LuD9nzL7mKFFaTPCjrTKr66hr1DlzE+CcHPUULAH3c=;
 b=lzD/GnlGk4WIihfAOcnU+dhrlSY4HdKJniTtHANbgAgyvzWYZtyAhPh6nCn6tbqG4eGyVjYNdJNnPx4VMKbc1qP9ufxoS+46KV16zn9glxNY8FzQUdpraXoNx3C2S8bV6dQZha3rZvLFjGyE+mNNinFM6mhei2WwuLoEUxIEoAN3jcfOuzrPf105+BYtEWlAhuc0mNbPiNFNXhiZEX4QYGVUL/zg0Rq16pDI8xy7YcWzegAAeWizgQw6+ascmQoT9FV2EglaIACWIAlad3JrLkwN1b0MSkJziBj1WjdSdPeZGPnkrT7qbqqLoLaQWCzxFg0r+w/ypn/TLCBU+hhSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LuD9nzL7mKFFaTPCjrTKr66hr1DlzE+CcHPUULAH3c=;
 b=sWD8A915QV0jVbP3JphdOEBGUlwWcCLrV9x2E0ZBWBL4VNWQlOH6yLBoz6+DutiYRapQyFomjFe6qPWhJYPu+WNGq609b8Gz6KwLYeq5+Ee6UEklUVh4buVX4/gP2R6Qzj9Nw4u+VAin8gDJdF2dbN8HVkkO9weO2Y87AGiAEcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR0P278MB0991.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:36:21 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:36:21 +0000
Message-ID: <96b1a672-e1cf-46c3-8760-db555ac7e98d@epfl.ch>
Date: Tue, 16 Dec 2025 10:35:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] Enable PC diversion via the plugin API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <f06e2059-9d86-4a5c-acff-84cbeabcfb06@epfl.ch>
 <87ikebucv4.fsf@draig.linaro.org>
 <f9c8243e-1b34-464d-a6ed-d26e5b844fcc@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <f9c8243e-1b34-464d-a6ed-d26e5b844fcc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::11) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR0P278MB0991:EE_
X-MS-Office365-Filtering-Correlation-Id: 1728f5c6-2db5-4b9a-0bcf-08de3c869277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHpQUGFKeVdKTFVnK3FGaHlPdDFrMkRVeEJHcTVxdGdpU1UyanFITm8rWlZa?=
 =?utf-8?B?MGpQdThoMW1PbVBuUzFjOTQ1V3BwWVlRYk5ZZ1l6alA1c3NRUTMyeVVsMWIz?=
 =?utf-8?B?N2FtczdLN1hZUUVaT0YxZ2xNaVhSeGx1aVNKaVNROTlUdzZ4Z3hvbVFiOHFk?=
 =?utf-8?B?QTFURzVuY3ltSEZYZklSRjdSS3c5R2hTTW5TeUI0elBQMXdlL0tGbWcya1Fl?=
 =?utf-8?B?NVg5MVRzRWowdFE0VXF4SEYzc2R4ZDBlQkRJMUdEZ3BlZzFjL0I0dEpxMmty?=
 =?utf-8?B?emNpQjFkMVAzOUJxMGtWd2tSSTNaeUpud2YxeDFGY1lIY0tadEJoRTM1ZHNI?=
 =?utf-8?B?bXVlK01DOFI1MzJNYXhzRkRYdlFpMFZJOXZRYnhkc3h6cUZ3bUxJVktKNkRR?=
 =?utf-8?B?RTJMWGthOWFhdEEzem40clZtQ0VZTWdwT1IzQ2ZUeFhaWkZMNHkrN0J3QlQw?=
 =?utf-8?B?S1U2VXA2UGdQb1FxUWQvVHlPaGswRmttVTFURWxZYUdndjducUp5NTA2dHFL?=
 =?utf-8?B?ZkFoZm1iZUVCa2pFYkprTk90TXFKKzFCZHNYT2I4L3FFc3JScU9uOFNDWGVo?=
 =?utf-8?B?VmQrRGVrS0twb0tHSHcwL2lnQXdyOXVySUhpVjlXSjlGV2dSRVdXZ25SU3pQ?=
 =?utf-8?B?VnJRa2JaWDJjU1pvU0Q5aFA2MUhnWG5kS3JLUmVnakpFcnRXdlpvMDVHODd1?=
 =?utf-8?B?MUNUdnM0aTltUUtYdENIZWF5L3V4RmJNWmZSczJqSVA5V3NsUWhoZEczUnhY?=
 =?utf-8?B?dVg0SmRzUUc3UFc0SU9KWHltRDUvRE9POUNuZS8wUk8wRkxQSGI2b2prUFBM?=
 =?utf-8?B?RHFHV3U5S2xSZmtOSjFIWkxycTdLdVhkMm5JUmk4UzcvU0F4VmFNUG1lRzJR?=
 =?utf-8?B?R2ZUTm1WQ2VFYnJYZ0hXUWl0eUpIN0l0WGFac0RtdlBWNHNCQk9zakEwcjBI?=
 =?utf-8?B?eCsvWldBOWZYbXNaZFNNQTlxRWRYbHdvMlhNdkFvdzFLRTRZb1V2V0hwRk9J?=
 =?utf-8?B?RkxuQ1YvbE82c2FwNU9GQWl6L1NENnhhWE1zbzdDYllWN0RQWmNKMFRrTmxE?=
 =?utf-8?B?ak1wUGFnNnBKMTFZdVptUGZqVGZlRlZmeXo1eGJUTXJjaWo4VG1hRzhidkVh?=
 =?utf-8?B?Q2NwdVdWVGJISGJidFV3eXY3Qnp3SWQ3aC85THFMaS9pdEp6TDRSVURXMEo4?=
 =?utf-8?B?ZG96WmNqTk9SZ04rd0NYa0RwYThIQnBqdlo1b0djSnZpN1daVGZoMTdxVTNO?=
 =?utf-8?B?enVzczFqNjYvbS83RmN1cnlteUdudXNLbUNtTHh1YVNrQ1V2UmpaUG5sbm0w?=
 =?utf-8?B?V2NhYUczWGVOdjFmU2dVSHkrRi9GLzgvK2xVcUNMbDk3QXVUYXNyQUNZNnJ5?=
 =?utf-8?B?RnB6UXFocW5yNUxLVW92OGZqMnlxZVFBYkJWM1kyckoxa3U0dG5WNkVjazRs?=
 =?utf-8?B?RWtlUEVYN3Q5MFA5Tk1OUWlIMG5RelEvWEVHZDhaK3I4YlN3U2dQK3VFbHk3?=
 =?utf-8?B?SG1JYWU4Wnl6OHhsaXMyZmdFWmN5TE82c0ZSNUVZS3VvdnFRZHMyeU1EOHE3?=
 =?utf-8?B?cENkNTRObXpSVTZRd0YvbTZyRkVQYjkvdDgra1U5VVVCOVZZb1ZGZ05yaEdD?=
 =?utf-8?B?K3MvMnhaY0kvS3pTT3V6QWttZzVqVU5aZHc0ZXJsV2ZSakF4d0xpOSthT1NJ?=
 =?utf-8?B?SUd1TjBuSzlUY1NRRDh6ZDJ2K0pnSGNKR3VPR0JERG8yOTdCWEpENlo5Q3pF?=
 =?utf-8?B?aW5wM0hUdTBvU3g3WGd3ZXB4MUhid0phYlhjWlljak05ZHhVZXVwNXozbGxz?=
 =?utf-8?B?M0phWUVWVVlIaTAxMmtOeHd5UzhmQ2lyQzl3TDI3UjRjNWZJa0VvazZUNjIy?=
 =?utf-8?B?RmJnWHdBUUJLSzM4eWd1RU5EcGdCbWdhY2xHRHFYRGM2Y2RzSjd5azdNNmVX?=
 =?utf-8?Q?rPKfV22vSjfdeg0+kyVzaLQ/ZqkfZ5ks?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHN4MjhTSkNOSmVGaDZCU09WUjI1SnlwbzZ0ZkRCMWpGVTN2TVMwYkF4ckNQ?=
 =?utf-8?B?ckM5Z2hxUHRHWEcvUzhqMG5MSS9IbVh2QWxvejErVG1NOGkwSUxSbldFejBQ?=
 =?utf-8?B?UlZHZzU4YzJ2VHBRZFMrY2ZhOVBOK3NtWWZRSTB0Nnk1SlB0Q3BMSHB3ZGdo?=
 =?utf-8?B?OWpJVDVnOE1ldmpRQ2RJS1lPNVV3QTUvTVg1QURuelpnMFpiTFdkR25UK01H?=
 =?utf-8?B?TEdIT3ZzS0VrS0FMaENFMS9qNXF6eXIzQmRTRGhuSjVMZ1lyekpFZWJzcUpr?=
 =?utf-8?B?bE1rb2VhZzhpSlB6WUFHaUtJeEdidkZyTVdlQjJNeHU0VmpwYnlQei9DamQx?=
 =?utf-8?B?QTQrL0QrYjJJKzZOWGRkeGd4aEtaQnZ5UEozbVMwU3lVb2hhSG9QS09xakdC?=
 =?utf-8?B?dXRPek1tYWM0UVNuVmV2SDZWc091QmlFci9lVVU5NTlKK2ZtOW4zdmpIOU1X?=
 =?utf-8?B?WGtrQ2MxL1ZNOFBldW1nMXhiVm8ySWc4aG0vdlhWQ2lZYkQrWkFTNGQrdjVx?=
 =?utf-8?B?d3BFdXlYK3N0dzRtMDQ4VUxnRm0xay9NSmtWN3YvU0Vqb0VtY0Fmdk9SZS84?=
 =?utf-8?B?SmlkL2ZFZHdDcHM2UlZNZXl6REhBNElCZ2czM2NRdGZJeHJsbXQwMTlUeVdm?=
 =?utf-8?B?T2JtTWZTc1U2UE1YOG1IcHQyR0tGZHpoT0lobGJ4TlpRWFhNMnd4eHpvUDEw?=
 =?utf-8?B?d0gzdjFwOUg2N2pXUlkvVUliZFU5Ly9BOEJ5azRTWGJEUTFMVVRleVRXcnB4?=
 =?utf-8?B?b2M2MndWZGV2SmlUQlVNU0V3aVFqNGN2a1V0bUcyM1RTTFRsS04rbU90VjdH?=
 =?utf-8?B?MkhjWCswNnJQR3gxc0Fta3NRci80R2E0eDV4MHN4cGxDb1lIN2RQVlJKUkxt?=
 =?utf-8?B?amFpUm1JaWEzSGprS2ZHU1VmdGVyY0c2RFQwR3VVTjRuTE1vemZnY1NFVTli?=
 =?utf-8?B?WGVuZmZwMG5LYTBTVTZ2V01zMFlCWGdYWk43NUNRR1FFTWNoZmJQa2JaRGdt?=
 =?utf-8?B?QjkrUXoxcHJWelIvVmdIS04vZW5DdG1rNHEvNGdBbnZMdUgzRzdob2NWL1Nj?=
 =?utf-8?B?RXRIQXhXY09FNmNvaUxXeFJXVnhUQVRQZEgyVlowOXV3SzUweDNtWmxFNDZx?=
 =?utf-8?B?d1NtYzhya053Ylk2THVjNnZRbHlCeDlnWVFzV1BsNTVjOGEvY0ExbTM1dkFq?=
 =?utf-8?B?ellaNy8wU3p5bm9BekdMeXFVd0ptdHVzR0xMcXJQOFNueXZXTVVuOWZnc2NJ?=
 =?utf-8?B?ZlV0c0F2bWM3YW00Z0M0RFQxUVJncXcrK1VFTU91NWdFUHBmZTczWXprV1pZ?=
 =?utf-8?B?bWh6UmpzaEsxU0EzaURWc0RyMXFlVitUNkJNaDlZQ0JRb1BmTXpnUVBoT01G?=
 =?utf-8?B?cGdQOWxOT3IzdWltZ3dqNklveHRzNFp5TUphamt3OTZ0K1AvVEE2WXJqUVNk?=
 =?utf-8?B?Yk4yVmlLQTR1TU85WGdUL0JYSS9oUjJ0NnlxQTNHQ2E5RHVyMXV5NmY5UEFD?=
 =?utf-8?B?OWcyWHV5UWk2dGFBeUdISVpIVDhXWjZCa0h3UldoYzlyeTRiN3d5Z3haeERD?=
 =?utf-8?B?L0R1dU5KcXFpWEpqVll3MWNkZ1dxalorVWx4ZFR1VlpNbGE1bWxFYk5qRnBi?=
 =?utf-8?B?L3hZRFFoV21GdHB4ZjUzUDFMVVE0TU41UFYxSmdMdEdoU2VNZFlCcVpuVUJJ?=
 =?utf-8?B?TkVSa0RPSWxLellKaDRMNXF1OUZyTzlDczU1SC9ZM1BqNGRDYWJ5WmNpU0ty?=
 =?utf-8?B?VWhxanJkbkM3c2RJTUxDa1c5MnVRRlZybGZzQ0Q3NTV3RVJEV0ZMNFdYUjk5?=
 =?utf-8?B?TzRvYVhuaEE2YldYclV3ZEVGd3FhaHBtbVlub2tLQ2dRYkdpbTBDcHBQMzcx?=
 =?utf-8?B?cEgxZGExSDhqMmFKa3FobzI0Zmpxd0ZRUlEvUXdNNUJhTm9lWWJEdXNUZVlD?=
 =?utf-8?B?ZGc5OVFIbFErUnRxaDlDNjNRRzZNRUJwb2JLL0tGQWJKTzBNZnQ1UXArVDlx?=
 =?utf-8?B?eVNvUFpVWnQ0d0p3eXRmdXVhak9PZW5WRklmL1k4RXp1VjkvNk44cU9VcTc0?=
 =?utf-8?B?OEcvWFpseVMyN2UrSjN6MDR4QWoxNHc4anBwYTd0YVpwaUNMSjJRK011WGht?=
 =?utf-8?B?d0xGeEtsT3RScHFXSDN1ck5sQkNEeWNmQWpTSlFyUXZGVTB1VHF0blZDbzh1?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 1728f5c6-2db5-4b9a-0bcf-08de3c869277
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:36:21.4682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xQJW/jmOKR6RvPxHcD7js1HMrdzo/+6slcdfP+CMwG0M5BKEVQkET/MhrGkmqxOEhrnzie1KuwMENnyua5jIISZJeR3aK+njTNHgZ3gVpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0991
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
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


On 12/12/2025 18:36, Pierrick Bouvier wrote:
> On 12/12/25 4:02 AM, Alex Bennée wrote:
>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>
>>> Hi,
>>>
>>> Sorry for necrobumping this thread. I just wanted to follow up on this
>>> and ask if there is still interest in this plugin API extension or if it
>>> is going to be dropped in favor of the Lorelei patches (which would also
>>> fulfill my original use case).
>>
>> These are the system call filter patches?
>>
>> I guess that depends on if being able to change PC is only for skipping
>> syscalls?
>>
> 
> Both can probably coexist, as they serve different purposes.
> If only considering syscalls, the syscall filter (that you propose first) is the best way to deal with it, as it's architecture agnostic.
> 
> That said, it would be sad to drop the effort you made into this series, and overriding pc can be convenient if anyone wants to filter anything else than syscalls, or for fuzzing purpose.

Yes, while the syscall filtering was my initial use case, setting the PC
and diverting control flow can also be used for patching out
functionality, diverting function calls, in-process resets for fuzzing,
or other use cases.

No hard feelings if there isn't enough upstream interest, though! :)

Thanks,
Florian

