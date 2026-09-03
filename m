Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B8FC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AsV-0003VR-TQ; Thu, 03 Sep 2026 13:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x2AsU-0003Uu-7x; Thu, 03 Sep 2026 13:05:30 -0400
Received: from mail-northeuropeazon11020131.outbound.protection.outlook.com
 ([52.101.84.131] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x2ArU-00058t-Pr; Thu, 03 Sep 2026 13:05:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4sQyeIlpWO9TL54TeLlkKLq+i8Bz/4BQjbb4OFlywe5g8xZbGNGCw6Ow1u6sB1nTmhwombM7Ui4isoRtbNE4AMwSaZyEMmyuhvlKtjT56LSH+THrPVVgIZna/NDMgrtc6LGB+MwMdFPY3M1P2r+TDERxFwsXI79/Lo34g0VKqJDB6GLDJcLt2mtM5EJHillYqJnMB5HH3Bhlp7REvzx2/XzSlfOvTuarUX1gZVqmUUNIyz/jlQvgT8IQB5j823g0YDXySkrlWjd7yk7WiKw2NcJHqEM33f91ML9YK2drckKX5RA4pQV4AjbdMnHOSN3vZpJuwpDlPFp148IQG+KVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq00WKBOGnhJHj9elboC5FEZZfFApKM7yh2H1pUJJRo=;
 b=CbvKVtOD2CRzty01qGKKZs9ITsjsx+rhFSfp+qHtWMbxREeMC6VrW/OwWcekrnJJo5xQ7Nn69Da3TdKeNp3aZwldJFWVhjl90UFw0/3toXALOcWyTKaqU+VL4sp+omvL5H3vhKs19YiMP2RSdl0UTjJjycEt7qZ72mecaEj9pVqdkcdVCnp2LhMMilwXJwspn6zXsR9X/dVGXYI49i+eeB7mJz8MNjcPmKiLzOeOITQ/VPIetFMIFmj6Sp9h22lpH/Z2IJjqsKs9tj9u0E/ou7WI9Qca0tnJIKW1PKO9bmwuXjJsxcQL5LpIlEYg4ELv17aXR+zVvWEYbEWdqtJn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq00WKBOGnhJHj9elboC5FEZZfFApKM7yh2H1pUJJRo=;
 b=s/aE7oIs9hrV49WvNSXviRBmWe+hzVl65SM2psCV3H+25SvMZWznQ4JSWgDk3G1CBEaACKNfi8RFfxqkGQTG0+sk3gWHEHK9z74ICOma1dR66F6YPmXIWkSpKCTI6bRLiX2vz9oiS1UeY75QXeQgFYX8EEvKLgrj55T5wIX/BiAAoQzHMPv5xDFzfrnfDu25Xxai5Qx6KJ+Ufu/VcHy+6Gr8FOZzT3Mlv6s5VJxu6581FiddXjnAm4Yn3/VsQM/q3nhiq9EIvTyQMct6x9FBeGsAV4F+kr9bWI2Ombi5riNMmne74IaIyKCuRHD1C72zctik+x9wwi9Di39B3DbxTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB8899.eurprd08.prod.outlook.com (2603:10a6:20b:5b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 17:04:20 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 17:04:20 +0000
Message-ID: <f24a0f08-3b69-4bcc-9fcb-be7c611926f5@virtuozzo.com>
Date: Thu, 3 Sep 2026 19:04:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tests/qtest: fix the disk tests on a host with a
 small /tmp
To: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
 <20260824200627.2180635-1-den@openvz.org>
 <a1a7cdc7-5458-4d1b-bf1e-9aa89502317b@redhat.com>
 <apAZaRwIdm1yLiLV@redhat.com>
 <8604eafa-c683-4d89-b180-5b26c56b7817@virtuozzo.com> <87jyp2gtn0.fsf@suse.de>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87jyp2gtn0.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0044.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::15) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bca47e-200a-42aa-1ccf-08df09dd654b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|10070799003|366016|4143699003|10067099003|5023799004|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: f/BMpUZd/cdiBl97au/E0Ebr8wejmE9PifskcTs4FMCgoClsqCDLrQ1XlnW2HcQNGRRh5o+PYkpMLxzLMBEuo8xg8lGMO6GEQYtgZj2s5qgEQT7PP3I7yKvR2Lc22szGM5lPjSd9fFwxcdmNOEPVribSchAav4mLR/KaL0XJgUDwqy110lF3RqUztSHv1WYFOiasyw/EU4bzDiQHf7OG64v8pv5CkBD9ll6YwsbXgzdo8s7CvEekdxPx6Io35sPpJOEKjusp33ZM67KwNsdLpV3Q85qoefjEWhX7Aim/m4lLif4/n7qYjOtO2yiP221VBKBQg6zll+JS2oKpHjKE3Vv6ool7CF1fiLCJs638ps9WW8URBUQrb+B8A8dV9oJk/z5lCe+ppZW1WBTksEaX3pLLq2eS+RB5O1kTIc9Lg08tKyisuM6V+qXKGQ/kKsVisVbOHUNaKzok8+fxCXj2Nt+Nj1/CJk1HWVDVONyyvktFjmZSidXmyS/umnBSrkeg4eR/FIoe2baGB0MsPt6V6jWGMnP5kKjzIkcu4DutuRcvSLL5wO5ijQG/31qzSV0BMJFZ520TzwMsDYGXMdDYoddXPfgKT5mAyTC23lqz/ME/0bd9L+9lLaE07gHSuYOIe8HD8b0ZdUH2ezNMoAaSMcXb+UKBF1aXNr4zaG4WdZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(4143699003)(10067099003)(5023799004)(18002099003)(22082099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QklGMkZiZlNhTnZvTEZGMC9EM2Vsdm8yV2FVUGNMVkZ5MFFEMnpSOGt4WjEz?=
 =?utf-8?B?TlBueHFvS0NNNzdxQ2VPL3QxMW1IelNRanN1MEhZYUE3QzdQdjA2emFrVThH?=
 =?utf-8?B?b1d2V082ZWJIdkNCaUZDTmttQmZQdlA1Yys4UmVRTHRUY0ZWUkRUZ2NZK1By?=
 =?utf-8?B?QXh4M1dQSDFuc1FFUndubTdHbnIxRjJPTDNMVEVjdnJxZVRDZ1NJeitHb2dN?=
 =?utf-8?B?c09TelAxUU9qN3hBRmtvbGpaUzh5TDlkS0FBa2p1VURkV1h1c3pUNHNHRCtI?=
 =?utf-8?B?OTkwdUdvQXZtMkFybVEzbXBSMnA5YWN3bVZWOTQ3NUVmWUR5dWpYK1pnUmo2?=
 =?utf-8?B?MEJ4UW0vaVM3RFZ6TWZ1aTVZaTdoazU1WTdUcVBzSmErY2xjL21meC9xLzNN?=
 =?utf-8?B?MFYrMmY3TEpxbUEwYWEzaFU4VlJMTGk3VktxMTFlR1R6TVNUbXhBL1ZhVXBv?=
 =?utf-8?B?WnUzVUx1d244R2o3YWlSSWVqeGpHZmNNK2V2ZFN1c0dnMjhEN1R2TENvcThR?=
 =?utf-8?B?NjQ3V3hqZ3BwRFhxTDd5cFEwMGdFM1RLb083c1ZrWmQzQ3lsZktCeUhBdTEr?=
 =?utf-8?B?WGhQSmxVQ3IxS3o4bHZQMDRuVFNGdFFjV2ZHT2NGR2JodjFjNHBvL2xTTmFK?=
 =?utf-8?B?VzFVRmo1Q1lzWUdSUHVsS3NMUml5YjNBNGZpeEwwdmx4RVp3TTF0MGtCZzB2?=
 =?utf-8?B?MlRxTlBKK29ueTloNDBLaTN4eGgrTjNSQm15SkdtYW1IYlQrenFxeDh6VFlX?=
 =?utf-8?B?M2VYQWhEVDROTEFUdGJWWCtNZzFaeUFxQTJnbUtrQTBqNVM5QkFEVDB6MnZF?=
 =?utf-8?B?c0JCcUQ1U2xIczR1cCtIYVZ6SlVEWENjTTB2T2d5amxUR3dTdW1EY3FuNUF4?=
 =?utf-8?B?NFlMOXpsYlN6L1o2VEJxRjBsZncvRm51WENJN1hLYWUrYmFxem5sWEQ1WjJt?=
 =?utf-8?B?YUdOemRnMFR4Vk1FTlBFZUhQVURYT3B2Ui9KbWE0SmNHMkVORG9Gc0Uxd1Zz?=
 =?utf-8?B?UnNsWHkrNXpFc3hyU2loVzdnTitDZHUvSnZTV1pCNVVrQlpjbU5WdWszN2hG?=
 =?utf-8?B?Rmp2ZHEyZG1NSjZDeXVtNFZCVENWM3FNdUlsUXJyT1NzWHJzTnFsY3M3SHBp?=
 =?utf-8?B?cWJVcCtuUU0xeHQzcTN0QWdYcE01UjdJNGx6eGZDeXJQMnNlcWx2YXBtS09k?=
 =?utf-8?B?ekFQczkzQkR0ZFlHb0lSMDZJYzVMWG1sUXE2ZU1DWGFIUWFxU2NxUW5jK1cx?=
 =?utf-8?B?OTdHZndISytoQTk1WGhaNE1BR0NDK0JBVXh4TTJiL0xYMkg1ZkQwaHpGSnRO?=
 =?utf-8?B?WHhOS1QvekxObStZaVFtVGhqM2NMZFArNHBiYjM5dTNGNUVRa0M3SjRBUDNu?=
 =?utf-8?B?VW5yRVprMFpzTzBudHdIb1p4N05uWWVjYUF5Q1FKNEp2MW00dmZDeElYcEh6?=
 =?utf-8?B?WUtWMnY2NDRIQ21DL0dEWmg2YXd6eC9nQ0Rmeit4YjJ6YjZLcXJjV243QTZx?=
 =?utf-8?B?ajdDMzJWOWVJSno5enZRM0diWVpKRG1tWkVYbVJrS2Nzd0hyOFFTYzFFdkNn?=
 =?utf-8?B?MW1CeFhJWUhUV0RLbGZjam1tbWZ1UmNkQVEvTWZORGp1eHhobG5ZU21vcFVF?=
 =?utf-8?B?OWhzbm1COSt1SkJCQU1sWStPQlg1S0FLTlZtWG8wMGY2OURxWEFBM3dWV0U1?=
 =?utf-8?B?TGVQZE9PWTVXbHBieXMyM2ErYUc5bHdTM2JqUG8rSHB0bFI3aWdFYSs1ckRm?=
 =?utf-8?B?KzFwRG1DcVZHK01KV0k4SEUyaTV3Uk9mcEVYcDNuZEpwY0IwVzBmc1kxdDZy?=
 =?utf-8?B?MzFIMVBkc3NPclVFOS91enQxc1hKV2NlNk1udTZuZmlINGQ4bG9oemlYOGJz?=
 =?utf-8?B?aHdVQmRHajZOdEVzZkNzSm16TVJVdFNQQmpYMUlKWFFpbTNzMGs4V3c3dk14?=
 =?utf-8?B?aGhBNWdNR2ZqZEREbGRpQXRUaVN5cEx1T0wxSlZ3ZjM1TjZpcnhBV2tzRS84?=
 =?utf-8?B?a1RVK2RLWnUrdS84dDZURzdDc3pHZnJ5QWNzUm4wTDBsQUQ4SERiUFNpcWVI?=
 =?utf-8?B?UHMreFVIS0E3Z0V5RTFjZ3F2V2RubEMyNGZtOGxuZUh1S0xaOXRoZkwzTXY3?=
 =?utf-8?B?QnBBVU02Ri9aemgwNzQ2ZWkxWmsrVE1lWi9uWjJFbmhVS2ZPbmtpYXFuWllV?=
 =?utf-8?B?RHozaTdCRnVrZyt4a0tVbU1FN0QrcWRieFRSOXM4cE9LNDFha2c1QWRrR0Qv?=
 =?utf-8?B?MTJnc1lXdkdaalZCMVEvZ3B3N1BXdTl3SkFMeXROaVlTYi9CQkVibm9abllj?=
 =?utf-8?B?bXBZWS9PSGxjQThOZWRka3E0S09mSnh5aGlCaFRsb1Zra0puZGxBdnBQMlNS?=
 =?utf-8?Q?52YozrhtqaD96GSgcmn9+zgi4TWO5xuhgDD/AZV5FTwDk?=
X-MS-Exchange-AntiSpam-MessageData-1: kbuqqLoGgKKxGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bca47e-200a-42aa-1ccf-08df09dd654b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:04:20.2908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB4VVPIhgq3sPGZrUv83uyxjTZaR0pTZef5PmG7RYhhhkVmWUEDfKnzpL9Z4Qn73TQ1bQ+J/vWEfV2a3IcWFZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8899
Received-SPF: pass client-ip=52.101.84.131; envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 9/3/26 18:57, Fabiano Rosas wrote:
> "Denis V. Lunev" <den@virtuozzo.com> writes:
>
>> On 8/27/26 13:03, Daniel P. Berrangé wrote:
>>> On Thu, Aug 27, 2026 at 12:16:56PM +0200, Thomas Huth wrote:
>>>>  Hi Denis!
>>>>
>>>> Please make sure to CC: the qtest maintainer (Fabiano Rosas) on series like
>>>> this.
>>>>
>>>> On 24/08/2026 22.06, Denis V. Lunev wrote:
>>>>> John reported ide-test dying at startup in the NetBSD VM:
>>>>>
>>>>>    ERROR:../src/tests/qtest/ide-test.c:1260:main: assertion failed:
>>>>>    (ret == 0)
>>>>>
>>>>> The hypothesys is that the ftruncate() of a 64 MiB scratch image. NetBSD
>>>>> mounts /tmp as a tmpfs sized at 25% of RAM and charges a file its full
>>>>> length themoment it is extended, so a sparse image is not free there and
>>>>> the call returns ENOSPC. The assert dates to 2013, nothing regressed.
>>>> Does NetBSD have another file like /var/tmp that might be friendlier to
>>>> sparse files? If so, maybe that should be used instead?
>>>>
>>>> OTOH, our NetBSD VM in tests/vm/ uses 4G of RAM, so a temporary file with
>>>> just 64 MiB should really not be a problem...?
>>> Or this is a concurrency scaling problem, or racing with another test
>>> that also uses stuff ?
>>>
>>> We hard code memory to 4 GB, but -smp we scale to "$NUM-CPUs / 2"
>>> for the "make vm-build-DIST" commands.
>>>
>>> IOW, regardless of whether QEMU is launched with -smp 1 or -smp 20,
>>> we only give it 4 GB to play with. We could be using a lot of RAM
>>> for concurrent build jobs leaving almost nothing for the tmpfs for
>>> the test.
>>>
>>> If we were that close to exhaustion I'd expected to see out of
>>> memory errors, but I'm unclear what NetBSD's behaviour is in
>>> this respect ?  Maybe normal RAM usage can be pushed to swap
>>> (of which I see another 4 GB) while tmpfs can't be pushed
>>> to swap ?
>>>
>>>
>>>
>>>
>>> With regards,
>>> Daniel
>> Guys,
>>
>> will somebody take a look into what was done?
>> This makes sense anyway - unified same class error tracking
>> plus requirements reduction.
>>
> I cannot reproduce this. I also don't think ENOSPC on 64MB is something
> worth the churn at all.
Great.

Clearly postponed, dropping this from watch list.

Thanks a lot for your time.

Den

