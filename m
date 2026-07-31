Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466EBC55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpubr-0007Ej-6y; Fri, 31 Jul 2026 17:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpubp-0007Du-1l; Fri, 31 Jul 2026 17:17:37 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpubn-0000XB-3H; Fri, 31 Jul 2026 17:17:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfCiJGkDNMDBI+x4F1Wc0kgAWXnyZOl5H6ZEuGr3aRid4sZA84xOiwN29mfcgSpkAaLjmusxCGxO3x9nsYm1EnW0rpzJqaNvaZvaxklDV6IPmemlRit+wKhxB0RkIaOfNn2e5WswanrNc2nUn0k0tSJ2YJD9TENinY1t04/dG1HG71z5TmfI+YD2l6/qRy/JAUknHcds2UnrnADy3dp70CBPM+CoBu9yuVbjqRlyLeiuBE7soAwZWDFJOV7OPBqDGIZP0TvNiIVaQbOhHc5jlrT8YaSGxcaSbKEhZ3srPqPm6rxVdCjqcZEftu2Eqnm1QDccS1S05lqSW/v6xuV7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRK0OyxTJghotg+SekI5BYLoC8wSBeGQ7918NSHchns=;
 b=OjK1F68iGFkh27EIHd7dgpzMw6c09RSNnI9qgZlCHPb0n6rWHr9kx6fSYrQBDTRmXm0i1OqGAyqXz95CEyzKerPlg/L2TWIKl5dKsBiNjFgtUUbP7agUfZ8AsJx6JB44opXiaYd2cwIbo2dYCskko4exbtSSjWueBtFrkWC80tBUiSMhcECFnUVZTb/P3X4sUvPAf78yuwxrL/jrLqmoJ2nVAel9gwqH0fSn3YTSP/NxareoYSj1BpczFPVjB7Eup5l+ZsFSgqfDE2Sc6B/2h/8WrxVP6Zi60MCVb/29S/OB5227V2Le8bEd8NgO9QcusDuO4FmnRYSUuOVkyF8e2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRK0OyxTJghotg+SekI5BYLoC8wSBeGQ7918NSHchns=;
 b=QgeZvNlqv0LZtv7h3dyAwzoG4TKzB0W5sQiMg6ORk7F0ETfZOV7bNMelBQp0Cyrc6QcBdT5OwScsD7+wcctHA7zxuFRlfvQKM5fsug5cj1KzhCZWn/E4+Wu5sBYXOFFyBypxRRBsZ5X/nAJtydrZBqinhyzRwgt/lg+1zt0ilUU9lzbjpJaWpEy3+vQ9dVR6FlQGt2PC1X7VVzZmopgCd9sh9nGAzfcs2Yoy7pxv9YCdf4HAqZ9GrS4dz2XBuBmmHj5Aw9wyJ0Iec+83Hd/QtPn5zCH4dR2AbrwzDzdyvFW6QI/CqXt753V/wEKIH5m6T+eEIlrxSNnk+vvnhiV18A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB9885.eurprd08.prod.outlook.com (2603:10a6:20b:5b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:17:29 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 21:17:29 +0000
Message-ID: <3f84a950-d079-4e05-a3c5-daf81672b3e4@virtuozzo.com>
Date: Fri, 31 Jul 2026 23:17:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
 <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
 <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0067.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::6) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB9885:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4fc83b-4021-46cd-8566-08deef4920bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|23010399003|376014|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: tDFl77BaZmn24SEhMNlrMJd4eE1xNmM0l57XqO8on2VgiBIdbwZvZefLdBLMN2ob+6snDsKuXdZok2hVhLRybhyDmx2CV5B4KLo2pBJuIzrytpCZ3/R4lr6U0CXceQf18Vo5Yr/0DbRxqw9jHS7FhLKe1Wx98XJ6TrFVwUAH4oTaVCoMsXx6gNeTi6Zy/UVJXmrzeN4smt2da7tN6TsC9Ce0FKNdkWqS4UWAiPZj6OhFz4sFYetonByndw+ttIn/rG+yih+WKZOGIeQDNVT0bOAnxKJOCrkd1MxzQrOAQm2AlcX5mHFu1vYaAGc1D0YZoqpVssG7OMwwCFnlKWFjeIGDCvIKRzGngvOrTuORBbixd/5TngAQmJ/mRYHn4fo7WSsehbqE2EzD9KhtCHzaXuLit2IWCTg2nYwTC6E5wgOk9Lm0ilqB4/qSX77iU2kpCVWXQTQ7ORg5bzQVkttLWVS/psDWCKvejTZBoLZzjlNrCYLsvoJ4vmtCZUEs8lLeesAPFXhNS36DVEnjCjO7rJvvjtZ6Q5jqJ5ESLL1i8GaKRlBQ8ptFfVBl6OE/m8i2ck+wstuVW6lfGlLbKiMB4kjOwq1s+9pupgPeaehv+Z9OZ8Kj9AkRagPvBwusr8/T2ZADV6clnEgBZYuN1Iex2argNSCWNugHur/LvjrA5pU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NLaUdmQ3hRNVh6d1V3M2prRFNkdzArK3ArMkhEeDBUS1h4UWc1TiszeXFZ?=
 =?utf-8?B?cVd1WDA1cFQvejcxZnF1YWJFVHVsMWxXeWcyVVJoR1dWT3hUT3JxWXFkVzdv?=
 =?utf-8?B?OU1LajhUNzZhVmp5SFU0L3dhYTdWYytRdjRnUkt4eTI4U1U2eXdPaklCQSsw?=
 =?utf-8?B?V3NKdVp3NFRVZEVudmhEYjBidlRObHBUdVBTV3l6N0N5N0dJMmZFUG1GR1JX?=
 =?utf-8?B?WTFTc2ljQVFYUlhublpvODl5aUhtUFgrM3BtWGNFVmZXT0Zxbjg0OTdDYUZw?=
 =?utf-8?B?bmlkSGx4MW4zSlY4WllEdStQRDB1Q1NpSlVoN3VZSzdEdFo1a29ONHdCTTFG?=
 =?utf-8?B?VU5tYnpscUNGRDI0MnVuM21YTy8yS0JNVFZtSytLWXk2QmxYVDRvY0p4VEFV?=
 =?utf-8?B?RG9BbDE3ajc2UmEzOWJzUGJHbmJmMVJCN0poZDNPY2NYY3hTT2poR0tUQ0Fq?=
 =?utf-8?B?dnJpZkd1akRCZldpTWoyVXVXaXYzOW92RDFJY2U4K1FWSUd3c1FMTy8yOWh5?=
 =?utf-8?B?enVaQkY4RnhyR2FtQXJKdUM1amlENVJiWHFTWFp5REtFUlg0TVFNWEdJdm55?=
 =?utf-8?B?TnZvZk43b2JzakwrMkJOeWkyQzVJTEw2d1AvUTdGVEpZSElqVXFwNTBpVys3?=
 =?utf-8?B?VmxsL1REN3dmaDFwOEF2VmEySHdtWWQ5cVEvWTdHZnVEQ3YrcnlnWU9kTmJq?=
 =?utf-8?B?WXdyRmJEdVhGSklidlFIdkxhMUQ2cUFGbllHSTBhUkJXQUhURkcwSFJkclpV?=
 =?utf-8?B?bVROd0lnWmJiMXZHZkkxYkxEcXNxbHVXVVg5YzZVVTBjNWtRZ2ExdksrZytS?=
 =?utf-8?B?YkhCdDU0cHBSejNQQ3FlOTd1TEk3ZU51ZHFFdGJiNURmM0RoaUNKUm1ta1ZB?=
 =?utf-8?B?c3E2Q0lYSjhTWWd2cnVheGJJV3VlRmlSTnkydFpTT2hkWjNZempDYnVYc2tJ?=
 =?utf-8?B?UWQrTnZHU2dLQkR4WDhWVzJDTVJiZm1ISVhUcEFEVldTSFNyWjIrM1VmWW55?=
 =?utf-8?B?L004YXBFMG9COW1WZFZsQklHa2w4R1JZSzFCcE1BeGg5cnEzYi80NEpuUHl3?=
 =?utf-8?B?eEtzQnJmTTlzUFJQYkxiSXFKczUwaVFCUXVjVVdCNnpIemNua0d0N2pwZ0xQ?=
 =?utf-8?B?ZlJRR0U3N2ZLbnN3bVpsRkRuMTlRNzlVaEp0TWVNOENFVXFxNllFeWdONy82?=
 =?utf-8?B?NWhyZ1h3UGZIRFBLbkNBTjhMOEJWN0Vzbmo5RnJIRnU1WjZtRmE3NEpGSUp0?=
 =?utf-8?B?eXpvQnFSSWFpVjRvMUo4ZWk5QU5yWHJBS05FKzFMQUovck1PSkZvRlBTaFBC?=
 =?utf-8?B?cnZiQ0gxQ3l6Y1BnRWtJcVRJRDFleFlISmk5OU9lYndVTnNFZmlobHQ5a2ZE?=
 =?utf-8?B?QUlzNTVnVnVBWFh4S2Z6aVhMak9vUGNURi9UcEtHVS9rRjlKSVJocWRNcDBo?=
 =?utf-8?B?NUFuMWhBaWJNM3pFQzFjSC9neXIrZUNkSWVhUXFPb1NTUEJyVlRPZW81SW5v?=
 =?utf-8?B?Q3dMWVlXdTdvT0J6dnlVbW4wYncrV1p6ZUlLTW04WVhvV21STUNLdUx1Q0lx?=
 =?utf-8?B?SFVEbHIwRFVPOU4ydlFkYlByTjRWWGlsUTRIUUpzQzF4K3JVbzZHZENldHgv?=
 =?utf-8?B?Ty9LdzIxb3NxVmpPU2FoSS9relVobkV3aE54WlJrM1R0M3dsQkVuWGNKSnpN?=
 =?utf-8?B?QXhIM0JmY1BaNlZ4NWxKM3d0WDErT3lFdys2ZHhxZXhNRUtpNWdFSURZRkhT?=
 =?utf-8?B?MnIxUVJNQVIxNmNGQk1NMWVEZmtSZmVoSlNhN0p1cHhPMnArV0VLRHRkQnAz?=
 =?utf-8?B?VVZLdEg4ZjhsTWNEZDVjT1RYbXk3dU1pSWVFWEJFSUdXdWhOMTZpOGtEZ0hK?=
 =?utf-8?B?c3RaZ0h0cGIwMGJIakJ4LzZDRFp5SWZseWVMU3BIWTNKTUpsVXJVNjBaMDRK?=
 =?utf-8?B?dzhHTHFhMUhCSm12ZnJXdnFIOUl3ajZlRlNQb0ozK3hYM2cwYjMwVDdSNXgw?=
 =?utf-8?B?NjdkYUViRjdaSXVpeHBiUkJHMDl4blJabGllM0NFdHZNODJwY3pjdURCZWpt?=
 =?utf-8?B?NkNDUStQOVBlWTJMSm5uZXg5RTEyS2tEK002WCtWb2V2eGh4ZnpqMkpoTHh5?=
 =?utf-8?B?TmRVdVZQaFUwS2kwN3BiZkdrZGtXRy9NYjI2ZmdhQXdmS1hsQWRscDBoKzZj?=
 =?utf-8?B?M050ZDRWT3g5RWduR01zUnlnYjRWSE81L1U2b3RKdzMzeUEzY01RMnNuZi8y?=
 =?utf-8?B?d2ZHaTRvQ0NKYUUxNk0rRHJQTW9Jd1EwS3JKb0tIb0hMRDgwazcyMGxkcTVC?=
 =?utf-8?B?K0d6UGM4MkRtWmVXTysrbGRVNUFCNnA3MjVDZTdRTjRycDQ2TWhkaDVzOU8v?=
 =?utf-8?Q?+lAePqBsOFwscwhgpdoRTjO3R3vSqGXG3glPpyfeK4DCx?=
X-MS-Exchange-AntiSpam-MessageData-1: 2hK+QvrkE/H0oA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4fc83b-4021-46cd-8566-08deef4920bb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:17:29.5274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfSFv9fd9KaWBMZ6jh14EnjS9tPYOdUFv03FE8ReLh3vyHBcKNrcW23Svc/COxHdKRxj1/R4M1WrOlm/oXZ/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9885
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 7/31/26 22:18, Stefan Hajnoczi wrote:
> On Fri, Jul 31, 2026 at 9:45 AM Denis V. Lunev <den@virtuozzo.com> wrote:
>> On 7/30/26 16:55, Stefan Hajnoczi wrote:
>>> On Thu, Jul 30, 2026 at 4:14 AM Denis V. Lunev <den@openvz.org> wrote:
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> ---
>>>>  MAINTAINERS | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 902db77218..4628793dde 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
>>>>
>>>>  IDE
>>>>  M: John Snow <jsnow@redhat.com>
>>>> +M: Denis V. Lunev <den@openvz.org>
>>> Waiting for acknowledgement from John.
>>>
>>> Stefan
>> The situation is not changed in general from yesterday.
>>
>> I can drop this patch from the submission, that is not
>> a problem. The problem is that IDE changes are not
>> moving, f.e. there is another stuck item for
>>
>> https://gitlab.com/qemu-project/qemu/-/work_items/2399
>>
>> floating in the list for month.
> It would be great to have you as an active IDE maintainer, Denis. I
> would like to see John Snow acknowledge the MAINTAINERS change on
> qemu-devel before we merge it.
>
> Please resend the pull request without the MAINTAINERS change for the
> time being. Feel free to include Peter Maydell's divide-by-zero fix
> too if you are happy with it. I'll merge the v2 pull request for
> v11.1.0-rc3 and we can independently allow John time officially
> confirm that MAINTAINERS change.
>
> Thanks,
> Stefan
Amazing plan.

Thanks,
    Den

