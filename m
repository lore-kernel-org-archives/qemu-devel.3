Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D3DC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkopZ-0006CL-PS; Thu, 14 Mar 2024 13:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rkopX-0006Bf-2M; Thu, 14 Mar 2024 13:25:23 -0400
Received: from mail-dbaeur03on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260d::701]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rkopU-0007wd-HE; Thu, 14 Mar 2024 13:25:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpadFaCB1vEloKxfFRztWWJLNsE8NQ/QHNbibb04XVlT8e5gRcS2456ojbj2zGowyWOY83dRq1ot0vyHD7gAPcXekKtAniMxjoMIhbVMFEZ5m0BfGiypxHXkWtBossHE6cv3En3W2fDQdoMkvzumAPBOcYUw4RgTVX2jPDgnd5E/dVqt/zWSC475us5If7H2cn7a7abfRYhC6gno+9sFxr8+/wSVsb3urtN0MsuZKPE0muVFfEoV3ZebixjmbMa3weqwH4HlFuvyc+pJI9fO8jthwrGfalQWEkI1FQq3fpL0oB3Ki41ge3sZSdqTQJ7frepWpLk9VE7ezUcx70BFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHuZHPq+RlasZGALbeQ8iGT+Mh0fJ2xr+qIPICAsv64=;
 b=lWqoM32+AILGKwnuKWWS1vPH4RPKeLb39bFtiD8RCO9dXFfnvkUA9gIv+Ypcyc2eB97k8aOfmz7L+k/Yw3UOCiZ+EjOABTixBvksbkLrMewYCYqRIUIX2RzESMUcHVAPO+lpcDvvNT5cSou4I3lvc9QfP30+zSC3GBZqosiCPoWlOkIV3VBjxRvxmhYxRwqk8Ym9zcMUUsjoL8tfn3RA5HR0KeXsvbAFXgisQfAfbgFrVGKwtCS1nqRgg3/It/vfRMLD99zoPxSrsYstzTrqr3ykjf0MVis6gfiHysWkWTlwt8HMItggGxIHJ9xXP1iqD1ABzdEqZ8AXgum8HMZ9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHuZHPq+RlasZGALbeQ8iGT+Mh0fJ2xr+qIPICAsv64=;
 b=hGFRDH5+EkfllquzYZvHmcvwhGyPg2ZG4Do3NOmeOdr8jWxRLbPfwR8nerFKOUsUWSDcAaCSsIgt/YLPU+oDkxMmw35Juyk/KrF8LihDTNIFtXfSnjI8vpNXwxliHGrSyeAodX+OYzRDB3HA1b0+bS3UenWRoWHYlC/nta6zPhi1ZFR4gxNoSeIifU/PKXI/lbMx9TEAsVkKHKyxO1Le+jWQL02Cv7mcYQ0BLWeTEXwHY4MPrdWa5ju92CDiOia5FseiK5K7Ly2peF+geYUbwA5R8fagSsR+7QNkaksvKOgaBkiZcJ0EHneySROfFKAaIsdNNiN22koKbb258YQCag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GV2PR08MB8390.eurprd08.prod.outlook.com
 (2603:10a6:150:bc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 17:25:13 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 17:25:12 +0000
Message-ID: <46f8e6c4-3a93-43cd-8652-bf574ea26a1a@virtuozzo.com>
Date: Thu, 14 Mar 2024 18:25:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Use LVM tools for LV block device truncation
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20240313104327.147450-1-alexander.ivanov@virtuozzo.com>
 <ZfLxLKlHKqFvbcKO@redhat.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <ZfLxLKlHKqFvbcKO@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GV2PR08MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 61611f59-d880-4257-f53e-08dc444bb4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mplNMYn0MYmLuE18zQBUTdL6iueI9g7hgk1LvkWGQ6AdanyoDZnJMr/iI9Ox3SzJsFItrU9dzS4vrShf9z3k2uLke5itgw14EEN2dyttJdLgBlP21EpRkreB6Wn4JQBawHeML/xEavU6ioivWu6uzaEjcYaE2KQcVb3Str74DV/Zlad8b4JS0kIh9dCk0jCae5KAjJA5+fRMOl6rGXD0WY//ZBotIOVZs0Np3HxutpIpmwFek1rCAWvS01HeeDX+mZQS3aI3Yxvlqz62qVhoT7Tg13jaOp7KjK4yS/yfwArB3Gu17mSpiRM7Tk1o2KUTTa2CfPG6QTbpDq+tLzLJ6TD+sGJgL0CMbQeyo3nIw4Ky9jAAfc5rXwu6JW52+ABp55TPlQvTz5t+YYQLvN3RlC2W+jC/wayzpGst6U1B9k+nvCpbYSnfRAspopJhToaa+v5mVGg/4l/VL9c0WNTLDd7wKrOe5Vt8slWpA/QyQk36h+QjgyEcIpLra79xuwT0GTc3HapYpevPZtKDX42enWcVaEKnM1w0Fo9ZM32dx8HtpQG7PB42k41t/fPujN5kGpFYkBsIHe2PCr18nC73hLnZnHWJwlqmQDsKQ6YIFjmOatX6VKeRwVaB0qQ1udwGJxncNs2Y9cAIzrr1Hhm06fYH8OAs60HBrXSyQ8pD7LI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHg1MXg5VzdtNmk3ZS9EdDZUbjFqYUx6VUx0Y0UrajA4SCtkY1F5WVdjNWFY?=
 =?utf-8?B?cFdYRHFITW4xeXZUZS93RXlwMEpSRk1uTDh1VWh3SEVyMVc0Zkllc3IwODBY?=
 =?utf-8?B?b21wTTdMWTd3ZjhVajdMZ0ZuZnJzR0FEclBqM2YyRU1sUndaMWFZTFNOdzVa?=
 =?utf-8?B?SDBZNE5TU1VicEZVY0d4UktrREZMY0lWRjYyWmFpTGM0RG1LaG9XdXBFbnFY?=
 =?utf-8?B?dWdRNTB2N1AxR0gxeDlQUTIzdC9mNjFUMHZnbTlPcTRpWjloeU9qM1FnZER1?=
 =?utf-8?B?dmFnVWJXUmdVeFBhVUhYQ3RNZFNjYWpnKysvUVpqamFkVnVsMnR6cFFsK3Aw?=
 =?utf-8?B?MlhhRHNFVXdDSXRMWlNRelRtM21jVzVYK0hydlZiUWFHc1dCaW1kMGFUaDlV?=
 =?utf-8?B?TTB3QjN5djd2bkVrN3ZGdGVWMDFtdG5MUi90ZXd0cjZaM2FodWhiWVkvenBy?=
 =?utf-8?B?UFlRL1M4ZnJhYlVDc1pTVVNYaEJXLzJaL0hhVFdISEQ4NFRQODlYeE9nRTdT?=
 =?utf-8?B?bXBCZ0ZVQ3Nwclh5ZVVDMk9DdnQvMHR1TEZVbThWTXBXZW03bkV2ZXRhOFNY?=
 =?utf-8?B?aU9GVE11aG82UUg5QWNpWWJ2T2pOTGR6dGpPdlorZkJncUZvV29ZMThuekZx?=
 =?utf-8?B?dysvQlJTbXdVZ0tZTVZVUTRadDJWQWJvWC9FdDJjV3czV05QWmJRSThDbzAx?=
 =?utf-8?B?cFljSC9wL2ZFdDJra21kb2Uwcks5REFDdDhxVVlPK2hpdGw3UUU2bzc4eDFK?=
 =?utf-8?B?aXkrTHNVKzVHN29pZjNraTRuU00zM3FNMVZOakRzVTRIY3lDWUdhekE1VzRP?=
 =?utf-8?B?ZkgwUXZQZVF0aUp4MGY3S3B2QTJKQnhxem51YmJhSkhwcWJLS1krZkpyTGp0?=
 =?utf-8?B?SzlZcFlZNEllMzBDYWtwSUlnbktSb0Q4TjJKV1hIcHNPUTROZGlHK1BmZmxS?=
 =?utf-8?B?cXBkYmFLMjROdGl6ZHZLdElJWlZSeFNqL2VjcjQ2MEFwYXhveXBJMmdBMWZR?=
 =?utf-8?B?aURkRlIxVS84aUs0OUZiOG9qYjJvejc5ZEZpNFgzZUJtMGcwNTVBQmY3cTZj?=
 =?utf-8?B?SDdSWVlJM2toSDNWa29kN2ZUa1lIbGdXRGVUa0NQV01jUXlTMDFjcHhBbXJI?=
 =?utf-8?B?VmhMU3NXRkZYWUlvNzl2T3ZpSURRWDFIV0xRd1lMVEllSDlmdWZ4MFRKd1lj?=
 =?utf-8?B?c1Rnamx6WlVkeTEwUm50QmR1NUw1VVR4bEF4SXpDRjdYMnJ5YW1WdUZadkhk?=
 =?utf-8?B?TGFEd1BXQzdqYnY4UUlBVDRqUHUxditZSGpPWHhsZDQ2dnoyV3RFSFFDOHVp?=
 =?utf-8?B?OWt6Z3JKNkZydlhlUFFvcnhBbll6M2djZEpGd2N0Q3JhMlU5L04yU21COUtU?=
 =?utf-8?B?Z1FON3Y2RDdYUHJ1WUtCeE16dTBYL3Y1K1VEWmJFb0JGaUtJeXRtM242LzZ4?=
 =?utf-8?B?N3VwMGZSbk5QczlxUGZITFFTRHhNelByUGVJSHVMYlUxelNMeEtJME9uOXdk?=
 =?utf-8?B?bWR2OFZEVklmVi9jODRmRndzcUkyUTJYSmhlN3Y5eUhEVFQrOGZRRFUzbEJQ?=
 =?utf-8?B?c1JPQ3JQWGpGaWtDUzZvNkhxSGt5OFJ5WjlXT2puWTJFNUEyM0QzdXNRbzdl?=
 =?utf-8?B?dE5uVytpakwySTVsMjBWR3doZ05Qb3VraklFekN3WitKZXBMUzZESEJOOWZn?=
 =?utf-8?B?aURZWGtpeFdIUlAvc2puQVdWcUtZOExNUXYzU0J4dExQZWt1d0lOSS81Umo4?=
 =?utf-8?B?SHgxVUxFeWhTVk4vSlBHYWFxQzhGSmdKRmI0cDhuQVJpRUpNcDV6d3h3NE9H?=
 =?utf-8?B?ZGhKTmRkOVlOWmdxc2JhN1ZqckhuS1BGZ0trQ2dqUzMwYVN0R3BOczB5OGd1?=
 =?utf-8?B?bXpjRVJZNTBnZGZNQVE0WG1JU0piMlZadHJIcDUyTy9mVmxYVEN0ZDB4SHVa?=
 =?utf-8?B?Y3FvMEpYM3BOOXBZbk5SRmZaYU9uWmdoWWtiWXJiQkxVamkwMmMvcDVkdFd5?=
 =?utf-8?B?dVlYcWhwM3RQR3Q4aEJVcUQwT0Jrall1WmNsWlFBMi95ZUhIa0V5RmM3STdU?=
 =?utf-8?B?MktZV0hxNVZodmFGeXRrVFpCb1hiemMxMnRkcGRlcHZucTc2dlppVksrZ2Nv?=
 =?utf-8?B?S0NUNUdwS0hBS2cza0FNN1lqNE54Rm1OQVE0Z3Y1d01taFpDUlEyKzBkeU4v?=
 =?utf-8?Q?NUQibQi8JzZkznxrpPRIDl4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61611f59-d880-4257-f53e-08dc444bb4ce
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 17:25:12.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4sWwRNPYRcHcquQTzcST6Lt2ISW2DTaVN7U8fa1E7JgBlO3N0K1T0VEuZW03MHhcZf5UhLk6Bj4huBAnYNNRyFfEIB613eKryf2YR1gR0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8390
Received-SPF: pass client-ip=2a01:111:f403:260d::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
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



On 3/14/24 13:44, Daniel P. Berrangé wrote:
> On Wed, Mar 13, 2024 at 11:43:27AM +0100, Alexander Ivanov wrote:
>> If a block device is an LVM logical volume we can resize it using
>> standard LVM tools.
>>
>> Add a helper to detect if a device is a DM device. In raw_co_truncate()
>> check if the block device is DM and resize it executing lvresize.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 35684f7e21..5f07d98aa5 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2642,6 +2642,38 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
>>       return raw_thread_pool_submit(handle_aiocb_truncate, &acb);
>>   }
>>   static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>>                                           bool exact, PreallocMode prealloc,
>>                                           BdrvRequestFlags flags, Error **errp)
>> @@ -2670,6 +2702,35 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>>       if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
>>           int64_t cur_length = raw_getlength(bs);
>>   
>> +        /*
>> +         * Try to resize an LVM device using LVM tools.
>> +         */
>> +        if (device_is_dm(&st) && offset > 0) {
>> +            int spawn_flags = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL;
>> +            int status;
>> +            bool success;
>> +            char *err;
>> +            GError *gerr = NULL;
>> +            g_autofree char *size_str = g_strdup_printf("%ldB", offset);
> offset is 64-bit, but '%ld' is not guaranteed to be 64-bit. I expect
> this will break on 32-bit platforms. Try PRId64 instead.
>
>> +            const char *cmd[] = {"lvresize", "-f", "-L",
>> +                                 size_str, bs->filename, NULL};
>> +
>> +            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
>> +                                   NULL, NULL, NULL, &err, &status, &gerr);
>> +
>> +            if (success && WEXITSTATUS(status) == 0) {
>> +                return 0;
>> +            }
> We should probably check  'g_spawn_check_wait_status' rather than
> WEXITSTATUS, as this then gives us further eror message details
> that....
Thank you.
I think it would be better to use 'g_spawn_check_exit_status' because 
there is no
'g_spawn_check_wait_status' in glib before 2.70 and even in 2.78 it 
leads to
'g_spawn_check_wait_status is deprecated: Not available before 2.70' error.
>
>> +
>> +            if (!success) {
>> +                error_setg(errp, "lvresize execution error: %s", gerr->message);
>> +            } else {
>> +                error_setg(errp, "%s", err);
> ...we would also include here, such as the exit code or terminal
> signal.
>
>> +            }
>> +
>> +            return -EINVAL;
>> +        }
>> +
>>           if (offset != cur_length && exact) {
>>               error_setg(errp, "Cannot resize device files");
>>               return -ENOTSUP;
>> -- 
>> 2.40.1
>>
>>
> With regards,
> Daniel

-- 
Best regards,
Alexander Ivanov


