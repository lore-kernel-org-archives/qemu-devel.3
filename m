Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01C9C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 13:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rner8-0007LU-JU; Fri, 22 Mar 2024 09:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rner7-0007LE-9H
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:22:45 -0400
Received: from mail-am7eur03on2102.outbound.protection.outlook.com
 ([40.107.105.102] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rner5-0001rV-7H
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmCHVrV83JptOULgj8X8M/gXetLDWfYCZGaY/sjnj9+GR1ZwvKmqnp/qmtZDfu9FCtSC0lAw2n1SgpLauGgx4fKdbci7jqKCWW+d+Z5TYllhOvpm9MziAND+FuGWScYOcjRJOI3v0307RDBUOx0Dn9p5I1diSwxJw8gLJOqBJ9Ol00XyjlzmiweWZqEeDLvabT9N8+9qAxZm4DdQ7qMRK4I8LO8jxbCFkhgQdGnpTD0/zYhwh2bftGX+DhxI7Jjc0g1SKgZQUlsGNJgOUtcSVzrO6qfj1JAu6G2VORiW5yiAOWlmp4eWhtqnBsStcA832Tw4U1CWjuxOkgM72BOx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw65GDz3icKT99IiRYpPsp0BjMz9efUBI0Z0iLrc3V0=;
 b=LZEWigiG73y3yhvg3Dn4d6y2M2GhAK0qAVnaNeLCho2JRkZupRdYUXuPT+0ZxFDTESCk1swLhuvG1JPqDR4vJf19ROm8U5YWsgxNUCRtmKGpD0Iu6bCdeJtz1yblEEHOO1MxUba9+tvsUmDZ+YxRXcmZe1D/sfSS9fE/1+6eM8+tfnh913pdFrEeJwOhgaqqxwhexKI7LpnpYmSlc5RiduHXLd0fYf6GkbQTK9s7suDywlqqVd7Hr1K4QrsnUFuoS4SQTddk/G1gmiSaKZquKn3mNHsLdSQLNNHLMdWwl4E9PxIcHhyhtjyDKqcwSkJ+QTjWW3/JBZoaKJjLy+A3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw65GDz3icKT99IiRYpPsp0BjMz9efUBI0Z0iLrc3V0=;
 b=Q2wzgO0zfrtQbpXFe3yK19T/pXIYmIIRLkz32HLRZhpB70eQZYMdB9cl5sm96mnNJPAn7CXx3voTvYZkFQEy92QsA0iLueeUjGOFfTCkZeNDSoaGN4kziObwNx1m96YF3kzYDqFvgZoXwBVb7jaN65EqjXB0Qs0VM22iaawU1e+rp92I/iENxaQds0IBZtBP1AdkyOrPlA4XHv42QhpQiakx4gH35iZsFulGzFnrmsvMXDvZbTe+8l6iwCWfrujUpoYS2/SvX5fdMSgoDhbJ6+bhS8lVmTS+zYXh7DO1hIwT8fl8FxI85MemNmW4/KUCB88Vb3SFKnsbBGv3bAsYCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB8128.eurprd08.prod.outlook.com
 (2603:10a6:10:381::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 13:17:36 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::787d:7732:63b:ff4d]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::787d:7732:63b:ff4d%6]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 13:17:36 +0000
Message-ID: <d3c9b601-8363-420b-8a3b-13dc50f0469f@virtuozzo.com>
Date: Fri, 22 Mar 2024 15:17:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-privileged' field
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
References: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
 <20240320161648.158226-2-andrey.drobyshev@virtuozzo.com>
 <Zf1f1yajMqqF6G6t@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <Zf1f1yajMqqF6G6t@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: a907de57-56cb-4019-ed29-08dc4a727103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /D8S9H7cvZ9cZpxSZTKZipyUlS+zgJnS4RMXL8S3F9wRVQTRWkWlAGFyxp8VqdpRAvwOpahkwyvKh3JZwLwFFdKSUKZ8dIwVGZJ/fpkdvFCppeb9VXgQ2jIxGukG5Wl8YbGm4VkHg9b4/XKabCUWKMBVx3UcCrbCXqoBs+4LnjnPwrIZlRzBISbHtPJlHRpcKIjpTMR8cKF60VTRjKLrwrtCmZuD89u9ftMfICRdkspq7qrDgGSN4vGDr/y9Zdxhk6AOfAGDABzkaLwMcpt4eaGrBepYwYtjCq45/+d3YyT0Nwr0u33fdX9Le0B4MIA+nDUG3nbljrjg3RyuxGKlwec4JntClKqoApeIoUR+n79e5uodjt+C/swa45dOYZCH6ydEjC3WWY1G+EbSnwncS9hHK9cIUpzfvO9lpfeAq4rO+zWfpI479qJC3VSc3o5HbLO2njKfipzerrsZwswM9Z4B6Y98i8N0l2s4CrEBkA0H9akiCRh/gotUamLHbYdJ1Zi285Ln2Ctb/l10Qg+aF4hCljV5XmrUbBN1HSWBDJjwEnYOmbxrx3GieBMWAL6wznq9HADXzDed7/fYehNV2TAKFmHP4Ycbem3cNvYueHrQB73lkwxSwcnKJutvFHXlQKtAtKQm4AJOelL7gI7yP2g25tJsBBe2JbzagmQ5BLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzE2SURzSjVvaVIraENuSFRldFFKcHNQTEFEbnNtZTlNYWUxeWtLdWE3ajBo?=
 =?utf-8?B?KytnWXhjTzdXWXUrZ1JGcitQdlFWZ0Z1S3FULzEzWXhucmlOMUNOcDd2VnpN?=
 =?utf-8?B?OXZZWXd5VnV6QnRLT0ZPSmE2SEw5QVVucjRmUTVYNGU2cndNTVhYUVBaZXRC?=
 =?utf-8?B?Nmw1NitDYzdjOWI4K0JicW5BUjdPL0hlNTlRb1c3QTZIL01mMDAvenlHQkdy?=
 =?utf-8?B?ME92c3hnYzdHdzNxdkFuZ2d1b09XcDE5M0VZZnhSVkF1S00zY1JaYlI5dW5F?=
 =?utf-8?B?OFNCZUwrc3h6bExyYml0NGpjRi9zNnIwc0gwaWEzV0Z5NDEyQWFpZ2RpazFM?=
 =?utf-8?B?YW5XMUU3a25wTG5oVVYzSXhvRVJON0M3eXlyNGRacWdhSmVFcmVXd1lTaDFi?=
 =?utf-8?B?ZnBlT3puRVpmVUlITnYvaEgzY21QYm5yMlJXL2tFYjBXTHZXbDVqbGVSVDVq?=
 =?utf-8?B?cW4zOVBmVkozeDcrQm5ReFhXQm0yQVF0em9HdlZRWW9IQ0t3M0NWS0xIdEJ2?=
 =?utf-8?B?ajdYcmpBU2h5YVBob3FTUVRDcVlpNWlDTmhoTkZ4RldUOFRzeDkzdVljNDZ0?=
 =?utf-8?B?SGN0OGVQak1hRTRuUGZNWEtPeHpsMG10RGNBYTR0ZWN0QVBTdW5zWG5YT251?=
 =?utf-8?B?M3ZSYTRIRjRzb1NWVHZ6UXEzNkxLTlVPVGdiaWhQNm4ySDBIU29SMHBZcXd3?=
 =?utf-8?B?QkRwUGphVVV1MGFTTTRSZEFwR2ZBK1U3UDQ1Z2psc1RmdlYrdlRocm9MNVVZ?=
 =?utf-8?B?VEI2bzY3OUpaSEx0UlAzdWJRSVZ6TFZqVEp5bGMyNTJkWHdQYWN5Yy9IZnV3?=
 =?utf-8?B?TVA2cnovdEdOZ3FQeHhzeTE4ZERwYUYrY0pRWEdvYURVZlFjTUpLVUR0cGw4?=
 =?utf-8?B?UEhUQmhqWERmV3l6dFZ2dE5rb3EzVm9JMG5xOTk1QnlteW1vZVpQSnY5eHVZ?=
 =?utf-8?B?amVqRzFpZUNlaGpWQm9uTGZxVU1MV0ZmbmlONU5PeS95SzNCYkU5d1JaRlJC?=
 =?utf-8?B?N09nRlZxVU4xdzZNNmlDa2ZqU0FqQ3hCeURRVVowNlFlcUZWbURTb1ExeFUz?=
 =?utf-8?B?UDd4aDlkZ2pWSTNJcnRPL1lmdDdsanNyM0J3MXRhWXJqVFM1UUJQQlJOUW5Z?=
 =?utf-8?B?WFpNNnA4a2pxUW9xVU1YenFvREtMb09NS2dyZlMzVmhHK2JQRWFiYmc5dVU1?=
 =?utf-8?B?dnFVMFI4ZzdlTDZzWlp6b0thUGJUM0tYZjJCVW1zS1hHMzBiQWUzTXVBMlEw?=
 =?utf-8?B?ODd2VmZWK0MzemZrL3JYVlRzQkxaYXZSd1FDbzFGS3pUWG1Ga1F6WEl0dnhw?=
 =?utf-8?B?MVh0dWxCZmFaY2hEN1dhdVFRdllza0VYdWF0cGVOejhhNHFUNlpjUVBtZDJ4?=
 =?utf-8?B?cDd6WTd4RThxVWtkalpreGpDMG9CbjdKUHhRM2hiMGhHWWRrd0o3L3BoMXdQ?=
 =?utf-8?B?clFMdUFNVFlsUkk0RG00eXZEWUM2NFI3YnVuZWZITkMzQm1tcWJIVElYTHlL?=
 =?utf-8?B?NGYvMFBqcFYwUVBNWnRabmFmZ2VRNDE4Y25mWUEybGVXQnpub01CVUN3SVd0?=
 =?utf-8?B?VExNZG1Fb0VDUXpkWnBjV2tCWTJsWFJiMDJ3UzJzNVIrQ3JQN2dSVUZDa01j?=
 =?utf-8?B?bEtBb2Y1c1hqQlJRM1ZtbnQ3Q3pRemdzdThVTzFNQVhQRWV3eHc4ckttZFlz?=
 =?utf-8?B?YkN4MGxwc0FTOEtNdCtaejVkMkZiOTRyMWtwVGMxK1hFYXp4VmQwZUFQdzFw?=
 =?utf-8?B?MnV1YVdMRnpBc2JDZ1JadUtjdlZiZTd2b0hiU1JCRTgvTm9iVHlYT0grNGZk?=
 =?utf-8?B?Ky9qWkZNbnc5K0hCK0FjSE5BdHFqSHVtZkNWdVZKaER1bzJ4Lzc4SVlYQm82?=
 =?utf-8?B?SGNvWFd3WndRWEtXU2hWb0tTS0dTakVpSmd5YWM0ZFhLZ2Fvcll4N05QbUZ3?=
 =?utf-8?B?NEpHWUlla1Z2cUQweGc4aTBGRnh6N3ZTWUZmaHVWTmUzdkNGMERiYWhrQk96?=
 =?utf-8?B?eGo4amVLUzA4SlpWYW1naC9FZU56TGFTVWlLSHN3T212eFltTHM4L3c4RnVh?=
 =?utf-8?B?ZUh0bVk2WFhhNnh4K0pDOVcrNWMyMGlPaEZETFBrZitERExReFZ6Z0ZRTVZn?=
 =?utf-8?B?UjZPNXJ5VmdkNU5Gdy9ubVNFSlFPUnFuL3NzYjQ0dVh0enBuN1E4bnJDRmV1?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a907de57-56cb-4019-ed29-08dc4a727103
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 13:17:36.3980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJn0rlIujs9oe1Ig5uuSr+u1GjJM5U82mWKeq/0PghYcBWZ9cQLDNrYxEb5U0fOiW6/daNhjadqAkl8WIiHuVyAos+tUycRN8/73yCzrqys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8128
Received-SPF: pass client-ip=40.107.105.102;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 3/22/24 12:39, Daniel P. Berrangé wrote:
> On Wed, Mar 20, 2024 at 06:16:42PM +0200, Andrey Drobyshev wrote:
>> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
>> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
>> used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
>> returned by statvfs(3).  While on Windows guests that's all we can get
>> with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
>> total file system size, as it's visible for root user.  Let's add an
>> optional field 'total-bytes-privileged' to GuestFilesystemInfo struct,
>> which'd only be reported on POSIX and represent f_blocks value as returned
>> by statvfs(3).
>>
>> While here, also tweak the docs to reflect better where those values
>> come from.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qga/commands-posix.c | 2 ++
>>  qga/commands-win32.c | 1 +
>>  qga/qapi-schema.json | 7 +++++--
>>  3 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 26008db497..7df2d72e9f 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>>          nonroot_total = used + buf.f_bavail;
>>          fs->used_bytes = used * fr_size;
>>          fs->total_bytes = nonroot_total * fr_size;
>> +        fs->total_bytes_privileged = buf.f_blocks * fr_size;
>>  
>>          fs->has_total_bytes = true;
>> +        fs->has_total_bytes_privileged = true;
>>          fs->has_used_bytes = true;
>>      }
>>  
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index 6242737b00..6fee0e1e6f 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
>>      fs = g_malloc(sizeof(*fs));
>>      fs->name = g_strdup(guid);
>>      fs->has_total_bytes = false;
>> +    fs->has_total_bytes_privileged = false;
>>      fs->has_used_bytes = false;
>>      if (len == 0) {
>>          fs->mountpoint = g_strdup("System Reserved");
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index 9554b566a7..dcc469b268 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -1026,7 +1026,10 @@
>>  #
>>  # @used-bytes: file system used bytes (since 3.0)
>>  #
>> -# @total-bytes: non-root file system total bytes (since 3.0)
>> +# @total-bytes: filesystem capacity in bytes for unprivileged users (since 3.0)
>> +#
>> +# @total-bytes-privileged: filesystem capacity in bytes for privileged users
>> +#     (since 9.0)
> 
> Will need to be '9.1', not '9.0', since we don't accept new features
> during freeze periods.
> 
>>  #
>>  # @disk: an array of disk hardware information that the volume lies
>>  #     on, which may be empty if the disk type is not supported
>> @@ -1036,7 +1039,7 @@
>>  { 'struct': 'GuestFilesystemInfo',
>>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
>> -           'disk': ['GuestDiskAddress']} }
>> +           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']} }
>>  
>>  ##
>>  # @guest-get-fsinfo:
> 
> Assuming the version is changed:
> 
>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> With regards,
> Daniel

Thanks, Daniel.

@kkostiuk do I need to send one more iteration with the version change?
Whatever is most convenient for you.

Andrey

