Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7341DC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6MU-00023o-RC; Fri, 15 Mar 2024 08:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6MS-00023c-7X
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:08:32 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6MP-0001lI-En
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKyzCsQBhyrH9Hx0HeAjTn9/sn8l+YhAcUTCpKgDIcX2zalpc8t8H7JFnp2yMHJ79N23IE5uzCDnJ+yUWmPyhAD7eJ2eccluVlee+zUIbAopX+hotCAhei4TliUiARKiNyeqsZap+sLp6XhgMHUyCuxAg7ZlgfwtNvvvW8e7PF+in8dkuBOuiz9z/6qy/lpGRJ/AJaNjhbJQCA8jq1nK6kNuiYAP4fBaj3WVenPrIOwMcpC9oAAj6L7zCBhDMy/Gxab/kuYFPSnBSbj7ag7/aOeWWIRFaSqBGa0QxSslsIyVre6USw5dG2gcmcT+bOh9/3h0Z+ZS0Akk1DXAWfVctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhdklns4J2k19pyVV171EZyEbT8V8kI528PmFYZgBH8=;
 b=khPFpYV4ccouvK53Vy/z2xAOcmQWnR+/qNnPU4chQrkiFMDSNg5d4dR/M0kL8yCqcWY2+231oBWG4lCUMQe6p8u461KRoKDMQtG7h9wKH3A4yFRrT8efy8iVws9+vbs+UgwNW3zGG3KQqu4IM8fwZnzKVUutmwkCpUUiVg667lbhFBVtDoiuJkgidOHxMxfRDpoigcGiY6zjqleOPFv7FC4CysPcdPfm1gEU9J4UtalbDo0iL+q4Ifff6sTVkDjPi5yj9lXmYHyFZOTbuvdAHkfuZOCTD/aAq853Y3pmNb18UBSCmxbBa1E/403Ix4isVPnq5KPCSg2AkUInX75c5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhdklns4J2k19pyVV171EZyEbT8V8kI528PmFYZgBH8=;
 b=r/otpzuF5oaeuLblFbalNuLzjblzBbNC0wtiFW0mitEQlntqK4hxM22wbCxn4YAx3OOHweCTvi3XD6zvZHDwWie2l3vM0jJ19CvdmzUIK3n/a8WLlZOyNZUo7/WlHhDdVQdtPb0GRwEsVvMA1Jls1bl23tSCTBCTBEXN3RbRz85wc+hb+zBujbAFcLDfjQRXQlxhmxnGO51RzpKh70pGWnqVlNmUVotGfBF287WBksyTvwogaZY2+dKIG4k94bMCnFT0b8UEEpD2pD/lcAjWio9WydpdaYugzUY0vBcdfZFKwvAuMfnstItJPLpsRj2X9aagm7FYqMKrLyjlnAmAzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6334.eurprd08.prod.outlook.com
 (2603:10a6:102:dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 12:08:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 12:08:24 +0000
Message-ID: <12b9c97c-0891-4496-9a04-53efd6bc9782@virtuozzo.com>
Date: Fri, 15 Mar 2024 14:08:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] qga/commands-posix: use ga_run_command helper when
 suspending via sysfs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
 <20240301172858.665135-7-andrey.drobyshev@virtuozzo.com>
 <Zedlt4vI2gHri8s5@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <Zedlt4vI2gHri8s5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAXPR08MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7455a2-9e9d-41b0-4f3f-08dc44e89d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3z1otz1W6vyVKSOt0uw/nBfC3EgSVlGtiAMO3WUSMIB1v7mdwHdR1guGa/g+2wfJ8PBjtj2PQsn4qf771O+fDJA76q8x4Xx3WXl3f0p7jkHzCig+0JzZRcSopkUch0l/O6llwoS4+HVbmCl2Cz/pM0Hub/FwwXtMXRJwR40cHgYD7vLWt2OZ/1nAVZS4rnhlctIo2GWTdW7dTwXAIcKZtRjQz5pvSCEOdWb+byEzZ4Bgg4g231VS6tqvCgNQ+smrinP5DYo5yD8tCD4LEZ9JEvd2Mo4xfiJ7c/4RM61NgDY4tCEmESaxFvfNDYkb8n/Z891ikovYfOwecvb3S44exNTXJiFKJ3mBZ3z+dtioq7Q/GYFzn1o2uS6fP6BL7v8S836ulkfeorw9apikeMTB1WbJByITozJCWfg1la8Fndp9UcjsPRo8KhSXnPPVm9gxJ2HkgEVf1xPett1YvtM+GXMbVRBuDopy5+sNAJiYD5XJboP2pmAwX8B4GPjrSPSUsH7S8eGYVDuRAKqivjuwVpYnQJZeRjbNxavNwjBmtxL31BprA98dQSq0a3KBvtO+Kj4/MkZt6ugK8gYnqf7Egll+2+NbHXzSOFY1x7YXRB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpjNExzV3ZXNkRYbGVkalN5NTR2eFJHK0pIVm1Nc0owb2JUMzQvN2pqZGZV?=
 =?utf-8?B?cjlDQnFJd2dybWZSWUNhaXh2MnpLOVRhcUFnbnNpakJQS29INm4veTgxbGxC?=
 =?utf-8?B?Vnl0VUNjbW5wSXNISnp3SURaMGlPVVhvenh1L000UFYvZmVYWnJTTlhRc0Ft?=
 =?utf-8?B?UEwxSGpBMTVUUnlNUG1vKzA3a0hpUWovTVRWV1hGK2pRM1lUbjNoUzdKVXNU?=
 =?utf-8?B?cTY2RVR3ZGdxd2NUSVRkZDY5SzBOUnNpOFU5d2J2b3lRZ001WGFkTklHbm5v?=
 =?utf-8?B?eDJjQmJSZHoxMGVtVHJoYThFbUc2elVQM0RLK3dFMHBRM01LSGk4Q1ZidFh4?=
 =?utf-8?B?RnEzMzRQUFNFekxzV1J0VjJVbzY5dTUwQjljWE83dzZ3TllGM2hGV0plcVRD?=
 =?utf-8?B?WUR3UTg5TUZuanBtL3VMYkc1clpvVnZMcExnTFJLalVVVGY4SCtHbzBrM0ZG?=
 =?utf-8?B?Y21FWU83amJOMXBrMTl6UGc5RWsvMVMvS21aZndFeDFMMU14eFdPS2twbngw?=
 =?utf-8?B?MWNVeVBuTDZ1cW90cmdYWnFhM0NrSjUvZmJDaGxYS0I5TXF5RkFIM2xuOU9r?=
 =?utf-8?B?QjRlVkFCT1hKeGs4ZjlrL2o3M2lWTWl4M0l2Ym8vcFIwa3JzVm9ERzJQNklv?=
 =?utf-8?B?MDNYWDQ2OGFSd3VRUGQ5S1pibHRhcFJSQlk2blpRZXJmWUlBYUlHekZLNDYz?=
 =?utf-8?B?b1E5UjJxSlc1TkZoZWJlcUtzM1dpUHJjZXQzL0YraytWQXppT2FzN0pPd2J1?=
 =?utf-8?B?MVF6by85WXFpZjY5aXFDeUtxaVBqWmh2SEViWnVzL2lQUWttT1RucllLUTBw?=
 =?utf-8?B?ZEhNVEtUZXFUU1ovL0ozR2kvZXV2MHpWOVRaYjRYWWJzNzRTUXRmUy84MmRa?=
 =?utf-8?B?d2V3ZnZXY3VLanVpS1dqeVAxSFRXRWRMN2N1NHI5OEJoZ2Z5Qi9CZVZBaTFq?=
 =?utf-8?B?ZW11OXl1ck1zKzJRd1ZvUWpCbmE2SnlnYzZETkJ4L0VyWlhRZlQ3aWpSSGsv?=
 =?utf-8?B?cDUwZlpIbk1WZzZPK0R6NWZxbGZVOVoyQWZxbURnWFJQa2xjM0VwQ1lOQThh?=
 =?utf-8?B?TjdKRjJpQ3k4Y0dybiszVmdGc2NNVnRITGhrS083aUJEQnh3QTFWaHdkOUNu?=
 =?utf-8?B?RUVETzZ2UDVMYngvUHdaL3hpcmkySXdBNERaN1VOOVNjaWhhRFBuVFQ4bU81?=
 =?utf-8?B?Sk1ORG1SMjY3b3VTTnV2WnV2WUtZQkpKN2JBVllIcFQ5MFpUTmFLMCswYVdi?=
 =?utf-8?B?bmlWekV1WlJtYk5IQk1RM0NyNFJlS1V4T1V6UXg1UGJKTDF5VjhxNW1hcm5i?=
 =?utf-8?B?aDR3VVNnalNxY3VIaUlIMTV4elBvWWZacGo3SWp4elpqWXV5QWlTUkszNzFr?=
 =?utf-8?B?UTh3SytCL2hIajNrRDMvdGovSlJKQlM1Z0Flc2hDZ2lQcXEyUFVTWnRZUUdV?=
 =?utf-8?B?QlVLUnFyNml2clpXUGRDSkROb3c3Mm5kYTE4WVNkS3lZVnJyRU5ZTEIzSjZn?=
 =?utf-8?B?TmxXZUUxNU5kL1dCVGNRdTJhMzRxdWpaRUNERExkbk9Ea0ZFSGNUelRTOVJy?=
 =?utf-8?B?NDhwR3ZRZE01OGFNbnM3OTFBWHBCaXZ2ZWVhWU9QMXl1T0RuUmpsTjYzU1lR?=
 =?utf-8?B?dnJiMVBMd2RTR1g1Z0t0Rk1ic2RQVTdFc0p4NW90NUZEb21vNUozWGNnZlpk?=
 =?utf-8?B?ZHduWDN3N3dVOGFtdFZQMnRkYjJrVDU5SE9qYUxDOUN2cWYzaUEzMGFxakx5?=
 =?utf-8?B?MDB4SW1jSnltWEI2Z2I2T3ZuM1ZpcmR4VEhMOFZhZjR1THBqS1pDNFg5bzJO?=
 =?utf-8?B?eDFvYzNQdjMvQ2hUZ3VtMmQwNVpjM1NON3I3RFZlTlhPaDZLQjJkNWhZUUFy?=
 =?utf-8?B?dlN1Q0ZjOWlmUE9CQy9QdHRTMExMckVPb2JVdktHSldrZEZRVkJlS2tJeWlM?=
 =?utf-8?B?ZGIyOE80SWw4NUtCalNjbGR3Lzc2ZWR3L2x3SjV0Z3FMNzkvNTh5MTJmMy9a?=
 =?utf-8?B?TDdsYjJMV1gycU13RXRXd0gzWVowRGlsaHY4ZEkybjRGSVVZdDJla1Z6bkpT?=
 =?utf-8?B?cVBpWHRGZytLUXl5Z3FzOFVkdmV4NnJMdk5Xcnkra21UeDc4VWFlYjdTRFVQ?=
 =?utf-8?B?U0dFemJuNmNrZHBDK0V4SVE0MHFmc3grbTFEdm82c0FWQlpYOVNQNXJRc0FQ?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7455a2-9e9d-41b0-4f3f-08dc44e89d8c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 12:08:24.7224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74JD/e2iBRQXcNv2TqRS6FFElD0GHSQDRUImSGJdrewOQK5JVDWRDHl3oOpc3BzMKA7psodNa5mY7oxOeJhbC+2e0G9FE5dujxZpcyJ2Ucs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6334
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 3/5/24 20:34, Daniel P. Berrangé wrote:
> [Вы нечасто получаете письма от berrange@redhat.com. Узнайте, почему это важно, по адресу https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Fri, Mar 01, 2024 at 07:28:57PM +0200, Andrey Drobyshev wrote:
>> We replace the direct call to open() with a "sh -c 'echo ...'" call, so
>> that it becomes an executable command.
> 
> Introduced an indirection via the shell is a significant step
> backwards IMHO.
> 
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qga/commands-posix.c | 36 ++++--------------------------------
>>  1 file changed, 4 insertions(+), 32 deletions(-)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index dd2a7ad2e6..f3f4a05e2d 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1921,49 +1921,21 @@ static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
>>      Error *local_err = NULL;
>>      const char *sysfile_strs[3] = {"disk", "mem", NULL};
>>      const char *sysfile_str = sysfile_strs[mode];
>> -    pid_t pid;
>> -    int status;
>>
>>      if (!sysfile_str) {
>>          error_setg(errp, "unknown guest suspend mode");
>>          return;
>>      }
>>
>> -    pid = fork();
>> -    if (!pid) {
>> -        /* child */
>> -        int fd;
>> -
>> -        setsid();
>> -        reopen_fd_to_null(0);
>> -        reopen_fd_to_null(1);
>> -        reopen_fd_to_null(2);
>> -
>> -        fd = open(LINUX_SYS_STATE_FILE, O_WRONLY);
>> -        if (fd < 0) {
>> -            _exit(EXIT_FAILURE);
>> -        }
>> -
>> -        if (write(fd, sysfile_str, strlen(sysfile_str)) < 0) {
>> -            _exit(EXIT_FAILURE);
>> -        }
>> -
>> -        _exit(EXIT_SUCCESS);
> 
> 
> This pre-existing code is strange to me.  Why do we need to fork a
> new process in order to write to /sys/power/state ?
> 
> Looking at the original commit
> 
>   commit 11d0f1255bd5651f628280dc96c4ce9d63ae9236
>   Author: Luiz Capitulino <lcapitulino@redhat.com>
>   Date:   Tue Feb 28 11:03:03 2012 -0300
> 
>     qemu-ga: add guest-suspend-disk
> 
> 
> The code made a little more sense, as after fork() it first
> tried to execve  'pm-utils', and then had the sysfs codepath
> as a fallback. IOW having the sysfs code after fork() was a
> much easier code structure.
> 
> This was all changed in
> 
>   commit 246d76eba1944d7e59affb288ec27d7fcfb5d256
>   Author: Daniel Henrique Barboza <danielhb413@gmail.com>
>   Date:   Thu Jun 21 07:21:50 2018 -0300
> 
>     qga: guest_suspend: decoupling pm-utils and sys logic
> 
> 
> so the pm-utils logic runs in a separate forked child
> from the sysfs logic.
> 
> AFAICT, that should have made it completely redundant to
> fork a process to access /sys/power/state.
> 
> Does anyone know of a reason to keep the fork() here ? Of
> not we should just be calling 'g_file_set_contents' without
> fork
> 

In the original commit message Luiz Capitulino explained that multiple
forks are needed to properly reap child processes needed for execl().
AFAIU since writing to /sys/power/state doesn't require execl(), fork()
isn't needed either.  I think the 2nd commit you mention simply kept
things as they were since it wasn't the original goal of the patch.  So
we're just looking at legacy code.

I agree that in this case my original patch is redundant and we may
replace it with smth like g_file_set_contents().  I'll add it in v3.

>> -    } else if (pid < 0) {
>> -        error_setg_errno(errp, errno, "failed to create child process");
>> -        return;
>> -    }
>> +    g_autofree char *echo_cmd = g_strdup_printf(
>> +        "echo %s > " LINUX_SYS_STATE_FILE, sysfile_str);
>> +    const char *argv[] = {"sh", "-c", echo_cmd, NULL};
>>
>> -    ga_wait_child(pid, &status, &local_err);
>> +    ga_run_command(argv, NULL, "suspend", &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>>      }
>> -
>> -    if (WEXITSTATUS(status)) {
>> -        error_setg(errp, "child process has failed to suspend");
>> -    }
>> -
>>  }
>>
>>  static void guest_suspend(SuspendMode mode, Error **errp)
>> --
>> 2.39.3
>>
>>
> 
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


