Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F2C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5KoT-0001ei-U4; Sat, 12 Sep 2026 06:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x5KoQ-0001dS-U3; Sat, 12 Sep 2026 06:18:22 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x5KoP-0004uw-4b; Sat, 12 Sep 2026 06:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1UN0s120IzN88/+BC8tZNkYcvEskLqvfoxBXGC+GVrWTgd+2I3Cw/D9YalvYvDIz8xGPKOc9XrSmTkY+5HD8+I6E/I5/ANqNFcq3HlxnM1UYicQdqZ3bbGEa/FEgcDnd0mhs0liVKJiTuLledJZxG97Q9NjO5K+hx1c1FrLCh7rHNAmm4dqNp0Vun1zyWTg1eZd7WYQmY834FRi4mRiycSvjjsk+j+kvshCuREWB6D1S5Yazlu/5lOOlU7Jk3jBW78EBG6VTHAgGnLfAz2Zc00X0bV5FYSSfz72sNDT+AihNNSHclgMoicf/xEcciIBUVv8SRmoA59/LayDPxmKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzSmfBYukRtYm0b5/p7DWcG/4Ws5bVDt7cTKxcL7Qj8=;
 b=Bf8X2MgsXokU+Q5Nzad26XHHPp1f3jd4J/+SBuWrXryEmM4YZ1QuaOQ7h9RS9O23fi/XLWKiSmXbJhAfx3mZLqybUPX6wES+1YVozE99FD+exZV8Zup5wagUHtgyxO2IJDLUopndwSw+SfPFLiYxNFctFDerT9+5lVdPF2G58tqfYUP5/qsfVS2A54pomOz7Jhq2q6gHaAg9Q9683lr0F1wc14N3mJsxcqnJKxQMFejk7snVW03ho1WSgglSC+WAqanR0FKpNNPcx+Z5tKMM2In3bd/eTWGihXkl1Z+DWAynQbR5M3MJ5eXxBIB2TISJI3BrJSrT6L1VEXBn0mefzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzSmfBYukRtYm0b5/p7DWcG/4Ws5bVDt7cTKxcL7Qj8=;
 b=WF2YkDcwB4XUt6RpAqaGgDP9jtk1nUhTpgCznP8Uxr94GZjczPVkajqLwvm32GI/7gq4DUO1s8MtLjwR1/US9i1/FWoIWSELvMQosPa0VzeTk1TmlvbQ7fEa1kHTLy/f3HlDNhxyajnrFq7SOuo8TfZ8Adl0mEWDBaIJ6H2yKPdOMk6BuuxBsTEhoWxt3KNs31TdkYBktyuUDyJbniw/DtPpit77Pg9gAAckKuw6rJU/eU/h6Uazwz9g2YeMoGDz7sp6dufzqk41zZ2Y+e0T1DVi05/tFN/br7WsbGC6xrvhm6ZTNK1AeC2HFq/U+CaKwdGGl5Yun0J94/gDI+00yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6222.eurprd08.prod.outlook.com (2603:10a6:102:e9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Sat, 12 Sep
 2026 10:18:14 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Sat, 12 Sep 2026
 10:18:14 +0000
Message-ID: <ba976401-0982-4b3c-a7c0-54f24a4e61b9@virtuozzo.com>
Date: Sat, 12 Sep 2026 12:18:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
To: Michael Tokarev <mjt@tls.msk.ru>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260728153849.601939-1-den@openvz.org>
 <52e606b3-507b-4869-bf29-97437d4ff84f@tls.msk.ru>
 <73e4dbf1-9b9b-44a3-8032-9fc443028bb5@tls.msk.ru>
 <a0ba6a1a-fdb8-4a44-9d77-fa818bf02757@tls.msk.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <a0ba6a1a-fdb8-4a44-9d77-fa818bf02757@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0103.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::32) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e62ea70-b0c5-40d8-fcda-08df10b727d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|23010399003|1800799024|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1XIbaZ3aOz70z4F9T/ulsNjmGuHR9r6nEjnW5/JcQe1g1f9yhCD1qtVKTUD/0X8ATLQO7ULpKzbR881PFCe0DLGjMtHD52cTp7TQXFMvitKiJUchHXquf56+JTtn9FAHDyOu9P1Uur3h2Wfm2evVoapw9q86iNOM1NDhlZWPGLPo5bEJJURwUosvJbiCSqq0ILXpi7BJx0wi1M+wdVxGey2jmbVI8ZQVNQxZX+MwbEDCaZTKdahHWPJ8ytpt+vCrUe5VDqC61YOh7OWR95+9jPW4k/Yhl6Ym01wMRYipiX3Yoznv9FvQ1i6v5u9ec1Z9gzGmQ2AuVPP34pVhLdOF4rd0m4QGi3ivp+6RIsSCvPvZE3IN+XyH5QEbTh/Dg6AGYeVr+OsWO5YNS4xUZMAXl5YLr6MjWRGRF4mIlv8MUO8QdDmqbvTTllMyaCjS8VB/BExv7DnydGPCBnBjcTh4zFKP2xpPdU/COQ9jfv6kfCz5FA6gczR5XZ96j0iVQqhAtB6OOSWAtQujHZHOnHfD0/Y0k8yziEVbeGIHDouBVjfVSBMfU3h0YDKd+zhMky7nwwbMBKDF/Q/xEDhKtGoavVeefL+Ti/h0H3DyL/59P+uUqjziec9ueVD0JYrImjgDNlTYDbHzG1RdNrBP+qd2RTupdYLVB788+IZkodi16+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm51OWRWZ2cwZlhPRHNKcDc2djh2eFZXdkp4TTNyUytrYzZVNk11MWVzS2Ir?=
 =?utf-8?B?REgxVTRMT0RraW9lOWlhTXQrV3FPZVlXbUJyTktuNi9mSWVtWmpNZno1MWxq?=
 =?utf-8?B?bW52RU5vY1FnT2xkQXlSM2dCSHcwN0N4QzFnN0czMDA2NEtYUXJKN0t5T2JY?=
 =?utf-8?B?R2FVeHRRa0dkd1R4TmtpblNlWHhPMmY2SGcrZllETm9NdE1mZnFPbWhjaUlh?=
 =?utf-8?B?WE5IYmt2anB0UFY0c3g5ZHhFV3o1czl4OExObmNxUjgrYkJTa1RNM25DWWxV?=
 =?utf-8?B?TzNMWXZiMndXVDJnWUZHSm9yUmQvZWkyNngvY1ZrNWw3b1VveXo4ODIvSnF1?=
 =?utf-8?B?ei9rK3RuelkvZlUxNDI0S2NIMjNDT0RweEtWY2dDbmRLWEVlcUIzT3JsRkNH?=
 =?utf-8?B?UnhTeXN0ZzdWdVh3Y1F1Ym5QN1IrS0RvZ1FFcDQyb29XR29xM1VqYmJ1T1h3?=
 =?utf-8?B?QTVVd0VCRlloT3NkZmh1VmhjZzlYNHFPTjRBUlg3ajJETU9NcWtEUU1ROVA1?=
 =?utf-8?B?NW1KaStaNDUxM0ZwRExSMTNVZzVCKzMyQ1p4dUd2blJQUHVHRHVhSGFwV1lH?=
 =?utf-8?B?Q0dSbExMNmVpdkN6WkluMVZMSWhiSUdTQWxZR2dCZXFHdlRqMzQzMS9CVEMr?=
 =?utf-8?B?SmR0NkQ1UTVkK2NaRHVTakh1Q1Fsa1l6WFp4cm9UUEdRdXJaUEFvUkcySFdH?=
 =?utf-8?B?SFFBcU9iek1lM0c0UDNVbnFtMGVNTTA1NzcyZXF0a0hhMEVqZTdaZjd6Q292?=
 =?utf-8?B?dFVzeThWWjkwTWVrNGtlR1EvVW9qUUcvelZmeVZwemN5SDJERmxTSUtwM01J?=
 =?utf-8?B?OHZSWTV3THJ0djJIaFk4RXVxUm1qUXR2enByUG1TSEk1Szk3a1BiY3kxRlBp?=
 =?utf-8?B?eTl0VFhzQ0c0bFBFTjZONDhSMXZmZzQ1YUV6UnBQZDBxYklLUERkODU2bHNr?=
 =?utf-8?B?aUFVblArc3hXcldUM2VkZFBrS2c0V1pnWFpLZjJzME9HM2hKakpiM0tQLzkv?=
 =?utf-8?B?dXBZK1AxcFBUdDZ2TlhsaUt2cHdJazVXc2ZOQjFqeUNaT1gvSmpOTng1RTkz?=
 =?utf-8?B?MW5USUNyV3gzNC90UkFkbnVPbHNQanh3a1czUW5wNEJ0RGpHUlQxam5uMzNX?=
 =?utf-8?B?Z3RoZU9MTnFnRHFYYkpIbUI3SHVLcjJ6VS9rdEJZdlBGeEhOWXd0Yld2ZSsv?=
 =?utf-8?B?dnpSOVJJT0VTUHRSZ1laSUFWZHhLVnNXQmdodnNObC9tb2NDdGg3ZURqYTlz?=
 =?utf-8?B?TkJlWDZJOGd3bDFnd2FjUStiRmR0UmNoN0g4MXFtejZTVjc3QUZWcndnQzN3?=
 =?utf-8?B?YktaRUxOQ0lNQ09pcnRJTVBVTVozMCtkK1JMNmdSOHAxY3dkTWQyQVhnZEdT?=
 =?utf-8?B?NnBLRkp5MFY5WXJMTFYrNDEyOE1IOTNkQ0RLYWpkODBJSE04MUttZ24xeUti?=
 =?utf-8?B?OEZ5bHZOMFd1Y21xQS9Vd3RoQms1Tnlsc0hITnE5S2pLNTF4OVVTRGZKSDZr?=
 =?utf-8?B?M1orMkZoZlZSK0FQM2RPQnVvd2pOVXdydEY2TnhFTXdnaDJhWUQvTW9GWkYy?=
 =?utf-8?B?OEZIWFFyNnBwQy9QMEpXNEl2VnY1QTVVU2dMWlhjdmYwWUlqeXlQT2RkeVdY?=
 =?utf-8?B?SnZhbFVWazVaeUxLK21BdkpZM0VRWnNXMHpHUTcrMFp4a0ttMWRPRzlDWTVV?=
 =?utf-8?B?ZXE2a2dVYmRHeTFJZ2lLcUZtTjYyVG9TNjBUNnVTWWNMcG8rUkZSbUY4VVF2?=
 =?utf-8?B?aks3ckw3SkxSMnhOUWMwZFpHUjJYdkZlMEhwZ0RVU1NCUWJUdTBHcUxFL0xU?=
 =?utf-8?B?MW1NUTFLSnZaL3BGbkpKT1FXL084UFROMnFZa2tCS3ZyL3hHOGQzT2dDazFp?=
 =?utf-8?B?SVVrOEN0NnJ0REpyNEkwV3lhemxNLzlRMmQ5Q0VqVGxTRGQvL0JRUHhpeFFy?=
 =?utf-8?B?ZGZIbW1LanE0RUtTaThLUVBhZjJHbGRkQ3YxdGJLc2hwcXVvaFJuekN4enZz?=
 =?utf-8?B?RU5NYkFyVWdPUWxhYTN6MTNSbmRTWll4U2JsV2FLby90T00rbFRuN242anV6?=
 =?utf-8?B?anZmbEFMRmQ4M1JvbFRlYTBzY2NOUnN4OTJaalU5WFdLV2J2YzJWYU9yK3dC?=
 =?utf-8?B?TkVNRmo0TjVlWTllbUZFakthZTRKa0pRQnpuZk9RSi9yS0RqanZZMFZRSGlD?=
 =?utf-8?B?Tmk5NzFnQ29qWkJtZ3VVeXlzV01EVjExbEY3QWJYbHV1dlNyeFdGcUFVNkFL?=
 =?utf-8?B?SWFFNGRlOFB6ZWhvcWpUYVAzVEhHcGNIclZQZnhnME1EL0FPTVVGY2tGeXhD?=
 =?utf-8?B?aGU0T2NZUThDRGU3djU5ajhFdW13cG5nQlkvTU1SZXl3dGgvSzAwckNxTFVO?=
 =?utf-8?Q?9kfCBwyAhGeteTYWIjNsmdvHIImCJLYpJVJ+Wcf/TR7sJ?=
X-MS-Exchange-AntiSpam-MessageData-1: bMtwNJWqgyCwaw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e62ea70-b0c5-40d8-fcda-08df10b727d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 10:18:14.4006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pS6zaEZNVb/NZt2NfEJK4nbpjaiOUzDd4I7pAkzuun1SMBCs/FLHIVFk4Z2rrNw5bqSoxOpp4MpeWDPJ2HTNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6222
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

On 9/12/26 09:26, Michael Tokarev wrote:
> Since this my question has never been answered, I assume parallels
> is not interesting for qemu-stable, and am skipping subsequent
> updates to the parallels driver (which stacks on top of this PR).
>
> One question remains though: is it really difficult to write a
> one-line reply to my questions?
Please apologize me. I have missed that letter.

You approach is correct. Parallels image driver in reality
in the best case is used for image library at my opinion.
qemu-img info, qemu-img check, qemu-img convert. We never
run VMs with it and I believe that is true for the
whole world. At least the auditory is quite small.

Your approach is correct. There is no much sense to move
this to stable.

Sorry for late reply,
    Den

