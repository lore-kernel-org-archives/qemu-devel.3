Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25954C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Yn-000064-8L; Tue, 12 Mar 2024 13:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rk5YW-0008RJ-AQ; Tue, 12 Mar 2024 13:04:55 -0400
Received: from mail-vi1eur04on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2611::701]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rk5YS-0000TR-VY; Tue, 12 Mar 2024 13:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3ykcvkGZ762CQdKHXxSH6eqoWRNDP2GwXojQFokVt/xcUzfoz9emlRp+ydCtiqnuQYVy2QXAOTTSAdIuWRFPpPPL6iPHMokn6X1A6KvyHl4Jhop/7zwgK+I8J3QG+u/omWZ+VMdzUGXJFe8/yS4tQkQw32tSqvZ+56Ws9o4Hf9GqgRQKp9hZoOfQ7bB/Bxw8sZJQkolGQyR7QH5BopEYvDFspqVKlSNwwGydM8z8dj9eNbkV+LeOnpjsqL3kwppQ0qX4dJZSJow+uBl0sUp51627FIBCWIqAF23urPLJvVhrYTxY233H0A7KNcQ7OytOeGmbFBByDjPF7vk1jWCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+ujKGUzzhatQwN4/rTpbhOhjtHbfNc/u+UP3NPK+Qg=;
 b=G96kHrqR0HR6eBXkNeE/yrGsi2Sz2Z/UvJ6DtfNGoWEfZdoIRwSNz0prf2iaUt+Afj1dQP0bFd8flFbZL9GT6OIn1866brp5br26quILkrzYBUAIsruDVJuCWRDIftrHQajkwjGprYjQ2enel+xa5Rk45IQGYDqdRubUY8Hbj4pHT9d4+YQg+XGoCGVxSkQkAG5k4s5dk6DbI4/I+Vt+CoR+2DQEbLzpjYIGrih+OGR9uZIy8dXW1E50j3AEqbq+7L3Xs2LaPlVFFsx3k67ytK9lBqjMLSbrxovIbBBK1W05LAviUoA/B1joyEyjimCAPLyPaxhaL2bO5JKKF5tymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+ujKGUzzhatQwN4/rTpbhOhjtHbfNc/u+UP3NPK+Qg=;
 b=yazJzmN2XyRslNyKkrENQOcQpZK0EE8cf9h0ocimdVEKjD6KbjvanJdWWVfPidIJXzI9jJkn7mrma64MdRAUBhNLy2NRYJGTVl/YOuuh6nu/Sa+F0a1BvQM3ogCd/KgsgkUqEbVA3wTKm+d4rm7yZnBr25Vl+lzdfxSm7IsGLelnIHSo8x8oN7kXHpfMAnluxZjOh/7LwK4ye/JFkYcRGAxkWNsO3K5AcoLe7IcqmgQOdoP+2vTbiQ5n//0aE6FvO4gG7XtdOIeMCjGyHtBRincKlW3yVnAiMOLtA+W1dpytSewc6fqQgcKPEtu31rFQxZ1iuJF98fsSMviFjZhvYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AM9PR08MB6690.eurprd08.prod.outlook.com
 (2603:10a6:20b:301::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 17:04:37 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 17:04:36 +0000
Message-ID: <874c2375-1216-4002-a490-8538fe92921d@virtuozzo.com>
Date: Tue, 12 Mar 2024 18:04:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Use LVM tools for LV block device truncation
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20240311174044.67094-1-alexander.ivanov@virtuozzo.com>
 <Ze9Mb6pHcTOdghCy@redhat.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <Ze9Mb6pHcTOdghCy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AM9PR08MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 08864e72-b6fc-4600-3d71-08dc42b67f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZV0nC6zge/qoeCNYDNRyDhsOMxsEclY/nVTlY1yGmS0rKJc4MIaC5Cxh6V+BczYUfDVwM7swk7+BtxxjD6rvG7FzT0Y4diQVgMHc7HgXwnxx4MC5gcGGBzz3W5GIFloAPUuC/hbmz7vObTiWUsuoS3B2dUIK8HLP4le4SqW6V3hxvULUkXuxOUFepKfLXuruNbalqzJ+sZaTQV9ocTZAHSlSa/O51Ml2Tzw62bK0+zt1cGjp+FCCGi0D1HaLpc52Zp+fdT42/1HN9lzjm7iF1wYPUyKjpe0RyG4zb7qObND8uMBaI1/fsFp9olKeTnuLBTqnlZVdJQo4wlvHsJT3r+LyTDCvBGuQH7cr+xEfLH645PMxIiUcC6Mr9d+vBt8gXPTEL6ss4vkWlUeM1rBa1J26EY0vx4qoVLkUahWzdQdY/PkntTPBw/XgcX8TpYc9xryKkDXmg5875gMDb0o7f8JbKxtOfMcG9/IKcIbsqWF8LLPbxYJOl+ArjB3qYiVRhnL9pG3FYAVBoVLybR+SAkXaoKVCPNBEvqnYKFEuWDYCxYazy93jrhmw/oo1NoQTVfamYqj5L+0NVD5TbneELIE5WDTk7EU5vHmz/poZWVl95MynK85VvFG4ZuiTbezCVwYJFiSoASQTq4GtIRrWCksJBwRU/JB7cMEgHa7I1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L21qYXY5RkViekl2Rm5lSk15SSsxZTRHaG5zR2QreU5WYzJ4TEFZV1ZxTWRN?=
 =?utf-8?B?eWs3bzArbTEvOUtQUzJlQnJ5U2E5cUJmRUpQRW9TWURPWWVJQzhpT3d4RnZQ?=
 =?utf-8?B?SitkZHdId090M0VubmpzV1p3MXNNemZmRmNZUnBjZXFGeG1ONVpoUmloWmRJ?=
 =?utf-8?B?OTJPNlhMOVBiUW5ITy9XeTZzc1BjeW5mekVWd2pjY1lJK1dzN2ZzaGxyOEhG?=
 =?utf-8?B?YVkwUG5EckhXazNtMi9wSE1wTk9Xb3BiNHF0V0dwOC9SMDR4TzdkWDI2TGdy?=
 =?utf-8?B?TmFhZytQajBCWkczVytFNWZQdHllR0JlejBPVERiY253QmtxTHBKdHdoTFBs?=
 =?utf-8?B?cExuQUJIckI2TmxYNjFaZDkrSE1ISG9wYmRMWDk3N1JvMkN1OEJEaTZDTXBy?=
 =?utf-8?B?UnA5NFhESnlPZUs4d3BJbVA2WkoyaXBSRktxVVJpWHR3eEZHcDV0UGRnZktR?=
 =?utf-8?B?a2Y5QTRXdUFQc2Q2QlF2OGxTZElnU3hkcDVaYmJ3K2ZaSjJDK21IR0NrK3I5?=
 =?utf-8?B?SkJ1U1ZXYXhTd1FTbXZRaUFFVWloNGI4UzBZTjFHZnpJVHNNQXh5NzBjTGh1?=
 =?utf-8?B?azFNejFpQnpBaXVOUG1ucU1kVEZQOEFEVkF6TmczWFpiS3dUV1NBNWkwNUNz?=
 =?utf-8?B?bXZOL25iK2VDaTAxc01SSWhQVFE0NmJNY3BRSE5QdnV6a0E0T3ZXTFl2M0Y1?=
 =?utf-8?B?bEFvZlY0L1ZORG54M2Z4Vk9nR2RLZm5mUnBPVlFCNlZLeXpmOFlQRUx2MzQr?=
 =?utf-8?B?UnJNb1JJQVl4MklpQiszbFpPTm1CenVMakh2TXF1NlpuZy8wNTErb2ZWRWV2?=
 =?utf-8?B?cHJobHdhdnB3bDJIT1VFSWJDYjFvYmxOeHVsaFZIR2dkbXVTSE1lUWEzZTA0?=
 =?utf-8?B?R283dVNVRnRJOGlUZXMzM3BVSDdPeWNHTEFnUXRyQkM0ZWtyRWxvYnJzSHkx?=
 =?utf-8?B?QW5jM2hEc1JJU2lneU16Y2h2K0NsaWI3T2ZndmZWUGhUd0ZsUUw2Yi8yKzls?=
 =?utf-8?B?Z1E1Umg3NmRPZC90QjN3MS81R1g0TVB6SUMzbjNNNm9JK0YzQ3NRVFFnNUlH?=
 =?utf-8?B?WkpoSDNzMXFIMTFpdzY5MHg1YU45Q0V6UTg0V25BS21YbUlnZm82OTJRWXh5?=
 =?utf-8?B?ZkFZY2VQY28rUHdLVS9lVitNOUt0OHUxU3JPeHIzRldjcXdGWjhWbGpyRG43?=
 =?utf-8?B?bHlYZ0dXYVZFWmVLTTQ4NUZtU1o4c1FRSWdMSmpESDB5U3RIUy8vakpkVEVG?=
 =?utf-8?B?MmVuMDRnRE1KbWRYV0t5WTZ2VS9iWVJYekxsengrODhhUXViNW1NQUJHT1Qx?=
 =?utf-8?B?MUIva3RQazBkZklKNWtEYmRneTNpWmdMNUp5UlA1dllvOHA1RFdEc0NxSTRL?=
 =?utf-8?B?V3loZGlpNEhCdHNmTzV6d2hlSmI3Nm1XdVh3bVhDeTZUOEViQi9WNnJLMjJk?=
 =?utf-8?B?RHN4UzhsTUFHei9yY0doaWJtaWJmVFVaeWpVUVBIaUdWUng3b1lnNVlQc2tT?=
 =?utf-8?B?RWduTEFYbjcva1h1aUkxUFh2STNaYUNIRm9jZG1MSGdNQnY0QXhOVmE3UU9h?=
 =?utf-8?B?NmZjNUd4Q3k4U0YxVU52VW9QL1NTYmxyZHh2eHBIZ1BlenM1TGhxUXhGMWU2?=
 =?utf-8?B?Y2hiWk10a2ZoOG1jQU5ETjQ1bVV1ZUNHUFF5aGFIdFFMeGVYaXlGNEVJdjRJ?=
 =?utf-8?B?cDJWcU5XUVBMVFowbUgvdEREQ1lBS3NUUVdwWXJRV0tnSFA3WmxZbzJTTi9N?=
 =?utf-8?B?YTBTeHNaNFpsZm9CQUhsMnJ0T09oT1ZCblZIbVFUTFV2cFV5c0tBRnczc1VM?=
 =?utf-8?B?RGlnd3dNSVAyWVNpZ2VvMi9SQk9CTHBJNDRiYjVkTWEyb0pYZW5Cc0c3YXV5?=
 =?utf-8?B?bnVFNjZXUjdoTTNGNlRJWWV5b0IrQVovdDg3ZzgwMENKclhuODFMMVp6VWp2?=
 =?utf-8?B?MUk4TlluRzdLRUdNM0dRTXI0d01QNHNMcGt0dW4rc1hOaXc5TjM3cldMMk9D?=
 =?utf-8?B?V3NnNlRlSlJmWDVMZm02TnVGdUNvK0ovMDVFdG1idUk5OGVmdVh5YUtQNjZH?=
 =?utf-8?B?cnNDK1FBeDQvczh5TXV4c0tnWTUxY2FPQ0pCS2sxdiszajlUOVpUVWJUVndo?=
 =?utf-8?B?bFJJWllZVnE4UGhFeCtIMkRVcE9yZEVNRnVzSWQrU0F6QThyZzJJZUVNU1pa?=
 =?utf-8?Q?0bHfMvWMFdaYoXMhuox9c1g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08864e72-b6fc-4600-3d71-08dc42b67f50
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 17:04:36.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiiyFYgXbs9eeC1l7QMmhzIFRyuzkdH2jz2xoCv3e6c72eLQhG09PLmgAYL28wjF5aE2ugpCl3mIdcudl9BJCHkquWMW1cuNvwdwm9/EC2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6690
Received-SPF: pass client-ip=2a01:111:f403:2611::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

Thank you for the review.

On 3/11/24 19:24, Daniel P. Berrangé wrote:
> On Mon, Mar 11, 2024 at 06:40:44PM +0100, Alexander Ivanov wrote:
>> If a block device is an LVM logical volume we can resize it using
>> standard LVM tools.
>>
>> In raw_co_truncate() check if the block device is a LV using lvdisplay
>> and resize it executing lvresize.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/file-posix.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 35684f7e21..cf8a04e6f7 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2670,6 +2670,33 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>>       if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
>>           int64_t cur_length = raw_getlength(bs);
>>   
>> +        /*
>> +         * Check if the device is an LVM logical volume and try to resize
>> +         * it using LVM tools.
>> +         */
>> +        if (S_ISBLK(st.st_mode) && offset > 0) {
>> +            char cmd[PATH_MAX + 32];
>> +
>> +            snprintf(cmd, sizeof(cmd), "lvdisplay %s > /dev/null",
>> +                     bs->filename);
> PATH_MAX + snprint is a bad practice - g_strdup_printf() is recommended
> for dynamic allocation, along with g_autofree for release.
>
>> +            ret = system(cmd);
> IMHO using 'system' for spawning processes is dubious in any non-trivial
> program.
>
> Historically at least it does not have well defined behaviour wrt signal
> handling in the child, before execve is called. ie potentially a signal
> handler registered by QEMU in the parent could run in the child having
> ill-effects.
>
> 'system' also executes via the shell which opens up many risks with
> unsanitized files path being substituted into the command line.
>> +            if (ret != 0) {
>> +                error_setg(errp, "lvdisplay returned %d error for '%s'",
>> +                           ret, bs->filename);
>> +                return ret;
>> +            }
> Calling 'lvdisplay' doesn't seem to be needed. Surely 'lvresize' is
> going to report errors if it isn't an LVM device.
The problem is that we don't know if 'lvresize' returned an error because of
non-LVM device or there was another reason. For the first variant we should
continue original code execution, for the second - return an error.
>
> If we want to detect an LVM device though, couldn't we lookup
> 'device-mapper'  in /proc/devices and then major the device major
> node number.
It will require more code for getting device major, file reading and 
parsing.
Why this way is better?
>
>> +
>> +            snprintf(cmd, sizeof(cmd), "lvresize -f -L %ldB %s > /dev/null",
>> +                     offset, bs->filename);
>> +            ret = system(cmd);
>> +            if (ret != 0) {
>> +                error_setg(errp, "lvresize returned %d error for '%s'",
>> +                           ret, bs->filename);
> lvresize might display an message on stderr on failure but that's at best
> going to QEMU's stderr. Any error needs to be captured and put into
> this error message that's fed back to the user / QMP client.
It seems I need to implement a high level function for programs 
execution. Looked at
g_spawn_sync(), but it uses fork() under the hood and we could have a 
performance
issue. Haven't found a high level function that uses vfork() and allows 
to catch stderr.

>
>> +            }
>> +
>> +            return ret;
>> +        }
>> +
> With regards,
> Daniel

-- 
Best regards,
Alexander Ivanov


