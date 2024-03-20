Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F466C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmy9c-0008QH-K6; Wed, 20 Mar 2024 11:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmy9Y-0008Oo-2m
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:46:59 -0400
Received: from mail-he1eur04on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260f::701]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmy9W-0006gV-27
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:46:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVIwoGCnBlRK9T46hzzahvi9VbIjOByYLfpahblZkAdinGyGyDNLSgep0eX1Pb1zLZoDCCgW+qBvPuPXfOpO0BVub1u18zbcZqDCerA+JqhEeH31jjxYhaETGad4cTt2ozubCY0vEhgHg73cCCy8cgZ/PDjFHTjuD5n59gn5SpomTDtV4eHD6XhvQMqR9b4kkNH0dAZXS47XJJhJZtgqhA9GN2Ge6eK6WJAp9sGnjaf/Ft9WF9rbYLaN2cLNLdjFukqTIueeLgLCQvSfizi714Fr8Or3opjN7+JBAOC9XWzW3LPsbddqqAeFRhkNHoh1bqCMp1xW6rb8F8Ey7/RVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgQgzTA7eeoXAht5n5y7789UieAkM/kf4g8pYVbxh28=;
 b=NyGOHF3KI0zkahDEKaa00BQyxYl8uAgaaEEITORK15mF3weI/CGLVerIHkV3ICmoKs0WXvmdushmCG7tTfUzT+YKqSBv+GIyljGHoNuxdSogVWdRJxn7v7x6NVsajMeSHDysl5TFF0RAZ5nha8mzoj0c9byrEqTDPOvP5d0lTtbgwOHQO/lZoGTIIgCGD19DA7/N+syDIclKjgi8aq7K+2H7pWzURL1G9EL2XnbYYi8ZOFHeAe9Jqm09P8A8vKEa4vEFlgSw1NHUtC9Go3PQ+adeOiXDEgGz1Wh2G/1wTsl5MLgmJYUyQSkNRI7jdzYYAyBhRMibZ3uDyVvCex5HoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgQgzTA7eeoXAht5n5y7789UieAkM/kf4g8pYVbxh28=;
 b=kFuMjKmGUwrcLcXbCMEf0ogBU/cwA7uSyMa837f6qWWrCr7mn5OVVIjonDBxl2mdL+VtUEfh9A4vC2uqwbsGQ+zR4MYFI+tBuI9UD7dqioGKgOhc8jxXX+0wipPYMb+bu+gyszwVSlpyJnPw/7htIGN0/D1tgoNkLUZNz2YytqAD/zwuLoZ4L+aXyqOpkKOk8bvJYulxwtxz+HCmZakgnr4TQLFUZSR9MDc2/yfXKLPk0VC8Cz60FAQxat++ZfZtoDoED/sbt6ESVOpLkHx+BWAd9ngbGt5rga1bUxS7MWYnh/Z9eqsEXsuia4vVOK4TOBXnxOEJqKzPhgjL6UdgIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAVPR08MB9700.eurprd08.prod.outlook.com
 (2603:10a6:102:31f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 15:46:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::787d:7732:63b:ff4d]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::787d:7732:63b:ff4d%6]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 15:46:18 +0000
Message-ID: <9ddb82bd-c320-4d5a-9d8e-3e1af38c3ce5@virtuozzo.com>
Date: Wed, 20 Mar 2024 17:46:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] qga/commands-posix: don't do fork()/exec() when
 suspending via sysfs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
 <20240315122946.39168-7-andrey.drobyshev@virtuozzo.com>
 <ZfnTIbXiGrVhTlQQ@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ZfnTIbXiGrVhTlQQ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::22) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAVPR08MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f135cf-ff50-4269-41d8-08dc48f4e22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpynzfemJIW92TN7E6dDX/Oa6+Z3LPCyjYG1TlzUwAioi2fPOHeK0tVEceo3p9pb9voA0HAVOO0QTdmQIvNZukAdi7ZNrZhbQyqI9/M/+2CZrxCNUQWqEx0C16Ww9LBVsuQ73dXUdvcJh3tc1sYKJ1BiyufXqeDeA444lMxYzALxUO8RRAGRJc+vK2fru/8AeRS6rMuhS4LJjtqg0eOIObGJ7WjUGjku0MBPUeieq66PAqqiEk/ZpGT0EA7FCnzWCbokktrFDxJ9+48mqcF+QLM/p+bdmmbsOsEh/83Qx/E7/CGo6kgD85HtlsUuAaKGgplmoWAVAg04rw2CcbxJJr1+3EtLFVNaaEZj9MNFTFKjMnnPzKqO5T10qRrxxCH8N2Ijj17iPawxJD0NM45olHIB7rT68eXKu9EOj0PdsgLm+mKi/YYfAEtELsx5M5+NieX3nt4kIaco8lSGArKgQTZz/GYfX9LzRclXESffVFGqxXfzlivMgxWQBNS1V6DoL+3IudRvU65dA338foiwgXW0ayVp4dXxImMekIWnSP6aHt1xRBDiiy3lEd68ntPyjlEce1XgN4xKlvr6s+l+0ODwgV/d8ffPp4WNd446vjj75P3kkk7EIkKBrys+aHKt738B0VQg1XuPftLRXyngx+1kvHX1w5C4VQmoxPVKpxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhIWVhsaHowbXI1ZjlTaXYwZS9wUHNkOEJTNER1R0Z5WFlreDJkazI2ckd5?=
 =?utf-8?B?dHU0Q2plWUxMSG1qblo3ZEtBaGpVRnltN2hPSUZjK0xlZE5jdUZxK3BjSlpp?=
 =?utf-8?B?ZVdORUV6MXEvaWQwRDdYZHdEQWkzbGEvTmZWZGV4bGtHTzZBaDg1QW5iV0t1?=
 =?utf-8?B?SWZWZ3NRUmt5bXI4NW15WE9LRTZCdW5zbElnajZEb1hmMDNWUCtwZW1sWUd4?=
 =?utf-8?B?Nzl5YUM1UWRQSlR3cjVFQVJEQjZwL1BzODFnZFF5L1JuRnBMdlRHeTJxY2V5?=
 =?utf-8?B?ZWZFNjN3eHY0WE9CazdNRm9uUUZRdlV5Z2ZpcXMzVmxRVnAyNjZKTGcvaUZj?=
 =?utf-8?B?VGdra2tublZCM2dWOTRsUGdZK0cyU1p1bE5hZU5mbkwzaktxa3hDNEk4SmdQ?=
 =?utf-8?B?VFVDNmwxODc0ZTk5MjdMeVJPV2FjRFVISWtYM3BzU3pWK3A0amdCWldPWEZO?=
 =?utf-8?B?Z242NEVKWUtBWllBOGlYcDNsbFYvTUdxSlk5OEZSQitKcWsycHdhMmdZZ1dF?=
 =?utf-8?B?bnlEQXgyK05Na0NHOU5ZQUtZbXRwWmtjZ0pKb3FmQ3ZTN1FwMHhqY1hUTERB?=
 =?utf-8?B?UmhwU0NjcVdYZ01XZENPa21oZ1ZCRytOVThjZWI4Tmo1QTRPejcreUE1bVNw?=
 =?utf-8?B?cXVPV2c2UEdTUVE1RVN4amdFSEFXbkdwbjZkeUVITWNPVENpcy9na2g5eW5R?=
 =?utf-8?B?M3BXREczN01kLy9BM1JoNmE3MzBLbElPZXUvQjV2ZTByMndqQk1PeFZVVWI5?=
 =?utf-8?B?OHozTC9zazRZcUFlNTcxMWlVT0N6ZFM4S3VLaHk0STZ3VEdCVllZeVp3aFE3?=
 =?utf-8?B?LytLb3gxZTRvVDRDSUR1NDVJcmJzZDY0WkNuTmsrUUFUaUx5TGxqa2hEbjdG?=
 =?utf-8?B?c2FZeGZ0TnNMRkw1Y0xJcnE2L2MrVHBEKys3bnd3M042S2xTamt4QWJmVGw3?=
 =?utf-8?B?ZE16eFU2T3p4QVJlRTdhZDhzeTVRTUw1UTY5cm1MdHVJQ0RyQWE2akpydmZz?=
 =?utf-8?B?YkQxSzFTMDdWekdUYVRaeVNXWC85WlNmTDJSRkdnMVBWUi9JSUlEOVFvNHEz?=
 =?utf-8?B?a3BpSFY2UWFacTB2NWMvMVlUVTJhWFV3d3JxUnBhKzFjS1FwbE1xdDkxNTJ6?=
 =?utf-8?B?OU5PRVErbTh2UW83MzdqWUlJN0hpcjA2WnI1eTVrNlN1V25GYmNpYzZYeWdG?=
 =?utf-8?B?bHltK2RidngyKzdoODBBdWhHVitybm80aWlpNEdVaEEyaWRrUGdLdUtyeklH?=
 =?utf-8?B?QmNrZXdCRElDblM3RzZPRE1yc01PeFdzYVRDK0tCZWhGTlcvWWlkREdneldQ?=
 =?utf-8?B?VE1QR1VpZ2F5KzI4R0w4ZmxsY3BSOEdaQXVFajhIRzBwaVRjMHpLb1Ntdkhx?=
 =?utf-8?B?d2Exc08ybFE3OVM5emV3L1dQMkY3OFRjUnVrV0cwUEhleW5kMXFXWktFV2Zk?=
 =?utf-8?B?SndWM2pOakk1SS9TL2hESU9kdlkzeitLQzVDaGRJT1lWdHRMQWMwQWp2RkpN?=
 =?utf-8?B?T1pWd3dLUm9OUU9ScTVva1JScU9IeFpiZ2NZT0RhZDZuSk40VVFBb3YrV2Nz?=
 =?utf-8?B?bFg5eVJ5NnVWMmZZRUVySVY2eU5TZ3cxdE5sd0lPSStpd3BibDZYZFJGT0gz?=
 =?utf-8?B?MmR6VTNXRDc5MGZWTG01a1pSWGJwNXgrZGRtYnhRY3hGWWNVNU5GUUx4OG5J?=
 =?utf-8?B?cHUrdFlwYmtZTk5JSFdNZXU0NVkwVFYvOWtqNE83V2p6NG8xeG56d2Z1TElw?=
 =?utf-8?B?bURUby9SZGh3eVlzeEF4STVuT0ZmRmk1Z1JiUFBBUHRaQUJWUmtTM21sZFBw?=
 =?utf-8?B?NVJoNmFhbklQRE01T3RhRWkzV01VQnE2eFp6eGZ0ZG44d3dqM09LUTMrcitF?=
 =?utf-8?B?c09mVlc2Z0J3TkpKZEhPazh3aVRTK05wZFB3Z1Iza1cxMGRVMyttd1djd2Qw?=
 =?utf-8?B?NGM0OHMwK3EzeHFldGVjRjQrUjVRVGUxWUZDWEZTaVdYR3p3S2Q3T2NXM09z?=
 =?utf-8?B?bnVFcmpIUFFVTnpBZ3BXNlBmL0FOVE4vMEhONWFNVFVYamV2U21kQnpnZVNC?=
 =?utf-8?B?WVdqcUN1a1pibzhvVE45RklwZk45aTFUdHZJSHhneUFmMjArdW91YXVlNEZO?=
 =?utf-8?B?Rkxya3k1N21UNFMwUmZFQW1DUmYzV2FabkQxSGVHNkNOVkdId2FiWTk2MS9a?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f135cf-ff50-4269-41d8-08dc48f4e22e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:46:18.4837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWYpR04npaOuKkzNg3EAOx+qn300XokYNrTemmwCt8MJv0O/U0FgUiwQ+TOQo1iYbuT19+3zXEUL0Ttt/p7QYIss+myOnflbksPQT4bND+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9700
Received-SPF: pass client-ip=2a01:111:f403:260f::701;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

On 3/19/24 20:02, Daniel P. Berrangé wrote:
> On Fri, Mar 15, 2024 at 02:29:45PM +0200, Andrey Drobyshev wrote:
>> Since commit 246d76eba ("qga: guest_suspend: decoupling pm-utils and sys
>> logic") pm-utils logic is running in a separate child from the sysfs
>> logic.  Now when suspending via sysfs we don't really need to do that in
>> a separate process as we only need to perform one write to /sys/power/state.
>>
>> Let's just use g_file_set_contents() to simplify things here.
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qga/commands-posix.c | 41 +++++------------------------------------
>>  1 file changed, 5 insertions(+), 36 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 610d225d30..e0ea377f65 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1928,52 +1928,21 @@ static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
>>  
>>  static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
>>  {
>> -    Error *local_err = NULL;
>> +    GError *local_gerr = NULL;
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
>> -    } else if (pid < 0) {
>> -        error_setg_errno(errp, errno, "failed to create child process");
>> -        return;
>> -    }
>> -
>> -    ga_wait_child(pid, &status, &local_err);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> +    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
>> +                             -1, &local_gerr)) {
>> +        error_setg(errp, "suspend: cannot write to '%s': %s",
>> +                   LINUX_SYS_STATE_FILE, local_gerr->message);
> 
> You need to declare with "g_autoptr(GError) local_gerr = NULL" to
> avoid a leak here.
> 

Of course, thanks for noticing.

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
> 
> With regards,
> Daniel


