Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005E0C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8Wv-0007TM-Sp; Fri, 15 Mar 2024 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl8Wu-0007RU-2l
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:27:28 -0400
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl8Wp-0008Lv-55
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD18VXQu0M8HYfNa5cwFpRMwzM9nvJO8U5b4j1JPGTcN49o81Q9JrjFkmGrqSI+fcX6hdt27Rr7jai9AjRW1NSJ73OUUNTgVvsT6aw0BENlZIq+gPPv3FSFiKm7H0/Aa1d8gndzd8rbo5r0DDnZ3yFBbnR5qP+t+8tEu9H0xtftGacBiizIOlBbgTBe5CNsR3GZC9HO3mzow1VaniPJfAkIIPLYEnj4x2ElIn1zGgg4J4Ta32zsVhYKkLI0a6bhgJHCFbBVZnyy2IB6hLnK5+dW9psZif83WLwsEboURKg/xBdI3xjTbD/RfMH9OJ5lnoZ+6cfchRaudaMq478qnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkEJWWdBYlFtxYpHhx7HFg29BLEjHLqNABN6Tmrv9ro=;
 b=c+ECU5OhUjLJVgAcuygwGLCt1XcDsMfL5JBrwt7OC4MGC3JVAHczT04kNHDn3LLY+GEMy3TI1fRhqYvVHPMlz3A8gteXK0oweDI56ZsQ2h0WYBeZqM2yknLUSGNhPTmQ8+ZhDj3t0Ou0nOhvNupTW907djsAutSFZdenpPIFgZ7zGCs3D8bDBdqxOkKsRpuHZiJoQc5+znmK9+vJ2IXQN0mJZ1FDaZYwWseFEB/ulrFFC8vIvCIWDDr6Z5ZdAYBEloghs6YdpeGH4T26BsYjmH1LXbaDdWke4RkHXLPWqOuBhiJBBabUEqTp+LDePN0iwnjn/FtMV1HtVQk/0F99LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkEJWWdBYlFtxYpHhx7HFg29BLEjHLqNABN6Tmrv9ro=;
 b=fuNGRVKCKr3/S9eKDBD399qVNDOxu1gjUP1VlIalcqSvSkBxnZecw6bmF+TFrxPVgkXd4G25JSMiOY6G2B+a/Xfqkmskli2Fx7QZy88B+4aJfDeEH60u5w+jRkqFNciSjteYpTfcMHuJWhdBvgHvxWjKeSys8SFooQa8EHhvgKwu0W2fxLyg7EvwYdGEEqOUshZgZ4dBZ6LohT2jZkquoG4KyanIU619JSBTZGpjrAqAsCgaCobY6pFFJ0LADs8Za48sXw1332Zlny0iMzT5kZP+DaVqJu09oLhoDd+GVX3hVFyExi7Y5V3fsrDJttY871Ueevw7eJW7jl66LvvPrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB5875.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 14:27:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 14:27:18 +0000
Message-ID: <d8c4e09c-9932-49b9-9f9b-640cd2f8aeb9@virtuozzo.com>
Date: Fri, 15 Mar 2024 16:27:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-root' field
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, michael.roth@amd.com,
 kkostiuk@redhat.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 den@virtuozzo.com
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
 <20240315122946.39168-2-andrey.drobyshev@virtuozzo.com>
 <87le6jehiw.fsf@pond.sub.org>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <87le6jehiw.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 5500912e-aae2-4ed5-95f1-08dc44fc048a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1jSi0EVkHvJlqgP6I+pO8anST5VetnPYcvQDb2IdgRV75hVz7xPsMs333QX3MvlbDJPKTJ4VCc6hxBgH/amAUxZGG0t1ZCWIDkET+wXHqJuFyDHhNPmh8Ry5wULU7jjkDXNRAmcs7lnvpLsMOZ1ayW3fcA1ZYdAj4k564vOb7JyDhQAusGD7dO/gpb8Mqh82NHSjpzWUjJYSWSFST4lYieqhAA14FE9BZs56C8kx3yVpjEx3kCPWn9lgP6qDWbe6rVGySqwDN7ZmaOmnwsrqaZRBgKgR3+W4HYtVZBZwOmko69+OlRlOUdZG94GapGJVhUIP/eWd9/8aDo9yJlG7aHFeuWaU/X+NdZy3MXxhx+T9chYtmbqmGZyo/BLSYr+xYTP63vjEKlWTqNXTFeWBD5Lc2YUiJK8r3OBnzL4q64Xe4lxn4I2Tjrj9kEXKNN+8rpLQydOWHijbRXIo5WtwirNUhl43EMc4rispZh6juYWIfpK25LyFbtCerB5UJIdp4XiKb+GR8u0EJcj/LnkWrRwbk1OU4Gzl6zf6oZtYNG4s0EKfR/fhB//ps7EDjVZy1yLoqGkpv8Ij8FFZgKuQ8umjeEBdTs6crKo7XjlM65G8I8yf25eaXgztKj7Vhpm8s57kENNGK9QW3OoELm4B+ZqkGuJqm+1cS6bDehB+TY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRZMnFaUXpkc1lEV0tPc2N5QkFBUHlzRkpQRFFlb3NSSVp1Kzdiek1FaHoz?=
 =?utf-8?B?R2Z5dXUwZHprRUJDL2Z6d0ZwQ1hoVDhKVlBMaFdUV1NFSHZTNTlMU0xBV0w2?=
 =?utf-8?B?UjBMaFBsRmIwMHlVZWdOdmFrRzB5dyt4RzQ3enRNeEgxNFRIRGlxMk0zYlhP?=
 =?utf-8?B?NFh4dHRJUUo1aTV2dDRtcmRScTZ6RGhRVm9jMkNsN3dwdXorVzBJMG03dlhB?=
 =?utf-8?B?R2tZK1pLbjM3Tjk2K25sVFNrNzMwWE5aYnEwUjNEOGNDdnJXRXhnZ2pCWFNP?=
 =?utf-8?B?YTlsQVlHaVRYUjlnWk81WDZBdTFZd0JaSldNdUkxaEY3T3VUS3ZKK1BnWE1p?=
 =?utf-8?B?SWFFa1hjMXNUbzVjSDk4WmRKTE9CRWNVZUpUSktnTElWT1lkSTVOaHhWN0ww?=
 =?utf-8?B?VFhzUVBKOC9TbWJua1AzWWhQSXBselZVaU82U0trb3VNaEhjaitQMXFBOXhC?=
 =?utf-8?B?NHk3UUVnVlZVckp4cDhlRldpU1FISExuQnprVXFmdFdCYTFsVFI2Z01DNWIy?=
 =?utf-8?B?YXFNNTFTUEdUNjRLOTQ1ZWRvaytOTVJGTlplNHlQbVp4cWJtdVErVS9iT0ll?=
 =?utf-8?B?UWxRcTJESTZCVUZwSlFxZWNLZjd6SFFlM1VSZDBWYzJ5MWpzOWlQU0o3VSsx?=
 =?utf-8?B?VzBMOW5lZC9vQ015VWx5eGx2UWJtNEVGeTkxUEltbEpZT3pMbHg1d2tGNkZo?=
 =?utf-8?B?cFB5SXptSEZvRkVoZkF2aUpMOHhraWxFWTJDN2tsUXJweUVUOGMwYTNabUFj?=
 =?utf-8?B?M3NhRXpSNkFFWG9Cam1Qclk1R2RQK08rQXM0eUhrcTBoUnkyb0NIbkNmaDh5?=
 =?utf-8?B?bUJIeWxrZlRKNm9WbjRUYkFBY0JFQlhkdVJrQk1nN3FYaDhydGdTWEJZek01?=
 =?utf-8?B?K1RYMTJHa2xSZU55YlVudW1naDRrdjRZZ2xQdnJFTW5DWUNQaFJ2NHErakNS?=
 =?utf-8?B?RlY4SmJ0b2hIUXM1bS9zaXhmVGlqVXZ2RmVRMWx0anBnTkpDOS9jS2xWaXVq?=
 =?utf-8?B?YUV4WXp4R0I4YlBDOTh0VXptamRYb24rOHVDMWZRbHoxVWFLMVplVkxlQk9V?=
 =?utf-8?B?ZGtuTDBqNVAvV0RlWlBnL0cwRWkrMEkvT01JaCtJSlZnMVQyZ3VRWFV0eisw?=
 =?utf-8?B?MXFZdzk3ZlI0QXpremNRSk9XTDNybXJFNkJWejRiYzVWVnFFNFJ0S0RPNGcw?=
 =?utf-8?B?NysvZkRjbHVVcHFrampiVTEvZXJrOFRlYjh6WWpMbDFhSzR1cnlabXhOWkZN?=
 =?utf-8?B?UE44dW9VemRmUW9UdjRGMURONXpqSEJZWkJuREx3Nm9KUVQzQm1Fc0NmeThx?=
 =?utf-8?B?NU9BZVFkSTJiQUJuUTFTRkkvSWdPOGRhZkJmcWVIUmh4ZlRXdUxVM1ZkL1Ja?=
 =?utf-8?B?SW04am9kOUVhVnM1c2YvdGFRWUZRZks2VFNQd0tGSWtTb0RVNytyeS9KTXds?=
 =?utf-8?B?WFVzWnpRU2NvQ3NOUlVxWmEwODMzMGl4dVowYnAvNGZYWGE2cGo5MzJhQmox?=
 =?utf-8?B?cyswbjZjMEl2NDFwcStTdzUzNU1INE1kZXFWeVBJeEN5VHkydVhiYlltY01L?=
 =?utf-8?B?bWJSMC9VbDdXUUMvZW9jU0VQaVUrL1haRk14QnlZMi9NREl6eHN0U2FIb3Nj?=
 =?utf-8?B?MlV6UUhwRGNJVExHNkhsRkNTYmdYcGVlSEJWL3B0Zmo0K1lWQkNXb0EzMmJ3?=
 =?utf-8?B?aWxNU2FSNGVtVWZWeWc4b1hVclVtVTR1SGtOT3VQRjV5SHdKQm0rejNKc0t4?=
 =?utf-8?B?N3RjT3dhaTVJWDc3dUgrRnU2dEROc1pjRmhoM01lT3VMRU1FemxtOENYdnFT?=
 =?utf-8?B?OFJKTitTYkNMMDFUTHlrQ2F1UmR4NUdLd3pBRnV4cjVXbHZmRnplV2krVC8r?=
 =?utf-8?B?aWY3ejR1T3BEaVVTWVUxZllpaGdVSTZ4V05RcmYrS0dDVlVEeEd6b0gzVWtp?=
 =?utf-8?B?N1FCUlBoS01CYXhaSmFQRFNqNWpIdEs2ZC9Ua1FuWDZpS1V0THI0TTNNUlBF?=
 =?utf-8?B?eUUxeDRGVzlRTG1JT1lhSkF1MWY4dXI4N2VOTmxyTWQ3dUlwYzltT0NwUnc3?=
 =?utf-8?B?R3NTL2s0eGpSWUFFTHFEWlNhandvdG01dThCM1JsTCtLczlWTUhvY0RrWUhY?=
 =?utf-8?B?VUxZUkFReFU1eHdTMHVDMDMvek5mallCSW8vK01iTUtmRWUrL3VGUUhmdlVz?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5500912e-aae2-4ed5-95f1-08dc44fc048a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 14:27:17.9466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIurvntAUWUnaMk0mgMWy1IrKZ/8BknxaCestRCHTAIHhR7Km66t+jSFO5nrEhDxzc7vrmtJCT1QV8q4lEj+Q/06qj4kpxREV7oooy/JmkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5875
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/15/24 15:44, Markus Armbruster wrote:
> [?? ??????? ????????? ?????? ?? armbru@redhat.com. ???????, ?????? ??? ?????, ?? ?????? https://aka.ms/LearnAboutSenderIdentification ]
> 
> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> writes:
> 
>> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
>> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
>> used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
>> returned by statvfs(3).  While on Windows guests that's all we can get
>> with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
>> total file system size, as it's visible for root user.  Let's add an
>> optional field 'total-bytes-root' to GuestFilesystemInfo struct, which'd
>> only be reported on POSIX and represent f_blocks value as returned by
>> statvfs(3).
>>
>> While here, let's document better where those values come from in both
>> POSIX and Windows.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> [...]
> 
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index b8efe31897..093a5ab602 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -1031,8 +1031,18 @@
>>  # @type: file system type string
>>  #
>>  # @used-bytes: file system used bytes (since 3.0)
>> +#     * POSIX: (f_blocks - f_bfree) * f_frsize, as returned by statvfs(3)
>> +#     * Windows: (TotalNumberOfBytes - TotalNumberOfFreeBytes), as returned
>> +#       by GetDiskFreeSpaceEx()
>>  #
>>  # @total-bytes: non-root file system total bytes (since 3.0)
>> +#     * POSIX: (f_blocks - f_bfree + f_bavail) * f_frsize, as returned by
>> +#       statvfs(3)
>> +#     * Windows: TotalNumberOfBytes, as returned by GetDiskFreeSpaceEx()
>> +#
>> +# @total-bytes-root: total file system size in bytes (as visible for a
>> +#     priviledged user) (since 8.3)
> 
> privileged
> 
>> +#     * POSIX only: (f_blocks * f_frsize), returned by statvfs(3)
>>  #
>>  # @disk: an array of disk hardware information that the volume lies
>>  #     on, which may be empty if the disk type is not supported
>> @@ -1042,7 +1052,7 @@
>>  { 'struct': 'GuestFilesystemInfo',
>>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
>> -           'disk': ['GuestDiskAddress']} }
>> +           '*total-bytes-root': 'uint64', 'disk': ['GuestDiskAddress']} }
>>
>>  ##
>>  # @guest-get-fsinfo:
> 
> Fails to build the manual:
> 
>     qga/qapi-schema.json:1019:Unexpected indentation.
> 
> To fix, add blank lines before the lists, like this:
> 
>    # @used-bytes: file system used bytes (since 3.0)
>    #
>    #     * POSIX: (f_blocks - f_bfree) * f_frsize, as returned by
>    #       statvfs(3)
>    #     * Windows: (TotalNumberOfBytes - TotalNumberOfFreeBytes), as
>    #       returned by GetDiskFreeSpaceEx()
>    #
>    # @total-bytes: non-root file system total bytes (since 3.0)
>    #
>    #     * POSIX: (f_blocks - f_bfree + f_bavail) * f_frsize, as returned by
>    #       statvfs(3)
>    #     * Windows: TotalNumberOfBytes, as returned by GetDiskFreeSpaceEx()
>    #
>    # @total-bytes-root: total file system size in bytes (as visible for a
>    #     privileged user) (since 8.3)
>    #
>    #     * POSIX only: (f_blocks * f_frsize), returned by statvfs(3)
>    #
> 
> Yes, reST can be quite annoying.
> 

For some reason in my environment build doesn't fail and file
build/docs/qemu-ga-ref.7 is produced.  However lists aren't indeed
formatted properly.  I'll wait for other patches to be reviewed and fix
that in v4.  Thank you for noticing.

